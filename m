From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: Cross platform perf reporting
Date: Mon, 15 Aug 2016 14:20:15 +0200
Message-ID: <18625452.F1CIFXVKL2@milian-kdab2>
References: <20160812153125.GK27651@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2155981.m03nQMB48J"; micalg="sha1"; protocol="application/pkcs7-signature"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:56448 "EHLO mail.kdab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752748AbcHOMUU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 15 Aug 2016 08:20:20 -0400
In-Reply-To: <20160812153125.GK27651@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, dsahern@gmail.com, hekuang@huawei.com

--nextPart2155981.m03nQMB48J
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, August 12, 2016 12:31:25 PM CEST Arnaldo Carvalho de Melo wrote:
> Em Fri, Aug 12, 2016 at 05:10:18PM +0200, Milian Wolff escreveu:
> > On Friday, August 12, 2016 2:22:29 PM CEST Milian Wolff wrote:
> > > I'm trying to analyze perf.data files that I recorded on one machine
> > > (usually arm or arm64) on my development machine (x86_64). I have
> > > compiled
> > > a new version of perf (and the corresponding dependencies, where needed)
> > > to
> > > do this.
> 
> Adding He Kuang, that did work on this area recently.
> 
> > > Now I do:
> > > 
> > > ~~~~~~~~~~~~~~~~~~~~~~~~
> > > aarch64$ perf record -g ...
> > > aarch64$ perf archive
> > > 
> > > x86_64$ scp aarch64:perf.data* .
> > > x86_64$ tar xvf perf.data.tar.bz2 -C ~/.debug
> > > x86_64$ perf report |& less
> > > -> lots of errors, none of which are displayed in the TUI, such as:
> > > 
> > > unwind: target platform=arm64 is not supported
> > > (often repeated)
> > > Failed to open /lib/ld-2.21.so, continuing without symbols
> > > Failed to open /lib/libc-2.21.so, continuing without symbols
> > > Failed to open /lib/libpthread-2.21.so, continuing without symbols
> > > Failed to open /lib/libdl-2.21.so, continuing without symbols
> > > ...
> > > ~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > What I notice, is that `perf buildid-list` does not contain any of these
> 
> That is a limitation that needs fixing, what gets into the build-id are
> entries that had hits, DSOs, but those are sample hits, not callchain
> hits.
> 
> We would have to traverse all callchains and add build-id entries for
> the DSOs in it.
> 
> I need to do this :-\
> 
> But if you have a copy of your target in a file and use --symfs with it it
> should work, because then, because it doesn't have the build-id for the DSOs
> in the callchains that didn't had hits, it will resort to using just the
> pathname when looking for a symtab or the whole ELF for annotation, etc.
>
> > files. I also don't have the corresponding files in my target's ~/.debug
> > folder, where everything seems to work as expected. Is that, because there
> > the symbols are read directly from the file and nothing is cached in
> > ~/.debug?
>
> That is a possibility, yes. But it should be adding it to ~/.debug, that
> is the default, unless you have something disabling that in your
> ~/.perfconfig or some sort of problem is happening that is preventing it
> to do the hardlink/copy.

I now realized that the culprit here is actually a broken platform, i.e. the 
libs above simply don't have a build id:

eu-readelf -n libc.so.6

Note section [ 1] '.note.ABI-tag' of 32 bytes at offset 0x270:
  Owner          Data size  Type
  GNU                   16  VERSION
    OS: Linux, ABI: 3.18.0

So no wonder they are not included in perf archive. I think a warning would be 
helpful here to tell users that analyzing the data on the remote machine will 
require --symfs (which I wasn't aware of, thanks!).

> > Can I set an environment variable to let perf know to look in secondary
> > paths for the libraries? I.e. I hope to make it look into the cross
> > compile sysroot for these libraries, instead of literally interpreting
> > the path as a valid path on my development machine.
> 
> That is the --symfs David talked about, no?
> 
> [acme@jouet linux]$ perf report -h symfs
> 
>  Usage: perf report [<options>]
> 
>         --symfs <directory>
>                           Look for files with symbols relative to this
> directory

Yes, symfs sounds exactly like what I was looking for. I have now tested this, 
and seem to hit some issues with it:

I unpacked a perf archive from a platform which includes a libc with buildit:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
milian@milian-kdab2:/tmp$ tar -tvf perf.data.tar.bz2 | grep libc-2.19
lrwxrwxrwx root/root         0 2000-01-01 18:36 .build-id/
45/7c5918872338e1b82bf8bf41ae9f55b34604ea -> ../../lib/arm-linux-gnueabihf/
libc-2.19.so/457c5918872338e1b82bf8bf41ae9f55b34604ea
drwxr-xr-x root/root         0 2000-01-01 18:36 lib/arm-linux-gnueabihf/
libc-2.19.so/457c5918872338e1b82bf8bf41ae9f55b34604ea/
-rwxr-xr-x root/root    911068 2016-03-01 01:55 lib/arm-linux-gnueabihf/
libc-2.19.so/457c5918872338e1b82bf8bf41ae9f55b34604ea/elf
-rw-r--r-- root/root         0 2000-01-01 18:36 lib/arm-linux-gnueabihf/
libc-2.19.so/457c5918872338e1b82bf8bf41ae9f55b34604ea/probes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Analyzing it for some reason isn't using the build id:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
milian@milian-kdab2:/tmp$ strace -e file -f perf report --stdio -s sym,srcline 
|& grep libc-2.19
stat("/lib/arm-linux-gnueabihf/libc-2.19.so", 0x7ffde9316200) = -1 ENOENT (No 
such file or directory)
stat("/lib/arm-linux-gnueabihf/libc-2.19.so", 0x7ffde9316180) = -1 ENOENT (No 
such file or directory)
stat("/usr/lib/debug/lib/arm-linux-gnueabihf/libc-2.19.so.debug", 
0x7ffde9316200) = -1 ENOENT (No such file or directory)
stat("/usr/lib/debug/lib/arm-linux-gnueabihf/libc-2.19.so", 0x7ffde9316200) = 
-1 ENOENT (No such file or directory)
stat("/lib/arm-linux-gnueabihf/libc-2.19.so", 0x7ffde9316200) = -1 ENOENT (No 
such file or directory)
stat("/lib/arm-linux-gnueabihf/.debug/libc-2.19.so", 0x7ffde9316200) = -1 
ENOENT (No such file or directory)
open("/lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = -1 ENOENT (No such 
file or directory)
addr2line_init failed for /lib/arm-linux-gnueabihf/libc-2.19.so
open("/lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = -1 ENOENT (No such 
file or directory)
addr2line_init failed for /lib/arm-linux-gnueabihf/libc-2.19.so
open("/lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = -1 ENOENT (No such 
file or directory)
addr2line_init failed for /lib/arm-linux-gnueabihf/libc-2.19.so
open("/lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = -1 ENOENT (No such 
file or directory)
addr2line_init failed for /lib/arm-linux-gnueabihf/libc-2.19.so
open("/lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = -1 ENOENT (No such 
file or directory)
addr2line_init failed for /lib/arm-linux-gnueabihf/libc-2.19.so
open("/lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = -1 ENOENT (No such 
file or directory)
addr2line_init failed for /lib/arm-linux-gnueabihf/libc-2.19.so
     0.25%     0.25%  [.] 0x000000000005336c       libc-2.19.so[5336c]
     0.25%     0.00%  [.] 0xffffffff4936136c       
libc-2.19.so[ffffffff4936136
     0.24%     0.24%  [.] 0x0000000000053422       libc-2.19.so[53422]
     0.24%     0.00%  [.] 0xffffffff49361422       
libc-2.19.so[ffffffff4936142
     0.21%     0.21%  [.] 0x0000000000053664       libc-2.19.so[53664]
     0.21%     0.00%  [.] 0xffffffff49361664       
libc-2.19.so[ffffffff4936166
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Setting symfs:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
milian@milian-kdab2:/tmp$ locate libc-2.19.so
/home/milian/.debug/lib/arm-linux-gnueabihf/libc-2.19.so
/home/milian/.debug/lib/arm-linux-gnueabihf/libc-2.19.so/
457c5918872338e1b82bf8bf41ae9f55b34604ea
/home/milian/.debug/lib/arm-linux-gnueabihf/libc-2.19.so/
457c5918872338e1b82bf8bf41ae9f55b34604ea/elf
/home/milian/.debug/lib/arm-linux-gnueabihf/libc-2.19.so/
457c5918872338e1b82bf8bf41ae9f55b34604ea/probes
/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06/lib/arm-
linux-gnueabihf/libc-2.19.so
milian@milian-kdab2:/tmp$ strace -e file -f perf report --symfs=/ssd/milian/
projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06/ --stdio -s 
sym,srcline |& grep libc-2.19
open("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = 8
stat("/lib/arm-linux-gnueabihf/libc-2.19.so", 0x7ffc4da5e740) = -1 ENOENT (No 
such file or directory)
stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
lib/arm-linux-gnueabihf/libc-2.19.so", {st_mode=S_IFREG|0755, st_size=911068, 
...}) = 0
open("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = 9
stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
lib/arm-linux-gnueabihf/libc-2.19.so", {st_mode=S_IFREG|0755, st_size=911068, 
...}) = 0
open("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = 9
stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
usr/lib/debug/lib/arm-linux-gnueabihf/libc-2.19.so.debug", 0x7ffc4da5e740) = 
-1 ENOENT (No such file or directory)
stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
usr/lib/debug/lib/arm-linux-gnueabihf/libc-2.19.so", 0x7ffc4da5e740) = -1 
ENOENT (No such file or directory)
stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
lib/arm-linux-gnueabihf/libc-2.19.so", {st_mode=S_IFREG|0755, st_size=911068, 
...}) = 0
open("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = 10
stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
lib/arm-linux-gnueabihf/.debug/libc-2.19.so", 0x7ffc4da5e740) = -1 ENOENT (No 
such file or directory)
open("/lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = -1 ENOENT (No such 
file or directory)
addr2line_init failed for /lib/arm-linux-gnueabihf/libc-2.19.so
open("/lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = -1 ENOENT (No such 
file or directory)
addr2line_init failed for /lib/arm-linux-gnueabihf/libc-2.19.so
open("/lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = -1 ENOENT (No such 
file or directory)
addr2line_init failed for /lib/arm-linux-gnueabihf/libc-2.19.so
open("/lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = -1 ENOENT (No such 
file or directory)
addr2line_init failed for /lib/arm-linux-gnueabihf/libc-2.19.so
open("/lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = -1 ENOENT (No such 
file or directory)
addr2line_init failed for /lib/arm-linux-gnueabihf/libc-2.19.so
open("/lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = -1 ENOENT (No such 
file or directory)
addr2line_init failed for /lib/arm-linux-gnueabihf/libc-2.19.so
     0.25%     0.25%  [.] 0x000000000005336c  libc-2.19.so[5336c]
     0.25%     0.00%  [.] 0xffffffff4936136c  libc-2.19.so[ffffffff4936136
     0.24%     0.24%  [.] 0x0000000000053422  libc-2.19.so[53422]
     0.24%     0.00%  [.] 0xffffffff49361422  libc-2.19.so[ffffffff4936142
     0.21%     0.21%  [.] 0x0000000000053664  libc-2.19.so[53664]
     0.21%     0.00%  [.] 0xffffffff49361664  libc-2.19.so[ffffffff4936166
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Note how it does look into symfs sometimes, but not everywhere...

To make things worse, it seems to break the buildid lookup, i.e. when you get 
samples in a file that you deployed manually to a target, which is not 
included in your sysroot that you pass to symfs:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ perf report --stdio -s sym,srcline |& grep particles
    34.79%    34.79%  [.] main                     particles.cpp:34
    32.62%    32.62%  [.] main                     particles.cpp:33
     9.85%     9.85%  [.] main                     particles.cpp:32
$ perf report --symfs=/ssd/milian/projects/pandaboard/debian-8.5-minimal-
armhf-2016-06-06/ --stdio -s sym,srcline |& grep particles
/root/particles with build id 1c10a17afa25337ab368f8d9e690184e536c6563 not 
found, continuing without symbols
addr2line_init failed for /root/particles
# above line is repeated a lot
    26.99%    26.99%  [.] 0x00000000000005a4  particles[5a4]
    26.99%     0.00%  [.] 0xffffffffffff05a4  particles[ffffffffffff05a4]
    21.83%    21.83%  [.] 0x00000000000005a6  particles[5a6]
    21.83%     0.00%  [.] 0xffffffffffff05a6  particles[ffffffffffff05a6]
    14.55%     0.00%  [.] 0xffffffffffff0596  particles[ffffffffffff0596]
    14.54%    14.54%  [.] 0x0000000000000596  particles[596]
...
$ strace -e file -f perf report --symfs=/ssd/milian/projects/pandaboard/
debian-8.5-minimal-armhf-2016-06-06/ --stdio -s sym,srcline |& grep particles 

open("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
root/particles", O_RDONLY) = -1 ENOENT (No such file or directory)
stat("/root/particles", 0x7ffe7535bf40) = -1 EACCES (Permission denied)
stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
root/particles", 0x7ffe7535bec0) = -1 ENOENT (No such file or directory)
stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
usr/lib/debug/root/particles.debug", 0x7ffe7535bf40) = -1 ENOENT (No such file 
or directory)
stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
usr/lib/debug/root/particles", 0x7ffe7535bf40) = -1 ENOENT (No such file or 
directory)
stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
root/particles", 0x7ffe7535bf40) = -1 ENOENT (No such file or directory)
stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
root/.debug/particles", 0x7ffe7535bf40) = -1 ENOENT (No such file or 
directory)
/root/particles with build id 1c10a17afa25337ab368f8d9e690184e536c6563 not 
found, continuing without symbols
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Note how the above does not look for the buildid in my ~/.debug anymore...

Cheers
-- 
Milian Wolff | milian.wolff@kdab.com | Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
--nextPart2155981.m03nQMB48J
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
DTE2MDgxNTEyMjAxNVowIwYJKoZIhvcNAQkEMRYEFDwNf8T6cx2c7SCkmWYYg2wgL4XwMCgGCSqG
SIb3DQEJDzEbMBkwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBAQUABIIBAI4k
5aubBPMd0S6MFF5kJ7smdRvqYvcNGoPDqRg3epRsGdd/WXFvGd1TuNH6eLsGK4pYY2r07w0IzY7G
TC1U4pxmbsNjIvB+iM33O3/++lLHyRETX+nwkyuY8bBYSJQM8iQx0hEcWi4vXDf+FD9t46APhZ0K
6s/BJYZEivm/nrgbA/wG0OjBQt6kDWBCXAgKW9NtZ0qEzdKufej++T5hVT5XYc8xGHwOkJxbPDMZ
9qM8rWhpaX4Z5C9Z7DoD5uQeI0CE6Ut4x8T6IQ4MSLl0bUqTSVKPnxjX+XJ/BnMWtCo0sAQwniVq
h9TVQ/2oi762LkuSIXZC7Xi3b4CN+yX5kpQAAAAAAAA=


--nextPart2155981.m03nQMB48J--
