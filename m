Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613073;
	b=u6ePRqbdUn7mACNnxKwkFiKpEwWsYc4VsYY9nU92a2GST0p3/bfjcaxg2iUDHjPVw8ke
	 a967YPNhYXzlJcL7OgxWxAFiZdKuui5A9AGSyS3V4iS8CPGUyzd5o3X/X0sjurrjCoTD8
	 FYGgTxkz2+6MkMBRF+ORCWF8lrUzFaUmhU+kU9wkYHwgvW5Zu4pRWo6yJSoIJXaopq8aZ
	 biIMjuq4SDE6lJ2XjcFFiOI2bvJYaQF2JvJXg3eDb+bxk46w6Ct+ALo2s9QgxhHkCyAOx
	 iadt4tkFk1HEf4w9Oh4DbdH/bDs+avZihQZExQQBg4lQgwSm/78r45ObN03SZiq0YdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613073;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Nc2lp6hDZ7Xg9EIqirPIw1RX7uCeiw1CvROwmwlIi8E=;
	b=L5YQ8l40/4UcbyhUS2ApRVVJm8zro2xFhNWOqi5exDyPHrm0f76fdP8ljk1yarLbl5wo
	 UukQwXjDJnbO3qRHDugqP/+EMAuo/8/M6e40pI+xSXXPXBKDxPngqkfzDzc4WVglgGURP
	 /zOqBPZWZRkWeo+gkfybEy/Vo5Q2AV1U3c6FtfmQkILYjJ8dEJ4pG4LRlUQIAfuygfvwa
	 w61zdbIJLA8TQtCnYM1HmK8Lp/eiVMZ1ajwddAJJtcuJsUrC0Lo9Jzd0hmT3Oufq7+pAM
	 FRItl5xUBKDRYqLVbzaX5MFq7oc4pZUwtT4Teo3qChQB0iPzW7PehqUvUoQwaagJjog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="WtOu/WMO";
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4C9606A8B2
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 23:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A4C9606A8B2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WtOu/WMO
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36d1353fdcdso6488385eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794613071; x=1795217871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Nc2lp6hDZ7Xg9EIqirPIw1RX7uCeiw1CvROwmwlIi8E=;
        b=WtOu/WMOJfnrc+ne4UHnSQ3q7dYqvXLxHDF3cfJfxstdJvtTx3QIPerV3EAfQQt+Ft
         00uHZw5ESy2/M9j6X7v/iftWsRPt5Upyh9tIpv5lwcL1vyA7oR1/NDrPKPAxu5qVJHCM
         jW6sMHQilEDgrqEiqNc3/AAXNmX/Jij/XTLHWkfYstl3D+wbGZTOJrxnw+uSDaTO+wPL
         Ygq+3zIrusrkjBWZWDcbzGhVt9uOScnB+9l3ZFd/ttt3ZeA5fMolGl0O1A1nj0rPzxh8
         PMaHZAK1I7+4VaVEBOxW4R2Gl9ZHVP+PHx2dZ/Z7zCQRIA6yGgshwXIIWqQZD20es8t/
         uUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794613071; x=1795217871;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nc2lp6hDZ7Xg9EIqirPIw1RX7uCeiw1CvROwmwlIi8E=;
        b=dgnNOD7zFJ+3flquLQcBZSzFEEls5kmOJULwFr1E4tb0Z8UCuvFy5ZOE6tOmQca1+P
         B/HoSDPlcuDuUkJ5Fk5thKmyX8KMfvLh45VWj/4ccKUMz/yX/DYhnLarl+/jDsFrPLZZ
         /RTCV1lPD0niDXDKWByTBoSYDiE7uVNa7PHn9TV7AHIWC/irKr8/lYdyE5hNmvvEYHaZ
         XdiBWvbH2Vko/X55gmChVY8DGiRqV7E45t0M8tymH0e1rTexZxkdQ4Mdgdmu5tLLtxTD
         fKxeIyDPzjfWDepLcRDCiTq7fZhhHnWlQ/wjl0fKWiLsPP9KRnqfG0h5siZRg+kzcPF+
         3zpg==
X-Forwarded-Encrypted: i=1; AL+hErGJepAxuGGR3vIst3hpwpB+xbITnbO4Kok9Qhc9kuAYGhvWdklADuj6C+1uwwmv3Y/mMkBt887I6yDPYUnYwMhL@vger.kernel.org
X-Gm-Message-State: APuU4Z9JEs3mkHZ/Iw5dyF+aOepPj5jG93iXNmlOy+scsGM2Ka+nhRjk
	DNywdvbugsBt7PZs+c7sUh7Ekp+TFj66e1bvgFPPipgZlXD6EBldatAMLGT5FuEN3OGskQLsNBp
	P3GQFONhTQQ==
X-Received: from dled16-n2.prod.google.com ([2002:a05:701b:42d0:20b0:19a:9ffd:b30e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:454a:20b0:194:3a84:e67a
 with SMTP id a92af1059eb24-1b503146625mr4200209c88.41.1794613070710; Fri, 13
 Nov 2026 15:37:50 -0800 (PST)
Date: Fri, 13 Nov 2026 15:37:38 -0800
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
Message-ID: <20261113233739.3626499-4-irogers@google.com>
Subject: [PATCH v2 3/4] perf tool_pmu: Add schedstat events
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

Add per-CPU tool PMU events backed by /proc/schedstat runqueue
statistics:
- schedstat_yield: Calls to sched_yield().
- schedstat_schedule: Calls to schedule().
- schedstat_schedule_idle: Calls to schedule() leaving the CPU idle.
- schedstat_wake: Calls to try_to_wake_up().
- schedstat_wake_local: Calls to try_to_wake_up() for the local CPU.
- schedstat_runtime: Task runtime on this CPU in nanoseconds.
- schedstat_wait: Task runqueue wait time on this CPU in nanoseconds.
- schedstat_timeslices: Number of timeslices run on this CPU.

Because /proc/schedstat reports per-CPU runqueue counters, reject
per-process and cgroup modes, exclude schedstat events from
perf_pmu__reads_only_on_cpu_idx0(), and update should_skip_zero_counter()
so zero-valued per-CPU tool events are not suppressed on CPUs > 0. Track
initial and accumulated values across enable/disable transitions to
report deltas over the measurement interval.

Example system-wide and per-CPU output:

  $ perf stat -a -e schedstat_yield,schedstat_schedule \
      -e schedstat_runtime,schedstat_wait,schedstat_timeslices sleep 0.1

   Performance counter stats for 'system wide':

                   0      schedstat_yield
                   0      schedstat_schedule
         455,566,105      schedstat_runtime
             348,262      schedstat_wait
              63,336      schedstat_timeslices

         0.112807668 seconds time elapsed

  $ perf stat -A -C 0,1 -e schedstat_schedule,schedstat_runtime \
      -e schedstat_wait,schedstat_timeslices sleep 0.1

   Performance counter stats for 'CPU(s) 0,1':

  CPU0                    0      tool/schedstat_schedule/
  CPU1                    0      tool/schedstat_schedule/
  CPU0            6,217,341      tool/schedstat_runtime/
  CPU1           25,243,949      tool/schedstat_runtime/
  CPU0               11,005      tool/schedstat_wait/
  CPU1               20,921      tool/schedstat_wait/
  CPU0                  115      tool/schedstat_timeslices/
  CPU1                3,535      tool/schedstat_timeslices/

         0.101808548 seconds time elapsed

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/common/common/tool.json   |  48 ++++
 tools/perf/pmu-events/empty-pmu-events.c      | 254 ++++++++++--------
 tools/perf/util/pmu.c                         |   4 +-
 tools/perf/util/stat-display.c                |   8 +-
 tools/perf/util/tool_pmu.c                    | 133 ++++++++-
 tools/perf/util/tool_pmu.h                    |   9 +
 6 files changed, 340 insertions(+), 116 deletions(-)

diff --git a/tools/perf/pmu-events/arch/common/common/tool.json b/tools/per=
f/pmu-events/arch/common/common/tool.json
index a332cbf842f7..7c6e03055ca3 100644
--- a/tools/perf/pmu-events/arch/common/common/tool.json
+++ b/tools/perf/pmu-events/arch/common/common/tool.json
@@ -334,5 +334,53 @@
     "EventName": "net_tx_compressed",
     "BriefDescription": "System-wide network transmitted compressed packet=
s",
     "ConfigCode": "56"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "schedstat_yield",
+    "BriefDescription": "Number of times sched_yield() was called",
+    "ConfigCode": "57"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "schedstat_schedule",
+    "BriefDescription": "Number of times schedule() was called",
+    "ConfigCode": "58"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "schedstat_schedule_idle",
+    "BriefDescription": "Number of times schedule() left the processor idl=
e",
+    "ConfigCode": "59"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "schedstat_wake",
+    "BriefDescription": "Number of times try_to_wake_up() was called",
+    "ConfigCode": "60"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "schedstat_wake_local",
+    "BriefDescription": "Number of times try_to_wake_up() was called to wa=
ke up the local cpu",
+    "ConfigCode": "61"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "schedstat_runtime",
+    "BriefDescription": "Sum of all time spent running by tasks on this pr=
ocessor (in nanoseconds)",
+    "ConfigCode": "62"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "schedstat_wait",
+    "BriefDescription": "Sum of all time spent waiting to run by tasks on =
this processor (in nanoseconds)",
+    "ConfigCode": "63"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "schedstat_timeslices",
+    "BriefDescription": "Number of timeslices run on this cpu",
+    "ConfigCode": "64"
   }
 ]
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-even=
ts/empty-pmu-events.c
index 8705f32563a6..49e2d3f8b3f1 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -2628,116 +2628,132 @@ static const char *const big_c_string =3D
 /* offset=3D130002 */
 "net_tx_compressed\000tool\000System-wide network transmitted compressed p=
ackets\000config=3D0x38\000\00000\000\000\000\000\000"
 /* offset=3D130096 */
+"schedstat_yield\000tool\000Number of times sched_yield() was called\000co=
nfig=3D0x39\000\00000\000\000\000\000\000"
+/* offset=3D130178 */
+"schedstat_schedule\000tool\000Number of times schedule() was called\000co=
nfig=3D0x3a\000\00000\000\000\000\000\000"
+/* offset=3D130260 */
+"schedstat_schedule_idle\000tool\000Number of times schedule() left the pr=
ocessor idle\000config=3D0x3b\000\00000\000\000\000\000\000"
+/* offset=3D130360 */
+"schedstat_wake\000tool\000Number of times try_to_wake_up() was called\000=
config=3D0x3c\000\00000\000\000\000\000\000"
+/* offset=3D130444 */
+"schedstat_wake_local\000tool\000Number of times try_to_wake_up() was call=
ed to wake up the local cpu\000config=3D0x3d\000\00000\000\000\000\000\000"
+/* offset=3D130559 */
+"schedstat_runtime\000tool\000Sum of all time spent running by tasks on th=
is processor (in nanoseconds)\000config=3D0x3e\000\00000\000\000\000\000\00=
0"
+/* offset=3D130676 */
+"schedstat_wait\000tool\000Sum of all time spent waiting to run by tasks o=
n this processor (in nanoseconds)\000config=3D0x3f\000\00000\000\000\000\00=
0\000"
+/* offset=3D130797 */
+"schedstat_timeslices\000tool\000Number of timeslices run on this cpu\000c=
onfig=3D0x40\000\00000\000\000\000\000\000"
+/* offset=3D130880 */
 "bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=3D0x8a\000\0000=
0\000\000\000\000\000"
-/* offset=3D130158 */
+/* offset=3D130942 */
 "bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=3D0x8b\000\0000=
0\000\000\000\000\000"
-/* offset=3D130220 */
+/* offset=3D131004 */
 "l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x40\000\00000\0=
00\000\000\000Attributable Level 3 cache access, read\000"
-/* offset=3D130318 */
+/* offset=3D131102 */
 "segment_reg_loads.any\000other\000Number of segment register loads\000eve=
nt=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\000\000\000"
-/* offset=3D130420 */
+/* offset=3D131204 */
 "dispatch_blocked.any\000other\000Memory cluster signals to block micro-op=
 dispatch for any reason\000event=3D9,period=3D200000,umask=3D0x20\000\0000=
0\000\000\000\000\000"
-/* offset=3D130553 */
+/* offset=3D131337 */
 "eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technology (=
EIST) transitions\000event=3D0x3a,period=3D200000\000\00000\000\000\000\000=
\000"
-/* offset=3D130671 */
+/* offset=3D131455 */
 "hisi_sccl,ddrc\000"
-/* offset=3D130686 */
+/* offset=3D131470 */
 "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=3D2\=
000\00000\000\000\000\000\000"
-/* offset=3D130756 */
+/* offset=3D131540 */
 "uncore_cbox\000"
-/* offset=3D130768 */
+/* offset=3D131552 */
 "unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core snoop resul=
ted from L3 Eviction which misses in some processor core\000event=3D0x22,um=
ask=3D0x81\000\00000\000\000\000\000\000"
-/* offset=3D130922 */
+/* offset=3D131706 */
 "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\000\00000\000\00=
0\000\000\000"
-/* offset=3D130976 */
+/* offset=3D131760 */
 "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc0\000\00000\00=
0\000\000\000\000"
-/* offset=3D131034 */
+/* offset=3D131818 */
 "hisi_sccl,l3c\000"
-/* offset=3D131048 */
+/* offset=3D131832 */
 "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000event=3D7\00=
0\00000\000\000\000\000\000"
-/* offset=3D131116 */
+/* offset=3D131900 */
 "uncore_imc_free_running\000"
-/* offset=3D131140 */
+/* offset=3D131924 */
 "uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000eve=
nt=3D0x12\000\00000\000\000\000\000\000"
-/* offset=3D131220 */
+/* offset=3D132004 */
 "uncore_imc\000"
-/* offset=3D131231 */
+/* offset=3D132015 */
 "uncore_imc.cache_hits\000uncore\000Total cache hits\000event=3D0x34\000\0=
0000\000\000\000\000\000"
-/* offset=3D131296 */
+/* offset=3D132080 */
 "uncore_sys_ddr_pmu\000"
-/* offset=3D131315 */
+/* offset=3D132099 */
 "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=3D0=
x2b\000v8\00000\000\000\000\000\000"
-/* offset=3D131391 */
+/* offset=3D132175 */
 "uncore_sys_ccn_pmu\000"
-/* offset=3D131410 */
+/* offset=3D132194 */
 "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=3D0x=
2c\0000x01\00000\000\000\000\000\000"
-/* offset=3D131487 */
+/* offset=3D132271 */
 "uncore_sys_cmn_pmu\000"
-/* offset=3D131506 */
+/* offset=3D132290 */
 "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in firs=
t lookup result (high priority)\000eventid=3D1,type=3D5\000(434|436|43c|43a=
).*\00000\000\000\000\000\000"
-/* offset=3D131649 */
+/* offset=3D132433 */
 "CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=3Dcpu\\-clock@=
 if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@) / (dur=
ation_time * 1e9)\000\000Average CPU utilization\000\0001CPUs\000\000\000\0=
00011"
-/* offset=3D131835 */
+/* offset=3D132619 */
 "cs_per_second\000Default\000software@context\\-switches\\,name\\=3Dcontex=
t\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #tar=
get_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Context=
 switches per CPU second\000\0001cs/sec\000\000\000\000011"
-/* offset=3D132068 */
+/* offset=3D132852 */
 "migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=3D=
cpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if =
#target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Pro=
cess migrations to a new CPU per CPU second\000\0001migrations/sec\000\000\=
000\000011"
-/* offset=3D132328 */
+/* offset=3D133112 */
 "page_faults_per_second\000Default\000software@page\\-faults\\,name\\=3Dpa=
ge\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #targ=
et_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Page fau=
lts per CPU second\000\0001faults/sec\000\000\000\000011"
-/* offset=3D132559 */
+/* offset=3D133343 */
 "insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_cycl=
e < 1\000Instructions Per Cycle\000\0001instructions\000\000\000\000001"
-/* offset=3D132672 */
+/* offset=3D133456 */
 "stalled_cycles_per_instruction\000Default\000(max(stalled\\-cycles\\-fron=
tend, stalled\\-cycles\\-backend) / instructions if has_event(stalled\\-cyc=
les\\-frontend) & has_event(stalled\\-cycles\\-backend) else (stalled\\-cyc=
les\\-frontend / instructions if has_event(stalled\\-cycles\\-frontend) els=
e (stalled\\-cycles\\-backend / instructions if has_event(stalled\\-cycles\=
\-backend) else 0)))\000\000Max front or backend stalls per instruction\000=
\000\000\000\000\000001"
-/* offset=3D133097 */
+/* offset=3D133881 */
 "frontend_cycles_idle\000Default\000(stalled\\-cycles\\-frontend / cpu\\-c=
ycles if has_event(stalled\\-cycles\\-frontend) else 0)\000frontend_cycles_=
idle > 0.1\000Frontend stalls per cycle\000\000\000\000\000\000001"
-/* offset=3D133276 */
+/* offset=3D134060 */
 "backend_cycles_idle\000Default\000(stalled\\-cycles\\-backend / cpu\\-cyc=
les if has_event(stalled\\-cycles\\-backend) else 0)\000backend_cycles_idle=
 > 0.2\000Backend stalls per cycle\000\000\000\000\000\000001"
-/* offset=3D133450 */
+/* offset=3D134234 */
 "cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\000\000011"
-/* offset=3D133626 */
+/* offset=3D134410 */
 "branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Branches per CPU second\000\0001000M/sec\000\000\000\000011=
"
-/* offset=3D133806 */
+/* offset=3D134590 */
 "branch_miss_rate\000Default\000branch\\-misses / branches\000branch_miss_=
rate > 0.05\000Branch miss rate\000\000100%\000\000\000\000001"
-/* offset=3D133910 */
+/* offset=3D134694 */
 "l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / L1\\-dcache\\-=
loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\000100%\000\000\000\000=
001"
-/* offset=3D134026 */
+/* offset=3D134810 */
 "llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-loads\000llc_mis=
s_rate > 0.05\000LLC miss rate\000\000100%\000\000\000\000001"
-/* offset=3D134127 */
+/* offset=3D134911 */
 "l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / L1\\-icache\\-=
loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\000100%\000\000\000\0000=
01"
-/* offset=3D134242 */
+/* offset=3D135026 */
 "dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\-loads\000dtlb=
_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\000\000\000001"
-/* offset=3D134348 */
+/* offset=3D135132 */
 "itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\-loads\000itlb=
_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\000\000\000001"
-/* offset=3D134454 */
+/* offset=3D135238 */
 "l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch\\-misses / L1=
\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.05\000L1 prefetch miss =
rate\000\000100%\000\000\000\000001"
-/* offset=3D134602 */
+/* offset=3D135386 */
 "CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000"
-/* offset=3D134625 */
+/* offset=3D135409 */
 "IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\000\0=
00\000\000\000\000000"
-/* offset=3D134689 */
+/* offset=3D135473 */
 "Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_unh=
alted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalt=
ed.ref_xclk)))\000\000\000\000\000\000\000\000000"
-/* offset=3D134856 */
+/* offset=3D135640 */
 "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\00=
0\000\000\000\000\000000"
-/* offset=3D134921 */
+/* offset=3D135705 */
 "icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000=
\000\000\000\000\000\000000"
-/* offset=3D134989 */
+/* offset=3D135773 */
 "cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\0=
00\000\000\000\000\000\000000"
-/* offset=3D135061 */
+/* offset=3D135845 */
 "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit +=
 l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000"
-/* offset=3D135156 */
+/* offset=3D135940 */
 "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.dema=
nd_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\000\000\000\0=
00\000\000\000000"
-/* offset=3D135291 */
+/* offset=3D136075 */
 "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\000\=
000\000\000\000\000000"
-/* offset=3D135356 */
+/* offset=3D136140 */
 "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\000\=
000\000\000\000\000\000000"
-/* offset=3D135425 */
+/* offset=3D136209 */
 "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000\00=
0\000\000\000\000\000\000000"
-/* offset=3D135496 */
+/* offset=3D136280 */
 "M1\000\000ipc + M2\000\000\000\000\000\000\000\000000"
-/* offset=3D135519 */
+/* offset=3D136303 */
 "M2\000\000ipc + M1\000\000\000\000\000\000\000\000000"
-/* offset=3D135542 */
+/* offset=3D136326 */
 "M3\000\0001 / M3\000\000\000\000\000\000\000\000000"
-/* offset=3D135563 */
+/* offset=3D136347 */
 "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\000\0=
00\000\000\000\000\000\000000"
 ;
=20
@@ -5336,6 +5352,22 @@ static const struct compact_pmu_event pmu_events__co=
mmon_tool[] =3D {
 	{ 125728 },
 	/* num_packages\000tool\000Number of packages. Each package has 1 or more=
 die\000co... */
 	{ 125804 },
+	/* schedstat_runtime\000tool\000Sum of all time spent running by tasks on=
 this proc... */
+	{ 130559 },
+	/* schedstat_schedule\000tool\000Number of times schedule() was called\00=
0config=3D0x... */
+	{ 130178 },
+	/* schedstat_schedule_idle\000tool\000Number of times schedule() left the=
 processor... */
+	{ 130260 },
+	/* schedstat_timeslices\000tool\000Number of timeslices run on this cpu\0=
00config=3D0... */
+	{ 130797 },
+	/* schedstat_wait\000tool\000Sum of all time spent waiting to run by task=
s on this ... */
+	{ 130676 },
+	/* schedstat_wake\000tool\000Number of times try_to_wake_up() was called\=
000config=3D... */
+	{ 130360 },
+	/* schedstat_wake_local\000tool\000Number of times try_to_wake_up() was c=
alled to w... */
+	{ 130444 },
+	/* schedstat_yield\000tool\000Number of times sched_yield() was called\00=
0config=3D0x... */
+	{ 130096 },
 	/* slots\000tool\000Number of functional units that in parallel can execu=
te parts o... */
 	{ 125890 },
 	/* smt_on\000tool\0001 if simultaneous multithreading (aka hyperthreading=
) is enabl... */
@@ -5371,39 +5403,39 @@ static const struct pmu_table_entry pmu_events__com=
mon[] =3D {
=20
 static const struct compact_pmu_event pmu_metrics__common_default_core[] =
=3D {
 	/* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=3Dcpu\\-clo=
ck@ if #targ... */
-	{ 131649 },
+	{ 132433 },
 	/* backend_cycles_idle\000Default\000(stalled\\-cycles\\-backend / cpu\\-=
cycles if ... */
-	{ 133276 },
+	{ 134060 },
 	/* branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name=
\\=3Dcpu\\-c... */
-	{ 133626 },
+	{ 134410 },
 	/* branch_miss_rate\000Default\000branch\\-misses / branches\000branch_mi=
ss_rate > ... */
-	{ 133806 },
+	{ 134590 },
 	/* cs_per_second\000Default\000software@context\\-switches\\,name\\=3Dcon=
text\\-switc... */
-	{ 131835 },
+	{ 132619 },
 	/* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,=
name\\=3Dcpu... */
-	{ 133450 },
+	{ 134234 },
 	/* dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\-loads\000d=
tlb_miss_r... */
-	{ 134242 },
+	{ 135026 },
 	/* frontend_cycles_idle\000Default\000(stalled\\-cycles\\-frontend / cpu\=
\-cycles i... */
-	{ 133097 },
+	{ 133881 },
 	/* insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_c=
ycle < 1\0... */
-	{ 132559 },
+	{ 133343 },
 	/* itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\-loads\000i=
tlb_miss_r... */
-	{ 134348 },
+	{ 135132 },
 	/* l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch\\-misses /=
 L1\\-dcac... */
-	{ 134454 },
+	{ 135238 },
 	/* l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / L1\\-dcache=
\\-loads\0... */
-	{ 133910 },
+	{ 134694 },
 	/* l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / L1\\-icache=
\\-loads\0... */
-	{ 134127 },
+	{ 134911 },
 	/* llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-loads\000llc_=
miss_rate ... */
-	{ 134026 },
+	{ 134810 },
 	/* migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=
=3Dcpu\\-mig... */
-	{ 132068 },
+	{ 132852 },
 	/* page_faults_per_second\000Default\000software@page\\-faults\\,name\\=
=3Dpage\\-faul... */
-	{ 132328 },
+	{ 133112 },
 	/* stalled_cycles_per_instruction\000Default\000(max(stalled\\-cycles\\-f=
rontend, s... */
-	{ 132672 },
+	{ 133456 },
=20
 };
=20
@@ -5417,41 +5449,41 @@ static const struct pmu_table_entry pmu_metrics__co=
mmon[] =3D {
=20
 static const struct compact_pmu_event pmu_events__test_soc_cpu_default_cor=
e[] =3D {
 	/* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=3D0x8a\000\0=
0000\000\000... */
-	{ 130096 },
+	{ 130880 },
 	/* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=3D0x8b\000\0=
0000\000\000... */
-	{ 130158 },
+	{ 130942 },
 	/* dispatch_blocked.any\000other\000Memory cluster signals to block micro=
-op dispat... */
-	{ 130420 },
+	{ 131204 },
 	/* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technolog=
y (EIST) t... */
-	{ 130553 },
+	{ 131337 },
 	/* l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x40\000\0000=
0\000\000\00... */
-	{ 130220 },
+	{ 131004 },
 	/* segment_reg_loads.any\000other\000Number of segment register loads\000=
event=3D6,pe... */
-	{ 130318 },
+	{ 131102 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_d=
drc[] =3D {
 	/* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=
=3D2\000\00000... */
-	{ 130686 },
+	{ 131470 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_l=
3c[] =3D {
 	/* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000event=3D7=
\000\00000\0... */
-	{ 131048 },
+	{ 131832 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_cbox=
[] =3D {
 	/* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\000\00000\000=
\000\000\000... */
-	{ 130922 },
+	{ 131706 },
 	/* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc0\000\00000=
\000\000\000... */
-	{ 130976 },
+	{ 131760 },
 	/* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core snoop re=
sulted fro... */
-	{ 130768 },
+	{ 131552 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc[=
] =3D {
 	/* uncore_imc.cache_hits\000uncore\000Total cache hits\000event=3D0x34\00=
0\00000\000\... */
-	{ 131231 },
+	{ 132015 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc_=
free_running[] =3D {
 	/* uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000=
event=3D0x12... */
-	{ 131140 },
+	{ 131924 },
=20
 };
=20
@@ -5464,61 +5496,61 @@ static const struct pmu_table_entry pmu_events__tes=
t_soc_cpu[] =3D {
 	{
 		.entries =3D pmu_events__test_soc_cpu_hisi_sccl_ddrc,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_ddrc),
-		.pmu_name =3D { 130671 /* hisi_sccl,ddrc\000 */ },
+		.pmu_name =3D { 131455 /* hisi_sccl,ddrc\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_cpu_hisi_sccl_l3c,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_l3c),
-		.pmu_name =3D { 131034 /* hisi_sccl,l3c\000 */ },
+		.pmu_name =3D { 131818 /* hisi_sccl,l3c\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_cpu_uncore_cbox,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_cbox),
-		.pmu_name =3D { 130756 /* uncore_cbox\000 */ },
+		.pmu_name =3D { 131540 /* uncore_cbox\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_cpu_uncore_imc,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc),
-		.pmu_name =3D { 131220 /* uncore_imc\000 */ },
+		.pmu_name =3D { 132004 /* uncore_imc\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_cpu_uncore_imc_free_running,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc_free_run=
ning),
-		.pmu_name =3D { 131116 /* uncore_imc_free_running\000 */ },
+		.pmu_name =3D { 131900 /* uncore_imc_free_running\000 */ },
 	},
 };
=20
 static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_co=
re[] =3D {
 	/* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
-	{ 134602 },
+	{ 135386 },
 	/* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\0=
00\000\000... */
-	{ 135291 },
+	{ 136075 },
 	/* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hi=
t + l2_rqs... */
-	{ 135061 },
+	{ 135845 },
 	/* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.d=
emand_data... */
-	{ 135156 },
+	{ 135940 },
 	/* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\0=
00\000\000... */
-	{ 135356 },
+	{ 136140 },
 	/* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000=
\000\000\0... */
-	{ 135425 },
+	{ 136209 },
 	/* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_=
unhalted.t... */
-	{ 134689 },
+	{ 135473 },
 	/* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\00=
0\000\000\... */
-	{ 134625 },
+	{ 135409 },
 	/* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\00=
0\000\000\... */
-	{ 135563 },
+	{ 136347 },
 	/* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
-	{ 135496 },
+	{ 136280 },
 	/* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
-	{ 135519 },
+	{ 136303 },
 	/* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
-	{ 135542 },
+	{ 136326 },
 	/* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\00=
0\000\000\... */
-	{ 134989 },
+	{ 135773 },
 	/* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000=
\000\000\0... */
-	{ 134856 },
+	{ 135640 },
 	/* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\=
000\000\00... */
-	{ 134921 },
+	{ 135705 },
=20
 };
=20
@@ -5532,15 +5564,15 @@ static const struct pmu_table_entry pmu_metrics__te=
st_soc_cpu[] =3D {
=20
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ccn_pmu[] =3D {
 	/* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=
=3D0x2c\0000x0... */
-	{ 131410 },
+	{ 132194 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
cmn_pmu[] =3D {
 	/* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in f=
irst looku... */
-	{ 131506 },
+	{ 132290 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ddr_pmu[] =3D {
 	/* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=
=3D0x2b\000v8... */
-	{ 131315 },
+	{ 132099 },
=20
 };
=20
@@ -5548,17 +5580,17 @@ static const struct pmu_table_entry pmu_events__tes=
t_soc_sys[] =3D {
 	{
 		.entries =3D pmu_events__test_soc_sys_uncore_sys_ccn_pmu,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ccn_pmu)=
,
-		.pmu_name =3D { 131391 /* uncore_sys_ccn_pmu\000 */ },
+		.pmu_name =3D { 132175 /* uncore_sys_ccn_pmu\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_sys_uncore_sys_cmn_pmu,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_cmn_pmu)=
,
-		.pmu_name =3D { 131487 /* uncore_sys_cmn_pmu\000 */ },
+		.pmu_name =3D { 132271 /* uncore_sys_cmn_pmu\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_sys_uncore_sys_ddr_pmu,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ddr_pmu)=
,
-		.pmu_name =3D { 131296 /* uncore_sys_ddr_pmu\000 */ },
+		.pmu_name =3D { 132080 /* uncore_sys_ddr_pmu\000 */ },
 	},
 };
=20
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 01753d5c69d1..f4560a0ec1db 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2830,5 +2830,7 @@ bool perf_pmu__reads_only_on_cpu_idx0(const struct pe=
rf_event_attr *attr)
 		return false;
=20
 	event =3D (enum tool_pmu_event)attr->config;
-	return event !=3D TOOL_PMU__EVENT_USER_TIME && event !=3D TOOL_PMU__EVENT=
_SYSTEM_TIME;
+	return event !=3D TOOL_PMU__EVENT_USER_TIME &&
+	       event !=3D TOOL_PMU__EVENT_SYSTEM_TIME &&
+	       !tool_pmu__is_sched_stat_event(event);
 }
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.=
c
index b337cc23f413..6671403c587c 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -929,9 +929,13 @@ static bool should_skip_zero_counter(struct perf_stat_=
config *config,
 	 * system_time, but for many the first index is the only one used, for
 	 * example num_cores. Don't skip for the first index.
 	 */
-	if (evsel__is_tool(counter)) {
+	if (evsel__is_tool(counter) &&
+	    (counter->core.reads_only_on_cpu_idx0 || counter->pid_stat)) {
+		struct perf_cpu first_cpu =3D perf_cpu_map__cpu(counter->core.cpus, 0);
 		struct aggr_cpu_id own_id =3D
-			config->aggr_get_id(config, (struct perf_cpu){ .cpu =3D 0 });
+			config->aggr_get_id(config,
+					    first_cpu.cpu >=3D 0 ? first_cpu
+							       : (struct perf_cpu){ .cpu =3D 0 });
=20
 		return !aggr_cpu_id__equal(id, &own_id);
 	}
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 655b22104320..b92aaf0d7671 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -84,6 +84,14 @@ static const char *const tool_pmu__event_names[TOOL_PMU_=
_EVENT_MAX] =3D {
 	"net_tx_colls",
 	"net_tx_carrier",
 	"net_tx_compressed",
+	"schedstat_yield",
+	"schedstat_schedule",
+	"schedstat_schedule_idle",
+	"schedstat_wake",
+	"schedstat_wake_local",
+	"schedstat_runtime",
+	"schedstat_wait",
+	"schedstat_timeslices",
 };
=20
 bool tool_pmu__skip_event(const char *name __maybe_unused)
@@ -205,6 +213,83 @@ static int read_stat_field(int fd, struct perf_cpu cpu=
, int field, __u64 *val)
 	return -EINVAL;
 }
=20
+bool tool_pmu__is_sched_stat_event(enum tool_pmu_event ev)
+{
+	return ev >=3D TOOL_PMU__EVENT_SCHEDSTAT_YIELD &&
+	       ev <=3D TOOL_PMU__EVENT_SCHEDSTAT_TIMESLICES;
+}
+
+static int sched_stat_event_to_field(enum tool_pmu_event ev)
+{
+	if (!tool_pmu__is_sched_stat_event(ev))
+		return -EINVAL;
+	if (ev =3D=3D TOOL_PMU__EVENT_SCHEDSTAT_YIELD)
+		return 1;
+	/* Field 2 is legacy 0 in /proc/schedstat v15+. */
+	return (ev - TOOL_PMU__EVENT_SCHEDSTAT_YIELD) + 2;
+}
+
+static int read_sched_stat(int fd, struct perf_cpu cpu, enum tool_pmu_even=
t ev, __u64 *val)
+{
+	int field =3D sched_stat_event_to_field(ev);
+	char buf[4096];
+	struct io io;
+	int ch;
+
+	if (field < 0)
+		return field;
+
+	io__init(&io, fd, buf, sizeof(buf));
+	lseek(fd, 0, SEEK_SET);
+
+	/* Search for "cpu<N> " */
+	while ((ch =3D io__get_char(&io)) !=3D -1) {
+		__u64 cpu_num;
+		int i =3D 1, c;
+
+		if (ch !=3D 'c') {
+			if (ch !=3D '\n')
+				read_until_char(&io, '\n');
+			continue;
+		}
+		c =3D io__get_char(&io);
+		if (c !=3D 'p') {
+			if (c !=3D '\n' && c !=3D -1)
+				read_until_char(&io, '\n');
+			continue;
+		}
+		c =3D io__get_char(&io);
+		if (c !=3D 'u') {
+			if (c !=3D '\n' && c !=3D -1)
+				read_until_char(&io, '\n');
+			continue;
+		}
+		c =3D io__get_dec(&io, &cpu_num);
+		if (c !=3D ' ' || (int)cpu_num !=3D cpu.cpu) {
+			if (c !=3D '\n' && c !=3D -1)
+				read_until_char(&io, '\n');
+			continue;
+		}
+
+		/* Found our CPU. Now read the field. */
+		while (true) {
+			__u64 v;
+			int sep =3D io__get_dec(&io, &v);
+
+			if (sep < 0)
+				return -EINVAL;
+			if (i =3D=3D field) {
+				*val =3D v;
+				return 0;
+			}
+			if (sep =3D=3D '\n')
+				return -EINVAL; /* Field not found on line */
+			i++;
+		}
+	}
+	return -EINVAL;
+}
+
 static int read_pid_stat_field(int fd, int field, __u64 *val)
 {
 	char buf[256];
@@ -303,6 +388,14 @@ static const char *tool_pmu__memory_event_to_key(enum =
tool_pmu_event ev)
 	case TOOL_PMU__EVENT_NET_TX_COLLS:
 	case TOOL_PMU__EVENT_NET_TX_CARRIER:
 	case TOOL_PMU__EVENT_NET_TX_COMPRESSED:
+	case TOOL_PMU__EVENT_SCHEDSTAT_YIELD:
+	case TOOL_PMU__EVENT_SCHEDSTAT_SCHEDULE:
+	case TOOL_PMU__EVENT_SCHEDSTAT_SCHEDULE_IDLE:
+	case TOOL_PMU__EVENT_SCHEDSTAT_WAKE:
+	case TOOL_PMU__EVENT_SCHEDSTAT_WAKE_LOCAL:
+	case TOOL_PMU__EVENT_SCHEDSTAT_RUNTIME:
+	case TOOL_PMU__EVENT_SCHEDSTAT_WAIT:
+	case TOOL_PMU__EVENT_SCHEDSTAT_TIMESLICES:
 	case TOOL_PMU__EVENT_DURATION_TIME:
 	case TOOL_PMU__EVENT_USER_TIME:
 	case TOOL_PMU__EVENT_SYSTEM_TIME:
@@ -477,7 +570,8 @@ static bool tool_pmu__has_start_times(enum tool_pmu_eve=
nt ev)
 {
 	return ev =3D=3D TOOL_PMU__EVENT_USER_TIME ||
 	       ev =3D=3D TOOL_PMU__EVENT_SYSTEM_TIME ||
-	       tool_pmu__is_net_event(ev);
+	       tool_pmu__is_net_event(ev) ||
+	       tool_pmu__is_sched_stat_event(ev);
 }
=20
 static int read_net_dev_col(struct io *io, __u64 *val, int *term)
@@ -609,6 +703,16 @@ static int tool_pmu__read_stat(struct evsel *evsel, in=
t cpu_map_idx, int thread,
 		return 0;
 	}
=20
+	if (tool_pmu__is_sched_stat_event(ev)) {
+		if (thread =3D=3D 0) {
+			struct perf_cpu cpu =3D perf_cpu_map__cpu(evsel->core.cpus, cpu_map_idx=
);
+
+			return read_sched_stat(fd, cpu, ev, val);
+		}
+		*val =3D 0;
+		return 0;
+	}
+
 	lseek(fd, 0, SEEK_SET);
 	if (evsel->pid_stat) {
 		if (cpu_map_idx =3D=3D 0)
@@ -702,6 +806,15 @@ static int evsel__tool_pmu_open_one(struct evsel *evse=
l, enum tool_pmu_event ev,
 				if (fd < 0)
 					return -errno;
 			}
+		} else if (tool_pmu__is_sched_stat_event(ev)) {
+			if (pid > -1 || evsel->cgrp)
+				return -EINVAL;
+			if (thread =3D=3D 0) {
+				snprintf(buf, sizeof(buf), "%s/schedstat", procfs__mountpoint());
+				fd =3D open(buf, O_RDONLY);
+				if (fd < 0)
+					return -errno;
+			}
 		} else {
 			if (pid > -1) {
 				snprintf(buf, sizeof(buf), "%s/%d/stat", procfs__mountpoint(), pid);
@@ -1005,6 +1118,14 @@ bool tool_pmu__read_event(enum tool_pmu_event ev,
 	case TOOL_PMU__EVENT_NET_TX_COLLS:
 	case TOOL_PMU__EVENT_NET_TX_CARRIER:
 	case TOOL_PMU__EVENT_NET_TX_COMPRESSED:
+	case TOOL_PMU__EVENT_SCHEDSTAT_YIELD:
+	case TOOL_PMU__EVENT_SCHEDSTAT_SCHEDULE:
+	case TOOL_PMU__EVENT_SCHEDSTAT_SCHEDULE_IDLE:
+	case TOOL_PMU__EVENT_SCHEDSTAT_WAKE:
+	case TOOL_PMU__EVENT_SCHEDSTAT_WAKE_LOCAL:
+	case TOOL_PMU__EVENT_SCHEDSTAT_RUNTIME:
+	case TOOL_PMU__EVENT_SCHEDSTAT_WAIT:
+	case TOOL_PMU__EVENT_SCHEDSTAT_TIMESLICES:
 	case TOOL_PMU__EVENT_NONE:
 	case TOOL_PMU__EVENT_DURATION_TIME:
 	case TOOL_PMU__EVENT_USER_TIME:
@@ -1261,7 +1382,15 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cp=
u_map_idx, int thread)
 	case TOOL_PMU__EVENT_NET_TX_FIFO:
 	case TOOL_PMU__EVENT_NET_TX_COLLS:
 	case TOOL_PMU__EVENT_NET_TX_CARRIER:
-	case TOOL_PMU__EVENT_NET_TX_COMPRESSED: {
+	case TOOL_PMU__EVENT_NET_TX_COMPRESSED:
+	case TOOL_PMU__EVENT_SCHEDSTAT_YIELD:
+	case TOOL_PMU__EVENT_SCHEDSTAT_SCHEDULE:
+	case TOOL_PMU__EVENT_SCHEDSTAT_SCHEDULE_IDLE:
+	case TOOL_PMU__EVENT_SCHEDSTAT_WAKE:
+	case TOOL_PMU__EVENT_SCHEDSTAT_WAKE_LOCAL:
+	case TOOL_PMU__EVENT_SCHEDSTAT_RUNTIME:
+	case TOOL_PMU__EVENT_SCHEDSTAT_WAIT:
+	case TOOL_PMU__EVENT_SCHEDSTAT_TIMESLICES: {
 		__u64 *accumulated_ptr =3D evsel->process_time.accumulated_times ?
 			xyarray__entry(evsel->process_time.accumulated_times, cpu_map_idx, thre=
ad) :
 			NULL;
diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
index f972995bb8ed..5a290a9e7555 100644
--- a/tools/perf/util/tool_pmu.h
+++ b/tools/perf/util/tool_pmu.h
@@ -66,6 +66,14 @@ enum tool_pmu_event {
 	TOOL_PMU__EVENT_NET_TX_COLLS,
 	TOOL_PMU__EVENT_NET_TX_CARRIER,
 	TOOL_PMU__EVENT_NET_TX_COMPRESSED,
+	TOOL_PMU__EVENT_SCHEDSTAT_YIELD,
+	TOOL_PMU__EVENT_SCHEDSTAT_SCHEDULE,
+	TOOL_PMU__EVENT_SCHEDSTAT_SCHEDULE_IDLE,
+	TOOL_PMU__EVENT_SCHEDSTAT_WAKE,
+	TOOL_PMU__EVENT_SCHEDSTAT_WAKE_LOCAL,
+	TOOL_PMU__EVENT_SCHEDSTAT_RUNTIME,
+	TOOL_PMU__EVENT_SCHEDSTAT_WAIT,
+	TOOL_PMU__EVENT_SCHEDSTAT_TIMESLICES,
=20
 	TOOL_PMU__EVENT_MAX,
 };
@@ -77,6 +85,7 @@ const char *tool_pmu__event_to_str(enum tool_pmu_event ev=
);
 enum tool_pmu_event tool_pmu__str_to_event(const char *str);
 bool tool_pmu__skip_event(const char *name);
 int tool_pmu__num_skip_events(void);
+bool tool_pmu__is_sched_stat_event(enum tool_pmu_event ev);
=20
 bool tool_pmu__read_event(enum tool_pmu_event ev,
 			  struct evsel *evsel,
--=20
2.56.1.703.gf848ed807c-goog

