Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCC629405
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 00:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749686576; cv=none; b=ZZSQ5w0baFTkSa68Rzm84mhNfm2u85C6pB9clzDMlOOGQv/+RBkAm2W4SUE1/W6JXnhVtrxyhfIk88tdIuTxpcyGgLkCQVycw2XneZRoQrANz91jeiOAr9CDbAEC+hQVoH8kgQvQfXcz8Oe0HuVQW8ZTyzf0wfSYhKuRx6n6tcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749686576; c=relaxed/simple;
	bh=ZTw885Bem4ZCCLHyNKZ+Pmul2MdJOpY/XTcwfAwNl94=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=IgFYbUPCl+8YYNh745qIItHPH6jYP1TAg0CoHEdvITaTaWGFyR0p6NaxUquPkJjZzD+W2vmylaHkD7d7uWUw9GqzPJdIR/s9bWVfyF4h59FvqlT700KsS4u1/RCHswKF6FCj8k531OWlBHUtojxYzZ47Oj1OdP9QDtO0LucpDR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zLRcNWvV; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zLRcNWvV"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2eeff19115so331291a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 17:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749686574; x=1750291374; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UofBpNxuqYU4CCinw74izIvpf3M2T/dM2DLx90SqXC0=;
        b=zLRcNWvVk9uAXLAUfPOnolN4/qd/xHLqEUHLwzXwF6wWe17I+ndJCRc0iFvZxIkMSY
         nJ/JflJxMOwd5uRzQnzsSNy3UNptr57YNCtqF3bvSJDaOx9CgdDQYV6RGMPlz4s1b734
         eacZTGpLHV6CuBRZW9AkeKtZ79Qd8V8J16f/zoIgpwDrlzr01sRNseWUuYGAiV5ed8dQ
         IyaN9ymwQ1CwBRiZL8dRbs0QzAA58zAo2AUAXRLKy5Qzx/DGmZphAIcXkCzFDNf2+1k1
         bwjCc5LdGRvD2npU1mJv3FecsA9/naVG5Mhwvr/ClcPr+fQwdXR7TxHoGJi6gnQGpyzA
         3q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749686574; x=1750291374;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UofBpNxuqYU4CCinw74izIvpf3M2T/dM2DLx90SqXC0=;
        b=ZbyNIUTi0x3n8cUup2me3Z4EMhPyxKi9SObKyQoZFMM3OOLAPsPJdP5PBj9lmiZSyf
         t+WSXS3SS5OSSmozf7F8TnkSgzWbDFsbgptMiqXJ4IRtP72DN/R3Th1IgsjInExfNKof
         rFPFeQEv8miOIc/OC9bgOTxcka/TxGwXJg0tkGnHScVopydpIALDQuSW/Leb7wkDZ8fx
         bT86hNBVhM7yqk/f/CGkjcTtnNTYaJ4hzovNrdUA6gA+dB1IZtvTU3T2WWuj1Jw8Z/Ne
         Fezpjk1r6+wijHB7WwqXhK2DmwptHFftr9g9UycDMP5Iuwhqtxjo+zRXn0fXU1Jy4Yzl
         oi4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDD6a/hUZmoVajPhqDBXZwjezudRIV/pitxI9iE9h4oryJ6FU9TwFfLoz+o3ajMLd58e7oqNkYYjvag/Y1nb9k@vger.kernel.org
X-Gm-Message-State: AOJu0YzKNg3nTvGxxkEt6X0bQ77BjgQ07GKS8eu6d9O3Ettg2FKd4THB
	+oGv/YbTZZwWtIJ3oR5X9nMukf9fu2u9P+ogFTUqsvqoMgv6qDOUCi/nYhXS7AyBIrkQRLDRqZw
	xtpF39LpDiA==
X-Google-Smtp-Source: AGHT+IELMRMyXAYBNaCfyTohlmDUnovz0/5zH/pZhnykhNn3/U14IsMnC9rzdOYCy72sMsvq20UTC7VMFhDL
X-Received: from pji15.prod.google.com ([2002:a17:90b:3fcf:b0:312:f88d:25f6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e45:b0:313:c1e9:9352
 with SMTP id 98e67ed59e1d1-313c1e993f6mr603237a91.8.1749686573771; Wed, 11
 Jun 2025 17:02:53 -0700 (PDT)
Date: Wed, 11 Jun 2025 17:02:22 -0700
In-Reply-To: <20250612000224.780337-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250612000224.780337-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250612000224.780337-14-irogers@google.com>
Subject: [PATCH v1 13/15] perf vendor events: Update SierraForest events
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
Content-Transfer-Encoding: quoted-printable

Update events from v1.09 to v1.11.

Bring in the event updates v1.11:
https://github.com/intel/perfmon/commit/6b824df1dba3948146281c8ba2a8c3e7bf7=
f7c51
https://github.com/intel/perfmon/commit/4b0346fbee2b04dd34526522250116aee52=
5c922

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../arch/x86/sierraforest/frontend.json       | 64 +++++++++++++++++++
 .../arch/x86/sierraforest/pipeline.json       |  8 +++
 .../arch/x86/sierraforest/srf-metrics.json    | 48 ++++++++++++++
 .../arch/x86/sierraforest/uncore-cache.json   |  6 +-
 .../x86/sierraforest/uncore-interconnect.json | 53 ++++++++++++---
 .../arch/x86/sierraforest/uncore-io.json      | 27 +++++++-
 7 files changed, 194 insertions(+), 14 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 13eaed97b4ac..54c2cfb0af9c 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -30,7 +30,7 @@ GenuineIntel-6-CC,v1.00,pantherlake,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.28,sapphirerapids,core
-GenuineIntel-6-AF,v1.09,sierraforest,core
+GenuineIntel-6-AF,v1.11,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
 GenuineIntel-6-55-[01234],v1.36,skylakex,core
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/frontend.json b/to=
ols/perf/pmu-events/arch/x86/sierraforest/frontend.json
index fef5cba533bb..8a591e31d331 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/frontend.json
@@ -8,6 +8,54 @@
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged with having preceded with frontend bound behavior",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ALL",
+        "SampleAfterValue": "1000003"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction retired that=
 are tagged after a branch instruction causes bubbles/empty issue slots due=
 to a baclear",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.BRANCH_DETECT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction retired that=
 are tagged after a branch instruction causes bubbles /empty issue slots du=
e to a btclear",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.BRANCH_RESTEER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged following an ms flow due to the bubble/wasted issue slot from=
 exiting long ms flow",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.CISC",
+        "PublicDescription": "Counts the number of  instructions retired t=
hat were tagged following an ms flow due to the bubble/wasted issue slot fr=
om exiting long ms flow",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged every cycle the decoder is unable to send 3 uops per cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.DECODE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to ica=
che miss",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ICACHE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to ITL=
B miss",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -16,6 +64,22 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x10"
     },
+    {
+        "BriefDescription": "Counts the number of instruction retired tagg=
ed after a wasted issue slot if none of the previous events occurred",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.OTHER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction retired that=
 are tagged after a branch instruction causes bubbles/empty issue slots due=
 to a predecode wrong.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.PREDECODE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Counts every time the code stream enters into=
 a new cache line by walking sequential from the previous line or being red=
irected by a jump.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/sierraforest/pipeline.json
index f56d8d816e53..70af13143024 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
@@ -11,6 +11,7 @@
     {
         "BriefDescription": "Counts the total number of branch instruction=
s retired for all branch types.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Errata": "SRF6, SRF7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PublicDescription": "Counts the total number of instructions in w=
hich the instruction pointer (IP) of the processor is resteered due to a br=
anch instruction and the branch instruction successfully retires.  All bran=
ch type instructions are accounted for.",
@@ -19,6 +20,7 @@
     {
         "BriefDescription": "Counts the number of retired JCC (Jump on Con=
ditional Code) branch instructions retired, includes both taken and not tak=
en branches.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Errata": "SRF7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND",
         "SampleAfterValue": "200003",
@@ -35,6 +37,7 @@
     {
         "BriefDescription": "Counts the number of far branch instructions =
retired, includes far jump, far call and return, and interrupt call and ret=
urn.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Errata": "SRF7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "SampleAfterValue": "200003",
@@ -43,6 +46,7 @@
     {
         "BriefDescription": "Counts the number of near indirect JMP and ne=
ar indirect CALL branch instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Errata": "SRF7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT",
         "SampleAfterValue": "200003",
@@ -51,6 +55,7 @@
     {
         "BriefDescription": "Counts the number of near indirect CALL branc=
h instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Errata": "SRF7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT_CALL",
         "SampleAfterValue": "200003",
@@ -68,6 +73,7 @@
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.INDIRECT_CALL",
         "Counter": "0,1,2,3,4,5,6,7",
         "Deprecated": "1",
+        "Errata": "SRF7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.IND_CALL",
         "SampleAfterValue": "200003",
@@ -76,6 +82,7 @@
     {
         "BriefDescription": "Counts the number of near CALL branch instruc=
tions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Errata": "SRF6, SRF7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
         "SampleAfterValue": "200003",
@@ -92,6 +99,7 @@
     {
         "BriefDescription": "Counts the number of near taken branch instru=
ctions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Errata": "SRF7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
         "SampleAfterValue": "200003",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json b=
/tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json
index ef629e4e91ce..b9f3c611d87b 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json
@@ -61,6 +61,18 @@
         "MetricName": "cpi",
         "ScaleUnit": "1per_instr"
     },
+    {
+        "BriefDescription": "The average number of cores that are in cstat=
e C0 as observed by the power control unit (PCU)",
+        "MetricExpr": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C0 / pcu_0@UNC_P_=
CLOCKTICKS@ * #num_packages",
+        "MetricGroup": "cpu_cstate",
+        "MetricName": "cpu_cstate_c0"
+    },
+    {
+        "BriefDescription": "The average number of cores that are in cstat=
e C6 as observed by the power control unit (PCU)",
+        "MetricExpr": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C6 / pcu_0@UNC_P_=
CLOCKTICKS@ * #num_packages",
+        "MetricGroup": "cpu_cstate",
+        "MetricName": "cpu_cstate_c6"
+    },
     {
         "BriefDescription": "CPU operating frequency (in GHz)",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC =
* #SYSTEM_TSC_FREQ / 1e9",
@@ -112,6 +124,12 @@
         "MetricName": "io_bandwidth_read",
         "ScaleUnit": "1MB/s"
     },
+    {
+        "BriefDescription": "Bandwidth of inbound IO reads that are initia=
ted by end device controllers that are requesting memory from the CPU and m=
iss the L3 cache",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_MISS_PCIRDCUR * 64 / 1e6 / d=
uration_time",
+        "MetricName": "io_bandwidth_read_l3_miss",
+        "ScaleUnit": "1MB/s"
+    },
     {
         "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the local CPU socket"=
,
         "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR_LOCAL * 64 / 1e6 / =
duration_time",
@@ -130,6 +148,12 @@
         "MetricName": "io_bandwidth_write",
         "ScaleUnit": "1MB/s"
     },
+    {
+        "BriefDescription": "Bandwidth of inbound IO writes that are initi=
ated by end device controllers that are writing memory to the CPU",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_MISS_ITOM + UNC_CHA_TOR_INS=
ERTS.IO_MISS_ITOMCACHENEAR) * 64 / 1e6 / duration_time",
+        "MetricName": "io_bandwidth_write_l3_miss",
+        "ScaleUnit": "1MB/s"
+    },
     {
         "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the local CPU socket",
         "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_ITOM_LOCAL + UNC_CHA_TOR_IN=
SERTS.IO_ITOMCACHENEAR_LOCAL) * 64 / 1e6 / duration_time",
@@ -142,6 +166,30 @@
         "MetricName": "io_bandwidth_write_remote",
         "ScaleUnit": "1MB/s"
     },
+    {
+        "BriefDescription": "The percent of inbound full cache line writes=
 initiated by IO that miss the L3 cache",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM / UNC_CHA_TOR_INSE=
RTS.IO_ITOM",
+        "MetricName": "io_full_write_l3_miss",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Message Signaled Interrupts (MSI) per second =
sent by the integrated I/O traffic controller (IIO) to System Configuration=
 Controller (Ubox)",
+        "MetricExpr": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.UBOX_POSTED / duratio=
n_time",
+        "MetricName": "io_msi",
+        "ScaleUnit": "1per_sec"
+    },
+    {
+        "BriefDescription": "The percent of inbound partial writes initiat=
ed by IO that miss the L3 cache",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_MISS_ITOMCACHENEAR + UNC_CH=
A_TOR_INSERTS.IO_MISS_RFO) / (UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR + UNC_CH=
A_TOR_INSERTS.IO_RFO)",
+        "MetricName": "io_partial_write_l3_miss",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "The percent of inbound reads initiated by IO =
that miss the L3 cache",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_MISS_PCIRDCUR / UNC_CHA_TOR_=
INSERTS.IO_PCIRDCUR",
+        "MetricName": "io_read_l3_miss",
+        "ScaleUnit": "100%"
+    },
     {
         "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total n=
umber of completed instructions",
         "MetricExpr": "ITLB_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRED.ANY=
",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json =
b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
index 7182ca00ef8d..3d1fb5f0417e 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
@@ -874,7 +874,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Counts snoop filter capacity evictions for en=
tries tracking exclusive lines in the cores? cache.? Snoop filter capacity =
evictions occur when the snoop filter is full and evicts an existing entry =
to track a new entry.? Does not count clean evictions such as when a core?s=
 cache replaces a tracked cacheline with a new cacheline.",
+        "BriefDescription": "Counts snoop filter capacity evictions for en=
tries tracking exclusive lines in the core's cache. Snoop filter capacity e=
victions occur when the snoop filter is full and evicts an existing entry t=
o track a new entry. Does not count clean evictions such as when a core's c=
ache replaces a tracked cacheline with a new cacheline.",
         "Counter": "0,1,2,3",
         "EventCode": "0x3d",
         "EventName": "UNC_CHA_SF_EVICTION.E_STATE",
@@ -885,7 +885,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Counts snoop filter capacity evictions for en=
tries tracking modified lines in the cores? cache.? Snoop filter capacity e=
victions occur when the snoop filter is full and evicts an existing entry t=
o track a new entry.? Does not count clean evictions such as when a core?s =
cache replaces a tracked cacheline with a new cacheline.",
+        "BriefDescription": "Counts snoop filter capacity evictions for en=
tries tracking modified lines in the core's cache. Snoop filter capacity ev=
ictions occur when the snoop filter is full and evicts an existing entry to=
 track a new entry. Does not count clean evictions such as when a core's ca=
che replaces a tracked cacheline with a new cacheline.",
         "Counter": "0,1,2,3",
         "EventCode": "0x3d",
         "EventName": "UNC_CHA_SF_EVICTION.M_STATE",
@@ -895,7 +895,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Counts snoop filter capacity evictions for en=
tries tracking shared lines in the cores? cache.? Snoop filter capacity evi=
ctions occur when the snoop filter is full and evicts an existing entry to =
track a new entry.? Does not count clean evictions such as when a core?s ca=
che replaces a tracked cacheline with a new cacheline.",
+        "BriefDescription": "Counts snoop filter capacity evictions for en=
tries tracking shared lines in the core's cache. Snoop filter capacity evic=
tions occur when the snoop filter is full and evicts an existing entry to t=
rack a new entry. Does not count clean evictions such as when a core's cach=
e replaces a tracked cacheline with a new cacheline.",
         "Counter": "0,1,2,3",
         "EventCode": "0x3d",
         "EventName": "UNC_CHA_SF_EVICTION.S_STATE",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnec=
t.json b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.js=
on
index 2ccbc8bca24e..952b6de3fefc 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json
@@ -1562,21 +1562,56 @@
         "Unit": "UPI"
     },
     {
-        "BriefDescription": "Tx Flit Buffer Allocations : Number of alloca=
tions into the UPI Tx Flit Buffer.  Generally, when data is transmitted acr=
oss UPI, it will bypass the TxQ and pass directly to the link.  However, th=
e TxQ will be used with L0p and when LLR occurs, increasing latency to tran=
sfer out to the link.  This event can be used in conjunction with the Flit =
Buffer Occupancy event in order to calculate the average flit buffer lifeti=
me.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x40",
-        "EventName": "UNC_UPI_TxL_INSERTS",
+        "BriefDescription": "Message Received : Doorbell",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.DOORBELL_RCVD",
         "Experimental": "1",
         "PerPkg": "1",
-        "Unit": "UPI"
+        "UMask": "0x8",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "Tx Flit Buffer Occupancy : Accumulates the nu=
mber of flits in the TxQ.  Generally, when data is transmitted across UPI, =
it will bypass the TxQ and pass directly to the link.  However, the TxQ wil=
l be used with L0p and when LLR occurs, increasing latency to transfer out =
to the link. This can be used with the cycles not empty event to track aver=
age occupancy, or the allocations event to track average lifetime in the Tx=
Q.",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Message Received : Interrupt",
+        "Counter": "0,1",
         "EventCode": "0x42",
-        "EventName": "UNC_UPI_TxL_OCCUPANCY",
+        "EventName": "UNC_U_EVENT_MSG.INT_PRIO",
         "Experimental": "1",
         "PerPkg": "1",
-        "Unit": "UPI"
+        "PublicDescription": "Message Received : Interrupt : Interrupts",
+        "UMask": "0x10",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Message Received : IPI",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.IPI_RCVD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Message Received : IPI : Inter Processor Int=
errupts",
+        "UMask": "0x4",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Message Received : MSI",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.MSI_RCVD",
+        "PerPkg": "1",
+        "PublicDescription": "Message Received : MSI : Message Signaled In=
terrupts - interrupts sent by devices (including PCIe via IOxAPIC) (Socket =
Mode only)",
+        "UMask": "0x2",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Message Received : VLW",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.VLW_RCVD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Message Received : VLW : Virtual Logical Wir=
e (legacy) message were received from Uncore.",
+        "UMask": "0x1",
+        "Unit": "UBOX"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-io.json b/t=
ools/perf/pmu-events/arch/x86/sierraforest/uncore-io.json
index 886b99a971be..f4f956966e16 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-io.json
@@ -1121,8 +1121,9 @@
         "Unit": "IIO"
     },
     {
-        "BriefDescription": "Occupancy of outbound request queue : To devi=
ce : Counts number of outbound requests/completions IIO is currently proces=
sing",
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to UNC_IIO_NUM_OUTSTANDING_REQ_FROM_CPU.TO_IO]",
         "Counter": "2,3",
+        "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "UNC_IIO_NUM_OUSTANDING_REQ_FROM_CPU.TO_IO",
         "Experimental": "1",
@@ -1132,6 +1133,18 @@
         "UMask": "0x8",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "Occupancy of outbound request queue : To devi=
ce : Counts number of outbound requests/completions IIO is currently proces=
sing [This event is alias to UNC_IIO_NUM_OUSTANDING_REQ_FROM_CPU.TO_IO]",
+        "Counter": "2,3",
+        "EventCode": "0xc5",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_FROM_CPU.TO_IO",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "Passing data to be written",
         "Counter": "0,1,2,3",
@@ -1300,6 +1313,18 @@
         "UMask": "0x4",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "Posted requests sent by the integrated IO (II=
O) controller to the Ubox, useful for counting message signaled interrupts =
(MSI).",
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
--=20
2.50.0.rc1.591.g9c95f17f64-goog

