Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3BC20011E
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739398257; cv=none; b=CoXTaWb2gEhhyo7N7Wdux7KRjClpJ/sUmfSBlZNn/aELtOnyzdofv/lEiik/o2gGaDAILvtnTO1BMlwFd7sQVLv8HKyrea0VMsleoLzTUp2HPUACtlFEiLehnOZ9RuF0GJgWRBldNCffifOWqVeOYgGGL66qy51Z/RrK4jCoQBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739398257; c=relaxed/simple;
	bh=NOy646oZwtyRTGskW1WRFrKUw2d6rf4NhaF9JQg/q4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAyM4wJ18DO5dYNUyk03CDdSdh+G6aQX4TeZSVMyz9D3+fhW8inAtmFQ5f6pWTid8xlxRmtD6Tlod9Pz1IcmDgqoy0PGLxxvXt2nj9gxRDupD+Dd5f237p9esG/rZteMR+/zMxdVCbqwdqvDSf/ZV12afu2TxDqFvw9V17fEUIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IbQ8xPX/; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IbQ8xPX/"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d13fe99d03so7805ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 14:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739398254; x=1740003054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bToaw/OYEIRpqtXHYAMxKpb0xCLeHzHNAMwzkIN65zk=;
        b=IbQ8xPX/qNh2BkR2ucvgqUYYcMdC8oY7ZSComS8AvBAJrgoEZb6G4NboBUWjUQUDAq
         zAiuHsdGywDOhhO4tG/Qw4mgQ6rEmPQq0XyXaxtF8+1nrjjL4W6zVWEHrDsbWF/FYUyF
         6lupDcZcnWtdRBOtcc8xHYB7g6EadSkQIE9Vxe0qS7fy11guP6AwLKjm8e4XfrKkEmhQ
         C67Vts9kwpsgcJndJ9BKiIMyF21+63daOB0Qv55KY4CIw/d4V7Bb4gPflByYETF0uorx
         icOvt8yMeNfUDnsJoCUo3iQDGUI65Vr/RMx/F+KaNN7ADk0QWioJjXZpZRp1SvSdZvl+
         MYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739398254; x=1740003054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bToaw/OYEIRpqtXHYAMxKpb0xCLeHzHNAMwzkIN65zk=;
        b=ZsTqaEtjuZ3+s5+wOQdWPbyo9vGnkK1vAb9pWrp8LhW5RXvrqHpxcwBe7EWcuuC2py
         sfhDiaV6/IBenebiI6780hueavpjl3acLVrlhqnVnFwzQ/AIuK6RSdZWat9ilZ8qoCVg
         9MfCEqWhdrgDGdxoQB+hOb5aXh75PNRvxIrhUo/RXnJP9L4UqWr2eBB8FYHz+O6nJtYc
         hVotB+oyGs/zQn3+WechobdAo5ncMmcUQHMfJkeB2FpA+7XbylrBth8PFbhnNyOE9qw9
         O0iCKz9SdLS+NK5J7aGbFTUNu0sbrOBnir9X+46XEnyXv8TDwBPNelh2RNlck+hg8ost
         2IIA==
X-Forwarded-Encrypted: i=1; AJvYcCUlR8qMao4X5wbM4n/UE/W34w4VmIGOL1JtlAhRzBPfGuMUVp9AYlz/KXPATXADDW94vMv9QDVp1SVdvmDaQgoJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzHmII67k++kN/84n4K1wJlmGiiKihXAHqs8imS/xt6XXNoKN8e
	TCuA5PqqfugsBiActDU8hapyYa1cGunGIocPJN7MR+B1G7FZomJLnUqSwNOu9SO+uhjB+H2+6b3
	HmX9oxBSTRnEsrID9jeOLXluhbwMZicSUrFX6
X-Gm-Gg: ASbGncu5rBxH50RCHJfS4faYxOTROKOAgsyF9v2jGKtbA/avvTa85EVuo1aqsEwZ7XS
	tJM8G2uVLSqvAPfBltezoDZmWi3Vh6RB6f/gX9bFrTMPjN/vwPNZXZeR3l7fqZwHu8/tU6qggeW
	0fXa1wwpW3rFrVWW851LYaPop8
X-Google-Smtp-Source: AGHT+IFEeaFz8ilYiMB31looOShRwgMjHvXxf35NREwmiADdfKwtgvLdset7lCyG7dddNdHiR78U7X6NnXf6fJswBkY=
X-Received: by 2002:a05:6e02:1a0f:b0:3bc:bd17:d68e with SMTP id
 e9e14a558f8ab-3d18e295459mr166805ab.21.1739398253757; Wed, 12 Feb 2025
 14:10:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206000137.2026034-1-namhyung@kernel.org> <Z60NFEAf2C8cL8Xh@x1>
 <Z60Ndm8VVI4Ao31U@x1> <CAP-5=fXw09MM5XyozJMM3FjMANJei1aNVmBghSEQFiCKAtJmXw@mail.gmail.com>
In-Reply-To: <CAP-5=fXw09MM5XyozJMM3FjMANJei1aNVmBghSEQFiCKAtJmXw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Feb 2025 14:10:42 -0800
X-Gm-Features: AWEUYZkYgTtbva4DpDVCRWQWTctolvqO2-cauLkb48uYugVaAvFieh4QBjWqBRs
Message-ID: <CAP-5=fUqcykMdApHVweETg9bp2EVPJhJOj_PR8cByOOA6OyQGw@mail.gmail.com>
Subject: Re: [PATCH] perf report: Add 'tgid' sort key
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 1:59=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Feb 12, 2025 at 1:07=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Wed, Feb 12, 2025 at 10:05:27PM +0100, Arnaldo Carvalho de Melo wrot=
e:
> > > On Wed, Feb 05, 2025 at 04:01:37PM -0800, Namhyung Kim wrote:
> > > > Sometimes we need to analyze the data in process level but current =
sort
> > > > keys only work on thread level.  Let's add 'tgid' sort key for that=
 as
> > > > 'pid' is already taken for thread.
> > > >
> > > > This will look mostly the same, but it only uses tgid instead of ti=
d.
> > > > Here's an example of a process with two threads (thloop).
> > > >
> > > >   $ perf record -- perf test -w thloop
> > >
> > > Unrelated, but when building perf with DEBUG=3D1 and trying to test t=
he
> > > above I noticed:
> > >
> > > root@number:~# perf record -- perf test -w thloop
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 0.404 MB perf.data (7968 samples) ]
> > > perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <=
=3D map__end(map)' failed.
> > > Aborted (core dumped)
> > > root@number:~# perf record -- perf test -w offcpu
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 0.040 MB perf.data (23 samples) ]
> > > perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <=
=3D map__end(map)' failed.
> > > Aborted (core dumped)
> > > root@number:~#
> > >
> > > I have:
> > >
> > > =E2=AC=A2 [acme@toolbox perf-tools-next]$ git log --oneline perf-tool=
s-next/perf-tools-next..
> > > 9de1ed6fa3b73cb1 (HEAD -> perf-tools-next) perf report: Add 'tgid' so=
rt key
> > > 23e98ede2a353530 perf trace: Add --summary-mode option
> > > e6d6104625a3790b perf tools: Get rid of now-unused rb_resort.h
> > > 173ec14e72ef4ed7 perf trace: Convert syscall_stats to hashmap
> > > 66edfb5d404e743d perf trace: Allocate syscall stats only if summary i=
s on
> > > ca6637e1ea08e6f4 perf parse-events filter: Use evsel__find_pmu()
> > > bd1ac4a678f7f2c8 perf bench evlist-open-close: Reduce scope of 2 vari=
ables
> > > cd59081880e89df8 perf test: Add direct off-cpu test
> > > 56cbd794c0c46ba9 perf record --off-cpu: Add --off-cpu-thresh option
> > > 28d9b19c5455556f perf record --off-cpu: Dump the remaining samples in=
 BPF's stack trace map
> > > 2bc05b02743b50a7 perf script: Display off-cpu samples correctly
> > > bfa457a621596947 perf record --off-cpu: Disable perf_event's callchai=
n collection
> > > eca732cc42d20266 perf evsel: Assemble offcpu samples
> > > 74ce50e40c569e90 perf record --off-cpu: Dump off-cpu samples in BPF
> > > e75f8ce63bfa6cb9 perf record --off-cpu: Preparation of off-cpu BPF pr=
ogram
> > > 0ffab9d26971c91c perf record --off-cpu: Parse off-cpu event
> > > efc3fe2070853b7d perf evsel: Expose evsel__is_offcpu_event() for futu=
re use
> > > =E2=AC=A2 [acme@toolbox perf-tools-next]$
> > >
> > > locally, that is the stuff I've been testing lately, doubt it is rela=
ted
> > > to these patches, I'll investigate later, have to go AFK, so FWIW as =
a
> > > heads up.
> >
> > Had time to extract this, now going really AFK:
> >
> > [New Thread 0x7fffdf24c6c0 (LWP 580622)]
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.403 MB perf.data (7948 samples) ]
> > [Thread 0x7fffdf24c6c0 (LWP 580622) exited]
> > perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <=3D =
map__end(map)' failed.
> >
> > Thread 1 "perf" received signal SIGABRT, Aborted.
> > Downloading 4.06 K source file /usr/src/debug/glibc-2.39-37.fc40.x86_64=
/nptl/pthread_kill.c
> > __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsign=
o@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
> > 44            return INTERNAL_SYSCALL_ERROR_P (ret) ? INTERNAL_SYSCALL_=
ERRNO (ret) : 0;
> > (gdb) bt
> > #0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3D=
signo@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
> > #1  0x00007ffff6ea80a3 in __pthread_kill_internal (threadid=3D<optimize=
d out>, signo=3D6) at pthread_kill.c:78
> > #2  0x00007ffff6e4ef1e in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdep=
s/posix/raise.c:26
> > #3  0x00007ffff6e36902 in __GI_abort () at abort.c:79
> > #4  0x00007ffff6e3681e in __assert_fail_base (fmt=3D0x7ffff6fc3bb8 "%s%=
s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=3Dassertion@entry=3D0x7b=
ef08 "map__end(prev) <=3D map__end(map)",
> >     file=3Dfile@entry=3D0x7bedf8 "util/maps.c", line=3Dline@entry=3D95,=
 function=3Dfunction@entry=3D0x7bf1c0 <__PRETTY_FUNCTION__.6> "check_invari=
ants") at assert.c:96
> > #5  0x00007ffff6e47047 in __assert_fail (assertion=3D0x7bef08 "map__end=
(prev) <=3D map__end(map)", file=3D0x7bedf8 "util/maps.c", line=3D95,
> >     function=3D0x7bf1c0 <__PRETTY_FUNCTION__.6> "check_invariants") at =
assert.c:105
> > #6  0x00000000006347a1 in check_invariants (maps=3D0xf987e0) at util/ma=
ps.c:95
> > #7  0x0000000000635ae2 in maps__remove (maps=3D0xf987e0, map=3D0xf98a80=
) at util/maps.c:538
> > #8  0x000000000062afd2 in machine__destroy_kernel_maps (machine=3D0xf98=
178) at util/machine.c:1176
> > #9  0x000000000062b32b in machines__destroy_kernel_maps (machines=3D0xf=
98178) at util/machine.c:1238
> > #10 0x00000000006388af in perf_session__destroy_kernel_maps (session=3D=
0xf97f60) at util/session.c:105
> > #11 0x0000000000638df0 in perf_session__delete (session=3D0xf97f60) at =
util/session.c:248
> > #12 0x0000000000431f18 in __cmd_record (rec=3D0xecace0 <record>, argc=
=3D4, argv=3D0x7fffffffde60) at builtin-record.c:2888
> > #13 0x00000000004351fb in cmd_record (argc=3D4, argv=3D0x7fffffffde60) =
at builtin-record.c:4286
> > #14 0x00000000004bd4d4 in run_builtin (p=3D0xecddc0 <commands+288>, arg=
c=3D6, argv=3D0x7fffffffde60) at perf.c:351
> > #15 0x00000000004bd77b in handle_internal_command (argc=3D6, argv=3D0x7=
fffffffde60) at perf.c:404
> > #16 0x00000000004bd8d4 in run_argv (argcp=3D0x7fffffffdc4c, argv=3D0x7f=
ffffffdc40) at perf.c:448
> > #17 0x00000000004bdc1d in main (argc=3D6, argv=3D0x7fffffffde60) at per=
f.c:556
> > (gdb)
>
> So my guess would be that something modified a map and broke the
> invariants of the maps_by_addresss/maps_by_name. It should be possible
> to add more check_invariants to work out where this happens.
>
> Thanks,
> Ian

I also suspect this is a regression. If you could bisect to find the
cause then the fix is probably to not modify a map but clone it,
change it and then reinsert it into the maps - the insert is called
maps__fixup_overlap_and_insert so that maps don't overlap one another
like the invariant check is detecting. Fwiw, in the older rbtree code,
invariant breakages like this would be silently ignored, so we may
have a latent bug :-(

Thanks,
Ian

> > > - Arnaldo
> > >
> > > >   $ perf report --stdio -s tgid,pid -H
> > > >   ...
> > > >   #
> > > >   #    Overhead  Tgid:Command / Pid:Command
> > > >   # ...........  ..........................
> > > >   #
> > > >      100.00%     2018407:perf
> > > >          50.34%     2018407:perf
> > > >          49.66%     2018409:perf
> > > >
> > > > Suggested-by: Stephane Eranian <eranian@google.com>
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/perf/Documentation/perf-report.txt |  1 +
> > > >  tools/perf/util/hist.h                   |  1 +
> > > >  tools/perf/util/sort.c                   | 35 ++++++++++++++++++++=
++++
> > > >  tools/perf/util/sort.h                   |  1 +
> > > >  4 files changed, 38 insertions(+)
> > > >
> > > > diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/=
Documentation/perf-report.txt
> > > > index 87f86451940623f3..4050ec4038425bf0 100644
> > > > --- a/tools/perf/Documentation/perf-report.txt
> > > > +++ b/tools/perf/Documentation/perf-report.txt
> > > > @@ -79,6 +79,7 @@ OPTIONS
> > > >
> > > >     - comm: command (name) of the task which can be read via /proc/=
<pid>/comm
> > > >     - pid: command and tid of the task
> > > > +   - tgid: command and tgid of the task
> > > >     - dso: name of library or module executed at the time of sample
> > > >     - dso_size: size of library or module executed at the time of s=
ample
> > > >     - symbol: name of function executed at the time of sample
> > > > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > > > index 46c8373e314657fa..c164e178e0a48a8e 100644
> > > > --- a/tools/perf/util/hist.h
> > > > +++ b/tools/perf/util/hist.h
> > > > @@ -38,6 +38,7 @@ enum hist_column {
> > > >     HISTC_TIME,
> > > >     HISTC_DSO,
> > > >     HISTC_THREAD,
> > > > +   HISTC_TGID,
> > > >     HISTC_COMM,
> > > >     HISTC_CGROUP_ID,
> > > >     HISTC_CGROUP,
> > > > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > > > index 3dd33721823f365d..5987438174967fd6 100644
> > > > --- a/tools/perf/util/sort.c
> > > > +++ b/tools/perf/util/sort.c
> > > > @@ -141,6 +141,40 @@ struct sort_entry sort_thread =3D {
> > > >     .se_width_idx   =3D HISTC_THREAD,
> > > >  };
> > > >
> > > > +/* --sort tgid */
> > > > +
> > > > +static int64_t
> > > > +sort__tgid_cmp(struct hist_entry *left, struct hist_entry *right)
> > > > +{
> > > > +   return thread__pid(right->thread) - thread__pid(left->thread);
> > > > +}
> > > > +
> > > > +static int hist_entry__tgid_snprintf(struct hist_entry *he, char *=
bf,
> > > > +                                  size_t size, unsigned int width)
> > > > +{
> > > > +   int tgid =3D thread__pid(he->thread);
> > > > +   const char *comm =3D NULL;
> > > > +
> > > > +   if (thread__pid(he->thread) =3D=3D thread__tid(he->thread)) {
> > > > +           comm =3D thread__comm_str(he->thread);
> > > > +   } else {
> > > > +           struct maps *maps =3D thread__maps(he->thread);
> > > > +           struct thread *leader =3D machine__find_thread(maps__ma=
chine(maps),
> > > > +                                                        tgid, tgid=
);
> > > > +           if (leader)
> > > > +                   comm =3D thread__comm_str(leader);
> > > > +   }
> > > > +   width =3D max(7U, width) - 8;
> > > > +   return repsep_snprintf(bf, size, "%7d:%-*.*s", tgid, width, wid=
th, comm ?: "");
> > > > +}
> > > > +
> > > > +struct sort_entry sort_tgid =3D {
> > > > +   .se_header      =3D "   Tgid:Command",
> > > > +   .se_cmp         =3D sort__tgid_cmp,
> > > > +   .se_snprintf    =3D hist_entry__tgid_snprintf,
> > > > +   .se_width_idx   =3D HISTC_TGID,
> > > > +};
> > > > +
> > > >  /* --sort simd */
> > > >
> > > >  static int64_t
> > > > @@ -2501,6 +2535,7 @@ static void sort_dimension_add_dynamic_header=
(struct sort_dimension *sd)
> > > >
> > > >  static struct sort_dimension common_sort_dimensions[] =3D {
> > > >     DIM(SORT_PID, "pid", sort_thread),
> > > > +   DIM(SORT_TGID, "tgid", sort_tgid),
> > > >     DIM(SORT_COMM, "comm", sort_comm),
> > > >     DIM(SORT_DSO, "dso", sort_dso),
> > > >     DIM(SORT_SYM, "symbol", sort_sym),
> > > > diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> > > > index a8572574e1686be6..6044eb1d61447c0d 100644
> > > > --- a/tools/perf/util/sort.h
> > > > +++ b/tools/perf/util/sort.h
> > > > @@ -72,6 +72,7 @@ enum sort_type {
> > > >     SORT_ANNOTATE_DATA_TYPE_OFFSET,
> > > >     SORT_SYM_OFFSET,
> > > >     SORT_ANNOTATE_DATA_TYPE_CACHELINE,
> > > > +   SORT_TGID,
> > > >
> > > >     /* branch stack specific sort keys */
> > > >     __SORT_BRANCH_STACK,
> > > > --
> > > > 2.48.1.502.g6dc24dfdaf-goog
