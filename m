Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B3213B288
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736324686; cv=none; b=OGv0PzgwSylSoivSrqXBfxKZExjaYNQjLESJtozQM+ns+l88X9pvGvgJRliKrSXJpiELz/H0JUkl5uKa2h+atJ9rYJQ7Z9Zg46Eis7jMAjy/m91dAg4KgGUwz5RQWSihM7ix7l0iU4JeEA0BU6VcdOp+dl/0d0hRJGmiIifsWOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736324686; c=relaxed/simple;
	bh=YpmZ9FRgsYmoMJsyMU3XaaDZ2+MIoBgM6UjEyfJ/BkY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=M+cyBfYSxEb70cqklYJjJzOND2Exsdpv6sSeb7GOKVIjAnRm0xY7hbY5Yu/hEqwhGFgbqRIifTBYmxC5fAFcsqEpHf+7pCvHgjwBunS/dRDP/hl78P4wPTZprr+MEUPHqsQEfAAWjJHqanEMVEjS7o5OWgzQZUItbXWmXSPvKwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XZLteAjk; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XZLteAjk"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aa68b4b957fso736225266b.3
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 00:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736324681; x=1736929481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fMTYHGdDf4vzI7KDEzLonkBH6LgGSn0lMDRM4BqGCm8=;
        b=XZLteAjk8WAGP7sdevuOztEFe/7IwSK6JBZ04Qt7enEKiaJ2iH8X5EjwMMe0BdM7us
         hskPQKGghMQ598Sv7XQ/LzKY2kMPPu9Bk34P/DLLSeCMJZU8S5r/Q0PC/7L3+cnN7X+j
         3P5lAyq7WXIR+lqkJwljFlQTQ8dCEUM82G8P8uQTzh7Gb2nnjcP+loPvBoQs7i2LQPeD
         m81iyAqXA4isS12t8rUOWYKqCNmIaJ+rz5OH91gNIImBeYrFJXi8crNXlo0Syg9Dc2NK
         FHaQtCswezZnWwPcot0jMVQSZ+CUlJxpRM4tDWbUpBcKhVgTI+WY20TOTUMZEvK2Rm2E
         VbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736324681; x=1736929481;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fMTYHGdDf4vzI7KDEzLonkBH6LgGSn0lMDRM4BqGCm8=;
        b=thSgQXDhr5aSVkr6ThesNqx4hBsC8vo5tmpWnWusPvSWhVmcoRl0LQ6Tw+KNY/rlSR
         estUaR5evoicfIuGSEwPmVzw/Godgo5f/egDhEsy8Vw+N7+ppCd2CvB1NlkB/39YQ6fP
         Pv8cci6mcC+BQoTG1ho/l4Jz3EjJj/B4vyy2FRFM7Fc3mtA9KNlHVMSRBkK7CEN3hoGt
         2E14KehZXwSxDQd3USIS8/cWhqNTvnKtvecek+DAj0KcujZcUZaJPvvsHrchNfuEKno/
         JJKz6k483v8zZVKXuMC8MS2IhmUv0On90gPMBHTt/zMSmiAKOOLGBEAcSfWPFjV1cn1n
         /BWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWfoCrlJE3mwagIBn29kEfUrdsXChEdP+QrUz+KtW6nC1uDnyNReUYQcSAdYG3uTeMw+QiYrFoa69q8Uxj5iec@vger.kernel.org
X-Gm-Message-State: AOJu0YwH2rdUPtkPC8cMQzwH5jQXk7/mH4RpRpjc2KXQlY16isJq1Icn
	uUjl2+HZWIp+wmNlaBJqu9Xz52hyoFS1pp34kn5aQVdLuyFiIwCpmhTfR59m2Yj/aYWEhQIOhMV
	T7aVzKg==
X-Google-Smtp-Source: AGHT+IE4mbucMeyfSt7LhJf+TYivVSwdkaOSkIIP7jfsr3C5bLfCFYDIIf4XgQm7T5Ag+euCTM3A4Df2VQZn
X-Received: from ejcts13.prod.google.com ([2002:a17:907:c5cd:b0:aab:88ee:628d])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:2cc5:b0:aa5:2a57:1779
 with SMTP id a640c23a62f3a-ab2abdc048bmr127676666b.59.1736324679589; Wed, 08
 Jan 2025 00:24:39 -0800 (PST)
Date: Wed,  8 Jan 2025 09:24:17 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108082435.268431-1-dvyukov@google.com>
Subject: [PATCH] tools/perf: Add wall-clock and parallelism profiling
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com
Cc: Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

There are two notions of time: wall-clock time and CPU time.
For a single-threaded program, or a program running on a single-core
machine, these notions are the same. However, for a multi-threaded/
multi-process program running on a multi-core machine, these notions are
significantly different. Each second of wall-clock time we have
number-of-cores seconds of CPU time.

Currently perf only allows to profile CPU time. Perf (and all other
existing profilers to be best of my knowledge) does not allow to profile
wall-clock time.

Optimizing CPU overhead is useful to improve 'throughput', while
optimizing wall-clock overhead is useful to improve 'latency'.
These profiles are complementary and are not interchangeable.
Examples of where wall-clock profile is needed:
 - optimzing build latency
 - optimizing server request latency
 - optimizing ML training/inference latency
 - optimizing running time of any command line program

CPU profile is useless for these use cases at best (if a user understands
the difference), or misleading at worst (if a user tries to use a wrong
profile for a job).

This patch adds wall-clock and parallelization profiling.
See the added documentation and flags descriptions for details.

Brief outline of the implementation:
 - add context switch collection during record
 - calculate number of threads running on CPUs (parallelism level)
   during report
 - divide each sample weight by the parallelism level
This effectively models that we were taking 1 sample per unit of
wall-clock time.

The feature is added on an equal footing with the existing CPU profiling
rather than a separate mode enabled with special flags. The reasoning is
that users may not understand the problem and the meaning of numbers they
are seeing in the first place, so won't even realize that they may need
to be looking for some different profiling mode. When they are presented
with 2 sets of different numbers, they should start asking questions.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../callchain-overhead-calculation.txt        |  5 +-
 .../cpu-and-wallclock-overheads.txt           | 85 +++++++++++++++++
 tools/perf/Documentation/perf-report.txt      | 50 ++++++----
 tools/perf/Documentation/tips.txt             |  3 +
 tools/perf/builtin-record.c                   |  6 ++
 tools/perf/builtin-report.c                   | 30 ++++++
 tools/perf/ui/browsers/hists.c                | 27 ++++--
 tools/perf/ui/hist.c                          | 61 +++++++++++--
 tools/perf/util/addr_location.c               |  1 +
 tools/perf/util/addr_location.h               |  6 +-
 tools/perf/util/event.c                       |  6 ++
 tools/perf/util/events_stats.h                |  2 +
 tools/perf/util/hist.c                        | 91 ++++++++++++++++---
 tools/perf/util/hist.h                        | 25 ++++-
 tools/perf/util/machine.c                     |  7 ++
 tools/perf/util/machine.h                     |  6 ++
 tools/perf/util/session.c                     | 12 +++
 tools/perf/util/session.h                     |  1 +
 tools/perf/util/sort.c                        | 59 +++++++++++-
 tools/perf/util/sort.h                        |  1 +
 tools/perf/util/symbol.c                      | 34 +++++++
 tools/perf/util/symbol_conf.h                 |  7 +-
 22 files changed, 467 insertions(+), 58 deletions(-)
 create mode 100644 tools/perf/Documentation/cpu-and-wallclock-overheads.txt

diff --git a/tools/perf/Documentation/callchain-overhead-calculation.txt b/tools/perf/Documentation/callchain-overhead-calculation.txt
index 1a757927195ed..e0202bf5bd1a0 100644
--- a/tools/perf/Documentation/callchain-overhead-calculation.txt
+++ b/tools/perf/Documentation/callchain-overhead-calculation.txt
@@ -1,7 +1,8 @@
 Overhead calculation
 --------------------
-The overhead can be shown in two columns as 'Children' and 'Self' when
-perf collects callchains.  The 'self' overhead is simply calculated by
+The CPU overhead can be shown in two columns as 'Children' and 'Self'
+when perf collects callchains (and corresponding 'Wall' columns for
+wall-clock overhead).  The 'self' overhead is simply calculated by
 adding all period values of the entry - usually a function (symbol).
 This is the value that perf shows traditionally and sum of all the
 'self' overhead values should be 100%.
diff --git a/tools/perf/Documentation/cpu-and-wallclock-overheads.txt b/tools/perf/Documentation/cpu-and-wallclock-overheads.txt
new file mode 100644
index 0000000000000..4f739ff4de437
--- /dev/null
+++ b/tools/perf/Documentation/cpu-and-wallclock-overheads.txt
@@ -0,0 +1,85 @@
+CPU and wall-clock overheads
+----------------------------
+There are two notions of time: wall-clock time and CPU time.
+For a single-threaded program, or a program running on a single-core machine,
+these notions are the same. However, for a multi-threaded/multi-process program
+running on a multi-core machine, these notions are significantly different.
+Each second of wall-clock time we have number-of-cores seconds of CPU time.
+Perf can measure overhead for both of these times (shown in 'overhead' and
+'wallclock' columns for CPU and wall-clock correspondingly).
+
+Optimizing CPU overhead is useful to improve 'throughput', while optimizing
+wall-clock overhead is useful to improve 'latency'. It's important to understand
+which one is useful in a concrete situation at hand. For example, the former
+may be useful to improve max throughput of a CI build server that runs on 100%
+CPU utilization, while the latter may be useful to improve user-perceived
+latency of a single interactive program build.
+These overheads may be significantly different in some cases. For example,
+consider a program that executes function 'foo' for 9 seconds with 1 thread,
+and then executes function 'bar' for 1 second with 128 threads (consumes
+128 seconds of CPU time). The CPU overhead is: 'foo' - 6.6%, 'bar' - 93.4%.
+While wall-clock overhead is: 'foo' - 90%, 'bar' - 10%. If we try to optimize
+running time of the program looking at the (wrong in this case) CPU overhead,
+we would concentrate on the function 'bar', but it can yield only 10% running
+time improvement at best.
+
+By default, perf shows both overheads (for parallel programs), but sorts by
+CPU overhead:
+
+-----------------------------------
+Overhead  Wallclock  Command
+  93.88%     25.79%  cc1
+   1.90%     39.87%  gzip
+   0.99%     10.16%  dpkg-deb
+   0.57%      1.00%  as
+   0.40%      0.46%  sh
+-----------------------------------
+
+To sort by wall-clock overhead, use '--sort=wallclock' flag:
+
+-----------------------------------
+Wallclock  Overhead  Command
+   39.87%     1.90%  gzip
+   25.79%    93.88%  cc1
+   10.16%     0.99%  dpkg-deb
+    4.17%     0.29%  git
+    2.81%     0.11%  objtool
+-----------------------------------
+
+To get insight into the difference between the overheads, you may check
+parallelization histogram with '--sort=wallclock,parallelism,comm,symbol --hierarchy'
+flags. It shows fraction of (wall-clock) time the workload utilizes different
+numbers of cores ('parallelism' column). For example, in the following case
+the workload utilizes only 1 core most of the time, but also has some
+highly-parallel phases, which explains significant difference between
+CPU and wall-clock overheads:
+
+-----------------------------------
+  Wallclock  Overhead     Parallelism / Command / Symbol
++    56.98%     2.29%     1
++    16.94%     1.36%     2
++     4.00%    20.13%     125
++     3.66%    18.25%     124
++     3.48%    17.66%     126
++     3.26%     0.39%     3
++     2.61%    12.93%     123
+-----------------------------------
+
+By expanding corresponding lines, you may see what programs/functions run
+at the given parallelism level:
+
+-----------------------------------
+  Wallclock  Overhead     Parallelism / Command / Symbol
+-    56.98%     2.29%     1
+        32.80%     1.32%     gzip
+         4.46%     0.18%     cc1
+         2.81%     0.11%     objtool
+         2.43%     0.10%     dpkg-source
+         2.22%     0.09%     ld
+         2.10%     0.08%     dpkg-genchanges
+-----------------------------------
+
+To see the normal function-level profile for particular parallelism levels
+(number of threads actively running on CPUs), you may use '--parallelism'
+filter. For example, to see the profile only for low parallelism phases
+of a workload use '--sort=wallclock,comm,symbol --parallelism=1-2' flags.
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 87f8645194062..e79ff412af0a5 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -44,7 +44,7 @@ OPTIONS
 --comms=::
 	Only consider symbols in these comms. CSV that understands
 	file://filename entries.  This option will affect the percentage of
-	the overhead column.  See --percentage for more info.
+	the overhead and wallclock columns.  See --percentage for more info.
 --pid=::
         Only show events for given process ID (comma separated list).
 
@@ -54,12 +54,12 @@ OPTIONS
 --dsos=::
 	Only consider symbols in these dsos. CSV that understands
 	file://filename entries.  This option will affect the percentage of
-	the overhead column.  See --percentage for more info.
+	the overhead and wallclock columns.  See --percentage for more info.
 -S::
 --symbols=::
 	Only consider these symbols. CSV that understands
 	file://filename entries.  This option will affect the percentage of
-	the overhead column.  See --percentage for more info.
+	the overhead and wallclock columns.  See --percentage for more info.
 
 --symbol-filter=::
 	Only show symbols that match (partially) with this filter.
@@ -68,6 +68,16 @@ OPTIONS
 --hide-unresolved::
         Only display entries resolved to a symbol.
 
+--parallelism::
+        Only consider these parallelism levels. Parallelism level is the number
+        of threads that actively run on CPUs at the time of sample. The flag
+        accepts single number, comma-separated list, and ranges (for example:
+        "1", "7,8", "1,64-128"). This is useful in understanding what a program
+        is doing during sequential/low-parallelism phases as compared to
+        high-parallelism phases. This option will affect the percentage of
+        the overhead and wallclock columns. See --percentage for more info.
+        Also see the `CPU and wall-clock overheads' section for more details.
+
 -s::
 --sort=::
 	Sort histogram entries by given key(s) - multiple keys can be specified
@@ -87,6 +97,7 @@ OPTIONS
 	entries are displayed as "[other]".
 	- cpu: cpu number the task ran at the time of sample
 	- socket: processor socket number the task ran at the time of sample
+	- parallelism: number of running threads at the time of sample
 	- srcline: filename and line number executed at the time of sample.  The
 	DWARF debugging info must be provided.
 	- srcfile: file name of the source file of the samples. Requires dwarf
@@ -97,12 +108,14 @@ OPTIONS
 	- cgroup_id: ID derived from cgroup namespace device and inode numbers.
 	- cgroup: cgroup pathname in the cgroupfs.
 	- transaction: Transaction abort flags.
-	- overhead: Overhead percentage of sample
-	- overhead_sys: Overhead percentage of sample running in system mode
-	- overhead_us: Overhead percentage of sample running in user mode
-	- overhead_guest_sys: Overhead percentage of sample running in system mode
+	- overhead: CPU overhead percentage of sample
+	- wallclock: Wall-clock (latency) overhead percentage of sample.
+	  See the `CPU and wall-clock overheads' section for more details.
+	- overhead_sys: CPU overhead percentage of sample running in system mode
+	- overhead_us: CPU overhead percentage of sample running in user mode
+	- overhead_guest_sys: CPU overhead percentage of sample running in system mode
 	on guest machine
-	- overhead_guest_us: Overhead percentage of sample running in user mode on
+	- overhead_guest_us: CPU overhead percentage of sample running in user mode on
 	guest machine
 	- sample: Number of sample
 	- period: Raw number of event count of sample
@@ -125,8 +138,9 @@ OPTIONS
 	- weight2: Average value of event specific weight (2nd field of weight_struct).
 	- weight3: Average value of event specific weight (3rd field of weight_struct).
 
-	By default, comm, dso and symbol keys are used.
-	(i.e. --sort comm,dso,symbol)
+	By default, overhead, comm, dso and symbol keys are used.
+	(i.e. --sort overhead,comm,dso,symbol). If only wallclock is specified,
+	(i.e. --sort wallclock), it expands to wallclock,comm,dso,symbol.
 
 	If --branch-stack option is used, following sort keys are also
 	available:
@@ -201,9 +215,9 @@ OPTIONS
 --fields=::
 	Specify output field - multiple keys can be specified in CSV format.
 	Following fields are available:
-	overhead, overhead_sys, overhead_us, overhead_children, sample, period,
-	weight1, weight2, weight3, ins_lat, p_stage_cyc and retire_lat.  The
-	last 3 names are alias for the corresponding weights.  When the weight
+	overhead, wallclock, overhead_sys, overhead_us, overhead_children, sample,
+	period, weight1, weight2, weight3, ins_lat, p_stage_cyc and retire_lat.
+	The last 3 names are alias for the corresponding weights.  When the weight
 	fields are used, they will show the average value of the weight.
 
 	Also it can contain any sort key(s).
@@ -289,7 +303,7 @@ OPTIONS
 	Accumulate callchain of children to parent entry so that then can
 	show up in the output.  The output will have a new "Children" column
 	and will be sorted on the data.  It requires callchains are recorded.
-	See the `overhead calculation' section for more details. Enabled by
+	See the `Overhead calculation' section for more details. Enabled by
 	default, disable with --no-children.
 
 --max-stack::
@@ -442,9 +456,9 @@ OPTIONS
 	--call-graph option for details.
 
 --percentage::
-	Determine how to display the overhead percentage of filtered entries.
-	Filters can be applied by --comms, --dsos and/or --symbols options and
-	Zoom operations on the TUI (thread, dso, etc).
+	Determine how to display the CPU and wall-clock overhead percentage
+	of filtered entries. Filters can be applied by --comms, --dsos, --symbols
+	and/or --parallelism options and Zoom operations on the TUI (thread, dso, etc).
 
 	"relative" means it's relative to filtered entries only so that the
 	sum of shown entries will be always 100%.  "absolute" means it retains
@@ -627,6 +641,8 @@ include::itrace.txt[]
 --skip-empty::
 	Do not print 0 results in the --stat output.
 
+include::cpu-and-wallclock-overheads.txt[]
+
 include::callchain-overhead-calculation.txt[]
 
 SEE ALSO
diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
index 67b326ba00407..50916c58b81c5 100644
--- a/tools/perf/Documentation/tips.txt
+++ b/tools/perf/Documentation/tips.txt
@@ -62,3 +62,6 @@ To show context switches in perf report sample context add --switch-events to pe
 To show time in nanoseconds in record/report add --ns
 To compare hot regions in two workloads use perf record -b -o file ... ; perf diff --stream file1 file2
 To compare scalability of two workload samples use perf diff -c ratio file1 file2
+For latency analysis, try: perf report --sort wallclock
+For parallelism histogram, try: perf report --hierarchy --sort wallclock,parallelism,comm,symbol
+To analyze particular parallelism levels, try: perf report --sort=wallclock,symbol --parallelism=32-64
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f832524729211..225e3997f03cb 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3342,6 +3342,12 @@ static struct record record = {
 		.ctl_fd              = -1,
 		.ctl_fd_ack          = -1,
 		.synth               = PERF_SYNTH_ALL,
+		/*
+		 * This is enabled by default because it's required to show
+		 * wallclock overhead and parallelism profile, and does not
+		 * add lots of overhead on top of samples data.
+		 */
+		.record_switch_events	= true,
 	},
 };
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 42d7dfdf07d9b..d86937174a1e1 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -112,6 +112,8 @@ struct report {
 	u64			nr_entries;
 	u64			queue_size;
 	u64			total_cycles;
+	u64			total_samples;
+	u64			singlethreaded_samples;
 	int			socket_filter;
 	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
 	struct branch_type_stat	brtype_stat;
@@ -331,6 +333,10 @@ static int process_sample_event(const struct perf_tool *tool,
 				     &rep->total_cycles, evsel);
 	}
 
+	rep->total_samples++;
+	if (al.parallelism == 1)
+		rep->singlethreaded_samples++;
+
 	ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
 	if (ret < 0)
 		pr_debug("problem adding hist entry, skipping event\n");
@@ -1081,6 +1087,10 @@ static int __cmd_report(struct report *rep)
 		return ret;
 	}
 
+	/* Don't show Wallclock column for non-parallel profiles. */
+	if (rep->singlethreaded_samples * 100 / rep->total_samples >= 99)
+		perf_hpp__cancel_wallclock();
+
 	evlist__check_mem_load_aux(session->evlist);
 
 	if (rep->stats_mode)
@@ -1392,6 +1402,8 @@ int cmd_report(int argc, const char **argv)
 		     symbol__config_symfs),
 	OPT_STRING('C', "cpu", &report.cpu_list, "cpu",
 		   "list of cpus to profile"),
+	OPT_STRING(0, "parallelism", &symbol_conf.parallelism_list_str, "parallelism",
+		   "only consider these parallelism levels (cpu set format)"),
 	OPT_BOOLEAN('I', "show-info", &report.show_full_info,
 		    "Display extended information about perf.data file"),
 	OPT_BOOLEAN(0, "source", &annotate_opts.annotate_src,
@@ -1570,6 +1582,7 @@ int cmd_report(int argc, const char **argv)
 	report.tool.cgroup		 = perf_event__process_cgroup;
 	report.tool.exit		 = perf_event__process_exit;
 	report.tool.fork		 = perf_event__process_fork;
+	report.tool.context_switch	 = perf_event__process_switch;
 	report.tool.lost		 = perf_event__process_lost;
 	report.tool.read		 = process_read_event;
 	report.tool.attr		 = process_attr;
@@ -1721,6 +1734,23 @@ int cmd_report(int argc, const char **argv)
 		symbol_conf.annotate_data_sample = true;
 	}
 
+	if (report.disable_order || !perf_session__has_switch_events(session)) {
+		if (symbol_conf.parallelism_list_str ||
+			(sort_order && (strstr(sort_order, "wallclock") ||
+				strstr(sort_order, "parallelism"))) ||
+			(field_order && (strstr(field_order, "wallclock") ||
+				strstr(field_order, "parallelism")))) {
+			if (report.disable_order)
+				ui__error("Use of wallclock profile or parallelism"
+					" is incompatible with --disable-order.\n");
+			else
+				ui__error("Use of wallclock profile or parallelism"
+					" requires --switch-events during record.\n");
+			return -1;
+		}
+		symbol_conf.disable_wallclock = true;
+	}
+
 	if (last_key != K_SWITCH_INPUT_DATA) {
 		if (sort_order && strstr(sort_order, "ipc")) {
 			parse_options_usage(report_usage, options, "s", 1);
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 49ba82bf33918..abcc4a11849f4 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -1226,7 +1226,7 @@ int __hpp__slsmg_color_printf(struct perf_hpp *hpp, const char *fmt, ...)
 	return ret;
 }
 
-#define __HPP_COLOR_PERCENT_FN(_type, _field)				\
+#define __HPP_COLOR_PERCENT_FN(_type, _field, _fmttype)			\
 static u64 __hpp_get_##_field(struct hist_entry *he)			\
 {									\
 	return he->stat._field;						\
@@ -1238,10 +1238,10 @@ hist_browser__hpp_color_##_type(struct perf_hpp_fmt *fmt,		\
 				struct hist_entry *he)			\
 {									\
 	return hpp__fmt(fmt, hpp, he, __hpp_get_##_field, " %*.2f%%",	\
-			__hpp__slsmg_color_printf, true);		\
+			__hpp__slsmg_color_printf, _fmttype);		\
 }
 
-#define __HPP_COLOR_ACC_PERCENT_FN(_type, _field)			\
+#define __HPP_COLOR_ACC_PERCENT_FN(_type, _field, _fmttype)		\
 static u64 __hpp_get_acc_##_field(struct hist_entry *he)		\
 {									\
 	return he->stat_acc->_field;					\
@@ -1262,15 +1262,18 @@ hist_browser__hpp_color_##_type(struct perf_hpp_fmt *fmt,		\
 		return ret;						\
 	}								\
 	return hpp__fmt(fmt, hpp, he, __hpp_get_acc_##_field,		\
-			" %*.2f%%", __hpp__slsmg_color_printf, true);	\
+			" %*.2f%%", __hpp__slsmg_color_printf,		\
+			_fmttype);					\
 }
 
-__HPP_COLOR_PERCENT_FN(overhead, period)
-__HPP_COLOR_PERCENT_FN(overhead_sys, period_sys)
-__HPP_COLOR_PERCENT_FN(overhead_us, period_us)
-__HPP_COLOR_PERCENT_FN(overhead_guest_sys, period_guest_sys)
-__HPP_COLOR_PERCENT_FN(overhead_guest_us, period_guest_us)
-__HPP_COLOR_ACC_PERCENT_FN(overhead_acc, period)
+__HPP_COLOR_PERCENT_FN(overhead, period, PERF_HPP_FMT_TYPE__PERCENT)
+__HPP_COLOR_PERCENT_FN(wallclock, wallclock, PERF_HPP_FMT_TYPE__WALLCLOCK)
+__HPP_COLOR_PERCENT_FN(overhead_sys, period_sys, PERF_HPP_FMT_TYPE__PERCENT)
+__HPP_COLOR_PERCENT_FN(overhead_us, period_us, PERF_HPP_FMT_TYPE__PERCENT)
+__HPP_COLOR_PERCENT_FN(overhead_guest_sys, period_guest_sys, PERF_HPP_FMT_TYPE__PERCENT)
+__HPP_COLOR_PERCENT_FN(overhead_guest_us, period_guest_us, PERF_HPP_FMT_TYPE__PERCENT)
+__HPP_COLOR_ACC_PERCENT_FN(overhead_acc, period, PERF_HPP_FMT_TYPE__PERCENT)
+__HPP_COLOR_ACC_PERCENT_FN(wallclock_acc, wallclock, PERF_HPP_FMT_TYPE__WALLCLOCK)
 
 #undef __HPP_COLOR_PERCENT_FN
 #undef __HPP_COLOR_ACC_PERCENT_FN
@@ -1279,6 +1282,8 @@ void hist_browser__init_hpp(void)
 {
 	perf_hpp__format[PERF_HPP__OVERHEAD].color =
 				hist_browser__hpp_color_overhead;
+	perf_hpp__format[PERF_HPP__WALLCLOCK].color =
+				hist_browser__hpp_color_wallclock;
 	perf_hpp__format[PERF_HPP__OVERHEAD_SYS].color =
 				hist_browser__hpp_color_overhead_sys;
 	perf_hpp__format[PERF_HPP__OVERHEAD_US].color =
@@ -1289,6 +1294,8 @@ void hist_browser__init_hpp(void)
 				hist_browser__hpp_color_overhead_guest_us;
 	perf_hpp__format[PERF_HPP__OVERHEAD_ACC].color =
 				hist_browser__hpp_color_overhead_acc;
+	perf_hpp__format[PERF_HPP__WALLCLOCK_ACC].color =
+				hist_browser__hpp_color_wallclock_acc;
 
 	res_sample_init();
 }
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 34fda1d5eccb4..c85ad841fb4ed 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -27,9 +27,10 @@ static int __hpp__fmt_print(struct perf_hpp *hpp, struct hists *hists, u64 val,
 			    int nr_samples, const char *fmt, int len,
 			    hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype)
 {
-	if (fmtype == PERF_HPP_FMT_TYPE__PERCENT) {
+	if (fmtype == PERF_HPP_FMT_TYPE__PERCENT || fmtype == PERF_HPP_FMT_TYPE__WALLCLOCK) {
 		double percent = 0.0;
-		u64 total = hists__total_period(hists);
+		u64 total = fmtype == PERF_HPP_FMT_TYPE__PERCENT ? hists__total_period(hists) :
+			hists__total_wallclock(hists);
 
 		if (total)
 			percent = 100.0 * val / total;
@@ -128,7 +129,7 @@ int hpp__fmt(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 				  print_fn, fmtype);
 	}
 
-	if (fmtype == PERF_HPP_FMT_TYPE__PERCENT)
+	if (fmtype == PERF_HPP_FMT_TYPE__PERCENT || fmtype == PERF_HPP_FMT_TYPE__WALLCLOCK)
 		len -= 2; /* 2 for a space and a % sign */
 	else
 		len -= 1;
@@ -472,11 +473,13 @@ __HPP_ENTRY_AVERAGE_FN(_type, _field)					\
 __HPP_SORT_AVERAGE_FN(_type, _field)
 
 HPP_PERCENT_FNS(overhead, period)
+HPP_PERCENT_FNS(wallclock, wallclock)
 HPP_PERCENT_FNS(overhead_sys, period_sys)
 HPP_PERCENT_FNS(overhead_us, period_us)
 HPP_PERCENT_FNS(overhead_guest_sys, period_guest_sys)
 HPP_PERCENT_FNS(overhead_guest_us, period_guest_us)
 HPP_PERCENT_ACC_FNS(overhead_acc, period)
+HPP_PERCENT_ACC_FNS(wallclock_acc, wallclock)
 
 HPP_RAW_FNS(samples, nr_events)
 HPP_RAW_FNS(period, period)
@@ -548,11 +551,13 @@ static bool hpp__equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
 
 struct perf_hpp_fmt perf_hpp__format[] = {
 	HPP__COLOR_PRINT_FNS("Overhead", overhead, OVERHEAD),
+	HPP__COLOR_PRINT_FNS("Wallclock", wallclock, WALLCLOCK),
 	HPP__COLOR_PRINT_FNS("sys", overhead_sys, OVERHEAD_SYS),
 	HPP__COLOR_PRINT_FNS("usr", overhead_us, OVERHEAD_US),
 	HPP__COLOR_PRINT_FNS("guest sys", overhead_guest_sys, OVERHEAD_GUEST_SYS),
 	HPP__COLOR_PRINT_FNS("guest usr", overhead_guest_us, OVERHEAD_GUEST_US),
 	HPP__COLOR_ACC_PRINT_FNS("Children", overhead_acc, OVERHEAD_ACC),
+	HPP__COLOR_ACC_PRINT_FNS("Wall", wallclock_acc, WALLCLOCK_ACC),
 	HPP__PRINT_FNS("Samples", samples, SAMPLES),
 	HPP__PRINT_FNS("Period", period, PERIOD),
 	HPP__PRINT_FNS("Weight1", weight1, WEIGHT1),
@@ -601,9 +606,15 @@ static void fmt_free(struct perf_hpp_fmt *fmt)
 		fmt->free(fmt);
 }
 
+static bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
+{
+	return a->equal && a->equal(a, b);
+}
+
 void perf_hpp__init(void)
 {
 	int i;
+	bool prefer_wallclock;
 
 	for (i = 0; i < PERF_HPP__MAX_INDEX; i++) {
 		struct perf_hpp_fmt *fmt = &perf_hpp__format[i];
@@ -621,12 +632,30 @@ void perf_hpp__init(void)
 	if (is_strict_order(field_order))
 		return;
 
+	/*
+	 * There are numerous ways how a user can setup a custom view with
+	 * --sort/fields flags, but we provide --sort=wallclock as a simple
+	 * preset for latency analysis and show wallclock before CPU overhead.
+	 */
+	prefer_wallclock = !symbol_conf.disable_wallclock && sort_order &&
+		!strncmp(sort_order, "wallclock", sizeof("wallclock")-1);
+
 	if (symbol_conf.cumulate_callchain) {
+		/* Use idempotent addition to avoid more complex logic. */
+		if (prefer_wallclock)
+			hpp_dimension__add_output(PERF_HPP__WALLCLOCK_ACC);
 		hpp_dimension__add_output(PERF_HPP__OVERHEAD_ACC);
+		if (!symbol_conf.disable_wallclock)
+			hpp_dimension__add_output(PERF_HPP__WALLCLOCK_ACC);
 		perf_hpp__format[PERF_HPP__OVERHEAD].name = "Self";
+		perf_hpp__format[PERF_HPP__WALLCLOCK].name = "Wall";
 	}
 
+	if (prefer_wallclock)
+		hpp_dimension__add_output(PERF_HPP__WALLCLOCK);
 	hpp_dimension__add_output(PERF_HPP__OVERHEAD);
+	if (!symbol_conf.disable_wallclock)
+		hpp_dimension__add_output(PERF_HPP__WALLCLOCK);
 
 	if (symbol_conf.show_cpu_utilization) {
 		hpp_dimension__add_output(PERF_HPP__OVERHEAD_SYS);
@@ -671,28 +700,43 @@ static void perf_hpp__column_unregister(struct perf_hpp_fmt *format)
 
 void perf_hpp__cancel_cumulate(void)
 {
-	struct perf_hpp_fmt *fmt, *acc, *ovh, *tmp;
+	struct perf_hpp_fmt *fmt, *acc, *ovh, *wall, *acc_wall, *tmp;
 
 	if (is_strict_order(field_order))
 		return;
 
 	ovh = &perf_hpp__format[PERF_HPP__OVERHEAD];
 	acc = &perf_hpp__format[PERF_HPP__OVERHEAD_ACC];
+	wall = &perf_hpp__format[PERF_HPP__WALLCLOCK];
+	acc_wall = &perf_hpp__format[PERF_HPP__WALLCLOCK_ACC];
 
 	perf_hpp_list__for_each_format_safe(&perf_hpp_list, fmt, tmp) {
-		if (acc->equal(acc, fmt)) {
+		if (fmt_equal(acc, fmt) || fmt_equal(acc_wall, fmt)) {
 			perf_hpp__column_unregister(fmt);
 			continue;
 		}
 
-		if (ovh->equal(ovh, fmt))
+		if (fmt_equal(ovh, fmt))
 			fmt->name = "Overhead";
+		if (fmt_equal(wall, fmt))
+			fmt->name = "Wallclock";
 	}
 }
 
-static bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
+void perf_hpp__cancel_wallclock(void)
 {
-	return a->equal && a->equal(a, b);
+	struct perf_hpp_fmt *fmt, *wall, *acc, *tmp;
+
+	if (is_strict_order(field_order))
+		return;
+
+	wall = &perf_hpp__format[PERF_HPP__WALLCLOCK];
+	acc = &perf_hpp__format[PERF_HPP__WALLCLOCK_ACC];
+
+	perf_hpp_list__for_each_format_safe(&perf_hpp_list, fmt, tmp) {
+		if (fmt_equal(wall, fmt) || fmt_equal(acc, fmt))
+			perf_hpp__column_unregister(fmt);
+	}
 }
 
 void perf_hpp__setup_output_field(struct perf_hpp_list *list)
@@ -819,6 +863,7 @@ void perf_hpp__reset_width(struct perf_hpp_fmt *fmt, struct hists *hists)
 
 	switch (fmt->idx) {
 	case PERF_HPP__OVERHEAD:
+	case PERF_HPP__WALLCLOCK:
 	case PERF_HPP__OVERHEAD_SYS:
 	case PERF_HPP__OVERHEAD_US:
 	case PERF_HPP__OVERHEAD_ACC:
diff --git a/tools/perf/util/addr_location.c b/tools/perf/util/addr_location.c
index 51825ef8c0ab7..007a2f5df9a6a 100644
--- a/tools/perf/util/addr_location.c
+++ b/tools/perf/util/addr_location.c
@@ -17,6 +17,7 @@ void addr_location__init(struct addr_location *al)
 	al->cpumode = 0;
 	al->cpu = 0;
 	al->socket = 0;
+	al->parallelism = 1;
 }
 
 /*
diff --git a/tools/perf/util/addr_location.h b/tools/perf/util/addr_location.h
index d8ac0428dff23..d8af6f467ae9d 100644
--- a/tools/perf/util/addr_location.h
+++ b/tools/perf/util/addr_location.h
@@ -17,10 +17,14 @@ struct addr_location {
 	const char    *srcline;
 	u64	      addr;
 	char	      level;
-	u8	      filtered;
+	u16	      filtered;
 	u8	      cpumode;
 	s32	      cpu;
 	s32	      socket;
+	/* Same as machine.parallelism but within [1, nr_cpus]. */
+	int	      parallelism;
+	/* See he_stat.wallclock. */
+	u64	      wallclock;
 };
 
 void addr_location__init(struct addr_location *al);
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index aac96d5d19170..1c50af20b3a4c 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -767,6 +767,12 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 			al->socket = env->cpu[al->cpu].socket_id;
 	}
 
+	/* Account for possible out-of-order switch events. */
+	al->parallelism = min(max(machine->parallelism, 1), machine__nr_cpus_avail(machine));
+	if (test_bit(al->parallelism, symbol_conf.parallelism_filter))
+		al->filtered |= (1 << HIST_FILTER__PARALLELISM);
+	al->wallclock = sample->period * 1000 / al->parallelism;
+
 	if (al->map) {
 		if (symbol_conf.dso_list &&
 		    (!dso || !(strlist__has_entry(symbol_conf.dso_list,
diff --git a/tools/perf/util/events_stats.h b/tools/perf/util/events_stats.h
index eabd7913c3092..c32c99c16ad39 100644
--- a/tools/perf/util/events_stats.h
+++ b/tools/perf/util/events_stats.h
@@ -57,6 +57,8 @@ struct events_stats {
 struct hists_stats {
 	u64 total_period;
 	u64 total_non_filtered_period;
+	u64 total_wallclock;
+	u64 total_non_filtered_wallclock;
 	u32 nr_samples;
 	u32 nr_non_filtered_samples;
 	u32 nr_lost_samples;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index b99d89b1a152d..fe690e9aece45 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -43,6 +43,8 @@ static bool hists__filter_entry_by_symbol(struct hists *hists,
 					  struct hist_entry *he);
 static bool hists__filter_entry_by_socket(struct hists *hists,
 					  struct hist_entry *he);
+static bool hists__filter_entry_by_parallelism(struct hists *hists,
+					       struct hist_entry *he);
 
 u16 hists__col_len(struct hists *hists, enum hist_column col)
 {
@@ -207,6 +209,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 
 	hists__new_col_len(hists, HISTC_CGROUP, 6);
 	hists__new_col_len(hists, HISTC_CGROUP_ID, 20);
+	hists__new_col_len(hists, HISTC_PARALLELISM, 11);
 	hists__new_col_len(hists, HISTC_CPU, 3);
 	hists__new_col_len(hists, HISTC_SOCKET, 6);
 	hists__new_col_len(hists, HISTC_MEM_LOCKED, 6);
@@ -302,9 +305,10 @@ static long hist_time(unsigned long htime)
 	return htime;
 }
 
-static void he_stat__add_period(struct he_stat *he_stat, u64 period)
+static void he_stat__add_period(struct he_stat *he_stat, u64 period, u64 wallclock)
 {
 	he_stat->period		+= period;
+	he_stat->wallclock	+= wallclock;
 	he_stat->nr_events	+= 1;
 }
 
@@ -319,6 +323,7 @@ static void he_stat__add_stat(struct he_stat *dest, struct he_stat *src)
 	dest->weight2		+= src->weight2;
 	dest->weight3		+= src->weight3;
 	dest->nr_events		+= src->nr_events;
+	dest->wallclock		+= src->wallclock;
 }
 
 static void he_stat__decay(struct he_stat *he_stat)
@@ -328,6 +333,7 @@ static void he_stat__decay(struct he_stat *he_stat)
 	he_stat->weight1 = (he_stat->weight1 * 7) / 8;
 	he_stat->weight2 = (he_stat->weight2 * 7) / 8;
 	he_stat->weight3 = (he_stat->weight3 * 7) / 8;
+	he_stat->wallclock = (he_stat->wallclock * 7) / 8;
 }
 
 static void hists__delete_entry(struct hists *hists, struct hist_entry *he);
@@ -335,7 +341,7 @@ static void hists__delete_entry(struct hists *hists, struct hist_entry *he);
 static bool hists__decay_entry(struct hists *hists, struct hist_entry *he)
 {
 	u64 prev_period = he->stat.period;
-	u64 diff;
+	u64 prev_wallclock = he->stat.wallclock;
 
 	if (prev_period == 0)
 		return true;
@@ -345,12 +351,16 @@ static bool hists__decay_entry(struct hists *hists, struct hist_entry *he)
 		he_stat__decay(he->stat_acc);
 	decay_callchain(he->callchain);
 
-	diff = prev_period - he->stat.period;
-
 	if (!he->depth) {
-		hists->stats.total_period -= diff;
-		if (!he->filtered)
-			hists->stats.total_non_filtered_period -= diff;
+		u64 period_diff = prev_period - he->stat.period;
+		u64 wallclock_diff = prev_wallclock - he->stat.wallclock;
+
+		hists->stats.total_period -= period_diff;
+		hists->stats.total_wallclock -= wallclock_diff;
+		if (!he->filtered) {
+			hists->stats.total_non_filtered_period -= period_diff;
+			hists->stats.total_non_filtered_wallclock -= wallclock_diff;
+		}
 	}
 
 	if (!he->leaf) {
@@ -365,7 +375,7 @@ static bool hists__decay_entry(struct hists *hists, struct hist_entry *he)
 		}
 	}
 
-	return he->stat.period == 0;
+	return he->stat.period == 0 && he->stat.wallclock == 0;
 }
 
 static void hists__delete_entry(struct hists *hists, struct hist_entry *he)
@@ -584,21 +594,24 @@ static struct hist_entry *hist_entry__new(struct hist_entry *template,
 	return he;
 }
 
-static u8 symbol__parent_filter(const struct symbol *parent)
+static u16 symbol__parent_filter(const struct symbol *parent)
 {
 	if (symbol_conf.exclude_other && parent == NULL)
 		return 1 << HIST_FILTER__PARENT;
 	return 0;
 }
 
-static void hist_entry__add_callchain_period(struct hist_entry *he, u64 period)
+static void hist_entry__add_callchain_period(struct hist_entry *he, u64 period, u64 wallclock)
 {
 	if (!hist_entry__has_callchains(he) || !symbol_conf.use_callchain)
 		return;
 
 	he->hists->callchain_period += period;
-	if (!he->filtered)
+	he->hists->callchain_wallclock += wallclock;
+	if (!he->filtered) {
 		he->hists->callchain_non_filtered_period += period;
+		he->hists->callchain_non_filtered_wallclock += wallclock;
+	}
 }
 
 static struct hist_entry *hists__findnew_entry(struct hists *hists,
@@ -611,6 +624,7 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 	struct hist_entry *he;
 	int64_t cmp;
 	u64 period = entry->stat.period;
+	u64 wallclock = entry->stat.wallclock;
 	bool leftmost = true;
 
 	p = &hists->entries_in->rb_root.rb_node;
@@ -629,10 +643,10 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 		if (!cmp) {
 			if (sample_self) {
 				he_stat__add_stat(&he->stat, &entry->stat);
-				hist_entry__add_callchain_period(he, period);
+				hist_entry__add_callchain_period(he, period, wallclock);
 			}
 			if (symbol_conf.cumulate_callchain)
-				he_stat__add_period(he->stat_acc, period);
+				he_stat__add_period(he->stat_acc, period, wallclock);
 
 			block_info__delete(entry->block_info);
 
@@ -669,7 +683,7 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 		return NULL;
 
 	if (sample_self)
-		hist_entry__add_callchain_period(he, period);
+		hist_entry__add_callchain_period(he, period, wallclock);
 	hists->nr_entries++;
 
 	rb_link_node(&he->rb_node_in, parent, p);
@@ -741,12 +755,14 @@ __hists__add_entry(struct hists *hists,
 		.ip	 = al->addr,
 		.level	 = al->level,
 		.code_page_size = sample->code_page_size,
+		.parallelism	= al->parallelism,
 		.stat = {
 			.nr_events = 1,
 			.period	= sample->period,
 			.weight1 = sample->weight,
 			.weight2 = sample->ins_lat,
 			.weight3 = sample->p_stage_cyc,
+			.wallclock = al->wallclock,
 		},
 		.parent = sym_parent,
 		.filtered = symbol__parent_filter(sym_parent) | al->filtered,
@@ -1456,6 +1472,10 @@ static void hist_entry__check_and_remove_filter(struct hist_entry *he,
 		if (symbol_conf.sym_list == NULL)
 			return;
 		break;
+	case HIST_FILTER__PARALLELISM:
+		if (__bitmap_weight(symbol_conf.parallelism_filter, MAX_NR_CPUS + 1) == 0)
+			return;
+		break;
 	case HIST_FILTER__PARENT:
 	case HIST_FILTER__GUEST:
 	case HIST_FILTER__HOST:
@@ -1514,6 +1534,9 @@ static void hist_entry__apply_hierarchy_filters(struct hist_entry *he)
 	hist_entry__check_and_remove_filter(he, HIST_FILTER__SYMBOL,
 					    perf_hpp__is_sym_entry);
 
+	hist_entry__check_and_remove_filter(he, HIST_FILTER__PARALLELISM,
+					    perf_hpp__is_parallelism_entry);
+
 	hists__apply_filters(he->hists, he);
 }
 
@@ -1710,6 +1733,7 @@ static void hists__apply_filters(struct hists *hists, struct hist_entry *he)
 	hists__filter_entry_by_thread(hists, he);
 	hists__filter_entry_by_symbol(hists, he);
 	hists__filter_entry_by_socket(hists, he);
+	hists__filter_entry_by_parallelism(hists, he);
 }
 
 int hists__collapse_resort(struct hists *hists, struct ui_progress *prog)
@@ -1757,12 +1781,14 @@ static void hists__reset_filter_stats(struct hists *hists)
 {
 	hists->nr_non_filtered_entries = 0;
 	hists->stats.total_non_filtered_period = 0;
+	hists->stats.total_non_filtered_wallclock = 0;
 }
 
 void hists__reset_stats(struct hists *hists)
 {
 	hists->nr_entries = 0;
 	hists->stats.total_period = 0;
+	hists->stats.total_wallclock = 0;
 
 	hists__reset_filter_stats(hists);
 }
@@ -1771,6 +1797,7 @@ static void hists__inc_filter_stats(struct hists *hists, struct hist_entry *h)
 {
 	hists->nr_non_filtered_entries++;
 	hists->stats.total_non_filtered_period += h->stat.period;
+	hists->stats.total_non_filtered_wallclock += h->stat.wallclock;
 }
 
 void hists__inc_stats(struct hists *hists, struct hist_entry *h)
@@ -1780,6 +1807,7 @@ void hists__inc_stats(struct hists *hists, struct hist_entry *h)
 
 	hists->nr_entries++;
 	hists->stats.total_period += h->stat.period;
+	hists->stats.total_wallclock += h->stat.wallclock;
 }
 
 static void hierarchy_recalc_total_periods(struct hists *hists)
@@ -1791,6 +1819,8 @@ static void hierarchy_recalc_total_periods(struct hists *hists)
 
 	hists->stats.total_period = 0;
 	hists->stats.total_non_filtered_period = 0;
+	hists->stats.total_wallclock = 0;
+	hists->stats.total_non_filtered_wallclock = 0;
 
 	/*
 	 * recalculate total period using top-level entries only
@@ -1802,8 +1832,11 @@ static void hierarchy_recalc_total_periods(struct hists *hists)
 		node = rb_next(node);
 
 		hists->stats.total_period += he->stat.period;
-		if (!he->filtered)
+		hists->stats.total_wallclock += he->stat.wallclock;
+		if (!he->filtered) {
 			hists->stats.total_non_filtered_period += he->stat.period;
+			hists->stats.total_non_filtered_wallclock += he->stat.wallclock;
+		}
 	}
 }
 
@@ -2196,6 +2229,17 @@ static bool hists__filter_entry_by_socket(struct hists *hists,
 	return false;
 }
 
+static bool hists__filter_entry_by_parallelism(struct hists *hists,
+					       struct hist_entry *he)
+{
+	if (test_bit(he->parallelism, hists->parallelism_filter)) {
+		he->filtered |= (1 << HIST_FILTER__PARALLELISM);
+		return true;
+	}
+
+	return false;
+}
+
 typedef bool (*filter_fn_t)(struct hists *hists, struct hist_entry *he);
 
 static void hists__filter_by_type(struct hists *hists, int type, filter_fn_t filter)
@@ -2365,6 +2409,16 @@ void hists__filter_by_socket(struct hists *hists)
 				      hists__filter_entry_by_socket);
 }
 
+void hists__filter_by_parallelism(struct hists *hists)
+{
+	if (symbol_conf.report_hierarchy)
+		hists__filter_hierarchy(hists, HIST_FILTER__PARALLELISM,
+					hists->parallelism_filter);
+	else
+		hists__filter_by_type(hists, HIST_FILTER__PARALLELISM,
+				      hists__filter_entry_by_parallelism);
+}
+
 void events_stats__inc(struct events_stats *stats, u32 type)
 {
 	++stats->nr_events[0];
@@ -2760,6 +2814,12 @@ u64 hists__total_period(struct hists *hists)
 		hists->stats.total_period;
 }
 
+u64 hists__total_wallclock(struct hists *hists)
+{
+	return symbol_conf.filter_relative ? hists->stats.total_non_filtered_wallclock :
+		hists->stats.total_wallclock;
+}
+
 int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool show_freq)
 {
 	char unit;
@@ -2871,6 +2931,7 @@ int __hists__init(struct hists *hists, struct perf_hpp_list *hpp_list)
 	hists->entries = RB_ROOT_CACHED;
 	mutex_init(&hists->lock);
 	hists->socket_filter = -1;
+	hists->parallelism_filter = symbol_conf.parallelism_filter;
 	hists->hpp_list = hpp_list;
 	INIT_LIST_HEAD(&hists->hpp_formats);
 	return 0;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 6cff03eb043b7..db9c05b810bd7 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -31,6 +31,7 @@ enum hist_filter {
 	HIST_FILTER__HOST,
 	HIST_FILTER__SOCKET,
 	HIST_FILTER__C2C,
+	HIST_FILTER__PARALLELISM,
 };
 
 enum hist_column {
@@ -42,6 +43,7 @@ enum hist_column {
 	HISTC_CGROUP_ID,
 	HISTC_CGROUP,
 	HISTC_PARENT,
+	HISTC_PARALLELISM,
 	HISTC_CPU,
 	HISTC_SOCKET,
 	HISTC_SRCLINE,
@@ -105,10 +107,13 @@ struct hists {
 	u64			nr_non_filtered_entries;
 	u64			callchain_period;
 	u64			callchain_non_filtered_period;
+	u64			callchain_wallclock;
+	u64			callchain_non_filtered_wallclock;
 	struct thread		*thread_filter;
 	const struct dso	*dso_filter;
 	const char		*uid_filter_str;
 	const char		*symbol_filter_str;
+	unsigned long		*parallelism_filter;
 	struct mutex		lock;
 	struct hists_stats	stats;
 	u64			event_stream;
@@ -165,6 +170,13 @@ struct res_sample {
 
 struct he_stat {
 	u64			period;
+	/*
+	 * Overhead re-scaled from CPU time to wallclock time (period divided
+	 * by the parallelism at the time of the sample). It's multipled by
+	 * some const to avoid precision loss or dealing with floats.
+	 * It does not matter otherwise since we only print it as percents.
+	 */
+	u64			wallclock;
 	u64			period_sys;
 	u64			period_us;
 	u64			period_guest_sys;
@@ -228,6 +240,7 @@ struct hist_entry {
 	u64			transaction;
 	s32			socket;
 	s32			cpu;
+	int			parallelism;
 	u64			code_page_size;
 	u64			weight;
 	u64			ins_lat;
@@ -242,7 +255,7 @@ struct hist_entry {
 	bool			leaf;
 
 	char			level;
-	u8			filtered;
+	u16			filtered;
 
 	u16			callchain_size;
 	union {
@@ -368,6 +381,7 @@ void hists__output_recalc_col_len(struct hists *hists, int max_rows);
 struct hist_entry *hists__get_entry(struct hists *hists, int idx);
 
 u64 hists__total_period(struct hists *hists);
+u64 hists__total_wallclock(struct hists *hists);
 void hists__reset_stats(struct hists *hists);
 void hists__inc_stats(struct hists *hists, struct hist_entry *h);
 void hists__inc_nr_events(struct hists *hists);
@@ -384,11 +398,13 @@ void hists__filter_by_dso(struct hists *hists);
 void hists__filter_by_thread(struct hists *hists);
 void hists__filter_by_symbol(struct hists *hists);
 void hists__filter_by_socket(struct hists *hists);
+void hists__filter_by_parallelism(struct hists *hists);
 
 static inline bool hists__has_filter(struct hists *hists)
 {
 	return hists->thread_filter || hists->dso_filter ||
-		hists->symbol_filter_str || (hists->socket_filter > -1);
+		hists->symbol_filter_str || (hists->socket_filter > -1) ||
+		hists->parallelism_filter;
 }
 
 u16 hists__col_len(struct hists *hists, enum hist_column col);
@@ -547,11 +563,13 @@ extern struct perf_hpp_fmt perf_hpp__format[];
 enum {
 	/* Matches perf_hpp__format array. */
 	PERF_HPP__OVERHEAD,
+	PERF_HPP__WALLCLOCK,
 	PERF_HPP__OVERHEAD_SYS,
 	PERF_HPP__OVERHEAD_US,
 	PERF_HPP__OVERHEAD_GUEST_SYS,
 	PERF_HPP__OVERHEAD_GUEST_US,
 	PERF_HPP__OVERHEAD_ACC,
+	PERF_HPP__WALLCLOCK_ACC,
 	PERF_HPP__SAMPLES,
 	PERF_HPP__PERIOD,
 	PERF_HPP__WEIGHT1,
@@ -563,6 +581,7 @@ enum {
 
 void perf_hpp__init(void);
 void perf_hpp__cancel_cumulate(void);
+void perf_hpp__cancel_wallclock(void);
 void perf_hpp__setup_output_field(struct perf_hpp_list *list);
 void perf_hpp__reset_output_field(struct perf_hpp_list *list);
 void perf_hpp__append_sort_keys(struct perf_hpp_list *list);
@@ -580,6 +599,7 @@ bool perf_hpp__is_thread_entry(struct perf_hpp_fmt *fmt);
 bool perf_hpp__is_comm_entry(struct perf_hpp_fmt *fmt);
 bool perf_hpp__is_dso_entry(struct perf_hpp_fmt *fmt);
 bool perf_hpp__is_sym_entry(struct perf_hpp_fmt *fmt);
+bool perf_hpp__is_parallelism_entry(struct perf_hpp_fmt *fmt);
 
 struct perf_hpp_fmt *perf_hpp_fmt__dup(struct perf_hpp_fmt *fmt);
 
@@ -606,6 +626,7 @@ void hists__reset_column_width(struct hists *hists);
 enum perf_hpp_fmt_type {
 	PERF_HPP_FMT_TYPE__RAW,
 	PERF_HPP_FMT_TYPE__PERCENT,
+	PERF_HPP_FMT_TYPE__WALLCLOCK,
 	PERF_HPP_FMT_TYPE__AVERAGE,
 };
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 27d5345d2b307..956581bfeb5b1 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -94,6 +94,8 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 	machine->comm_exec = false;
 	machine->kernel_start = 0;
 	machine->vmlinux_map = NULL;
+	/* There is no initial context switch in, so we start at 1. */
+	machine->parallelism = 1;
 
 	machine->root_dir = strdup(root_dir);
 	if (machine->root_dir == NULL)
@@ -677,8 +679,11 @@ int machine__process_aux_output_hw_id_event(struct machine *machine __maybe_unus
 int machine__process_switch_event(struct machine *machine __maybe_unused,
 				  union perf_event *event)
 {
+	bool out = event->header.misc & PERF_RECORD_MISC_SWITCH_OUT;
+
 	if (dump_trace)
 		perf_event__fprintf_switch(event, stdout);
+	machine->parallelism += out ? -1 : 1;
 	return 0;
 }
 
@@ -1898,6 +1903,8 @@ int machine__process_exit_event(struct machine *machine, union perf_event *event
 	if (dump_trace)
 		perf_event__fprintf_task(event, stdout);
 
+	/* There is no context switch out before exit, so we decrement here. */
+	machine->parallelism--;
 	if (thread != NULL) {
 		if (symbol_conf.keep_exited_threads)
 			thread__set_exited(thread, /*exited=*/true);
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 2e5a4cb342d82..a5f28652873ce 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -50,6 +50,12 @@ struct machine {
 		u64	  text_start;
 		u64	  text_end;
 	} sched, lock, traceiter, trace;
+	/*
+	 * The current parallelism level (number of threads that run on CPUs).
+	 * This value can be less than 1, or larger than the total number
+	 * of CPUs, if events are poorly ordered.
+	 */
+	int		  parallelism;
 	pid_t		  *current_tid;
 	size_t		  current_tid_sz;
 	union { /* Tool specific area */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 507e6cba95458..19db4bb315aa5 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2402,6 +2402,18 @@ bool perf_session__has_traces(struct perf_session *session, const char *msg)
 	return false;
 }
 
+bool perf_session__has_switch_events(struct perf_session *session)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(session->evlist, evsel) {
+		if (evsel->core.attr.context_switch)
+			return true;
+	}
+
+	return false;
+}
+
 int map__set_kallsyms_ref_reloc_sym(struct map *map, const char *symbol_name, u64 addr)
 {
 	char *bracket;
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index bcf1bcf06959b..db1c120a9e67f 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -141,6 +141,7 @@ int perf_session__resolve_callchain(struct perf_session *session,
 				    struct symbol **parent);
 
 bool perf_session__has_traces(struct perf_session *session, const char *msg);
+bool perf_session__has_switch_events(struct perf_session *session);
 
 void perf_event__attr_swap(struct perf_event_attr *attr);
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 9dd60c7869a28..01e8c54d93464 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -892,6 +892,38 @@ struct sort_entry sort_cpu = {
 	.se_width_idx	= HISTC_CPU,
 };
 
+/* --sort parallelism */
+
+static int64_t
+sort__parallelism_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	return right->parallelism - left->parallelism;
+}
+
+static int hist_entry__parallelism_filter(struct hist_entry *he, int type, const void *arg)
+{
+	const unsigned long *parallelism_filter = arg;
+
+	if (type != HIST_FILTER__PARALLELISM)
+		return -1;
+
+	return test_bit(he->parallelism, parallelism_filter);
+}
+
+static int hist_entry__parallelism_snprintf(struct hist_entry *he, char *bf,
+				    size_t size, unsigned int width)
+{
+	return repsep_snprintf(bf, size, "%*d", width, he->parallelism);
+}
+
+struct sort_entry sort_parallelism = {
+	.se_header      = "Parallelism",
+	.se_cmp	        = sort__parallelism_cmp,
+	.se_filter	= hist_entry__parallelism_filter,
+	.se_snprintf    = hist_entry__parallelism_snprintf,
+	.se_width_idx	= HISTC_PARALLELISM,
+};
+
 /* --sort cgroup_id */
 
 static int64_t _sort__cgroup_dev_cmp(u64 left_dev, u64 right_dev)
@@ -2532,6 +2564,7 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_ANNOTATE_DATA_TYPE_OFFSET, "typeoff", sort_type_offset),
 	DIM(SORT_SYM_OFFSET, "symoff", sort_sym_offset),
 	DIM(SORT_ANNOTATE_DATA_TYPE_CACHELINE, "typecln", sort_type_cacheline),
+	DIM(SORT_PARALLELISM, "parallelism", sort_parallelism),
 };
 
 #undef DIM
@@ -2593,11 +2626,13 @@ struct hpp_dimension {
 
 static struct hpp_dimension hpp_sort_dimensions[] = {
 	DIM(PERF_HPP__OVERHEAD, "overhead"),
+	DIM(PERF_HPP__WALLCLOCK, "wallclock"),
 	DIM(PERF_HPP__OVERHEAD_SYS, "overhead_sys"),
 	DIM(PERF_HPP__OVERHEAD_US, "overhead_us"),
 	DIM(PERF_HPP__OVERHEAD_GUEST_SYS, "overhead_guest_sys"),
 	DIM(PERF_HPP__OVERHEAD_GUEST_US, "overhead_guest_us"),
 	DIM(PERF_HPP__OVERHEAD_ACC, "overhead_children"),
+	DIM(PERF_HPP__WALLCLOCK_ACC, "wallclock_children"),
 	DIM(PERF_HPP__SAMPLES, "sample"),
 	DIM(PERF_HPP__PERIOD, "period"),
 	DIM(PERF_HPP__WEIGHT1, "weight1"),
@@ -2733,6 +2768,7 @@ MK_SORT_ENTRY_CHK(thread)
 MK_SORT_ENTRY_CHK(comm)
 MK_SORT_ENTRY_CHK(dso)
 MK_SORT_ENTRY_CHK(sym)
+MK_SORT_ENTRY_CHK(parallelism)
 
 
 static bool __sort__hpp_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
@@ -3715,6 +3751,21 @@ static int setup_sort_order(struct evlist *evlist)
 {
 	char *new_sort_order;
 
+	/*
+	 * Append the default sort order to "wallclock".
+	 * Just "wallclock" is not useful on its own, and there is no easy way
+	 * to express it otherwise.
+	 */
+	if (sort_order && !strcmp(sort_order, "wallclock")) {
+		if (asprintf(&new_sort_order, "%s,%s",
+			     sort_order, get_default_sort_order(evlist)) < 0) {
+			pr_err("Not enough memory to set up --sort");
+			return -ENOMEM;
+		}
+		sort_order = new_sort_order;
+		return 0;
+	}
+
 	/*
 	 * Append '+'-prefixed sort order to the default sort
 	 * order string.
@@ -3764,10 +3815,14 @@ static char *setup_overhead(char *keys)
 	if (sort__mode == SORT_MODE__DIFF)
 		return keys;
 
-	keys = prefix_if_not_in("overhead", keys);
+	if (!strstr(keys, "wallclock"))
+		keys = prefix_if_not_in("overhead", keys);
 
-	if (symbol_conf.cumulate_callchain)
+	if (symbol_conf.cumulate_callchain) {
+		if (!symbol_conf.disable_wallclock)
+			keys = prefix_if_not_in("wallclock_children", keys);
 		keys = prefix_if_not_in("overhead_children", keys);
+	}
 
 	return keys;
 }
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index a8572574e1686..11fb15f914093 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -72,6 +72,7 @@ enum sort_type {
 	SORT_ANNOTATE_DATA_TYPE_OFFSET,
 	SORT_SYM_OFFSET,
 	SORT_ANNOTATE_DATA_TYPE_CACHELINE,
+	SORT_PARALLELISM,
 
 	/* branch stack specific sort keys */
 	__SORT_BRANCH_STACK,
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 0037f11639195..38500609ea6ed 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -18,6 +18,7 @@
 #include "annotate.h"
 #include "build-id.h"
 #include "cap.h"
+#include "cpumap.h"
 #include "dso.h"
 #include "util.h" // lsdir()
 #include "debug.h"
@@ -2464,6 +2465,36 @@ int symbol__annotation_init(void)
 	return 0;
 }
 
+static int setup_parallelism_bitmap(void)
+{
+	struct perf_cpu_map *map;
+	struct perf_cpu cpu;
+	int i, err = -1;
+
+	if (symbol_conf.parallelism_list_str == NULL)
+		return 0;
+
+	map = perf_cpu_map__new(symbol_conf.parallelism_list_str);
+	if (map == NULL) {
+		pr_err("failed to parse parallelism filter list\n");
+		return -1;
+	}
+
+	bitmap_fill(symbol_conf.parallelism_filter, MAX_NR_CPUS + 1);
+	perf_cpu_map__for_each_cpu(cpu, i, map) {
+		if (cpu.cpu <= 0 || cpu.cpu > MAX_NR_CPUS) {
+			pr_err("Requested parallelism level %d is invalid.\n", cpu.cpu);
+			goto out_delete_map;
+		}
+		__clear_bit(cpu.cpu, symbol_conf.parallelism_filter);
+	}
+
+	err = 0;
+out_delete_map:
+	perf_cpu_map__put(map);
+	return err;
+}
+
 int symbol__init(struct perf_env *env)
 {
 	const char *symfs;
@@ -2483,6 +2514,9 @@ int symbol__init(struct perf_env *env)
 		return -1;
 	}
 
+	if (setup_parallelism_bitmap())
+		return -1;
+
 	if (setup_list(&symbol_conf.dso_list,
 		       symbol_conf.dso_list_str, "dso") < 0)
 		return -1;
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index a9c51acc722fe..7f6d6a1c773f1 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -3,6 +3,8 @@
 #define __PERF_SYMBOL_CONF 1
 
 #include <stdbool.h>
+#include <linux/bitmap.h>
+#include "perf.h"
 
 struct strlist;
 struct intlist;
@@ -47,7 +49,8 @@ struct symbol_conf {
 			keep_exited_threads,
 			annotate_data_member,
 			annotate_data_sample,
-			skip_empty;
+			skip_empty,
+			disable_wallclock;
 	const char	*vmlinux_name,
 			*kallsyms_name,
 			*source_prefix,
@@ -62,6 +65,7 @@ struct symbol_conf {
 			*pid_list_str,
 			*tid_list_str,
 			*sym_list_str,
+			*parallelism_list_str,
 			*col_width_list_str,
 			*bt_stop_list_str;
 	const char		*addr2line_path;
@@ -82,6 +86,7 @@ struct symbol_conf {
 	int		pad_output_len_dso;
 	int		group_sort_idx;
 	int		addr_range;
+	DECLARE_BITMAP(parallelism_filter, MAX_NR_CPUS + 1);
 };
 
 extern struct symbol_conf symbol_conf;

base-commit: 660d2400e5bf865ff2e2d8413284d0d3248cbf25
-- 
2.47.1.613.gc27f4b7a9f-goog

