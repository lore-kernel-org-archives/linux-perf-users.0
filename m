Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21FB202F61
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739397586; cv=none; b=SDmNaUM6DqiI9SicQ13SD4ofqxAgoTufS9XCmcUjeMhMO6d2UjObidfIl2yjzt3Lx9/7zwWsl4gsFXrz0Sy1AUughqW4I0C/gfJARI3w/ppKHeqjd1M8v14/TRQzjoqcWBN4xdbj/wN+Uob/DR78BjqxpnJLo563yJ+TK6ROt5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739397586; c=relaxed/simple;
	bh=FXZ75gQAbAoYm7eFGD2xjaDZq2cYcuFnJFkdgoTSZiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDNwbnCBDFE9zM/Dd13TPFONUfVIsxZaYxMEuuPjoNMxRTApmAXTePPpj5RlYGxvTBFCwOXnmf7rivXWmlKCOlCyPlp9rM/8s1S/6WliYjSF3dvv0qGmrHg81RVG2LN2pzorOKfgGwExrfsxqPD7hRPepySIC6E1uevF66gbmRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HQkjjQ41; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HQkjjQ41"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d13fe99d03so6485ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 13:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739397584; x=1740002384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JZMa2DPbbfY/4c9jk36eAz74gJF4kgqpbfI/labaKY=;
        b=HQkjjQ41ieBANK/0OZev0gwLPNPpVpV9bgEkgwOSmX9cW7NxSE5QOjEQrihQ9lSZ+f
         T6ZPDfL/tqpYns3wBK18hSTWiX1AlZ8h6pmVETS083aHXOxWzH86tR+jz8RTnmVL0ZQs
         4r4tKKbrp5LunLox1NszXFww0Zh5g8tpKz+iD8paONRYqbPgj8eYXDQ1LAaBqNC3bEx8
         yGau7CG/Q02OKPt+pqLRk9QUL9DlOk2Wdz7mHw2MRFCY7nfm1aQUhVZEMZm7xk++P9fm
         e+e0gTvCm5U0fGxvYtbZ9sp2U7UYfdY66asze9Awhj02xeAa12M9MAGGsGDMxwA/YX5s
         W+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739397584; x=1740002384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JZMa2DPbbfY/4c9jk36eAz74gJF4kgqpbfI/labaKY=;
        b=ryXb1HROqSE5DOBBilBxBBhTrGEFW+5k7EIitXX6r9HniERHpeUECreDlJFhlkRW2Q
         PqyU1PULH8p5v1cAgUqF0wPnuiE5nDbRBQc9tfXDz4bR9urqd4iqPM2X3Xxd+222C28Z
         Z5KJ1NKrxALh3vgS1zKK+OTPtRb7+qU4vuqFVt8KkQgMyIoWRM1oYZCyqZkHMAYJkfUk
         4+C5dCkyUkeHITD/l1VNjpZreFPs9K7bzvbDECYoj/l9LSFbH/FZJdrm6OmwTX31mA96
         NZCTuourldWBo8XifcbfTr1VvsORun7ATglQ1NYKfiOOCXQA8zWSusEzteaVAuDcgft0
         6VGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDODQOhbSU93ah6IkEc6kkTC/h66lkHhhukqUythJVLcxl3S/9hvVv52t+T6hkwUcl8pN7/5rJdOuJAsuTl/qb@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo8bUxdaJZBtVLbDcjgHSANg9e7ofEx+b2trmmxL4ugWsV2XEs
	zyfA+0JaXhcUamjCo6f/FmWkibzTi0x4wDeKr2Z8/dhPz+epd9k9VO9KH9Sb+k7pOobkFCn5ZlH
	cBUlpezdaSrYD/p6AbeOzuBpkHK0VCqEh5pc5
X-Gm-Gg: ASbGnctzGdgGIrEF0j3oI4iD8ajSCJo2G19BAwbZLn4hQBhlOidJ8hyDBIqIfPaARkE
	oPoNNLxWuHVfsweXv8qyXucSSEXzrFkvF3Oz+cjv1hnxOYnZ1poS9fNG75OB7zNfmpInvCwXNFj
	BwTgAoqXBZ3MKKkohYDK0Du8vf
X-Google-Smtp-Source: AGHT+IED4Y7f8C6VvTj6nAikiQAxXPJ2t+21cF1FToxySHRijw62LX1KNb6kQP0zZVCXUPVEBM3KrQrq8ZNtVKTxfrs=
X-Received: by 2002:a05:6e02:13a6:b0:3d0:5693:d730 with SMTP id
 e9e14a558f8ab-3d18cc98567mr746125ab.6.1739397583548; Wed, 12 Feb 2025
 13:59:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206000137.2026034-1-namhyung@kernel.org> <Z60NFEAf2C8cL8Xh@x1>
 <Z60Ndm8VVI4Ao31U@x1>
In-Reply-To: <Z60Ndm8VVI4Ao31U@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Feb 2025 13:59:32 -0800
X-Gm-Features: AWEUYZlUGjnLqOIpbHdwhRX-cDZuJoIKldBPXLPmqJduJ-_5SrNos6ZeERSB9Lo
Message-ID: <CAP-5=fXw09MM5XyozJMM3FjMANJei1aNVmBghSEQFiCKAtJmXw@mail.gmail.com>
Subject: Re: [PATCH] perf report: Add 'tgid' sort key
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 1:07=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Feb 12, 2025 at 10:05:27PM +0100, Arnaldo Carvalho de Melo wrote:
> > On Wed, Feb 05, 2025 at 04:01:37PM -0800, Namhyung Kim wrote:
> > > Sometimes we need to analyze the data in process level but current so=
rt
> > > keys only work on thread level.  Let's add 'tgid' sort key for that a=
s
> > > 'pid' is already taken for thread.
> > >
> > > This will look mostly the same, but it only uses tgid instead of tid.
> > > Here's an example of a process with two threads (thloop).
> > >
> > >   $ perf record -- perf test -w thloop
> >
> > Unrelated, but when building perf with DEBUG=3D1 and trying to test the
> > above I noticed:
> >
> > root@number:~# perf record -- perf test -w thloop
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.404 MB perf.data (7968 samples) ]
> > perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <=3D =
map__end(map)' failed.
> > Aborted (core dumped)
> > root@number:~# perf record -- perf test -w offcpu
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.040 MB perf.data (23 samples) ]
> > perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <=3D =
map__end(map)' failed.
> > Aborted (core dumped)
> > root@number:~#
> >
> > I have:
> >
> > =E2=AC=A2 [acme@toolbox perf-tools-next]$ git log --oneline perf-tools-=
next/perf-tools-next..
> > 9de1ed6fa3b73cb1 (HEAD -> perf-tools-next) perf report: Add 'tgid' sort=
 key
> > 23e98ede2a353530 perf trace: Add --summary-mode option
> > e6d6104625a3790b perf tools: Get rid of now-unused rb_resort.h
> > 173ec14e72ef4ed7 perf trace: Convert syscall_stats to hashmap
> > 66edfb5d404e743d perf trace: Allocate syscall stats only if summary is =
on
> > ca6637e1ea08e6f4 perf parse-events filter: Use evsel__find_pmu()
> > bd1ac4a678f7f2c8 perf bench evlist-open-close: Reduce scope of 2 variab=
les
> > cd59081880e89df8 perf test: Add direct off-cpu test
> > 56cbd794c0c46ba9 perf record --off-cpu: Add --off-cpu-thresh option
> > 28d9b19c5455556f perf record --off-cpu: Dump the remaining samples in B=
PF's stack trace map
> > 2bc05b02743b50a7 perf script: Display off-cpu samples correctly
> > bfa457a621596947 perf record --off-cpu: Disable perf_event's callchain =
collection
> > eca732cc42d20266 perf evsel: Assemble offcpu samples
> > 74ce50e40c569e90 perf record --off-cpu: Dump off-cpu samples in BPF
> > e75f8ce63bfa6cb9 perf record --off-cpu: Preparation of off-cpu BPF prog=
ram
> > 0ffab9d26971c91c perf record --off-cpu: Parse off-cpu event
> > efc3fe2070853b7d perf evsel: Expose evsel__is_offcpu_event() for future=
 use
> > =E2=AC=A2 [acme@toolbox perf-tools-next]$
> >
> > locally, that is the stuff I've been testing lately, doubt it is relate=
d
> > to these patches, I'll investigate later, have to go AFK, so FWIW as a
> > heads up.
>
> Had time to extract this, now going really AFK:
>
> [New Thread 0x7fffdf24c6c0 (LWP 580622)]
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.403 MB perf.data (7948 samples) ]
> [Thread 0x7fffdf24c6c0 (LWP 580622) exited]
> perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <=3D ma=
p__end(map)' failed.
>
> Thread 1 "perf" received signal SIGABRT, Aborted.
> Downloading 4.06 K source file /usr/src/debug/glibc-2.39-37.fc40.x86_64/n=
ptl/pthread_kill.c
> __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsigno@=
entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
> 44            return INTERNAL_SYSCALL_ERROR_P (ret) ? INTERNAL_SYSCALL_ER=
RNO (ret) : 0;
> (gdb) bt
> #0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsi=
gno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
> #1  0x00007ffff6ea80a3 in __pthread_kill_internal (threadid=3D<optimized =
out>, signo=3D6) at pthread_kill.c:78
> #2  0x00007ffff6e4ef1e in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/=
posix/raise.c:26
> #3  0x00007ffff6e36902 in __GI_abort () at abort.c:79
> #4  0x00007ffff6e3681e in __assert_fail_base (fmt=3D0x7ffff6fc3bb8 "%s%s%=
s:%u: %s%sAssertion `%s' failed.\n%n", assertion=3Dassertion@entry=3D0x7bef=
08 "map__end(prev) <=3D map__end(map)",
>     file=3Dfile@entry=3D0x7bedf8 "util/maps.c", line=3Dline@entry=3D95, f=
unction=3Dfunction@entry=3D0x7bf1c0 <__PRETTY_FUNCTION__.6> "check_invarian=
ts") at assert.c:96
> #5  0x00007ffff6e47047 in __assert_fail (assertion=3D0x7bef08 "map__end(p=
rev) <=3D map__end(map)", file=3D0x7bedf8 "util/maps.c", line=3D95,
>     function=3D0x7bf1c0 <__PRETTY_FUNCTION__.6> "check_invariants") at as=
sert.c:105
> #6  0x00000000006347a1 in check_invariants (maps=3D0xf987e0) at util/maps=
.c:95
> #7  0x0000000000635ae2 in maps__remove (maps=3D0xf987e0, map=3D0xf98a80) =
at util/maps.c:538
> #8  0x000000000062afd2 in machine__destroy_kernel_maps (machine=3D0xf9817=
8) at util/machine.c:1176
> #9  0x000000000062b32b in machines__destroy_kernel_maps (machines=3D0xf98=
178) at util/machine.c:1238
> #10 0x00000000006388af in perf_session__destroy_kernel_maps (session=3D0x=
f97f60) at util/session.c:105
> #11 0x0000000000638df0 in perf_session__delete (session=3D0xf97f60) at ut=
il/session.c:248
> #12 0x0000000000431f18 in __cmd_record (rec=3D0xecace0 <record>, argc=3D4=
, argv=3D0x7fffffffde60) at builtin-record.c:2888
> #13 0x00000000004351fb in cmd_record (argc=3D4, argv=3D0x7fffffffde60) at=
 builtin-record.c:4286
> #14 0x00000000004bd4d4 in run_builtin (p=3D0xecddc0 <commands+288>, argc=
=3D6, argv=3D0x7fffffffde60) at perf.c:351
> #15 0x00000000004bd77b in handle_internal_command (argc=3D6, argv=3D0x7ff=
fffffde60) at perf.c:404
> #16 0x00000000004bd8d4 in run_argv (argcp=3D0x7fffffffdc4c, argv=3D0x7fff=
ffffdc40) at perf.c:448
> #17 0x00000000004bdc1d in main (argc=3D6, argv=3D0x7fffffffde60) at perf.=
c:556
> (gdb)

So my guess would be that something modified a map and broke the
invariants of the maps_by_addresss/maps_by_name. It should be possible
to add more check_invariants to work out where this happens.

Thanks,
Ian

> > - Arnaldo
> >
> > >   $ perf report --stdio -s tgid,pid -H
> > >   ...
> > >   #
> > >   #    Overhead  Tgid:Command / Pid:Command
> > >   # ...........  ..........................
> > >   #
> > >      100.00%     2018407:perf
> > >          50.34%     2018407:perf
> > >          49.66%     2018409:perf
> > >
> > > Suggested-by: Stephane Eranian <eranian@google.com>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/Documentation/perf-report.txt |  1 +
> > >  tools/perf/util/hist.h                   |  1 +
> > >  tools/perf/util/sort.c                   | 35 ++++++++++++++++++++++=
++
> > >  tools/perf/util/sort.h                   |  1 +
> > >  4 files changed, 38 insertions(+)
> > >
> > > diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Do=
cumentation/perf-report.txt
> > > index 87f86451940623f3..4050ec4038425bf0 100644
> > > --- a/tools/perf/Documentation/perf-report.txt
> > > +++ b/tools/perf/Documentation/perf-report.txt
> > > @@ -79,6 +79,7 @@ OPTIONS
> > >
> > >     - comm: command (name) of the task which can be read via /proc/<p=
id>/comm
> > >     - pid: command and tid of the task
> > > +   - tgid: command and tgid of the task
> > >     - dso: name of library or module executed at the time of sample
> > >     - dso_size: size of library or module executed at the time of sam=
ple
> > >     - symbol: name of function executed at the time of sample
> > > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > > index 46c8373e314657fa..c164e178e0a48a8e 100644
> > > --- a/tools/perf/util/hist.h
> > > +++ b/tools/perf/util/hist.h
> > > @@ -38,6 +38,7 @@ enum hist_column {
> > >     HISTC_TIME,
> > >     HISTC_DSO,
> > >     HISTC_THREAD,
> > > +   HISTC_TGID,
> > >     HISTC_COMM,
> > >     HISTC_CGROUP_ID,
> > >     HISTC_CGROUP,
> > > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > > index 3dd33721823f365d..5987438174967fd6 100644
> > > --- a/tools/perf/util/sort.c
> > > +++ b/tools/perf/util/sort.c
> > > @@ -141,6 +141,40 @@ struct sort_entry sort_thread =3D {
> > >     .se_width_idx   =3D HISTC_THREAD,
> > >  };
> > >
> > > +/* --sort tgid */
> > > +
> > > +static int64_t
> > > +sort__tgid_cmp(struct hist_entry *left, struct hist_entry *right)
> > > +{
> > > +   return thread__pid(right->thread) - thread__pid(left->thread);
> > > +}
> > > +
> > > +static int hist_entry__tgid_snprintf(struct hist_entry *he, char *bf=
,
> > > +                                  size_t size, unsigned int width)
> > > +{
> > > +   int tgid =3D thread__pid(he->thread);
> > > +   const char *comm =3D NULL;
> > > +
> > > +   if (thread__pid(he->thread) =3D=3D thread__tid(he->thread)) {
> > > +           comm =3D thread__comm_str(he->thread);
> > > +   } else {
> > > +           struct maps *maps =3D thread__maps(he->thread);
> > > +           struct thread *leader =3D machine__find_thread(maps__mach=
ine(maps),
> > > +                                                        tgid, tgid);
> > > +           if (leader)
> > > +                   comm =3D thread__comm_str(leader);
> > > +   }
> > > +   width =3D max(7U, width) - 8;
> > > +   return repsep_snprintf(bf, size, "%7d:%-*.*s", tgid, width, width=
, comm ?: "");
> > > +}
> > > +
> > > +struct sort_entry sort_tgid =3D {
> > > +   .se_header      =3D "   Tgid:Command",
> > > +   .se_cmp         =3D sort__tgid_cmp,
> > > +   .se_snprintf    =3D hist_entry__tgid_snprintf,
> > > +   .se_width_idx   =3D HISTC_TGID,
> > > +};
> > > +
> > >  /* --sort simd */
> > >
> > >  static int64_t
> > > @@ -2501,6 +2535,7 @@ static void sort_dimension_add_dynamic_header(s=
truct sort_dimension *sd)
> > >
> > >  static struct sort_dimension common_sort_dimensions[] =3D {
> > >     DIM(SORT_PID, "pid", sort_thread),
> > > +   DIM(SORT_TGID, "tgid", sort_tgid),
> > >     DIM(SORT_COMM, "comm", sort_comm),
> > >     DIM(SORT_DSO, "dso", sort_dso),
> > >     DIM(SORT_SYM, "symbol", sort_sym),
> > > diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> > > index a8572574e1686be6..6044eb1d61447c0d 100644
> > > --- a/tools/perf/util/sort.h
> > > +++ b/tools/perf/util/sort.h
> > > @@ -72,6 +72,7 @@ enum sort_type {
> > >     SORT_ANNOTATE_DATA_TYPE_OFFSET,
> > >     SORT_SYM_OFFSET,
> > >     SORT_ANNOTATE_DATA_TYPE_CACHELINE,
> > > +   SORT_TGID,
> > >
> > >     /* branch stack specific sort keys */
> > >     __SORT_BRANCH_STACK,
> > > --
> > > 2.48.1.502.g6dc24dfdaf-goog
