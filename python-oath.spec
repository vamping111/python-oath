%{!?python_sitelib: %global python_sitelib %(%{__python} -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())")}

Summary:          Python implementation of HOTP, TOTP and OCRA
Name:             python-oath
Version:          1.4.1
Release:          CROC1%{?dist}
License:          BSD 3-clause
Group:            Development/Libraries

Provides:         %name = %version-%release
BuildRequires:    make, python, python-setuptools, python-devel

URL:              https://github.com/bdauvergne/python-oath
BuildArch:        noarch

Vendor:           Benjamin Dauvergne <bdauvergne@entrouvert.com>
Packager:         Vadim Radovel <vadim@radovel.ru>

Source0:          %name-%version.tar.gz

%description
Python implementation of the three main OATH specifications: HOTP, TOTP and OCRA


%prep
%setup -n %name-%version -q


%build
%{__python} setup.py build


%install
%{__python} setup.py install -O1 --skip-build --root $RPM_BUILD_ROOT

find $RPM_BUILD_ROOT/ -name '*.egg-info' -exec rm -rf -- '{}' '+'


%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%doc README.rst
%{python_sitelib}/*
