Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197528;
	b=iujL8DUou8k7jjYqiXT6HQZIywTTGaK2R4n35rv/uEW7YlxGD1lIeNuDKLUYRsEKgOGc
	 Ri4ejqyHLFiLHkM1Y61Ps52LecmmICoBmwwOtJcFKfoD2lQ0wVf1SmRNgI2roLG1Qa9BF
	 jUb6/2e8mPLyal8k5o0Dkmu4wAfgjv55YJZemKqLnplrLPFuOWoF+9sA1+txB/GN9qFPa
	 yDXd38T4bvafT97gMnPEgAQMH4PdF7bIF/5JXVAF2TNVttg/lBP/lKFJRjtgYQBWGZvLb
	 ml4skOX3rr+6R39J7PGU+Kkpvf09c3RxrwSEzPnHnGoRtrEkCRBr/iWuJd1i1atQoJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LOjQxW1G7cSzUMyn+C9AV/q1L1OOwhexXt96P8+m4ro=;
	b=qMf/gTXacJzEPaZ26nTkmBbrrUygrUIc9y0yOsX2xufo7firEOZgJMg7TUbItEgZcAN5
	 /nw9xepkF0Zzq9sQJimPr0OnX0RpKd+C7SObRHdG7b/3PvAEcvVjRfIlMRomLPTIaUPE/
	 LbDf3RPQXb6zxon/cfq37yGy4uYHfAQf0Sg/amqa+NnBVIwmhkpFhS+RAdEu2uBD3CwrR
	 vqXWGUUvBbAweAA643hlIkPiJS2J+4qCO5HnVFWZTDEl2irlNqMAsEJdUq5zZ0ThtciQ7
	 Or62mkPPhK0lfZCdG/1v1fW1jlF48d9C9r3PlW8tp+VHSRwEZrjo5pj9zNXT5SKznew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WiYB0nwO;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8918606A33B
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 17:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8918606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WiYB0nwO
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1ae58d17cd9so1210207c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 09:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795197527; x=1795802327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LOjQxW1G7cSzUMyn+C9AV/q1L1OOwhexXt96P8+m4ro=;
        b=WiYB0nwOWjEbGrEV2ayKQzIVq/byUMiIBQCAnlJSJeGH75HjHisD3K6Wdt4UDl/qxv
         4NSGGV+tndpGR2PaCqICs4MfzUl5C/K7lns90T10NFsDtdcLbODwRg3hbBZOKk+hkQkY
         oNkptdeuFAepoetLZ2wux/YPBNAQ8oLoOyi41z/SWFHUwUOTG7snkoCsr/hdn7KDVl/g
         +m85Q+V2iyOPSbuSZdx3Wf6kqN8k6pPVeDel0o2II5qZEE7BZaf3+2dFaCfPh3LPxuKx
         9mgq3m0SpmyP9bMXcmXvOjrRYrg+Zr5l1NpqnG9Voe0QgXDzVEH67tmZqdV1P6huMuzV
         rqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795197527; x=1795802327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LOjQxW1G7cSzUMyn+C9AV/q1L1OOwhexXt96P8+m4ro=;
        b=gM3v5ASk6aQzlVWnk7tnuSx1vu75XNCccUHMHI7HBo5Dqy4glRDAr8FiB4R6gx9qXN
         66WUApXLqVKVR2gRli6DkyoZNyIh3Ix3VM/KvoWxxz3JHd28OsHnI0lj9OnQ1BIELkFl
         PoViT+oSyd7bQSqPeD8h54omsAUq5mUup7TAYceQKzt1U28XkCyz96jFguNrWyk9mawm
         lcbyDu3QqAVFyj4ObFMq2bzorUQAiE2spEgKeda3vvN0oZAZ2tbRAHHII/Ywrx/JWAm+
         UwswFs8wnHC7FGg/m8unTj6LQESpLn6QGYHLDQKn+T1U6iFuqVvP94tahO8N75OSGxF7
         uLpw==
X-Gm-Message-State: APuU4Z/VIXqN+ZloVoeYjF9eNKnA0MYXkpev1JJY2peQ3Wmg7xAqFgBM
	Qb0CVJdOk6R7GQkE+9UpH27hIji/acHc+96Imscl0aeY58IZWJrgnZjJUaX9waz/
X-Gm-Gg: AYBFou2DpS8/JG5tyZ5k3xIjNIlPAMrLwywd9dVbH93ZP3dUT3PILINYdTumCw4wCGx
	N+FtUGRxEYJk7AVZNekNfHwfClLfIsP01aDRF6qd1aC20QJhe4Gn2g9QmHDiifJKS5ifjuk0gjO
	6JXEWFKQRice3BA23D2e32Na8RW7ypAT7mqxjZE1e19B7xI2ud9Cc8hKk7KJTP5oF2FbvhMaOhX
	Y65dxC+0Ym3ugZxnS84XIXAYqk7bBEs74yCCniejfBZlIJs4DdUJGJAs4+M4ddsFbmnL2/G2mbS
	X8aHfZ9XRgKgq3i/TVfHoFwOjClq3By6DlqRjtvLy/h3AdLHwZYNX/MCv4z63y8CqCFtAcH0rFm
	c8Uh/zWO7viOysoDiLXoHkw4DzAStAsjzsvoqPAXCwMrDsZtbHgFWDu9J8F0OQbrr09HD9nwrlS
	e2f+Y7MFAlbJkLBVgyQOo4+/PNknxH0yv3x/VmrJk6a9bDoytASqWwWCMouWv+eTkMlx+C6wYtp
	jizkhDMyT37K2txTiAsKAjNLNCrLh3S/taKCHs+NpJelMcGl1Si3LT82kxAf1zHjMiJfZ6Tzsj9
	5rB1fpro9OJE/cogNpfK
X-Received: by 2002:a05:7023:a5b:20b0:191:a5b2:ef4a with SMTP id a92af1059eb24-1b5568b9f5dmr3304324c88.28.1795197526703;
        Fri, 20 Nov 2026 09:58:46 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b562a82b3fsm681084c88.5.2026.11.20.09.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 09:58:46 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH 1/3] perf vendor events powerpc: Fix misspellings in the power tables
Date: Fri, 20 Nov 2026 17:58:38 +0000
Message-ID: <20261120175840.1274637-2-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120175840.1274637-1-takano32@gmail.com>
References: <20261120175840.1274637-1-takano32@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thirty-two different words are wrong, 69 times in all, in 54 descriptions
of the power8, power9 and power10 tables.  Fifteen of them appear more
than once: "than than" and "thee" eight times each, "exceed" five times,
"cyles", "finshed" and "cant" four times each, "software.Fuzzy" three
times, and "coverted", "repoted", "Fetchs", "whtver", "Micrpartition",
"dmand", "invalidat" and "tread" twice each; the other seventeen appear
once.

62 of the 69 are in BriefDescription fields and seven in PublicDescription
fields, so `perf list` prints those 62 and `perf list -v` prints those
seven.  Eleven of the 62 are metric descriptions, printed by `perf list
metric`.

Sixteen of the 69 are not misspellings: eight are a doubled "than", four
are missing spaces ("touchto" in "touch to L3", and "software.Fuzzy" in
"software. Fuzzy" three times), and four are "cant" without its
apostrophe.

One more description in power8/other.json has a space inside each of two
words ("Group experi enced Non-specu lative I cache miss"); a sibling
description above it spells them "experienced non-speculative", so the two
words are joined as well.  Fifty-five descriptions change in total.

Only the descriptions change.  Regenerating the tables with

  jevents.py powerpc all tools/perf/pmu-events/arch out.c out-str.c

leaves every event name and event code untouched, and the misspellings are
gone from the generated out-str.c, which shrinks by 393 bytes as some
corrected descriptions become identical to ones already stored for other
models.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 .../arch/powerpc/power10/metrics.json         |  8 ++--
 .../pmu-events/arch/powerpc/power8/cache.json |  2 +-
 .../arch/powerpc/power8/memory.json           |  2 +-
 .../arch/powerpc/power8/metrics.json          |  8 ++--
 .../pmu-events/arch/powerpc/power8/other.json | 38 +++++++++----------
 .../arch/powerpc/power8/pipeline.json         |  4 +-
 .../pmu-events/arch/powerpc/power8/pmc.json   |  4 +-
 .../pmu-events/arch/powerpc/power9/cache.json |  2 +-
 .../arch/powerpc/power9/frontend.json         |  2 +-
 .../arch/powerpc/power9/marked.json           |  4 +-
 .../arch/powerpc/power9/metrics.json          |  6 +--
 .../pmu-events/arch/powerpc/power9/other.json | 28 +++++++-------
 .../arch/powerpc/power9/translation.json      |  2 +-
 13 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power10/metrics.json b/tools/perf/pmu-events/arch/powerpc/power10/metrics.json
index a36621858ea3..0830eba7769b 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/metrics.json
@@ -755,25 +755,25 @@
         "MetricName": "TLBIE_PER_INST"
     },
     {
-        "BriefDescription": "Average number of STCX instructions finshed per completed instruction",
+        "BriefDescription": "Average number of STCX instructions finished per completed instruction",
         "MetricExpr": "PM_STCX_FIN / PM_RUN_INST_CMPL",
         "MetricGroup": "General",
         "MetricName": "STCX_PER_INST"
     },
     {
-        "BriefDescription": "Average number of LARX instructions finshed per completed instruction",
+        "BriefDescription": "Average number of LARX instructions finished per completed instruction",
         "MetricExpr": "PM_LARX_FIN / PM_RUN_INST_CMPL",
         "MetricGroup": "General",
         "MetricName": "LARX_PER_INST"
     },
     {
-        "BriefDescription": "Average number of PTESYNC instructions finshed per completed instruction",
+        "BriefDescription": "Average number of PTESYNC instructions finished per completed instruction",
         "MetricExpr": "PM_PTESYNC_FIN / PM_RUN_INST_CMPL",
         "MetricGroup": "General",
         "MetricName": "PTESYNC_PER_INST"
     },
     {
-        "BriefDescription": "Average number of simple fixed-point instructions finshed in the store unit per completed instruction",
+        "BriefDescription": "Average number of simple fixed-point instructions finished in the store unit per completed instruction",
         "MetricExpr": "PM_FX_LSU_FIN / PM_RUN_INST_CMPL",
         "MetricGroup": "General",
         "MetricName": "FX_PER_INST"
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/cache.json b/tools/perf/pmu-events/arch/powerpc/power8/cache.json
index 05a17084d939..c5907a51b897 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/cache.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/cache.json
@@ -128,7 +128,7 @@
   {
     "EventCode": "0x3001a",
     "EventName": "PM_DATA_TABLEWALK_CYC",
-    "BriefDescription": "Tablwalk Cycles (could be 1 or 2 active)",
+    "BriefDescription": "Tablewalk Cycles (could be 1 or 2 active)",
     "PublicDescription": "Data Tablewalk Active"
   },
   {
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/memory.json b/tools/perf/pmu-events/arch/powerpc/power8/memory.json
index 2ba33420e20d..1d8241b8dc57 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/memory.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/memory.json
@@ -152,7 +152,7 @@
   {
     "EventCode": "0x1c05e",
     "EventName": "PM_MEM_LOC_THRESH_LSU_MED",
-    "BriefDescription": "Local memory above theshold for data prefetch",
+    "BriefDescription": "Local memory above threshold for data prefetch",
     "PublicDescription": ""
   },
   {
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
index 4e25525b7da6..e5f9dbf199ac 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
@@ -30,7 +30,7 @@
         "MetricName": "ccache_mispredict_rate_percent"
     },
     {
-        "BriefDescription": "Percent of count catch mispredictions out of all completed branches that required count cache predictionn",
+        "BriefDescription": "Percent of count cache mispredictions out of all completed branches that required count cache prediction",
         "MetricExpr": "PM_BR_MPRED_CCACHE / (PM_BR_PRED_CCACHE_BR0 + PM_BR_PRED_CCACHE_BR1) * 100",
         "MetricGroup": "branch_prediction",
         "MetricName": "ccache_misprediction_percent"
@@ -969,7 +969,7 @@
         "MetricName": "l2_inst_miss_rate_percent"
     },
     {
-        "BriefDescription": "L2 dmand  Load Miss Rate (per run instruction)(%)",
+        "BriefDescription": "L2 demand  Load Miss Rate (per run instruction)(%)",
         "MetricExpr": "PM_DATA_FROM_L2MISS * 100 / PM_RUN_INST_CMPL",
         "MetricGroup": "general",
         "MetricName": "l2_ld_miss_rate_percent"
@@ -1215,7 +1215,7 @@
         "MetricName": "stores_per_inst"
     },
     {
-        "BriefDescription": "Icache Fetchs per Icache Miss",
+        "BriefDescription": "Icache Fetches per Icache Miss",
         "MetricExpr": "(PM_L1_ICACHE_MISS - PM_IC_PREF_WRITE) / PM_L1_ICACHE_MISS",
         "MetricGroup": "instruction_stats_percent_per_ref",
         "MetricName": "icache_miss_reload"
@@ -2003,7 +2003,7 @@
         "MetricName": "expansion_overhead_cpi"
     },
     {
-        "BriefDescription": "Total Fixed point operations executded in the Load/Store Unit following a load/store operation",
+        "BriefDescription": "Total Fixed point operations executed in the Load/Store Unit following a load/store operation",
         "MetricExpr": "PM_LSU_FX_FIN/PM_RUN_INST_CMPL",
         "MetricName": "fixed_in_lsu_per_inst"
     },
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/other.json b/tools/perf/pmu-events/arch/powerpc/power8/other.json
index f1f2965f6775..6fef23e40658 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/other.json
@@ -212,13 +212,13 @@
   {
     "EventCode": "0x40a0",
     "EventName": "PM_BR_UNCOND_BR0",
-    "BriefDescription": "Unconditional Branch Completed on BR0. HW branch prediction was not used for this branch. This can be an I-form branch, a B-form branch with BO-field set to branch always, or a B-form branch which was coverted to a Resolve",
+    "BriefDescription": "Unconditional Branch Completed on BR0. HW branch prediction was not used for this branch. This can be an I-form branch, a B-form branch with BO-field set to branch always, or a B-form branch which was converted to a Resolve",
     "PublicDescription": ""
   },
   {
     "EventCode": "0x40a2",
     "EventName": "PM_BR_UNCOND_BR1",
-    "BriefDescription": "Unconditional Branch Completed on BR1. HW branch prediction was not used for this branch. This can be an I-form branch, a B-form branch with BO-field set to branch always, or a B-form branch which was coverted to a Resolve",
+    "BriefDescription": "Unconditional Branch Completed on BR1. HW branch prediction was not used for this branch. This can be an I-form branch, a B-form branch with BO-field set to branch always, or a B-form branch which was converted to a Resolve",
     "PublicDescription": ""
   },
   {
@@ -656,7 +656,7 @@
   {
     "EventCode": "0x4e050",
     "EventName": "PM_DC_PREF_STREAM_FUZZY_CONF",
-    "BriefDescription": "A demand load referenced a line in an active fuzzy prefetch stream. The stream could have been allocated through the hardware prefetch mechanism or through software.Fuzzy stream confirm (out of order effects, or pf cant keep up)",
+    "BriefDescription": "A demand load referenced a line in an active fuzzy prefetch stream. The stream could have been allocated through the hardware prefetch mechanism or through software. Fuzzy stream confirm (out of order effects, or pf can't keep up)",
     "PublicDescription": ""
   },
   {
@@ -1095,7 +1095,7 @@
     "EventCode": "0x1000a",
     "EventName": "PM_GRP_BR_MPRED_NONSPEC",
     "BriefDescription": "Group experienced non-speculative branch redirect",
-    "PublicDescription": "Group experienced Non-speculative br mispredicct"
+    "PublicDescription": "Group experienced Non-speculative br mispredict"
   },
   {
     "EventCode": "0x30004",
@@ -1113,7 +1113,7 @@
     "EventCode": "0x1000c",
     "EventName": "PM_GRP_IC_MISS_NONSPEC",
     "BriefDescription": "Group experienced non-speculative I cache miss",
-    "PublicDescription": "Group experi enced Non-specu lative I cache miss"
+    "PublicDescription": "Group experienced Non-speculative I cache miss"
   },
   {
     "EventCode": "0x10130",
@@ -1136,7 +1136,7 @@
   {
     "EventCode": "0x50a6",
     "EventName": "PM_GRP_TERM_FPU_AFTER_BR",
-    "BriefDescription": "There were enough instructions in the Ibuffer, but FPU OP IN same group after a branch terminates a group, cant do partial flushes",
+    "BriefDescription": "There were enough instructions in the Ibuffer, but FPU OP IN same group after a branch terminates a group, can't do partial flushes",
     "PublicDescription": ""
   },
   {
@@ -1220,7 +1220,7 @@
   {
     "EventCode": "0x4096",
     "EventName": "PM_IC_RELOAD_PRIVATE",
-    "BriefDescription": "Reloading line was brought in private for a specific thread. Most lines are brought in shared for all eight thrreads. If RA does not match then invalidates and then brings it shared to other thread. In P7 line brought in private , then line was invalidat",
+    "BriefDescription": "Reloading line was brought in private for a specific thread. Most lines are brought in shared for all eight threads. If RA does not match then invalidates and then brings it shared to other thread. In P7 line brought in private , then line was invalidated",
     "PublicDescription": ""
   },
   {
@@ -1664,25 +1664,25 @@
   {
     "EventCode": "0x200301ea",
     "EventName": "PM_L1MISS_LAT_EXC_1024",
-    "BriefDescription": "L1 misses that took longer than 1024 cyles to resolve (miss to reload)",
+    "BriefDescription": "L1 misses that took longer than 1024 cycles to resolve (miss to reload)",
     "PublicDescription": "Reload latency exceeded 1024 cyc"
   },
   {
     "EventCode": "0x200401ec",
     "EventName": "PM_L1MISS_LAT_EXC_2048",
-    "BriefDescription": "L1 misses that took longer than 2048 cyles to resolve (miss to reload)",
+    "BriefDescription": "L1 misses that took longer than 2048 cycles to resolve (miss to reload)",
     "PublicDescription": "Reload latency exceeded 2048 cyc"
   },
   {
     "EventCode": "0x200101e8",
     "EventName": "PM_L1MISS_LAT_EXC_256",
-    "BriefDescription": "L1 misses that took longer than 256 cyles to resolve (miss to reload)",
+    "BriefDescription": "L1 misses that took longer than 256 cycles to resolve (miss to reload)",
     "PublicDescription": "Reload latency exceeded 256 cyc"
   },
   {
     "EventCode": "0x200201e6",
     "EventName": "PM_L1MISS_LAT_EXC_32",
-    "BriefDescription": "L1 misses that took longer than 32 cyles to resolve (miss to reload)",
+    "BriefDescription": "L1 misses that took longer than 32 cycles to resolve (miss to reload)",
     "PublicDescription": "Reload latency exceeded 32 cyc"
   },
   {
@@ -1694,7 +1694,7 @@
   {
     "EventCode": "0x408c",
     "EventName": "PM_L1_DEMAND_WRITE",
-    "BriefDescription": "Instruction Demand sectors wriittent into IL1",
+    "BriefDescription": "Instruction Demand sectors written into IL1",
     "PublicDescription": ""
   },
   {
@@ -1874,7 +1874,7 @@
   {
     "EventCode": "0x3e052",
     "EventName": "PM_L3_SW_PREF",
-    "BriefDescription": "Data stream touchto L3",
+    "BriefDescription": "Data stream touch to L3",
     "PublicDescription": ""
   },
   {
@@ -2793,7 +2793,7 @@
     "EventCode": "0x2001a",
     "EventName": "PM_NTCG_ALL_FIN",
     "BriefDescription": "Cycles after all instructions have finished to group completed",
-    "PublicDescription": "Ccycles after all instructions have finished to group completed"
+    "PublicDescription": "Cycles after all instructions have finished to group completed"
   },
   {
     "EventCode": "0x20ac",
@@ -2877,7 +2877,7 @@
     "EventCode": "0x200101e8",
     "EventName": "PM_RC_LIFETIME_EXC_256",
     "BriefDescription": "Number of times the RC machine for a sampled instruction was active for more than 256 cycles",
-    "PublicDescription": "Threshold counter exceed a count of 256"
+    "PublicDescription": "Threshold counter exceeded a count of 256"
   },
   {
     "EventCode": "0x200201e6",
@@ -3092,8 +3092,8 @@
   {
     "EventCode": "0xe0b8",
     "EventName": "PM_TM_FAIL_NON_TX_CONFLICT",
-    "BriefDescription": "Non transactional conflict from LSU whtver gets repoted to texas",
-    "PublicDescription": "Non transactional conflict from LSU whtver gets repoted to texas42"
+    "BriefDescription": "Non transactional conflict from LSU whatever gets reported to texas",
+    "PublicDescription": "Non transactional conflict from LSU whatever gets reported to texas42"
   },
   {
     "EventCode": "0x308a",
@@ -3140,8 +3140,8 @@
   {
     "EventCode": "0xe08e",
     "EventName": "PM_UP_PREF_POINTER",
-    "BriefDescription": "Micrpartition pointer prefetches",
-    "PublicDescription": "Micrpartition pointer prefetches42"
+    "BriefDescription": "Micropartition pointer prefetches",
+    "PublicDescription": "Micropartition pointer prefetches42"
   },
   {
     "EventCode": "0xa0a4",
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/pipeline.json b/tools/perf/pmu-events/arch/powerpc/power8/pipeline.json
index 0acfaaef4772..12689e8fb0b5 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/pipeline.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/pipeline.json
@@ -116,7 +116,7 @@
   {
     "EventCode": "0x30006",
     "EventName": "PM_CMPLU_STALL_OTHER_CMPL",
-    "BriefDescription": "Instructions core completed while this tread was stalled",
+    "BriefDescription": "Instructions core completed while this thread was stalled",
     "PublicDescription": "Instructions core completed while this thread was stalled"
   },
   {
@@ -189,7 +189,7 @@
     "EventCode": "0x3405e",
     "EventName": "PM_IFETCH_THROTTLE",
     "BriefDescription": "Cycles in which Instruction fetch throttle was active",
-    "PublicDescription": "Cycles instruction fecth was throttled in IFU"
+    "PublicDescription": "Cycles instruction fetch was throttled in IFU"
   },
   {
     "EventCode": "0x10014",
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/pmc.json b/tools/perf/pmu-events/arch/powerpc/power8/pmc.json
index 5e0469f68bea..4e416878417d 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/pmc.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/pmc.json
@@ -98,7 +98,7 @@
   {
     "EventCode": "0x101e8",
     "EventName": "PM_THRESH_EXC_256",
-    "BriefDescription": "Threshold counter exceed a count of 256",
+    "BriefDescription": "Threshold counter exceeded a count of 256",
     "PublicDescription": ""
   },
   {
@@ -110,7 +110,7 @@
   {
     "EventCode": "0x101e6",
     "EventName": "PM_THRESH_EXC_4096",
-    "BriefDescription": "Threshold counter exceed a count of 4096",
+    "BriefDescription": "Threshold counter exceeded a count of 4096",
     "PublicDescription": ""
   },
   {
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/cache.json b/tools/perf/pmu-events/arch/powerpc/power9/cache.json
index 2984190c2118..71dbed868c80 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/cache.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/cache.json
@@ -72,7 +72,7 @@
   {
     "EventCode": "0x101E6",
     "EventName": "PM_THRESH_EXC_4096",
-    "BriefDescription": "Threshold counter exceed a count of 4096"
+    "BriefDescription": "Threshold counter exceeded a count of 4096"
   },
   {
     "EventCode": "0x3F14A",
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/frontend.json b/tools/perf/pmu-events/arch/powerpc/power9/frontend.json
index c8add9dfaa64..53a29e1c6c31 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/frontend.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/frontend.json
@@ -7,7 +7,7 @@
   {
     "EventCode": "0x101E8",
     "EventName": "PM_THRESH_EXC_256",
-    "BriefDescription": "Threshold counter exceed a count of 256"
+    "BriefDescription": "Threshold counter exceeded a count of 256"
   },
   {
     "EventCode": "0x4504E",
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/marked.json b/tools/perf/pmu-events/arch/powerpc/power9/marked.json
index b24d25aba2df..aad23b00be92 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/marked.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/marked.json
@@ -402,7 +402,7 @@
   {
     "EventCode": "0x30006",
     "EventName": "PM_CMPLU_STALL_OTHER_CMPL",
-    "BriefDescription": "Instructions the core completed while this tread was stalled"
+    "BriefDescription": "Instructions the core completed while this thread was stalled"
   },
   {
     "EventCode": "0x1005C",
@@ -432,7 +432,7 @@
   {
     "EventCode": "0x400FC",
     "EventName": "PM_ITLB_MISS",
-    "BriefDescription": "ITLB Reloaded. Counts 1 per ITLB miss for HPT but multiple for radix depending on number of levels traveresed"
+    "BriefDescription": "ITLB Reloaded. Counts 1 per ITLB miss for HPT but multiple for radix depending on number of levels traversed"
   },
   {
     "EventCode": "0x1E044",
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
index db86ba36224d..c405bf65d2f9 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
@@ -226,7 +226,7 @@
         "MetricName": "ict_noslot_cyc_other_cpi"
     },
     {
-        "BriefDescription": "Cycles in which the NTC instruciton is held at dispatch for any reason",
+        "BriefDescription": "Cycles in which the NTC instruction is held at dispatch for any reason",
         "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "ict_noslot_disp_held_cpi"
@@ -958,7 +958,7 @@
         "MetricName": "l2_inst_miss_rate_percent"
     },
     {
-        "BriefDescription": "L2 dmand Load Miss Rate (per run instruction)(%)",
+        "BriefDescription": "L2 demand Load Miss Rate (per run instruction)(%)",
         "MetricExpr": "PM_DATA_FROM_L2MISS * 100 / PM_RUN_INST_CMPL",
         "MetricGroup": "general",
         "MetricName": "l2_ld_miss_rate_percent"
@@ -1102,7 +1102,7 @@
         "MetricName": "l1_inst_miss_rate_percent"
     },
     {
-        "BriefDescription": "Icache Fetchs per Icache Miss",
+        "BriefDescription": "Icache Fetches per Icache Miss",
         "MetricExpr": "(PM_L1_ICACHE_MISS - PM_IC_PREF_WRITE) / PM_L1_ICACHE_MISS",
         "MetricGroup": "instruction_stats_percent_per_ref",
         "MetricName": "icache_miss_reload"
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/other.json b/tools/perf/pmu-events/arch/powerpc/power9/other.json
index f10bd554521a..9fee9dfaa32f 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/other.json
@@ -57,7 +57,7 @@
   {
     "EventCode": "0xF8AC",
     "EventName": "PM_DC_DEALLOC_NO_CONF",
-    "BriefDescription": "A demand load referenced a line in an active fuzzy prefetch stream. The stream could have been allocated through the hardware prefetch mechanism or through software.Fuzzy stream confirm (out of order effects, or pf cant keep up)"
+    "BriefDescription": "A demand load referenced a line in an active fuzzy prefetch stream. The stream could have been allocated through the hardware prefetch mechanism or through software. Fuzzy stream confirm (out of order effects, or pf can't keep up)"
   },
   {
     "EventCode": "0xD090",
@@ -277,7 +277,7 @@
   {
     "EventCode": "0xF0BC",
     "EventName": "PM_LS2_UNALIGNED_ST",
-    "BriefDescription": "Store instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the Store of that size.  If the Store wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
+    "BriefDescription": "Store instructions whose data crosses a double-word boundary, which causes it to require an additional slice than what normally would be required of the Store of that size.  If the Store wraps from slice 3 to slice 0, there is an additional 3-cycle penalty"
   },
   {
     "EventCode": "0xD0AC",
@@ -297,7 +297,7 @@
   {
     "EventCode": "0x26082",
     "EventName": "PM_L2_IC_INV",
-    "BriefDescription": "I-cache Invalidates sent over the realod bus to the core"
+    "BriefDescription": "I-cache Invalidates sent over the reload bus to the core"
   },
   {
     "EventCode": "0xC8AC",
@@ -392,7 +392,7 @@
   {
     "EventCode": "0xC098",
     "EventName": "PM_LS2_UNALIGNED_LD",
-    "BriefDescription": "Load instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the load of that size.  If the load wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
+    "BriefDescription": "Load instructions whose data crosses a double-word boundary, which causes it to require an additional slice than what normally would be required of the load of that size.  If the load wraps from slice 3 to slice 0, there is an additional 3-cycle penalty"
   },
   {
     "EventCode": "0x20058",
@@ -472,12 +472,12 @@
   {
     "EventCode": "0xC094",
     "EventName": "PM_LS0_UNALIGNED_LD",
-    "BriefDescription": "Load instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the load of that size.  If the load wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
+    "BriefDescription": "Load instructions whose data crosses a double-word boundary, which causes it to require an additional slice than what normally would be required of the load of that size.  If the load wraps from slice 3 to slice 0, there is an additional 3-cycle penalty"
   },
   {
     "EventCode": "0xF8BC",
     "EventName": "PM_LS3_UNALIGNED_ST",
-    "BriefDescription": "Store instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the Store of that size.  If the Store wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
+    "BriefDescription": "Store instructions whose data crosses a double-word boundary, which causes it to require an additional slice than what normally would be required of the Store of that size.  If the Store wraps from slice 3 to slice 0, there is an additional 3-cycle penalty"
   },
   {
     "EventCode": "0x460AE",
@@ -512,12 +512,12 @@
   {
     "EventCode": "0x40A0",
     "EventName": "PM_BR_UNCOND",
-    "BriefDescription": "Unconditional Branch Completed. HW branch prediction was not used for this branch. This can be an I-form branch, a B-form branch with BO-field set to branch always, or a B-form branch which was covenrted to a Resolve."
+    "BriefDescription": "Unconditional Branch Completed. HW branch prediction was not used for this branch. This can be an I-form branch, a B-form branch with BO-field set to branch always, or a B-form branch which was converted to a Resolve."
   },
   {
     "EventCode": "0xF8A8",
     "EventName": "PM_DC_PREF_FUZZY_CONF",
-    "BriefDescription": "A demand load referenced a line in an active fuzzy prefetch stream. The stream could have been allocated through the hardware prefetch mechanism or through software.Fuzzy stream confirm (out of order effects, or pf cant keep up)"
+    "BriefDescription": "A demand load referenced a line in an active fuzzy prefetch stream. The stream could have been allocated through the hardware prefetch mechanism or through software. Fuzzy stream confirm (out of order effects, or pf can't keep up)"
   },
   {
     "EventCode": "0xF8A4",
@@ -647,7 +647,7 @@
   {
     "EventCode": "0x4894",
     "EventName": "PM_IC_RELOAD_PRIVATE",
-    "BriefDescription": "Reloading line was brought in private for a specific thread.  Most lines are brought in shared for all eight threads.  If RA does not match then invalidates and then brings it shared to other thread. In P7 line brought in private , then line was invalidat"
+    "BriefDescription": "Reloading line was brought in private for a specific thread.  Most lines are brought in shared for all eight threads.  If RA does not match then invalidates and then brings it shared to other thread. In P7 line brought in private , then line was invalidated"
   },
   {
     "EventCode": "0x1688E",
@@ -707,7 +707,7 @@
   {
     "EventCode": "0xF8B8",
     "EventName": "PM_LS1_UNALIGNED_ST",
-    "BriefDescription": "Store instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the Store of that size.  If the Store wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
+    "BriefDescription": "Store instructions whose data crosses a double-word boundary, which causes it to require an additional slice than what normally would be required of the Store of that size.  If the Store wraps from slice 3 to slice 0, there is an additional 3-cycle penalty"
   },
   {
     "EventCode": "0x408C",
@@ -887,7 +887,7 @@
   {
     "EventCode": "0xC898",
     "EventName": "PM_LS3_UNALIGNED_LD",
-    "BriefDescription": "Load instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the load of that size.  If the load wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
+    "BriefDescription": "Load instructions whose data crosses a double-word boundary, which causes it to require an additional slice than what normally would be required of the load of that size.  If the load wraps from slice 3 to slice 0, there is an additional 3-cycle penalty"
   },
   {
     "EventCode": "0x488C",
@@ -1117,7 +1117,7 @@
   {
     "EventCode": "0x50A4",
     "EventName": "PM_FLUSH_MPRED",
-    "BriefDescription": "Branch mispredict flushes.  Includes target and address misprecition"
+    "BriefDescription": "Branch mispredict flushes.  Includes target and address misprediction"
   },
   {
     "EventCode": "0x1504C",
@@ -1262,7 +1262,7 @@
   {
     "EventCode": "0xC894",
     "EventName": "PM_LS1_UNALIGNED_LD",
-    "BriefDescription": "Load instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the load of that size.  If the load wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
+    "BriefDescription": "Load instructions whose data crosses a double-word boundary, which causes it to require an additional slice than what normally would be required of the load of that size.  If the load wraps from slice 3 to slice 0, there is an additional 3-cycle penalty"
   },
   {
     "EventCode": "0x360A2",
@@ -2072,7 +2072,7 @@
   {
     "EventCode": "0xF0B8",
     "EventName": "PM_LS0_UNALIGNED_ST",
-    "BriefDescription": "Store instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the Store of that size.  If the Store wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
+    "BriefDescription": "Store instructions whose data crosses a double-word boundary, which causes it to require an additional slice than what normally would be required of the Store of that size.  If the Store wraps from slice 3 to slice 0, there is an additional 3-cycle penalty"
   },
   {
     "EventCode": "0x20132",
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/translation.json b/tools/perf/pmu-events/arch/powerpc/power9/translation.json
index 2360b5afec6b..ab38d157540c 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/translation.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/translation.json
@@ -17,7 +17,7 @@
   {
     "EventCode": "0x4D05C",
     "EventName": "PM_DP_QP_FLOP_CMPL",
-    "BriefDescription": "Double-Precion or Quad-Precision instruction completed"
+    "BriefDescription": "Double-Precision or Quad-Precision instruction completed"
   },
   {
     "EventCode": "0x4E04C",
-- 
2.53.0

