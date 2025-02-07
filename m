Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879F41E7C37
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928493; cv=none; b=j+73pK/Rk3k6OnpicfKA7JnFE47706TX8VtQA/mCcMPENvx7yUYF2GxKH/jBs3vR0Xm1cslyTfqXBZ+s3nIZ/5usUejQSR+lNjUAj300CumEUtTPJ/Je3TIsDIR7oTq2U0EhOyKf+lhWmHAu752ix7wI/Cg4nhxDwfg9dpFG+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928493; c=relaxed/simple;
	bh=P9HSZ/nNeSnQL+lLQdXoxtPRsVfq9a6a1xEeFBWOVbw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hjKaVDupHKQDZDshrvXC7B1AHGq6DpCPPiuMZ3xHFdiR0FxQGeC1Xuwwi7HHIVZlvAISm+LuYDSIISlKMFGhYKdlPSPU/RfkEblfMBIcE936mKQiTdr9H1sqZAzYPEtXP3XE/ayR1WSLhAQn8N8SHZdA7hztOfK7oJRM5TPChJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TAityom+; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TAityom+"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5de4ab2f76aso490039a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 03:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738928489; x=1739533289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+/O6jYpePgmlgvnVLFkdGhbSuF+TM5Ypn5EkCeXUpos=;
        b=TAityom+E+yn3BY1MezAyZ/mBLkU7jtYDEDhb0GGuirm4XxQ1aBRlVyRmIKkR4koSa
         yAOBZFMldOxD/sI411VEFfvsZa4nYQIyMiY+2mcItHrO7YGSR3C41F8pK2aj3VJbs0mX
         0Htj9Q+ei5RzeDqWsTILdjkDGVbZAHKZ4Mc0Gfczusz9XzMfQuSWtKQwCjADAiAa0qCx
         09I23xTHSIXEHlYhHscLGuHqRtP6GPTYG1wocT3AnZQkkeaXtv3wx6gwPGVl3l9sMEWZ
         zJ3ATF4fC66EfcIJIHIK3H/BBjKeLUPIploIdoAyzM2Kij2iPvhSmdyl5Q1feRBcfhxj
         E85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738928489; x=1739533289;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/O6jYpePgmlgvnVLFkdGhbSuF+TM5Ypn5EkCeXUpos=;
        b=FkNVlidt8CQUuFtmIyMTjdMPdgQ7HWCK6JKNKyBMnlmaKFXA7jOtaUdDFVQHutaV2H
         Xs27Vfb9Y6BCFXyLMMrFcG/eYrYmr4fa906b7lTVnCjwkWprwIfsUyYf0GHviDsqM0eB
         JeOSfKoNURvh9UG1ZrQDhM2Bq0RpCcDNTHS+jvhXlEv6bIMsrXJCOfbRdjEcQlBj92CH
         x4bPiM9XSO5rg5C4NbPGJH039cAqHYIEAmngK6jGETrZwaD1O7Q28iOo97+ds4bQDmr0
         VPzcANGdm9Vdaoma7RiJQgnnkbPvEbRCuXn9ACj7SP3aJjJg+Wg9uUWcvfgGEf2AJ4Fu
         fukQ==
X-Gm-Message-State: AOJu0YyZMZlCc8HqUQThfjIXeFcMbSvrvKtIIEe6C+fNLvwKbtxB+lwd
	Uw+NiUZwhcziBNmMImv20L4Q7t1h4Pvs9LRi/IURuYgXR7ey4VQYdTffNO3YSQPgfUXcuARb5Kx
	YUOt8ow==
X-Google-Smtp-Source: AGHT+IGJ6oWQt9pPNDOFpDwUhmUkchmZG7vYr6AgOtYLA0UHXJ19+emc4VinifyPwJarLmKBFKr9hPQPe3wh
X-Received: from edbfe1.prod.google.com ([2002:a05:6402:3901:b0:5dc:771e:a6c0])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:2710:b0:5dc:92c0:281b
 with SMTP id 4fb4d7f45d1cf-5de45072fe1mr2663681a12.22.1738928488789; Fri, 07
 Feb 2025 03:41:28 -0800 (PST)
Date: Fri,  7 Feb 2025 12:40:34 +0100
In-Reply-To: <cover.1738928210.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1738928210.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <3294c9cbcb6accfb57539d6435be613589e3b276.1738928210.git.dvyukov@google.com>
Subject: [PATCH v6 7/9] perf report: Add latency and parallelism profiling documentation
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com, ak@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Describe latency and parallelism profiling, related flags, and differences
with the currently only supported CPU-consumption-centric profiling.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../callchain-overhead-calculation.txt        |  5 +-
 .../cpu-and-latency-overheads.txt             | 85 +++++++++++++++++++
 tools/perf/Documentation/perf-report.txt      | 49 +++++++----
 tools/perf/Documentation/tips.txt             |  3 +
 4 files changed, 123 insertions(+), 19 deletions(-)

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
diff --git a/tools/perf/Documentation/cpu-and-latency-overheads.txt b/tools/perf/Documentation/cpu-and-latency-overheads.txt
new file mode 100644
index 0000000000000..3b6d637054651
--- /dev/null
+++ b/tools/perf/Documentation/cpu-and-latency-overheads.txt
@@ -0,0 +1,85 @@
+CPU and latency overheads
+-------------------------
+There are two notions of time: wall-clock time and CPU time.
+For a single-threaded program, or a program running on a single-core machine,
+these notions are the same. However, for a multi-threaded/multi-process program
+running on a multi-core machine, these notions are significantly different.
+Each second of wall-clock time we have number-of-cores seconds of CPU time.
+Perf can measure overhead for both of these times (shown in 'overhead' and
+'latency' columns for CPU and wall-clock time correspondingly).
+
+Optimizing CPU overhead is useful to improve 'throughput', while optimizing
+latency overhead is useful to improve 'latency'. It's important to understand
+which one is useful in a concrete situation at hand. For example, the former
+may be useful to improve max throughput of a CI build server that runs on 100%
+CPU utilization, while the latter may be useful to improve user-perceived
+latency of a single interactive program build.
+These overheads may be significantly different in some cases. For example,
+consider a program that executes function 'foo' for 9 seconds with 1 thread,
+and then executes function 'bar' for 1 second with 128 threads (consumes
+128 seconds of CPU time). The CPU overhead is: 'foo' - 6.6%, 'bar' - 93.4%.
+While the latency overhead is: 'foo' - 90%, 'bar' - 10%. If we try to optimize
+running time of the program looking at the (wrong in this case) CPU overhead,
+we would concentrate on the function 'bar', but it can yield only 10% running
+time improvement at best.
+
+By default, perf shows only CPU overhead. To show latency overhead, use
+'perf record --latency' and 'perf report':
+
+-----------------------------------
+Overhead  Latency  Command
+  93.88%   25.79%  cc1
+   1.90%   39.87%  gzip
+   0.99%   10.16%  dpkg-deb
+   0.57%    1.00%  as
+   0.40%    0.46%  sh
+-----------------------------------
+
+To sort by latency overhead, use 'perf report --latency':
+
+-----------------------------------
+Latency  Overhead  Command
+ 39.87%     1.90%  gzip
+ 25.79%    93.88%  cc1
+ 10.16%     0.99%  dpkg-deb
+  4.17%     0.29%  git
+  2.81%     0.11%  objtool
+-----------------------------------
+
+To get insight into the difference between the overheads, you may check
+parallelization histogram with '--sort=latency,parallelism,comm,symbol --hierarchy'
+flags. It shows fraction of (wall-clock) time the workload utilizes different
+numbers of cores ('Parallelism' column). For example, in the following case
+the workload utilizes only 1 core most of the time, but also has some
+highly-parallel phases, which explains significant difference between
+CPU and wall-clock overheads:
+
+-----------------------------------
+  Latency  Overhead     Parallelism / Command / Symbol
++  56.98%     2.29%     1
++  16.94%     1.36%     2
++   4.00%    20.13%     125
++   3.66%    18.25%     124
++   3.48%    17.66%     126
++   3.26%     0.39%     3
++   2.61%    12.93%     123
+-----------------------------------
+
+By expanding corresponding lines, you may see what commands/functions run
+at the given parallelism level:
+
+-----------------------------------
+  Latency  Overhead     Parallelism / Command / Symbol
+-  56.98%     2.29%     1
+      32.80%     1.32%     gzip
+       4.46%     0.18%     cc1
+       2.81%     0.11%     objtool
+       2.43%     0.10%     dpkg-source
+       2.22%     0.09%     ld
+       2.10%     0.08%     dpkg-genchanges
+-----------------------------------
+
+To see the normal function-level profile for particular parallelism levels
+(number of threads actively running on CPUs), you may use '--parallelism'
+filter. For example, to see the profile only for low parallelism phases
+of a workload use '--latency --parallelism=1-2' flags.
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 66794131aec48..3376c47105750 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -44,7 +44,7 @@ OPTIONS
 --comms=::
 	Only consider symbols in these comms. CSV that understands
 	file://filename entries.  This option will affect the percentage of
-	the overhead column.  See --percentage for more info.
+	the overhead and latency columns.  See --percentage for more info.
 --pid=::
         Only show events for given process ID (comma separated list).
 
@@ -54,12 +54,12 @@ OPTIONS
 --dsos=::
 	Only consider symbols in these dsos. CSV that understands
 	file://filename entries.  This option will affect the percentage of
-	the overhead column.  See --percentage for more info.
+	the overhead and latency columns.  See --percentage for more info.
 -S::
 --symbols=::
 	Only consider these symbols. CSV that understands
 	file://filename entries.  This option will affect the percentage of
-	the overhead column.  See --percentage for more info.
+	the overhead and latency columns.  See --percentage for more info.
 
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
+        the overhead and latency columns. See --percentage for more info.
+        Also see the `CPU and latency overheads' section for more details.
+
 --latency::
         Show latency-centric profile rather than the default
         CPU-consumption-centric profile
@@ -92,6 +102,7 @@ OPTIONS
 	entries are displayed as "[other]".
 	- cpu: cpu number the task ran at the time of sample
 	- socket: processor socket number the task ran at the time of sample
+	- parallelism: number of running threads at the time of sample
 	- srcline: filename and line number executed at the time of sample.  The
 	DWARF debugging info must be provided.
 	- srcfile: file name of the source file of the samples. Requires dwarf
@@ -102,12 +113,14 @@ OPTIONS
 	- cgroup_id: ID derived from cgroup namespace device and inode numbers.
 	- cgroup: cgroup pathname in the cgroupfs.
 	- transaction: Transaction abort flags.
-	- overhead: Overhead percentage of sample
-	- overhead_sys: Overhead percentage of sample running in system mode
-	- overhead_us: Overhead percentage of sample running in user mode
-	- overhead_guest_sys: Overhead percentage of sample running in system mode
+	- overhead: CPU overhead percentage of sample.
+	- latency: latency (wall-clock) overhead percentage of sample.
+	  See the `CPU and latency overheads' section for more details.
+	- overhead_sys: CPU overhead percentage of sample running in system mode
+	- overhead_us: CPU overhead percentage of sample running in user mode
+	- overhead_guest_sys: CPU overhead percentage of sample running in system mode
 	on guest machine
-	- overhead_guest_us: Overhead percentage of sample running in user mode on
+	- overhead_guest_us: CPU overhead percentage of sample running in user mode on
 	guest machine
 	- sample: Number of sample
 	- period: Raw number of event count of sample
@@ -130,8 +143,8 @@ OPTIONS
 	- weight2: Average value of event specific weight (2nd field of weight_struct).
 	- weight3: Average value of event specific weight (3rd field of weight_struct).
 
-	By default, comm, dso and symbol keys are used.
-	(i.e. --sort comm,dso,symbol)
+	By default, overhead, comm, dso and symbol keys are used.
+	(i.e. --sort overhead,comm,dso,symbol).
 
 	If --branch-stack option is used, following sort keys are also
 	available:
@@ -206,9 +219,9 @@ OPTIONS
 --fields=::
 	Specify output field - multiple keys can be specified in CSV format.
 	Following fields are available:
-	overhead, overhead_sys, overhead_us, overhead_children, sample, period,
-	weight1, weight2, weight3, ins_lat, p_stage_cyc and retire_lat.  The
-	last 3 names are alias for the corresponding weights.  When the weight
+	overhead, latency, overhead_sys, overhead_us, overhead_children, sample,
+	period, weight1, weight2, weight3, ins_lat, p_stage_cyc and retire_lat.
+	The last 3 names are alias for the corresponding weights.  When the weight
 	fields are used, they will show the average value of the weight.
 
 	Also it can contain any sort key(s).
@@ -294,7 +307,7 @@ OPTIONS
 	Accumulate callchain of children to parent entry so that then can
 	show up in the output.  The output will have a new "Children" column
 	and will be sorted on the data.  It requires callchains are recorded.
-	See the `overhead calculation' section for more details. Enabled by
+	See the `Overhead calculation' section for more details. Enabled by
 	default, disable with --no-children.
 
 --max-stack::
@@ -447,9 +460,9 @@ OPTIONS
 	--call-graph option for details.
 
 --percentage::
-	Determine how to display the overhead percentage of filtered entries.
-	Filters can be applied by --comms, --dsos and/or --symbols options and
-	Zoom operations on the TUI (thread, dso, etc).
+	Determine how to display the CPU and latency overhead percentage
+	of filtered entries. Filters can be applied by --comms, --dsos, --symbols
+	and/or --parallelism options and Zoom operations on the TUI (thread, dso, etc).
 
 	"relative" means it's relative to filtered entries only so that the
 	sum of shown entries will be always 100%.  "absolute" means it retains
@@ -632,6 +645,8 @@ include::itrace.txt[]
 --skip-empty::
 	Do not print 0 results in the --stat output.
 
+include::cpu-and-latency-overheads.txt[]
+
 include::callchain-overhead-calculation.txt[]
 
 SEE ALSO
diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
index 67b326ba00407..f6f71e70ff2cb 100644
--- a/tools/perf/Documentation/tips.txt
+++ b/tools/perf/Documentation/tips.txt
@@ -62,3 +62,6 @@ To show context switches in perf report sample context add --switch-events to pe
 To show time in nanoseconds in record/report add --ns
 To compare hot regions in two workloads use perf record -b -o file ... ; perf diff --stream file1 file2
 To compare scalability of two workload samples use perf diff -c ratio file1 file2
+For latency profiling, try: perf record/report --latency
+For parallelism histogram, try: perf report --hierarchy --sort latency,parallelism,comm,symbol
+To analyze particular parallelism levels, try: perf report --latency --parallelism=32-64
-- 
2.48.1.502.g6dc24dfdaf-goog

