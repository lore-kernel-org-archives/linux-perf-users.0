Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797751FE456
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Feb 2025 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738776793; cv=none; b=AMeexU3QLsRyirLEcMajaOBz2UrldAjUSxO6qrItLa6qaO9TIAb1gZ9G7KYHKTW3O9xnxE1ZQsl/uXX5G7wAq8jJOepCjZAAiwR1AzzBa8iL4nu80mbZ/DE9ZUANV6FbMWUQJbwDFR7qoUfB0eh+LOEonnEu06hq8L3HzUuLzdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738776793; c=relaxed/simple;
	bh=mWKFx/fur6/GDNDwynvQUyImyPB/7sog4p5k9HKz9B4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=BYRbwcSgK3Gcx2hO6JQ1+xeIr5MilDJtsaEARZXyfVgdq8/Y2sTJDD0XxZkKQE/TYT4V4/beU+QzLcWZBS+EdP33q7xOBWkqB5btrrzgn9pCCjUkUiY/Nnzu3lcFx6ZsHZ7aCiUdJezF+nWqGEuHMPDpGybLckoqLeumz0PvH4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fBY/fNng; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBY/fNng"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f46fb73061so14940297b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 09:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738776762; x=1739381562; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNdTJw3kftue8KhChs6N4kDx/u66edylSKZLm4DOBp4=;
        b=fBY/fNng1Cap0YLnXlIwXvx4kIUD3SiGY8BSLIIv86x7o/KGjJ2AC5ZscGu4/08YyX
         IEsiVstKaqWzNfX9GPaHV5Rzt2/g13REQNtHNM5wL11YmSSIc9xV8O8gyLcU5L6uSrnR
         +UqOL1VJQSf87vxBnZRxC9u6dvXCepYLDNv2c1ykKpCipXm2tqKTIgL17mRnY+pQz7/s
         yg7yRmhgypqqwxjcZPRicRkJCC7W7n1X0qGd/mWULCuRUUgD3GGILMEGIXSuXTt+HYaF
         GKQeJdvxvTrjiVyWrKqcw6Jls/NJhFmA3epwtlfeh26yi6nD+YgWDVeUeGZNWVvoDy2T
         QuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738776762; x=1739381562;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PNdTJw3kftue8KhChs6N4kDx/u66edylSKZLm4DOBp4=;
        b=lgWqZDua75yPSTMv0s+xOqOcVmcACkFaLo1kUBJWN2lkv/GiSljuOi1TY7McB5Lq2H
         McnvOWirPU9vb5WLsBhc0sxmKclF3VZcQcM5EApt0LQql7wanNz2OHixizgkeTHeq+7j
         vh8eh/9YUn/I7RS77YxG7xosJlU5CAPEE9EWMqmY5HomWJMGtJoI4Ogwkt6Aj2bqZ1tU
         8nrSew4muA/jmS56x6EHrBlxohAG7onSHSJlwUuOxyCZSMPpvGc9OlT2SSGHAr1K6yfG
         DIR5GqhnQr5kIzPF6045Y2nUofw9Wr1ONApwcukZlPXIKqZMu0M4IJzsFA2wnMFLD+7c
         vH1w==
X-Forwarded-Encrypted: i=1; AJvYcCXPeuGwMr9VvRvnmjycJsW1a/TqRue+Kpdhb5tHr+ZNYYm4LfcQwAgSnddijmKOpXH86JSpEO+3aCwG1Cw+LGNa@vger.kernel.org
X-Gm-Message-State: AOJu0YxPctOg4NDrdqpvmn7VIQKpLDBf27gWnC7LM5eZj3woyT+0F8Gb
	t/mI5isF+9KTf6qEXXvZHeGddkhvBo/uCQSYToqArdIsGx+lCedaMpWoUIN22jxBzLePc+IO+MP
	20376Rg==
X-Google-Smtp-Source: AGHT+IHdJuOFnaRsEYgj/Y8yOiDrDi+TxyrRsfimANaXzwxkkokFUYqa4cYKCn3ae15boD73jXUUvYmt56OZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:34a2:aced:a7fd:972a])
 (user=irogers job=sendgmr) by 2002:a05:690c:688e:b0:6ee:a2b0:a803 with SMTP
 id 00721157ae682-6f99a624133mr9937b3.1.1738776761863; Wed, 05 Feb 2025
 09:32:41 -0800 (PST)
Date: Wed,  5 Feb 2025 09:31:38 -0800
In-Reply-To: <20250205173140.238294-1-irogers@google.com>
Message-Id: <20250205173140.238294-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250205173140.238294-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Subject: [PATCH v5 22/24] perf vendor events: Update SkylakeX events/metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Michael Petlan <mpetlan@redhat.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.35 to v1.36.
Update TMA metrics from 4.8 to 5.01.

Bring in the event updates v1.36:
https://github.com/intel/perfmon/commit/f6801e5c145406f355f40e1746f836eaa14=
26cf9

The TMA 5.01 addition is from (with subsequent fixes):
https://github.com/intel/perfmon/commit/1d72913b2d938781fb28f3cc3507aaec5c2=
2d782

Co-developed-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Caleb Biggers <caleb.biggers@intel.com>
Acked-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 .../arch/x86/skylakex/metricgroups.json       |   9 +-
 .../arch/x86/skylakex/skx-metrics.json        | 740 ++++++++++--------
 .../arch/x86/skylakex/uncore-cache.json       |  60 +-
 .../x86/skylakex/uncore-interconnect.json     |  11 -
 5 files changed, 465 insertions(+), 357 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 678ee6b11184..fbb4437db799 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -32,7 +32,7 @@ GenuineIntel-6-8F,v1.25,sapphirerapids,core
 GenuineIntel-6-AF,v1.08,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
-GenuineIntel-6-55-[01234],v1.35,skylakex,core
+GenuineIntel-6-55-[01234],v1.36,skylakex,core
 GenuineIntel-6-86,v1.23,snowridgex,core
 GenuineIntel-6-8[CD],v1.16,tigerlake,core
 GenuineIntel-6-2C,v5,westmereep-dp,core
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/metricgroups.json b/to=
ols/perf/pmu-events/arch/x86/skylakex/metricgroups.json
index cccfcab3425e..a579603f720b 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/metricgroups.json
@@ -38,6 +38,7 @@
     "IoBW": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
     "L2Evicts": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "LSD": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
+    "LockCont": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "MachineClears": "Grouping from Top-down Microarchitecture Analysis Me=
trics spreadsheet",
     "Machine_Clears": "Grouping from Top-down Microarchitecture Analysis M=
etrics spreadsheet",
     "Mem": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
@@ -84,7 +85,9 @@
     "tma_bad_speculation_group": "Metrics contributing to tma_bad_speculat=
ion category",
     "tma_branch_mispredicts_group": "Metrics contributing to tma_branch_mi=
spredicts category",
     "tma_branch_resteers_group": "Metrics contributing to tma_branch_reste=
ers category",
+    "tma_code_stlb_miss_group": "Metrics contributing to tma_code_stlb_mis=
s category",
     "tma_core_bound_group": "Metrics contributing to tma_core_bound catego=
ry",
+    "tma_divider_group": "Metrics contributing to tma_divider category",
     "tma_dram_bound_group": "Metrics contributing to tma_dram_bound catego=
ry",
     "tma_dtlb_load_group": "Metrics contributing to tma_dtlb_load category=
",
     "tma_dtlb_store_group": "Metrics contributing to tma_dtlb_store catego=
ry",
@@ -113,10 +116,13 @@
     "tma_issueSpSt": "Metrics related by the issue $issueSpSt",
     "tma_issueSyncxn": "Metrics related by the issue $issueSyncxn",
     "tma_issueTLB": "Metrics related by the issue $issueTLB",
+    "tma_itlb_misses_group": "Metrics contributing to tma_itlb_misses cate=
gory",
     "tma_l1_bound_group": "Metrics contributing to tma_l1_bound category",
+    "tma_l2_bound_group": "Metrics contributing to tma_l2_bound category",
     "tma_l3_bound_group": "Metrics contributing to tma_l3_bound category",
     "tma_light_operations_group": "Metrics contributing to tma_light_opera=
tions category",
     "tma_load_op_utilization_group": "Metrics contributing to tma_load_op_=
utilization category",
+    "tma_load_stlb_miss_group": "Metrics contributing to tma_load_stlb_mis=
s category",
     "tma_machine_clears_group": "Metrics contributing to tma_machine_clear=
s category",
     "tma_mem_latency_group": "Metrics contributing to tma_mem_latency cate=
gory",
     "tma_memory_bound_group": "Metrics contributing to tma_memory_bound ca=
tegory",
@@ -129,5 +135,6 @@
     "tma_retiring_group": "Metrics contributing to tma_retiring category",
     "tma_serializing_operation_group": "Metrics contributing to tma_serial=
izing_operation category",
     "tma_store_bound_group": "Metrics contributing to tma_store_bound cate=
gory",
-    "tma_store_op_utilization_group": "Metrics contributing to tma_store_o=
p_utilization category"
+    "tma_store_op_utilization_group": "Metrics contributing to tma_store_o=
p_utilization category",
+    "tma_store_stlb_miss_group": "Metrics contributing to tma_store_stlb_m=
iss category"
 }
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index e5e86892d7bb..2fe630cd4927 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -55,7 +55,7 @@
         "MetricName": "UNCORE_FREQ"
     },
     {
-        "BriefDescription": "Cycles per instruction retired; indicating ho=
w much time each executed instruction took; in units of cycles.",
+        "BriefDescription": "Cycles per instruction retired; indicating ho=
w much time each executed instruction took; in units of cycles",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD / INST_RETIRED.ANY",
         "MetricName": "cpi",
         "ScaleUnit": "1per_instr"
@@ -76,31 +76,31 @@
         "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte page sizes) caused by demand data loads to the total number of c=
ompleted instructions",
         "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRE=
D.ANY",
         "MetricName": "dtlb_2mb_large_page_load_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte page sizes) caused by demand data loads to the total number of =
completed instructions. This implies it missed in the Data Translation Look=
aside Buffer (DTLB) and further levels of TLB.",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte page sizes) caused by demand data loads to the total number of =
completed instructions. This implies it missed in the Data Translation Look=
aside Buffer (DTLB) and further levels of TLB",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data loads to the total number of complete=
d instructions",
         "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETIRED.ANY"=
,
         "MetricName": "dtlb_load_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data loads to the total number of complet=
ed instructions. This implies it missed in the DTLB and further levels of T=
LB.",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data loads to the total number of complet=
ed instructions. This implies it missed in the DTLB and further levels of T=
LB",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data stores to the total number of complet=
ed instructions",
         "MetricExpr": "DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
         "MetricName": "dtlb_store_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data stores to the total number of comple=
ted instructions. This implies it missed in the DTLB and further levels of =
TLB.",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data stores to the total number of comple=
ted instructions. This implies it missed in the DTLB and further levels of =
TLB",
         "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the CPU.",
+        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the CPU",
         "MetricExpr": "(UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 + UNC_IIO_D=
ATA_REQ_OF_CPU.MEM_READ.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 + UN=
C_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3) * 4 / 1e6 / duration_time",
         "MetricName": "io_bandwidth_read",
         "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the CPU.",
+        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the CPU",
         "MetricExpr": "(UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PART0 + UNC_IIO=
_PAYLOAD_BYTES_IN.MEM_WRITE.PART1 + UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PART=
2 + UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PART3) * 4 / 1e6 / duration_time",
         "MetricName": "io_bandwidth_write",
         "ScaleUnit": "1MB/s"
@@ -109,14 +109,14 @@
         "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total n=
umber of completed instructions",
         "MetricExpr": "ITLB_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRED.ANY=
",
         "MetricName": "itlb_large_page_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total =
number of completed instructions. This implies it missed in the Instruction=
 Translation Lookaside Buffer (ITLB) and further levels of TLB.",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total =
number of completed instructions. This implies it missed in the Instruction=
 Translation Lookaside Buffer (ITLB) and further levels of TLB",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by a code fetch to the total number of completed ins=
tructions",
         "MetricExpr": "ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY",
         "MetricName": "itlb_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by a code fetch to the total number of completed in=
structions. This implies it missed in the ITLB (Instruction TLB) and furthe=
r levels of TLB.",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by a code fetch to the total number of completed in=
structions. This implies it missed in the ITLB (Instruction TLB) and furthe=
r levels of TLB",
         "ScaleUnit": "1per_instr"
     },
     {
@@ -192,25 +192,25 @@
         "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to local memory.",
+        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to local memory",
         "MetricExpr": "UNC_CHA_REQUESTS.READS_LOCAL * 64 / 1e6 / duration_=
time",
         "MetricName": "llc_miss_local_memory_bandwidth_read",
         "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to local memory.",
+        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to local memory",
         "MetricExpr": "UNC_CHA_REQUESTS.WRITES_LOCAL * 64 / 1e6 / duration=
_time",
         "MetricName": "llc_miss_local_memory_bandwidth_write",
         "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to remote memory.",
+        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to remote memory",
         "MetricExpr": "UNC_CHA_REQUESTS.READS_REMOTE * 64 / 1e6 / duration=
_time",
         "MetricName": "llc_miss_remote_memory_bandwidth_read",
         "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to remote memory.",
+        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to remote memory",
         "MetricExpr": "UNC_CHA_REQUESTS.WRITES_REMOTE * 64 / 1e6 / duratio=
n_time",
         "MetricName": "llc_miss_remote_memory_bandwidth_write",
         "ScaleUnit": "1MB/s"
@@ -240,13 +240,13 @@
         "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Memory read that miss the last level cache (L=
LC) addressed to local DRAM as a percentage of total memory read accesses, =
does not include LLC prefetches.",
+        "BriefDescription": "Memory read that miss the last level cache (L=
LC) addressed to local DRAM as a percentage of total memory read accesses, =
does not include LLC prefetches",
         "MetricExpr": "cha@UNC_CHA_TOR_INSERTS.IA_MISS\\,config1\\=3D0x404=
32@ / (cha@UNC_CHA_TOR_INSERTS.IA_MISS\\,config1\\=3D0x40432@ + cha@UNC_CHA=
_TOR_INSERTS.IA_MISS\\,config1\\=3D0x40431@)",
         "MetricName": "numa_reads_addressed_to_local_dram",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Memory reads that miss the last level cache (=
LLC) addressed to remote DRAM as a percentage of total memory read accesses=
, does not include LLC prefetches.",
+        "BriefDescription": "Memory reads that miss the last level cache (=
LLC) addressed to remote DRAM as a percentage of total memory read accesses=
, does not include LLC prefetches",
         "MetricExpr": "cha@UNC_CHA_TOR_INSERTS.IA_MISS\\,config1\\=3D0x404=
31@ / (cha@UNC_CHA_TOR_INSERTS.IA_MISS\\,config1\\=3D0x40432@ + cha@UNC_CHA=
_TOR_INSERTS.IA_MISS\\,config1\\=3D0x40431@)",
         "MetricName": "numa_reads_addressed_to_remote_dram",
         "ScaleUnit": "100%"
@@ -295,12 +295,12 @@
         "MetricExpr": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS / tma_info_thread_c=
lks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_4k_aliasing",
-        "MetricThreshold": "tma_4k_aliasing > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates how often memory load =
accesses were aliased by preceding stores (in program order) with a 4K addr=
ess offset. False match is possible; which incur a few cycles load re-issue=
. However; the short re-issue duration is often hidden by the out-of-order =
core and HW optimizations; hence a user may safely ignore a high value of t=
his metric unless it manages to propagate up into parent nodes of the hiera=
rchy (e.g. to L1_Bound).",
+        "MetricThreshold": "tma_4k_aliasing > 0.2 & tma_l1_bound > 0.1 & t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often memory load =
accesses were aliased by preceding stores (in program order) with a 4K addr=
ess offset. False match is possible; which incur a few cycles load re-issue=
. However; the short re-issue duration is often hidden by the out-of-order =
core and HW optimizations; hence a user may safely ignore a high value of t=
his metric unless it manages to propagate up into parent nodes of the hiera=
rchy (e.g. to L1_Bound)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations",
         "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5 + UOPS_DISPATCHED_PORT.PORT_6) / tma_=
info_thread_slots",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
@@ -312,7 +312,7 @@
         "MetricExpr": "34 * (FP_ASSIST.ANY + OTHER_ASSISTS.ANY) / tma_info=
_thread_slots",
         "MetricGroup": "BvIO;TopdownL4;tma_L4_group;tma_microcode_sequence=
r_group",
         "MetricName": "tma_assists",
-        "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
+        "MetricThreshold": "tma_assists > 0.1 & tma_microcode_sequencer > =
0.05 & tma_heavy_operations > 0.1",
         "PublicDescription": "This metric estimates fraction of slots the =
CPU retired uops delivered by the Microcode_Sequencer as a result of Assist=
s. Assists are long sequences of uops that are required in certain corner-c=
ases for operations that cannot be handled natively by the execution pipeli=
ne. For example; when working with very small floating point values (so-cal=
led Denormals); the FP units are not set up to perform these operations nat=
ively. Instead; a sequence of instructions to perform the computation on th=
e Denormals is injected into the pipeline. Since these microcode sequences =
might be dozens of uops long; Assists can be extremely deleterious to perfo=
rmance and they can be avoided in many cases. Sample with: OTHER_ASSISTS.AN=
Y",
         "ScaleUnit": "100%"
     },
@@ -323,7 +323,7 @@
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
         "MetricgroupNoGroup": "TopdownL1",
-        "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound.",
+        "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound",
         "ScaleUnit": "100%"
     },
     {
@@ -333,9 +333,102 @@
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "MetricgroupNoGroup": "TopdownL1",
-        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
+        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example",
         "ScaleUnit": "100%"
     },
+    {
+        "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
+        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_icache_misses + tma_itlb_misses =
+ tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches)",
+        "MetricGroup": "BigFootprint;BvBC;Fed;Frontend;IcMiss;MemoryTLB",
+        "MetricName": "tma_bottleneck_big_code",
+        "MetricThreshold": "tma_bottleneck_big_code > 20"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of instructions used for =
program control-flow - a subset of the Retiring category in TMA",
+        "MetricExpr": "100 * ((BR_INST_RETIRED.ALL_BRANCHES + 2 * BR_INST_=
RETIRED.NEAR_CALL + INST_RETIRED.NOP) / tma_info_thread_slots)",
+        "MetricGroup": "BvBO;Ret",
+        "MetricName": "tma_bottleneck_branching_overhead",
+        "MetricThreshold": "tma_bottleneck_branching_overhead > 5",
+        "PublicDescription": "Total pipeline cost of instructions used for=
 program control-flow - a subset of the Retiring category in TMA. Examples =
include function calls; loops and alignments. (A lower bound)"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dr=
am_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_store_fwd_blk + tm=
a_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_4k_alias=
ing + tma_fb_full)))",
+        "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
+        "MetricName": "tma_bottleneck_cache_memory_bandwidth",
+        "MetricThreshold": "tma_bottleneck_cache_memory_bandwidth > 20",
+        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_=
system_dram_bw_use, tma_mem_bandwidth, tma_sq_full"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Latency related bottlenecks",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_bou=
nd * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram=
_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound =
* tma_l2_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bou=
nd + tma_store_bound) + tma_memory_bound * (tma_l1_bound / (tma_l1_bound + =
tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_l1_=
latency_dependency / (tma_dtlb_load + tma_store_fwd_blk + tma_l1_latency_de=
pendency + tma_lock_latency + tma_split_loads + tma_4k_aliasing + tma_fb_fu=
ll)) + tma_memory_bound * (tma_l1_bound / (tma_l1_bound + tma_l2_bound + tm=
a_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_lock_latency / (tma_=
dtlb_load + tma_store_fwd_blk + tma_l1_latency_dependency + tma_lock_latenc=
y + tma_split_loads + tma_4k_aliasing + tma_fb_full)) + tma_memory_bound * =
(tma_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_boun=
d + tma_store_bound)) * (tma_split_loads / (tma_dtlb_load + tma_store_fwd_b=
lk + tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_4=
k_aliasing + tma_fb_full)) + tma_memory_bound * (tma_store_bound / (tma_l1_=
bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * =
(tma_split_stores / (tma_store_latency + tma_false_sharing + tma_split_stor=
es + tma_dtlb_store)) + tma_memory_bound * (tma_store_bound / (tma_l1_bound=
 + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_=
store_latency / (tma_store_latency + tma_false_sharing + tma_split_stores +=
 tma_dtlb_store)))",
+        "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
+        "MetricName": "tma_bottleneck_cache_memory_latency",
+        "MetricThreshold": "tma_bottleneck_cache_memory_latency > 20",
+        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Latency related bottlenecks. Related metrics: tma_l3_hit_latency, tma_=
mem_latency"
+    },
+    {
+        "BriefDescription": "Total pipeline cost when the execution is com=
pute-bound - an estimation",
+        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_divider =
+ tma_serializing_operation + tma_ports_utilization) + tma_core_bound * (tm=
a_ports_utilization / (tma_divider + tma_serializing_operation + tma_ports_=
utilization)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_ports_=
utilized_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
+        "MetricGroup": "BvCB;Cor;tma_issueComp",
+        "MetricName": "tma_bottleneck_compute_bound_est",
+        "MetricThreshold": "tma_bottleneck_compute_bound_est > 20",
+        "PublicDescription": "Total pipeline cost when the execution is co=
mpute-bound - an estimation. Covers Core Bound when High ILP as well as whe=
n long-latency execution units are busy"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks (when the front-end could not sustain operations =
delivery to the back-end)",
+        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_icache_misses + tma_itlb_misses + t=
ma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches) - tma_mi=
crocode_sequencer / (tma_few_uops_instructions + tma_microcode_sequencer) *=
 (tma_assists / tma_microcode_sequencer) * tma_fetch_latency * (tma_ms_swit=
ches + tma_branch_resteers * (tma_clears_resteers + tma_mispredicts_resteer=
s * (10 * tma_microcode_sequencer * tma_other_mispredicts / tma_branch_misp=
redicts)) / (tma_mispredicts_resteers + tma_clears_resteers + tma_unknown_b=
ranches)) / (tma_icache_misses + tma_itlb_misses + tma_branch_resteers + tm=
a_ms_switches + tma_lcp + tma_dsb_switches)) - tma_bottleneck_big_code",
+        "MetricGroup": "BvFB;Fed;FetchBW;Frontend",
+        "MetricName": "tma_bottleneck_instruction_fetch_bw",
+        "MetricThreshold": "tma_bottleneck_instruction_fetch_bw > 20"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of irregular execution (e=
.g",
+        "MetricExpr": "100 * (tma_microcode_sequencer / (tma_few_uops_inst=
ructions + tma_microcode_sequencer) * (tma_assists / tma_microcode_sequence=
r) * tma_fetch_latency * (tma_ms_switches + tma_branch_resteers * (tma_clea=
rs_resteers + tma_mispredicts_resteers * (10 * tma_microcode_sequencer * tm=
a_other_mispredicts / tma_branch_mispredicts)) / (tma_mispredicts_resteers =
+ tma_clears_resteers + tma_unknown_branches)) / (tma_icache_misses + tma_i=
tlb_misses + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_swit=
ches) + 10 * tma_microcode_sequencer * tma_other_mispredicts / tma_branch_m=
ispredicts * tma_branch_mispredicts + tma_machine_clears * tma_other_nukes =
/ tma_other_nukes + tma_core_bound * (tma_serializing_operation + tma_core_=
bound * RS_EVENTS.EMPTY_CYCLES / tma_info_thread_clks * tma_ports_utilized_=
0) / (tma_divider + tma_serializing_operation + tma_ports_utilization) + tm=
a_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_sequence=
r) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
+        "MetricGroup": "Bad;BvIO;Cor;Ret;tma_issueMS",
+        "MetricName": "tma_bottleneck_irregular_overhead",
+        "MetricThreshold": "tma_bottleneck_irregular_overhead > 10",
+        "PublicDescription": "Total pipeline cost of irregular execution (=
e.g. FP-assists in HPC, Wait time with work imbalance multithreaded workloa=
ds, overhead in system services or virtualized environments). Related metri=
cs: tma_microcode_sequencer, tma_ms_switches"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + =
tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_dtlb_load + tma_=
store_fwd_blk + tma_l1_latency_dependency + tma_lock_latency + tma_split_lo=
ads + tma_4k_aliasing + tma_fb_full)) + tma_memory_bound * (tma_store_bound=
 / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store=
_bound)) * (tma_dtlb_store / (tma_store_latency + tma_false_sharing + tma_s=
plit_stores + tma_dtlb_store)))",
+        "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
+        "MetricName": "tma_bottleneck_memory_data_tlbs",
+        "MetricThreshold": "tma_bottleneck_memory_data_tlbs > 20",
+        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound) * =
(tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) * tma_remote_cach=
e / (tma_local_mem + tma_remote_mem + tma_remote_cache) + tma_l3_bound / (t=
ma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_boun=
d) * (tma_contested_accesses + tma_data_sharing) / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / =
(tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bo=
und) * tma_false_sharing / (tma_store_latency + tma_false_sharing + tma_spl=
it_stores + tma_dtlb_store - tma_store_latency)) + tma_machine_clears * (1 =
- tma_other_nukes / tma_other_nukes))",
+        "MetricGroup": "BvMS;LockCont;Mem;Offcore;tma_issueSyncxn",
+        "MetricName": "tma_bottleneck_memory_synchronization",
+        "MetricThreshold": "tma_bottleneck_memory_synchronization > 10",
+        "PublicDescription": "Total pipeline cost of Memory Synchronizatio=
n related bottlenecks (data transfers and coherency updates across processo=
rs). Related metrics: tma_contested_accesses, tma_data_sharing, tma_false_s=
haring, tma_machine_clears, tma_remote_cache"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
+        "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_other=
_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fetc=
h_latency * tma_mispredicts_resteers / (tma_icache_misses + tma_itlb_misses=
 + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches))",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts;BvMP;tma_issueBM",
+        "MetricName": "tma_bottleneck_mispredictions",
+        "MetricThreshold": "tma_bottleneck_mispredictions > 20",
+        "PublicDescription": "Total pipeline cost of Branch Misprediction =
related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_bad_=
spec_branch_misprediction_cost, tma_mispredicts_resteers"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of remaining bottlenecks =
in the back-end",
+        "MetricExpr": "100 - (tma_bottleneck_big_code + tma_bottleneck_ins=
truction_fetch_bw + tma_bottleneck_mispredictions + tma_bottleneck_cache_me=
mory_bandwidth + tma_bottleneck_cache_memory_latency + tma_bottleneck_memor=
y_data_tlbs + tma_bottleneck_memory_synchronization + tma_bottleneck_comput=
e_bound_est + tma_bottleneck_irregular_overhead + tma_bottleneck_branching_=
overhead + tma_bottleneck_useful_work)",
+        "MetricGroup": "BvOB;Cor;Offcore",
+        "MetricName": "tma_bottleneck_other_bottlenecks",
+        "MetricThreshold": "tma_bottleneck_other_bottlenecks > 20",
+        "PublicDescription": "Total pipeline cost of remaining bottlenecks=
 in the back-end. Examples include data-dependencies (Core Bound when Low I=
LP) and other unlisted memory-related stalls"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the portion of Retiring category not covered by Branching_Overhead nor Ir=
regular_Overhead",
+        "MetricExpr": "100 * (tma_retiring - (BR_INST_RETIRED.ALL_BRANCHES=
 + 2 * BR_INST_RETIRED.NEAR_CALL + INST_RETIRED.NOP) / tma_info_thread_slot=
s - tma_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_se=
quencer) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)"=
,
+        "MetricGroup": "BvUW;Ret",
+        "MetricName": "tma_bottleneck_useful_work",
+        "MetricThreshold": "tma_bottleneck_useful_work > 20"
+    },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
         "MetricConstraint": "NO_GROUP_EVENTS",
@@ -344,7 +437,7 @@
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics:=
 tma_info_bad_spec_branch_misprediction_cost, tma_info_bottleneck_mispredic=
tions, tma_mispredicts_resteers",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics:=
 tma_bottleneck_mispredictions, tma_info_bad_spec_branch_misprediction_cost=
, tma_mispredicts_resteers",
         "ScaleUnit": "100%"
     },
     {
@@ -352,8 +445,8 @@
         "MetricExpr": "INT_MISC.CLEAR_RESTEER_CYCLES / tma_info_thread_clk=
s + tma_unknown_branches",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group",
         "MetricName": "tma_branch_resteers",
-        "MetricThreshold": "tma_branch_resteers > 0.05 & (tma_fetch_latenc=
y > 0.1 & tma_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES",
+        "MetricThreshold": "tma_branch_resteers > 0.05 & tma_fetch_latency=
 > 0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES. Related metrics: tma_l3_hit_latency, tma_store_latency",
         "ScaleUnit": "100%"
     },
     {
@@ -361,8 +454,8 @@
         "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_cisc",
-        "MetricThreshold": "tma_cisc > 0.1 & (tma_microcode_sequencer > 0.=
05 & tma_heavy_operations > 0.1)",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources.",
+        "MetricThreshold": "tma_cisc > 0.1 & tma_microcode_sequencer > 0.0=
5 & tma_heavy_operations > 0.1",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources",
         "ScaleUnit": "100%"
     },
     {
@@ -370,18 +463,50 @@
         "MetricExpr": "(1 - BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRE=
D.ALL_BRANCHES + MACHINE_CLEARS.COUNT)) * INT_MISC.CLEAR_RESTEER_CYCLES / t=
ma_info_thread_clks",
         "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueMC",
         "MetricName": "tma_clears_resteers",
-        "MetricThreshold": "tma_clears_resteers > 0.05 & (tma_branch_reste=
ers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
+        "MetricThreshold": "tma_clears_resteers > 0.05 & tma_branch_restee=
rs > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Machine Clears. Sam=
ple with: INT_MISC.CLEAR_RESTEER_CYCLES. Related metrics: tma_l1_bound, tma=
_machine_clears, tma_microcode_sequencer, tma_ms_switches",
         "ScaleUnit": "100%"
     },
+    {
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the (first level) ITLB was missed by instructions fetches, th=
at later on hit in second-level TLB (STLB)",
+        "MetricExpr": "max(0, tma_itlb_misses - tma_code_stlb_miss)",
+        "MetricGroup": "FetchLat;MemoryTLB;TopdownL4;tma_L4_group;tma_itlb=
_misses_group",
+        "MetricName": "tma_code_stlb_hit",
+        "MetricThreshold": "tma_code_stlb_hit > 0.05 & tma_itlb_misses > 0=
.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
where the Second-level TLB (STLB) was missed by instruction fetches, perfor=
ming a hardware page walk",
+        "MetricExpr": "ITLB_MISSES.WALK_ACTIVE / tma_info_thread_clks",
+        "MetricGroup": "FetchLat;MemoryTLB;TopdownL4;tma_L4_group;tma_itlb=
_misses_group",
+        "MetricName": "tma_code_stlb_miss",
+        "MetricThreshold": "tma_code_stlb_miss > 0.05 & tma_itlb_misses > =
0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for (instruction) code accesses",
+        "MetricExpr": "tma_code_stlb_miss * ITLB_MISSES.WALK_COMPLETED_2M_=
4M / (ITLB_MISSES.WALK_COMPLETED_4K + ITLB_MISSES.WALK_COMPLETED_2M_4M)",
+        "MetricGroup": "FetchLat;MemoryTLB;TopdownL5;tma_L5_group;tma_code=
_stlb_miss_group",
+        "MetricName": "tma_code_stlb_miss_2m",
+        "MetricThreshold": "tma_code_stlb_miss_2m > 0.05 & tma_code_stlb_m=
iss > 0.05 & tma_itlb_misses > 0.05 & tma_fetch_latency > 0.1 & tma_fronten=
d_bound > 0.15",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 (instruction) code accesses",
+        "MetricExpr": "tma_code_stlb_miss * ITLB_MISSES.WALK_COMPLETED_4K =
/ (ITLB_MISSES.WALK_COMPLETED_4K + ITLB_MISSES.WALK_COMPLETED_2M_4M)",
+        "MetricGroup": "FetchLat;MemoryTLB;TopdownL5;tma_L5_group;tma_code=
_stlb_miss_group",
+        "MetricName": "tma_code_stlb_miss_4k",
+        "MetricThreshold": "tma_code_stlb_miss_4k > 0.05 & tma_code_stlb_m=
iss > 0.05 & tma_itlb_misses > 0.05 & tma_fetch_latency > 0.1 & tma_fronten=
d_bound > 0.15",
+        "ScaleUnit": "100%"
+    },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(44 * tma_info_system_core_frequency * (MEM_LOAD_L3=
_HIT_RETIRED.XSNP_HITM * (OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.HITM_OTHER=
_CORE / (OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.HITM_OTHER_CORE + OFFCORE_R=
ESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) + 44 * tma_info_system_=
core_frequency * MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS) * (1 + MEM_LOAD_RETIRED=
.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
-        "MetricGroup": "BvMS;DataSharing;Offcore;Snoop;TopdownL4;tma_L4_gr=
oup;tma_issueSyncxn;tma_l3_bound_group",
+        "MetricExpr": "((47.5 * tma_info_system_core_frequency - 3.5 * tma=
_info_system_core_frequency) * (MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM * (OFFCOR=
E_RESPONSE.DEMAND_DATA_RD.L3_HIT.HITM_OTHER_CORE / (OFFCORE_RESPONSE.DEMAND=
_DATA_RD.L3_HIT.HITM_OTHER_CORE + OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SN=
OOP_HIT_WITH_FWD))) + (47.5 * tma_info_system_core_frequency - 3.5 * tma_in=
fo_system_core_frequency) * MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS) * (1 + MEM_L=
OAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
+        "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
-        "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS. Re=
lated metrics: tma_data_sharing, tma_false_sharing, tma_machine_clears, tma=
_remote_cache",
+        "MetricThreshold": "tma_contested_accesses > 0.05 & tma_l3_bound >=
 0.05 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_HITM, MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Related=
 metrics: tma_bottleneck_memory_synchronization, tma_data_sharing, tma_fals=
e_sharing, tma_machine_clears, tma_remote_cache",
         "ScaleUnit": "100%"
     },
     {
@@ -392,25 +517,25 @@
         "MetricName": "tma_core_bound",
         "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2=
",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations).",
+        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "44 * tma_info_system_core_frequency * (MEM_LOAD_L3_=
HIT_RETIRED.XSNP_HIT + MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM * (1 - OFFCORE_RES=
PONSE.DEMAND_DATA_RD.L3_HIT.HITM_OTHER_CORE / (OFFCORE_RESPONSE.DEMAND_DATA=
_RD.L3_HIT.HITM_OTHER_CORE + OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_H=
IT_WITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / =
2) / tma_info_thread_clks",
+        "MetricExpr": "(47.5 * tma_info_system_core_frequency - 3.5 * tma_=
info_system_core_frequency) * (MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_=
L3_HIT_RETIRED.XSNP_HITM * (1 - OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.HITM=
_OTHER_CORE / (OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.HITM_OTHER_CORE + OFF=
CORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) * (1 + MEM_LOAD_R=
ETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "BvMS;Offcore;Snoop;TopdownL4;tma_L4_group;tma_issu=
eSyncxn;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
-        "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_HIT_PS. Related metrics: tma_contested_accesses, tma=
_false_sharing, tma_machine_clears, tma_remote_cache",
+        "MetricThreshold": "tma_data_sharing > 0.05 & tma_l3_bound > 0.05 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_HIT. Related metrics: tma_bottleneck_memory_synchron=
ization, tma_contested_accesses, tma_false_sharing, tma_machine_clears, tma=
_remote_cache",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re decoder-0 was the only active decoder",
-        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cpu@INS=
T_DECODED.DECODERS\\,cmask\\=3D2@) / tma_info_core_core_clks / 2",
+        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D0x1@ - cpu@I=
NST_DECODED.DECODERS\\,cmask\\=3D0x2@) / tma_info_core_core_clks / 2",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_L4_group;tma_issueD0=
;tma_mite_group",
         "MetricName": "tma_decoder0_alone",
-        "MetricThreshold": "tma_decoder0_alone > 0.1 & (tma_mite > 0.1 & t=
ma_fetch_bandwidth > 0.2)",
+        "MetricThreshold": "tma_decoder0_alone > 0.1 & tma_mite > 0.1 & tm=
a_fetch_bandwidth > 0.2",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere decoder-0 was the only active decoder. Related metrics: tma_few_uops_in=
structions",
         "ScaleUnit": "100%"
     },
@@ -419,7 +544,7 @@
         "MetricExpr": "ARITH.DIVIDER_ACTIVE / tma_info_thread_clks",
         "MetricGroup": "BvCB;TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_divider",
-        "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
+        "MetricThreshold": "tma_divider > 0.2 & tma_core_bound > 0.1 & tma=
_backend_bound > 0.2",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_ACTIVE",
         "ScaleUnit": "100%"
     },
@@ -429,8 +554,8 @@
         "MetricExpr": "CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_thread_clk=
s + (CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_=
info_thread_clks - tma_l2_bound",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_dram_bound",
-        "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS_PS",
+        "MetricThreshold": "tma_dram_bound > 0.1 & tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS",
         "ScaleUnit": "100%"
     },
     {
@@ -439,7 +564,7 @@
         "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_dsb",
         "MetricThreshold": "tma_dsb > 0.15 & tma_fetch_bandwidth > 0.2",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here",
         "ScaleUnit": "100%"
     },
     {
@@ -447,47 +572,47 @@
         "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / tma_info_thread_=
clks",
         "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_L3_group;tma_fetch_=
latency_group;tma_issueFB",
         "MetricName": "tma_dsb_switches",
-        "MetricThreshold": "tma_dsb_switches > 0.05 & (tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS_PS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_ban=
dwidth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_=
info_inst_mix_iptb, tma_lcp",
+        "MetricThreshold": "tma_dsb_switches > 0.05 & tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwi=
dth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_inf=
o_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
-        "MetricExpr": "min(9 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D1=
@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY - CYCLE=
_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
+        "MetricExpr": "min(9 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D0=
x1@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY - CYC=
LE_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
         "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_l1_bound_group",
         "MetricName": "tma_dtlb_load",
-        "MetricThreshold": "tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_dtlb_store, tma_info_bottleneck_memory_data_tlbs, tma_info_bottleneck_me=
mory_synchronization",
+        "MetricThreshold": "tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma=
_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS. Related metrics: tma_=
bottleneck_memory_data_tlbs, tma_dtlb_store",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
-        "MetricExpr": "(9 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D1@ =
+ DTLB_STORE_MISSES.WALK_ACTIVE) / tma_info_core_core_clks",
+        "MetricExpr": "(9 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D0x1=
@ + DTLB_STORE_MISSES.WALK_ACTIVE) / tma_info_core_core_clks",
         "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_store_bound_group",
         "MetricName": "tma_dtlb_store",
-        "MetricThreshold": "tma_dtlb_store > 0.05 & (tma_store_bound > 0.2=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_dtlb_load, =
tma_info_bottleneck_memory_data_tlbs, tma_info_bottleneck_memory_synchroniz=
ation",
+        "MetricThreshold": "tma_dtlb_store > 0.05 & tma_store_bound > 0.2 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES. Related metrics: tma_bottleneck_mem=
ory_data_tlbs, tma_dtlb_load",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(110 * tma_info_system_core_frequency * (OFFCORE_RE=
SPONSE.DEMAND_RFO.L3_MISS.REMOTE_HITM + OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS.=
REMOTE_HITM) + 47.5 * tma_info_system_core_frequency * (OFFCORE_RESPONSE.DE=
MAND_RFO.L3_HIT.HITM_OTHER_CORE + OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.HITM_OT=
HER_CORE)) / tma_info_thread_clks",
-        "MetricGroup": "BvMS;DataSharing;Offcore;Snoop;TopdownL4;tma_L4_gr=
oup;tma_issueSyncxn;tma_store_bound_group",
+        "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
-        "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: MEM_LOAD_L3_HIT_=
RETIRED.XSNP_HITM_PS;OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HITM. Related=
 metrics: tma_contested_accesses, tma_data_sharing, tma_machine_clears, tma=
_remote_cache",
+        "MetricThreshold": "tma_false_sharing > 0.05 & tma_store_bound > 0=
.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: MEM_LOAD_L3_HIT_=
RETIRED.XSNP_HITM, OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.HITM_OTHER_CORE. Rela=
ted metrics: tma_bottleneck_memory_synchronization, tma_contested_accesses,=
 tma_data_sharing, tma_machine_clears, tma_remote_cache",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
-        "MetricExpr": "tma_info_memory_load_miss_real_latency * cpu@L1D_PE=
ND_MISS.FB_FULL\\,cmask\\=3D1@ / tma_info_thread_clks",
-        "MetricGroup": "BvMS;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;t=
ma_issueSL;tma_issueSmSt;tma_l1_bound_group",
+        "MetricExpr": "tma_info_memory_load_miss_real_latency * cpu@L1D_PE=
ND_MISS.FB_FULL\\,cmask\\=3D0x1@ / tma_info_thread_clks",
+        "MetricGroup": "BvMB;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;t=
ma_issueSL;tma_issueSmSt;tma_l1_bound_group",
         "MetricName": "tma_fb_full",
         "MetricThreshold": "tma_fb_full > 0.3",
-        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_bottleneck_cache_memory_bandwi=
dth, tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store=
_latency, tma_streaming_stores",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_bottleneck_cache_memory_bandwidth, =
tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store_late=
ncy",
         "ScaleUnit": "100%"
     },
     {
@@ -497,7 +622,7 @@
         "MetricName": "tma_fetch_bandwidth",
         "MetricThreshold": "tma_fetch_bandwidth > 0.2",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LA=
TENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_sw=
itches, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses, tm=
a_info_frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1, FRONTEND_RETIRED.LATE=
NCY_GE_1, FRONTEND_RETIRED.LATENCY_GE_2. Related metrics: tma_dsb_switches,=
 tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_=
frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
     },
     {
@@ -507,17 +632,17 @@
         "MetricName": "tma_fetch_latency",
         "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound >=
 0.15",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_=
16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_=
16, FRONTEND_RETIRED.LATENCY_GE_8",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring instructions that that are decoder into two or up to=
 ([SNB+] four; [ADL+] five) uops",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring instructions that that are decoder into two or more =
uops",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "tma_heavy_operations - tma_microcode_sequencer",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_heavy_operations_group;=
tma_issueD0",
         "MetricName": "tma_few_uops_instructions",
         "MetricThreshold": "tma_few_uops_instructions > 0.05 & tma_heavy_o=
perations > 0.1",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring instructions that that are decoder into two or up t=
o ([SNB+] four; [ADL+] five) uops. This highly-correlates with the number o=
f uops in such instructions. Related metrics: tma_decoder0_alone",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring instructions that that are decoder into two or more=
 uops. This highly-correlates with the number of uops in such instructions.=
 Related metrics: tma_decoder0_alone",
         "ScaleUnit": "100%"
     },
     {
@@ -527,7 +652,7 @@
         "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_gr=
oup",
         "MetricName": "tma_fp_arith",
         "MetricThreshold": "tma_fp_arith > 0.2 & tma_light_operations > 0.=
6",
-        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting.",
+        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting",
         "ScaleUnit": "100%"
     },
     {
@@ -536,7 +661,7 @@
         "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
         "MetricName": "tma_fp_assists",
         "MetricThreshold": "tma_fp_assists > 0.1",
-        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Floating Point (FP) Assists=
. FP Assist may apply when working with very small floating point values (s=
o-called Denormals).",
+        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Floating Point (FP) Assists=
. FP Assist may apply when working with very small floating point values (s=
o-called Denormals)",
         "ScaleUnit": "100%"
     },
     {
@@ -544,17 +669,17 @@
         "MetricExpr": "FP_ARITH_INST_RETIRED.SCALAR / UOPS_RETIRED.RETIRE_=
SLOTS",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_scalar",
-        "MetricThreshold": "tma_fp_scalar > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
+        "MetricThreshold": "tma_fp_scalar > 0.1 & tma_fp_arith > 0.2 & tma=
_light_operations > 0.6",
         "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, tm=
a_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_5, t=
ma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) vector uops fraction the CPU has retired aggregated across all v=
ector widths",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umas=
k\\=3D0xfc@ / UOPS_RETIRED.RETIRE_SLOTS",
+        "MetricExpr": "cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umas=
k\\=3D0xFC@ / UOPS_RETIRED.RETIRE_SLOTS",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_vector",
-        "MetricThreshold": "tma_fp_vector > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
+        "MetricThreshold": "tma_fp_vector > 0.1 & tma_fp_arith > 0.2 & tma=
_light_operations > 0.6",
         "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting. Related metrics: t=
ma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, t=
ma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
@@ -563,8 +688,8 @@
         "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.128B_PACKED_SINGLE) / UOPS_RETIRED.RETIRE_SLOTS",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_128b",
-        "MetricThreshold": "tma_fp_vector_128b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_5=
, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_fp_vector_128b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_=
1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -572,8 +697,8 @@
         "MetricExpr": "(FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.256B_PACKED_SINGLE) / UOPS_RETIRED.RETIRE_SLOTS",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_256b",
-        "MetricThreshold": "tma_fp_vector_256b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_128b, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_5=
, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_fp_vector_256b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_128b, tma_fp_vector_512b, tma_port_0, tma_port_=
1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -581,7 +706,7 @@
         "MetricExpr": "(FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.512B_PACKED_SINGLE) / UOPS_RETIRED.RETIRE_SLOTS",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_512b",
-        "MetricThreshold": "tma_fp_vector_512b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
+        "MetricThreshold": "tma_fp_vector_512b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
         "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 512-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_128b, tma_fp_vector_256b, tma_port_0, tma_port_1, tma_port_5=
, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
@@ -592,50 +717,50 @@
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "MetricgroupNoGroup": "TopdownL1",
-        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound. Sample with: FRONTE=
ND_RETIRED.LATENCY_GE_4_PS",
+        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound. Sample with: FRONTE=
ND_RETIRED.LATENCY_GE_4",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions -- where one uop can represent mu=
ltiple contiguous instructions",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions , where one uop can represent mul=
tiple contiguous instructions",
         "MetricExpr": "tma_light_operations * UOPS_RETIRED.MACRO_FUSED / U=
OPS_RETIRED.RETIRE_SLOTS",
         "MetricGroup": "Branches;BvBO;Pipeline;TopdownL3;tma_L3_group;tma_=
light_operations_group",
         "MetricName": "tma_fused_instructions",
         "MetricThreshold": "tma_fused_instructions > 0.1 & tma_light_opera=
tions > 0.6",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions -- where one uop can represent m=
ultiple contiguous instructions. CMP+JCC or DEC+JCC are common examples of =
legacy fusions. {([MTL] Note new MOV+OP and Load+OP fusions appear under Ot=
her_Light_Ops in MTL!)}",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions , where one uop can represent mu=
ltiple contiguous instructions. CMP+JCC or DEC+JCC are common examples of l=
egacy fusions. {([MTL] Note new MOV+OP and Load+OP fusions appear under Oth=
er_Light_Ops in MTL!)}",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or micro-coded sequences",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations , instructions that require =
two or more uops or micro-coded sequences",
         "MetricExpr": "(UOPS_RETIRED.RETIRE_SLOTS + UOPS_RETIRED.MACRO_FUS=
ED - INST_RETIRED.ANY) / tma_info_thread_slots",
         "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
         "MetricName": "tma_heavy_operations",
         "MetricThreshold": "tma_heavy_operations > 0.1",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or micro-coded sequences. This highly-correlates with th=
e uop length of these instructions/sequences. ([ICL+] Note this may overcou=
nt due to approximation using indirect events; [ADL+] .)",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations , instructions that require=
 two or more uops or micro-coded sequences. This highly-correlates with the=
 uop length of these instructions/sequences.([ICL+] Note this may overcount=
 due to approximation using indirect events; [ADL+])",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses",
-        "MetricExpr": "(ICACHE_16B.IFDATA_STALL + 2 * cpu@ICACHE_16B.IFDAT=
A_STALL\\,cmask\\=3D1\\,edge@) / tma_info_thread_clks",
+        "MetricExpr": "(ICACHE_16B.IFDATA_STALL + 2 * cpu@ICACHE_16B.IFDAT=
A_STALL\\,cmask\\=3D0x1\\,edge\\=3D0x1@) / tma_info_thread_clks",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;IcMiss;TopdownL3;tma_L3=
_group;tma_fetch_latency_group",
         "MetricName": "tma_icache_misses",
-        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS_PS;FRONTEND_RETIRED.L1I_MISS_PS",
+        "MetricThreshold": "tma_icache_misses > 0.05 & tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS, FRONTEND_RETIRED.L1I_MISS",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
-        "MetricExpr": "tma_info_bottleneck_mispredictions * tma_info_threa=
d_slots / BR_MISP_RETIRED.ALL_BRANCHES / 100",
+        "BriefDescription": "Branch Misprediction Cost: Cycles representin=
g fraction of TMA slots wasted per non-speculative branch misprediction (re=
tired JEClear)",
+        "MetricExpr": "tma_bottleneck_mispredictions * tma_info_thread_slo=
ts / 4 / BR_MISP_RETIRED.ALL_BRANCHES / 100",
         "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
         "MetricName": "tma_info_bad_spec_branch_misprediction_cost",
-        "PublicDescription": "Branch Misprediction Cost: Fraction of TMA s=
lots wasted per non-speculative branch misprediction (retired JEClear). Rel=
ated metrics: tma_branch_mispredicts, tma_info_bottleneck_mispredictions, t=
ma_mispredicts_resteers"
+        "PublicDescription": "Branch Misprediction Cost: Cycles representi=
ng fraction of TMA slots wasted per non-speculative branch misprediction (r=
etired JEClear). Related metrics: tma_bottleneck_mispredictions, tma_branch=
_mispredicts, tma_mispredicts_resteers"
     },
     {
-        "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
+        "BriefDescription": "Instructions per retired Mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate)",
         "MetricExpr": "tma_info_inst_mix_instructions / (UOPS_RETIRED.RETI=
RE_SLOTS / UOPS_ISSUED.ANY * BR_MISP_EXEC.INDIRECT)",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_indirect",
-        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1e3"
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1000"
     },
     {
         "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
@@ -645,7 +770,7 @@
         "MetricThreshold": "tma_info_bad_spec_ipmispredict < 200"
     },
     {
-        "BriefDescription": "Speculative to Retired ratio of all clears (c=
overing mispredicts and nukes)",
+        "BriefDescription": "Speculative to Retired ratio of all clears (c=
overing Mispredicts and nukes)",
         "MetricExpr": "INT_MISC.CLEARS_COUNT / (BR_MISP_RETIRED.ALL_BRANCH=
ES + MACHINE_CLEARS.COUNT)",
         "MetricGroup": "BrMispredicts",
         "MetricName": "tma_info_bad_spec_spec_clears_ratio"
@@ -660,8 +785,8 @@
     },
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) hits -=
 subset of the Instruction_Fetch_BW Bottleneck",
-        "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth / =
(tma_fetch_bandwidth + tma_fetch_latency)) * (tma_dsb / (tma_dsb + tma_mite=
)))",
-        "MetricGroup": "DSB;FetchBW;tma_issueFB",
+        "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth / =
(tma_fetch_latency + tma_fetch_bandwidth)) * (tma_dsb / (tma_mite + tma_dsb=
)))",
+        "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
         "MetricName": "tma_info_botlnk_l2_dsb_bandwidth",
         "MetricThreshold": "tma_info_botlnk_l2_dsb_bandwidth > 10",
         "PublicDescription": "Total pipeline cost of DSB (uop cache) hits =
- subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb_s=
witches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_front=
end_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp"
@@ -669,7 +794,7 @@
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_mite))",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_switches + t=
ma_lcp + tma_dsb_switches) + tma_fetch_bandwidth * tma_mite / (tma_mite + t=
ma_dsb))",
         "MetricGroup": "DSBmiss;Fed;tma_issueFB",
         "MetricName": "tma_info_botlnk_l2_dsb_misses",
         "MetricThreshold": "tma_info_botlnk_l2_dsb_misses > 10",
@@ -677,108 +802,10 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_switches + =
tma_lcp + tma_dsb_switches))",
         "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
         "MetricName": "tma_info_botlnk_l2_ic_misses",
-        "MetricThreshold": "tma_info_botlnk_l2_ic_misses > 5",
-        "PublicDescription": "Total pipeline cost of Instruction Cache mis=
ses - subset of the Big_Code Bottleneck. Related metrics: "
-    },
-    {
-        "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
-        "MetricGroup": "BigFootprint;BvBC;Fed;Frontend;IcMiss;MemoryTLB",
-        "MetricName": "tma_info_bottleneck_big_code",
-        "MetricThreshold": "tma_info_bottleneck_big_code > 20"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of instructions used for =
program control-flow - a subset of the Retiring category in TMA",
-        "MetricExpr": "100 * ((BR_INST_RETIRED.ALL_BRANCHES + 2 * BR_INST_=
RETIRED.NEAR_CALL + INST_RETIRED.NOP) / tma_info_thread_slots)",
-        "MetricGroup": "BvBO;Ret",
-        "MetricName": "tma_info_bottleneck_branching_overhead",
-        "MetricThreshold": "tma_info_bottleneck_branching_overhead > 5",
-        "PublicDescription": "Total pipeline cost of instructions used for=
 program control-flow - a subset of the Retiring category in TMA. Examples =
include function calls; loops and alignments. (A lower bound)"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_=
l3_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_4k_aliasing + tma_dtlb_load + tma_=
fb_full + tma_l1_hit_latency + tma_lock_latency + tma_split_loads + tma_sto=
re_fwd_blk)))",
-        "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
-        "MetricName": "tma_info_bottleneck_cache_memory_bandwidth",
-        "MetricThreshold": "tma_info_bottleneck_cache_memory_bandwidth > 2=
0",
-        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_=
system_dram_bw_use, tma_mem_bandwidth, tma_sq_full"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Latency related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_bou=
nd * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3=
_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound =
* tma_l2_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_store_bound) + tma_memory_bound * (tma_store_bound / (tma_dram_bou=
nd + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_=
store_latency / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tm=
a_store_latency)) + tma_memory_bound * (tma_l1_bound / (tma_dram_bound + tm=
a_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_l1_hit_=
latency / (tma_4k_aliasing + tma_dtlb_load + tma_fb_full + tma_l1_hit_laten=
cy + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)))",
-        "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
-        "MetricName": "tma_info_bottleneck_cache_memory_latency",
-        "MetricThreshold": "tma_info_bottleneck_cache_memory_latency > 20"=
,
-        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Latency related bottlenecks. Related metrics: tma_l3_hit_latency, tma_=
mem_latency"
-    },
-    {
-        "BriefDescription": "Total pipeline cost when the execution is com=
pute-bound - an estimation",
-        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_divider =
+ tma_ports_utilization + tma_serializing_operation) + tma_core_bound * (tm=
a_ports_utilization / (tma_divider + tma_ports_utilization + tma_serializin=
g_operation)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_ports_=
utilized_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
-        "MetricGroup": "BvCB;Cor;tma_issueComp",
-        "MetricName": "tma_info_bottleneck_compute_bound_est",
-        "MetricThreshold": "tma_info_bottleneck_compute_bound_est > 20",
-        "PublicDescription": "Total pipeline cost when the execution is co=
mpute-bound - an estimation. Covers Core Bound when High ILP as well as whe=
n long-latency execution units are busy. Related metrics: "
-    },
-    {
-        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks (when the front-end could not sustain operations =
delivery to the back-end)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches =
+ tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) - tma_mi=
crocode_sequencer / (tma_few_uops_instructions + tma_microcode_sequencer) *=
 (tma_assists / tma_microcode_sequencer) * tma_fetch_latency * (tma_ms_swit=
ches + tma_branch_resteers * (tma_clears_resteers + tma_mispredicts_resteer=
s * (10 * tma_microcode_sequencer * tma_other_mispredicts / tma_branch_misp=
redicts)) / (tma_clears_resteers + tma_mispredicts_resteers + tma_unknown_b=
ranches)) / (tma_branch_resteers + tma_dsb_switches + tma_icache_misses + t=
ma_itlb_misses + tma_lcp + tma_ms_switches)) - tma_info_bottleneck_big_code=
",
-        "MetricGroup": "BvFB;Fed;FetchBW;Frontend",
-        "MetricName": "tma_info_bottleneck_instruction_fetch_bw",
-        "MetricThreshold": "tma_info_bottleneck_instruction_fetch_bw > 20"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of irregular execution (e=
.g",
-        "MetricExpr": "100 * (tma_microcode_sequencer / (tma_few_uops_inst=
ructions + tma_microcode_sequencer) * (tma_assists / tma_microcode_sequence=
r) * tma_fetch_latency * (tma_ms_switches + tma_branch_resteers * (tma_clea=
rs_resteers + tma_mispredicts_resteers * (10 * tma_microcode_sequencer * tm=
a_other_mispredicts / tma_branch_mispredicts)) / (tma_clears_resteers + tma=
_mispredicts_resteers + tma_unknown_branches)) / (tma_branch_resteers + tma=
_dsb_switches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_swit=
ches) + 10 * tma_microcode_sequencer * tma_other_mispredicts / tma_branch_m=
ispredicts * tma_branch_mispredicts + tma_machine_clears * tma_other_nukes =
/ tma_other_nukes + tma_core_bound * (tma_serializing_operation + tma_core_=
bound * RS_EVENTS.EMPTY_CYCLES / tma_info_thread_clks * tma_ports_utilized_=
0) / (tma_divider + tma_ports_utilization + tma_serializing_operation) + tm=
a_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_sequence=
r) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
-        "MetricGroup": "Bad;BvIO;Cor;Ret;tma_issueMS",
-        "MetricName": "tma_info_bottleneck_irregular_overhead",
-        "MetricThreshold": "tma_info_bottleneck_irregular_overhead > 10",
-        "PublicDescription": "Total pipeline cost of irregular execution (=
e.g. FP-assists in HPC, Wait time with work imbalance multithreaded workloa=
ds, overhead in system services or virtualized environments). Related metri=
cs: tma_microcode_sequencer, tma_ms_switches"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_4k_aliasing + tm=
a_dtlb_load + tma_fb_full + tma_l1_hit_latency + tma_lock_latency + tma_spl=
it_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma_store_bound / (tma=
_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)=
) * (tma_dtlb_store / (tma_dtlb_store + tma_false_sharing + tma_split_store=
s + tma_store_latency)))",
-        "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
-        "MetricName": "tma_info_bottleneck_memory_data_tlbs",
-        "MetricThreshold": "tma_info_bottleneck_memory_data_tlbs > 20",
-        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store, tma_info_bottleneck_memory_synchronization"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * =
(tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) * tma_remote_cach=
e / (tma_local_mem + tma_remote_cache + tma_remote_mem) + tma_l3_bound / (t=
ma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_boun=
d) * (tma_contested_accesses + tma_data_sharing) / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / =
(tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bo=
und) * tma_false_sharing / (tma_dtlb_store + tma_false_sharing + tma_split_=
stores + tma_store_latency - tma_store_latency)) + tma_machine_clears * (1 =
- tma_other_nukes / tma_other_nukes))",
-        "MetricGroup": "BvMS;Mem;Offcore;tma_issueTLB",
-        "MetricName": "tma_info_bottleneck_memory_synchronization",
-        "MetricThreshold": "tma_info_bottleneck_memory_synchronization > 1=
0",
-        "PublicDescription": "Total pipeline cost of Memory Synchronizatio=
n related bottlenecks (data transfers and coherency updates across processo=
rs). Related metrics: tma_dtlb_load, tma_dtlb_store, tma_info_bottleneck_me=
mory_data_tlbs"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_other=
_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fetc=
h_latency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switc=
hes + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts;BvMP;tma_issueBM",
-        "MetricName": "tma_info_bottleneck_mispredictions",
-        "MetricThreshold": "tma_info_bottleneck_mispredictions > 20",
-        "PublicDescription": "Total pipeline cost of Branch Misprediction =
related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_bad_=
spec_branch_misprediction_cost, tma_mispredicts_resteers"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of remaining bottlenecks =
in the back-end",
-        "MetricExpr": "100 - (tma_info_bottleneck_big_code + tma_info_bott=
leneck_instruction_fetch_bw + tma_info_bottleneck_mispredictions + tma_info=
_bottleneck_cache_memory_bandwidth + tma_info_bottleneck_cache_memory_laten=
cy + tma_info_bottleneck_memory_data_tlbs + tma_info_bottleneck_memory_sync=
hronization + tma_info_bottleneck_compute_bound_est + tma_info_bottleneck_i=
rregular_overhead + tma_info_bottleneck_branching_overhead + tma_info_bottl=
eneck_useful_work)",
-        "MetricGroup": "BvOB;Cor;Offcore",
-        "MetricName": "tma_info_bottleneck_other_bottlenecks",
-        "MetricThreshold": "tma_info_bottleneck_other_bottlenecks > 20",
-        "PublicDescription": "Total pipeline cost of remaining bottlenecks=
 in the back-end. Examples include data-dependencies (Core Bound when Low I=
LP) and other unlisted memory-related stalls."
-    },
-    {
-        "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the portion of Retiring category not covered by Branching_Overhead nor Ir=
regular_Overhead.",
-        "MetricExpr": "100 * (tma_retiring - (BR_INST_RETIRED.ALL_BRANCHES=
 + 2 * BR_INST_RETIRED.NEAR_CALL + INST_RETIRED.NOP) / tma_info_thread_slot=
s - tma_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_se=
quencer) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)"=
,
-        "MetricGroup": "BvUW;Ret",
-        "MetricName": "tma_info_bottleneck_useful_work",
-        "MetricThreshold": "tma_info_bottleneck_useful_work > 20"
+        "MetricThreshold": "tma_info_botlnk_l2_ic_misses > 5"
     },
     {
         "BriefDescription": "Fraction of branches that are CALL or RET",
@@ -807,7 +834,7 @@
     },
     {
         "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
-        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD / 2 * (1 + CPU_CLK_UNHALTE=
D.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK) if #core_wide < 1 else (CP=
U_CLK_UNHALTED.THREAD_ANY / 2 if #SMT_on else tma_info_thread_clks))",
+        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD_ANY / 2 if #SMT_on else tm=
a_info_thread_clks)",
         "MetricGroup": "SMT",
         "MetricName": "tma_info_core_core_clks"
     },
@@ -832,14 +859,14 @@
     },
     {
         "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + cpu@FP_ARITH_INST_R=
ETIRED.128B_PACKED_DOUBLE\\,umask\\=3D0xfc@) / (2 * tma_info_core_core_clks=
)",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + cpu@FP_ARITH_INST_R=
ETIRED.128B_PACKED_DOUBLE\\,umask\\=3D0xFC@) / (2 * tma_info_core_core_clks=
)",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_core_fp_arith_utilization",
-        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
+        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)"
     },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per thread (logical-processor)",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D0x1@",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "tma_info_core_ilp"
     },
@@ -852,20 +879,20 @@
         "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses,=
 tma_info_inst_mix_iptb, tma_lcp"
     },
     {
-        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
.",
+        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
",
         "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / DSB2MITE_SWITCHE=
S.COUNT",
         "MetricGroup": "DSBmiss",
         "MetricName": "tma_info_frontend_dsb_switch_cost"
     },
     {
         "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
-        "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=3D1=
@",
+        "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=3D0=
x1@",
         "MetricGroup": "Fed;FetchBW",
         "MetricName": "tma_info_frontend_fetch_upc"
     },
     {
         "BriefDescription": "Average Latency for L1 instruction cache miss=
es",
-        "MetricExpr": "ICACHE_16B.IFDATA_STALL / cpu@ICACHE_16B.IFDATA_STA=
LL\\,cmask\\=3D1\\,edge@ + 2",
+        "MetricExpr": "ICACHE_16B.IFDATA_STALL / cpu@ICACHE_16B.IFDATA_STA=
LL\\,cmask\\=3D0x1\\,edge\\=3D0x1@ + 2",
         "MetricGroup": "Fed;FetchLat;IcMiss",
         "MetricName": "tma_info_frontend_icache_miss_latency"
     },
@@ -895,7 +922,13 @@
         "MetricName": "tma_info_frontend_l2mpki_code_all"
     },
     {
-        "BriefDescription": "Branch instructions per taken branch.",
+        "BriefDescription": "Taken Branches retired Per Cycle",
+        "MetricExpr": "BR_INST_RETIRED.NEAR_TAKEN / tma_info_thread_clks",
+        "MetricGroup": "Branches;FetchBW",
+        "MetricName": "tma_info_frontend_tbpc"
+    },
+    {
+        "BriefDescription": "Branch instructions per taken branch",
         "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
         "MetricGroup": "Branches;Fed;PGO",
         "MetricName": "tma_info_inst_mix_bptkbranch"
@@ -910,11 +943,11 @@
     {
         "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR + =
cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umask\\=3D0xfc@)",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR + =
cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umask\\=3D0xFC@)",
         "MetricGroup": "Flops;InsType",
         "MetricName": "tma_info_inst_mix_iparith",
         "MetricThreshold": "tma_info_inst_mix_iparith < 10",
-        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). Values < 1 are possible due to =
intentional FMA double counting. Approximated prior to BDW."
+        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). Values < 1 are possible due to =
intentional FMA double counting. Approximated prior to BDW"
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
@@ -922,7 +955,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx128",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx128 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). Values < 1 are =
possible due to intentional FMA double counting."
+        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). Values < 1 are =
possible due to intentional FMA double counting"
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
@@ -930,7 +963,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx256",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx256 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). Values < 1 are pos=
sible due to intentional FMA double counting."
+        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). Values < 1 are pos=
sible due to intentional FMA double counting"
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX 512-bit in=
struction (lower number means higher occurrence rate)",
@@ -938,7 +971,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx512",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx512 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX 512-bit i=
nstruction (lower number means higher occurrence rate). Values < 1 are poss=
ible due to intentional FMA double counting."
+        "PublicDescription": "Instructions per FP Arithmetic AVX 512-bit i=
nstruction (lower number means higher occurrence rate). Values < 1 are poss=
ible due to intentional FMA double counting"
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction (lower number means higher occurrence rate)",
@@ -946,7 +979,7 @@
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_dp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_dp < 10",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting."
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting"
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction (lower number means higher occurrence rate)",
@@ -954,7 +987,7 @@
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_sp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_sp < 10",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting."
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting"
     },
     {
         "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
@@ -994,7 +1027,7 @@
     },
     {
         "BriefDescription": "Instructions per Software prefetch instructio=
n (of any type: NTA/T0/T1/T2/Prefetch) (lower number means higher occurrenc=
e rate)",
-        "MetricExpr": "INST_RETIRED.ANY / cpu@SW_PREFETCH_ACCESS.T0\\,umas=
k\\=3D0xF@",
+        "MetricExpr": "INST_RETIRED.ANY / SW_PREFETCH_ACCESS.ANY",
         "MetricGroup": "Prefetches",
         "MetricName": "tma_info_inst_mix_ipswpf",
         "MetricThreshold": "tma_info_inst_mix_ipswpf < 100"
@@ -1004,7 +1037,7 @@
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
         "MetricName": "tma_info_inst_mix_iptb",
-        "MetricThreshold": "tma_info_inst_mix_iptb < 9",
+        "MetricThreshold": "tma_info_inst_mix_iptb < 4 * 2 + 1",
         "PublicDescription": "Instructions per taken branch. Related metri=
cs: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidth=
, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_lcp"
     },
     {
@@ -1051,7 +1084,7 @@
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / tma_info_system_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l1d_cache_fill_bw"
     },
@@ -1069,7 +1102,7 @@
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / tma_info_system_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l2_cache_fill_bw"
     },
@@ -1111,13 +1144,13 @@
     },
     {
         "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
-        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / duration=
_time",
+        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / tma_info=
_system_time",
         "MetricGroup": "Mem;MemoryBW;Offcore",
         "MetricName": "tma_info_memory_l3_cache_access_bw"
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / tma_info_system=
_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l3_cache_fill_bw"
     },
@@ -1136,7 +1169,7 @@
     {
         "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS.DEMAND_DATA_RD",
-        "MetricGroup": "Memory_Lat;Offcore",
+        "MetricGroup": "LockCont;Memory_Lat;Offcore",
         "MetricName": "tma_info_memory_latency_load_l2_miss_latency"
     },
     {
@@ -1192,7 +1225,7 @@
     },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per core",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else cpu@UOPS_EXECUTED.THREAD\\,cmask\\=3D1@)",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else cpu@UOPS_EXECUTED.THREAD\\,cmask\\=3D0x1@)",
         "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
         "MetricName": "tma_info_pipeline_execute"
     },
@@ -1213,18 +1246,18 @@
         "MetricExpr": "INST_RETIRED.ANY / (FP_ASSIST.ANY + OTHER_ASSISTS.A=
NY)",
         "MetricGroup": "MicroSeq;Pipeline;Ret;Retire",
         "MetricName": "tma_info_pipeline_ipassist",
-        "MetricThreshold": "tma_info_pipeline_ipassist < 100e3",
+        "MetricThreshold": "tma_info_pipeline_ipassist < 100000",
         "PublicDescription": "Instructions per a microcode Assist invocati=
on. See Assists tree node for details (lower number means higher occurrence=
 rate)"
     },
     {
-        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / cpu@UOPS_RETIRED.RETIRE=
_SLOTS\\,cmask\\=3D1@",
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / cpu@UOPS_RETIRED.RETIRE=
_SLOTS\\,cmask\\=3D0x1@",
         "MetricGroup": "Pipeline;Ret",
         "MetricName": "tma_info_pipeline_retire"
     },
     {
         "BriefDescription": "Measured Average Core Frequency for unhalted =
processors [GHz]",
-        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / dur=
ation_time",
+        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / tma=
_info_system_time",
         "MetricGroup": "Power;Summary",
         "MetricName": "tma_info_system_core_frequency"
     },
@@ -1242,29 +1275,29 @@
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / duration_time",
+        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / tma_info_system_time",
         "MetricGroup": "HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
         "MetricName": "tma_info_system_dram_bw_use",
-        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_info_bottlenec=
k_cache_memory_bandwidth, tma_mem_bandwidth, tma_sq_full"
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_bottleneck_cache_memory_ban=
dwidth, tma_fb_full, tma_mem_bandwidth, tma_sq_full"
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + 2 * FP_ARITH_INST_R=
ETIRED.128B_PACKED_DOUBLE + 4 * FP_ARITH_INST_RETIRED.4_FLOPS + 8 * FP_ARIT=
H_INST_RETIRED.8_FLOPS + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE) / 1=
e9 / duration_time",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + 2 * FP_ARITH_INST_R=
ETIRED.128B_PACKED_DOUBLE + 4 * FP_ARITH_INST_RETIRED.4_FLOPS + 8 * FP_ARIT=
H_INST_RETIRED.8_FLOPS + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE) / 1=
e9 / tma_info_system_time",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_system_gflops",
         "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width"
     },
     {
         "BriefDescription": "Average IO (network or disk) Bandwidth Use fo=
r Reads [GB / sec]",
-        "MetricExpr": "(UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 + UNC_IIO_=
DATA_REQ_OF_CPU.MEM_WRITE.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 +=
 UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3) * 4 / 1e9 / duration_time",
+        "MetricExpr": "(UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 + UNC_IIO_=
DATA_REQ_OF_CPU.MEM_WRITE.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 +=
 UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3) * 4 / 1e9 / tma_info_system_time"=
,
         "MetricGroup": "IoBW;MemOffcore;Server;SoC",
         "MetricName": "tma_info_system_io_read_bw",
         "PublicDescription": "Average IO (network or disk) Bandwidth Use f=
or Reads [GB / sec]. Bandwidth of IO reads that are initiated by end device=
 controllers that are requesting memory from the CPU"
     },
     {
         "BriefDescription": "Average IO (network or disk) Bandwidth Use fo=
r Writes [GB / sec]",
-        "MetricExpr": "(UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 + UNC_IIO_D=
ATA_REQ_OF_CPU.MEM_READ.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 + UN=
C_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3) * 4 / 1e9 / duration_time",
+        "MetricExpr": "(UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 + UNC_IIO_D=
ATA_REQ_OF_CPU.MEM_READ.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 + UN=
C_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3) * 4 / 1e9 / tma_info_system_time",
         "MetricGroup": "IoBW;MemOffcore;Server;SoC",
         "MetricName": "tma_info_system_io_write_bw",
         "PublicDescription": "Average IO (network or disk) Bandwidth Use f=
or Writes [GB / sec]. Bandwidth of IO writes that are initiated by end devi=
ce controllers that are writing memory to the CPU"
@@ -1274,13 +1307,14 @@
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
         "MetricGroup": "Branches;OS",
         "MetricName": "tma_info_system_ipfarbranch",
-        "MetricThreshold": "tma_info_system_ipfarbranch < 1e6"
+        "MetricThreshold": "tma_info_system_ipfarbranch < 1000000"
     },
     {
         "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
         "MetricGroup": "OS",
-        "MetricName": "tma_info_system_kernel_cpi"
+        "MetricName": "tma_info_system_kernel_cpi",
+        "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
@@ -1298,24 +1332,37 @@
     },
     {
         "BriefDescription": "Average number of parallel data read requests=
 to external memory",
-        "MetricExpr": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_TOR_OCC=
UPANCY.IA_MISS_DRD@thresh\\=3D1@",
+        "MetricExpr": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / cha@UNC_CHA_TOR=
_OCCUPANCY.IA_MISS_DRD\\,thresh\\=3D0x1@",
         "MetricGroup": "Mem;MemoryBW;SoC",
         "MetricName": "tma_info_system_mem_parallel_reads",
         "PublicDescription": "Average number of parallel data read request=
s to external memory. Accounts for demand loads and L1/L2 prefetches"
     },
     {
         "BriefDescription": "Average latency of data read request to exter=
nal memory (in nanoseconds)",
-        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_=
TOR_INSERTS.IA_MISS_DRD) / (tma_info_system_socket_clks / duration_time)",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_=
TOR_INSERTS.IA_MISS_DRD) / (tma_info_system_socket_clks / tma_info_system_t=
ime)",
         "MetricGroup": "Mem;MemoryLat;SoC",
         "MetricName": "tma_info_system_mem_read_latency",
         "PublicDescription": "Average latency of data read request to exte=
rnal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetche=
s. ([RKL+]memory-controller only)"
     },
+    {
+        "BriefDescription": "PerfMon Event Multiplexing accuracy indicator=
",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P / CPU_CLK_UNHALTED.THREAD=
",
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_mux",
+        "MetricThreshold": "tma_info_system_mux > 1.1 | tma_info_system_mu=
x < 0.9"
+    },
+    {
+        "BriefDescription": "Total package Power in Watts",
+        "MetricExpr": "(power@energy\\-pkg@ * 61 + 15.6 * power@energy\\-r=
am@) / (duration_time * 1e6)",
+        "MetricGroup": "Power;SoC",
+        "MetricName": "tma_info_system_power"
+    },
     {
         "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for baseline license level 0",
         "MetricExpr": "(CORE_POWER.LVL0_TURBO_LICENSE / 2 / tma_info_core_=
core_clks if #SMT_on else CORE_POWER.LVL0_TURBO_LICENSE / tma_info_core_cor=
e_clks)",
         "MetricGroup": "Power",
         "MetricName": "tma_info_system_power_license0_utilization",
-        "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for baseline license level 0.  This includes non=
-AVX codes, SSE, AVX 128-bit, and low-current AVX 256-bit codes."
+        "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for baseline license level 0.  This includes non=
-AVX codes, SSE, AVX 128-bit, and low-current AVX 256-bit codes"
     },
     {
         "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for license level 1",
@@ -1323,7 +1370,7 @@
         "MetricGroup": "Power",
         "MetricName": "tma_info_system_power_license1_utilization",
         "MetricThreshold": "tma_info_system_power_license1_utilization > 0=
.5",
-        "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for license level 1.  This includes high current=
 AVX 256-bit instructions as well as low current AVX 512-bit instructions."
+        "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for license level 1.  This includes high current=
 AVX 256-bit instructions as well as low current AVX 512-bit instructions"
     },
     {
         "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for license level 2 (introduced in SKX)",
@@ -1331,7 +1378,7 @@
         "MetricGroup": "Power",
         "MetricName": "tma_info_system_power_license2_utilization",
         "MetricThreshold": "tma_info_system_power_license2_utilization > 0=
.5",
-        "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for license level 2 (introduced in SKX).  This i=
ncludes high current AVX 512-bit instructions."
+        "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for license level 2 (introduced in SKX).  This i=
ncludes high current AVX 512-bit instructions"
     },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
@@ -1345,6 +1392,13 @@
         "MetricGroup": "SoC",
         "MetricName": "tma_info_system_socket_clks"
     },
+    {
+        "BriefDescription": "Run duration time in seconds",
+        "MetricExpr": "duration_time",
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_time",
+        "MetricThreshold": "tma_info_system_time < 1"
+    },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
         "MetricExpr": "tma_info_thread_clks / CPU_CLK_UNHALTED.REF_TSC",
@@ -1353,12 +1407,12 @@
     },
     {
         "BriefDescription": "Measured Average Uncore Frequency for the SoC=
 [GHz]",
-        "MetricExpr": "tma_info_system_socket_clks / 1e9 / duration_time",
+        "MetricExpr": "tma_info_system_socket_clks / 1e9 / tma_info_system=
_time",
         "MetricGroup": "SoC",
         "MetricName": "tma_info_system_uncore_frequency"
     },
     {
-        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
+        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Pipeline",
         "MetricName": "tma_info_thread_clks"
@@ -1367,14 +1421,15 @@
         "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
         "MetricExpr": "1 / tma_info_thread_ipc",
         "MetricGroup": "Mem;Pipeline",
-        "MetricName": "tma_info_thread_cpi"
+        "MetricName": "tma_info_thread_cpi",
+        "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "The ratio of Executed- by Issued-Uops",
         "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
         "MetricGroup": "Cor;Pipeline",
         "MetricName": "tma_info_thread_execute_per_issue",
-        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage."
+        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage"
     },
     {
         "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
@@ -1400,43 +1455,52 @@
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / BR_INST_RETIRED.NEAR_TA=
KEN",
         "MetricGroup": "Branches;Fed;FetchBW",
         "MetricName": "tma_info_thread_uptb",
-        "MetricThreshold": "tma_info_thread_uptb < 6"
+        "MetricThreshold": "tma_info_thread_uptb < 4 * 1.5"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
         "MetricExpr": "ICACHE_TAG.STALLS / tma_info_thread_clks",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;MemoryTLB;TopdownL3;tma=
_L3_group;tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
-        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS_PS;FRONTEND_RETIRED.ITLB_MISS_PS",
+        "MetricThreshold": "tma_itlb_misses > 0.05 & tma_fetch_latency > 0=
.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS, FRONTEND_RETIRED.ITLB_MISS",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 Data (L1D) cache",
         "MetricExpr": "max((CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY=
.STALLS_L1D_MISS) / tma_info_thread_clks, 0)",
         "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_issueL1;tma_issueMC;tma_memory_bound_group",
         "MetricName": "tma_l1_bound",
-        "MetricThreshold": "tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 data cache.  The L1 data cache typical=
ly has the shortest latency.  However; in certain cases like loads blocked =
on older stores; a load might suffer due to high latency even though it is =
being satisfied by the L1. Another example is loads who miss in the TLB. Th=
ese cases are characterized by execution unit stalls; while some non-comple=
ted demand load lives in the machine without having that demand load missin=
g the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT_PS;MEM_LOAD_RETIRED.FB=
_HIT_PS. Related metrics: tma_clears_resteers, tma_machine_clears, tma_micr=
ocode_sequencer, tma_ms_switches, tma_ports_utilized_1",
+        "MetricThreshold": "tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & =
tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 Data (L1D) cache.  The L1D cache typic=
ally has the shortest latency.  However; in certain cases like loads blocke=
d on older stores; a load might suffer due to high latency even though it i=
s being satisfied by the L1D. Another example is loads who miss in the TLB.=
 These cases are characterized by execution unit stalls; while some non-com=
pleted demand load lives in the machine without having that demand load mis=
sing the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT. Related metrics: t=
ma_clears_resteers, tma_machine_clears, tma_microcode_sequencer, tma_ms_swi=
tches, tma_ports_utilized_1",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric roughly estimates fraction of cyc=
les with demand load accesses that hit the L1 cache",
+        "BriefDescription": "This metric([SKL+] roughly; [LNL]) estimates =
fraction of cycles with demand load accesses that hit the L1D cache",
         "MetricExpr": "min(2 * (MEM_INST_RETIRED.ALL_LOADS - MEM_LOAD_RETI=
RED.FB_HIT - MEM_LOAD_RETIRED.L1_MISS) * 20 / 100, max(CYCLE_ACTIVITY.CYCLE=
S_MEM_ANY - CYCLE_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
         "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_l1_bound=
_group",
-        "MetricName": "tma_l1_hit_latency",
-        "MetricThreshold": "tma_l1_hit_latency > 0.1 & (tma_l1_bound > 0.1=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates fraction of cy=
cles with demand load accesses that hit the L1 cache. The short latency of =
the L1 data cache may be exposed in pointer-chasing memory access patterns =
as an example. Sample with: MEM_LOAD_RETIRED.L1_HIT",
+        "MetricName": "tma_l1_latency_dependency",
+        "MetricThreshold": "tma_l1_latency_dependency > 0.1 & tma_l1_bound=
 > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric([SKL+] roughly; [LNL]) estimates=
 fraction of cycles with demand load accesses that hit the L1D cache. The s=
hort latency of the L1D cache may be exposed in pointer-chasing memory acce=
ss patterns as an example. Sample with: MEM_LOAD_RETIRED.L1_HIT",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_RETIRED.FB_=
HIT / MEM_LOAD_RETIRED.L1_MISS) / (MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_=
RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + cpu@L1D_PEND_MISS.FB_FULL\\,cm=
ask\\=3D1@) * ((CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_M=
ISS) / tma_info_thread_clks)",
+        "MetricExpr": "MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_RETIRED.FB_=
HIT / MEM_LOAD_RETIRED.L1_MISS) / (MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_=
RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + cpu@L1D_PEND_MISS.FB_FULL\\,cm=
ask\\=3D0x1@) * ((CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2=
_MISS) / tma_info_thread_clks)",
         "MetricGroup": "BvML;CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_=
L3_group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
-        "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_RETIRED.L2_HIT_PS",
+        "MetricThreshold": "tma_l2_bound > 0.05 & tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_RETIRED.L2_HIT",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L2 cache under unloaded scenarios (poss=
ibly L2 latency limited)",
+        "MetricExpr": "3.5 * tma_info_system_core_frequency * MEM_LOAD_RET=
IRED.L2_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) =
/ tma_info_thread_clks",
+        "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_l2_bound_grou=
p",
+        "MetricName": "tma_l2_hit_latency",
+        "MetricThreshold": "tma_l2_hit_latency > 0.05 & tma_l2_bound > 0.0=
5 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L2 cache under unloaded scenarios (pos=
sibly L2 latency limited).  Avoiding L1 cache misses (i.e. L1 misses/L2 hit=
s) will improve the latency. Sample with: MEM_LOAD_RETIRED.L2_HIT",
         "ScaleUnit": "100%"
     },
     {
@@ -1444,17 +1508,17 @@
         "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_ACTIVITY.STA=
LLS_L3_MISS) / tma_info_thread_clks",
         "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
-        "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS",
+        "MetricThreshold": "tma_l3_bound > 0.05 & tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles with=
 demand load accesses that hit the L3 cache under unloaded scenarios (possi=
bly L3 latency limited)",
-        "MetricExpr": "17 * tma_info_system_core_frequency * (MEM_LOAD_RET=
IRED.L3_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2))=
 / tma_info_thread_clks",
+        "MetricExpr": "(20.5 * tma_info_system_core_frequency - 3.5 * tma_=
info_system_core_frequency) * (MEM_LOAD_RETIRED.L3_HIT * (1 + MEM_LOAD_RETI=
RED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2)) / tma_info_thread_clks",
         "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_issueLat=
;tma_l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
-        "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.0=
5 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: tm=
a_info_bottleneck_cache_memory_latency, tma_mem_latency",
+        "MetricThreshold": "tma_l3_hit_latency > 0.1 & tma_l3_bound > 0.05=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT. Related metrics: tma_b=
ottleneck_cache_memory_latency, tma_branch_resteers, tma_mem_latency, tma_s=
tore_latency",
         "ScaleUnit": "100%"
     },
     {
@@ -1462,18 +1526,18 @@
         "MetricExpr": "DECODE.LCP / tma_info_thread_clks",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group;tma_issueFB",
         "MetricName": "tma_lcp",
-        "MetricThreshold": "tma_lcp > 0.05 & (tma_fetch_latency > 0.1 & tm=
a_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses,=
 tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb",
+        "MetricThreshold": "tma_lcp > 0.05 & tma_fetch_latency > 0.1 & tma=
_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. Related metr=
ics: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidt=
h, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_info_=
inst_mix_iptb",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations -- instructions that require=
 no more than one uop (micro-operation)",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations , instructions that require =
no more than one uop (micro-operation)",
         "MetricExpr": "tma_retiring - tma_heavy_operations",
         "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
         "MetricName": "tma_light_operations",
         "MetricThreshold": "tma_light_operations > 0.6",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations -- instructions that requir=
e no more than one uop (micro-operation). This correlates with total number=
 of instructions used by the program. A uops-per-instruction (see UopPI met=
ric) ratio of 1 or less should be expected for decently optimized code runn=
ing on Intel Core/Xeon products. While this often indicates efficient X86 i=
nstructions were executed; high value does not necessarily mean better perf=
ormance cannot be achieved. ([ICL+] Note this may undercount due to approxi=
mation using indirect events; [ADL+] .). Sample with: INST_RETIRED.PREC_DIS=
T",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations , instructions that require=
 no more than one uop (micro-operation). This correlates with total number =
of instructions used by the program. A uops-per-instruction (see UopPI metr=
ic) ratio of 1 or less should be expected for decently optimized code runni=
ng on Intel Core/Xeon products. While this often indicates efficient X86 in=
structions were executed; high value does not necessarily mean better perfo=
rmance cannot be achieved. ([ICL+] Note this may undercount due to approxim=
ation using indirect events; [ADL+] .). Sample with: INST_RETIRED.PREC_DIST=
",
         "ScaleUnit": "100%"
     },
     {
@@ -1491,7 +1555,7 @@
         "MetricExpr": "tma_dtlb_load - tma_load_stlb_miss",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
         "MetricName": "tma_load_stlb_hit",
-        "MetricThreshold": "tma_load_stlb_hit > 0.05 & (tma_dtlb_load > 0.=
1 & (tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
)))",
+        "MetricThreshold": "tma_load_stlb_hit > 0.05 & tma_dtlb_load > 0.1=
 & tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%"
     },
     {
@@ -1499,24 +1563,48 @@
         "MetricExpr": "DTLB_LOAD_MISSES.WALK_ACTIVE / tma_info_thread_clks=
",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
         "MetricName": "tma_load_stlb_miss",
-        "MetricThreshold": "tma_load_stlb_miss > 0.05 & (tma_dtlb_load > 0=
.1 & (tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.=
2)))",
+        "MetricThreshold": "tma_load_stlb_miss > 0.05 & tma_dtlb_load > 0.=
1 & tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data load accesses",
+        "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLETE=
D_1G / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPLETE=
D_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
+        "MetricName": "tma_load_stlb_miss_1g",
+        "MetricThreshold": "tma_load_stlb_miss_1g > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data load accesses",
+        "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLETE=
D_2M_4M / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPL=
ETED_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
+        "MetricName": "tma_load_stlb_miss_2m",
+        "MetricThreshold": "tma_load_stlb_miss_2m > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data load accesses",
+        "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLETE=
D_4K / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPLETE=
D_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
+        "MetricName": "tma_load_stlb_miss_4k",
+        "MetricThreshold": "tma_load_stlb_miss_4k > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from local memory",
-        "MetricExpr": "59.5 * tma_info_system_core_frequency * MEM_LOAD_L3=
_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.=
L1_MISS / 2) / tma_info_thread_clks",
+        "MetricExpr": "(80 * tma_info_system_core_frequency - 20.5 * tma_i=
nfo_system_core_frequency) * MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM=
_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks=
",
         "MetricGroup": "Server;TopdownL5;tma_L5_group;tma_mem_latency_grou=
p",
         "MetricName": "tma_local_mem",
-        "MetricThreshold": "tma_local_mem > 0.1 & (tma_mem_latency > 0.1 &=
 (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2)=
))",
+        "MetricThreshold": "tma_local_mem > 0.1 & tma_mem_latency > 0.1 & =
tma_dram_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from local memory. Caching will =
improve the latency and increase performance. Sample with: MEM_LOAD_L3_MISS=
_RETIRED.LOCAL_DRAM",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
         "MetricExpr": "(12 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES * (11=
 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTAN=
DING.CYCLES_WITH_DEMAND_RFO))) / tma_info_thread_clks",
-        "MetricGroup": "Offcore;TopdownL4;tma_L4_group;tma_issueRFO;tma_l1=
_bound_group",
+        "MetricGroup": "LockCont;Offcore;TopdownL4;tma_L4_group;tma_issueR=
FO;tma_l1_bound_group",
         "MetricName": "tma_lock_latency",
-        "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_lock_latency > 0.2 & tma_l1_bound > 0.1 & =
tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_INST_RETIRED.LOCK_LOA=
DS. Related metrics: tma_store_latency",
         "ScaleUnit": "100%"
     },
@@ -1528,16 +1616,16 @@
         "MetricName": "tma_machine_clears",
         "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation=
 > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Machine Clears.  These slots are either wasted by uo=
ps fetched prior to the clear; or stalls the out-of-order portion of the ma=
chine needs to recover its state after the clear. For example; this can hap=
pen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modif=
ying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: =
tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sh=
aring, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_c=
ache",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Machine Clears.  These slots are either wasted by uo=
ps fetched prior to the clear; or stalls the out-of-order portion of the ma=
chine needs to recover its state after the clear. For example; this can hap=
pen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modif=
ying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: =
tma_bottleneck_memory_synchronization, tma_clears_resteers, tma_contested_a=
ccesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_s=
equencer, tma_ms_switches, tma_remote_cache",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clks",
-        "MetricGroup": "BvMS;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D0x4@) / tma_info_thread_clks",
+        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
         "MetricName": "tma_mem_bandwidth",
-        "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_fb_full, tma_info_bottleneck_cache=
_memory_bandwidth, tma_info_system_dram_bw_use, tma_sq_full",
+        "MetricThreshold": "tma_mem_bandwidth > 0.2 & tma_dram_bound > 0.1=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_bottleneck_cache_memory_bandwidth,=
 tma_fb_full, tma_info_system_dram_bw_use, tma_sq_full",
         "ScaleUnit": "100%"
     },
     {
@@ -1545,8 +1633,8 @@
         "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / tma_info_thread_clks - tma_mem_bandwidth",
         "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
dram_bound_group;tma_issueLat",
         "MetricName": "tma_mem_latency",
-        "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_info_bottleneck_cache_memory_latency, tma_l3_hit_la=
tency",
+        "MetricThreshold": "tma_mem_latency > 0.1 & tma_dram_bound > 0.1 &=
 tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_bottleneck_cache_memory_latency, tma_l3_hit_latency=
",
         "ScaleUnit": "100%"
     },
     {
@@ -1557,11 +1645,11 @@
         "MetricName": "tma_memory_bound",
         "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
.",
+        "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations -- uops for memory load or store a=
ccesses.",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations , uops for memory load or store ac=
cesses",
         "MetricExpr": "tma_light_operations * MEM_INST_RETIRED.ANY / INST_=
RETIRED.ANY",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_memory_operations",
@@ -1575,7 +1663,7 @@
         "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_heavy_operatio=
ns_group;tma_issueMC;tma_issueMS",
         "MetricName": "tma_microcode_sequencer",
         "MetricThreshold": "tma_microcode_sequencer > 0.05 & tma_heavy_ope=
rations > 0.1",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: IDQ.MS_UOPS. Related metrics: tma_clears_resteers,=
 tma_info_bottleneck_irregular_overhead, tma_l1_bound, tma_machine_clears, =
tma_ms_switches",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: IDQ.MS_UOPS. Related metrics: tma_bottleneck_irreg=
ular_overhead, tma_clears_resteers, tma_l1_bound, tma_machine_clears, tma_m=
s_switches",
         "ScaleUnit": "100%"
     },
     {
@@ -1583,8 +1671,8 @@
         "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.ALL=
_BRANCHES + MACHINE_CLEARS.COUNT) * INT_MISC.CLEAR_RESTEER_CYCLES / tma_inf=
o_thread_clks",
         "MetricGroup": "BadSpec;BrMispredicts;BvMP;TopdownL4;tma_L4_group;=
tma_branch_resteers_group;tma_issueBM",
         "MetricName": "tma_mispredicts_resteers",
-        "MetricThreshold": "tma_mispredicts_resteers > 0.05 & (tma_branch_=
resteers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related m=
etrics: tma_branch_mispredicts, tma_info_bad_spec_branch_misprediction_cost=
, tma_info_bottleneck_mispredictions",
+        "MetricThreshold": "tma_mispredicts_resteers > 0.05 & tma_branch_r=
esteers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related m=
etrics: tma_bottleneck_mispredictions, tma_branch_mispredicts, tma_info_bad=
_spec_branch_misprediction_cost",
         "ScaleUnit": "100%"
     },
     {
@@ -1597,12 +1685,12 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates penalty in terms of per=
centage of([SKL+] injected blend uops out of all Uops Issued -- the Count D=
omain; [ADL+] cycles)",
+        "BriefDescription": "This metric estimates penalty in terms of per=
centage of([SKL+] injected blend uops out of all Uops Issued , the Count Do=
main; [ADL+] cycles)",
         "MetricExpr": "UOPS_ISSUED.VECTOR_WIDTH_MISMATCH / UOPS_ISSUED.ANY=
",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_issueMV;tma_ports_utili=
zed_0_group",
         "MetricName": "tma_mixing_vectors",
         "MetricThreshold": "tma_mixing_vectors > 0.05",
-        "PublicDescription": "This metric estimates penalty in terms of pe=
rcentage of([SKL+] injected blend uops out of all Uops Issued -- the Count =
Domain; [ADL+] cycles). Usually a Mixing_Vectors over 5% is worth investiga=
ting. Read more in Appendix B1 of the Optimizations Guide for this topic. R=
elated metrics: tma_ms_switches",
+        "PublicDescription": "This metric estimates penalty in terms of pe=
rcentage of([SKL+] injected blend uops out of all Uops Issued , the Count D=
omain; [ADL+] cycles). Usually a Mixing_Vectors over 5% is worth investigat=
ing. Read more in Appendix B1 of the Optimizations Guide for this topic. Re=
lated metrics: tma_ms_switches",
         "ScaleUnit": "100%"
     },
     {
@@ -1610,8 +1698,8 @@
         "MetricExpr": "2 * IDQ.MS_SWITCHES / tma_info_thread_clks",
         "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fetch=
_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_issueSO",
         "MetricName": "tma_ms_switches",
-        "MetricThreshold": "tma_ms_switches > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
-        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: IDQ.MS_SWITCHES. Related metrics: tma_clears_r=
esteers, tma_info_bottleneck_irregular_overhead, tma_l1_bound, tma_machine_=
clears, tma_microcode_sequencer, tma_mixing_vectors, tma_serializing_operat=
ion",
+        "MetricThreshold": "tma_ms_switches > 0.05 & tma_fetch_latency > 0=
.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: IDQ.MS_SWITCHES. Related metrics: tma_bottlene=
ck_irregular_overhead, tma_clears_resteers, tma_l1_bound, tma_machine_clear=
s, tma_microcode_sequencer, tma_mixing_vectors, tma_serializing_operation",
         "ScaleUnit": "100%"
     },
     {
@@ -1620,7 +1708,7 @@
         "MetricGroup": "Branches;BvBO;Pipeline;TopdownL3;tma_L3_group;tma_=
light_operations_group",
         "MetricName": "tma_non_fused_branches",
         "MetricThreshold": "tma_non_fused_branches > 0.1 & tma_light_opera=
tions > 0.6",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused.",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused",
         "ScaleUnit": "100%"
     },
     {
@@ -1628,7 +1716,7 @@
         "MetricExpr": "tma_light_operations * INST_RETIRED.NOP / UOPS_RETI=
RED.RETIRE_SLOTS",
         "MetricGroup": "BvBO;Pipeline;TopdownL4;tma_L4_group;tma_other_lig=
ht_ops_group",
         "MetricName": "tma_nop_instructions",
-        "MetricThreshold": "tma_nop_instructions > 0.1 & (tma_other_light_=
ops > 0.3 & tma_light_operations > 0.6)",
+        "MetricThreshold": "tma_nop_instructions > 0.1 & tma_other_light_o=
ps > 0.3 & tma_light_operations > 0.6",
         "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring NOP (no op) instructions. Compilers often use NOPs =
for certain address alignments - e.g. start address of a function or loop b=
ody. Sample with: INST_RETIRED.NOP",
         "ScaleUnit": "100%"
     },
@@ -1642,19 +1730,19 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of slots the C=
PU was stalled due to other cases of misprediction (non-retired x86 branche=
s or other types).",
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU was stalled due to other cases of misprediction (non-retired x86 branche=
s or other types)",
         "MetricExpr": "max(tma_branch_mispredicts * (1 - BR_MISP_RETIRED.A=
LL_BRANCHES / (INT_MISC.CLEARS_COUNT - MACHINE_CLEARS.COUNT)), 0.0001)",
         "MetricGroup": "BrMispredicts;BvIO;TopdownL3;tma_L3_group;tma_bran=
ch_mispredicts_group",
         "MetricName": "tma_other_mispredicts",
-        "MetricThreshold": "tma_other_mispredicts > 0.05 & (tma_branch_mis=
predicts > 0.1 & tma_bad_speculation > 0.15)",
+        "MetricThreshold": "tma_other_mispredicts > 0.05 & tma_branch_misp=
redicts > 0.1 & tma_bad_speculation > 0.15",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Nukes (Machine Clears) not related to memory ordering=
.",
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Nukes (Machine Clears) not related to memory ordering=
",
         "MetricExpr": "max(tma_machine_clears * (1 - MACHINE_CLEARS.MEMORY=
_ORDERING / MACHINE_CLEARS.COUNT), 0.0001)",
         "MetricGroup": "BvIO;Machine_Clears;TopdownL3;tma_L3_group;tma_mac=
hine_clears_group",
         "MetricName": "tma_other_nukes",
-        "MetricThreshold": "tma_other_nukes > 0.05 & (tma_machine_clears >=
 0.1 & tma_bad_speculation > 0.15)",
+        "MetricThreshold": "tma_other_nukes > 0.05 & tma_machine_clears > =
0.1 & tma_bad_speculation > 0.15",
         "ScaleUnit": "100%"
     },
     {
@@ -1708,7 +1796,7 @@
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_5",
         "MetricThreshold": "tma_port_5 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 5 ([SNB+] Branches and ALU; [HSW+]=
 ALU). Sample with: UOPS_DISPATCHED.PORT_5. Related metrics: tma_fp_scalar,=
 tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b,=
 tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 5 ([SNB+] Branches and ALU; [HSW+]=
 ALU). Sample with: UOPS_DISPATCHED_PORT.PORT_5. Related metrics: tma_fp_sc=
alar, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_=
512b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -1717,7 +1805,7 @@
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_6",
         "MetricThreshold": "tma_port_6 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Sample with: UOPS_DISPATCHED_PORT.PORT_6. Related metrics: tma_fp_s=
calar, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector=
_512b, tma_port_0, tma_port_1, tma_port_5, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Sample with: UOPS_DISPATCHED_PORT.PORT_1. Related metrics: tma_fp_s=
calar, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector=
_512b, tma_port_0, tma_port_1, tma_port_5, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -1734,8 +1822,8 @@
         "MetricExpr": "((tma_ports_utilized_0 * tma_info_thread_clks + (EX=
E_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL)) / tma_=
info_thread_clks if ARITH.DIVIDER_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL - CY=
CLE_ACTIVITY.STALLS_MEM_ANY else (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring =
* EXE_ACTIVITY.2_PORTS_UTIL) / tma_info_thread_clks)",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
-        "MetricThreshold": "tma_ports_utilization > 0.15 & (tma_core_bound=
 > 0.1 & tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations.",
+        "MetricThreshold": "tma_ports_utilization > 0.15 & tma_core_bound =
> 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations",
         "ScaleUnit": "100%"
     },
     {
@@ -1743,8 +1831,8 @@
         "MetricExpr": "EXE_ACTIVITY.EXE_BOUND_0_PORTS / tma_info_thread_cl=
ks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
-        "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric.",
+        "MetricThreshold": "tma_ports_utilized_0 > 0.2 & tma_ports_utiliza=
tion > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric",
         "ScaleUnit": "100%"
     },
     {
@@ -1752,7 +1840,7 @@
         "MetricExpr": "((UOPS_EXECUTED.CORE_CYCLES_GE_1 - UOPS_EXECUTED.CO=
RE_CYCLES_GE_2) / 2 if #SMT_on else EXE_ACTIVITY.1_PORTS_UTIL) / tma_info_c=
ore_core_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_1",
-        "MetricThreshold": "tma_ports_utilized_1 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_ports_utilized_1 > 0.2 & tma_ports_utiliza=
tion > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere the CPU executed total of 1 uop per cycle on all execution ports (Logic=
al Processor cycles since ICL, Physical Core cycles otherwise). This can be=
 due to heavy data-dependency among software instructions; or over oversubs=
cribing a particular hardware resource. In some other cases with high 1_Por=
t_Utilized and L1_Bound; this metric can point to L1 data-cache latency bot=
tleneck that may not necessarily manifest with complete execution starvatio=
n (due to the short L1 latency e.g. walking a linked list) - looking at the=
 assembly can be helpful. Related metrics: tma_l1_bound",
         "ScaleUnit": "100%"
     },
@@ -1761,35 +1849,35 @@
         "MetricExpr": "((UOPS_EXECUTED.CORE_CYCLES_GE_2 - UOPS_EXECUTED.CO=
RE_CYCLES_GE_3) / 2 if #SMT_on else EXE_ACTIVITY.2_PORTS_UTIL) / tma_info_c=
ore_core_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
-        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & tma_ports_utiliz=
ation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
         "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. R=
elated metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_128b, tma_fp_ve=
ctor_256b, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_5, tma_port=
_6",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise).",
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise)",
         "MetricExpr": "(UOPS_EXECUTED.CORE_CYCLES_GE_3 / 2 if #SMT_on else=
 UOPS_EXECUTED.CORE_CYCLES_GE_3) / tma_info_core_core_clks",
         "MetricGroup": "BvCB;PortsUtil;TopdownL4;tma_L4_group;tma_ports_ut=
ilization_group",
         "MetricName": "tma_ports_utilized_3m",
-        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & tma_ports_utiliz=
ation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote cache in other socket=
s including synchronizations issues",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
-        "MetricExpr": "(89.5 * tma_info_system_core_frequency * MEM_LOAD_L=
3_MISS_RETIRED.REMOTE_HITM + 89.5 * tma_info_system_core_frequency * MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_FWD) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RE=
TIRED.L1_MISS / 2) / tma_info_thread_clks",
+        "MetricExpr": "((110 * tma_info_system_core_frequency - 20.5 * tma=
_info_system_core_frequency) * MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM + (110 =
* tma_info_system_core_frequency - 20.5 * tma_info_system_core_frequency) *=
 MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_=
LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "Offcore;Server;Snoop;TopdownL5;tma_L5_group;tma_is=
sueSyncxn;tma_mem_latency_group",
         "MetricName": "tma_remote_cache",
-        "MetricThreshold": "tma_remote_cache > 0.05 & (tma_mem_latency > 0=
.1 & (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > =
0.2)))",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote cache in other socke=
ts including synchronizations issues. This is caused often due to non-optim=
al NUMA allocations. #link to NUMA article. Sample with: MEM_LOAD_L3_MISS_R=
ETIRED.REMOTE_HITM_PS;MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD_PS. Related metri=
cs: tma_contested_accesses, tma_data_sharing, tma_false_sharing, tma_machin=
e_clears",
+        "MetricThreshold": "tma_remote_cache > 0.05 & tma_mem_latency > 0.=
1 & tma_dram_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote cache in other socke=
ts including synchronizations issues. This is caused often due to non-optim=
al NUMA allocations. Sample with: MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM, MEM=
_LOAD_L3_MISS_RETIRED.REMOTE_FWD. Related metrics: tma_bottleneck_memory_sy=
nchronization, tma_contested_accesses, tma_data_sharing, tma_false_sharing,=
 tma_machine_clears",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote memory",
-        "MetricExpr": "127 * tma_info_system_core_frequency * MEM_LOAD_L3_=
MISS_RETIRED.REMOTE_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.=
L1_MISS / 2) / tma_info_thread_clks",
+        "MetricExpr": "(147.5 * tma_info_system_core_frequency - 20.5 * tm=
a_info_system_core_frequency) * MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * (1 +=
 MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_=
clks",
         "MetricGroup": "Server;Snoop;TopdownL5;tma_L5_group;tma_mem_latenc=
y_group",
         "MetricName": "tma_remote_mem",
-        "MetricThreshold": "tma_remote_mem > 0.1 & (tma_mem_latency > 0.1 =
& (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
)))",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote memory. This is caus=
ed often due to non-optimal NUMA allocations. #link to NUMA article. Sample=
 with: MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS",
+        "MetricThreshold": "tma_remote_mem > 0.1 & tma_mem_latency > 0.1 &=
 tma_dram_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote memory. This is caus=
ed often due to non-optimal NUMA allocations. Sample with: MEM_LOAD_L3_MISS=
_RETIRED.REMOTE_DRAM",
         "ScaleUnit": "100%"
     },
     {
@@ -1807,7 +1895,7 @@
         "MetricExpr": "PARTIAL_RAT_STALLS.SCOREBOARD / tma_info_thread_clk=
s",
         "MetricGroup": "BvIO;PortsUtil;TopdownL3;tma_L3_group;tma_core_bou=
nd_group;tma_issueSO",
         "MetricName": "tma_serializing_operation",
-        "MetricThreshold": "tma_serializing_operation > 0.1 & (tma_core_bo=
und > 0.1 & tma_backend_bound > 0.2)",
+        "MetricThreshold": "tma_serializing_operation > 0.1 & tma_core_bou=
nd > 0.1 & tma_backend_bound > 0.2",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU issue-pipeline was stalled due to serializing operations. Instruction=
s like CPUID; WRMSR or LFENCE serialize the out-of-order execution which ma=
y limit performance. Sample with: PARTIAL_RAT_STALLS.SCOREBOARD. Related me=
trics: tma_ms_switches",
         "ScaleUnit": "100%"
     },
@@ -1817,8 +1905,8 @@
         "MetricExpr": "tma_info_memory_load_miss_real_latency * LD_BLOCKS.=
NO_SR / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_split_loads",
-        "MetricThreshold": "tma_split_loads > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary. Sample with: MEM_INST_RETIRED.SPLIT_LOADS_PS",
+        "MetricThreshold": "tma_split_loads > 0.3",
+        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary. Sample with: MEM_INST_RETIRED.SPLIT_LOADS",
         "ScaleUnit": "100%"
     },
     {
@@ -1826,17 +1914,17 @@
         "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / tma_info_core_core_=
clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
         "MetricName": "tma_split_stores",
-        "MetricThreshold": "tma_split_stores > 0.2 & (tma_store_bound > 0.=
2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_INST_RETIRED.SPLIT_STORES_PS. Related metrics: tma_port_=
4",
+        "MetricThreshold": "tma_split_stores > 0.2 & tma_store_bound > 0.2=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_INST_RETIRED.SPLIT_STORES. Related metrics: tma_port_4",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
         "MetricExpr": "(OFFCORE_REQUESTS_BUFFER.SQ_FULL / 2 if #SMT_on els=
e OFFCORE_REQUESTS_BUFFER.SQ_FULL) / tma_info_core_core_clks",
-        "MetricGroup": "BvMS;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_bound_group",
+        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_bound_group",
         "MetricName": "tma_sq_full",
-        "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_fb_full=
, tma_info_bottleneck_cache_memory_bandwidth, tma_info_system_dram_bw_use, =
tma_mem_bandwidth",
+        "MetricThreshold": "tma_sq_full > 0.3 & tma_l3_bound > 0.05 & tma_=
memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_bottlen=
eck_cache_memory_bandwidth, tma_fb_full, tma_info_system_dram_bw_use, tma_m=
em_bandwidth",
         "ScaleUnit": "100%"
     },
     {
@@ -1844,8 +1932,8 @@
         "MetricExpr": "EXE_ACTIVITY.BOUND_ON_STORES / tma_info_thread_clks=
",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_store_bound",
-        "MetricThreshold": "tma_store_bound > 0.2 & (tma_memory_bound > 0.=
2 & tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_INST_RETIRED.ALL_STORES_PS",
+        "MetricThreshold": "tma_store_bound > 0.2 & tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_INST_RETIRED.ALL_STORES",
         "ScaleUnit": "100%"
     },
     {
@@ -1853,18 +1941,18 @@
         "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_thread_clks=
",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
-        "MetricThreshold": "tma_store_fwd_blk > 0.1 & (tma_l1_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading.",
+        "MetricThreshold": "tma_store_fwd_blk > 0.1 & tma_l1_bound > 0.1 &=
 tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "(L2_RQSTS.RFO_HIT * 11 * (1 - MEM_INST_RETIRED.LOCK=
_LOADS / MEM_INST_RETIRED.ALL_STORES) + (1 - MEM_INST_RETIRED.LOCK_LOADS / =
MEM_INST_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUEST=
S_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_thread_clks",
-        "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
issueRFO;tma_issueSL;tma_store_bound_group",
+        "MetricGroup": "BvML;LockCont;MemoryLat;Offcore;TopdownL4;tma_L4_g=
roup;tma_issueRFO;tma_issueSL;tma_store_bound_group",
         "MetricName": "tma_store_latency",
-        "MetricThreshold": "tma_store_latency > 0.1 & (tma_store_bound > 0=
.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full). Related metrics: tma_fb_full, tma_lock_latency",
+        "MetricThreshold": "tma_store_latency > 0.1 & tma_store_bound > 0.=
2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full). Related metrics: tma_branch_resteers, tma_fb_full, tma_l=
3_hit_latency, tma_lock_latency",
         "ScaleUnit": "100%"
     },
     {
@@ -1880,7 +1968,7 @@
         "MetricExpr": "tma_dtlb_store - tma_store_stlb_miss",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
         "MetricName": "tma_store_stlb_hit",
-        "MetricThreshold": "tma_store_stlb_hit > 0.05 & (tma_dtlb_store > =
0.05 & (tma_store_bound > 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound=
 > 0.2)))",
+        "MetricThreshold": "tma_store_stlb_hit > 0.05 & tma_dtlb_store > 0=
.05 & tma_store_bound > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound > =
0.2",
         "ScaleUnit": "100%"
     },
     {
@@ -1888,7 +1976,31 @@
         "MetricExpr": "DTLB_STORE_MISSES.WALK_ACTIVE / tma_info_core_core_=
clks",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
         "MetricName": "tma_store_stlb_miss",
-        "MetricThreshold": "tma_store_stlb_miss > 0.05 & (tma_dtlb_store >=
 0.05 & (tma_store_bound > 0.2 & (tma_memory_bound > 0.2 & tma_backend_boun=
d > 0.2)))",
+        "MetricThreshold": "tma_store_stlb_miss > 0.05 & tma_dtlb_store > =
0.05 & tma_store_bound > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound >=
 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data store accesses",
+        "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMPLE=
TED_1G / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_COMP=
LETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
+        "MetricName": "tma_store_stlb_miss_1g",
+        "MetricThreshold": "tma_store_stlb_miss_1g > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data store accesses",
+        "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMPLE=
TED_2M_4M / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_C=
OMPLETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
+        "MetricName": "tma_store_stlb_miss_2m",
+        "MetricThreshold": "tma_store_stlb_miss_2m > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data store accesses",
+        "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMPLE=
TED_4K / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_COMP=
LETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
+        "MetricName": "tma_store_stlb_miss_4k",
+        "MetricThreshold": "tma_store_stlb_miss_4k > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%"
     },
     {
@@ -1896,7 +2008,7 @@
         "MetricExpr": "9 * BACLEARS.ANY / tma_info_thread_clks",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;TopdownL4;tma_L4_group;=
tma_branch_resteers_group",
         "MetricName": "tma_unknown_branches",
-        "MetricThreshold": "tma_unknown_branches > 0.05 & (tma_branch_rest=
eers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
+        "MetricThreshold": "tma_unknown_branches > 0.05 & tma_branch_reste=
ers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to new branch address clears. These are fetched branc=
hes the Branch Prediction Unit was unable to recognize (e.g. first time the=
 branch is fetched or hitting BTB capacity limit) hence called Unknown Bran=
ches. Sample with: BACLEARS.ANY",
         "ScaleUnit": "100%"
     },
@@ -1905,8 +2017,8 @@
         "MetricExpr": "tma_retiring * UOPS_EXECUTED.X87 / UOPS_EXECUTED.TH=
READ",
         "MetricGroup": "Compute;TopdownL4;tma_L4_group;tma_fp_arith_group"=
,
         "MetricName": "tma_x87_use",
-        "MetricThreshold": "tma_x87_use > 0.1 & (tma_fp_arith > 0.2 & tma_=
light_operations > 0.6)",
-        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint.",
+        "MetricThreshold": "tma_x87_use > 0.1 & tma_fp_arith > 0.2 & tma_l=
ight_operations > 0.6",
+        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint",
         "ScaleUnit": "100%"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json b/to=
ols/perf/pmu-events/arch/x86/skylakex/uncore-cache.json
index 4fc818626491..da46a3aeb58c 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json
@@ -4454,7 +4454,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD",
-        "Filter": "config1=3D0x4023300000000",
+        "Filter": "config1=3D0x40233",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : CRds issued by iA Cores that H=
it the LLC : Counts the number of entries successfully inserted into the TO=
R that match qualifications specified by the subevent.   Does not include a=
ddressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4465,7 +4465,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD",
-        "Filter": "config1=3D0x4043300000000",
+        "Filter": "config1=3D0x40433",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : DRds issued by iA Cores that H=
it the LLC : Counts the number of entries successfully inserted into the TO=
R that match qualifications specified by the subevent.   Does not include a=
ddressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4476,7 +4476,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefCRD",
-        "Filter": "config1=3D0x4b23300000000",
+        "Filter": "config1=3D0x4b233",
         "PerPkg": "1",
         "UMask": "0x11",
         "Unit": "CHA"
@@ -4486,7 +4486,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefDRD",
-        "Filter": "config1=3D0x4b43300000000",
+        "Filter": "config1=3D0x4b433",
         "PerPkg": "1",
         "UMask": "0x11",
         "Unit": "CHA"
@@ -4496,7 +4496,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefRFO",
-        "Filter": "config1=3D0x4b03300000000",
+        "Filter": "config1=3D0x4b033",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores =
that hit the LLC : Counts the number of entries successfully inserted into =
the TOR that match qualifications specified by the subevent.   Does not inc=
lude addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4507,7 +4507,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO",
-        "Filter": "config1=3D0x4003300000000",
+        "Filter": "config1=3D0x40033",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that H=
it the LLC : Counts the number of entries successfully inserted into the TO=
R that match qualifications specified by the subevent.   Does not include a=
ddressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4528,7 +4528,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD",
-        "Filter": "config1=3D0x4023300000000",
+        "Filter": "config1=3D0x40233",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : CRds issued by iA Cores that M=
issed the LLC : Counts the number of entries successfully inserted into the=
 TOR that match qualifications specified by the subevent.   Does not includ=
e addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4539,7 +4539,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD",
-        "Filter": "config1=3D0x4043300000000",
+        "Filter": "config1=3D0x40433",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : DRds issued by iA Cores that M=
issed the LLC : Counts the number of entries successfully inserted into the=
 TOR that match qualifications specified by the subevent.   Does not includ=
e addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4550,7 +4550,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefCRD",
-        "Filter": "config1=3D0x4b23300000000",
+        "Filter": "config1=3D0x4b233",
         "PerPkg": "1",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -4560,7 +4560,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefDRD",
-        "Filter": "config1=3D0x4b43300000000",
+        "Filter": "config1=3D0x4b433",
         "PerPkg": "1",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -4570,7 +4570,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefRFO",
-        "Filter": "config1=3D0x4b03300000000",
+        "Filter": "config1=3D0x4b033",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores =
that missed the LLC : Counts the number of entries successfully inserted in=
to the TOR that match qualifications specified by the subevent.   Does not =
include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4581,7 +4581,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
-        "Filter": "config1=3D0x4003300000000",
+        "Filter": "config1=3D0x40033",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that M=
issed the LLC : Counts the number of entries successfully inserted into the=
 TOR that match qualifications specified by the subevent.   Does not includ=
e addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4624,7 +4624,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM",
         "Experimental": "1",
-        "Filter": "config1=3D0x4903300000000",
+        "Filter": "config1=3D0x49033",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that are generated from local IO ItoM requests that mis=
s the LLC. An ItoM request is used by IIO to request a data write without f=
irst reading the data for ownership.",
         "UMask": "0x24",
@@ -4636,7 +4636,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RDCUR",
         "Experimental": "1",
-        "Filter": "config1=3D0x43c3300000000",
+        "Filter": "config1=3D0x43C33",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that are generated from local IO RdCur requests and mis=
s the LLC. A RdCur request is used by IIO to read data without changing sta=
te.",
         "UMask": "0x24",
@@ -4648,7 +4648,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RFO",
         "Experimental": "1",
-        "Filter": "config1=3D0x4003300000000",
+        "Filter": "config1=3D0x40033",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that are generated from local IO RFO requests that miss=
 the LLC. A read for ownership (RFO) requests a cache line to be cached in =
E state with the intent to modify.",
         "UMask": "0x24",
@@ -4865,7 +4865,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD",
-        "Filter": "config1=3D0x4023300000000",
+        "Filter": "config1=3D0x40233",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : CRds issued by iA Cores that=
 Hit the LLC : For each cycle, this event accumulates the number of valid e=
ntries in the TOR that match qualifications specified by the subevent.     =
Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4876,7 +4876,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD",
-        "Filter": "config1=3D0x4043300000000",
+        "Filter": "config1=3D0x40433",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRds issued by iA Cores that=
 Hit the LLC : For each cycle, this event accumulates the number of valid e=
ntries in the TOR that match qualifications specified by the subevent.     =
Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4887,7 +4887,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefCRD",
-        "Filter": "config1=3D0x4b23300000000",
+        "Filter": "config1=3D0x4b233",
         "PerPkg": "1",
         "UMask": "0x11",
         "Unit": "CHA"
@@ -4897,7 +4897,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefDRD",
-        "Filter": "config1=3D0x4b43300000000",
+        "Filter": "config1=3D0x4b433",
         "PerPkg": "1",
         "UMask": "0x11",
         "Unit": "CHA"
@@ -4907,7 +4907,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefRFO",
-        "Filter": "config1=3D0x4b03300000000",
+        "Filter": "config1=3D0x4b033",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Core=
s that hit the LLC : For each cycle, this event accumulates the number of v=
alid entries in the TOR that match qualifications specified by the subevent=
.     Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4918,7 +4918,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
-        "Filter": "config1=3D0x4003300000000",
+        "Filter": "config1=3D0x40033",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that=
 Hit the LLC : For each cycle, this event accumulates the number of valid e=
ntries in the TOR that match qualifications specified by the subevent.     =
Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4939,7 +4939,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD",
-        "Filter": "config1=3D0x4023300000000",
+        "Filter": "config1=3D0x40233",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : CRds issued by iA Cores that=
 Missed the LLC : For each cycle, this event accumulates the number of vali=
d entries in the TOR that match qualifications specified by the subevent.  =
   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4950,7 +4950,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD",
-        "Filter": "config1=3D0x4043300000000",
+        "Filter": "config1=3D0x40433",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRds issued by iA Cores that=
 Missed the LLC : For each cycle, this event accumulates the number of vali=
d entries in the TOR that match qualifications specified by the subevent.  =
   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4961,7 +4961,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefCRD",
-        "Filter": "config1=3D0x4b23300000000",
+        "Filter": "config1=3D0x4b233",
         "PerPkg": "1",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -4971,7 +4971,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
-        "Filter": "config1=3D0x4b43300000000",
+        "Filter": "config1=3D0x4b433",
         "PerPkg": "1",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -4981,7 +4981,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefRFO",
-        "Filter": "config1=3D0x4b03300000000",
+        "Filter": "config1=3D0x4b033",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Core=
s that missed the LLC : For each cycle, this event accumulates the number o=
f valid entries in the TOR that match qualifications specified by the subev=
ent.     Does not include addressless requests such as locks and interrupts=
.",
         "UMask": "0x21",
@@ -4992,7 +4992,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
-        "Filter": "config1=3D0x4003300000000",
+        "Filter": "config1=3D0x40033",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that=
 Missed the LLC : For each cycle, this event accumulates the number of vali=
d entries in the TOR that match qualifications specified by the subevent.  =
   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -5037,7 +5037,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM",
         "Experimental": "1",
-        "Filter": "config1=3D0x4903300000000",
+        "Filter": "config1=3D0x49033",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that are generated from local IO ItoM req=
uests that miss the LLC. An ItoM is used by IIO to request a data write wit=
hout first reading the data for ownership.",
         "UMask": "0x24",
@@ -5049,7 +5049,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RDCUR",
         "Experimental": "1",
-        "Filter": "config1=3D0x43c3300000000",
+        "Filter": "config1=3D0x43C33",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that are generated from local IO RdCur re=
quests that miss the LLC. A RdCur request is used by IIO to read data witho=
ut changing state.",
         "UMask": "0x24",
@@ -5061,7 +5061,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RFO",
         "Experimental": "1",
-        "Filter": "config1=3D0x4003300000000",
+        "Filter": "config1=3D0x40033",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that are generated from local IO RFO requ=
ests that miss the LLC. A read for ownership (RFO) requests data to be cach=
ed in E state with the intent to modify.",
         "UMask": "0x24",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.js=
on b/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json
index 216a00237cd1..eef801c68bd2 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json
@@ -13754,16 +13754,5 @@
         "PerPkg": "1",
         "PublicDescription": "Number outstanding register requests within =
message channel tracker",
         "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "UPI interconnect send bandwidth for payload. =
Derived from unc_upi_txl_flits.all_data",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2",
-        "EventName": "UPI_DATA_BANDWIDTH_TX",
-        "PerPkg": "1",
-        "PublicDescription": "Counts valid data FLITs (80 bit FLow control=
 unITs: 64bits of data) transmitted (TxL) via any of the 3 Intel(R) Ultra P=
ath Interconnect (UPI) slots on this UPI unit.",
-        "ScaleUnit": "7.11E-06Bytes",
-        "UMask": "0xf",
-        "Unit": "UPI"
     }
 ]
--=20
2.48.1.362.g079036d154-goog

