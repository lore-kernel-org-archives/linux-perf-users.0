From: Mauro Andreolini <mauro.andreolini@gmail.com>
Subject: Re: Two questions on perf dwarf callchains
Date: Mon, 03 Feb 2014 15:30:56 +0100
Message-ID: <1391437856.1135.8.camel@nb-andreolini.mat.unimo.it>
References: <1389954083.1125.23.camel@nb-andreolini.mat.unimo.it>
	 <20140129111844.GA1869@krava.brq.redhat.com>
	 <1391008146.1316.8.camel@nb-andreolini.mat.unimo.it>
	 <20140130114751.GB1161@krava.brq.redhat.com>
	 <1391092999.1111.3.camel@nb-andreolini.mat.unimo.it>
	 <20140130154047.GB1827@krava.brq.redhat.com>
Reply-To: mauro.andreolini@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:42735 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbaBCObB (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 3 Feb 2014 09:31:01 -0500
Received: by mail-ee0-f51.google.com with SMTP id b57so3692904eek.38
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2014 06:31:00 -0800 (PST)
In-Reply-To: <20140130154047.GB1827@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-perf-users@vger.kernel.org

> I use elfutils git tree ;-)
> git://git.fedorahosted.org/git/elfutils.git
Installed fine.

> and the latest patchset (recently rebased) is in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/core_libdw_unwind
Pulled the repo, switched branch to core_libdw_unwind, recompiled
the kernel and rebooted fine. When I try to compile perf
(make tools/perf NO_LIBUNWIND=3D1 PYTHON=3D/usr/bin/python2) I get this
error message, though:

    CHK -fstack-protector-all
    CHK -Wstack-protector
    CHK -Wvolatile-register-var
    CHK bionic
    CHK libelf
    CHK libdw
    CHK -DLIBELF_MMAP
    CHK libaudit
    CHK libnewt
    CHK gtk2
    CHK -DHAVE_GTK_INFO_BAR
    CHK perl
    CHK python
    CHK python version
    CHK libbfd
    CHK liberty
    CHK libz
    CHK demangle
    CHK -DHAVE_STRLCPY
    CHK -DHAVE_ON_EXIT
    CHK -DBACKTRACE_SUPPORT
    CHK libnuma
    * new build flags or prefix
PERF_VERSION =3D 3.9.rc2.g7c6baa
=2E..
[SNIP make output]
=2E..
In file included from util/scripting-engines/trace-event-perl.c:30:0:
/usr/lib/perl5/core_perl/CORE/perl.h:548:5: error:
"SILENT_NO_TAINT_SUPPORT" is not defined [-Werror=3Dundef]
 #if SILENT_NO_TAINT_SUPPORT && !defined(NO_TAINT_SUPPORT)
     ^
/usr/lib/perl5/core_perl/CORE/perl.h:556:5: error: "NO_TAINT_SUPPORT" i=
s
not defined [-Werror=3Dundef]
 #if NO_TAINT_SUPPORT
     ^
In file included from /usr/lib/perl5/core_perl/CORE/perl.h:3471:0,
                 from util/scripting-engines/trace-event-perl.c:30:
/usr/lib/perl5/core_perl/CORE/sv.h:1455:5: error: "NO_TAINT_SUPPORT" is
not defined [-Werror=3Dundef]
 #if NO_TAINT_SUPPORT
     ^
In file included from /usr/lib/perl5/core_perl/CORE/perl.h:3472:0,
                 from util/scripting-engines/trace-event-perl.c:30:
/usr/lib/perl5/core_perl/CORE/regexp.h:436:5: error: "NO_TAINT_SUPPORT"
is not defined [-Werror=3Dundef]
 #if NO_TAINT_SUPPORT
     ^
In file included from /usr/lib/perl5/core_perl/CORE/hv.h:593:0,
                 from /usr/lib/perl5/core_perl/CORE/perl.h:3480,
                 from util/scripting-engines/trace-event-perl.c:30:
/usr/lib/perl5/core_perl/CORE/hv_func.h: In function
=E2=80=98S_perl_hash_siphash_2_4=E2=80=99:
/usr/lib/perl5/core_perl/CORE/hv_func.h:222:3: error: switch missing
default case [-Werror=3Dswitch-default]
   switch( left )
   ^
/usr/lib/perl5/core_perl/CORE/hv_func.h: In function
=E2=80=98S_perl_hash_superfast=E2=80=99:
/usr/lib/perl5/core_perl/CORE/hv_func.h:274:5: error: switch missing
default case [-Werror=3Dswitch-default]
     switch (rem) { \
     ^
/usr/lib/perl5/core_perl/CORE/hv_func.h: In function
=E2=80=98S_perl_hash_murmur3=E2=80=99:
/usr/lib/perl5/core_perl/CORE/hv_func.h:398:5: error: switch missing
default case [-Werror=3Dswitch-default]
     switch(bytes_in_carry) { /* how many bytes in carry */
     ^
cc1: all warnings being treated as errors
make: *** [util/scripting-engines/trace-event-perl.o] Errore 1

Mauro
