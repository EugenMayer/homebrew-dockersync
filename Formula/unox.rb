class Unox < Formula
  # see http://docs.brew.sh/Python-for-Formula-Authors.html
  desc 'A layer for unison-fsmonitor arround either macfsevents or watchdog for usage with unison'
  homepage 'https://github.com/hnsl/unox'
  url 'https://github.com/hnsl/unox/archive/0.2.0.tar.gz'
  head 'https://github.com/hnsl/unox.git', :using => :git, :revision => '0.2.0'
  sha256 '163668398356619d0b422f7e067836754d6eae6bf63058bac3f4c7c70182e837'
  revision 2
  depends_on "python@3.9"

  resource 'watchdog' do
    url 'https://pypi.python.org/packages/54/7d/c7c0ad1e32b9f132075967fc353a244eb2b375a3d2f5b0ce612fd96e107e/watchdog-0.8.3.tar.gz'
    sha256 '7e65882adb7746039b6f3876ee174952f8eaaa34491ba34333ddf1fe35de4162'
  end

  resource 'pathtools' do
    url 'https://pypi.python.org/packages/e7/7f/470d6fcdf23f9f3518f6b0b76be9df16dcc8630ad409947f8be2eb0ed13a/pathtools-0.1.2.tar.gz'
    sha256 '7c35c5421a39bb82e58018febd90e3b6e5db34c5443aaaf742b3f33d4655f1c0'
  end

  include Language::Python::Virtualenv

  def install
    virtualenv_install_with_resources(:using => "python@3.9")
  end

  test do
    ENV["PYTHONDONTWRITEBYTECODE"] = "1"

    Language::Python.each_python(build) do |python, _|
      system python, "-c", "import watchdog"
    end
  end
end
