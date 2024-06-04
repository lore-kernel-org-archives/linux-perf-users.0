Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4AE8F45
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Jun 2024 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509000; cv=none; b=lG4BCJFRmduGE58M9vwNrtbaVEhKjPGqgyygd0u+3D9WSs+YbEoUpZHAWp1sA1cVwf0nsuv7zTw8yH1BRn9Ad2+5hXlPeo+woXxgz9jpHVFvFVCiaWT3CzZ16jQnl5kmAz+7OVYRf2XVyetX1KnGGOQsIUfkoswVyJ+RQLVnQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509000; c=relaxed/simple;
	bh=1tNsqaplAjXG/MnhrbHeGCpFNy3KebnjUiGnDiFF/eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBfDhqAJ2Td4Vg5EERSYvNjQRknqknQSZLOSRZ6ALqR7mHN45/0iPqBCg+W/1CVZuPd7XqR3iJ+5Nxxx8FFR4EWYVjeBtX2gdc+3RGUzBVNPkgDB4DQRMw2ncPxFZmVC+JNLYHzoWn2YOz1RQ1dx2puhl6s0mIoNeheO+HvfbBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DETe/sLK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DETe/sLK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B94C2BBFC;
	Tue,  4 Jun 2024 13:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717509000;
	bh=1tNsqaplAjXG/MnhrbHeGCpFNy3KebnjUiGnDiFF/eI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DETe/sLKPXJ4OcDLgmlJvwnYbCT8l+Zlg07s0viMm2XhwPdToMMh8tvwwTNGKZI6Q
	 1U9BMAz9TVDGmHEsFEt7an+IPcZ9JlAkG3QiQgKtsaeSvG7zucKzJWr/3jy80dsdFH
	 hDvxEDfefWk/Vt6yhGwsHyZGLwmoXhF+utu9Qq6TUyZGU3dmASSMT2/3N2yndvvabJ
	 9k576/miSXkk7MhXCD/YWn02lbp7rw4bx0PIC8VjTbnI64ZCqfmdY91hhQsoJu0zDl
	 wmJSQ61FGWEBWBMznCGzP0ILXrIiFh0eg7S5d12wo69l+1ulOaDsnGhyypqvZAqwo3
	 GRt4xyUL3BYtA==
Date: Tue, 4 Jun 2024 10:49:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kenel.org>
Subject: Re: perf 6.9-1 (archlinux) crashes during recording of cycles +
 raw_syscalls
Message-ID: <Zl8bhWfHSXxs35r2@x1>
References: <23879991.0LEYPuXRzz@milian-workstation>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23879991.0LEYPuXRzz@milian-workstation>

On Tue, Jun 04, 2024 at 01:44:18PM +0200, Milian Wolff wrote:
> Hey all,
> 
> the following command crashes perf for me, is this still an issue upstream and 
> should I report it to arch for backporting? I cannot build the official perf/
> core branch, so I am afraid I cannot test it myself there:
> 
> ```
> sudo /usr/bin/perf record -z --call-graph dwarf -e cycles -e 
> raw_syscalls:sys_enter ls
> ...
> [ perf record: Woken up 3 times to write data ]
> malloc(): invalid next size (unsorted)
> Aborted
> ```
> 
> Backtrace with GDB + debuginfod:
> ```
> malloc(): invalid next size (unsorted)

I reproduced this all the way back to 6.8, trying to bisect now, thanks
for the report,

- Arnaldo
 
> Thread 1 "perf" received signal SIGABRT, Aborted.
> __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, 
> no_tid=no_tid@entry=0) at pthread_kill.c:44
> Downloading source file /usr/src/debug/glibc/glibc/nptl/pthread_kill.c
> 44            return INTERNAL_SYSCALL_ERROR_P (ret) ? INTERNAL_SYSCALL_ERRNO 
> (ret) : 0;                                                                                                                                                                     
> (gdb) bt
> #0  __pthread_kill_implementation (threadid=<optimized out>, 
> signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
> #1  0x00007ffff6ea8eb3 in __pthread_kill_internal (threadid=<optimized out>, 
> signo=6) at pthread_kill.c:78
> #2  0x00007ffff6e50a30 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/
> raise.c:26
> #3  0x00007ffff6e384c3 in __GI_abort () at abort.c:79
> #4  0x00007ffff6e39354 in __libc_message_impl (fmt=fmt@entry=0x7ffff6fc22ea 
> "%s\n") at ../sysdeps/posix/libc_fatal.c:132
> #5  0x00007ffff6eb3085 in malloc_printerr (str=str@entry=0x7ffff6fc5850 
> "malloc(): invalid next size (unsorted)") at malloc.c:5772
> #6  0x00007ffff6eb657c in _int_malloc (av=av@entry=0x7ffff6ff6ac0 
> <main_arena>, bytes=bytes@entry=368) at malloc.c:4081
> #7  0x00007ffff6eb877e in __libc_calloc (n=<optimized out>, 
> elem_size=<optimized out>) at malloc.c:3754
> #8  0x000055555569bdb6 in perf_session.do_write_header ()
> #9  0x00005555555a373a in __cmd_record.constprop.0 ()
> #10 0x00005555555a6846 in cmd_record ()
> #11 0x000055555564db7f in run_builtin ()
> #12 0x000055555558ed77 in main ()
> ```
> 
> Valgrind memcheck:
> ```
> ==45136== Invalid write of size 8
> ==45136==    at 0x2B38A5: perf_event__synthesize_id_sample (in /usr/bin/perf)
> ==45136==    by 0x157069: __cmd_record.constprop.0 (in /usr/bin/perf)
> ==45136==    by 0x15A845: cmd_record (in /usr/bin/perf)
> ==45136==    by 0x201B7E: run_builtin (in /usr/bin/perf)
> ==45136==    by 0x142D76: main (in /usr/bin/perf)
> ==45136==  Address 0x6a866a8 is 0 bytes after a block of size 40 alloc'd
> ==45136==    at 0x4849BF3: calloc (vg_replace_malloc.c:1675)
> ==45136==    by 0x3574AB: zalloc (in /usr/bin/perf)
> ==45136==    by 0x1570E0: __cmd_record.constprop.0 (in /usr/bin/perf)
> ==45136==    by 0x15A845: cmd_record (in /usr/bin/perf)
> ==45136==    by 0x201B7E: run_builtin (in /usr/bin/perf)
> ==45136==    by 0x142D76: main (in /usr/bin/perf)
> ==45136== 
> ==45136== Syscall param write(buf) points to unaddressable byte(s)
> ==45136==    at 0x575953D: __libc_write (write.c:26)
> ==45136==    by 0x575953D: write (write.c:24)
> ==45136==    by 0x35761F: ion (in /usr/bin/perf)
> ==45136==    by 0x357778: writen (in /usr/bin/perf)
> ==45136==    by 0x1548F7: record__write (in /usr/bin/perf)
> ==45136==    by 0x15708A: __cmd_record.constprop.0 (in /usr/bin/perf)
> ==45136==    by 0x15A845: cmd_record (in /usr/bin/perf)
> ==45136==    by 0x201B7E: run_builtin (in /usr/bin/perf)
> ==45136==    by 0x142D76: main (in /usr/bin/perf)
> ==45136==  Address 0x6a866a8 is 0 bytes after a block of size 40 alloc'd
> ==45136==    at 0x4849BF3: calloc (vg_replace_malloc.c:1675)
> ==45136==    by 0x3574AB: zalloc (in /usr/bin/perf)
> ==45136==    by 0x1570E0: __cmd_record.constprop.0 (in /usr/bin/perf)
> ==45136==    by 0x15A845: cmd_record (in /usr/bin/perf)
> ==45136==    by 0x201B7E: run_builtin (in /usr/bin/perf)
> ==45136==    by 0x142D76: main (in /usr/bin/perf)
> ==45136==
> ```
> 
> Thanks
> -- 
> Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
> KDAB (Deutschland) GmbH, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt, C++ and OpenGL Experts
> 
