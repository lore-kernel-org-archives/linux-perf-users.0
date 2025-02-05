Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598411DE8AF
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Feb 2025 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738774033; cv=none; b=Jx2c8+EtfzyXVMTN25XcQzK6/tDZuJU29FrCPGX0f+7p0dMBdWipDCerH5BVAKL5n8TzI2oXqcTyGUhgcdP9hyvPGRmVFMwvNhr7fsuTq0c2M2DLCAq6G8PXODXQ4gjHfWikmfUS4cEKFwc+i5EA6ieBLPxFMba0mUK+LbbTgZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738774033; c=relaxed/simple;
	bh=+RTXZ7KNlWuZpYQ9B3AC1oqgHWNrSFYkRpr/sZbsxB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exSuldFVDWwQ1cV7P9XPo5axqK+VV/+mq8i9F7Jpwqjw4Xve7GzDcT/9mmsUW5nh5ai69HCKuqo55BUn7QZ8N7RwPbNLKmr/vhm8Gb0Rrc9kqpNBiDVJSM1THGrCyMYGYFfoGHkIqJOf5Y82DaWDfrvFXGJQPnbTNfylquaaz/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ADN6q5De; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ADN6q5De"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30229d5b229so69254761fa.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 08:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738774029; x=1739378829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hQgPaAQT9lCCMokU5e7QcSqm18k8TV67gVB86R3s708=;
        b=ADN6q5DeGnbc/KwvAIHnlQ9HWy7v1sVQ6uNSXyvaJNHQkDydM78E5vs800E1hr4vmq
         G9QTaVfZ/GkbdvcTH+uz3P4eewL9Z/tGjX4nP8EwD37PlLkOnJ2qbgrdOdMWgY/HbC1m
         CUu3uTwfKdOfCTxsffkEof2XtxyJKXYbd3dWAF9noGO4+U6uem0qwLhr/Ck4G1SPnfGn
         SDys1ESNwyrKX3+b4cskHsK8K81OUG/J9S1AOwKTP6fLCIxkc+2cLz6o6F1jkNKtyfGG
         55YxUYwYP+ls77/f1Od3vgEWEkyoTPOHH9IiQX9lrM6s3Gmm1LarJu/Kx9fyTYQ/u2oX
         mlrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738774029; x=1739378829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQgPaAQT9lCCMokU5e7QcSqm18k8TV67gVB86R3s708=;
        b=PmSBljYVsze4Kn2n8zy+FFWTZ2DpupfbqrwREEYuNwgtMAp/ErdOoLkxz+Kw9gnA9w
         1VJcS6zHKMdlcsMGGHPbrpQJTaIXLOsc29wXgCmzoXYZ68ixuJ/ED5qg1xFDspL7YBvh
         BFj260LVRiwIm0URU6vSvga7xe6sZTtVTeHX6AtcqdqAET8HhPijVbI0IYpSUx+9Xk9G
         DWlVPnM8Wl3b5SMkRQfJvnj0xmfAz6UfrtBEaFFqTRHSjz/YPYxoJuc7VCwxqPmZQU1/
         3RQEqrKe57ZFk5FyehJ7Zk6Vhow1HIIwL1sL7JqYr5tShdB4fGRl2gKQfNzmZCCC7O/3
         qFKg==
X-Forwarded-Encrypted: i=1; AJvYcCXBfzqii4Wo4Xpc19uekb6+TaBCOb43aFDXBE+dHUbPr6RoJ0iqmMVpkPSSB5PTOq40dhDdbH3sw2TroQMifTky@vger.kernel.org
X-Gm-Message-State: AOJu0YwLlZXimQjS/JD2gZHq5e4f88meqonY7f/vpVeL0fLck9f2Ai9b
	qhGadfu2yusmp+umXZTCIe2F2Ej5fdH0QQA4erIQe2evHxKLLeKImqHM/1Zd9AwKAXxvlXL96S+
	gTf+qjXZJgku0Dz2yVBuMHOcyC187MXZEAoQI
X-Gm-Gg: ASbGncsVcKnFwuNedhNK65wsNk4js6CCglK5ZBlKqINtwl/fLsaAlWPDoiNeVNWqNV+
	MHV/ImGSllSxpg6Wx0q39pdPNoAxoNkY8VqCNNmCO/YCmWeQVFUiKN9Qs9qGGJncOEFYrU1hSX+
	a6O7/1pDO7rnWB/W87a09jscejj2e/oQ==
X-Google-Smtp-Source: AGHT+IEliTX20/M46pS6smu1XhYGMAP87siUmA36hsiogxIAv+7pJuQ2Bk+gaKAVEQ1lsKxwOmurxqe7cOsd0E3k6xk=
X-Received: by 2002:a2e:bd0b:0:b0:302:2598:de91 with SMTP id
 38308e7fff4ca-307cf2fdf22mr15096571fa.16.1738774029161; Wed, 05 Feb 2025
 08:47:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738592865.git.dvyukov@google.com> <4b49d5dd316f5d7119d8b16d5d70f13574158dc6.1738592865.git.dvyukov@google.com>
 <Z6GXRZ9NWVQVAanZ@google.com>
In-Reply-To: <Z6GXRZ9NWVQVAanZ@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 5 Feb 2025 17:46:57 +0100
X-Gm-Features: AWEUYZkrOgfHWMJh4w3xx52qbdfmDXp6MGmB9fFATudyXPQ0T9lLImZx4JbaSmg
Message-ID: <CACT4Y+bYkihUan84uj6ZHEmYpzAPS9opmXG+RUkPc2JtjV59LQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] perf report: Add latency and parallelism profiling documentation
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, acme@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Feb 2025 at 05:27, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Mon, Feb 03, 2025 at 03:30:42PM +0100, Dmitry Vyukov wrote:
> > Describe latency and parallelism profiling, related flags, and differences
> > with the currently only supported CPU-consumption-centric profiling.
>
> It doesn't seem to have descriptions for the --latency option (for perf
> record and report).  Probably better to put them in the previous patch.

Done in v5.

> >
> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: linux-perf-users@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  .../callchain-overhead-calculation.txt        |  5 +-
> >  .../cpu-and-latency-overheads.txt             | 85 +++++++++++++++++++
> >  tools/perf/Documentation/perf-report.txt      | 49 +++++++----
> >  tools/perf/Documentation/tips.txt             |  3 +
> >  4 files changed, 123 insertions(+), 19 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/callchain-overhead-calculation.txt b/tools/perf/Documentation/callchain-overhead-calculation.txt
> > index 1a757927195ed..e0202bf5bd1a0 100644
> > --- a/tools/perf/Documentation/callchain-overhead-calculation.txt
> > +++ b/tools/perf/Documentation/callchain-overhead-calculation.txt
> > @@ -1,7 +1,8 @@
> >  Overhead calculation
> >  --------------------
> > -The overhead can be shown in two columns as 'Children' and 'Self' when
> > -perf collects callchains.  The 'self' overhead is simply calculated by
> > +The CPU overhead can be shown in two columns as 'Children' and 'Self'
> > +when perf collects callchains (and corresponding 'Wall' columns for
> > +wall-clock overhead).  The 'self' overhead is simply calculated by
> >  adding all period values of the entry - usually a function (symbol).
> >  This is the value that perf shows traditionally and sum of all the
> >  'self' overhead values should be 100%.
> > diff --git a/tools/perf/Documentation/cpu-and-latency-overheads.txt b/tools/perf/Documentation/cpu-and-latency-overheads.txt
> > new file mode 100644
> > index 0000000000000..3b6d637054651
> > --- /dev/null
> > +++ b/tools/perf/Documentation/cpu-and-latency-overheads.txt
> > @@ -0,0 +1,85 @@
> > +CPU and latency overheads
> > +-------------------------
> > +There are two notions of time: wall-clock time and CPU time.
> > +For a single-threaded program, or a program running on a single-core machine,
> > +these notions are the same. However, for a multi-threaded/multi-process program
> > +running on a multi-core machine, these notions are significantly different.
> > +Each second of wall-clock time we have number-of-cores seconds of CPU time.
> > +Perf can measure overhead for both of these times (shown in 'overhead' and
> > +'latency' columns for CPU and wall-clock time correspondingly).
> > +
> > +Optimizing CPU overhead is useful to improve 'throughput', while optimizing
> > +latency overhead is useful to improve 'latency'. It's important to understand
> > +which one is useful in a concrete situation at hand. For example, the former
> > +may be useful to improve max throughput of a CI build server that runs on 100%
> > +CPU utilization, while the latter may be useful to improve user-perceived
> > +latency of a single interactive program build.
> > +These overheads may be significantly different in some cases. For example,
> > +consider a program that executes function 'foo' for 9 seconds with 1 thread,
> > +and then executes function 'bar' for 1 second with 128 threads (consumes
> > +128 seconds of CPU time). The CPU overhead is: 'foo' - 6.6%, 'bar' - 93.4%.
> > +While the latency overhead is: 'foo' - 90%, 'bar' - 10%. If we try to optimize
> > +running time of the program looking at the (wrong in this case) CPU overhead,
> > +we would concentrate on the function 'bar', but it can yield only 10% running
> > +time improvement at best.
> > +
> > +By default, perf shows only CPU overhead. To show latency overhead, use
> > +'perf record --latency' and 'perf report':
> > +
> > +-----------------------------------
> > +Overhead  Latency  Command
> > +  93.88%   25.79%  cc1
> > +   1.90%   39.87%  gzip
> > +   0.99%   10.16%  dpkg-deb
> > +   0.57%    1.00%  as
> > +   0.40%    0.46%  sh
> > +-----------------------------------
> > +
> > +To sort by latency overhead, use 'perf report --latency':
> > +
> > +-----------------------------------
> > +Latency  Overhead  Command
> > + 39.87%     1.90%  gzip
> > + 25.79%    93.88%  cc1
> > + 10.16%     0.99%  dpkg-deb
> > +  4.17%     0.29%  git
> > +  2.81%     0.11%  objtool
> > +-----------------------------------
> > +
> > +To get insight into the difference between the overheads, you may check
> > +parallelization histogram with '--sort=latency,parallelism,comm,symbol --hierarchy'
>
> I think you need to omit latency in the sort key and recommend users to
> use --latency option instead.
>
>   'perf report --hierarchy --latency --sort=parallelism,comm,symbol'

This does not work as is b/c --hierarchy is very sensitive to field
set/order and --latency adds both latency and overhead fields now.

The current command shows (intended):

   Latency           Parallelism / Command
+   54.24%           1
+   12.67%           3
+    8.69%           2
+    2.89%           4
+    2.34%           5

and when you expand the first line:

   Latency           Parallelism / Command
-   54.24%           1
   +   25.15%           cc1
   +    7.72%           ld
   +    4.03%           sh

While  --hierarchy --latency --sort=parallelism,comm,symbol shows just 1 line:

   Latency              Overhead / Parallelism / Command
+  100.00%               100.00%

and when you expand it:

   Latency              Overhead / Parallelism / Command
-  100.00%               100.00%
   +   54.24%              1
   +   12.67%              3
   +    8.69%              2
   +    2.89%              4


And showing both latency and overhead when --latency flag is specified
looks reasonable and useful. Just perf report [--latency] is probably
much more widely used than --hierarchy.
And currently for perf report --latency you see:

 Latency  Overhead  Symbol
   4.37%    38.17%  [k] native_queued_spin_lock_slowpath
   2.71%     0.86%  [.] _PyEval_EvalFrameDefault
   2.18%     0.47%  [.] iterative_hash
   2.00%     0.68%  [k] clear_page_erms
   1.26%     0.16%  [.] bfd_elf_link_add_symbols
   1.04%     0.11%  [.] bfd_link_hash_traverse

Making --latency behave differently when --hierarchy is specified will
complicate things even more.



> > +flags. It shows fraction of (wall-clock) time the workload utilizes different
> > +numbers of cores ('Parallelism' column). For example, in the following case
> > +the workload utilizes only 1 core most of the time, but also has some
> > +highly-parallel phases, which explains significant difference between
> > +CPU and wall-clock overheads:
> > +
> > +-----------------------------------
> > +  Latency  Overhead     Parallelism / Command / Symbol
> > ++  56.98%     2.29%     1
> > ++  16.94%     1.36%     2
> > ++   4.00%    20.13%     125
> > ++   3.66%    18.25%     124
> > ++   3.48%    17.66%     126
> > ++   3.26%     0.39%     3
> > ++   2.61%    12.93%     123
> > +-----------------------------------
> > +
> > +By expanding corresponding lines, you may see what commands/functions run
> > +at the given parallelism level:
> > +
> > +-----------------------------------
> > +  Latency  Overhead     Parallelism / Command / Symbol
> > +-  56.98%     2.29%     1
> > +      32.80%     1.32%     gzip
> > +       4.46%     0.18%     cc1
> > +       2.81%     0.11%     objtool
> > +       2.43%     0.10%     dpkg-source
> > +       2.22%     0.09%     ld
> > +       2.10%     0.08%     dpkg-genchanges
> > +-----------------------------------
> > +
> > +To see the normal function-level profile for particular parallelism levels
> > +(number of threads actively running on CPUs), you may use '--parallelism'
> > +filter. For example, to see the profile only for low parallelism phases
> > +of a workload use '--latency --parallelism=1-2' flags.
> > diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> > index 87f8645194062..7e0ba990d71e8 100644
> > --- a/tools/perf/Documentation/perf-report.txt
> > +++ b/tools/perf/Documentation/perf-report.txt
> > @@ -44,7 +44,7 @@ OPTIONS
> >  --comms=::
> >       Only consider symbols in these comms. CSV that understands
> >       file://filename entries.  This option will affect the percentage of
> > -     the overhead column.  See --percentage for more info.
> > +     the overhead and latency columns.  See --percentage for more info.
> >  --pid=::
> >          Only show events for given process ID (comma separated list).
> >
> > @@ -54,12 +54,12 @@ OPTIONS
> >  --dsos=::
> >       Only consider symbols in these dsos. CSV that understands
> >       file://filename entries.  This option will affect the percentage of
> > -     the overhead column.  See --percentage for more info.
> > +     the overhead and latency columns.  See --percentage for more info.
> >  -S::
> >  --symbols=::
> >       Only consider these symbols. CSV that understands
> >       file://filename entries.  This option will affect the percentage of
> > -     the overhead column.  See --percentage for more info.
> > +     the overhead and latency columns.  See --percentage for more info.
> >
> >  --symbol-filter=::
> >       Only show symbols that match (partially) with this filter.
> > @@ -68,6 +68,16 @@ OPTIONS
> >  --hide-unresolved::
> >          Only display entries resolved to a symbol.
> >
> > +--parallelism::
> > +        Only consider these parallelism levels. Parallelism level is the number
> > +        of threads that actively run on CPUs at the time of sample. The flag
> > +        accepts single number, comma-separated list, and ranges (for example:
> > +        "1", "7,8", "1,64-128"). This is useful in understanding what a program
> > +        is doing during sequential/low-parallelism phases as compared to
> > +        high-parallelism phases. This option will affect the percentage of
> > +        the overhead and latency columns. See --percentage for more info.
> > +        Also see the `CPU and latency overheads' section for more details.
> > +
> >  -s::
> >  --sort=::
> >       Sort histogram entries by given key(s) - multiple keys can be specified
> > @@ -87,6 +97,7 @@ OPTIONS
> >       entries are displayed as "[other]".
> >       - cpu: cpu number the task ran at the time of sample
> >       - socket: processor socket number the task ran at the time of sample
> > +     - parallelism: number of running threads at the time of sample
> >       - srcline: filename and line number executed at the time of sample.  The
> >       DWARF debugging info must be provided.
> >       - srcfile: file name of the source file of the samples. Requires dwarf
> > @@ -97,12 +108,14 @@ OPTIONS
> >       - cgroup_id: ID derived from cgroup namespace device and inode numbers.
> >       - cgroup: cgroup pathname in the cgroupfs.
> >       - transaction: Transaction abort flags.
> > -     - overhead: Overhead percentage of sample
> > -     - overhead_sys: Overhead percentage of sample running in system mode
> > -     - overhead_us: Overhead percentage of sample running in user mode
> > -     - overhead_guest_sys: Overhead percentage of sample running in system mode
> > +     - overhead: CPU overhead percentage of sample.
> > +     - latency: latency (wall-clock) overhead percentage of sample.
> > +       See the `CPU and latency overheads' section for more details.
> > +     - overhead_sys: CPU overhead percentage of sample running in system mode
> > +     - overhead_us: CPU overhead percentage of sample running in user mode
> > +     - overhead_guest_sys: CPU overhead percentage of sample running in system mode
> >       on guest machine
> > -     - overhead_guest_us: Overhead percentage of sample running in user mode on
> > +     - overhead_guest_us: CPU overhead percentage of sample running in user mode on
> >       guest machine
> >       - sample: Number of sample
> >       - period: Raw number of event count of sample
> > @@ -125,8 +138,8 @@ OPTIONS
> >       - weight2: Average value of event specific weight (2nd field of weight_struct).
> >       - weight3: Average value of event specific weight (3rd field of weight_struct).
> >
> > -     By default, comm, dso and symbol keys are used.
> > -     (i.e. --sort comm,dso,symbol)
> > +     By default, overhead, comm, dso and symbol keys are used.
> > +     (i.e. --sort overhead,comm,dso,symbol).
> >
> >       If --branch-stack option is used, following sort keys are also
> >       available:
> > @@ -201,9 +214,9 @@ OPTIONS
> >  --fields=::
> >       Specify output field - multiple keys can be specified in CSV format.
> >       Following fields are available:
> > -     overhead, overhead_sys, overhead_us, overhead_children, sample, period,
> > -     weight1, weight2, weight3, ins_lat, p_stage_cyc and retire_lat.  The
> > -     last 3 names are alias for the corresponding weights.  When the weight
> > +     overhead, latency, overhead_sys, overhead_us, overhead_children, sample,
> > +     period, weight1, weight2, weight3, ins_lat, p_stage_cyc and retire_lat.
> > +     The last 3 names are alias for the corresponding weights.  When the weight
> >       fields are used, they will show the average value of the weight.
> >
> >       Also it can contain any sort key(s).
> > @@ -289,7 +302,7 @@ OPTIONS
> >       Accumulate callchain of children to parent entry so that then can
> >       show up in the output.  The output will have a new "Children" column
> >       and will be sorted on the data.  It requires callchains are recorded.
> > -     See the `overhead calculation' section for more details. Enabled by
> > +     See the `Overhead calculation' section for more details. Enabled by
> >       default, disable with --no-children.
> >
> >  --max-stack::
> > @@ -442,9 +455,9 @@ OPTIONS
> >       --call-graph option for details.
> >
> >  --percentage::
> > -     Determine how to display the overhead percentage of filtered entries.
> > -     Filters can be applied by --comms, --dsos and/or --symbols options and
> > -     Zoom operations on the TUI (thread, dso, etc).
> > +     Determine how to display the CPU and latency overhead percentage
> > +     of filtered entries. Filters can be applied by --comms, --dsos, --symbols
> > +     and/or --parallelism options and Zoom operations on the TUI (thread, dso, etc).
> >
> >       "relative" means it's relative to filtered entries only so that the
> >       sum of shown entries will be always 100%.  "absolute" means it retains
> > @@ -627,6 +640,8 @@ include::itrace.txt[]
> >  --skip-empty::
> >       Do not print 0 results in the --stat output.
> >
> > +include::cpu-and-latency-overheads.txt[]
> > +
> >  include::callchain-overhead-calculation.txt[]
> >
> >  SEE ALSO
> > diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
> > index 67b326ba00407..f6f71e70ff2cb 100644
> > --- a/tools/perf/Documentation/tips.txt
> > +++ b/tools/perf/Documentation/tips.txt
> > @@ -62,3 +62,6 @@ To show context switches in perf report sample context add --switch-events to pe
> >  To show time in nanoseconds in record/report add --ns
> >  To compare hot regions in two workloads use perf record -b -o file ... ; perf diff --stream file1 file2
> >  To compare scalability of two workload samples use perf diff -c ratio file1 file2
> > +For latency profiling, try: perf record/report --latency
> > +For parallelism histogram, try: perf report --hierarchy --sort latency,parallelism,comm,symbol
>
> Ditto.
>
> Thanks,
> Namhyung
>
>
> > +To analyze particular parallelism levels, try: perf report --latency --parallelism=32-64
> > --
> > 2.48.1.362.g079036d154-goog
> >
