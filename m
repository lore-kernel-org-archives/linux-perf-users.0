Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DC318028
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Jun 2024 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717526903; cv=none; b=bb1QIn7nC0gMFc0xCBUU94EFGNOcYlC7yg5Ei2jAfJRVbr2Cv32NUkQ5wE6Dt1YN2mg1ZLGWm62xBVoTEcxj44Dymjbr6k1c8eYSuNclY9Vxsp8OvSGD6NFTIRf5lIa8ptSJC9eMjQ9gSB+kOTUlyCLisXevTZH+F1k93np8dDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717526903; c=relaxed/simple;
	bh=jX8UMTejDZxOWy2xvRQrFYx9FLkD8PRvvmu286qo3B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAcmG5NKiKYjDDwrFyHqIAWmuXr/DX6UUOlqetkA7v+YZPUxkbHmbbGfK1QecPxbnzM1Xor0bCezk6tfDDX10wBYbsgvtcUTRPUgm/1Ices1J+MrvzFDSx0z3itNKWPTBZpfSEU6rnYIYkaVfVmNFLH24Ch2xE/ZuVSHAKolpjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y4xYIfv4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y4xYIfv4"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f66ad03847so28975ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Jun 2024 11:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717526901; x=1718131701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GW87wwCX8r5pSoAmwipgb8TBgyr5V1aGTvd+vaaORGA=;
        b=y4xYIfv4vyvXS0ob6OglaQSyePcU6H4yj4gWdc68Cp3w9wEdasebeKwlixtX0rx7k6
         LXMlRKc7jLoD5UgDZKDfu6TnL66Hbw+G8YsKhjrBRSFqM0ert5U+mafG3WvA0K/ukRY9
         P15rOIc1nHDcfPy3Re3wuuZO1m+/tzeoR+2r605wniQhC88tvHi0rW4z13YxL7MLLfZc
         AvyTM+muDGbR771u6w0Pj1uJu1bislbI7tIaA5yOYc7KB5BhKFaIb60apMhaymZfL/I4
         n42hBtOUHuDOM8USDn03EuoT31YiM71+eIViry1zJICdxTWqE3uB6aPQ+mVxhQ0YpVmP
         sLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717526901; x=1718131701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GW87wwCX8r5pSoAmwipgb8TBgyr5V1aGTvd+vaaORGA=;
        b=waHjctilkb5KEhwHB/SxrvRyb+116Wvpp8bl91yg9eNflxWOMkUeFeyseLa35MWRCR
         8ms6fMpHznqck3DPoC6x57MmARdKwheh04/nc+FlbiBwcl+ZCFGKXMzBnJhT8KGEJoaO
         YkV5xSpo6RupCzlGKwhlMcBPCCNMRa/NsMSeAcdwJsIa7Bjua4OCy/+gXV1FATl3qkN0
         hdGpY/NrP9Hm6ASHc1pDafZ3rak7VyqTMlbWe/4WAqdPILlUvFB4JbfGxiFZzlf7iIk+
         jLQE7aDUS7u74wHcB8Crpf11W6FlUo4AmG0JZOxUW22lpd/lfll19UHooBFWUd15KNyP
         nbLg==
X-Forwarded-Encrypted: i=1; AJvYcCX72XZ3vucRxocQ6RDWUDsHmT4w3aKA7x2Z5z6JNy+MqS01YDUGad/iZCJWSVMGw5t53sk2281i13m8gL04TPh5rnR4S5ByXY6BDNujVxZ0VA==
X-Gm-Message-State: AOJu0YwShsqTFWJMoO1kE73mM80YvIn88AmvwjFxiQVc1ciWpXjghMLY
	zsxixG31XXHPL71TVORa/GhsBK8RtWAAUdhZvzdoV6/Cl746NzyOKpAuJMdJA1D6utPwYdesawD
	hWnES9a5Mk2GGpRvReZVEW5/mthfI3eZGaaUm
X-Google-Smtp-Source: AGHT+IHUVUunvHlUcY83hu7GlpidYQUM4eo6IlyvzCk7xmtTg7hH7ekLcv/5Om/sMvyhqe1VhxNDnvG9iTXn6sBiS40=
X-Received: by 2002:a17:902:da89:b0:1f3:aff:8318 with SMTP id
 d9443c01a7336-1f6a66e4cbbmr289735ad.5.1717526900793; Tue, 04 Jun 2024
 11:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23879991.0LEYPuXRzz@milian-workstation> <Zl8bhWfHSXxs35r2@x1> <Zl8g1LxRCYgTSxhy@x1>
In-Reply-To: <Zl8g1LxRCYgTSxhy@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Jun 2024 11:48:09 -0700
Message-ID: <CAP-5=fVJRr2Qgf88ugEJ2FGerzKNv_dD6XOT_dSuFyYp2ubwSw@mail.gmail.com>
Subject: Re: perf 6.9-1 (archlinux) crashes during recording of cycles + raw_syscalls
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>, linux-perf-users@vger.kernel.org, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kenel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 7:12=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Tue, Jun 04, 2024 at 10:50:00AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Jun 04, 2024 at 01:44:18PM +0200, Milian Wolff wrote:
> > > the following command crashes perf for me, is this still an issue ups=
tream and
> > > should I report it to arch for backporting? I cannot build the offici=
al perf/
> > > core branch, so I am afraid I cannot test it myself there:
>
> > > ```
> > > sudo /usr/bin/perf record -z --call-graph dwarf -e cycles -e
> > > raw_syscalls:sys_enter ls
> > > ...
> > > [ perf record: Woken up 3 times to write data ]
> > > malloc(): invalid next size (unsorted)
> > > Aborted
> > > ```
> > > Backtrace with GDB + debuginfod:
> > > ```
> > > malloc(): invalid next size (unsorted)
>
> > I reproduced this all the way back to 6.8, trying to bisect now, thanks
> > for the report,
>
> Can you please try with the attached and perhaps provide your Tested-by?
>
> Thanks,
>
> - Arnaldo
>
> From ab355e2c6b4cf641a9fff7af38059cf69ac712d5 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Tue, 4 Jun 2024 11:00:22 -0300
> Subject: [PATCH 1/1] Revert "perf record: Reduce memory for recording
>  PERF_RECORD_LOST_SAMPLES event"
>
> This reverts commit 7d1405c71df21f6c394b8a885aa8a133f749fa22.

I think we should try to fight back reverts when possible. Reverts are
removing something somebody poured time and attention into. When a
regression has occurred then I think we should add the regression case
as a test.

> This causes segfaults in some cases, as reported by Milian:
>
>   ```
>   sudo /usr/bin/perf record -z --call-graph dwarf -e cycles -e
>   raw_syscalls:sys_enter ls
>   ...
>   [ perf record: Woken up 3 times to write data ]
>   malloc(): invalid next size (unsorted)
>   Aborted
>   ```
>
>   Backtrace with GDB + debuginfod:
>
>   ```
>   malloc(): invalid next size (unsorted)
>
>   Thread 1 "perf" received signal SIGABRT, Aborted.
>   __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsign=
o@entry=3D6,
>   no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
>   Downloading source file /usr/src/debug/glibc/glibc/nptl/pthread_kill.c
>   44            return INTERNAL_SYSCALL_ERROR_P (ret) ? INTERNAL_SYSCALL_=
ERRNO
>   (ret) : 0;
>   (gdb) bt
>   #0  __pthread_kill_implementation (threadid=3D<optimized out>,
>   signo=3Dsigno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:4=
4
>   #1  0x00007ffff6ea8eb3 in __pthread_kill_internal (threadid=3D<optimize=
d out>,
>   signo=3D6) at pthread_kill.c:78
>   #2  0x00007ffff6e50a30 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdep=
s/posix/
>   raise.c:26
>   #3  0x00007ffff6e384c3 in __GI_abort () at abort.c:79
>   #4  0x00007ffff6e39354 in __libc_message_impl (fmt=3Dfmt@entry=3D0x7fff=
f6fc22ea
>   "%s\n") at ../sysdeps/posix/libc_fatal.c:132
>   #5  0x00007ffff6eb3085 in malloc_printerr (str=3Dstr@entry=3D0x7ffff6fc=
5850
>   "malloc(): invalid next size (unsorted)") at malloc.c:5772
>   #6  0x00007ffff6eb657c in _int_malloc (av=3Dav@entry=3D0x7ffff6ff6ac0
>   <main_arena>, bytes=3Dbytes@entry=3D368) at malloc.c:4081
>   #7  0x00007ffff6eb877e in __libc_calloc (n=3D<optimized out>,
>   elem_size=3D<optimized out>) at malloc.c:3754
>   #8  0x000055555569bdb6 in perf_session.do_write_header ()
>   #9  0x00005555555a373a in __cmd_record.constprop.0 ()
>   #10 0x00005555555a6846 in cmd_record ()
>   #11 0x000055555564db7f in run_builtin ()
>   #12 0x000055555558ed77 in main ()
>   ```
>
>   Valgrind memcheck:
>   ```
>   =3D=3D45136=3D=3D Invalid write of size 8
>   =3D=3D45136=3D=3D    at 0x2B38A5: perf_event__synthesize_id_sample (in =
/usr/bin/perf)

The write that is happening here is because an empty sample except for
the id value is written out:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/synthetic-events.c?h=3Dperf-tools-next#n1805
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/builtin-record.c?h=3Dperf-tools-next#n1910
It'd been missed that the sample wasn't quite empty and needed space.

Rather than making the space 64kb again, can we not use
perf_event__sample_event_size or some max constant?

Thanks,
Ian

>   =3D=3D45136=3D=3D    by 0x157069: __cmd_record.constprop.0 (in /usr/bin=
/perf)
>   =3D=3D45136=3D=3D    by 0x15A845: cmd_record (in /usr/bin/perf)
>   =3D=3D45136=3D=3D    by 0x201B7E: run_builtin (in /usr/bin/perf)
>   =3D=3D45136=3D=3D    by 0x142D76: main (in /usr/bin/perf)
>   =3D=3D45136=3D=3D  Address 0x6a866a8 is 0 bytes after a block of size 4=
0 alloc'd
>   =3D=3D45136=3D=3D    at 0x4849BF3: calloc (vg_replace_malloc.c:1675)
>   =3D=3D45136=3D=3D    by 0x3574AB: zalloc (in /usr/bin/perf)
>   =3D=3D45136=3D=3D    by 0x1570E0: __cmd_record.constprop.0 (in /usr/bin=
/perf)
>   =3D=3D45136=3D=3D    by 0x15A845: cmd_record (in /usr/bin/perf)
>   =3D=3D45136=3D=3D    by 0x201B7E: run_builtin (in /usr/bin/perf)
>   =3D=3D45136=3D=3D    by 0x142D76: main (in /usr/bin/perf)
>   =3D=3D45136=3D=3D
>   =3D=3D45136=3D=3D Syscall param write(buf) points to unaddressable byte=
(s)
>   =3D=3D45136=3D=3D    at 0x575953D: __libc_write (write.c:26)
>   =3D=3D45136=3D=3D    by 0x575953D: write (write.c:24)
>   =3D=3D45136=3D=3D    by 0x35761F: ion (in /usr/bin/perf)
>   =3D=3D45136=3D=3D    by 0x357778: writen (in /usr/bin/perf)
>   =3D=3D45136=3D=3D    by 0x1548F7: record__write (in /usr/bin/perf)
>   =3D=3D45136=3D=3D    by 0x15708A: __cmd_record.constprop.0 (in /usr/bin=
/perf)
>   =3D=3D45136=3D=3D    by 0x15A845: cmd_record (in /usr/bin/perf)
>   =3D=3D45136=3D=3D    by 0x201B7E: run_builtin (in /usr/bin/perf)
>   =3D=3D45136=3D=3D    by 0x142D76: main (in /usr/bin/perf)
>   =3D=3D45136=3D=3D  Address 0x6a866a8 is 0 bytes after a block of size 4=
0 alloc'd
>   =3D=3D45136=3D=3D    at 0x4849BF3: calloc (vg_replace_malloc.c:1675)
>   =3D=3D45136=3D=3D    by 0x3574AB: zalloc (in /usr/bin/perf)
>   =3D=3D45136=3D=3D    by 0x1570E0: __cmd_record.constprop.0 (in /usr/bin=
/perf)
>   =3D=3D45136=3D=3D    by 0x15A845: cmd_record (in /usr/bin/perf)
>   =3D=3D45136=3D=3D    by 0x201B7E: run_builtin (in /usr/bin/perf)
>   =3D=3D45136=3D=3D    by 0x142D76: main (in /usr/bin/perf)
>   =3D=3D45136=3D=3D
>  -----
>
> Closes: https://lore.kernel.org/linux-perf-users/23879991.0LEYPuXRzz@mili=
an-workstation/
> Reported-by: Milian Wolff <milian.wolff@kdab.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: stable@kernel.org # 6.8+
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-record.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 66a3de8ac66186b0..0a8ba1323d64be6b 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1956,8 +1956,7 @@ static void record__read_lost_samples(struct record=
 *rec)
>
>                                 if (count.lost) {
>                                         if (!lost) {
> -                                               lost =3D zalloc(sizeof(*l=
ost) +
> -                                                             session->ma=
chines.host.id_hdr_size);
> +                                               lost =3D zalloc(PERF_SAMP=
LE_MAX_SIZE);
>                                                 if (!lost) {
>                                                         pr_debug("Memory =
allocation failed\n");
>                                                         return;
> @@ -1973,8 +1972,7 @@ static void record__read_lost_samples(struct record=
 *rec)
>                 lost_count =3D perf_bpf_filter__lost_count(evsel);
>                 if (lost_count) {
>                         if (!lost) {
> -                               lost =3D zalloc(sizeof(*lost) +
> -                                             session->machines.host.id_h=
dr_size);
> +                               lost =3D zalloc(PERF_SAMPLE_MAX_SIZE);
>                                 if (!lost) {
>                                         pr_debug("Memory allocation faile=
d\n");
>                                         return;
> --
> 2.45.1
>
