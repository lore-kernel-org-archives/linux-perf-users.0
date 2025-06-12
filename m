Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C2578F26
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 00:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749686563; cv=none; b=T9txJIOVJbG4LqMhQOYJh0O181ZQhmrwktXp1FAH+Q5kc3PZDgele+OzCHvHlRZcOHM+okt4kMylH9G6dGEXTmoqImXwCyx4ifIF4SSjgQowqW5y7hgM0hLsC9/rEL0JRguEqMbagubmV/lBExtp2v7w/bve827d+3rVLxzu0LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749686563; c=relaxed/simple;
	bh=JNfZ5ZOPkJA95VjdqtZ+z7n2un0cp93I5argkTdE+uk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=B+4BfpZpciJp1DDNVviZQtDkUzB9k0SeMRrIF4EztCJlkIYHYhAvr3TXQ15J13LIIjSZgAi54d5i/YhIz0ZSCjoTQATtz07prpaNqxg/1iVRos9ZSjOmUw3SAx96LwiSS8vkBBlbSDhuEajcLIVqYE4mM9GnijBDu8cq9gDW+Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dfUXJphz; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dfUXJphz"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b26e33ae9d5so280706a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 17:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749686561; x=1750291361; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mmacm3DpVTP/Y25dRDeIpCe5e0sTBmcdAZpnlDXoTNs=;
        b=dfUXJphzQW/gnmqajneNlOhEVJlEd1mJk7WvcOJj6oZPTbINNTy7POMmpe77kDQ6le
         yYGH+oKsy95CLRVKMhKkdtfB7LsZzjE6yirJP3TCA5GvUKok7lvwkkfCDsz7sewW+m1l
         AuHehw2lnAtQqVuGxtABl4XM/Ze0BcYrw46Rx7dw4mtEdzquMMymYL9FyycCkk9TMTxS
         8BJ4pWe3L/+5+Ey0B2+b8GEqQWsXllAyo+4heBNLXERQfOFecbfLDdqV7OplsKYBC+jJ
         H08Yz0N0qYcUWNlIWqhXCQoy1vx3QsS/CRvI4RbETcfLI+jSWFX//LH+4VxRYXkRF6n9
         jHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749686561; x=1750291361;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmacm3DpVTP/Y25dRDeIpCe5e0sTBmcdAZpnlDXoTNs=;
        b=R40PR/1sjqomcDqV7Ulr0axls/M24yIXyVlGqnX64kTCSMNcxGe+WqaNOC6bhH1LWM
         q256blnef4yJZrfNbnnwupMqgUa8DzwCNJc6VhuSFcaJdjI9W8d5SR+o1FE43Lcm3j91
         hAdnN2exVNdlcL5hD1AZrzmyy5FIBsiKwUMYyz2le0ThLugK9y/7h8KEc33T1NxFnKug
         BrG3mQ72UuOwnXpZnkEUv/jOlXtzD18MdNpgPRxD59wf3psfLMbiR7zpxKnEIMoj3QQq
         RE+lUhdy/wDNKoODAsVSGnaJxayJUO0nCSFHytMu5LVxrONMEfdbgG3zebAOmjmle0HY
         EgPg==
X-Forwarded-Encrypted: i=1; AJvYcCXSwFhdaEtqfkXlBzvHwBOOUd5vNAMCNnIcuZ/oIvhscD8Jefs/b7N+6W2Z9loAuOgD3W98fUQonCZ1eCCIgA4H@vger.kernel.org
X-Gm-Message-State: AOJu0YzE3/sqD2ih40PV5/kmm7OgEOVF9zHuZ7UyKXjT3DGw5JOQlCcF
	oybbOBnr2an8sqVSWg28pJcJfPRup2ipr56CLDb2gBno3xCGQurJ1qVkJf4Ai0SD+tUW970X4ZQ
	yCkoFY3uRig==
X-Google-Smtp-Source: AGHT+IF9nL1X26bf2QtGTXx9JCvtuolY55vgJHj3Ao4Y1Gr8Gh8w+48muBezSJ4fFqPtvSpVEINitdC/C+Lt
X-Received: from pjuw4.prod.google.com ([2002:a17:90a:d604:b0:2ef:d136:17fc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:274a:b0:30e:3718:e9d
 with SMTP id 98e67ed59e1d1-313bfc2ae6bmr1910402a91.35.1749686560734; Wed, 11
 Jun 2025 17:02:40 -0700 (PDT)
Date: Wed, 11 Jun 2025 17:02:15 -0700
In-Reply-To: <20250612000224.780337-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250612000224.780337-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250612000224.780337-7-irogers@google.com>
Subject: [PATCH v1 06/15] perf vendor events: Update GrandRidge events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

Update events from v1.07 to v1.09.

Bring in the event updates v1.09:
https://github.com/intel/perfmon/commit/8c74d09c8544421256a79f4f21e548ad756f5b7f
https://github.com/intel/perfmon/commit/18c7d2a75e45eacf5553f900ae2097a1290f5bed

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/grandridge/grr-metrics.json      | 30 +++++++++++++++----
 .../x86/grandridge/uncore-interconnect.json   | 10 +++++++
 .../arch/x86/grandridge/uncore-io.json        | 12 ++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 4 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json b/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
index 1c6dba7b2822..878b1caf12de 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
@@ -106,6 +106,30 @@
         "MetricName": "io_bandwidth_write",
         "ScaleUnit": "1MB/s"
     },
+    {
+        "BriefDescription": "The percent of inbound full cache line writes initiated by IO that miss the L3 cache",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM / UNC_CHA_TOR_INSERTS.IO_ITOM",
+        "MetricName": "io_full_write_l3_miss",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Message Signaled Interrupts (MSI) per second sent by the integrated I/O traffic controller (IIO) to System Configuration Controller (Ubox)",
+        "MetricExpr": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.UBOX_POSTED / duration_time",
+        "MetricName": "io_msi",
+        "ScaleUnit": "1per_sec"
+    },
+    {
+        "BriefDescription": "The percent of inbound partial writes initiated by IO that miss the L3 cache",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_MISS_ITOMCACHENEAR + UNC_CHA_TOR_INSERTS.IO_MISS_RFO) / (UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR + UNC_CHA_TOR_INSERTS.IO_RFO)",
+        "MetricName": "io_partial_write_l3_miss",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "The percent of inbound reads initiated by IO that miss the L3 cache",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_MISS_PCIRDCUR / UNC_CHA_TOR_INSERTS.IO_PCIRDCUR",
+        "MetricName": "io_read_l3_miss",
+        "ScaleUnit": "100%"
+    },
     {
         "BriefDescription": "Ratio of number of completed page walks (for 2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total number of completed instructions",
         "MetricExpr": "ITLB_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRED.ANY",
@@ -162,12 +186,6 @@
         "MetricName": "llc_data_read_mpi_demand_plus_prefetch",
         "ScaleUnit": "1per_instr"
     },
-    {
-        "BriefDescription": "Average latency of a last level cache (LLC) demand data read miss (read memory access) in nano seconds",
-        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT) / (UNC_CHA_CLOCKTICKS / (source_count(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT) * #num_packages)) * duration_time",
-        "MetricName": "llc_demand_data_read_miss_latency",
-        "ScaleUnit": "1ns"
-    },
     {
         "BriefDescription": "Load operations retired per instruction",
         "MetricExpr": "MEM_UOPS_RETIRED.ALL_LOADS / INST_RETIRED.ANY",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/grandridge/uncore-interconnect.json
index 2c18767511f3..c7250332d8aa 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/uncore-interconnect.json
@@ -261,5 +261,15 @@
         "PerPkg": "1",
         "UMask": "0x8",
         "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Message Received : MSI",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.MSI_RCVD",
+        "PerPkg": "1",
+        "PublicDescription": "Message Received : MSI : Message Signaled Interrupts - interrupts sent by devices (including PCIe via IOxAPIC) (Socket Mode only)",
+        "UMask": "0x2",
+        "Unit": "UBOX"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/uncore-io.json b/tools/perf/pmu-events/arch/x86/grandridge/uncore-io.json
index c5b05c71c56d..764cf2f0b4a8 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/uncore-io.json
@@ -907,6 +907,18 @@
         "UMask": "0x4",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "Posted requests sent by the integrated IO (IIO) controller to the Ubox, useful for counting message signaled interrupts (MSI).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.UBOX_POSTED",
+        "FCMask": "0x01",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "PublicDescription": "-",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "All 9 bits of Page Walk Tracker Occupancy",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index e139a099374a..f3fe686b6630 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -12,7 +12,7 @@ GenuineIntel-6-9[6C],v1.05,elkhartlake,core
 GenuineIntel-6-CF,v1.14,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
-GenuineIntel-6-B6,v1.07,grandridge,core
+GenuineIntel-6-B6,v1.09,grandridge,core
 GenuineIntel-6-A[DE],v1.08,graniterapids,core
 GenuineIntel-6-(3C|45|46),v36,haswell,core
 GenuineIntel-6-3F,v29,haswellx,core
-- 
2.50.0.rc1.591.g9c95f17f64-goog

