Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C606302742;
	Thu,  6 Nov 2025 19:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762456747; cv=none; b=LWuq09NOK+0n+Rt7gK/K8c9tW/yqGHhIdOq9NFUioMreTZbAoh63CsuxQZbeK5//jtlXb5enZap6g6mELoIUQpnGcgnOHWl0Vh3IiedpPr0GUHXdIGNzqRwivdWxcBReIV3J1hbL6Pn1ChQHYdgpFxHlZUUvq6AV4u3iQvHIH7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762456747; c=relaxed/simple;
	bh=BGS5XBZ9SofT+k6xatjSITkWE9+3RxIFgRP/+ftjogw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJ4zuyMFgSmNMXfocpOTN1QRpLNrIwEnW7Um/XjsWdjv7wU95LKOxXhaQiWJWRqF7XHARPHZJUUvuj/H5BvCKwlOGBR21+weS/1z9dNUZlmU2KfSzhQjbGr8qt5PT7cQJ72MO4eMEW7vGJAt08vZcdoByst3ZL4Z4WAWuItKGWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpM19gS1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpM19gS1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FC7C16AAE;
	Thu,  6 Nov 2025 19:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762456746;
	bh=BGS5XBZ9SofT+k6xatjSITkWE9+3RxIFgRP/+ftjogw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bpM19gS1g9ba5YHcamOlwfX6wpNqd5AYXZv28AFNE+ZW0di/yCj8mdKabrv6iE3k8
	 Az5P9rgdf/ESjkZg6rePSiJ3nMingL1XCS7O+2t6kecnSUShvzvTwZ5Ci1xlxpl72x
	 W5QkS504XaNNhaZ+T1exnb43BTKwiDpRt48VTXn7aaXPo7gHoSUKTMaeFDliZn4RMG
	 25OVwRCub5968MQZ0mB9/PJkGT/4+ZvgIlmitq2f31ulLQqjmEMrj3qzj4tYcDQvbq
	 JYsjuP6lwMthOEvFdw26SqeZC2fH6GDcWzJGXr1Y0+mIBYC6hzPGHti0TZ46QJwfQa
	 GvVWopbcerrRA==
Date: Thu, 6 Nov 2025 11:19:03 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Guilherme Amadio <amadio@gentoo.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: Crash when running perf top with perf-6.17.7
Message-ID: <aQz0pwBSEHfkMBZX@google.com>
References: <aQt66zhfxSA80xwt@gentoo.org>
 <CAP-5=fX-Z6cKX30TRNYQLnYHzDSaY-yw56BZwk8db0_R3_mcNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX-Z6cKX30TRNYQLnYHzDSaY-yw56BZwk8db0_R3_mcNQ@mail.gmail.com>

On Wed, Nov 05, 2025 at 09:07:23AM -0800, Ian Rogers wrote:
> On Wed, Nov 5, 2025 at 8:36 AM Guilherme Amadio <amadio@gentoo.org> wrote:
> >
> > Hi Arnaldo,
> >
> > After updating to perf-6.17.7, perf top crashes for me (seems to happen
> > since perf-6.17, but doesn't happen with perf-6.16):
> >
> > gentoo perf $ perf top
> > perf: Segmentation fault
> > -------- backtrace --------
> > perf: Segmentation fault
> > -------- backtrace --------
> > Segmentation fault         (core dumped) perf top
> >
> > The stack trace from the crash is below. If this is not enough information,
> > please let me know what additional information you'd like to have.
> 
> This is a BUILD_NONDISTRO=1 build that is default off and
> non-distributable as libbfd is incompatible with perf's GPLv2 license.
> I think the perf libbfd code should just be deleted so we can focus
> energy on distributable code.
> 
> Most recently the libbfd code was factored into its own file:
> https://lore.kernel.org/lkml/20250929190805.201446-5-irogers@google.com/
> we still don't have the dlopen support:
> https://lore.kernel.org/lkml/20251007163835.3152881-1-irogers@google.com/
> even though shipping with libLLVM/capstone linked (ie not dlopen)
> isn't possible in distributions like SuSE:
> https://lore.kernel.org/linux-perf-users/aPkivW2WoySU1Zkc@suse.de/
> For addr2line the fallback options are fairly clear (LLVM first, then
> libbfd then the forked command):
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/srcline.c?h=perf-tools-next#n117
> there should probably be a similar clean up for read build id. That
> said, the symbol-minimal.c code:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/symbol-minimal.c?h=perf-tools-next#n33
> has no library or forked tool dependencies, so perhaps we can just use
> this for all our build ID needs.
> 
> I'll see if there's a cleanup for read build id similar to the
> addr2line cleanup that can be done and try to fix the libbfd
> implementation in the process. However, as I said at the top, this
> would be less work if we just delete the code. Do people really care
> if a build ID, line number of objdump was provided to them by libbfd?
> I suspect I've introduced this regression by making build ID mmaps the
> default, anyway...

Looks like a problem in libbfd.  Why does it crash when reading
build-ID?  A thread-safety problem?

Thanks,
Namhyung

> >
> > Core was generated by `perf top'.
> > Program terminated with signal SIGSEGV, Segmentation fault.
> > #0  close_one () at /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binutils-2.45/bfd/cache.c:197
> >
> > warning: 197    /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binutils-2.45/bfd/cache.c: No such file or directory
> > [Current thread is 1 (Thread 0x7f8769c466c0 (LWP 144140))]
> > (gdb) bt
> > #0  close_one () at /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binutils-2.45/bfd/cache.c:197
> > #1  0x00007f87885286dd in _bfd_cache_init_unlocked (abfd=abfd@entry=0x5567f738eb40) at /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binutils-2.45/bfd/cache.c:561
> > #2  0x00007f8788529021 in bfd_cache_init (abfd=abfd@entry=0x5567f738eb40) at /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binutils-2.45/bfd/cache.c:587
> > #3  0x00007f878853618a in bfd_fopen (filename=filename@entry=0x7f8769c3fa98 "/usr/bin/perf", target=target@entry=0x0, mode=0x7f878860c4b9 "r", fd=84)
> >     at /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binutils-2.45/bfd/opncls.c:291
> > #4  0x00007f87885363c9 in bfd_fdopenr (filename=filename@entry=0x7f8769c3fa98 "/usr/bin/perf", target=target@entry=0x0, fd=<optimized out>)
> >     at /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binutils-2.45/bfd/opncls.c:407
> > #5  0x00005567c5cf4436 in read_build_id (filename=filename@entry=0x7f8769c3fa98 "/usr/bin/perf", bid=bid@entry=0x7f8769c3d8f0, block=block@entry=false)
> >     at util/symbol-elf.c:886
> > #6  0x00005567c5cf7240 in filename__read_build_id (filename=filename@entry=0x7f8769c3fa98 "/usr/bin/perf", bid=bid@entry=0x7f8769c3d8f0, block=block@entry=false)
> >     at util/symbol-elf.c:968
> > #7  0x00005567c5caaba4 in perf_record_mmap2__read_build_id (event=event@entry=0x7f8769c3fa50, machine=machine@entry=0x5567f7392a00, is_kernel=is_kernel@entry=false)
> >     at util/synthetic-events.c:404
> > #8  0x00005567c5cabff2 in perf_event__synthesize_mmap_events (tool=tool@entry=0x0, event=event@entry=0x7f8769c3fa50, pid=pid@entry=144076, tgid=tgid@entry=144076,
> >     process=process@entry=0x5567c5c5d491 <mmap_handler>, machine=machine@entry=0x5567f7392a00, mmap_data=true) at util/synthetic-events.c:536
> > #9  0x00005567c5c598fb in machine__init_live (machine=machine@entry=0x5567f7392a00, pid=pid@entry=144076) at util/machine.c:167
> > #10 0x00005567c5c5b987 in machine__new_live (host_env=host_env@entry=0x7f8769c40b70, kernel_maps=kernel_maps@entry=false, pid=pid@entry=144076) at util/machine.c:178
> > #11 0x00005567c5c56b13 in __dump_stack (file=0x7f87887f25c0 <_IO_2_1_stdout_>, stackdump=stackdump@entry=0x7f8769c40d90, stackdump_size=15) at util/debug.c:318
> > #12 0x00005567c5bfb299 in ui__signal_backtrace (sig=<optimized out>) at ui/tui/setup.c:111
> > #13 <signal handler called>
> > #14 close_one () at /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binutils-2.45/bfd/cache.c:197
> > #15 0x00007f87885286dd in _bfd_cache_init_unlocked (abfd=abfd@entry=0x5567f738e8c0) at /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binutils-2.45/bfd/cache.c:561
> > #16 0x00007f8788529021 in bfd_cache_init (abfd=abfd@entry=0x5567f738e8c0) at /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binutils-2.45/bfd/cache.c:587
> > #17 0x00007f878853618a in bfd_fopen (filename=filename@entry=0x5567f73ca048 "/usr/lib64/libfribidi.so.0.4.0", target=target@entry=0x0, mode=0x7f878860c4b9 "r", fd=63)
> >     at /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binutils-2.45/bfd/opncls.c:291
> > #18 0x00007f87885363c9 in bfd_fdopenr (filename=filename@entry=0x5567f73ca048 "/usr/lib64/libfribidi.so.0.4.0", target=target@entry=0x0, fd=<optimized out>)
> >     at /tmp/portage/sys-libs/binutils-libs-2.45-r1/work/binutils-2.45/bfd/opncls.c:407
> > #19 0x00005567c5cf4436 in read_build_id (filename=filename@entry=0x5567f73ca048 "/usr/lib64/libfribidi.so.0.4.0", bid=bid@entry=0x7f8769c425d0, block=block@entry=false)
> >     at util/symbol-elf.c:886
> > #20 0x00005567c5cf7240 in filename__read_build_id (filename=filename@entry=0x5567f73ca048 "/usr/lib64/libfribidi.so.0.4.0", bid=bid@entry=0x7f8769c425d0,
> >     block=block@entry=false) at util/symbol-elf.c:968
> > #21 0x00005567c5caaba4 in perf_record_mmap2__read_build_id (event=event@entry=0x5567f73ca000, machine=machine@entry=0x5567f7280b18, is_kernel=is_kernel@entry=false)
> >     at util/synthetic-events.c:404
> > #22 0x00005567c5cabff2 in perf_event__synthesize_mmap_events (tool=tool@entry=0x0, event=event@entry=0x5567f73ca000, pid=pid@entry=5227, tgid=5227,
> >     process=process@entry=0x5567c5c19264 <perf_event__process>, machine=machine@entry=0x5567f7280b18, mmap_data=false) at util/synthetic-events.c:536
> > #23 0x00005567c5cac2a5 in __event__synthesize_thread (comm_event=comm_event@entry=0x5567f73c8060, mmap_event=mmap_event@entry=0x5567f73ca000,
> >     fork_event=fork_event@entry=0x5567f73c8080, namespaces_event=namespaces_event@entry=0x5567f7246870, pid=5227, full=full@entry=1,
> >     process=0x5567c5c19264 <perf_event__process>, tool=0x0, machine=0x5567f7280b18, needs_mmap=true, mmap_data=false) at util/synthetic-events.c:851
> > #24 0x00005567c5cac50d in __perf_event__synthesize_threads (tool=0x0, process=0x5567c5c19264 <perf_event__process>, machine=0x5567f7280b18, needs_mmap=true,
> >     mmap_data=false, dirent=0x5567f7377400, start=475, num=19) at util/synthetic-events.c:986
> > #25 0x00005567c5cac5c4 in synthesize_threads_worker (arg=<optimized out>) at util/synthetic-events.c:1018
> > #26 0x00007f87886c0379 in start_thread (arg=<optimized out>) at pthread_create.c:448
> > #27 0x00007f8788728fac in __GI___clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78
> >
> >
