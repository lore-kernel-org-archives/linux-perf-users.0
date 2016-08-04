From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: cross compiling perf
Date: Thu, 04 Aug 2016 23:58:32 +0200
Message-ID: <1973740.7uikfxrqxa@agathebauer>
References: <16135005.c00Xa53Rc9@milian-kdab2> <3173583.b0RsRJyeV2@milian-kdab2> <20160804183605.GJ14639@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1548359.Vbqk7Zj31B"; micalg="sha1"; protocol="application/pkcs7-signature"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:57294 "EHLO mail.kdab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934289AbcHDV6h (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 4 Aug 2016 17:58:37 -0400
In-Reply-To: <20160804183605.GJ14639@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, hekuang@huawei.com
Cc: wangnan0@huawei.com, linux-perf-users@vger.kernel.org

--nextPart1548359.Vbqk7Zj31B
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 4. August 2016 15:36:05 CEST Arnaldo Carvalho de Melo wrote:
> Em Thu, Aug 04, 2016 at 05:02:01PM +0200, Milian Wolff escreveu:
> > On Thursday, August 4, 2016 10:22:25 AM CEST Arnaldo Carvalho de Melo 
wrote:
> > > Em Wed, Aug 03, 2016 at 10:56:20PM +0200, Milian Wolff escreveu:
> > > > I hope this helps others. I finally have a working up2date perf on my
> > > > aarch64 platform and it seems to work form my simple 5min tests so
> > > > far.
> > > 
> > > Ok, that should help people, but it is way convoluted :-\
> > > 
> > > How did you obtained your cross compiler environment? Some ready made
> > > tarball or set of distro packages? I have an ever growing set of perf
> > 
> > > build cointainers that includes a few cross compilers:
> > The environment was provided to us as a tarball from a customer of ours,
> > who probably got that from another subcontractor.
> > 
> > <snip>
> > 
> >     export INSTALLDIR=/usr/${TARGET} && \
> > 
> > ^-- is that path potentially special cased in the build file? I mean you
> > don't
> Huh? Not that I am aware, no, I just looked at where the existing cross
> build packages were located, so that I used the same place for the cross
> built versions of libelf and zlib:

<snip>

> etc. So I assumed the best place to install the zlib and libelf devel files
> was with that path prefix.

Right, I think my point above was not clear: Since you essentially put your 
custom libelf into the implicit sysroot and also don't specify any prefix to 
install to, it seems to work out of the box. Is this the common way people 
build perf? From my experience working on e.g. KDE, one often has the sysroot 
(e.g. /usr), and then a bunch of custom stuff in a prefix somewhere in $HOME. 
Doing that with perf seems to be "hard", as it's not enough to do

    make prefix=$HOME/path/to/foo

but instead one also needs to pass `-I.../include` and `-L.../lib` to 
EXTRA_CFLAGS & LDFLAGS. I'd be willing to supply a patch to simplify this 
process, if you think that is acceptable.

> See it running:

<snip>

> See? The features it is finding are just the ones related to having glibc,
> zlib and libelf devel packages that can be used in a cross build.

OK, good to know. Then this clearly is something else special to my setup, 
similar to my initial problems with `--sysroot` being defined in `CC` rather 
than `EXTRA_CFLAGS`. I'll try to dig into that eventually.
 
> > set the sysroot anywhere, nor do you seem to pass special include paths to
> > perf. This of course works fine in a docker environment, but for "normal"
> > development machines, where you compile and install stuff somewhere in
> > $HOME, this won't work at all.
> 
> Hey, a "docker environment" should be no different than a "normal"
> development machine, it should work just the same, its just the former will
> run inside a container, but the packages are the same I would install in my
> workstation if I wanted to pollute it with a cross compiler environment.
> Since I want to install tons of cross compiler environments, I better use
> some sort of container, docker being the most popular, I picked it.

My point here is exactly the pollution that happens in my non-containered 
environment. There, I have tons of dev packages installed in e.g. /usr, which 
may potentially get picked up, as well as the "actual" stuff that should be 
used from the sysroot. But, again, at this point this is just speculation.

If you have the time, could you try to install some more x86 dev packages in 
your docker environments? E.g. when you install libunwind(-x86-64) - does it 
then get picked up by your arm cross compile, or does it work as it should? 
That data point would help me figure out what could go wrong.

> > The above wouldn't directly explain the really strange behavior of the
> > feature detection though (which enables _everything_ for me).
> 
> That is strage, yes, and I haven't even tried to figure out why this
> happens in your case, I was just trying to show cross compiler
> environments where the cross build of perf works, perhaps that would
> help you figure out your specific case.

Yep, it does help (see above). Thanks!

> Further example, here is the Android NDK one, that is on top of Fedora 24
> instead of the previous example, that is on top of Ubuntu 16.04, and here
> you may have your answer, i.e. use EXTRA_CFLAGS to set --sysroot, I got
> that from tools/perf/Documentation/android.txt:

I do pass --sysroot to EXTRA_CFLAGS via CFLAGS. From my previous mail:

export CFLAGS="--sysroot=...
#              ^-- CFLAGS contains --sysroot

make ...\
    EXTRA_CFLAGS="$CFLAGS -I/home/yocto/milian/target-prefix/include" \
#                 ^--- and gets passed in here
    LDFLAGS="-L/home/yocto/milian/target-prefix/lib $LDFLAGS" \
    prefix=/home/yocto/milian/target-prefix

> [root@jouet x-arm64]# cat /root/perf/android/r12b/arm/Dockerfile
> # docker.io/acmel/linux-perf-tools-build-android-ndk:r12b
> FROM docker.io/fedora:24
> MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
> ENV SOURCEFILE=android-ndk-r12b-linux-x86_64.zip
> RUN dnf -y install make bison flex unzip && \
>     dnf -y clean all && \
>     mkdir -m 777 -p /tmp/build/perf /tmp/build/objtool && \
>     curl -OL http://dl.google.com/android/repository/${SOURCEFILE} && \
>     unzip -d /opt ${SOURCEFILE} && \
>     rm -f ${SOURCEFILE} && \
>     rm -rf /opt/android-ndk-r12b/sources \
> 	   /opt/android-ndk-r12b/platforms/android-[19]* \
> 	   /opt/android-ndk-r12b/platforms/android-2[0-3]* \
> 	   /opt/android-ndk-r12b/platforms/android-24/arch-mips* \
> 	   /opt/android-ndk-r12b/platforms/android-24/arch-x86* \
> 	   /opt/android-ndk-r12b/toolchains/x86* \
> 	   /opt/android-ndk-r12b/toolchains/mips* \
> 	   /opt/android-ndk-r12b/toolchains/llvm* \
> 	   /opt/android-ndk-r12b/prebuilt/ \
> 	   /opt/android-ndk-r12b/python* \
> 	   /opt/android-ndk-r12b/shader-tools/ &&\
>     groupadd -r perfbuilder && \
>     useradd -r -g perfbuilder perfbuilder
> USER perfbuilder
> ENV NDK=/opt/android-ndk-r12b/
> ENV
> NDK_TOOLCHAIN=${NDK}/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x8
> 6_64/bin/arm-linux-androideabi- ENV
> NDK_SYSROOT=${NDK}/platforms/android-24/arch-arm
> ENTRYPOINT make -C /git/linux/tools/perf O=/tmp/build/perf WERROR=0 ARCH=arm
> CROSS_COMPILE=${NDK_TOOLCHAIN} EXTRA_CFLAGS="-pie --sysroot=${NDK_SYSROOT}"
> && \ make -C /git/linux/tools/objtool O=/tmp/build/objtool WERROR=0
> ARCH=arm CROSS_COMPILE=${NDK_TOOLCHAIN} EXTRA_CFLAGS="-pie
> --sysroot=${NDK_SYSROOT}" [root@jouet x-arm64]#
> 
> --------------------------------------------------------
> 
> This one comes with a bit more pre-built devel packages, so did not have to
> cross build zlib (I'll copy the cross build of libelf to get a bit more code
> tested...) instead I threw away lots of toolchains for arches I didn't
> want, leaving just the ones for "arm-linux-androideabi-", running it we
> get:
> 
> [root@jouet ~]# docker run -v /home/acme/git:/git:Z --rm -ti
> docker.io/acmel/linux-perf-tools-build-android-ndk:r12b make: Entering
> directory '/git/linux/tools/perf'
>   BUILD:   Doing 'make -j4' parallel build
> 
> Auto-detecting system features:
> ...                         dwarf: [ OFF ]
> ...            dwarf_getlocations: [ OFF ]
> ...                         glibc: [ OFF ]

glibc fails, but no fatal error is shown. from the make files I seem to 
remember special casing for the bionic libc implementation, which doesn't seem 
to be represented in the feature list.

<snip>

Still, good to see that the feature detection otherwise seems to work just 
fine for your docker setups.

Thanks for the input, I'll get back to you once I know more about the failures 
on my system. Btw.:

- would it be acceptable to add a warning/error to the build system when CC 
contains more than the compiler name? 
- would a patch be accepted to automatically add $prefix/include and $prefix/
lib to -I & -L via CFLAGS/LDFLAGS in the makefile (see above)?

If so, then I'd create some patches for that.

Cheers
-- 
Milian Wolff | milian.wolff@kdab.com | Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
--nextPart1548359.Vbqk7Zj31B
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
DTE2MDgwNDIxNTgzMlowIwYJKoZIhvcNAQkEMRYEFP07d0lBEkwPFg63miRtdlg8V0kDMCgGCSqG
SIb3DQEJDzEbMBkwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBAQUABIIBACap
cWxVx4DthLKLk8pxyzN71RVoLiRCIfMNiHB8y8vahBRt5qeVZTEvn/s0iUcph4eUVuZAbQdv1Aql
bca/ufBdOmO2eRuuVqAtbrrSCCbndsw5Jjer6CGKd3zrT/uuAYWGUv5nIxs4HzavleyoP1FKjTCw
2jm1ZYYUljiBFsXQob8bGI1hyMbMsnSHGKX62RSNF9CJpy2AjesOidv5zbnDqnFm+yF4dVnRNtqc
IcgZ9wr+ep6dujEM7I7wjEvVHKQ91XPE4c5lJpCjPpSGcRIrCrhRd6fqyFlgE8Fb8aYysq3QpU9U
Stq4+uBz/2YfdwDeApimHt3HzuwKUQT1B3UAAAAAAAA=


--nextPart1548359.Vbqk7Zj31B--
