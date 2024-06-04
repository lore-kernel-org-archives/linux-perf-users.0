Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BE912B14B;
	Tue,  4 Jun 2024 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510359; cv=none; b=BsdhanfWTF+9zmw4Oz3v9CqeBk8AmQRvdeYePw1UGRJqRKJI6LKvegV9MKRSZBJBUpz8xQloTFjKeEYWo+dVvu1llsj/S5yFCn3ggrRGuaG73gSOiGASjmnh8hIP1ettz0px0+RxoVIHGXweqOPJQzSGY6GySb0k3ian2NoqGRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510359; c=relaxed/simple;
	bh=QRLlM2u8ZhW9M94JeTRqj7E4RsizD2fIsY2GA02A/8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBv7wKjOF5eH1315zfkXIb5qetN+KA1wdQ6rJs5beDsdRjHbHBLV3PCmQ/+l12cF48z4mUoRfc/GIVADao9+3kmLZSy2N1lWIS6msN4M6bpmOUjvi2dr6TgrYawLN1FvqNtt+cEQK3nboj/q/ab2LwQ6T9XlYHdhApHKerIDNm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSrrG135; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSrrG135"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA7BC4AF07;
	Tue,  4 Jun 2024 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717510359;
	bh=QRLlM2u8ZhW9M94JeTRqj7E4RsizD2fIsY2GA02A/8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZSrrG135YH7otMz7zP6kDuCrEqsxNCb78oNONQJA7DWQe4c+4aAqNk/PRCNZn7p6s
	 r87AtL2iiJ2mWk+OgOOPLS8bRzsxD6NV19n4ejGNNxxzFdYky4v0nn30TAMWfHZr24
	 9EPUCA1vP4xPsiyMM7YO/Do0NKEwFUgeKht+xn2h8dzavH+Km1Dknsw8nE5Qq/kqiQ
	 E22IdYbSNJVpLerqYauFtDHfZaFUnjKUwEo+yYTZtoDbk97iK0MbIcdJ8Wa1nk2t3h
	 0YuBYRncSGZMJD8tvr6/Rh5MEDiD4kMatw32YRZq4NAgZeciDlRCNOXLxe07lFRh1f
	 QKX0/EAn+j1WQ==
Date: Tue, 4 Jun 2024 11:12:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kenel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf 6.9-1 (archlinux) crashes during recording of cycles +
 raw_syscalls
Message-ID: <Zl8g1LxRCYgTSxhy@x1>
References: <23879991.0LEYPuXRzz@milian-workstation>
 <Zl8bhWfHSXxs35r2@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl8bhWfHSXxs35r2@x1>

On Tue, Jun 04, 2024 at 10:50:00AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Jun 04, 2024 at 01:44:18PM +0200, Milian Wolff wrote:
> > the following command crashes perf for me, is this still an issue upstream and 
> > should I report it to arch for backporting? I cannot build the official perf/
> > core branch, so I am afraid I cannot test it myself there:

> > ```
> > sudo /usr/bin/perf record -z --call-graph dwarf -e cycles -e 
> > raw_syscalls:sys_enter ls
> > ...
> > [ perf record: Woken up 3 times to write data ]
> > malloc(): invalid next size (unsorted)
> > Aborted
> > ```
> > Backtrace with GDB + debuginfod:
> > ```
> > malloc(): invalid next size (unsorted)

> I reproduced this all the way back to 6.8, trying to bisect now, thanks
> for the report,

Can you please try with the attached and perhaps provide your Tested-by?

Thanks,

- Arnaldo

From ab355e2c6b4cf641a9fff7af38059cf69ac712d5 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Tue, 4 Jun 2024 11:00:22 -0300
Subject: [PATCH 1/1] Revert "perf record: Reduce memory for recording
 PERF_RECORD_LOST_SAMPLES event"

This reverts commit 7d1405c71df21f6c394b8a885aa8a133f749fa22.

This causes segfaults in some cases, as reported by Milian:

  ```
  sudo /usr/bin/perf record -z --call-graph dwarf -e cycles -e
  raw_syscalls:sys_enter ls
  ...
  [ perf record: Woken up 3 times to write data ]
  malloc(): invalid next size (unsorted)
  Aborted
  ```

  Backtrace with GDB + debuginfod:

  ```
  malloc(): invalid next size (unsorted)

  Thread 1 "perf" received signal SIGABRT, Aborted.
  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6,
  no_tid=no_tid@entry=0) at pthread_kill.c:44
  Downloading source file /usr/src/debug/glibc/glibc/nptl/pthread_kill.c
  44            return INTERNAL_SYSCALL_ERROR_P (ret) ? INTERNAL_SYSCALL_ERRNO
  (ret) : 0;
  (gdb) bt
  #0  __pthread_kill_implementation (threadid=<optimized out>,
  signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
  #1  0x00007ffff6ea8eb3 in __pthread_kill_internal (threadid=<optimized out>,
  signo=6) at pthread_kill.c:78
  #2  0x00007ffff6e50a30 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/
  raise.c:26
  #3  0x00007ffff6e384c3 in __GI_abort () at abort.c:79
  #4  0x00007ffff6e39354 in __libc_message_impl (fmt=fmt@entry=0x7ffff6fc22ea
  "%s\n") at ../sysdeps/posix/libc_fatal.c:132
  #5  0x00007ffff6eb3085 in malloc_printerr (str=str@entry=0x7ffff6fc5850
  "malloc(): invalid next size (unsorted)") at malloc.c:5772
  #6  0x00007ffff6eb657c in _int_malloc (av=av@entry=0x7ffff6ff6ac0
  <main_arena>, bytes=bytes@entry=368) at malloc.c:4081
  #7  0x00007ffff6eb877e in __libc_calloc (n=<optimized out>,
  elem_size=<optimized out>) at malloc.c:3754
  #8  0x000055555569bdb6 in perf_session.do_write_header ()
  #9  0x00005555555a373a in __cmd_record.constprop.0 ()
  #10 0x00005555555a6846 in cmd_record ()
  #11 0x000055555564db7f in run_builtin ()
  #12 0x000055555558ed77 in main ()
  ```

  Valgrind memcheck:
  ```
  ==45136== Invalid write of size 8
  ==45136==    at 0x2B38A5: perf_event__synthesize_id_sample (in /usr/bin/perf)
  ==45136==    by 0x157069: __cmd_record.constprop.0 (in /usr/bin/perf)
  ==45136==    by 0x15A845: cmd_record (in /usr/bin/perf)
  ==45136==    by 0x201B7E: run_builtin (in /usr/bin/perf)
  ==45136==    by 0x142D76: main (in /usr/bin/perf)
  ==45136==  Address 0x6a866a8 is 0 bytes after a block of size 40 alloc'd
  ==45136==    at 0x4849BF3: calloc (vg_replace_malloc.c:1675)
  ==45136==    by 0x3574AB: zalloc (in /usr/bin/perf)
  ==45136==    by 0x1570E0: __cmd_record.constprop.0 (in /usr/bin/perf)
  ==45136==    by 0x15A845: cmd_record (in /usr/bin/perf)
  ==45136==    by 0x201B7E: run_builtin (in /usr/bin/perf)
  ==45136==    by 0x142D76: main (in /usr/bin/perf)
  ==45136==
  ==45136== Syscall param write(buf) points to unaddressable byte(s)
  ==45136==    at 0x575953D: __libc_write (write.c:26)
  ==45136==    by 0x575953D: write (write.c:24)
  ==45136==    by 0x35761F: ion (in /usr/bin/perf)
  ==45136==    by 0x357778: writen (in /usr/bin/perf)
  ==45136==    by 0x1548F7: record__write (in /usr/bin/perf)
  ==45136==    by 0x15708A: __cmd_record.constprop.0 (in /usr/bin/perf)
  ==45136==    by 0x15A845: cmd_record (in /usr/bin/perf)
  ==45136==    by 0x201B7E: run_builtin (in /usr/bin/perf)
  ==45136==    by 0x142D76: main (in /usr/bin/perf)
  ==45136==  Address 0x6a866a8 is 0 bytes after a block of size 40 alloc'd
  ==45136==    at 0x4849BF3: calloc (vg_replace_malloc.c:1675)
  ==45136==    by 0x3574AB: zalloc (in /usr/bin/perf)
  ==45136==    by 0x1570E0: __cmd_record.constprop.0 (in /usr/bin/perf)
  ==45136==    by 0x15A845: cmd_record (in /usr/bin/perf)
  ==45136==    by 0x201B7E: run_builtin (in /usr/bin/perf)
  ==45136==    by 0x142D76: main (in /usr/bin/perf)
  ==45136==
 -----

Closes: https://lore.kernel.org/linux-perf-users/23879991.0LEYPuXRzz@milian-workstation/
Reported-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: stable@kernel.org # 6.8+
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 66a3de8ac66186b0..0a8ba1323d64be6b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1956,8 +1956,7 @@ static void record__read_lost_samples(struct record *rec)
 
 				if (count.lost) {
 					if (!lost) {
-						lost = zalloc(sizeof(*lost) +
-							      session->machines.host.id_hdr_size);
+						lost = zalloc(PERF_SAMPLE_MAX_SIZE);
 						if (!lost) {
 							pr_debug("Memory allocation failed\n");
 							return;
@@ -1973,8 +1972,7 @@ static void record__read_lost_samples(struct record *rec)
 		lost_count = perf_bpf_filter__lost_count(evsel);
 		if (lost_count) {
 			if (!lost) {
-				lost = zalloc(sizeof(*lost) +
-					      session->machines.host.id_hdr_size);
+				lost = zalloc(PERF_SAMPLE_MAX_SIZE);
 				if (!lost) {
 					pr_debug("Memory allocation failed\n");
 					return;
-- 
2.45.1

