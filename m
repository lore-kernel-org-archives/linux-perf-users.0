Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F22C337115
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Nov 2025 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362460; cv=none; b=r3jDH4ukej6w8KUD11Ek21V42hHkom8yCRYv4hL/mc5mO2gNIlAssUJkoSCgIhv/aVWNLL2q9kcQT+4r/Bhdze3ivYBZHnsTZOV3+S7kQB/hhdp5e9g9AF4s4PPJ/ymOHtIbvoMje4Mmm1sFX3pB5pSfg/MXJ1aoHIF5qLr/Vwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362460; c=relaxed/simple;
	bh=mSVW7NfzeLTLR7j91YmYSVmzXmA8TKjps7xIbiWTwKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9KdjohKtXAyLK7JDSlEpsgI3Ngx72tXoRG/HAegmEjMzheqay/ikdHcpSHsJ1reN8SNinbD7h7EVCVd/2B36VqUks4/aSk27G/1rVRpLMMI4khSM4Lhe0WFAVtvb1YW25pRZy3h2jrGjKwrd1PHUmM1RVBd0jnlb8EAc9KZHMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KvmbjbBT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KvmbjbBT"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2959197b68eso96425ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Nov 2025 09:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762362458; x=1762967258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQMK21Ynz/Elulfrn6LOY7sanlJgcibrbQM3/PEN7VY=;
        b=KvmbjbBTyR/AkXcn1HzUPhDUKRDVAfIPYvzxgvW/kTGYDhMGUzpcHQW9SBSosAyMlg
         h4UMhjM2/QLCbgXyJm+/SZc5/ZBNyMnQ0qsaxwRZnmQzwZOopTKa2lchOrzqgRNvloyY
         brcJiPESTfxHbBBbAT+Bk3tIregmgXwZEVxvlRvBKDeUhAWY5vrI7xpDDgqKqVI+w9+4
         agKxvZufrM66iANTGQEybPJ8wHZY1PE1I0HNC0THJNTbn09SqZm/Xo2mwAOCM9D/dSjG
         /CZH2fqKXIm1fCMTwzvw01f5FMjFRS2IRC0NKDrh0oV5OKeYMz598eIY0/r5jGbQ1Rdz
         SVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362458; x=1762967258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lQMK21Ynz/Elulfrn6LOY7sanlJgcibrbQM3/PEN7VY=;
        b=P+KwgflCRPBuC92cLUUCO+Aagodr25tTN429gylPX0/tqynZ/Mkptcb79ELxGjoJqE
         bIZKPo4nlF0CFHQ4EODDiLgKb/QiewJuQnrKBbMiNbvT7E/VpNH2Bm6XplK9QQ1EFtQO
         BJymMy1Xp4TS4JMQwV4Y0MNPv4H7ULEYKM/aFeAucw1yi639+FTl5PpYLBo2Yjt5N2Kc
         wQ2izfOkoMHNLeWUnatdD0PeFjJSLtqV8g9UBtElJj2J4ad3KdHVdXNZ79s+HXuwD/UC
         mCRLYCQ1R4AhwlSNAkKejEhA6a06mMxeBQUKzGkbdJ0Nu9JXKyzkAvTK1TUFjLniwu5B
         lNBg==
X-Forwarded-Encrypted: i=1; AJvYcCW3jqkJLKMauZx1YC/pFK2NToQnkCsQKGZ1rkrLn7ZMb0TqU1SwWwBYlm/7M9nuXA63gwzzha6GV1/0zAR91brd@vger.kernel.org
X-Gm-Message-State: AOJu0YxhGgAVz5cIt4PuPP5aIHLCqho4MyIzXuRtQJ5jtnrw4Sp/+Cgc
	+p3fh5emKHhvevwZCcrp+7bZeMjcBqo406bI32bC6IvZmvSh0zOT9XXumSjjezHRG69rIqVztZ8
	unHXK1UzH2guPtCU342tOrT9JKZ5oaAoCWaxUDp5K
X-Gm-Gg: ASbGnctMYK6VOyGVw4ODmsLzE/aFeyfy8piFzel81m0Dv4F6XihrNYVMzdmh7xlfa7k
	ElTLh1EiJgOkJ2z71jVv5uue8OSYChLIhz0kXqMWhKuACoTMd3ZS2OgCeqnmwlsLj1j4/hiDJUx
	Jm24UGsKsYRlznOZFE/nUb+O+S/82dD9UEjupugcqOhCxDNPRmLmd2qYSbrP2yHiO4vKFh756Bj
	dzmLU9ji2g+jYY799ayvqpDu/tqqpBr+ScbrRyZpHOSyUzuKO2R6M855ThD9i1nBInUVZnlXhv8
	uhAoMo010LzKIRw=
X-Google-Smtp-Source: AGHT+IEA0vRF3ExI4utuwWh94iClHkfpv9qlNz9cnPbzUlfrey1Iw56nRYwmHPYVRYNudYPQD3xAJEzczoXtGNchFSM=
X-Received: by 2002:a17:902:f545:b0:26a:befc:e7e1 with SMTP id
 d9443c01a7336-29631395060mr6126925ad.12.1762362457131; Wed, 05 Nov 2025
 09:07:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQt66zhfxSA80xwt@gentoo.org>
In-Reply-To: <aQt66zhfxSA80xwt@gentoo.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Nov 2025 09:07:23 -0800
X-Gm-Features: AWmQ_blhOE_BiTpvlGdoqDsRYwbK-rKyKmMwuP-uvht6Jkav_bUDCniH_XefVSA
Message-ID: <CAP-5=fX-Z6cKX30TRNYQLnYHzDSaY-yw56BZwk8db0_R3_mcNQ@mail.gmail.com>
Subject: Re: Crash when running perf top with perf-6.17.7
To: Guilherme Amadio <amadio@gentoo.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 8:36=E2=80=AFAM Guilherme Amadio <amadio@gentoo.org>=
 wrote:
>
> Hi Arnaldo,
>
> After updating to perf-6.17.7, perf top crashes for me (seems to happen
> since perf-6.17, but doesn't happen with perf-6.16):
>
> gentoo perf $ perf top
> perf: Segmentation fault
> -------- backtrace --------
> perf: Segmentation fault
> -------- backtrace --------
> Segmentation fault         (core dumped) perf top
>
> The stack trace from the crash is below. If this is not enough informatio=
n,
> please let me know what additional information you'd like to have.

This is a BUILD_NONDISTRO=3D1 build that is default off and
non-distributable as libbfd is incompatible with perf's GPLv2 license.
I think the perf libbfd code should just be deleted so we can focus
energy on distributable code.

Most recently the libbfd code was factored into its own file:
https://lore.kernel.org/lkml/20250929190805.201446-5-irogers@google.com/
we still don't have the dlopen support:
https://lore.kernel.org/lkml/20251007163835.3152881-1-irogers@google.com/
even though shipping with libLLVM/capstone linked (ie not dlopen)
isn't possible in distributions like SuSE:
https://lore.kernel.org/linux-perf-users/aPkivW2WoySU1Zkc@suse.de/
For addr2line the fallback options are fairly clear (LLVM first, then
libbfd then the forked command):
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/srcline.c?h=3Dperf-tools-next#n117
there should probably be a similar clean up for read build id. That
said, the symbol-minimal.c code:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/symbol-minimal.c?h=3Dperf-tools-next#n33
has no library or forked tool dependencies, so perhaps we can just use
this for all our build ID needs.

I'll see if there's a cleanup for read build id similar to the
addr2line cleanup that can be done and try to fix the libbfd
implementation in the process. However, as I said at the top, this
would be less work if we just delete the code. Do people really care
if a build ID, line number of objdump was provided to them by libbfd?
I suspect I've introduced this regression by making build ID mmaps the
default, anyway...

Thanks,
Ian


> Best regards,
> -Guilherme
>
> Core was generated by `perf top'.
> Program terminated with signal SIGSEGV, Segmentation fault.
> #0  close_one () at /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binu=
tils-2.45/bfd/cache.c:197
>
> warning: 197    /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binutils=
-2.45/bfd/cache.c: No such file or directory
> [Current thread is 1 (Thread 0x7f8769c466c0 (LWP 144140))]
> (gdb) bt
> #0  close_one () at /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binu=
tils-2.45/bfd/cache.c:197
> #1  0x00007f87885286dd in _bfd_cache_init_unlocked (abfd=3Dabfd@entry=3D0=
x5567f738eb40) at /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binutils=
-2.45/bfd/cache.c:561
> #2  0x00007f8788529021 in bfd_cache_init (abfd=3Dabfd@entry=3D0x5567f738e=
b40) at /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binutils-2.45/bfd/=
cache.c:587
> #3  0x00007f878853618a in bfd_fopen (filename=3Dfilename@entry=3D0x7f8769=
c3fa98 "/usr/bin/perf", target=3Dtarget@entry=3D0x0, mode=3D0x7f878860c4b9 =
"r", fd=3D84)
>     at /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binutils-2.45/bfd=
/opncls.c:291
> #4  0x00007f87885363c9 in bfd_fdopenr (filename=3Dfilename@entry=3D0x7f87=
69c3fa98 "/usr/bin/perf", target=3Dtarget@entry=3D0x0, fd=3D<optimized out>=
)
>     at /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binutils-2.45/bfd=
/opncls.c:407
> #5  0x00005567c5cf4436 in read_build_id (filename=3Dfilename@entry=3D0x7f=
8769c3fa98 "/usr/bin/perf", bid=3Dbid@entry=3D0x7f8769c3d8f0, block=3Dblock=
@entry=3Dfalse)
>     at util/symbol-elf.c:886
> #6  0x00005567c5cf7240 in filename__read_build_id (filename=3Dfilename@en=
try=3D0x7f8769c3fa98 "/usr/bin/perf", bid=3Dbid@entry=3D0x7f8769c3d8f0, blo=
ck=3Dblock@entry=3Dfalse)
>     at util/symbol-elf.c:968
> #7  0x00005567c5caaba4 in perf_record_mmap2__read_build_id (event=3Devent=
@entry=3D0x7f8769c3fa50, machine=3Dmachine@entry=3D0x5567f7392a00, is_kerne=
l=3Dis_kernel@entry=3Dfalse)
>     at util/synthetic-events.c:404
> #8  0x00005567c5cabff2 in perf_event__synthesize_mmap_events (tool=3Dtool=
@entry=3D0x0, event=3Devent@entry=3D0x7f8769c3fa50, pid=3Dpid@entry=3D14407=
6, tgid=3Dtgid@entry=3D144076,
>     process=3Dprocess@entry=3D0x5567c5c5d491 <mmap_handler>, machine=3Dma=
chine@entry=3D0x5567f7392a00, mmap_data=3Dtrue) at util/synthetic-events.c:=
536
> #9  0x00005567c5c598fb in machine__init_live (machine=3Dmachine@entry=3D0=
x5567f7392a00, pid=3Dpid@entry=3D144076) at util/machine.c:167
> #10 0x00005567c5c5b987 in machine__new_live (host_env=3Dhost_env@entry=3D=
0x7f8769c40b70, kernel_maps=3Dkernel_maps@entry=3Dfalse, pid=3Dpid@entry=3D=
144076) at util/machine.c:178
> #11 0x00005567c5c56b13 in __dump_stack (file=3D0x7f87887f25c0 <_IO_2_1_st=
dout_>, stackdump=3Dstackdump@entry=3D0x7f8769c40d90, stackdump_size=3D15) =
at util/debug.c:318
> #12 0x00005567c5bfb299 in ui__signal_backtrace (sig=3D<optimized out>) at=
 ui/tui/setup.c:111
> #13 <signal handler called>
> #14 close_one () at /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binu=
tils-2.45/bfd/cache.c:197
> #15 0x00007f87885286dd in _bfd_cache_init_unlocked (abfd=3Dabfd@entry=3D0=
x5567f738e8c0) at /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binutils=
-2.45/bfd/cache.c:561
> #16 0x00007f8788529021 in bfd_cache_init (abfd=3Dabfd@entry=3D0x5567f738e=
8c0) at /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binutils-2.45/bfd/=
cache.c:587
> #17 0x00007f878853618a in bfd_fopen (filename=3Dfilename@entry=3D0x5567f7=
3ca048 "/usr/lib64/libfribidi.so.0.4.0", target=3Dtarget@entry=3D0x0, mode=
=3D0x7f878860c4b9 "r", fd=3D63)
>     at /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binutils-2.45/bfd=
/opncls.c:291
> #18 0x00007f87885363c9 in bfd_fdopenr (filename=3Dfilename@entry=3D0x5567=
f73ca048 "/usr/lib64/libfribidi.so.0.4.0", target=3Dtarget@entry=3D0x0, fd=
=3D<optimized out>)
>     at /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binutils-2.45/bfd=
/opncls.c:407
> #19 0x00005567c5cf4436 in read_build_id (filename=3Dfilename@entry=3D0x55=
67f73ca048 "/usr/lib64/libfribidi.so.0.4.0", bid=3Dbid@entry=3D0x7f8769c425=
d0, block=3Dblock@entry=3Dfalse)
>     at util/symbol-elf.c:886
> #20 0x00005567c5cf7240 in filename__read_build_id (filename=3Dfilename@en=
try=3D0x5567f73ca048 "/usr/lib64/libfribidi.so.0.4.0", bid=3Dbid@entry=3D0x=
7f8769c425d0,
>     block=3Dblock@entry=3Dfalse) at util/symbol-elf.c:968
> #21 0x00005567c5caaba4 in perf_record_mmap2__read_build_id (event=3Devent=
@entry=3D0x5567f73ca000, machine=3Dmachine@entry=3D0x5567f7280b18, is_kerne=
l=3Dis_kernel@entry=3Dfalse)
>     at util/synthetic-events.c:404
> #22 0x00005567c5cabff2 in perf_event__synthesize_mmap_events (tool=3Dtool=
@entry=3D0x0, event=3Devent@entry=3D0x5567f73ca000, pid=3Dpid@entry=3D5227,=
 tgid=3D5227,
>     process=3Dprocess@entry=3D0x5567c5c19264 <perf_event__process>, machi=
ne=3Dmachine@entry=3D0x5567f7280b18, mmap_data=3Dfalse) at util/synthetic-e=
vents.c:536
> #23 0x00005567c5cac2a5 in __event__synthesize_thread (comm_event=3Dcomm_e=
vent@entry=3D0x5567f73c8060, mmap_event=3Dmmap_event@entry=3D0x5567f73ca000=
,
>     fork_event=3Dfork_event@entry=3D0x5567f73c8080, namespaces_event=3Dna=
mespaces_event@entry=3D0x5567f7246870, pid=3D5227, full=3Dfull@entry=3D1,
>     process=3D0x5567c5c19264 <perf_event__process>, tool=3D0x0, machine=
=3D0x5567f7280b18, needs_mmap=3Dtrue, mmap_data=3Dfalse) at util/synthetic-=
events.c:851
> #24 0x00005567c5cac50d in __perf_event__synthesize_threads (tool=3D0x0, p=
rocess=3D0x5567c5c19264 <perf_event__process>, machine=3D0x5567f7280b18, ne=
eds_mmap=3Dtrue,
>     mmap_data=3Dfalse, dirent=3D0x5567f7377400, start=3D475, num=3D19) at=
 util/synthetic-events.c:986
> #25 0x00005567c5cac5c4 in synthesize_threads_worker (arg=3D<optimized out=
>) at util/synthetic-events.c:1018
> #26 0x00007f87886c0379 in start_thread (arg=3D<optimized out>) at pthread=
_create.c:448
> #27 0x00007f8788728fac in __GI___clone3 () at ../sysdeps/unix/sysv/linux/=
x86_64/clone3.S:78
>
>
