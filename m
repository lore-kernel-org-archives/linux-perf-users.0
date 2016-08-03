From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: cross compiling perf
Date: Wed, 03 Aug 2016 22:56:20 +0200
Message-ID: <5791976.t4kYR0rFfJ@agathebauer>
References: <16135005.c00Xa53Rc9@milian-kdab2> <57674D39.1000104@huawei.com> <3763103.tiqVXQm4JX@milian-kdab2>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3453434.DCAfXbUh0M"; micalg="sha1"; protocol="application/pkcs7-signature"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:56372 "EHLO mail.kdab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755000AbcHCVvA (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 3 Aug 2016 17:51:00 -0400
In-Reply-To: <3763103.tiqVXQm4JX@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: wangnan0@huawei.com
Cc: acme@kernel.org, jiri@infradead.org, hekuang@huawei.com, linux-perf-users@vger.kernel.org

--nextPart3453434.DCAfXbUh0M
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 27. Juni 2016 13:56:23 CEST Milian Wolff wrote:
> On Monday, June 20, 2016 9:56:09 AM CEST Wangnan (F) wrote:
> > On 2016/6/17 19:00, Arnaldo Carvalho de Melo wrote:
> > > Adding some folks to the CC list, that either worked on the make
> > > infrastructure or that I know works with cross compiling environments,
> > > maybe they can help.
> > > 
> > > More below.
> > > 
> > > Em Fri, Jun 17, 2016 at 11:49:28AM +0200, Milian Wolff escreveu:
> > >> On Donnerstag, 16. Juni 2016 13:11:11 CEST Arnaldo Carvalho de Melo
> 
> wrote:
> > >>> Em Wed, Jun 15, 2016 at 04:24:52PM +0200, Milian Wolff escreveu:
> > >>>> I'm trying to compile a more modern version of the user-space perf
> > >>>> tools
> > >>>> for an arm64 embedded target. So far, no cigar.
> > >>>> 
> > >>>> Neither tools/build/Documentation nor
> > >>>> tools/perf/Documentation/Build.txt
> > >>>> explain how this should be done. Right now, I'm trying the following
> > >>>> from
> > >>>> an SDK with an environment that already sets up CC, CFLAGS etc. pp.
> > >>>> 
> > >>>> [SDK] ~/milian/linux/tools/perf$ make ARCH=arm64
> > >>>> CROSS_COMPILE=/home/sdk/
> > >>>> sysroots/x86_64-oesdk-linux/usr/bin/aarch64-gnu-linux/aarch64-gnu-lin
> > >>>> ux
> > >>>> -
> > >>>> CFLAGS="--sysroot=/home/sdk/sysroots/aarch64-gnu-linux
> > >>>> -I/home/milian/target- prefix/include
> > >>>> -L/home/milian/target-prefix/lib
> > >>>> $CFLAGS"
> > >>>> 
> > >>>>    BUILD:   Doing 'make -j8' parallel build
> > >>>> 
> > >>>> Auto-detecting system features:
> > >>>> ...                         dwarf: [ OFF ]
> > >>>> ...            dwarf_getlocations: [ OFF ]
> > >>>> ...                         glibc: [ OFF ]
> > >>>> ...                          gtk2: [ OFF ]
> > >>>> ...                      libaudit: [ OFF ]
> > >>>> ...                        libbfd: [ OFF ]
> > >>>> ...                        libelf: [ OFF ]
> > >>>> ...                       libnuma: [ OFF ]
> > >>>> ...        numa_num_possible_cpus: [ OFF ]
> > >>>> ...                       libperl: [ OFF ]
> > >>>> ...                     libpython: [ OFF ]
> > >>>> ...                      libslang: [ OFF ]
> > >>>> ...                     libcrypto: [ OFF ]
> > >>>> ...                     libunwind: [ OFF ]
> > >>>> ...            libdw-dwarf-unwind: [ OFF ]
> > >>>> ...                          zlib: [ OFF ]
> > >>>> ...                          lzma: [ OFF ]
> > >>>> ...                     get_cpuid: [ OFF ]
> > >>>> ...                           bpf: [ OFF ]
> > >>>> 
> > >>>> config/Makefile:272: *** No gnu/libc-version.h found, please install
> > >>>> glibc-
> > >>>> dev[el].  Stop
> > 
> > I think this error message is missleading. Let's see source code:
> > 
> > ifdef NO_LIBELF
> > 
> >    ...
> > 
> > else
> > 
> >    ifeq ($(feature-libelf), 0)
> >    
> >      ifeq ($(feature-glibc), 1)
> >      
> >        LIBC_SUPPORT := 1
> >      
> >      endif
> >      ifeq ($(BIONIC),1)
> >      
> >        LIBC_SUPPORT := 1
> >      
> >      endif
> >      ifeq ($(LIBC_SUPPORT),1)
> >      
> >        ...
> >      
> >      else
> >      
> >        ifneq ($(filter s% -static%,$(LDFLAGS),),)
> >        
> >          msg := $(error No static glibc found, please install
> >          glibc-static);
> > 
> > else
> > 
> >          msg := $(error No gnu/libc-version.h found, please install
> > 
> > glibc-dev[el]);
> > 
> >        endif
> >      
> >      endif
> >    
> >    else
> >    
> >      ...
> >    
> >    endif # libelf support
> > 
> > endif # NO_LIBELF
> > 
> > So the 'libc-version.h' error message really means the failure of
> > feature-glibc detector.
> > There's many reasons cause libc detector fail. 'libc-version.h' in error
> > message provides
> > wrong clue, lead user to check this file instead of checking feature
> > check result.
> 
> OK, so if it's the wrong clue, can you tell me what else to look at then?
> 
> I'm seeing
> 
> $ echo $CC
> aarch64-gnu-linux-gcc
> --sysroot=/home/yocto/SDK/E013/sdk/sysroots/aarch64-gnu- linux
> $ echo $PWD
> path/to/linux/tools/build/feature
> $ $CC test-glib.c
> $ echo $?
> 0
> 
> The above looks good, but from a make run I get:
> 
> $ cat test-glibc.make.output
> test-glibc.c:1:20: fatal error: stdlib.h: No such file or directory
>  #include <stdlib.h>
>                     ^
> compilation terminated.
> 
> Can I somehow figure out how it tries to compile the test-glib.c file? I.e.
> can I invoke "make" in a verbose mode that outputs all commands?

I have finally found the time to dig into these issues and now found a way to 
cross compile perf for my target platform. Here are the issues I needed to 
overcome:

a) CC can only point to the executable
For some reason, the toolchain I have to work with defines

CC=aarch64-gnu-linux-gcc --sysroot=/home/yocto/SDK/E013/sdk/sysroots/aarch64-
gnu-linux
CFLAGS=-O2 -pipe -g -feliminate-unused-debug-types -fno-omit-frame-pointer -
march=armv8-a -funwind-tables

This works everywhere else (qmake, configure, cmake), but the kernel 
buildsystem is more picky and will silently ignore the sysroot parameter set 
in CC. To fix this, one has to move the sysroot parameter into CFLAGS. This 
was the reason for the "test-glib.c" feature failure

b) Manually enable/disable features

Once the above is fixed, the feature detection is still completely broken for 
me. It seems to blindly enable all features for some reason:

~~~~~~~~~~~~~
export CC="aarch64-gnu-linux-gcc"
export CFLAGS="--sysroot=/home/yocto/SDK/E013/sdk/sysroots/aarch64-gnu-linux -
O2 -pipe -g -feliminate-unused-debug-types -fno-omit-frame-pointer -
march=armv8-a -funwind-tables"
export ARCH=arm64
export CROSS_COMPILE=aarch64-gnu-linux-
make V=1 VF=1 EXTRA_CFLAGS="$CFLAGS"
  BUILD:   Doing 'make -j8' parallel build

Auto-detecting system features:
...                         dwarf: [ on  ]
...            dwarf_getlocations: [ on  ]
...                         glibc: [ on  ]
...                          gtk2: [ on  ]
...                      libaudit: [ on  ]
...                        libbfd: [ on  ]
...                        libelf: [ on  ]
...                       libnuma: [ on  ]
...        numa_num_possible_cpus: [ on  ]
...                       libperl: [ on  ]
...                     libpython: [ on  ]
...                      libslang: [ on  ]
...                     libcrypto: [ on  ]
...                     libunwind: [ on  ]
...            libdw-dwarf-unwind: [ on  ]
...                          zlib: [ on  ]
...                          lzma: [ on  ]
...                     get_cpuid: [ on  ]
...                           bpf: [ on  ]
...                     backtrace: [ on  ]
...                fortify-source: [ on  ]
...         sync-compare-and-swap: [ on  ]
...                  gtk2-infobar: [ on  ]
...             libelf-getphdrnum: [ on  ]
...           libelf-gelf_getnote: [ on  ]
...          libelf-getshdrstrndx: [ on  ]
...                   libelf-mmap: [ on  ]
...             libpython-version: [ on  ]
...                 libunwind-x86: [ on  ]
...              libunwind-x86_64: [ on  ]
...                 libunwind-arm: [ on  ]
...             libunwind-aarch64: [ on  ]
...   pthread-attr-setaffinity-np: [ on  ]
...            stackprotector-all: [ on  ]
...                       timerfd: [ on  ]
...                           sdt: [ on  ]

<snip>

In file included from /home/yocto/milian/linux/tools/perf/util/include/../../
ui/keysyms.h:4:0,
                 from /home/yocto/milian/linux/tools/perf/util/include/../
hist.h:409,
                 from /home/yocto/milian/linux/tools/perf/util/include/../
sort.h:23,
                 from ui/gtk/browser.c:4:
/home/yocto/milian/linux/tools/perf/util/include/../../ui/libslang.h:12:19: 
fatal error: slang.h: No such file or directory
 #include <slang.h>

... and many more errors
~~~~~~~~~~~~~

Looking at the faulty FEATURE-DUMP file in tools/build, I noticed not only 
features being enabled that I have on my host but not on the target (which 
would be bad enough), but also the following, which can only mean it blindly 
enabled everything:

~~~~~~~~~~~~~~
feature-libunwind=1
feature-libunwind-x86=1
feature-libunwind-x86_64=1
feature-libunwind-arm=1
feature-libunwind-aarch64=1
~~~~~~~~~~~~~~

I work-arounded this for now by copying the faulty FEATURE-DUMP file from 
tools/build/ to some other location, then hand-editing it to disable the 
features that I know are not available for my platform (slang, sdt, numa, gtk, 
x86 libunwind, ...). Then, I pass FEATURES_DUMP=path/to/my/FEATURE-DUMP to 
make.

c) Picking up dependencies from custom prefix

I've build libelf and other dependencies manually into a custom prefix outside 
of my sysroot. To pick those up, it's not enough to pass `prefix=path/to/
prefix` to make. You need to manually add `-Ipath/to/prefix/include` to 
EXTRA_CFLAGS and `-Lpath/to/prefix/lib` to LDFLAGS...

d) My final make invocation looks like this now:

export CC=aarch64-gnu-linux-gcc
export CFLAGS="--sysroot=/home/yocto/SDK/E013/sdk/sysroots/aarch64-gnu-linux 
-O2 -pipe -g -feliminate-unused-debug-types -fno-omit-frame-pointer -
march=armv8-a -funwind-tables"

make \
    FEATURES_DUMP=/home/yocto/milian/perf-FEATURE-DUMP \
    CROSS_COMPILE="aarch64-gnu-linux-" \
    EXTRA_CFLAGS="$CFLAGS -I/home/yocto/milian/target-prefix/include" \
    LDFLAGS="-L/home/yocto/milian/target-prefix/lib $LDFLAGS" \
    prefix=/home/yocto/milian/target-prefix

The features dump contains the following:

feature-backtrace=1
feature-dwarf=1
feature-dwarf_getlocations=1
feature-fortify-source=1
feature-sync-compare-and-swap=1
feature-glibc=1
feature-gtk2=0
feature-gtk2-infobar=0
feature-libaudit=0
feature-libbfd=0
feature-libelf=1
feature-libelf-getphdrnum=1
feature-libelf-gelf_getnote=1
feature-libelf-getshdrstrndx=1
feature-libelf-mmap=1
feature-libnuma=0
feature-numa_num_possible_cpus=0
feature-libperl=0
feature-libpython=0
feature-libpython-version=0
feature-libslang=0
feature-libcrypto=1
feature-libunwind=1
feature-libunwind-x86=0
feature-libunwind-x86_64=0
feature-libunwind-arm=1
feature-libunwind-aarch64=1
feature-pthread-attr-setaffinity-np=1
feature-stackprotector-all=1
feature-timerfd=1
feature-libdw-dwarf-unwind=1
feature-zlib=1
feature-lzma=1
feature-get_cpuid=1
feature-bpf=0
feature-sdt=0

I hope this helps others. I finally have a working up2date perf on my aarch64 
platform and it seems to work form my simple 5min tests so far.

Cheers

-- 
Milian Wolff | milian.wolff@kdab.com | Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
--nextPart3453434.DCAfXbUh0M
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIUdzCCBGYw
ggNOoAMCAQICEFEmCpMc4n+cw6VfeeByroIwDQYJKoZIhvcNAQEFBQAwgZMxCzAJBgNVBAYTAlVT
MQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRoZSBVU0VS
VFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29tMRswGQYDVQQD
ExJVVE4gLSBEQVRBQ29ycCBTR0MwHhcNMDUwNjA3MDgwOTEwWhcNMTkwNjI0MTkwNjMwWjBvMQsw
CQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFkZFRydXN0IEV4dGVy
bmFsIFRUUCBOZXR3b3JrMSIwIAYDVQQDExlBZGRUcnVzdCBFeHRlcm5hbCBDQSBSb290MIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt/caM+byAAQtOeBOW+0fvGwPzbX6I7bO3psRM5ek
KUx9k5+9SryT7QMa44/P5W1QWtaXKZRagLBJetsulf24yr83OC0ePpFBrXBWx/BPP+gynnTKyJBU
6cZfD3idmkA8Dqxhql4Uj56HoWpQ3NeaTq8Fs6ZxlJxxs1BgCscTnTgHhgKo6ahpJhiQq0ywTyOr
Ok+E2N/On+Fpb7vXQtdrROTHre5tQV9yWnEIN7N5ZaRZoJQ39wAvDcKSctrQOHLbFKhFxF0qfbe0
1sTurM0TRLfJK91DACX6YblpalgjEbenM49WdVn1zSnXRrcKK2W200JvFbK4e/vv6V1T1TRaJwID
AQABo4HYMIHVMB8GA1UdIwQYMBaAFFMy0bPPf/rg8aBdhU6S0p5FHbRPMB0GA1UdDgQWBBStvZh6
NLQm9/rEJlTvA73gJMtUGjAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB/zARBglghkgB
hvhCAQEEBAMCAQIwIAYDVR0lBBkwFwYKKwYBBAGCNwoDAwYJYIZIAYb4QgQBMD0GA1UdHwQ2MDQw
MqAwoC6GLGh0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9VVE4tREFUQUNvcnBTR0MuY3JsMA0GCSqG
SIb3DQEBBQUAA4IBAQDG7lMXaBSyUSIekFgNlP298XDlhi3DNjGPVEhG5y0IN7xsCmDhDq1RNOAS
k+m+uKu4JrTplj0oj65kB/7gAezF45HrGKDxdX7bCuafkduvrnXfI5Fo3RcAWkv/ZGxw6wEa0JDZ
x6bWbfYT5P+1ydIeKsuxJUMmeNkwm04NHr5p79/q/i2zzPmw3bUUypHUsrWl+wEZo0d5n52MlYc0
+B84kto2phH6a+tr6dxFeBU5BtdNQeQhyNwvh9G3v0hgdaViyyTeO2GgKSCmvsVsnMTpCmki75E6
+iav0VtBpzri+DgHQqvBW/jObboPBD8yNKzcBCjXcDAUJgbE5JuY1c94MIIEnTCCA4WgAwIBAgIQ
ND3pK6wnNP+PyzSU+8xwVDANBgkqhkiG9w0BAQUFADBvMQswCQYDVQQGEwJTRTEUMBIGA1UEChML
QWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFkZFRydXN0IEV4dGVybmFsIFRUUCBOZXR3b3JrMSIwIAYD
VQQDExlBZGRUcnVzdCBFeHRlcm5hbCBDQSBSb290MB4XDTA1MDYwNzA4MDkxMFoXDTIwMDUzMDEw
NDgzOFowga4xCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENp
dHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51
c2VydHJ1c3QuY29tMTYwNAYDVQQDEy1VVE4tVVNFUkZpcnN0LUNsaWVudCBBdXRoZW50aWNhdGlv
biBhbmQgRW1haWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCyOYWk8n2rQTtiRjeu
zcFgdbw5ZflKGkeiucxIzGqY1U01GbmkQuXOSeKKLx580jEHx060g2SdLinVomTEhb2FUTV5pE5o
kHsceqSSqBfymBXyk8zJpDKVuwxPML2YoAuL5W4bokb6eLyib6tZXqUvz8rabaov66yhs2qqty5n
NYt54R5piOLmRs2gpeq+C852OnoOm+r82idbPXMfIuZIYcZM82mxqC4bttQxICy8goqOpA6l14lD
/BZarx1x1xFZ2rqHDa/68+HC8KTFZ4zW1lQ63gqkugN3s2XI/R7TdGKqGMpokx6hhX71R2XL+E1X
KHTSNP8wtu72YjAUjCzrAgMBAAGjgfQwgfEwHwYDVR0jBBgwFoAUrb2YejS0Jvf6xCZU7wO94CTL
VBowHQYDVR0OBBYEFImCZ33EnSZwAEu0UEh83j2uBG59MA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMB
Af8EBTADAQH/MBEGA1UdIAQKMAgwBgYEVR0gADBEBgNVHR8EPTA7MDmgN6A1hjNodHRwOi8vY3Js
LnVzZXJ0cnVzdC5jb20vQWRkVHJ1c3RFeHRlcm5hbENBUm9vdC5jcmwwNQYIKwYBBQUHAQEEKTAn
MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0GCSqGSIb3DQEBBQUAA4IB
AQABvJzjYyiw8zEBwt973WKgAZ0jMQ+cknNTUeofTPrWn8TKL2d+eDMPdBa5kYeR9Yom+mRwANge
+QsEYlCHk4HU2vUj2zS7hVa0cDRueIM3HoUcxREVkl+HF72sav3xwtHMiV+xfPA+UfI183zsYJhr
Oivg79+zfYbrtRv1W+yifJgT1wBQudEtc94DeHThBYUxXsuauZ2UxrmUN3Vy3ET7Z+jw+iUeUqfa
JelH4KDHPKBOsQo2+3dIn++Xivu0/uOUFKiDvFwtP9JgcWDuwnGCDOmINuPaILSjoGyqlku4gI51
ykkH9jsUut/cBdmf2+Cy5k2geCbn5y1uf1/GHogVMIIFGjCCBAKgAwIBAgIQbRnqpxlPajMi5iIy
eqpx3jANBgkqhkiG9w0BAQUFADCBrjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAlVUMRcwFQYDVQQH
Ew5TYWx0IExha2UgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMSEwHwYDVQQL
ExhodHRwOi8vd3d3LnVzZXJ0cnVzdC5jb20xNjA0BgNVBAMTLVVUTi1VU0VSRmlyc3QtQ2xpZW50
IEF1dGhlbnRpY2F0aW9uIGFuZCBFbWFpbDAeFw0xMTA0MjgwMDAwMDBaFw0yMDA1MzAxMDQ4Mzha
MIGTMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
YWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE5MDcGA1UEAxMwQ09NT0RPIENsaWVu
dCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAkoSEW0tXmNReL4uk4UDIo1NYX2Zl8TJO958yfVXQeExVt0KU4PkncQfFxmmk
uTLE8UAakMwnVmJ/F7Vxaa7lIBvky2NeYMqiQfZq4aP/uN8fSG1lQ4wqLitjOHffsReswtqCAtbU
MmrUZ28gE49cNfrlVICv2HEKHTcKAlBTbJUdqRAUtJmVWRIx/wmi0kzcUtve4kABW0ho3cVKtODt
JB86r3FfB+OsvxQ7sCVxaD30D9YXWEYVgTxoi4uDD216IVfmNLDbMn7jSuGlUnJkJpFOpZIP/+Cx
YP0ab2hRmWONGoulzEKbm30iY9OpoPzOnpDfRBn0XFs1uhbzp5v/wQIDAQABo4IBSzCCAUcwHwYD
VR0jBBgwFoAUiYJnfcSdJnAAS7RQSHzePa4Ebn0wHQYDVR0OBBYEFHoTTgB0W8Z4Y2QnwS/ioFu8
ecV7MA4GA1UdDwEB/wQEAwIBBjASBgNVHRMBAf8ECDAGAQH/AgEAMBEGA1UdIAQKMAgwBgYEVR0g
ADBYBgNVHR8EUTBPME2gS6BJhkdodHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVROLVVTRVJGaXJz
dC1DbGllbnRBdXRoZW50aWNhdGlvbmFuZEVtYWlsLmNybDB0BggrBgEFBQcBAQRoMGYwPQYIKwYB
BQUHMAKGMWh0dHA6Ly9jcnQudXNlcnRydXN0LmNvbS9VVE5BZGRUcnVzdENsaWVudF9DQS5jcnQw
JQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEFBQADggEB
AIXWvnhXVW0zf0RS/kLVBqgBA4CK+w2y/Uq/9q9BSfUbWsXSrRtzbj7pJnzmTJjBMCjfy/tCPKEl
Pgp11tA9OYZm0aGbtU2bb68obB2v5ep0WqjascDxdXovnrqTecr+4pEeVnSy+I3T4ENyG+2P/WA5
IEf7i686ZUg8mD2lJb+972DgSeUWyOs/Q4Pw4O4NwdPNM1+b0L1garM7/vrUyTo8H+2b/5tJM75C
KTmD7jNpLoKdRU2oadqAGx490hpdfEeZpZsIbRKZhtZdVwcbpzC+S0lEuJB+ytF5OOu0M/qgOl0m
WJ5hVRi0IdWZ1eBDQEIwvuql55TSsP7zdfl/bucwggZKMIIFMqADAgECAhByCOhbkTwXiJtaa0d5
K5u0MA0GCSqGSIb3DQEBBQUAMIGTMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5j
aGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE5MDcG
A1UEAxMwQ09NT0RPIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4X
DTE0MDYwMjAwMDAwMFoXDTE3MDYwMTIzNTk1OVowggFZMQswCQYDVQQGEwJTRTEPMA0GA1UEERMG
NjgzIDMxMRIwEAYDVQQIEwlWYWVybWxhbmQxEDAOBgNVBAcTB0hhZ2ZvcnMxGDAWBgNVBAkTD05v
cnJpbmdzIHZhZWcgMjEPMA0GA1UEEhMGQm94IDMwMSYwJAYDVQQKDB1LbGFyw6RsdmRhbGVucyBE
YXRha29uc3VsdCBBQjEdMBsGA1UECxMUQSBLREFCIEdyb3VwIENvbXBhbnkxQzBBBgNVBAsMOklz
c3VlZCB0aHJvdWdoIEtsYXLDpGx2ZGFsZW5zIERhdGFrb25zdWx0IEFCIEUtUEtJIE1hbmFnZXIx
HzAdBgNVBAsTFkNvcnBvcmF0ZSBTZWN1cmUgRW1haWwxFTATBgNVBAMTDE1pbGlhbiBXb2xmZjEk
MCIGCSqGSIb3DQEJARYVbWlsaWFuLndvbGZmQGtkYWIuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAwirYPAOcWQk9jaCoEAn84PwINg/NDs3PxsEd34f27AfCqJepwIF+ikMuBBxt
mm1pieQwU9fcFrE4CXPCdYxfFOdcbJJ58Xzog5aFrJHnYGEFIL8KVvdBvAFeP/AJPaY2lg1JWnVI
1jwO74VmUGMyvMG286wpwW3hWO3sepZZQN3tvXyd9EgD72AiImkvw43+BW4xy8ptOd3TvEwCJ+uN
x8v+uILsRLvKcmSrUsLpo7No2HoifWX1doKHKSwYVVqmOT/rjJWxF98j4w2kTKRsWdQ4ENlqNpjW
zlbtB6TM2mrnInefzALbIoLLQ2E2NFCaMVsczf7RFsMxUepM9KQQ5QIDAQABo4IBzzCCAcswHwYD
VR0jBBgwFoAUehNOAHRbxnhjZCfBL+KgW7x5xXswHQYDVR0OBBYEFGSjHixs9BD9OyGskYjMX7mi
P+fiMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggr
BgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUFBwIBFh1odHRwczov
L3NlY3VyZS5jb21vZG8ubmV0L0NQUzBXBgNVHR8EUDBOMEygSqBIhkZodHRwOi8vY3JsLmNvbW9k
b2NhLmNvbS9DT01PRE9DbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGI
BggrBgEFBQcBAQR8MHowUgYIKwYBBQUHMAKGRmh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9E
T0NsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0
dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAgBgNVHREEGTAXgRVtaWxpYW4ud29sZmZAa2RhYi5jb20w
DQYJKoZIhvcNAQEFBQADggEBAFvi067uXCOkiUH/D6rv4gV0/e+e8DzcvbbsUxAC5nwDXBv+47ds
l7j8NrZstZraVz35WEWgksNmnyghcuBKzKcN3kY1KNn/ERc9wvns/0dI+yj39L0eSMzchUZoV6GY
MtPfmLofPvUBbDesl97JQXF9vpk8FIVsI1UKKrLzfoKhue5abQHXurSFa0ts1UPmSh2Y8/QCQlFN
lCv8ISyEwVCAkhdIqxRc3hslooBhcRVUrYhRdCLlNN6Od8yuLE9sKWH/K4wg/BpnjCJmGp4GQhU8
DUG2r0CbOa+iZQKTWUgwdGU3Jr+WcOan/JaNzBuKk1GM3D+WcljoU7ZWtoqXPzgxggJaMIICVgIB
ATCBqDCBkzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
BxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxOTA3BgNVBAMTMENPTU9ETyBD
bGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQcgjoW5E8F4ibWmtHeSub
tDAJBgUrDgMCGgUAoIGHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8X
DTE2MDgwMzIwNTYyMFowIwYJKoZIhvcNAQkEMRYEFMU9GLg3nBDf8azKPm/6tOnSe5apMCgGCSqG
SIb3DQEJDzEbMBkwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBAQUABIIBAJ53
0bpWN2aVm+LOemSUpzEmB059yyIcVsjkIho7V5yzkCRdG2wR8m6yC66ruTXHt5ABbB5CBjLLcLf9
GvekK1eMM50fEXMiGvzESH6ScXAU7w1BQfHdskkJhmG5amAP4a8I35vAcyYlMkKLXYRgmS/lNdlL
ZgQdh5uDg5eXBFBCN87mUsXIUtsBuyVDp0inR9NnHXFqjYUJQqHwEjMhOPFmfpzgGSA6to1OXP2W
WrePBuOfVvGL/ZGMEAos4hh20KKFxzc3c1Xpe7fiLxDp12ptUZkDSAKNAPK7SNvlTR0IhCe7r3Vh
ntHXk5vhXZf9WmPPY5os/Q1cmrtfyW15ynwAAAAAAAA=


--nextPart3453434.DCAfXbUh0M--
