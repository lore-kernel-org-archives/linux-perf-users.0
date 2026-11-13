Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613069;
	b=2fPJLI7pEZ1cd0ZN8lgKacuyC/Rzgt9gwZSEqwZFn4Fb8PIZCR3i8ELsRtth7xsAl9KV
	 CRlm0lqZ5qp1SXOu8SeV2hY0oVzhysQJ4HVuIkq9KZtUOwDOakkmWWW1dbOUgFaIP+gj7
	 6L2Zh0MI7wbSatSw/mtuWm/naE8VqPdKXEsyFRS/Tt8f0YqJXWrZiFaoSK1/rjH9UvW2I
	 CVJUL1+lfHLi7Q5EyTfBRFSL/YDVKunCzwAyaqvzGusHZJ9sqlg+m7272/PhbKCIkgL4k
	 Uhx0BYM9a5SkdCeYTT0G6vA0SIaHL/8rOdH+M6ME6oS8y4qargJLLjPgzPwW3pUDraQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=F5CDZ1JWHhEdFBYjLq8IbYW2bP/odnNfvavGEVAdPAY=;
	b=yFAX8/a860R6pQxt0l9UbuuaREeX/frqj2mBsC/QPUFdpZU+ifnhz4rf+RGTlKhSHba3
	 PA+HxfazCMSzFEmvpBIEOceBhtNltffDrhyCgJejDxHLL0opaHEFUGJsA0purNTupiJSO
	 nt+VtVC/cNBzjZFicozoA93qZb/0Z+MwypFZ92czDVjhIQ6gjwvJybeIglFLrlHvvFsUV
	 SrGDykWJehyuw6bXv0V5NQ8VOvsAbXx8OKWq+Em8pE7IiEaEcZUnrwOMzzsBjtt+sem9L
	 uwjGKXV0M/SKU2Jzd27HIbLA8hxsZ6ReFVyHKdID2H2oDc/nMivMjRIF92Yvr3i00bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JjWnuGzl;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9AE606A881
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 23:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D9AE606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JjWnuGzl
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-375bac6bd21so1121700eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794613066; x=1795217866; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F5CDZ1JWHhEdFBYjLq8IbYW2bP/odnNfvavGEVAdPAY=;
        b=JjWnuGzl5rwC15WZHpYPzORPWu1ZstkvDosccwKY+egLRTP0PJez731mXsspbCpHSJ
         BI10BS68YW/j/ISXK2cTcWwuT9Hmmy3pQHjmnuwhZ0VN4mSUQZiXiFunDh0vWpZvHHAn
         zh9veCYkbygzErVTupTEtrixdq0JYwwNjbU4ALev8YLEqLTlUQ3O7NP6Xcx7v2XsCWuK
         f76KzN2TZSrt/7CMQCe4qzK5rPcXSzmPpUdnIhZI6DcY/mzULr5CYue8bxuyjwlu/pg5
         O4RdiArmPwh6PPVm0YGLsBi70UQXDKEN0vbB89ISv0VQ+pPkDm/dKpxWddLeHnVw6gx9
         FhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794613066; x=1795217866;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F5CDZ1JWHhEdFBYjLq8IbYW2bP/odnNfvavGEVAdPAY=;
        b=WZmxkxxmWLuK+SOV2llX0rzHbJMywdge28fUI7BadAjoxuGYD/XG1n8DMZmLKeD79w
         ruKWX+J5mRslYrpyiFAFKYUkK2c2rz0ixBNgNPiqRAjws4FNzySfm7Y19U/hDIAAV9M8
         5FXQal7jsw2mJFJffsIpHe+TuM92j4hR8RkCqCca5qO6QAilFOzU43t1vP4LujU/5C5B
         oG5u6b1CmVobYH8rfpTrFDNbivT8n18Vy/gdLfOBWLkRPG4SVdgHyfRf9NMQVw6QnEvH
         0wKCg7f2e+vA1XuPKPqGtzq1FGoK5uI7JoCPxf9jLTGA8AOgvnenA4EzvZyxh3eXjJ3d
         qnng==
X-Forwarded-Encrypted: i=1; AL+hErGU4WpFOasNOYKB1/KcbQgK20p6CZ7M17VdQO9xiz3AX/zTNFpXRLmJ4ZpywvcafLoafl9BM1spxEvEki/wFHlp@vger.kernel.org
X-Gm-Message-State: APuU4Z9R9rEXOPtvunp+iJGtvdvea6Cii712AHt+/QsfMGTENncWGoPs
	QLpJseO7mfDUw5A9IYAjYVdN0LwbJm8Pnkf67yn6aRcbuM8AiaRhDqecWtU8PTQNgzNFWv9o7Gc
	OKD3CdlBzbA==
X-Received: from dyff26.prod.google.com ([2002:a05:693c:805a:b0:378:1191:3e95])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:87d4:10b0:371:197b:5ade
 with SMTP id 5a478bee46e88-377e1016802mr6317848eec.11.1794613065746; Fri, 13
 Nov 2026 15:37:45 -0800 (PST)
Date: Fri, 13 Nov 2026 15:37:36 -0800
In-Reply-To: <20261113233739.3626499-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113233739.3626499-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113233739.3626499-2-irogers@google.com>
Subject: [PATCH v2 1/4] perf tool_pmu: Add memory events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add tool PMU events to report memory usage information exposed by
/proc/pid/smaps_rollup and /proc/pid/statm.

The following events are added:
- memory_anon_huge_pages: Anonymous Huge Pages memory in bytes.
- memory_anonymous: Anonymous (non-file-backed) memory in bytes.
- memory_data: Data and stack segment memory in bytes.
- memory_file_pmd_mapped: File-backed PMD-mapped memory in bytes.
- memory_ksm: Kernel Samepage Merging (KSM) memory in bytes.
- memory_lazyfree: LazyFree marked memory in bytes.
- memory_locked: RAM-locked memory in bytes.
- memory_private_clean: Private clean memory in bytes.
- memory_private_dirty: Private dirty memory in bytes.
- memory_private_hugetlb: Private Huge Pages memory in bytes.
- memory_pss: Proportional Set Size (PSS) in bytes.
- memory_pss_anon: Anonymous PSS memory in bytes.
- memory_pss_dirty: Dirty PSS memory in bytes.
- memory_pss_file: File-backed PSS memory in bytes.
- memory_pss_shmem: Shared PSS memory in bytes.
- memory_referenced: Referenced/accessed memory in bytes.
- memory_rss: Resident Set Size (RSS) in bytes.
- memory_shared_clean: Shared clean memory in bytes.
- memory_shared_dirty: Shared dirty memory in bytes.
- memory_shared_hugetlb: Shared Huge Pages memory in bytes.
- memory_shmem_pmd_mapped: Shared PMD-mapped memory in bytes.
- memory_size: Virtual memory size in bytes.
- memory_swap: Swapped-out memory in bytes.
- memory_swap_pss: Proportional swap memory (SwapPss) in bytes.
- memory_text: Code (text segment) memory in bytes.
- memory_uss: Unique Set Size (USS) in bytes.

The events are aggregated across processes in system-wide mode, or
reported per-process when monitoring specific tasks. In per-process mode,
open a /proc/<pid> directory descriptor and resolve statm or smaps_rollup
on each read so post-exec address spaces are observed without PID-reuse
races, and deduplicate sibling threads sharing a Tgid so multi-threaded
processes are not multiplied by thread count.

Because /proc/<pid>/statm and /proc/<pid>/smaps_rollup require a live
mm_struct at counter read time, non-memory_rss per-process events require
an active target at read time (such as -p <pid> or -I interval mode while
a workload runs). For memory_rss, fall back to wait4 rusage ru_maxrss
when a forked workload has already terminated at counter read time.

Example per-process and system-wide output:

  $ perf stat -e memory_size,memory_rss,memory_pss,memory_uss \
      -e memory_data,memory_text -p 3558512 -- sleep 0.1

   Performance counter stats for process id '3558512':

           7,520,256      memory_size
           4,542,464      memory_rss
             585,728      memory_pss
             356,352      memory_uss
             458,752      memory_data
             892,928      memory_text

         0.101111221 seconds time elapsed

  $ perf stat -a -e memory_size,memory_rss,memory_pss,memory_uss sleep 0.1

   Performance counter stats for 'system wide':

  104,040,572,162,048      memory_size
      40,880,496,640      memory_rss
      24,085,870,592      memory_pss
      22,840,549,376      memory_uss

         0.101068461 seconds time elapsed

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c                     |  81 ++-
 .../pmu-events/arch/common/common/tool.json   | 156 +++++
 tools/perf/pmu-events/empty-pmu-events.c      | 326 +++++++----
 tools/perf/util/tool_pmu.c                    | 552 ++++++++++++++++--
 tools/perf/util/tool_pmu.h                    |  26 +
 5 files changed, 954 insertions(+), 187 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 37752d6bfef4..d2c8c0ccea49 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -139,6 +139,7 @@ static const char		*output_name;
 static int			output_fd;
 static char			*metrics;
 static struct rusage_stats	ru_stats;
+static bool			ru_stats_valid;
=20
 struct perf_stat {
 	bool			 record;
@@ -283,12 +284,13 @@ static int read_single_counter(struct evsel *counter,=
 int cpu_map_idx, int threa
 	int err =3D evsel__read_counter(counter, cpu_map_idx, thread);
=20
 	/*
-	 * Reading user and system time will fail when the process
-	 * terminates. Use the wait4 values in that case.
+	 * Reading user, system time and memory_rss will fail when a forked
+	 * workload terminates. Use the wait4 values in that case.
 	 */
-	if (err && cpu_map_idx =3D=3D 0 &&
+	if (err && cpu_map_idx =3D=3D 0 && thread =3D=3D 0 && ru_stats_valid &&
 	    (evsel__tool_event(counter) =3D=3D TOOL_PMU__EVENT_USER_TIME ||
-	     evsel__tool_event(counter) =3D=3D TOOL_PMU__EVENT_SYSTEM_TIME)) {
+	     evsel__tool_event(counter) =3D=3D TOOL_PMU__EVENT_SYSTEM_TIME ||
+	     evsel__tool_event(counter) =3D=3D TOOL_PMU__EVENT_MEMORY_RSS)) {
 		struct perf_counts_values *count =3D
 			perf_counts(counter->counts, cpu_map_idx, thread);
 		struct perf_counts_values *old_count =3D NULL;
@@ -299,10 +301,15 @@ static int read_single_counter(struct evsel *counter,=
 int cpu_map_idx, int threa
=20
 		if (evsel__tool_event(counter) =3D=3D TOOL_PMU__EVENT_USER_TIME)
 			val =3D ru_stats.ru_utime_usec_stat.mean;
-		else
+		else if (evsel__tool_event(counter) =3D=3D TOOL_PMU__EVENT_SYSTEM_TIME)
 			val =3D ru_stats.ru_stime_usec_stat.mean;
+		else
+			val =3D (u64)stat_config.ru_data.ru_maxrss * 1024ULL;
=20
-		count->val =3D val;
+		if (evsel__tool_event(counter) =3D=3D TOOL_PMU__EVENT_MEMORY_RSS && old_=
count)
+			count->val =3D old_count->val + val;
+		else
+			count->val =3D val;
 		if (old_count) {
 			count->run =3D old_count->run + 1;
 			count->ena =3D old_count->ena + 1;
@@ -612,6 +619,34 @@ static void compute_tts(struct timespec *time_start, s=
truct timespec *time_stop,
 	*time_to_sleep =3D tts;
 }
=20
+static void update_rusage_stats(const struct rusage *rusage)
+{
+	const u64 us_to_ns =3D 1000;
+	const u64 s_to_ns =3D 1000000000;
+
+	update_stats(&ru_stats.ru_utime_usec_stat,
+		(rusage->ru_utime.tv_usec * us_to_ns + rusage->ru_utime.tv_sec * s_to_ns=
));
+	update_stats(&ru_stats.ru_stime_usec_stat,
+		(rusage->ru_stime.tv_usec * us_to_ns + rusage->ru_stime.tv_sec * s_to_ns=
));
+	ru_stats_valid =3D true;
+}
+
+static bool reap_workload(int *status, int options)
+{
+	pid_t pid =3D evlist__workload_pid(evsel_list);
+
+	if (pid <=3D 0)
+		return false;
+
+	if (wait4(pid, status, options, &stat_config.ru_data) <=3D 0)
+		return false;
+
+	child_pid =3D -1;
+	evlist__set_workload_pid(evsel_list, -1);
+	update_rusage_stats(&stat_config.ru_data);
+	return true;
+}
+
 static int dispatch_events(bool forks, int timeout, int interval, int *tim=
es)
 {
 	int child_exited =3D 0, status =3D 0;
@@ -628,18 +663,20 @@ static int dispatch_events(bool forks, int timeout, i=
nt interval, int *times)
 	time_to_sleep =3D sleep_time;
=20
 	while (!done) {
-		if (forks) {
-			child_exited =3D waitpid(child_pid, &status, WNOHANG);
-		} else {
+		if (forks)
+			child_exited =3D reap_workload(&status, WNOHANG) ? 1 : 0;
+		else
 			child_exited =3D !is_target_alive(&target,
 							evlist__core(evsel_list)->threads) ? 1 : 0;
-		}
+
 		if (child_exited)
 			break;
=20
 		clock_gettime(CLOCK_MONOTONIC, &time_start);
 		if (!(evlist__poll(evsel_list, time_to_sleep) > 0)) { /* poll timeout or=
 EINTR */
-			if (timeout || handle_interval(interval, times))
+			if (forks && reap_workload(&status, WNOHANG))
+				child_exited =3D 1;
+			if (timeout || handle_interval(interval, times) || child_exited)
 				break;
 			time_to_sleep =3D sleep_time;
 		} else { /* fd revent */
@@ -761,17 +798,6 @@ static int create_perf_stat_counter(struct evsel *evse=
l,
 					      evsel->core.threads);
 }
=20
-static void update_rusage_stats(const struct rusage *rusage)
-{
-	const u64 us_to_ns =3D 1000;
-	const u64 s_to_ns =3D 1000000000;
-
-	update_stats(&ru_stats.ru_utime_usec_stat,
-		(rusage->ru_utime.tv_usec * us_to_ns + rusage->ru_utime.tv_sec * s_to_ns=
));
-	update_stats(&ru_stats.ru_stime_usec_stat,
-		(rusage->ru_stime.tv_usec * us_to_ns + rusage->ru_stime.tv_sec * s_to_ns=
));
-}
-
 static int __run_perf_stat(int argc, const char **argv, int run_idx)
 {
 	int interval =3D stat_config.interval;
@@ -787,6 +813,8 @@ static int __run_perf_stat(int argc, const char **argv,=
 int run_idx)
 	int err, open_err =3D 0;
 	bool second_pass =3D false, has_supported_counters;
=20
+	ru_stats_valid =3D false;
+
 	if (forks) {
 		if (evlist__prepare_workload(evsel_list, &target, argv, is_pipe,
 					     workload_exec_failed_signal) < 0) {
@@ -979,11 +1007,9 @@ static int __run_perf_stat(int argc, const char **arg=
v, int run_idx)
 	if (forks) {
 		if (interval || timeout || evlist__ctlfd_initialized(evsel_list))
 			status =3D dispatch_events(forks, timeout, interval, &times);
-		if (child_pid !=3D -1) {
-			if (timeout)
-				kill(child_pid, SIGTERM);
-			wait4(child_pid, &status, 0, &stat_config.ru_data);
-		}
+		if (child_pid !=3D -1 && timeout)
+			kill(child_pid, SIGTERM);
+		reap_workload(&status, 0);
=20
 		if (workload_exec_errno) {
 			errno =3D workload_exec_errno;
@@ -1026,7 +1052,6 @@ static int __run_perf_stat(int argc, const char **arg=
v, int run_idx)
 		evlist__reset_aggr_stats(evsel_list);
 	} else {
 		update_stats(stat_config.walltime_nsecs_stats, t1 - t0);
-		update_rusage_stats(&stat_config.ru_data);
 	}
=20
 	/*
diff --git a/tools/perf/pmu-events/arch/common/common/tool.json b/tools/per=
f/pmu-events/arch/common/common/tool.json
index 14d0d60a1976..9e0e89553847 100644
--- a/tools/perf/pmu-events/arch/common/common/tool.json
+++ b/tools/perf/pmu-events/arch/common/common/tool.json
@@ -82,5 +82,161 @@
     "EventName": "target_cpu",
     "BriefDescription": "1 if CPUs being analyzed, 0 if threads/processes"=
,
     "ConfigCode": "14"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_anon_huge_pages",
+    "BriefDescription": "Memory backed by anonymous huge pages in bytes",
+    "ConfigCode": "15"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_anonymous",
+    "BriefDescription": "Memory not mapped to a file (anonymous) in bytes"=
,
+    "ConfigCode": "16"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_data",
+    "BriefDescription": "Memory dedicated to data and stack in bytes",
+    "ConfigCode": "17"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_file_pmd_mapped",
+    "BriefDescription": "Memory backed by file and mapped with Page Middle=
 Directory (PMD) in bytes",
+    "ConfigCode": "18"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_ksm",
+    "BriefDescription": "Memory shared via Kernel Samepage Merging (KSM) i=
n bytes",
+    "ConfigCode": "19"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_lazyfree",
+    "BriefDescription": "Memory marked as LazyFree in bytes",
+    "ConfigCode": "20"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_locked",
+    "BriefDescription": "Memory locked in RAM in bytes",
+    "ConfigCode": "21"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_private_clean",
+    "BriefDescription": "Private clean memory (not shared, not modified) i=
n bytes",
+    "ConfigCode": "22"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_private_dirty",
+    "BriefDescription": "Private dirty memory (not shared, modified) in by=
tes",
+    "ConfigCode": "23"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_private_hugetlb",
+    "BriefDescription": "Private memory backed by huge pages in bytes",
+    "ConfigCode": "24"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_pss",
+    "BriefDescription": "Proportional Share Size (PSS) in bytes",
+    "ConfigCode": "25"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_pss_anon",
+    "BriefDescription": "Proportional Share Size (PSS) for anonymous memor=
y in bytes",
+    "ConfigCode": "26"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_pss_dirty",
+    "BriefDescription": "Proportional Share Size (PSS) for dirty memory in=
 bytes",
+    "ConfigCode": "27"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_pss_file",
+    "BriefDescription": "Proportional Share Size (PSS) for file-backed mem=
ory in bytes",
+    "ConfigCode": "28"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_pss_shmem",
+    "BriefDescription": "Proportional Share Size (PSS) for shared memory i=
n bytes",
+    "ConfigCode": "29"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_referenced",
+    "BriefDescription": "Memory marked as referenced/accessed in bytes",
+    "ConfigCode": "30"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_rss",
+    "BriefDescription": "Resident Set Size (RSS) in bytes",
+    "ConfigCode": "31"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_shared_clean",
+    "BriefDescription": "Shared clean memory (shared with other processes,=
 not modified) in bytes",
+    "ConfigCode": "32"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_shared_dirty",
+    "BriefDescription": "Shared dirty memory (shared with other processes,=
 modified) in bytes",
+    "ConfigCode": "33"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_shared_hugetlb",
+    "BriefDescription": "Shared memory backed by huge pages in bytes",
+    "ConfigCode": "34"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_shmem_pmd_mapped",
+    "BriefDescription": "Shared memory mapped with Page Middle Directory (=
PMD) in bytes",
+    "ConfigCode": "35"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_size",
+    "BriefDescription": "Virtual memory size in bytes",
+    "ConfigCode": "36"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_swap",
+    "BriefDescription": "Memory swapped out to disk in bytes",
+    "ConfigCode": "37"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_swap_pss",
+    "BriefDescription": "Proportional Share Size (PSS) for swap memory in =
bytes",
+    "ConfigCode": "38"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_text",
+    "BriefDescription": "Memory dedicated to code (text segment) in bytes"=
,
+    "ConfigCode": "39"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_uss",
+    "BriefDescription": "Unique Set Size (USS) in bytes",
+    "ConfigCode": "40"
   }
 ]
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-even=
ts/empty-pmu-events.c
index 7df1552403e7..8d1b9e9b4f58 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -2544,116 +2544,168 @@ static const char *const big_c_string =3D
 /* offset=3D126320 */
 "target_cpu\000tool\0001 if CPUs being analyzed, 0 if threads/processes\00=
0config=3D0xe\000\00000\000\000\000\000\000"
 /* offset=3D126404 */
+"memory_anon_huge_pages\000tool\000Memory backed by anonymous huge pages i=
n bytes\000config=3D0xf\000\00000\000\000\000\000\000"
+/* offset=3D126498 */
+"memory_anonymous\000tool\000Memory not mapped to a file (anonymous) in by=
tes\000config=3D0x10\000\00000\000\000\000\000\000"
+/* offset=3D126589 */
+"memory_data\000tool\000Memory dedicated to data and stack in bytes\000con=
fig=3D0x11\000\00000\000\000\000\000\000"
+/* offset=3D126670 */
+"memory_file_pmd_mapped\000tool\000Memory backed by file and mapped with P=
age Middle Directory (PMD) in bytes\000config=3D0x12\000\00000\000\000\000\=
000\000"
+/* offset=3D126793 */
+"memory_ksm\000tool\000Memory shared via Kernel Samepage Merging (KSM) in =
bytes\000config=3D0x13\000\00000\000\000\000\000\000"
+/* offset=3D126886 */
+"memory_lazyfree\000tool\000Memory marked as LazyFree in bytes\000config=
=3D0x14\000\00000\000\000\000\000\000"
+/* offset=3D126962 */
+"memory_locked\000tool\000Memory locked in RAM in bytes\000config=3D0x15\0=
00\00000\000\000\000\000\000"
+/* offset=3D127031 */
+"memory_private_clean\000tool\000Private clean memory (not shared, not mod=
ified) in bytes\000config=3D0x16\000\00000\000\000\000\000\000"
+/* offset=3D127134 */
+"memory_private_dirty\000tool\000Private dirty memory (not shared, modifie=
d) in bytes\000config=3D0x17\000\00000\000\000\000\000\000"
+/* offset=3D127233 */
+"memory_private_hugetlb\000tool\000Private memory backed by huge pages in =
bytes\000config=3D0x18\000\00000\000\000\000\000\000"
+/* offset=3D127326 */
+"memory_pss\000tool\000Proportional Share Size (PSS) in bytes\000config=3D=
0x19\000\00000\000\000\000\000\000"
+/* offset=3D127401 */
+"memory_pss_anon\000tool\000Proportional Share Size (PSS) for anonymous me=
mory in bytes\000config=3D0x1a\000\00000\000\000\000\000\000"
+/* offset=3D127502 */
+"memory_pss_dirty\000tool\000Proportional Share Size (PSS) for dirty memor=
y in bytes\000config=3D0x1b\000\00000\000\000\000\000\000"
+/* offset=3D127600 */
+"memory_pss_file\000tool\000Proportional Share Size (PSS) for file-backed =
memory in bytes\000config=3D0x1c\000\00000\000\000\000\000\000"
+/* offset=3D127703 */
+"memory_pss_shmem\000tool\000Proportional Share Size (PSS) for shared memo=
ry in bytes\000config=3D0x1d\000\00000\000\000\000\000\000"
+/* offset=3D127802 */
+"memory_referenced\000tool\000Memory marked as referenced/accessed in byte=
s\000config=3D0x1e\000\00000\000\000\000\000\000"
+/* offset=3D127891 */
+"memory_rss\000tool\000Resident Set Size (RSS) in bytes\000config=3D0x1f\0=
00\00000\000\000\000\000\000"
+/* offset=3D127960 */
+"memory_shared_clean\000tool\000Shared clean memory (shared with other pro=
cesses, not modified) in bytes\000config=3D0x20\000\00000\000\000\000\000\0=
00"
+/* offset=3D128078 */
+"memory_shared_dirty\000tool\000Shared dirty memory (shared with other pro=
cesses, modified) in bytes\000config=3D0x21\000\00000\000\000\000\000\000"
+/* offset=3D128192 */
+"memory_shared_hugetlb\000tool\000Shared memory backed by huge pages in by=
tes\000config=3D0x22\000\00000\000\000\000\000\000"
+/* offset=3D128283 */
+"memory_shmem_pmd_mapped\000tool\000Shared memory mapped with Page Middle =
Directory (PMD) in bytes\000config=3D0x23\000\00000\000\000\000\000\000"
+/* offset=3D128395 */
+"memory_size\000tool\000Virtual memory size in bytes\000config=3D0x24\000\=
00000\000\000\000\000\000"
+/* offset=3D128461 */
+"memory_swap\000tool\000Memory swapped out to disk in bytes\000config=3D0x=
25\000\00000\000\000\000\000\000"
+/* offset=3D128534 */
+"memory_swap_pss\000tool\000Proportional Share Size (PSS) for swap memory =
in bytes\000config=3D0x26\000\00000\000\000\000\000\000"
+/* offset=3D128630 */
+"memory_text\000tool\000Memory dedicated to code (text segment) in bytes\0=
00config=3D0x27\000\00000\000\000\000\000\000"
+/* offset=3D128716 */
+"memory_uss\000tool\000Unique Set Size (USS) in bytes\000config=3D0x28\000=
\00000\000\000\000\000\000"
+/* offset=3D128783 */
 "bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=3D0x8a\000\0000=
0\000\000\000\000\000"
-/* offset=3D126466 */
+/* offset=3D128845 */
 "bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=3D0x8b\000\0000=
0\000\000\000\000\000"
-/* offset=3D126528 */
+/* offset=3D128907 */
 "l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x40\000\00000\0=
00\000\000\000Attributable Level 3 cache access, read\000"
-/* offset=3D126626 */
+/* offset=3D129005 */
 "segment_reg_loads.any\000other\000Number of segment register loads\000eve=
nt=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\000\000\000"
-/* offset=3D126728 */
+/* offset=3D129107 */
 "dispatch_blocked.any\000other\000Memory cluster signals to block micro-op=
 dispatch for any reason\000event=3D9,period=3D200000,umask=3D0x20\000\0000=
0\000\000\000\000\000"
-/* offset=3D126861 */
+/* offset=3D129240 */
 "eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technology (=
EIST) transitions\000event=3D0x3a,period=3D200000\000\00000\000\000\000\000=
\000"
-/* offset=3D126979 */
+/* offset=3D129358 */
 "hisi_sccl,ddrc\000"
-/* offset=3D126994 */
+/* offset=3D129373 */
 "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=3D2\=
000\00000\000\000\000\000\000"
-/* offset=3D127064 */
+/* offset=3D129443 */
 "uncore_cbox\000"
-/* offset=3D127076 */
+/* offset=3D129455 */
 "unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core snoop resul=
ted from L3 Eviction which misses in some processor core\000event=3D0x22,um=
ask=3D0x81\000\00000\000\000\000\000\000"
-/* offset=3D127230 */
+/* offset=3D129609 */
 "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\000\00000\000\00=
0\000\000\000"
-/* offset=3D127284 */
+/* offset=3D129663 */
 "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc0\000\00000\00=
0\000\000\000\000"
-/* offset=3D127342 */
+/* offset=3D129721 */
 "hisi_sccl,l3c\000"
-/* offset=3D127356 */
+/* offset=3D129735 */
 "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000event=3D7\00=
0\00000\000\000\000\000\000"
-/* offset=3D127424 */
+/* offset=3D129803 */
 "uncore_imc_free_running\000"
-/* offset=3D127448 */
+/* offset=3D129827 */
 "uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000eve=
nt=3D0x12\000\00000\000\000\000\000\000"
-/* offset=3D127528 */
+/* offset=3D129907 */
 "uncore_imc\000"
-/* offset=3D127539 */
+/* offset=3D129918 */
 "uncore_imc.cache_hits\000uncore\000Total cache hits\000event=3D0x34\000\0=
0000\000\000\000\000\000"
-/* offset=3D127604 */
+/* offset=3D129983 */
 "uncore_sys_ddr_pmu\000"
-/* offset=3D127623 */
+/* offset=3D130002 */
 "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=3D0=
x2b\000v8\00000\000\000\000\000\000"
-/* offset=3D127699 */
+/* offset=3D130078 */
 "uncore_sys_ccn_pmu\000"
-/* offset=3D127718 */
+/* offset=3D130097 */
 "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=3D0x=
2c\0000x01\00000\000\000\000\000\000"
-/* offset=3D127795 */
+/* offset=3D130174 */
 "uncore_sys_cmn_pmu\000"
-/* offset=3D127814 */
+/* offset=3D130193 */
 "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in firs=
t lookup result (high priority)\000eventid=3D1,type=3D5\000(434|436|43c|43a=
).*\00000\000\000\000\000\000"
-/* offset=3D127957 */
+/* offset=3D130336 */
 "CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=3Dcpu\\-clock@=
 if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@) / (dur=
ation_time * 1e9)\000\000Average CPU utilization\000\0001CPUs\000\000\000\0=
00011"
-/* offset=3D128143 */
+/* offset=3D130522 */
 "cs_per_second\000Default\000software@context\\-switches\\,name\\=3Dcontex=
t\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #tar=
get_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Context=
 switches per CPU second\000\0001cs/sec\000\000\000\000011"
-/* offset=3D128376 */
+/* offset=3D130755 */
 "migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=3D=
cpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if =
#target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Pro=
cess migrations to a new CPU per CPU second\000\0001migrations/sec\000\000\=
000\000011"
-/* offset=3D128636 */
+/* offset=3D131015 */
 "page_faults_per_second\000Default\000software@page\\-faults\\,name\\=3Dpa=
ge\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #targ=
et_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Page fau=
lts per CPU second\000\0001faults/sec\000\000\000\000011"
-/* offset=3D128867 */
+/* offset=3D131246 */
 "insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_cycl=
e < 1\000Instructions Per Cycle\000\0001instructions\000\000\000\000001"
-/* offset=3D128980 */
+/* offset=3D131359 */
 "stalled_cycles_per_instruction\000Default\000(max(stalled\\-cycles\\-fron=
tend, stalled\\-cycles\\-backend) / instructions if has_event(stalled\\-cyc=
les\\-frontend) & has_event(stalled\\-cycles\\-backend) else (stalled\\-cyc=
les\\-frontend / instructions if has_event(stalled\\-cycles\\-frontend) els=
e (stalled\\-cycles\\-backend / instructions if has_event(stalled\\-cycles\=
\-backend) else 0)))\000\000Max front or backend stalls per instruction\000=
\000\000\000\000\000001"
-/* offset=3D129405 */
+/* offset=3D131784 */
 "frontend_cycles_idle\000Default\000(stalled\\-cycles\\-frontend / cpu\\-c=
ycles if has_event(stalled\\-cycles\\-frontend) else 0)\000frontend_cycles_=
idle > 0.1\000Frontend stalls per cycle\000\000\000\000\000\000001"
-/* offset=3D129584 */
+/* offset=3D131963 */
 "backend_cycles_idle\000Default\000(stalled\\-cycles\\-backend / cpu\\-cyc=
les if has_event(stalled\\-cycles\\-backend) else 0)\000backend_cycles_idle=
 > 0.2\000Backend stalls per cycle\000\000\000\000\000\000001"
-/* offset=3D129758 */
+/* offset=3D132137 */
 "cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\000\000011"
-/* offset=3D129934 */
+/* offset=3D132313 */
 "branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Branches per CPU second\000\0001000M/sec\000\000\000\000011=
"
-/* offset=3D130114 */
+/* offset=3D132493 */
 "branch_miss_rate\000Default\000branch\\-misses / branches\000branch_miss_=
rate > 0.05\000Branch miss rate\000\000100%\000\000\000\000001"
-/* offset=3D130218 */
+/* offset=3D132597 */
 "l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / L1\\-dcache\\-=
loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\000100%\000\000\000\000=
001"
-/* offset=3D130334 */
+/* offset=3D132713 */
 "llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-loads\000llc_mis=
s_rate > 0.05\000LLC miss rate\000\000100%\000\000\000\000001"
-/* offset=3D130435 */
+/* offset=3D132814 */
 "l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / L1\\-icache\\-=
loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\000100%\000\000\000\0000=
01"
-/* offset=3D130550 */
+/* offset=3D132929 */
 "dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\-loads\000dtlb=
_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\000\000\000001"
-/* offset=3D130656 */
+/* offset=3D133035 */
 "itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\-loads\000itlb=
_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\000\000\000001"
-/* offset=3D130762 */
+/* offset=3D133141 */
 "l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch\\-misses / L1=
\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.05\000L1 prefetch miss =
rate\000\000100%\000\000\000\000001"
-/* offset=3D130910 */
+/* offset=3D133289 */
 "CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000"
-/* offset=3D130933 */
+/* offset=3D133312 */
 "IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\000\0=
00\000\000\000\000000"
-/* offset=3D130997 */
+/* offset=3D133376 */
 "Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_unh=
alted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalt=
ed.ref_xclk)))\000\000\000\000\000\000\000\000000"
-/* offset=3D131164 */
+/* offset=3D133543 */
 "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\00=
0\000\000\000\000\000000"
-/* offset=3D131229 */
+/* offset=3D133608 */
 "icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000=
\000\000\000\000\000\000000"
-/* offset=3D131297 */
+/* offset=3D133676 */
 "cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\0=
00\000\000\000\000\000\000000"
-/* offset=3D131369 */
+/* offset=3D133748 */
 "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit +=
 l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000"
-/* offset=3D131464 */
+/* offset=3D133843 */
 "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.dema=
nd_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\000\000\000\0=
00\000\000\000000"
-/* offset=3D131599 */
+/* offset=3D133978 */
 "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\000\=
000\000\000\000\000000"
-/* offset=3D131664 */
+/* offset=3D134043 */
 "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\000\=
000\000\000\000\000\000000"
-/* offset=3D131733 */
+/* offset=3D134112 */
 "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000\00=
0\000\000\000\000\000\000000"
-/* offset=3D131804 */
+/* offset=3D134183 */
 "M1\000\000ipc + M2\000\000\000\000\000\000\000\000000"
-/* offset=3D131827 */
+/* offset=3D134206 */
 "M2\000\000ipc + M1\000\000\000\000\000\000\000\000000"
-/* offset=3D131850 */
+/* offset=3D134229 */
 "M3\000\0001 / M3\000\000\000\000\000\000\000\000000"
-/* offset=3D131871 */
+/* offset=3D134250 */
 "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\000\0=
00\000\000\000\000\000\000000"
 ;
=20
@@ -5158,6 +5210,58 @@ static const struct compact_pmu_event pmu_events__co=
mmon_tool[] =3D {
 	{ 125073 },
 	/* has_pmem\000tool\0001 if persistent memory installed otherwise 0\000co=
nfig=3D4\000... */
 	{ 125287 },
+	/* memory_anon_huge_pages\000tool\000Memory backed by anonymous huge page=
s in bytes... */
+	{ 126404 },
+	/* memory_anonymous\000tool\000Memory not mapped to a file (anonymous) in=
 bytes\000... */
+	{ 126498 },
+	/* memory_data\000tool\000Memory dedicated to data and stack in bytes\000=
config=3D0x1... */
+	{ 126589 },
+	/* memory_file_pmd_mapped\000tool\000Memory backed by file and mapped wit=
h Page Mid... */
+	{ 126670 },
+	/* memory_ksm\000tool\000Memory shared via Kernel Samepage Merging (KSM) =
in bytes\0... */
+	{ 126793 },
+	/* memory_lazyfree\000tool\000Memory marked as LazyFree in bytes\000confi=
g=3D0x14\000... */
+	{ 126886 },
+	/* memory_locked\000tool\000Memory locked in RAM in bytes\000config=3D0x1=
5\000\00000\... */
+	{ 126962 },
+	/* memory_private_clean\000tool\000Private clean memory (not shared, not =
modified) ... */
+	{ 127031 },
+	/* memory_private_dirty\000tool\000Private dirty memory (not shared, modi=
fied) in b... */
+	{ 127134 },
+	/* memory_private_hugetlb\000tool\000Private memory backed by huge pages =
in bytes\0... */
+	{ 127233 },
+	/* memory_pss\000tool\000Proportional Share Size (PSS) in bytes\000config=
=3D0x19\000\... */
+	{ 127326 },
+	/* memory_pss_anon\000tool\000Proportional Share Size (PSS) for anonymous=
 memory in... */
+	{ 127401 },
+	/* memory_pss_dirty\000tool\000Proportional Share Size (PSS) for dirty me=
mory in by... */
+	{ 127502 },
+	/* memory_pss_file\000tool\000Proportional Share Size (PSS) for file-back=
ed memory ... */
+	{ 127600 },
+	/* memory_pss_shmem\000tool\000Proportional Share Size (PSS) for shared m=
emory in b... */
+	{ 127703 },
+	/* memory_referenced\000tool\000Memory marked as referenced/accessed in b=
ytes\000co... */
+	{ 127802 },
+	/* memory_rss\000tool\000Resident Set Size (RSS) in bytes\000config=3D0x1=
f\000\00000\... */
+	{ 127891 },
+	/* memory_shared_clean\000tool\000Shared clean memory (shared with other =
processes,... */
+	{ 127960 },
+	/* memory_shared_dirty\000tool\000Shared dirty memory (shared with other =
processes,... */
+	{ 128078 },
+	/* memory_shared_hugetlb\000tool\000Shared memory backed by huge pages in=
 bytes\000... */
+	{ 128192 },
+	/* memory_shmem_pmd_mapped\000tool\000Shared memory mapped with Page Midd=
le Directo... */
+	{ 128283 },
+	/* memory_size\000tool\000Virtual memory size in bytes\000config=3D0x24\0=
00\00000\000... */
+	{ 128395 },
+	/* memory_swap\000tool\000Memory swapped out to disk in bytes\000config=
=3D0x25\000\00... */
+	{ 128461 },
+	/* memory_swap_pss\000tool\000Proportional Share Size (PSS) for swap memo=
ry in byte... */
+	{ 128534 },
+	/* memory_text\000tool\000Memory dedicated to code (text segment) in byte=
s\000confi... */
+	{ 128630 },
+	/* memory_uss\000tool\000Unique Set Size (USS) in bytes\000config=3D0x28\=
000\00000\00... */
+	{ 128716 },
 	/* num_cores\000tool\000Number of cores. A core consists of 1 or more thr=
ead, with ... */
 	{ 125363 },
 	/* num_cpus\000tool\000Number of logical Linux CPUs. There may be multipl=
e such CPU... */
@@ -5203,39 +5307,39 @@ static const struct pmu_table_entry pmu_events__com=
mon[] =3D {
=20
 static const struct compact_pmu_event pmu_metrics__common_default_core[] =
=3D {
 	/* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=3Dcpu\\-clo=
ck@ if #targ... */
-	{ 127957 },
+	{ 130336 },
 	/* backend_cycles_idle\000Default\000(stalled\\-cycles\\-backend / cpu\\-=
cycles if ... */
-	{ 129584 },
+	{ 131963 },
 	/* branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name=
\\=3Dcpu\\-c... */
-	{ 129934 },
+	{ 132313 },
 	/* branch_miss_rate\000Default\000branch\\-misses / branches\000branch_mi=
ss_rate > ... */
-	{ 130114 },
+	{ 132493 },
 	/* cs_per_second\000Default\000software@context\\-switches\\,name\\=3Dcon=
text\\-switc... */
-	{ 128143 },
+	{ 130522 },
 	/* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,=
name\\=3Dcpu... */
-	{ 129758 },
+	{ 132137 },
 	/* dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\-loads\000d=
tlb_miss_r... */
-	{ 130550 },
+	{ 132929 },
 	/* frontend_cycles_idle\000Default\000(stalled\\-cycles\\-frontend / cpu\=
\-cycles i... */
-	{ 129405 },
+	{ 131784 },
 	/* insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_c=
ycle < 1\0... */
-	{ 128867 },
+	{ 131246 },
 	/* itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\-loads\000i=
tlb_miss_r... */
-	{ 130656 },
+	{ 133035 },
 	/* l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch\\-misses /=
 L1\\-dcac... */
-	{ 130762 },
+	{ 133141 },
 	/* l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / L1\\-dcache=
\\-loads\0... */
-	{ 130218 },
+	{ 132597 },
 	/* l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / L1\\-icache=
\\-loads\0... */
-	{ 130435 },
+	{ 132814 },
 	/* llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-loads\000llc_=
miss_rate ... */
-	{ 130334 },
+	{ 132713 },
 	/* migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=
=3Dcpu\\-mig... */
-	{ 128376 },
+	{ 130755 },
 	/* page_faults_per_second\000Default\000software@page\\-faults\\,name\\=
=3Dpage\\-faul... */
-	{ 128636 },
+	{ 131015 },
 	/* stalled_cycles_per_instruction\000Default\000(max(stalled\\-cycles\\-f=
rontend, s... */
-	{ 128980 },
+	{ 131359 },
=20
 };
=20
@@ -5249,41 +5353,41 @@ static const struct pmu_table_entry pmu_metrics__co=
mmon[] =3D {
=20
 static const struct compact_pmu_event pmu_events__test_soc_cpu_default_cor=
e[] =3D {
 	/* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=3D0x8a\000\0=
0000\000\000... */
-	{ 126404 },
+	{ 128783 },
 	/* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=3D0x8b\000\0=
0000\000\000... */
-	{ 126466 },
+	{ 128845 },
 	/* dispatch_blocked.any\000other\000Memory cluster signals to block micro=
-op dispat... */
-	{ 126728 },
+	{ 129107 },
 	/* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technolog=
y (EIST) t... */
-	{ 126861 },
+	{ 129240 },
 	/* l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x40\000\0000=
0\000\000\00... */
-	{ 126528 },
+	{ 128907 },
 	/* segment_reg_loads.any\000other\000Number of segment register loads\000=
event=3D6,pe... */
-	{ 126626 },
+	{ 129005 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_d=
drc[] =3D {
 	/* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=
=3D2\000\00000... */
-	{ 126994 },
+	{ 129373 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_l=
3c[] =3D {
 	/* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000event=3D7=
\000\00000\0... */
-	{ 127356 },
+	{ 129735 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_cbox=
[] =3D {
 	/* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\000\00000\000=
\000\000\000... */
-	{ 127230 },
+	{ 129609 },
 	/* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc0\000\00000=
\000\000\000... */
-	{ 127284 },
+	{ 129663 },
 	/* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core snoop re=
sulted fro... */
-	{ 127076 },
+	{ 129455 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc[=
] =3D {
 	/* uncore_imc.cache_hits\000uncore\000Total cache hits\000event=3D0x34\00=
0\00000\000\... */
-	{ 127539 },
+	{ 129918 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc_=
free_running[] =3D {
 	/* uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000=
event=3D0x12... */
-	{ 127448 },
+	{ 129827 },
=20
 };
=20
@@ -5296,61 +5400,61 @@ static const struct pmu_table_entry pmu_events__tes=
t_soc_cpu[] =3D {
 	{
 		.entries =3D pmu_events__test_soc_cpu_hisi_sccl_ddrc,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_ddrc),
-		.pmu_name =3D { 126979 /* hisi_sccl,ddrc\000 */ },
+		.pmu_name =3D { 129358 /* hisi_sccl,ddrc\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_cpu_hisi_sccl_l3c,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_l3c),
-		.pmu_name =3D { 127342 /* hisi_sccl,l3c\000 */ },
+		.pmu_name =3D { 129721 /* hisi_sccl,l3c\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_cpu_uncore_cbox,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_cbox),
-		.pmu_name =3D { 127064 /* uncore_cbox\000 */ },
+		.pmu_name =3D { 129443 /* uncore_cbox\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_cpu_uncore_imc,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc),
-		.pmu_name =3D { 127528 /* uncore_imc\000 */ },
+		.pmu_name =3D { 129907 /* uncore_imc\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_cpu_uncore_imc_free_running,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc_free_run=
ning),
-		.pmu_name =3D { 127424 /* uncore_imc_free_running\000 */ },
+		.pmu_name =3D { 129803 /* uncore_imc_free_running\000 */ },
 	},
 };
=20
 static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_co=
re[] =3D {
 	/* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
-	{ 130910 },
+	{ 133289 },
 	/* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\0=
00\000\000... */
-	{ 131599 },
+	{ 133978 },
 	/* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hi=
t + l2_rqs... */
-	{ 131369 },
+	{ 133748 },
 	/* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.d=
emand_data... */
-	{ 131464 },
+	{ 133843 },
 	/* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\0=
00\000\000... */
-	{ 131664 },
+	{ 134043 },
 	/* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000=
\000\000\0... */
-	{ 131733 },
+	{ 134112 },
 	/* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_=
unhalted.t... */
-	{ 130997 },
+	{ 133376 },
 	/* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\00=
0\000\000\... */
-	{ 130933 },
+	{ 133312 },
 	/* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\00=
0\000\000\... */
-	{ 131871 },
+	{ 134250 },
 	/* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
-	{ 131804 },
+	{ 134183 },
 	/* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
-	{ 131827 },
+	{ 134206 },
 	/* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
-	{ 131850 },
+	{ 134229 },
 	/* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\00=
0\000\000\... */
-	{ 131297 },
+	{ 133676 },
 	/* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000=
\000\000\0... */
-	{ 131164 },
+	{ 133543 },
 	/* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\=
000\000\00... */
-	{ 131229 },
+	{ 133608 },
=20
 };
=20
@@ -5364,15 +5468,15 @@ static const struct pmu_table_entry pmu_metrics__te=
st_soc_cpu[] =3D {
=20
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ccn_pmu[] =3D {
 	/* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=
=3D0x2c\0000x0... */
-	{ 127718 },
+	{ 130097 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
cmn_pmu[] =3D {
 	/* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in f=
irst looku... */
-	{ 127814 },
+	{ 130193 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ddr_pmu[] =3D {
 	/* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=
=3D0x2b\000v8... */
-	{ 127623 },
+	{ 130002 },
=20
 };
=20
@@ -5380,17 +5484,17 @@ static const struct pmu_table_entry pmu_events__tes=
t_soc_sys[] =3D {
 	{
 		.entries =3D pmu_events__test_soc_sys_uncore_sys_ccn_pmu,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ccn_pmu)=
,
-		.pmu_name =3D { 127699 /* uncore_sys_ccn_pmu\000 */ },
+		.pmu_name =3D { 130078 /* uncore_sys_ccn_pmu\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_sys_uncore_sys_cmn_pmu,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_cmn_pmu)=
,
-		.pmu_name =3D { 127795 /* uncore_sys_cmn_pmu\000 */ },
+		.pmu_name =3D { 130174 /* uncore_sys_cmn_pmu\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_sys_uncore_sys_ddr_pmu,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ddr_pmu)=
,
-		.pmu_name =3D { 127604 /* uncore_sys_ddr_pmu\000 */ },
+		.pmu_name =3D { 129983 /* uncore_sys_ddr_pmu\000 */ },
 	},
 };
=20
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index d2f7591747d9..0ae08cd910bc 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -12,10 +12,17 @@
 #include "tsc.h"
 #include <api/fs/fs.h>
 #include <api/io.h>
+#include <api/io_dir.h>
 #include <internal/threadmap.h>
 #include <perf/threadmap.h>
+#include <ctype.h>
+#include <errno.h>
 #include <fcntl.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
 #include <strings.h>
+#include <unistd.h>
=20
 #define INVALID_START_TIME ~0ULL
=20
@@ -35,6 +42,32 @@ static const char *const tool_pmu__event_names[TOOL_PMU_=
_EVENT_MAX] =3D {
 	"system_tsc_freq",
 	"core_wide",
 	"target_cpu",
+	"memory_anon_huge_pages",
+	"memory_anonymous",
+	"memory_data",
+	"memory_file_pmd_mapped",
+	"memory_ksm",
+	"memory_lazyfree",
+	"memory_locked",
+	"memory_private_clean",
+	"memory_private_dirty",
+	"memory_private_hugetlb",
+	"memory_pss",
+	"memory_pss_anon",
+	"memory_pss_dirty",
+	"memory_pss_file",
+	"memory_pss_shmem",
+	"memory_referenced",
+	"memory_rss",
+	"memory_shared_clean",
+	"memory_shared_dirty",
+	"memory_shared_hugetlb",
+	"memory_shmem_pmd_mapped",
+	"memory_size",
+	"memory_swap",
+	"memory_swap_pss",
+	"memory_text",
+	"memory_uss",
 };
=20
 bool tool_pmu__skip_event(const char *name __maybe_unused)
@@ -203,6 +236,205 @@ static int read_pid_stat_field(int fd, int field, __u=
64 *val)
 	return -EINVAL;
 }
=20
+static bool tool_pmu__is_memory_event(enum tool_pmu_event ev)
+{
+	return ev >=3D TOOL_PMU__EVENT_MEMORY_ANON_HUGE_PAGES &&
+	       ev <=3D TOOL_PMU__EVENT_MEMORY_USS;
+}
+
+static const char *tool_pmu__memory_event_to_key(enum tool_pmu_event ev)
+{
+	switch (ev) {
+	case TOOL_PMU__EVENT_MEMORY_ANON_HUGE_PAGES: return "AnonHugePages:";
+	case TOOL_PMU__EVENT_MEMORY_ANONYMOUS: return "Anonymous:";
+	case TOOL_PMU__EVENT_MEMORY_FILE_PMD_MAPPED: return "FilePmdMapped:";
+	case TOOL_PMU__EVENT_MEMORY_KSM: return "KSM:";
+	case TOOL_PMU__EVENT_MEMORY_LAZYFREE: return "LazyFree:";
+	case TOOL_PMU__EVENT_MEMORY_LOCKED: return "Locked:";
+	case TOOL_PMU__EVENT_MEMORY_PRIVATE_CLEAN: return "Private_Clean:";
+	case TOOL_PMU__EVENT_MEMORY_PRIVATE_DIRTY: return "Private_Dirty:";
+	case TOOL_PMU__EVENT_MEMORY_PRIVATE_HUGETLB: return "Private_Hugetlb:";
+	case TOOL_PMU__EVENT_MEMORY_PSS: return "Pss:";
+	case TOOL_PMU__EVENT_MEMORY_PSS_ANON: return "Pss_Anon:";
+	case TOOL_PMU__EVENT_MEMORY_PSS_DIRTY: return "Pss_Dirty:";
+	case TOOL_PMU__EVENT_MEMORY_PSS_FILE: return "Pss_File:";
+	case TOOL_PMU__EVENT_MEMORY_PSS_SHMEM: return "Pss_Shmem:";
+	case TOOL_PMU__EVENT_MEMORY_REFERENCED: return "Referenced:";
+	case TOOL_PMU__EVENT_MEMORY_RSS: return "Rss:";
+	case TOOL_PMU__EVENT_MEMORY_SHARED_CLEAN: return "Shared_Clean:";
+	case TOOL_PMU__EVENT_MEMORY_SHARED_DIRTY: return "Shared_Dirty:";
+	case TOOL_PMU__EVENT_MEMORY_SHARED_HUGETLB: return "Shared_Hugetlb:";
+	case TOOL_PMU__EVENT_MEMORY_SHMEM_PMD_MAPPED: return "ShmemPmdMapped:";
+	case TOOL_PMU__EVENT_MEMORY_SWAP: return "Swap:";
+	case TOOL_PMU__EVENT_MEMORY_SWAP_PSS: return "SwapPss:";
+	case TOOL_PMU__EVENT_MEMORY_DATA:
+	case TOOL_PMU__EVENT_MEMORY_SIZE:
+	case TOOL_PMU__EVENT_MEMORY_TEXT:
+	case TOOL_PMU__EVENT_MEMORY_USS:
+	case TOOL_PMU__EVENT_DURATION_TIME:
+	case TOOL_PMU__EVENT_USER_TIME:
+	case TOOL_PMU__EVENT_SYSTEM_TIME:
+	case TOOL_PMU__EVENT_HAS_PMEM:
+	case TOOL_PMU__EVENT_NUM_CORES:
+	case TOOL_PMU__EVENT_NUM_CPUS:
+	case TOOL_PMU__EVENT_NUM_CPUS_ONLINE:
+	case TOOL_PMU__EVENT_NUM_DIES:
+	case TOOL_PMU__EVENT_NUM_PACKAGES:
+	case TOOL_PMU__EVENT_SLOTS:
+	case TOOL_PMU__EVENT_SMT_ON:
+	case TOOL_PMU__EVENT_SYSTEM_TSC_FREQ:
+	case TOOL_PMU__EVENT_CORE_WIDE:
+	case TOOL_PMU__EVENT_TARGET_CPU:
+	case TOOL_PMU__EVENT_NONE:
+	case TOOL_PMU__EVENT_MAX:
+	default: return NULL;
+	}
+}
+
+static int read_proc_status_u64(struct io *io, const char *key, u64 *val)
+{
+	int ch;
+
+	while ((ch =3D io__get_char(io)) !=3D -1) {
+		/* Check if line starts with key */
+		if (ch =3D=3D key[0]) {
+			const char *k =3D key + 1;
+
+			while (*k && (ch =3D io__get_char(io)) =3D=3D *k)
+				k++;
+
+			if (!*k) {
+				/* Found key, skip whitespace */
+				while ((ch =3D io__get_char(io)) =3D=3D ' ' || ch =3D=3D '\t')
+					;
+				/* Read value */
+				if (ch >=3D '0' && ch <=3D '9') {
+					*val =3D ch - '0';
+					while ((ch =3D io__get_char(io)) >=3D '0' && ch <=3D '9')
+						*val =3D *val * 10 + (ch - '0');
+					if (ch !=3D '\n' && ch !=3D -1)
+						read_until_char(io, '\n');
+					return 0;
+				}
+			}
+		}
+		/* Skip rest of line */
+		if (ch !=3D '\n' && ch !=3D -1)
+			read_until_char(io, '\n');
+	}
+	return -EINVAL;
+}
+
+static int read_pid_tgid(int dir_fd, int *tgid)
+{
+	char buf[1024];
+	struct io io;
+	u64 val;
+	int fd, ret;
+
+	fd =3D openat(dir_fd, "status", O_RDONLY);
+	if (fd < 0)
+		return -errno;
+
+	io__init(&io, fd, buf, sizeof(buf));
+	ret =3D read_proc_status_u64(&io, "Tgid:", &val);
+	close(fd);
+	if (!ret)
+		*tgid =3D (int)val;
+	return ret;
+}
+
+static int read_smaps_rollup_field(struct io *io, const char *key, u64 *va=
l)
+{
+	int ret =3D read_proc_status_u64(io, key, val);
+
+	if (!ret)
+		*val *=3D 1024; /* Convert kB to bytes */
+	return ret;
+}
+
+static int read_smaps_rollup(int fd, enum tool_pmu_event ev, u64 *val)
+{
+	char buf[4096];
+	struct io io;
+
+	lseek(fd, 0, SEEK_SET);
+	io__init(&io, fd, buf, sizeof(buf));
+
+	if (ev =3D=3D TOOL_PMU__EVENT_MEMORY_USS) {
+		u64 pc, pd;
+		int ret;
+
+		ret =3D read_smaps_rollup_field(&io, "Private_Clean:", &pc);
+		if (ret)
+			return ret;
+		ret =3D read_smaps_rollup_field(&io, "Private_Dirty:", &pd);
+		if (ret) {
+			lseek(fd, 0, SEEK_SET);
+			io__init(&io, fd, buf, sizeof(buf));
+			ret =3D read_smaps_rollup_field(&io, "Private_Dirty:", &pd);
+			if (ret)
+				return ret;
+		}
+		*val =3D pc + pd;
+		return 0;
+	}
+
+	return read_smaps_rollup_field(&io, tool_pmu__memory_event_to_key(ev), va=
l);
+}
+
+static int read_statm(int fd, enum tool_pmu_event ev, u64 *val)
+{
+	long page_sz =3D sysconf(_SC_PAGE_SIZE);
+	char buf[128];
+	struct io io;
+	__u64 v;
+
+	if (page_sz <=3D 0)
+		return -EINVAL;
+
+	io__init(&io, fd, buf, sizeof(buf));
+	lseek(fd, 0, SEEK_SET);
+
+	/* Size */
+	if (io__get_dec(&io, &v) !=3D ' ')
+		return -EINVAL;
+	if (ev =3D=3D TOOL_PMU__EVENT_MEMORY_SIZE) {
+		*val =3D v * page_sz;
+		return 0;
+	}
+
+	/* Resident */
+	if (io__get_dec(&io, &v) !=3D ' ') /* Skip */
+		return -EINVAL;
+
+	/* Shared */
+	if (io__get_dec(&io, &v) !=3D ' ') /* Skip */
+		return -EINVAL;
+
+	/* Text */
+	if (io__get_dec(&io, &v) !=3D ' ')
+		return -EINVAL;
+	if (ev =3D=3D TOOL_PMU__EVENT_MEMORY_TEXT) {
+		*val =3D v * page_sz;
+		return 0;
+	}
+
+	/* Lib */
+	if (io__get_dec(&io, &v) !=3D ' ') /* Skip */
+		return -EINVAL;
+
+	/* Data */
+	if (io__get_dec(&io, &v) < 0)
+		return -EINVAL;
+	if (ev =3D=3D TOOL_PMU__EVENT_MEMORY_DATA) {
+		*val =3D v * page_sz;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 int evsel__tool_pmu_prepare_open(struct evsel *evsel,
 				 struct perf_cpu_map *cpus,
 				 int nthreads)
@@ -258,19 +490,138 @@ static int tool_pmu__read_stat(struct evsel *evsel, =
int cpu_map_idx, int thread,
 	return err;
 }
=20
+static int open_memory_pid_dir(enum tool_pmu_event ev, int pid,
+			       int *seen_tgids, int *nr_seen_tgids, int *out_fd)
+{
+	const char *file =3D "smaps_rollup";
+	int dir_fd, test_fd, tgid =3D -1;
+	char buf[PATH_MAX];
+
+	*out_fd =3D -1;
+	snprintf(buf, sizeof(buf), "%s/%d", procfs__mountpoint(), pid);
+	dir_fd =3D open(buf, O_RDONLY | O_DIRECTORY);
+	if (dir_fd < 0)
+		return -errno;
+
+	if (seen_tgids) {
+		int err =3D read_pid_tgid(dir_fd, &tgid);
+
+		if (err) {
+			close(dir_fd);
+			return err;
+		}
+		for (int i =3D 0; i < *nr_seen_tgids; i++) {
+			if (seen_tgids[i] =3D=3D tgid) {
+				close(dir_fd);
+				return 0;
+			}
+		}
+	}
+
+	if (ev =3D=3D TOOL_PMU__EVENT_MEMORY_SIZE ||
+	    ev =3D=3D TOOL_PMU__EVENT_MEMORY_DATA ||
+	    ev =3D=3D TOOL_PMU__EVENT_MEMORY_TEXT)
+		file =3D "statm";
+
+	test_fd =3D openat(dir_fd, file, O_RDONLY);
+	if (test_fd < 0) {
+		int err =3D -errno;
+
+		close(dir_fd);
+		return err;
+	}
+	close(test_fd);
+
+	if (seen_tgids)
+		seen_tgids[(*nr_seen_tgids)++] =3D tgid;
+
+	*out_fd =3D dir_fd;
+	return 0;
+}
+
+static int evsel__tool_pmu_open_one(struct evsel *evsel, enum tool_pmu_eve=
nt ev,
+				    int pid, int idx, int thread,
+				    int *seen_tgids, int *nr_seen_tgids)
+{
+	if (ev =3D=3D TOOL_PMU__EVENT_USER_TIME || ev =3D=3D TOOL_PMU__EVENT_SYST=
EM_TIME) {
+		__u64 *start_time =3D NULL;
+		__u64 *accumulated_time =3D NULL;
+		char buf[PATH_MAX];
+		int fd, err;
+
+		if (pid > -1) {
+			snprintf(buf, sizeof(buf), "%s/%d/stat", procfs__mountpoint(), pid);
+			evsel->pid_stat =3D true;
+		} else {
+			snprintf(buf, sizeof(buf), "%s/stat", procfs__mountpoint());
+		}
+		fd =3D open(buf, O_RDONLY);
+		FD(evsel, idx, thread) =3D fd;
+		if (fd < 0)
+			return -errno;
+
+		start_time =3D xyarray__entry(evsel->process_time.start_times, idx, thre=
ad);
+		accumulated_time =3D xyarray__entry(evsel->process_time.accumulated_time=
s,
+						  idx, thread);
+		*accumulated_time =3D 0;
+
+		if (evsel->core.attr.disabled) {
+			evsel->disabled =3D true;
+			*start_time =3D INVALID_START_TIME;
+		} else {
+			evsel->disabled =3D false;
+			err =3D tool_pmu__read_stat(evsel, idx, thread, start_time);
+			if (err) {
+				close(fd);
+				FD(evsel, idx, thread) =3D -1;
+				return err;
+			}
+		}
+	} else if (tool_pmu__is_memory_event(ev)) {
+		int fd =3D -1;
+
+		if (evsel->cgrp)
+			return -EINVAL;
+
+		evsel->disabled =3D evsel->core.attr.disabled;
+		if (pid > -1) {
+			evsel->pid_stat =3D true;
+			if (idx =3D=3D 0) {
+				int err =3D open_memory_pid_dir(ev, pid, seen_tgids,
+							      nr_seen_tgids, &fd);
+
+				if (err)
+					return err;
+			}
+		}
+		/*
+		 * For per-process, FD holds /proc/<pid> directory fd so
+		 * smaps_rollup/statm are opened on read (avoiding caching a
+		 * pre-exec mm_struct), or -1 for deduplicated sibling threads.
+		 * For system-wide (pid =3D=3D -1), we aggregate in read().
+		 */
+		FD(evsel, idx, thread) =3D fd;
+	}
+	return 0;
+}
+
 int evsel__tool_pmu_open(struct evsel *evsel,
 			 struct perf_thread_map *threads,
 			 int start_cpu_map_idx, int end_cpu_map_idx)
 {
 	enum tool_pmu_event ev =3D evsel__tool_event(evsel);
-	int pid =3D -1, idx =3D 0, thread =3D 0, nthreads, err =3D 0, old_errno;
+	int pid =3D -1, idx =3D 0, thread =3D 0, nthreads, err =3D 0;
+	int *seen_tgids =3D NULL, nr_seen_tgids =3D 0;
+
+	if (evsel->core.attr.sample_period) { /* no sampling */
+		errno =3D EINVAL;
+		return -EINVAL;
+	}
=20
 	if (ev =3D=3D TOOL_PMU__EVENT_NUM_CPUS)
 		return 0;
=20
 	if (ev =3D=3D TOOL_PMU__EVENT_DURATION_TIME) {
-		if (evsel->core.attr.sample_period) /* no sampling */
-			return -EINVAL;
 		evsel->duration_time.accumulated_time =3D 0;
 		if (evsel->core.attr.disabled) {
 			evsel->disabled =3D true;
@@ -286,62 +637,33 @@ int evsel__tool_pmu_open(struct evsel *evsel,
 		pid =3D evsel->cgrp->fd;
=20
 	nthreads =3D perf_thread_map__nr(threads);
+	if (tool_pmu__is_memory_event(ev) && !evsel->cgrp && !evsel->core.system_=
wide &&
+	    nthreads > 1 && start_cpu_map_idx =3D=3D 0 && end_cpu_map_idx > 0) {
+		seen_tgids =3D calloc(nthreads, sizeof(*seen_tgids));
+		if (!seen_tgids) {
+			errno =3D ENOMEM;
+			return -ENOMEM;
+		}
+	}
+
 	for (idx =3D start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
 		for (thread =3D 0; thread < nthreads; thread++) {
 			if (!evsel->cgrp && !evsel->core.system_wide)
 				pid =3D perf_thread_map__pid(threads, thread);
=20
-			if (ev =3D=3D TOOL_PMU__EVENT_USER_TIME || ev =3D=3D TOOL_PMU__EVENT_SY=
STEM_TIME) {
-				__u64 *start_time =3D NULL;
-				__u64 *accumulated_time =3D NULL;
-				int fd;
-
-				if (evsel->core.attr.sample_period) {
-					/* no sampling */
-					err =3D -EINVAL;
-					goto out_close;
-				}
-				if (pid > -1) {
-					char buf[64];
-
-					snprintf(buf, sizeof(buf), "/proc/%d/stat", pid);
-					fd =3D open(buf, O_RDONLY);
-					evsel->pid_stat =3D true;
-				} else {
-					fd =3D open("/proc/stat", O_RDONLY);
-				}
-				FD(evsel, idx, thread) =3D fd;
-				if (fd < 0) {
-					err =3D -errno;
-					goto out_close;
-				}
-				start_time =3D xyarray__entry(evsel->process_time.start_times, idx,
-							    thread);
-				accumulated_time =3D xyarray__entry(
-					evsel->process_time.accumulated_times, idx, thread);
-				*accumulated_time =3D 0;
-
-				if (evsel->core.attr.disabled) {
-					evsel->disabled =3D true;
-					*start_time =3D INVALID_START_TIME;
-				} else {
-					evsel->disabled =3D false;
-					err =3D tool_pmu__read_stat(evsel, idx, thread, start_time);
-					if (err) {
-						close(fd);
-						FD(evsel, idx, thread) =3D -1;
-						goto out_close;
-					}
-				}
-			}
+			err =3D evsel__tool_pmu_open_one(evsel, ev, pid, idx, thread,
+						       seen_tgids, &nr_seen_tgids);
+			if (err)
+				goto out_close;
 		}
 	}
+	free(seen_tgids);
 	return 0;
 out_close:
+	free(seen_tgids);
 	if (err)
 		threads->err_thread =3D thread;
=20
-	old_errno =3D errno;
 	do {
 		while (--thread >=3D 0) {
 			if (FD(evsel, idx, thread) >=3D 0)
@@ -350,7 +672,7 @@ int evsel__tool_pmu_open(struct evsel *evsel,
 		}
 		thread =3D nthreads;
 	} while (--idx >=3D start_cpu_map_idx);
-	errno =3D old_errno;
+	errno =3D -err;
 	return err;
 }
=20
@@ -486,6 +808,32 @@ bool tool_pmu__read_event(enum tool_pmu_event ev,
 		*result =3D system_wide || (user_requested_cpu_list !=3D NULL) ? 1 : 0;
 		return true;
=20
+	case TOOL_PMU__EVENT_MEMORY_SIZE:
+	case TOOL_PMU__EVENT_MEMORY_RSS:
+	case TOOL_PMU__EVENT_MEMORY_PSS:
+	case TOOL_PMU__EVENT_MEMORY_SHARED_CLEAN:
+	case TOOL_PMU__EVENT_MEMORY_SHARED_DIRTY:
+	case TOOL_PMU__EVENT_MEMORY_PRIVATE_CLEAN:
+	case TOOL_PMU__EVENT_MEMORY_PRIVATE_DIRTY:
+	case TOOL_PMU__EVENT_MEMORY_USS:
+	case TOOL_PMU__EVENT_MEMORY_SWAP:
+	case TOOL_PMU__EVENT_MEMORY_SWAP_PSS:
+	case TOOL_PMU__EVENT_MEMORY_PSS_DIRTY:
+	case TOOL_PMU__EVENT_MEMORY_PSS_ANON:
+	case TOOL_PMU__EVENT_MEMORY_PSS_FILE:
+	case TOOL_PMU__EVENT_MEMORY_PSS_SHMEM:
+	case TOOL_PMU__EVENT_MEMORY_REFERENCED:
+	case TOOL_PMU__EVENT_MEMORY_ANONYMOUS:
+	case TOOL_PMU__EVENT_MEMORY_KSM:
+	case TOOL_PMU__EVENT_MEMORY_LAZYFREE:
+	case TOOL_PMU__EVENT_MEMORY_ANON_HUGE_PAGES:
+	case TOOL_PMU__EVENT_MEMORY_SHMEM_PMD_MAPPED:
+	case TOOL_PMU__EVENT_MEMORY_FILE_PMD_MAPPED:
+	case TOOL_PMU__EVENT_MEMORY_SHARED_HUGETLB:
+	case TOOL_PMU__EVENT_MEMORY_PRIVATE_HUGETLB:
+	case TOOL_PMU__EVENT_MEMORY_LOCKED:
+	case TOOL_PMU__EVENT_MEMORY_DATA:
+	case TOOL_PMU__EVENT_MEMORY_TEXT:
 	case TOOL_PMU__EVENT_NONE:
 	case TOOL_PMU__EVENT_DURATION_TIME:
 	case TOOL_PMU__EVENT_USER_TIME:
@@ -517,6 +865,55 @@ static void perf_counts__update(struct perf_counts_val=
ues *count,
 		count->lost =3D 0;
 	}
 }
+
+static int tool_pmu__aggregate_memory_event(enum tool_pmu_event ev, u64 *v=
al)
+{
+	struct io_dir iod;
+	struct io_dirent64 *ent;
+	char buf[PATH_MAX];
+	int fd, proc_fd;
+	u64 pid_val;
+
+	*val =3D 0;
+	proc_fd =3D open(procfs__mountpoint(), O_DIRECTORY | O_RDONLY);
+	if (proc_fd < 0)
+		return -errno;
+
+	io_dir__init(&iod, proc_fd);
+
+	while ((ent =3D io_dir__readdir(&iod)) !=3D NULL) {
+		if (!isdigit((unsigned char)ent->d_name[0]))
+			continue;
+
+		if (!io_dir__is_dir(&iod, ent))
+			continue;
+
+		if (ev =3D=3D TOOL_PMU__EVENT_MEMORY_SIZE ||
+		    ev =3D=3D TOOL_PMU__EVENT_MEMORY_DATA ||
+		    ev =3D=3D TOOL_PMU__EVENT_MEMORY_TEXT)
+			snprintf(buf, sizeof(buf), "%s/statm", ent->d_name);
+		else
+			snprintf(buf, sizeof(buf), "%s/smaps_rollup", ent->d_name);
+
+		fd =3D openat(proc_fd, buf, O_RDONLY);
+		if (fd < 0)
+			continue;
+
+		if (ev =3D=3D TOOL_PMU__EVENT_MEMORY_SIZE ||
+		    ev =3D=3D TOOL_PMU__EVENT_MEMORY_DATA ||
+		    ev =3D=3D TOOL_PMU__EVENT_MEMORY_TEXT) {
+			if (!read_statm(fd, ev, &pid_val))
+				*val +=3D pid_val;
+		} else {
+			if (!read_smaps_rollup(fd, ev, &pid_val))
+				*val +=3D pid_val;
+		}
+		close(fd);
+	}
+	close(proc_fd);
+	return 0;
+}
+
 int evsel__tool_pmu_enable_cpu(struct evsel *evsel, int cpu_map_idx)
 {
 	enum tool_pmu_event ev =3D evsel__tool_event(evsel);
@@ -690,6 +1087,65 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu=
_map_idx, int thread)
 		adjust =3D true;
 		break;
 	}
+	case TOOL_PMU__EVENT_MEMORY_SIZE:
+	case TOOL_PMU__EVENT_MEMORY_RSS:
+	case TOOL_PMU__EVENT_MEMORY_PSS:
+	case TOOL_PMU__EVENT_MEMORY_SHARED_CLEAN:
+	case TOOL_PMU__EVENT_MEMORY_SHARED_DIRTY:
+	case TOOL_PMU__EVENT_MEMORY_PRIVATE_CLEAN:
+	case TOOL_PMU__EVENT_MEMORY_PRIVATE_DIRTY:
+	case TOOL_PMU__EVENT_MEMORY_USS:
+	case TOOL_PMU__EVENT_MEMORY_SWAP:
+	case TOOL_PMU__EVENT_MEMORY_SWAP_PSS:
+	case TOOL_PMU__EVENT_MEMORY_PSS_DIRTY:
+	case TOOL_PMU__EVENT_MEMORY_PSS_ANON:
+	case TOOL_PMU__EVENT_MEMORY_PSS_FILE:
+	case TOOL_PMU__EVENT_MEMORY_PSS_SHMEM:
+	case TOOL_PMU__EVENT_MEMORY_REFERENCED:
+	case TOOL_PMU__EVENT_MEMORY_ANONYMOUS:
+	case TOOL_PMU__EVENT_MEMORY_KSM:
+	case TOOL_PMU__EVENT_MEMORY_LAZYFREE:
+	case TOOL_PMU__EVENT_MEMORY_ANON_HUGE_PAGES:
+	case TOOL_PMU__EVENT_MEMORY_SHMEM_PMD_MAPPED:
+	case TOOL_PMU__EVENT_MEMORY_FILE_PMD_MAPPED:
+	case TOOL_PMU__EVENT_MEMORY_SHARED_HUGETLB:
+	case TOOL_PMU__EVENT_MEMORY_PRIVATE_HUGETLB:
+	case TOOL_PMU__EVENT_MEMORY_LOCKED:
+	case TOOL_PMU__EVENT_MEMORY_DATA:
+	case TOOL_PMU__EVENT_MEMORY_TEXT: {
+		u64 val =3D 0;
+
+		if (evsel->pid_stat) {
+			if (cpu_map_idx =3D=3D 0) {
+				int dir_fd =3D FD(evsel, 0, thread);
+
+				if (dir_fd >=3D 0) {
+					bool is_statm =3D ev =3D=3D TOOL_PMU__EVENT_MEMORY_SIZE ||
+							ev =3D=3D TOOL_PMU__EVENT_MEMORY_DATA ||
+							ev =3D=3D TOOL_PMU__EVENT_MEMORY_TEXT;
+					int fd =3D openat(dir_fd,
+							is_statm ? "statm" : "smaps_rollup",
+							O_RDONLY);
+					int ret;
+
+					if (fd < 0)
+						return -errno;
+					ret =3D is_statm ? read_statm(fd, ev, &val)
+						       : read_smaps_rollup(fd, ev, &val);
+					close(fd);
+					if (ret)
+						return ret;
+				}
+			}
+		} else if (cpu_map_idx =3D=3D 0 && thread =3D=3D 0) {
+			int ret =3D tool_pmu__aggregate_memory_event(ev, &val);
+
+			if (ret)
+				return ret;
+		}
+		perf_counts__update(count, old_count, /*raw=3D*/false, val);
+		return 0;
+	}
 	case TOOL_PMU__EVENT_NONE:
 	case TOOL_PMU__EVENT_MAX:
 	default:
diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
index f66d24cf3502..99a2ea1548f8 100644
--- a/tools/perf/util/tool_pmu.h
+++ b/tools/perf/util/tool_pmu.h
@@ -24,6 +24,32 @@ enum tool_pmu_event {
 	TOOL_PMU__EVENT_SYSTEM_TSC_FREQ,
 	TOOL_PMU__EVENT_CORE_WIDE,
 	TOOL_PMU__EVENT_TARGET_CPU,
+	TOOL_PMU__EVENT_MEMORY_ANON_HUGE_PAGES,
+	TOOL_PMU__EVENT_MEMORY_ANONYMOUS,
+	TOOL_PMU__EVENT_MEMORY_DATA,
+	TOOL_PMU__EVENT_MEMORY_FILE_PMD_MAPPED,
+	TOOL_PMU__EVENT_MEMORY_KSM,
+	TOOL_PMU__EVENT_MEMORY_LAZYFREE,
+	TOOL_PMU__EVENT_MEMORY_LOCKED,
+	TOOL_PMU__EVENT_MEMORY_PRIVATE_CLEAN,
+	TOOL_PMU__EVENT_MEMORY_PRIVATE_DIRTY,
+	TOOL_PMU__EVENT_MEMORY_PRIVATE_HUGETLB,
+	TOOL_PMU__EVENT_MEMORY_PSS,
+	TOOL_PMU__EVENT_MEMORY_PSS_ANON,
+	TOOL_PMU__EVENT_MEMORY_PSS_DIRTY,
+	TOOL_PMU__EVENT_MEMORY_PSS_FILE,
+	TOOL_PMU__EVENT_MEMORY_PSS_SHMEM,
+	TOOL_PMU__EVENT_MEMORY_REFERENCED,
+	TOOL_PMU__EVENT_MEMORY_RSS,
+	TOOL_PMU__EVENT_MEMORY_SHARED_CLEAN,
+	TOOL_PMU__EVENT_MEMORY_SHARED_DIRTY,
+	TOOL_PMU__EVENT_MEMORY_SHARED_HUGETLB,
+	TOOL_PMU__EVENT_MEMORY_SHMEM_PMD_MAPPED,
+	TOOL_PMU__EVENT_MEMORY_SIZE,
+	TOOL_PMU__EVENT_MEMORY_SWAP,
+	TOOL_PMU__EVENT_MEMORY_SWAP_PSS,
+	TOOL_PMU__EVENT_MEMORY_TEXT,
+	TOOL_PMU__EVENT_MEMORY_USS,
=20
 	TOOL_PMU__EVENT_MAX,
 };
--=20
2.56.1.703.gf848ed807c-goog

