Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABD5E555
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Jan 2026 01:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767489467; cv=none; b=uSYuKTculTh+wSQ2+L31KQuAOAewqpuzW5eC5xvIqGS6O2ipF4t9bebMZasCeenV9SeEpTi72BiD7bIOq/yv1cQ4P+B+ZV48UrZ9addqSehprX7lPG3lMAPPz2MnSMLryEHupWiRfkSlbMgcHIWB6n4ZP1LmfCFrDIO0RaAwSOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767489467; c=relaxed/simple;
	bh=BbPLbkayDZsk919gfE5VG14uNOJXcU4guEPzpCpFzA8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nq+OgheilMzwh1BN2HhLZyzGPUl4FCkwwvYojLvsb60RIFsLMZYG7hHojRPf2R1cwY0Tql6AqF9vd/5fjcv3TJE34NWsS1OK6e8SEQ+FZNfrbVd9OTLeP7UUq8Lfh2lZleL14tuqj1EfUxxOUW1TZVaF6AAvkjJZeit0WRj3ALY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V4QE9iSR; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V4QE9iSR"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34eb6589ed2so11889619a91.2
        for <linux-perf-users@vger.kernel.org>; Sat, 03 Jan 2026 17:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767489463; x=1768094263; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bCmM71I6TWgxDH4yC2jk88q4K8fjb4ThSa2NSpUHCM=;
        b=V4QE9iSRC5+SF4fhIasc+8iuEefS/YVd3rN1nCADqu/MyNE2C+N12SJGQ8ZvYKRzGD
         8/SoSCoHY0Jm+70I2EnWr22VEVDaRLHsZXhYOy9OQxq3CowtP8C0jRMbvq5KNVwz0fhT
         r9j4xclkhIS2QuHUnkI2oqvHRHmUHa4A4c7jXB7GimYrUBrz9Xn3Lpwbbn2gxIuL6OZM
         UarYz5K3A0lmAShienSGmGbsi4LUKnf40/pvOLVH5oiJRX7EF7E0GN9xmRZtTWfxVAdG
         34NkTNxMlBEZTb+shZVYDa+8aLCXOF+XmR0aWScKnzDDqsNCs2ddQhhtBqdRM1pnPxbA
         uAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767489463; x=1768094263;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4bCmM71I6TWgxDH4yC2jk88q4K8fjb4ThSa2NSpUHCM=;
        b=qjOotpggskuz13oLZejbeBlsjF0KlSSu8VGgEHHU9hltovK1AJjjPVI6lrw41qMYSC
         /SfE2sykhv8Ek4CWUbq37sS/irzUujRsGMqzffxQ5Lko2m8ROYHwsphDpJDvboJ9j2kA
         /oDGSkBvaE11PkWCbMsTyVHyTkte/110sgUWnoOOhYgqBk77EY00j8yyRc/Lxyfk7eIJ
         vowPxpgbmeL0r7NQDaf9TrTKsNAHYl5OaReCharA8ggZ4Mjqk3WU2CqaFtoHoE7T2efa
         P1yPKRhrKt0aBRXz4F78xvY1Tu+JZqIV7H5Vk51kI/Bnm/l4Lwx4JBg2hUqrCBbN5qeO
         lWWA==
X-Forwarded-Encrypted: i=1; AJvYcCUt+VLtauPom3y+HVpWTVIV9aGBX/Qsv7ZaYsnX2QNfEgEu0u+YdOIHguYvYt8RpDJAoXI9Dh5OWBsBcKCnkfNp@vger.kernel.org
X-Gm-Message-State: AOJu0YwPT5PBHckEzEtb+3hwFE84waSWDziLetDKK7umfsHp6MeXbZz/
	uBcQ/2HazgWvZCP4UWfnXgwtzN7AFXJrxiqkH701YSZYC2UyVSXAlwrPRUMsEUpamB8xvaqmXdg
	gmKZyQFeHSw==
X-Google-Smtp-Source: AGHT+IFNv4sXJ6qkCOKrtjjdhGE4YemaImm6sHSvaFvxoR8k+WI6pTnPf4ZgR9i56QTSQCOg78DKAfWkbRVB
X-Received: from dlbps14.prod.google.com ([2002:a05:7023:88e:b0:11e:64d:cd3b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:924:b0:11b:923d:7753
 with SMTP id a92af1059eb24-121721aab49mr51821527c88.3.1767489463290; Sat, 03
 Jan 2026 17:17:43 -0800 (PST)
Date: Sat,  3 Jan 2026 17:17:37 -0800
In-Reply-To: <20260104011738.475680-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260104011738.475680-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260104011738.475680-2-irogers@google.com>
Subject: [PATCH v1 1/2] perf tool_pmu: Add memory events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add tool PMU events to report memory usage information exposed by
/proc/pid/smaps_rollup and /proc/pid/statm.

The following events are added:
- memory_anon_huge_pages
- memory_anonymous
- memory_data
- memory_file_pmd_mapped
- memory_ksm
- memory_lazyfree
- memory_locked
- memory_private_clean
- memory_private_dirty
- memory_private_hugetlb
- memory_pss
- memory_pss_anon
- memory_pss_dirty
- memory_pss_file
- memory_pss_shmem
- memory_referenced
- memory_resident
- memory_rss
- memory_shared
- memory_shared_clean
- memory_shared_dirty
- memory_shared_hugetlb
- memory_shmem_pmd_mapped
- memory_size
- memory_swap
- memory_swap_pss
- memory_text
- memory_uss

The events are aggregated across processes in system-wide mode, or
reported per-process when monitoring specific tasks.  The tool_pmu
implementation is updated to read from /proc files and tool.json is
updated with the new events and detailed descriptions. The data can
only be gathered for a running process except for memory_rss and
memory_resident that use rusage data from wait4 to give a final value.

Examples of gathering system-wide statm and smaps_rollup based events:
```
$ perf stat -e memory_size,memory_resident,memory_shared,memory_text,memory=
_data -I 1000
     1.001046524 94,942,406,868,992      memory_size
     1.001046524     24,885,137,408      memory_resident
     1.001046524     15,494,561,792      memory_shared
     1.001046524     15,249,453,056      memory_text
     1.001046524     74,510,024,704      memory_data
...
$ perf stat -e memory_anon_huge_pages,memory_anonymous,memory_file_pmd_mapp=
ed,memory_ksm,memory_lazyfree,memory_locked,memory_private_clean,memory_pri=
vate_dirty,memory_private_hugetlb,memory_pss,memory_pss_anon,memory_pss_dir=
ty,memory_pss_file,memory_pss_shmem,memory_referenced,memory_rss,memory_sha=
red,memory_shared_clean,memory_shared_dirty,memory_shared_hugetlb,memory_sh=
mem_pmd_mapped,memory_swap,memory_swap_pss,memory_uss -I 1000
     1.001107268        981,467,136      memory_anon_huge_pages
     1.001107268      9,459,105,792      memory_anonymous
     1.001107268                  0      memory_file_pmd_mapped
     1.001107268                  0      memory_ksm
     1.001107268          1,269,760      memory_lazyfree
     1.001107268            634,880      memory_locked
     1.001107268        958,963,712      memory_private_clean
     1.001107268      8,400,080,896      memory_private_dirty
     1.001107268                  0      memory_private_hugetlb
     1.001107268     10,711,451,648      memory_pss
     1.001107268      8,387,961,856      memory_pss_anon
     1.001107268      8,642,944,000      memory_pss_dirty
     1.001107268      2,078,282,752      memory_pss_file
     1.001107268        245,125,120      memory_pss_shmem
     1.001107268     24,356,818,944      memory_referenced
     1.001107268     25,256,157,184      memory_rss
     1.001107268     15,757,029,376      memory_shared
     1.001107268     14,230,978,560      memory_shared_clean
     1.001107268      1,670,934,528      memory_shared_dirty
     1.001107268                  0      memory_shared_hugetlb
     1.001107268                  0      memory_shmem_pmd_mapped
     1.001107268                  0      memory_swap
     1.001107268                  0      memory_swap_pss
     1.001107268      9,328,041,984      memory_uss
...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c                     |  10 +-
 .../pmu-events/arch/common/common/tool.json   | 168 ++++++++
 tools/perf/pmu-events/empty-pmu-events.c      | 280 +++++++------
 tools/perf/util/tool_pmu.c                    | 375 +++++++++++++++++-
 tools/perf/util/tool_pmu.h                    |  28 ++
 5 files changed, 742 insertions(+), 119 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ab40d85fb125..8c6290174afb 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -107,6 +107,7 @@
 struct rusage_stats {
 	struct stats ru_utime_usec_stat;
 	struct stats ru_stime_usec_stat;
+	struct stats ru_maxrss_stat;
 };
=20
 static void print_counters(struct timespec *ts, int argc, const char **arg=
v);
@@ -288,7 +289,9 @@ static int read_single_counter(struct evsel *counter, i=
nt cpu_map_idx, int threa
 	 */
 	if (err && cpu_map_idx =3D=3D 0 &&
 	    (evsel__tool_event(counter) =3D=3D TOOL_PMU__EVENT_USER_TIME ||
-	     evsel__tool_event(counter) =3D=3D TOOL_PMU__EVENT_SYSTEM_TIME)) {
+	     evsel__tool_event(counter) =3D=3D TOOL_PMU__EVENT_SYSTEM_TIME ||
+	     evsel__tool_event(counter) =3D=3D TOOL_PMU__EVENT_MEMORY_RESIDENT ||
+	     evsel__tool_event(counter) =3D=3D TOOL_PMU__EVENT_MEMORY_RSS)) {
 		struct perf_counts_values *count =3D
 			perf_counts(counter->counts, cpu_map_idx, thread);
 		struct perf_counts_values *old_count =3D NULL;
@@ -299,8 +302,10 @@ static int read_single_counter(struct evsel *counter, =
int cpu_map_idx, int threa
=20
 		if (evsel__tool_event(counter) =3D=3D TOOL_PMU__EVENT_USER_TIME)
 			val =3D ru_stats.ru_utime_usec_stat.mean;
-		else
+		else if (evsel__tool_event(counter) =3D=3D TOOL_PMU__EVENT_SYSTEM_TIME)
 			val =3D ru_stats.ru_stime_usec_stat.mean;
+		else
+			val =3D ru_stats.ru_maxrss_stat.mean;
=20
 		count->val =3D val;
 		if (old_count) {
@@ -778,6 +783,7 @@ static void update_rusage_stats(const struct rusage *ru=
sage)
 		(rusage->ru_utime.tv_usec * us_to_ns + rusage->ru_utime.tv_sec * s_to_ns=
));
 	update_stats(&ru_stats.ru_stime_usec_stat,
 		(rusage->ru_stime.tv_usec * us_to_ns + rusage->ru_stime.tv_sec * s_to_ns=
));
+	update_stats(&ru_stats.ru_maxrss_stat, rusage->ru_maxrss * 1024);
 }
=20
 static int __run_perf_stat(int argc, const char **argv, int run_idx)
diff --git a/tools/perf/pmu-events/arch/common/common/tool.json b/tools/per=
f/pmu-events/arch/common/common/tool.json
index 14d0d60a1976..4b3fce655f8a 100644
--- a/tools/perf/pmu-events/arch/common/common/tool.json
+++ b/tools/perf/pmu-events/arch/common/common/tool.json
@@ -82,5 +82,173 @@
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
+    "EventName": "memory_resident",
+    "BriefDescription": "Resident Set Size (RSS) in bytes (from /proc/pid/=
statm). The sum of anonymous, file and shared memory.",
+    "ConfigCode": "31"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_rss",
+    "BriefDescription": "Resident Set Size (RSS) in bytes (from /proc/pid/=
smaps_rollup). The sum of anonymous, file and shared memory.",
+    "ConfigCode": "32"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_shared",
+    "BriefDescription": "Shared memory (shared with other processes via fi=
les/shmem) in bytes",
+    "ConfigCode": "33"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_shared_clean",
+    "BriefDescription": "Shared clean memory (shared with other processes,=
 not modified) in bytes",
+    "ConfigCode": "34"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_shared_dirty",
+    "BriefDescription": "Shared dirty memory (shared with other processes,=
 modified) in bytes",
+    "ConfigCode": "35"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_shared_hugetlb",
+    "BriefDescription": "Shared memory backed by huge pages in bytes",
+    "ConfigCode": "36"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_shmem_pmd_mapped",
+    "BriefDescription": "Shared memory mapped with Page Middle Directory (=
PMD) in bytes",
+    "ConfigCode": "37"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_size",
+    "BriefDescription": "Virtual memory size in bytes",
+    "ConfigCode": "38"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_swap",
+    "BriefDescription": "Memory swapped out to disk in bytes",
+    "ConfigCode": "39"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_swap_pss",
+    "BriefDescription": "Proportional Share Size (PSS) for swap memory in =
bytes",
+    "ConfigCode": "40"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_text",
+    "BriefDescription": "Memory dedicated to code (text segment) in bytes"=
,
+    "ConfigCode": "41"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "memory_uss",
+    "BriefDescription": "Unique Set Size (USS) in bytes",
+    "ConfigCode": "42"
   }
 ]
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-even=
ts/empty-pmu-events.c
index 76c395cf513c..4b7c534f1801 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -1281,62 +1281,90 @@ static const char *const big_c_string =3D
 /* offset=3D126106 */ "system_tsc_freq\000tool\000The amount a Time Stamp =
Counter (TSC) increases per second\000config=3D0xc\000\00000\000\000\000\00=
0\000"
 /* offset=3D126205 */ "core_wide\000tool\0001 if not SMT, if SMT are event=
s being gathered on all SMT threads 1 otherwise 0\000config=3D0xd\000\00000=
\000\000\000\000\000"
 /* offset=3D126319 */ "target_cpu\000tool\0001 if CPUs being analyzed, 0 i=
f threads/processes\000config=3D0xe\000\00000\000\000\000\000\000"
-/* offset=3D126403 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\00=
0event=3D0x8a\000\00000\000\000\000\000\000"
-/* offset=3D126465 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\00=
0event=3D0x8b\000\00000\000\000\000\000\000"
-/* offset=3D126527 */ "l3_cache_rd\000cache\000L3 cache access, read\000ev=
ent=3D0x40\000\00000\000\000\000\000Attributable Level 3 cache access, read=
\000"
-/* offset=3D126625 */ "segment_reg_loads.any\000other\000Number of segment=
 register loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000=
\000\000\000"
-/* offset=3D126727 */ "dispatch_blocked.any\000other\000Memory cluster sig=
nals to block micro-op dispatch for any reason\000event=3D9,period=3D200000=
,umask=3D0x20\000\00000\000\000\000\000\000"
-/* offset=3D126860 */ "eist_trans\000other\000Number of Enhanced Intel Spe=
edStep(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000=
\00000\000\000\000\000\000"
-/* offset=3D126978 */ "hisi_sccl,ddrc\000"
-/* offset=3D126993 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write =
commands\000event=3D2\000\00000\000\000\000\000\000"
-/* offset=3D127063 */ "uncore_cbox\000"
-/* offset=3D127075 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000A =
cross-core snoop resulted from L3 Eviction which misses in some processor c=
ore\000event=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000"
-/* offset=3D127229 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=
=3D0xe0\000\00000\000\000\000\000\000"
-/* offset=3D127283 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000eve=
nt=3D0xc0\000\00000\000\000\000\000\000"
-/* offset=3D127341 */ "hisi_sccl,l3c\000"
-/* offset=3D127355 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total rea=
d hits\000event=3D7\000\00000\000\000\000\000\000"
-/* offset=3D127423 */ "uncore_imc_free_running\000"
-/* offset=3D127447 */ "uncore_imc_free_running.cache_miss\000uncore\000Tot=
al cache misses\000event=3D0x12\000\00000\000\000\000\000\000"
-/* offset=3D127527 */ "uncore_imc\000"
-/* offset=3D127538 */ "uncore_imc.cache_hits\000uncore\000Total cache hits=
\000event=3D0x34\000\00000\000\000\000\000\000"
-/* offset=3D127603 */ "uncore_sys_ddr_pmu\000"
-/* offset=3D127622 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cyc=
les event\000event=3D0x2b\000v8\00000\000\000\000\000\000"
-/* offset=3D127698 */ "uncore_sys_ccn_pmu\000"
-/* offset=3D127717 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycle=
s event\000config=3D0x2c\0000x01\00000\000\000\000\000\000"
-/* offset=3D127794 */ "uncore_sys_cmn_pmu\000"
-/* offset=3D127813 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts tota=
l cache misses in first lookup result (high priority)\000eventid=3D1,type=
=3D5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
-/* offset=3D127956 */ "CPUs_utilized\000Default\000(software@cpu\\-clock\\=
,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=
=3Dtask\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\00=
0\0001CPUs\000\000\000\000011"
-/* offset=3D128142 */ "cs_per_second\000Default\000software@context\\-swit=
ches\\,name\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000\=
000011"
-/* offset=3D128375 */ "migrations_per_second\000Default\000software@cpu\\-=
migrations\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Process migrations to a new CPU per CPU second\000\0001m=
igrations/sec\000\000\000\000011"
-/* offset=3D128635 */ "page_faults_per_second\000Default\000software@page\=
\-faults\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\0=
00011"
-/* offset=3D128866 */ "insn_per_cycle\000Default\000instructions / cpu\\-c=
ycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\=
000\000\000\000001"
-/* offset=3D128979 */ "stalled_cycles_per_instruction\000Default\000max(st=
alled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\0=
00Max front or backend stalls per instruction\000\000\000\000\000\000001"
-/* offset=3D129143 */ "frontend_cycles_idle\000Default\000stalled\\-cycles=
\\-frontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls=
 per cycle\000\000\000\000\000\000001"
-/* offset=3D129273 */ "backend_cycles_idle\000Default\000stalled\\-cycles\=
\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per=
 cycle\000\000\000\000\000\000001"
-/* offset=3D129399 */ "cycles_frequency\000Default\000cpu\\-cycles / (soft=
ware@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\=
\-clock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\=
000\000\000\000011"
-/* offset=3D129575 */ "branch_frequency\000Default\000branches / (software=
@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-cl=
ock\\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M/s=
ec\000\000\000\000011"
-/* offset=3D129755 */ "branch_miss_rate\000Default\000branch\\-misses / br=
anches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\0=
00\000001"
-/* offset=3D129859 */ "l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-m=
isses / L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\0=
00100%\000\000\000\000001"
-/* offset=3D129975 */ "llc_miss_rate\000Default2\000LLC\\-load\\-misses / =
LLC\\-loads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\00=
0\000001"
-/* offset=3D130076 */ "l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-m=
isses / L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\00=
0100%\000\000\000\000001"
-/* offset=3D130191 */ "dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses =
/ dTLB\\-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\0=
00\000\000001"
-/* offset=3D130297 */ "itlb_miss_rate\000Default3\000iTLB\\-load\\-misses =
/ iTLB\\-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\0=
00\000\000001"
-/* offset=3D130403 */ "l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-=
prefetch\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.0=
5\000L1 prefetch miss rate\000\000100%\000\000\000\000001"
-/* offset=3D130551 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\0000=
00"
-/* offset=3D130574 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalte=
d.thread\000\000\000\000\000\000\000\000000"
-/* offset=3D130638 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.co=
re / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_a=
ctive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000"
-/* offset=3D130805 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_=
retired.any\000\000\000\000\000\000\000\000000"
-/* offset=3D130870 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / in=
st_retired.any\000\000\000\000\000\000\000\000000"
-/* offset=3D130938 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + ic=
ache_miss_cycles\000\000\000\000\000\000\000\000000"
-/* offset=3D131010 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_h=
it + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000"
-/* offset=3D131105 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_d=
ata_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_=
miss\000\000\000\000\000\000\000\000000"
-/* offset=3D131240 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2=
_All_Miss\000\000\000\000\000\000\000\000000"
-/* offset=3D131305 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, D=
Cache_L2_All)\000\000\000\000\000\000\000\000000"
-/* offset=3D131374 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss,=
 DCache_L2_All)\000\000\000\000\000\000\000\000000"
-/* offset=3D131445 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\0000=
00"
-/* offset=3D131468 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\0000=
00"
-/* offset=3D131491 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\000000=
"
-/* offset=3D131512 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9=
 / duration_time\000\000\000\000\000\000\000\000000"
+/* offset=3D126403 */ "memory_anon_huge_pages\000tool\000Memory backed by =
anonymous huge pages in bytes\000config=3D0xf\000\00000\000\000\000\000\000=
"
+/* offset=3D126497 */ "memory_anonymous\000tool\000Memory not mapped to a =
file (anonymous) in bytes\000config=3D0x10\000\00000\000\000\000\000\000"
+/* offset=3D126588 */ "memory_data\000tool\000Memory dedicated to data and=
 stack in bytes\000config=3D0x11\000\00000\000\000\000\000\000"
+/* offset=3D126669 */ "memory_file_pmd_mapped\000tool\000Memory backed by =
file and mapped with Page Middle Directory (PMD) in bytes\000config=3D0x12\=
000\00000\000\000\000\000\000"
+/* offset=3D126792 */ "memory_ksm\000tool\000Memory shared via Kernel Same=
page Merging (KSM) in bytes\000config=3D0x13\000\00000\000\000\000\000\000"
+/* offset=3D126885 */ "memory_lazyfree\000tool\000Memory marked as LazyFre=
e in bytes\000config=3D0x14\000\00000\000\000\000\000\000"
+/* offset=3D126961 */ "memory_locked\000tool\000Memory locked in RAM in by=
tes\000config=3D0x15\000\00000\000\000\000\000\000"
+/* offset=3D127030 */ "memory_private_clean\000tool\000Private clean memor=
y (not shared, not modified) in bytes\000config=3D0x16\000\00000\000\000\00=
0\000\000"
+/* offset=3D127133 */ "memory_private_dirty\000tool\000Private dirty memor=
y (not shared, modified) in bytes\000config=3D0x17\000\00000\000\000\000\00=
0\000"
+/* offset=3D127232 */ "memory_private_hugetlb\000tool\000Private memory ba=
cked by huge pages in bytes\000config=3D0x18\000\00000\000\000\000\000\000"
+/* offset=3D127325 */ "memory_pss\000tool\000Proportional Share Size (PSS)=
 in bytes\000config=3D0x19\000\00000\000\000\000\000\000"
+/* offset=3D127400 */ "memory_pss_anon\000tool\000Proportional Share Size =
(PSS) for anonymous memory in bytes\000config=3D0x1a\000\00000\000\000\000\=
000\000"
+/* offset=3D127501 */ "memory_pss_dirty\000tool\000Proportional Share Size=
 (PSS) for dirty memory in bytes\000config=3D0x1b\000\00000\000\000\000\000=
\000"
+/* offset=3D127599 */ "memory_pss_file\000tool\000Proportional Share Size =
(PSS) for file-backed memory in bytes\000config=3D0x1c\000\00000\000\000\00=
0\000\000"
+/* offset=3D127702 */ "memory_pss_shmem\000tool\000Proportional Share Size=
 (PSS) for shared memory in bytes\000config=3D0x1d\000\00000\000\000\000\00=
0\000"
+/* offset=3D127801 */ "memory_referenced\000tool\000Memory marked as refer=
enced/accessed in bytes\000config=3D0x1e\000\00000\000\000\000\000\000"
+/* offset=3D127890 */ "memory_resident\000tool\000Resident Set Size (RSS) =
in bytes (from /proc/pid/statm). The sum of anonymous, file and shared memo=
ry\000config=3D0x1f\000\00000\000\000\000\000\000"
+/* offset=3D128033 */ "memory_rss\000tool\000Resident Set Size (RSS) in by=
tes (from /proc/pid/smaps_rollup). The sum of anonymous, file and shared me=
mory\000config=3D0x20\000\00000\000\000\000\000\000"
+/* offset=3D128178 */ "memory_shared\000tool\000Shared memory (shared with=
 other processes via files/shmem) in bytes\000config=3D0x21\000\00000\000\0=
00\000\000\000"
+/* offset=3D128286 */ "memory_shared_clean\000tool\000Shared clean memory =
(shared with other processes, not modified) in bytes\000config=3D0x22\000\0=
0000\000\000\000\000\000"
+/* offset=3D128404 */ "memory_shared_dirty\000tool\000Shared dirty memory =
(shared with other processes, modified) in bytes\000config=3D0x23\000\00000=
\000\000\000\000\000"
+/* offset=3D128518 */ "memory_shared_hugetlb\000tool\000Shared memory back=
ed by huge pages in bytes\000config=3D0x24\000\00000\000\000\000\000\000"
+/* offset=3D128609 */ "memory_shmem_pmd_mapped\000tool\000Shared memory ma=
pped with Page Middle Directory (PMD) in bytes\000config=3D0x25\000\00000\0=
00\000\000\000\000"
+/* offset=3D128721 */ "memory_size\000tool\000Virtual memory size in bytes=
\000config=3D0x26\000\00000\000\000\000\000\000"
+/* offset=3D128787 */ "memory_swap\000tool\000Memory swapped out to disk i=
n bytes\000config=3D0x27\000\00000\000\000\000\000\000"
+/* offset=3D128860 */ "memory_swap_pss\000tool\000Proportional Share Size =
(PSS) for swap memory in bytes\000config=3D0x28\000\00000\000\000\000\000\0=
00"
+/* offset=3D128956 */ "memory_text\000tool\000Memory dedicated to code (te=
xt segment) in bytes\000config=3D0x29\000\00000\000\000\000\000\000"
+/* offset=3D129042 */ "memory_uss\000tool\000Unique Set Size (USS) in byte=
s\000config=3D0x2a\000\00000\000\000\000\000\000"
+/* offset=3D129109 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\00=
0event=3D0x8a\000\00000\000\000\000\000\000"
+/* offset=3D129171 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\00=
0event=3D0x8b\000\00000\000\000\000\000\000"
+/* offset=3D129233 */ "l3_cache_rd\000cache\000L3 cache access, read\000ev=
ent=3D0x40\000\00000\000\000\000\000Attributable Level 3 cache access, read=
\000"
+/* offset=3D129331 */ "segment_reg_loads.any\000other\000Number of segment=
 register loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000=
\000\000\000"
+/* offset=3D129433 */ "dispatch_blocked.any\000other\000Memory cluster sig=
nals to block micro-op dispatch for any reason\000event=3D9,period=3D200000=
,umask=3D0x20\000\00000\000\000\000\000\000"
+/* offset=3D129566 */ "eist_trans\000other\000Number of Enhanced Intel Spe=
edStep(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000=
\00000\000\000\000\000\000"
+/* offset=3D129684 */ "hisi_sccl,ddrc\000"
+/* offset=3D129699 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write =
commands\000event=3D2\000\00000\000\000\000\000\000"
+/* offset=3D129769 */ "uncore_cbox\000"
+/* offset=3D129781 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000A =
cross-core snoop resulted from L3 Eviction which misses in some processor c=
ore\000event=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000"
+/* offset=3D129935 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=
=3D0xe0\000\00000\000\000\000\000\000"
+/* offset=3D129989 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000eve=
nt=3D0xc0\000\00000\000\000\000\000\000"
+/* offset=3D130047 */ "hisi_sccl,l3c\000"
+/* offset=3D130061 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total rea=
d hits\000event=3D7\000\00000\000\000\000\000\000"
+/* offset=3D130129 */ "uncore_imc_free_running\000"
+/* offset=3D130153 */ "uncore_imc_free_running.cache_miss\000uncore\000Tot=
al cache misses\000event=3D0x12\000\00000\000\000\000\000\000"
+/* offset=3D130233 */ "uncore_imc\000"
+/* offset=3D130244 */ "uncore_imc.cache_hits\000uncore\000Total cache hits=
\000event=3D0x34\000\00000\000\000\000\000\000"
+/* offset=3D130309 */ "uncore_sys_ddr_pmu\000"
+/* offset=3D130328 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cyc=
les event\000event=3D0x2b\000v8\00000\000\000\000\000\000"
+/* offset=3D130404 */ "uncore_sys_ccn_pmu\000"
+/* offset=3D130423 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycle=
s event\000config=3D0x2c\0000x01\00000\000\000\000\000\000"
+/* offset=3D130500 */ "uncore_sys_cmn_pmu\000"
+/* offset=3D130519 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts tota=
l cache misses in first lookup result (high priority)\000eventid=3D1,type=
=3D5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
+/* offset=3D130662 */ "CPUs_utilized\000Default\000(software@cpu\\-clock\\=
,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=
=3Dtask\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\00=
0\0001CPUs\000\000\000\000011"
+/* offset=3D130848 */ "cs_per_second\000Default\000software@context\\-swit=
ches\\,name\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000\=
000011"
+/* offset=3D131081 */ "migrations_per_second\000Default\000software@cpu\\-=
migrations\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Process migrations to a new CPU per CPU second\000\0001m=
igrations/sec\000\000\000\000011"
+/* offset=3D131341 */ "page_faults_per_second\000Default\000software@page\=
\-faults\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\0=
00011"
+/* offset=3D131572 */ "insn_per_cycle\000Default\000instructions / cpu\\-c=
ycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\=
000\000\000\000001"
+/* offset=3D131685 */ "stalled_cycles_per_instruction\000Default\000max(st=
alled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\0=
00Max front or backend stalls per instruction\000\000\000\000\000\000001"
+/* offset=3D131849 */ "frontend_cycles_idle\000Default\000stalled\\-cycles=
\\-frontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls=
 per cycle\000\000\000\000\000\000001"
+/* offset=3D131979 */ "backend_cycles_idle\000Default\000stalled\\-cycles\=
\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per=
 cycle\000\000\000\000\000\000001"
+/* offset=3D132105 */ "cycles_frequency\000Default\000cpu\\-cycles / (soft=
ware@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\=
\-clock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\=
000\000\000\000011"
+/* offset=3D132281 */ "branch_frequency\000Default\000branches / (software=
@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-cl=
ock\\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M/s=
ec\000\000\000\000011"
+/* offset=3D132461 */ "branch_miss_rate\000Default\000branch\\-misses / br=
anches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\0=
00\000001"
+/* offset=3D132565 */ "l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-m=
isses / L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\0=
00100%\000\000\000\000001"
+/* offset=3D132681 */ "llc_miss_rate\000Default2\000LLC\\-load\\-misses / =
LLC\\-loads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\00=
0\000001"
+/* offset=3D132782 */ "l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-m=
isses / L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\00=
0100%\000\000\000\000001"
+/* offset=3D132897 */ "dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses =
/ dTLB\\-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\0=
00\000\000001"
+/* offset=3D133003 */ "itlb_miss_rate\000Default3\000iTLB\\-load\\-misses =
/ iTLB\\-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\0=
00\000\000001"
+/* offset=3D133109 */ "l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-=
prefetch\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.0=
5\000L1 prefetch miss rate\000\000100%\000\000\000\000001"
+/* offset=3D133257 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D133280 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalte=
d.thread\000\000\000\000\000\000\000\000000"
+/* offset=3D133344 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.co=
re / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_a=
ctive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000"
+/* offset=3D133511 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_=
retired.any\000\000\000\000\000\000\000\000000"
+/* offset=3D133576 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / in=
st_retired.any\000\000\000\000\000\000\000\000000"
+/* offset=3D133644 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + ic=
ache_miss_cycles\000\000\000\000\000\000\000\000000"
+/* offset=3D133716 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_h=
it + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000"
+/* offset=3D133811 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_d=
ata_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_=
miss\000\000\000\000\000\000\000\000000"
+/* offset=3D133946 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2=
_All_Miss\000\000\000\000\000\000\000\000000"
+/* offset=3D134011 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, D=
Cache_L2_All)\000\000\000\000\000\000\000\000000"
+/* offset=3D134080 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss,=
 DCache_L2_All)\000\000\000\000\000\000\000\000000"
+/* offset=3D134151 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D134174 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D134197 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\000000=
"
+/* offset=3D134218 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9=
 / duration_time\000\000\000\000\000\000\000\000000"
 ;
=20
 static const struct compact_pmu_event pmu_events__common_default_core[] =
=3D {
@@ -2592,6 +2620,34 @@ static const struct compact_pmu_event pmu_events__co=
mmon_tool[] =3D {
 { 126205 }, /* core_wide\000tool\0001 if not SMT, if SMT are events being =
gathered on all SMT threads 1 otherwise 0\000config=3D0xd\000\00000\000\000=
\000\000\000 */
 { 125072 }, /* duration_time\000tool\000Wall clock interval time in nanose=
conds\000config=3D1\000\00000\000\000\000\000\000 */
 { 125286 }, /* has_pmem\000tool\0001 if persistent memory installed otherw=
ise 0\000config=3D4\000\00000\000\000\000\000\000 */
+{ 126403 }, /* memory_anon_huge_pages\000tool\000Memory backed by anonymou=
s huge pages in bytes\000config=3D0xf\000\00000\000\000\000\000\000 */
+{ 126497 }, /* memory_anonymous\000tool\000Memory not mapped to a file (an=
onymous) in bytes\000config=3D0x10\000\00000\000\000\000\000\000 */
+{ 126588 }, /* memory_data\000tool\000Memory dedicated to data and stack i=
n bytes\000config=3D0x11\000\00000\000\000\000\000\000 */
+{ 126669 }, /* memory_file_pmd_mapped\000tool\000Memory backed by file and=
 mapped with Page Middle Directory (PMD) in bytes\000config=3D0x12\000\0000=
0\000\000\000\000\000 */
+{ 126792 }, /* memory_ksm\000tool\000Memory shared via Kernel Samepage Mer=
ging (KSM) in bytes\000config=3D0x13\000\00000\000\000\000\000\000 */
+{ 126885 }, /* memory_lazyfree\000tool\000Memory marked as LazyFree in byt=
es\000config=3D0x14\000\00000\000\000\000\000\000 */
+{ 126961 }, /* memory_locked\000tool\000Memory locked in RAM in bytes\000c=
onfig=3D0x15\000\00000\000\000\000\000\000 */
+{ 127030 }, /* memory_private_clean\000tool\000Private clean memory (not s=
hared, not modified) in bytes\000config=3D0x16\000\00000\000\000\000\000\00=
0 */
+{ 127133 }, /* memory_private_dirty\000tool\000Private dirty memory (not s=
hared, modified) in bytes\000config=3D0x17\000\00000\000\000\000\000\000 */
+{ 127232 }, /* memory_private_hugetlb\000tool\000Private memory backed by =
huge pages in bytes\000config=3D0x18\000\00000\000\000\000\000\000 */
+{ 127325 }, /* memory_pss\000tool\000Proportional Share Size (PSS) in byte=
s\000config=3D0x19\000\00000\000\000\000\000\000 */
+{ 127400 }, /* memory_pss_anon\000tool\000Proportional Share Size (PSS) fo=
r anonymous memory in bytes\000config=3D0x1a\000\00000\000\000\000\000\000 =
*/
+{ 127501 }, /* memory_pss_dirty\000tool\000Proportional Share Size (PSS) f=
or dirty memory in bytes\000config=3D0x1b\000\00000\000\000\000\000\000 */
+{ 127599 }, /* memory_pss_file\000tool\000Proportional Share Size (PSS) fo=
r file-backed memory in bytes\000config=3D0x1c\000\00000\000\000\000\000\00=
0 */
+{ 127702 }, /* memory_pss_shmem\000tool\000Proportional Share Size (PSS) f=
or shared memory in bytes\000config=3D0x1d\000\00000\000\000\000\000\000 */
+{ 127801 }, /* memory_referenced\000tool\000Memory marked as referenced/ac=
cessed in bytes\000config=3D0x1e\000\00000\000\000\000\000\000 */
+{ 127890 }, /* memory_resident\000tool\000Resident Set Size (RSS) in bytes=
 (from /proc/pid/statm). The sum of anonymous, file and shared memory\000co=
nfig=3D0x1f\000\00000\000\000\000\000\000 */
+{ 128033 }, /* memory_rss\000tool\000Resident Set Size (RSS) in bytes (fro=
m /proc/pid/smaps_rollup). The sum of anonymous, file and shared memory\000=
config=3D0x20\000\00000\000\000\000\000\000 */
+{ 128178 }, /* memory_shared\000tool\000Shared memory (shared with other p=
rocesses via files/shmem) in bytes\000config=3D0x21\000\00000\000\000\000\0=
00\000 */
+{ 128286 }, /* memory_shared_clean\000tool\000Shared clean memory (shared =
with other processes, not modified) in bytes\000config=3D0x22\000\00000\000=
\000\000\000\000 */
+{ 128404 }, /* memory_shared_dirty\000tool\000Shared dirty memory (shared =
with other processes, modified) in bytes\000config=3D0x23\000\00000\000\000=
\000\000\000 */
+{ 128518 }, /* memory_shared_hugetlb\000tool\000Shared memory backed by hu=
ge pages in bytes\000config=3D0x24\000\00000\000\000\000\000\000 */
+{ 128609 }, /* memory_shmem_pmd_mapped\000tool\000Shared memory mapped wit=
h Page Middle Directory (PMD) in bytes\000config=3D0x25\000\00000\000\000\0=
00\000\000 */
+{ 128721 }, /* memory_size\000tool\000Virtual memory size in bytes\000conf=
ig=3D0x26\000\00000\000\000\000\000\000 */
+{ 128787 }, /* memory_swap\000tool\000Memory swapped out to disk in bytes\=
000config=3D0x27\000\00000\000\000\000\000\000 */
+{ 128860 }, /* memory_swap_pss\000tool\000Proportional Share Size (PSS) fo=
r swap memory in bytes\000config=3D0x28\000\00000\000\000\000\000\000 */
+{ 128956 }, /* memory_text\000tool\000Memory dedicated to code (text segme=
nt) in bytes\000config=3D0x29\000\00000\000\000\000\000\000 */
+{ 129042 }, /* memory_uss\000tool\000Unique Set Size (USS) in bytes\000con=
fig=3D0x2a\000\00000\000\000\000\000\000 */
 { 125362 }, /* num_cores\000tool\000Number of cores. A core consists of 1 =
or more thread, with each thread being associated with a logical Linux CPU\=
000config=3D5\000\00000\000\000\000\000\000 */
 { 125507 }, /* num_cpus\000tool\000Number of logical Linux CPUs. There may=
 be multiple such CPUs on a core\000config=3D6\000\00000\000\000\000\000\00=
0 */
 { 125610 }, /* num_cpus_online\000tool\000Number of online logical Linux C=
PUs. There may be multiple such CPUs on a core\000config=3D7\000\00000\000\=
000\000\000\000 */
@@ -2625,23 +2681,23 @@ static const struct pmu_table_entry pmu_events__com=
mon[] =3D {
 };
=20
 static const struct compact_pmu_event pmu_metrics__common_default_core[] =
=3D {
-{ 127956 }, /* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CPU=
s\000\000\000\000011 */
-{ 129273 }, /* backend_cycles_idle\000Default\000stalled\\-cycles\\-backen=
d / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cycle\0=
00\000\000\000\000\000001 */
-{ 129575 }, /* branch_frequency\000Default\000branches / (software@cpu\\-c=
lock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,na=
me\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M/sec\000\0=
00\000\000011 */
-{ 129755 }, /* branch_miss_rate\000Default\000branch\\-misses / branches\0=
00branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\00000=
1 */
-{ 128142 }, /* cs_per_second\000Default\000software@context\\-switches\\,n=
ame\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-=
clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\=
000\000Context switches per CPU second\000\0001cs/sec\000\000\000\000011 */
-{ 129399 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu=
\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\=
\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\=
000\000011 */
-{ 130191 }, /* dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\=
-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\000\000\0=
00001 */
-{ 129143 }, /* frontend_cycles_idle\000Default\000stalled\\-cycles\\-front=
end / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per cyc=
le\000\000\000\000\000\000001 */
-{ 128866 }, /* insn_per_cycle\000Default\000instructions / cpu\\-cycles\00=
0insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\000\=
000\000001 */
-{ 130297 }, /* itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\=
-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\000\000\0=
00001 */
-{ 130403 }, /* l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch=
\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.05\000L1 =
prefetch miss rate\000\000100%\000\000\000\000001 */
-{ 129859 }, /* l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / =
L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\000100%\0=
00\000\000\000001 */
-{ 130076 }, /* l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / =
L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\000100%\00=
0\000\000\000001 */
-{ 129975 }, /* llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-lo=
ads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\000\000001=
 */
-{ 128375 }, /* migrations_per_second\000Default\000software@cpu\\-migratio=
ns\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcp=
u\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-cloc=
k@)\000\000Process migrations to a new CPU per CPU second\000\0001migration=
s/sec\000\000\000\000011 */
-{ 128635 }, /* page_faults_per_second\000Default\000software@page\\-faults=
\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-c=
lock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\0=
00\000Page faults per CPU second\000\0001faults/sec\000\000\000\000011 */
-{ 128979 }, /* stalled_cycles_per_instruction\000Default\000max(stalled\\-=
cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max fr=
ont or backend stalls per instruction\000\000\000\000\000\000001 */
+{ 130662 }, /* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CPU=
s\000\000\000\000011 */
+{ 131979 }, /* backend_cycles_idle\000Default\000stalled\\-cycles\\-backen=
d / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cycle\0=
00\000\000\000\000\000001 */
+{ 132281 }, /* branch_frequency\000Default\000branches / (software@cpu\\-c=
lock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,na=
me\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M/sec\000\0=
00\000\000011 */
+{ 132461 }, /* branch_miss_rate\000Default\000branch\\-misses / branches\0=
00branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\00000=
1 */
+{ 130848 }, /* cs_per_second\000Default\000software@context\\-switches\\,n=
ame\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-=
clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\=
000\000Context switches per CPU second\000\0001cs/sec\000\000\000\000011 */
+{ 132105 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu=
\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\=
\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\=
000\000011 */
+{ 132897 }, /* dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\=
-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\000\000\0=
00001 */
+{ 131849 }, /* frontend_cycles_idle\000Default\000stalled\\-cycles\\-front=
end / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per cyc=
le\000\000\000\000\000\000001 */
+{ 131572 }, /* insn_per_cycle\000Default\000instructions / cpu\\-cycles\00=
0insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\000\=
000\000001 */
+{ 133003 }, /* itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\=
-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\000\000\0=
00001 */
+{ 133109 }, /* l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch=
\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.05\000L1 =
prefetch miss rate\000\000100%\000\000\000\000001 */
+{ 132565 }, /* l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / =
L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\000100%\0=
00\000\000\000001 */
+{ 132782 }, /* l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / =
L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\000100%\00=
0\000\000\000001 */
+{ 132681 }, /* llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-lo=
ads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\000\000001=
 */
+{ 131081 }, /* migrations_per_second\000Default\000software@cpu\\-migratio=
ns\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcp=
u\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-cloc=
k@)\000\000Process migrations to a new CPU per CPU second\000\0001migration=
s/sec\000\000\000\000011 */
+{ 131341 }, /* page_faults_per_second\000Default\000software@page\\-faults=
\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-c=
lock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\0=
00\000Page faults per CPU second\000\0001faults/sec\000\000\000\000011 */
+{ 131685 }, /* stalled_cycles_per_instruction\000Default\000max(stalled\\-=
cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max fr=
ont or backend stalls per instruction\000\000\000\000\000\000001 */
=20
 };
=20
@@ -2654,29 +2710,29 @@ static const struct pmu_table_entry pmu_metrics__co=
mmon[] =3D {
 };
=20
 static const struct compact_pmu_event pmu_events__test_soc_cpu_default_cor=
e[] =3D {
-{ 126403 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=
=3D0x8a\000\00000\000\000\000\000\000 */
-{ 126465 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=
=3D0x8b\000\00000\000\000\000\000\000 */
-{ 126727 }, /* dispatch_blocked.any\000other\000Memory cluster signals to =
block micro-op dispatch for any reason\000event=3D9,period=3D200000,umask=
=3D0x20\000\00000\000\000\000\000\000 */
-{ 126860 }, /* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R=
) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\00000\0=
00\000\000\000\000 */
-{ 126527 }, /* l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x=
40\000\00000\000\000\000\000Attributable Level 3 cache access, read\000 */
-{ 126625 }, /* segment_reg_loads.any\000other\000Number of segment registe=
r loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\000\000=
\000 */
+{ 129109 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=
=3D0x8a\000\00000\000\000\000\000\000 */
+{ 129171 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=
=3D0x8b\000\00000\000\000\000\000\000 */
+{ 129433 }, /* dispatch_blocked.any\000other\000Memory cluster signals to =
block micro-op dispatch for any reason\000event=3D9,period=3D200000,umask=
=3D0x20\000\00000\000\000\000\000\000 */
+{ 129566 }, /* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R=
) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\00000\0=
00\000\000\000\000 */
+{ 129233 }, /* l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x=
40\000\00000\000\000\000\000Attributable Level 3 cache access, read\000 */
+{ 129331 }, /* segment_reg_loads.any\000other\000Number of segment registe=
r loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\000\000=
\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_d=
drc[] =3D {
-{ 126993 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands=
\000event=3D2\000\00000\000\000\000\000\000 */
+{ 129699 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands=
\000event=3D2\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_l=
3c[] =3D {
-{ 127355 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\0=
00event=3D7\000\00000\000\000\000\000\000 */
+{ 130061 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\0=
00event=3D7\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_cbox=
[] =3D {
-{ 127229 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\00=
0\00000\000\000\000\000\000 */
-{ 127283 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc=
0\000\00000\000\000\000\000\000 */
-{ 127075 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-co=
re snoop resulted from L3 Eviction which misses in some processor core\000e=
vent=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000 */
+{ 129935 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\00=
0\00000\000\000\000\000\000 */
+{ 129989 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc=
0\000\00000\000\000\000\000\000 */
+{ 129781 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-co=
re snoop resulted from L3 Eviction which misses in some processor core\000e=
vent=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc[=
] =3D {
-{ 127538 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000even=
t=3D0x34\000\00000\000\000\000\000\000 */
+{ 130244 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000even=
t=3D0x34\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc_=
free_running[] =3D {
-{ 127447 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cache=
 misses\000event=3D0x12\000\00000\000\000\000\000\000 */
+{ 130153 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cache=
 misses\000event=3D0x12\000\00000\000\000\000\000\000 */
=20
 };
=20
@@ -2689,46 +2745,46 @@ static const struct pmu_table_entry pmu_events__tes=
t_soc_cpu[] =3D {
 {
      .entries =3D pmu_events__test_soc_cpu_hisi_sccl_ddrc,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_ddrc),
-     .pmu_name =3D { 126978 /* hisi_sccl,ddrc\000 */ },
+     .pmu_name =3D { 129684 /* hisi_sccl,ddrc\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_hisi_sccl_l3c,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_l3c),
-     .pmu_name =3D { 127341 /* hisi_sccl,l3c\000 */ },
+     .pmu_name =3D { 130047 /* hisi_sccl,l3c\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_uncore_cbox,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_cbox),
-     .pmu_name =3D { 127063 /* uncore_cbox\000 */ },
+     .pmu_name =3D { 129769 /* uncore_cbox\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_uncore_imc,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc),
-     .pmu_name =3D { 127527 /* uncore_imc\000 */ },
+     .pmu_name =3D { 130233 /* uncore_imc\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_uncore_imc_free_running,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc_free_=
running),
-     .pmu_name =3D { 127423 /* uncore_imc_free_running\000 */ },
+     .pmu_name =3D { 130129 /* uncore_imc_free_running\000 */ },
 },
 };
=20
 static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_co=
re[] =3D {
-{ 130551 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
-{ 131240 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Mis=
s\000\000\000\000\000\000\000\000000 */
-{ 131010 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_=
rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000 */
-{ 131105 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd -=
 l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000=
\000\000\000\000\000\000\000000 */
-{ 131305 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2=
_All)\000\000\000\000\000\000\000\000000 */
-{ 131374 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_=
L2_All)\000\000\000\000\000\000\000\000000 */
-{ 130638 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 =
* (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / =
cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000 */
-{ 130574 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread=
\000\000\000\000\000\000\000\000000 */
-{ 131512 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / durat=
ion_time\000\000\000\000\000\000\000\000000 */
-{ 131445 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
-{ 131468 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
-{ 131491 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
-{ 130938 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_mis=
s_cycles\000\000\000\000\000\000\000\000000 */
-{ 130805 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.=
any\000\000\000\000\000\000\000\000000 */
-{ 130870 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
ed.any\000\000\000\000\000\000\000\000000 */
+{ 133257 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
+{ 133946 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Mis=
s\000\000\000\000\000\000\000\000000 */
+{ 133716 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_=
rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000 */
+{ 133811 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd -=
 l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000=
\000\000\000\000\000\000\000000 */
+{ 134011 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2=
_All)\000\000\000\000\000\000\000\000000 */
+{ 134080 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_=
L2_All)\000\000\000\000\000\000\000\000000 */
+{ 133344 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 =
* (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / =
cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000 */
+{ 133280 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread=
\000\000\000\000\000\000\000\000000 */
+{ 134218 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / durat=
ion_time\000\000\000\000\000\000\000\000000 */
+{ 134151 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
+{ 134174 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
+{ 134197 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
+{ 133644 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_mis=
s_cycles\000\000\000\000\000\000\000\000000 */
+{ 133511 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.=
any\000\000\000\000\000\000\000\000000 */
+{ 133576 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
ed.any\000\000\000\000\000\000\000\000000 */
=20
 };
=20
@@ -2741,13 +2797,13 @@ static const struct pmu_table_entry pmu_metrics__te=
st_soc_cpu[] =3D {
 };
=20
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ccn_pmu[] =3D {
-{ 127717 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\=
000config=3D0x2c\0000x01\00000\000\000\000\000\000 */
+{ 130423 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\=
000config=3D0x2c\0000x01\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
cmn_pmu[] =3D {
-{ 127813 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache =
misses in first lookup result (high priority)\000eventid=3D1,type=3D5\000(4=
34|436|43c|43a).*\00000\000\000\000\000\000 */
+{ 130519 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache =
misses in first lookup result (high priority)\000eventid=3D1,type=3D5\000(4=
34|436|43c|43a).*\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ddr_pmu[] =3D {
-{ 127622 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles even=
t\000event=3D0x2b\000v8\00000\000\000\000\000\000 */
+{ 130328 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles even=
t\000event=3D0x2b\000v8\00000\000\000\000\000\000 */
=20
 };
=20
@@ -2755,17 +2811,17 @@ static const struct pmu_table_entry pmu_events__tes=
t_soc_sys[] =3D {
 {
      .entries =3D pmu_events__test_soc_sys_uncore_sys_ccn_pmu,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ccn_p=
mu),
-     .pmu_name =3D { 127698 /* uncore_sys_ccn_pmu\000 */ },
+     .pmu_name =3D { 130404 /* uncore_sys_ccn_pmu\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_sys_uncore_sys_cmn_pmu,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_cmn_p=
mu),
-     .pmu_name =3D { 127794 /* uncore_sys_cmn_pmu\000 */ },
+     .pmu_name =3D { 130500 /* uncore_sys_cmn_pmu\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_sys_uncore_sys_ddr_pmu,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ddr_p=
mu),
-     .pmu_name =3D { 127603 /* uncore_sys_ddr_pmu\000 */ },
+     .pmu_name =3D { 130309 /* uncore_sys_ddr_pmu\000 */ },
 },
 };
=20
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 37c4eae0bef1..2d1f244264dd 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -13,11 +13,14 @@
 #include "tsc.h"
 #include <api/fs/fs.h>
 #include <api/io.h>
+#include <internal/lib.h> // page_size
 #include <internal/threadmap.h>
 #include <perf/cpumap.h>
 #include <perf/threadmap.h>
 #include <fcntl.h>
 #include <strings.h>
+#include <api/io_dir.h>
+#include <ctype.h>
=20
 static const char *const tool_pmu__event_names[TOOL_PMU__EVENT_MAX] =3D {
 	NULL,
@@ -35,6 +38,34 @@ static const char *const tool_pmu__event_names[TOOL_PMU_=
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
+	"memory_resident",
+	"memory_rss",
+	"memory_shared",
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
@@ -220,6 +251,190 @@ static int read_pid_stat_field(int fd, int field, __u=
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
+static bool tool_pmu__is_memory_statm_event(enum tool_pmu_event ev)
+{
+	return ev =3D=3D TOOL_PMU__EVENT_MEMORY_SIZE ||
+	       ev =3D=3D TOOL_PMU__EVENT_MEMORY_RESIDENT ||
+	       ev =3D=3D TOOL_PMU__EVENT_MEMORY_SHARED ||
+	       ev =3D=3D TOOL_PMU__EVENT_MEMORY_TEXT ||
+	       ev =3D=3D TOOL_PMU__EVENT_MEMORY_DATA;
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
+	case TOOL_PMU__EVENT_MEMORY_RESIDENT:
+	case TOOL_PMU__EVENT_MEMORY_SHARED:
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
+static int read_smaps_rollup_field(int fd, const char *key, u64 *val)
+{
+	char buf[4096];
+	struct io io;
+	int ch;
+
+	io__init(&io, fd, buf, sizeof(buf));
+
+	while ((ch =3D io__get_char(&io)) !=3D -1) {
+		/* Check if line starts with key */
+		if (ch =3D=3D key[0]) {
+			const char *k =3D key + 1;
+
+			while (*k && (ch =3D io__get_char(&io)) =3D=3D *k)
+				k++;
+
+			if (!*k) {
+				/* Found key, skip whitespace */
+				while ((ch =3D io__get_char(&io)) =3D=3D ' ' || ch =3D=3D '\t')
+					;
+				/* Read value */
+				if (ch >=3D '0' && ch <=3D '9') {
+					*val =3D ch - '0';
+					while ((ch =3D io__get_char(&io)) >=3D '0' && ch <=3D '9') {
+						*val =3D *val * 10 + (ch - '0');
+					}
+					/* Convert kB to bytes */
+					*val *=3D 1024;
+					return 0;
+				}
+			}
+		}
+		/* Skip rest of line */
+		if (ch !=3D '\n')
+			read_until_char(&io, '\n');
+	}
+	return -EINVAL;
+}
+
+static int read_smaps_rollup(int fd, enum tool_pmu_event ev, u64 *val)
+{
+	int ret;
+
+	if (ev =3D=3D TOOL_PMU__EVENT_MEMORY_USS) {
+		u64 pc, pd;
+
+		lseek(fd, 0, SEEK_SET);
+		ret =3D read_smaps_rollup_field(fd, "Private_Clean:", &pc);
+		if (ret)
+			return ret;
+		lseek(fd, 0, SEEK_SET);
+		ret =3D read_smaps_rollup_field(fd, "Private_Dirty:", &pd);
+		if (ret)
+			return ret;
+		*val =3D pc + pd;
+		return 0;
+	}
+
+	lseek(fd, 0, SEEK_SET);
+	return read_smaps_rollup_field(fd, tool_pmu__memory_event_to_key(ev), val=
);
+}
+
+static int read_statm(int fd, enum tool_pmu_event ev, u64 *val)
+{
+	char buf[128];
+	struct io io;
+	u64 v;
+
+	io__init(&io, fd, buf, sizeof(buf));
+	lseek(fd, 0, SEEK_SET);
+
+	/* Size */
+	if (io__get_dec(&io, (__u64 *)&v) =3D=3D -1)
+		return -EINVAL;
+	if (ev =3D=3D TOOL_PMU__EVENT_MEMORY_SIZE) {
+		*val =3D v * page_size;
+		return 0;
+	}
+
+	/* Resident */
+	if (io__get_dec(&io, (__u64 *)&v) =3D=3D -1) /* Skip */
+		return -EINVAL;
+	if (ev =3D=3D TOOL_PMU__EVENT_MEMORY_RESIDENT) {
+		*val =3D v * page_size;
+		return 0;
+	}
+
+	/* Shared */
+	if (io__get_dec(&io, (__u64 *)&v) =3D=3D -1) /* Skip */
+		return -EINVAL;
+	if (ev =3D=3D TOOL_PMU__EVENT_MEMORY_SHARED) {
+		*val =3D v * page_size;
+		return 0;
+	}
+
+	/* Text */
+	if (io__get_dec(&io, (__u64 *)&v) =3D=3D -1)
+		return -EINVAL;
+	if (ev =3D=3D TOOL_PMU__EVENT_MEMORY_TEXT) {
+		*val =3D v * page_size;
+		return 0;
+	}
+
+	/* Lib */
+	if (io__get_dec(&io, (__u64 *)&v) =3D=3D -1) /* Skip */
+		return -EINVAL;
+
+	/* Data */
+	if (io__get_dec(&io, (__u64 *)&v) =3D=3D -1)
+		return -EINVAL;
+	if (ev =3D=3D TOOL_PMU__EVENT_MEMORY_DATA) {
+		*val =3D v * page_size;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 int evsel__tool_pmu_prepare_open(struct evsel *evsel,
 				 struct perf_cpu_map *cpus,
 				 int nthreads)
@@ -267,6 +482,7 @@ int evsel__tool_pmu_open(struct evsel *evsel,
 			if (ev =3D=3D TOOL_PMU__EVENT_USER_TIME || ev =3D=3D TOOL_PMU__EVENT_SY=
STEM_TIME) {
 				bool system =3D ev =3D=3D TOOL_PMU__EVENT_SYSTEM_TIME;
 				__u64 *start_time =3D NULL;
+				char buf[PATH_MAX];
 				int fd;
=20
 				if (evsel->core.attr.sample_period) {
@@ -275,14 +491,14 @@ int evsel__tool_pmu_open(struct evsel *evsel,
 					goto out_close;
 				}
 				if (pid > -1) {
-					char buf[64];
-
-					snprintf(buf, sizeof(buf), "/proc/%d/stat", pid);
-					fd =3D open(buf, O_RDONLY);
+					snprintf(buf, sizeof(buf), "%s/%d/stat",
+						 procfs__mountpoint(), pid);
 					evsel->pid_stat =3D true;
 				} else {
-					fd =3D open("/proc/stat", O_RDONLY);
+					snprintf(buf, sizeof(buf), "%s/stat",
+						 procfs__mountpoint());
 				}
+				fd =3D open(buf, O_RDONLY);
 				FD(evsel, idx, thread) =3D fd;
 				if (fd < 0) {
 					err =3D -errno;
@@ -301,6 +517,30 @@ int evsel__tool_pmu_open(struct evsel *evsel,
 				}
 				if (err)
 					goto out_close;
+			} else if (tool_pmu__is_memory_event(ev)) {
+				int fd =3D -1;
+
+				if (pid > -1) {
+					char buf[PATH_MAX];
+
+					if (tool_pmu__is_memory_statm_event(ev)) {
+						snprintf(buf, sizeof(buf), "%s/%d/statm",
+							 procfs__mountpoint(), pid);
+					} else {
+						snprintf(buf, sizeof(buf), "%s/%d/smaps_rollup",
+							 procfs__mountpoint(), pid);
+					}
+					fd =3D open(buf, O_RDONLY);
+				}
+				/*
+				 * For system-wide (pid =3D=3D -1), we don't open a file here.
+				 * We will aggregate in read().
+				 */
+				if (pid > -1 && fd < 0) {
+					err =3D -errno;
+					goto out_close;
+				}
+				FD(evsel, idx, thread) =3D fd;
 			}
=20
 		}
@@ -455,6 +695,34 @@ bool tool_pmu__read_event(enum tool_pmu_event ev,
 		*result =3D system_wide || (user_requested_cpu_list !=3D NULL) ? 1 : 0;
 		return true;
=20
+	case TOOL_PMU__EVENT_MEMORY_SIZE:
+	case TOOL_PMU__EVENT_MEMORY_RSS:
+	case TOOL_PMU__EVENT_MEMORY_PSS:
+	case TOOL_PMU__EVENT_MEMORY_SHARED:
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
+	case TOOL_PMU__EVENT_MEMORY_RESIDENT:
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
@@ -487,6 +755,52 @@ static void perf_counts__update(struct perf_counts_val=
ues *count,
 	}
 }
=20
+static int tool_pmu__aggregate_memory_event(enum tool_pmu_event ev, u64 *v=
al)
+{
+	struct io_dir iod;
+	struct io_dirent64 *ent;
+	int proc_fd;
+
+	*val =3D 0;
+	proc_fd =3D open(procfs__mountpoint(), O_DIRECTORY | O_RDONLY);
+	if (proc_fd < 0)
+		return -errno;
+
+	io_dir__init(&iod, proc_fd);
+
+	while ((ent =3D io_dir__readdir(&iod)) !=3D NULL) {
+		char buf[PATH_MAX];
+		u64 pid_val;
+		int fd;
+
+		if (!io_dir__is_dir(&iod, ent))
+			continue;
+
+		if (!isdigit(ent->d_name[0]))
+			continue;
+
+		if (tool_pmu__is_memory_statm_event(ev))
+			snprintf(buf, sizeof(buf), "%s/statm", ent->d_name);
+		else
+			snprintf(buf, sizeof(buf), "%s/smaps_rollup", ent->d_name);
+
+		fd =3D openat(proc_fd, buf, O_RDONLY);
+		if (fd < 0)
+			continue;
+
+		if (tool_pmu__is_memory_statm_event(ev)) {
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
 int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 {
 	__u64 *start_time, cur_time, delta_start;
@@ -564,6 +878,57 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_=
map_idx, int thread)
 		adjust =3D true;
 		break;
 	}
+	case TOOL_PMU__EVENT_MEMORY_SIZE:
+	case TOOL_PMU__EVENT_MEMORY_RSS:
+	case TOOL_PMU__EVENT_MEMORY_PSS:
+	case TOOL_PMU__EVENT_MEMORY_SHARED:
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
+	case TOOL_PMU__EVENT_MEMORY_RESIDENT:
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
+		int fd =3D FD(evsel, cpu_map_idx, thread);
+		u64 val =3D 0;
+
+		if (fd >=3D 0) {
+			/* Per-process */
+			int ret;
+
+			if (tool_pmu__is_memory_statm_event(ev))
+				ret =3D read_statm(fd, ev, &val);
+			else
+				ret =3D read_smaps_rollup(fd, ev, &val);
+
+			if (ret)
+				return ret;
+		} else {
+			/* System-wide aggregation */
+			if (cpu_map_idx =3D=3D 0 && thread =3D=3D 0) {
+				tool_pmu__aggregate_memory_event(ev, &val);
+			}
+		}
+		perf_counts__update(count, old_count, /*raw=3D*/false, val);
+		return 0;
+	}
 	case TOOL_PMU__EVENT_NONE:
 	case TOOL_PMU__EVENT_MAX:
 	default:
diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
index ea343d1983d3..bf6bb196ad75 100644
--- a/tools/perf/util/tool_pmu.h
+++ b/tools/perf/util/tool_pmu.h
@@ -24,6 +24,34 @@ enum tool_pmu_event {
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
+	TOOL_PMU__EVENT_MEMORY_RESIDENT,
+	TOOL_PMU__EVENT_MEMORY_RSS,
+	TOOL_PMU__EVENT_MEMORY_SHARED,
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
2.52.0.351.gbe84eed79e-goog

