From: Milian Wolff <milian.wolff@kdab.com>
Subject: usability issues with inlining and backtraces
Date: Mon, 23 May 2016 11:10:00 +0200
Message-ID: <3421510.JYGX19gbWH@milian-kdab2>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15250905.mWTtv9s2Is"; micalg="sha1"; protocol="application/pkcs7-signature"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:49009 "EHLO mail.kdab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753758AbcEWJKL (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 23 May 2016 05:10:11 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

--nextPart15250905.mWTtv9s2Is
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hey all,

I've recently encountered some nasty issues with perf which should - I hope=
 -=20
be possible to be fixed.

=46irst of all, I learned about `perf report -s sym,srcline`, most notably =
the=20
`srcline`, which finally (!) allows me to correlate sample cost directly to=
=20
line numbers, without trying to interpret the often quite convoluted output=
 of=20
`perf annotate`. But, take the following example code:

~~~~~~~~~~~~
#include <complex>
#include <cmath>
#include <random>
#include <iostream>

using namespace std;

int main()
{
    uniform_real_distribution<double> uniform(-1E5, 1E5);
    default_random_engine engine;
    double s =3D 0;
    for (int i =3D 0; i < 1000000; ++i) {
        s +=3D norm(complex<double>(uniform(engine), uniform(engine)));
    }
    cout << s << '\n';
    return 0;
}
~~~~~~~~~~~~

Compile it with

    g++ -std=3Dc++11 -g -O2 test.cpp

Then profile it with perf:

    perf record --call-graph dwarf

########## perf report backtraces in face of inlining

Now let us go through the the output of the report with srcline enabled:

~~~~~~~~~~~~
    perf report --stdio -s sym,srcline --no-children

    21.07%  [.] main                   random.tcc:3332
            |
            ---__libc_start_main
               _start
    20.30%  [.] main                   random.h:143
            |
            ---__libc_start_main
               _start
~~~~~~~~~~~~

Here, the cost of inlined functions (random.tcc:3332,random.h:143) is=20
attributed to the main function. This is of course correct, but very unhelp=
ful=20
to me as a programmer. I'm much more interested in the line inside test.cpp=
=20
which triggered the call to random.tcc:3332 etc. Is there a way to get that=
=20
data? Note how you can a way better backtrace when using GDB on the same=20
binary as above:=20

~~~~~~~~~~~~
    gdb a.out
    break random.tcc:3332
    run
Breakpoint 1, std::generate_canonical<double, 53ul,=20
std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> =
>=20
(__urng=3D...) at /usr/include/c++/6.1.1/bits/random.tcc:3332
3332                  __sum +=3D _RealType(__urng() - __urng.min()) * __tmp;
(gdb) bt
#0  std::generate_canonical<double, 53ul,=20
std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> =
>=20
(__urng=3D...) at /usr/include/c++/6.1.1/bits/random.tcc:3332
#1  std::__detail::_Adaptor<std::linear_congruential_engine<unsigned long,=
=20
16807ul, 0ul, 2147483647ul>, double>::operator() (this=3D<optimized out>)
    at /usr/include/c++/6.1.1/bits/random.h:185
#2 =20
std::uniform_real_distribution<double>::operator()<std::linear_congruential=
_engine<unsigned=20
long, 16807ul, 0ul, 2147483647ul> > (this=3D<optimized out>, __p=3D...,=20
__urng=3D...)
    at /usr/include/c++/6.1.1/bits/random.h:1818
#3 =20
std::uniform_real_distribution<double>::operator()<std::linear_congruential=
_engine<unsigned=20
long, 16807ul, 0ul, 2147483647ul> > (__urng=3D<synthetic pointer>,=20
this=3D<synthetic pointer>)
    at /usr/include/c++/6.1.1/bits/random.h:1809
#4  main () at test.cpp:14
~~~~~~~~~~~~

Why is perf (or is it libunwind?) not capable of getting the same backtrace?

######### srcline in perf report backtraces

If we continue with the `perf report` output from the command above, we'll
eventually see:

~~~~~~~~~~~~

     4.60%  [.] main                   test.cpp:14
            |
            ---__libc_start_main
               _start

     3.63%  [.] __hypot_finite         __hypot_finite+257
            |
            ---hypot
               main
               __libc_start_main
               _start

     3.25%  [.] hypot                  hypot+55
            |
            ---main
               __libc_start_main
               _start

     3.21%  [.] __hypot_finite         __hypot_finite+152
            |
            ---hypot
               main
               __libc_start_main
               _start

     2.63%  [.] __hypot_finite         __hypot_finite+66
            |
            ---hypot
               main
=2E.. continued
~~~~~~~~~

Here, I have again a few things to note:

On one hand, we have the same issue as above, namely inlined functions bein=
g=20
attributed directly to the parent function. See how the backtrace shows mai=
n=20
calling hypot? Look at the source, I'm not calling hypot anywhere - it's=20
std::norm calling it internally eventually. And GDB does know about that an=
d=20
can give me a proper backtrace.

But, differently to above, the major gripe I have with this output is=20
exemplified by this part:

~~~~~~~~~
     3.63%  [.] __hypot_finite         __hypot_finite+257
            |
            ---hypot
               main
               __libc_start_main
               _start
~~~~~~~~~

I added `srcline` to the report, but the backtrace still only contains the=
=20
symbol name. I hope, that we can simply honor srcline there as well, to at=
=20
least print something like this instead:

~~~~~~~~~
     3.63%  [.] __hypot_finite         __hypot_finite+257
            |
            ---hypot
               main at test.cpp:14 ### <-- srcline here as well please?
               __libc_start_main
               _start
~~~~~~~~~

Is there a reason why this was not yet implemented? If not, then I'll prepa=
re=20
a patch for that, as I hope this to be easy to implement.

########## symbol cost aggregation

Once we have that implemented, can we maybe account for the following: I to=
ld=20
`perf report` to aggregate by symbol first, then srcline, i.e. `-s=20
sym,srcline`. But the report seems to aggregate by `srcline`, because I see=
=20
some symbols (__hypot_finite) multiple times, for different code points. Ca=
n=20
we merge those and start the backtrace then at the different code points?=20
Something like this would be my desirable output:

~~~~~~~~
# see above for what I actually get, here I'm accumulating manually
$ perf report --stdio -s sym,srcline --no-children |grep __hypot_finite+ | =
awk=20
'{sum+=3D$1}END{print sum}'
34.96
# this is what I would like to get directly
$ perf report --stdio -s sym,srcline --no-children=20
=2E..
34.96%  [.] __hypot_finite
            |
     3.63%  | __hypot_finite         __hypot_finite+257
            - ...
     3.21%  | __hypot_finite         __hypot_finite+152
            - ...
     ...
~~~~~~~~~

What do you think?

####### perf annotate for mere mortals

To conclude this already long email, I want to raise the mess that is `perf=
=20
annotate`. If I run it on my above data file, I get the following output:

~~~~~~~~~
  1.23 =E2=94=82       mulsd  0x2f2(%rip),%xmm0        # 400bd0 <_IO_stdin_=
used+0x20>
  2.47 =E2=94=82       subsd  0x2f2(%rip),%xmm0        # 400bd8 <_IO_stdin_=
used+0x28>
       =E2=94=82     _ZSt13__complex_absCd():
       =E2=94=82     #if _GLIBCXX_USE_C99_COMPLEX
       =E2=94=82       inline float
       =E2=94=82       __complex_abs(__complex__ float __z) { return=20
__builtin_cabsf(__z); }
       =E2=94=82
       =E2=94=82       inline double
       =E2=94=82       __complex_abs(__complex__ double __z) { return=20
__builtin_cabs(__z); }
  1.23 =E2=94=82     =E2=86=92 callq  cabs@plt
       =E2=94=82     _ZNSt12_Norm_helperILb1EE8_S_do_itIdEET_RKSt7complexIS=
2_E():
       =E2=94=82         {
       =E2=94=82           template<typename _Tp>
       =E2=94=82             static inline _Tp _S_do_it(const complex<_Tp>&=
 __z)
       =E2=94=82             {
       =E2=94=82               _Tp __res =3D std::abs(__z);
       =E2=94=82               return __res * __res;
       =E2=94=82       mulsd  %xmm0,%xmm0
       =E2=94=82     main():
       =E2=94=82         for (int i =3D 0; i < 1000000; ++i) {
  1.23 =E2=94=82       sub    $0x1,%ebp
       =E2=94=82             s +=3D norm(complex<double>(uniform(engine),=20
uniform(engine)));
  7.41 =E2=94=82       addsd  0x8(%rsp),%xmm0
       =E2=94=82       movsd  %xmm0,0x8(%rsp)
       =E2=94=82     int main()
       =E2=94=82     {
       =E2=94=82         uniform_real_distribution<double> uniform(-1E5, 1E=
5);
       =E2=94=82         default_random_engine engine;
       =E2=94=82         double s =3D 0;
       =E2=94=82         for (int i =3D 0; i < 1000000; ++i) {
       =E2=94=82     =E2=86=93 je     24e
       =E2=94=82    =20
_ZNSt8__detail4_ModImLm2147483647ELm16807ELm0ELb1ELb1EE6__calcEm():
       =E2=94=82           struct _Mod<_Tp, __m, __a, __c, true, __s>
       =E2=94=82           {
       =E2=94=82             static _Tp
       =E2=94=82             __calc(_Tp __x)
       =E2=94=82             {
       =E2=94=82               _Tp __res =3D __a * __x + __c;
       =E2=94=82194:   imul   $0x41a7,%rbx,%rbx

~~~~~~~

I personally think this output is extremely hard to interpret. I see the va=
lue=20
of the above output when you want to look at the cost of hot computational=
=20
kernels, but for most user space applications the above is pretty much=20
useless. Most notably, note that the above shows self cost only and I could=
=20
not find a way to trigger inclusive cost visualization. It makes me believe=
=20
that the addition of the complex norms is the most costly operation in my=20
code. That is not true, the inclusive cost of the random engine as well as=
=20
actually computing the norm is way higher, i.e. I see

   1.23 =E2=94=82     =E2=86=92 callq  cabs@plt

but from the output of `perf report` above that triggers the calls to=20
`__hypot` which have close to 40% of the cost.

As such, I propose a "simplified" `perf annotate` output, which gets closer=
 to=20
what you'll see in other profilers, e.g. VTune or also Microsoft Visual=20
studio's sampling profilers: Use the source files and annotate those with=20
inclusive cost. Only show the cost of individual binary instructions (statu=
s=20
quo) when explicitly asked. I.e. I want the output to look something like t=
hat=20
(I made up the actual percentages):

~~~~~~~~~
        #include <complex>
        #include <cmath>
        #include <random>
        #include <iostream>

        using namespace std;

        int main()
        {
1%          uniform_real_distribution<double> uniform(-1E5, 1E5);
1%          default_random_engine engine;
            double s =3D 0;
1%          for (int i =3D 0; i < 1000000; ++i) {
95%            s +=3D norm(complex<double>(uniform(engine), uniform(engine)=
));
            }
2%          cout << s << '\n';
            return 0;
        }
~~~~~~~~~

Bonus points if I could then navigate to a source line and dig deeper (i.e.=
=20
see the instructions for this line and then jump to a function that is bein=
g=20
called e.g.).

Thanks a lot for reading this far. Please note that I really like perf, I j=
ust=20
have trouble teaching people using it as many things are really really hard=
=20
and I hope we can work together to make perf much easier to use!

Thanks
=2D-=20
Milian Wolff | milian.wolff@kdab.com | Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
--nextPart15250905.mWTtv9s2Is
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
DTE2MDUyMzA5MTAwMFowIwYJKoZIhvcNAQkEMRYEFNObBHYerfgM8DscT6S9L/xgsBQ7MCgGCSqG
SIb3DQEJDzEbMBkwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBAQUABIIBALCJ
NUDBwOldqMRLJhjlCaMo9/YKi9xAW7cTmYml4/2PCqVqJAi0lHe/oZHlMHPRJLF7Stv8zCH5QtpT
U/553jQ9tVX2lBz8YzNRU0v2BkOSOcBTZV4fD4e0ULu0GZVo9qMPdt0b1Q5oiShI679ocb/6D7wz
zeesqqQijdirqVL9xML+//N4RkTK4b3Ca+KeWrrJoOnX9nkua2NNvo8UWiwm5ztVTxopFtNl+8hH
VZOCIQ3Pl0keyXaIxV0vjrDIgfIWXYu4GMfPr6dUgnN7WN4vi4lcWmzhcx3lNrzho6Eurb4zrOpR
lV5TehTdWQ6gLJEqpmps/JmnhnsFtacUFMMAAAAAAAA=


--nextPart15250905.mWTtv9s2Is--
