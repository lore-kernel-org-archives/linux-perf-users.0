Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7304B2D12F7
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301093; cv=none; b=DRwUMXaZrAgE7K49Lih7v2pyxSGO9Zw9IqkUV9ywYfKMzi4hpqZRQjR5csPmScFFeAg0U9So260xVb4pATWGpxSkCLmneLrLMBmn74poS/S0/EYfWvUjCdvn3TW/t0dLWZu5mqTd7OCSXiS87m7tRv7h5X/MvhNZ3mihLGtf2sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301093; c=relaxed/simple;
	bh=/TcY5PWtS4ptdwvaZVGEWXrFFFGxyIAuGIyLOJsAybU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=miPA2PhWEfdmRhe0E3DH51wMd+AqlM6HezvH0eITI5bIuqhslaz8Uqc1uBEGK4glfJ1XJdWDfkiW428tL98vpvQqaUcvkc87TNvwnX/s3cmSGaFYX2+k54UDaIE0anNjz9Bsnqaj2bmJraqLZZyUsdYSGaTJoZQp4kFPpdgVZvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T7aSLXHB; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T7aSLXHB"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2eb887a2109so2853245fac.2
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 09:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751301089; x=1751905889; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FX/ABbkv9BuddTyObC39bd9UBLO+quC+AfP/r3yCtyg=;
        b=T7aSLXHBdHU3dLXOiRpMbhgpYuqn0Ffc119j5JpJpiZbhCnwQq7KR21NDtTXEvihTo
         AplrKAratrSKe5/6dAbXpffL0OIkIJkGeXhHFxBvUML8jaThkyPhrAnIx+6iWZwFczn8
         AvfHX7CwaFzcJ3dnfMIofAmeD1eogDpGko+//aXIO9s4/NS8Awk3ch04fJbC361Zx05V
         oLMt8xQD49sE5G/S/aAMdWics6MaBdVTzCdQueFmy8EM9b9/+wy1u4tL40wpTVKphXKf
         4xiX4oWg41irAM/EgtR94cpX0yNUAf3QIuqlcwUn7c41q9YL6vvYdX0+jf9Gtqn0/ttM
         ftKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301089; x=1751905889;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FX/ABbkv9BuddTyObC39bd9UBLO+quC+AfP/r3yCtyg=;
        b=eUomzOArnjymHZyMLhELayBIncCTbGIUtUQjmti5LGzLaIwOxKKaAm6npteG/I4ilO
         3pWvDnjiLPYhxXcffOvK5awBtNb/z8OCLzoC+jalIDqtpX97b2a759YlREoCrbsQLV5Y
         RvOOQ+LtSFmTczVvxapyaaPZOxuc9amGkX3wh2EfOmFKQ1cNYCCh3WvOdv8oKp6YUFhR
         QsRLiJMgCveVVOIZvI1BkC9OrkPknmxB8lumPlAnGQ+Z/owxLj2jEgdfwplmmBN+fBT0
         D2oMs2f1V7N5ZwCuqaFmr9p3XTeiQSJAjOYRm82+Fd+koAG7KZla/4ecFKaV9USxmroN
         64Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXZDsCrwf4WlGomQdARW+zYxdQaG34dbPGjfnXnlftgLnXa5GoNBFi7koFWdF5IWyNsOr22HY2Oao2rcUTSi7uJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+/ZF85j3ScYyXTMW3sAX2z3bTJ8iBo7G5seCy5qxhl+8Yr7L2
	e6mEOPu+w3Au/AIuE3YpqO2R4Bz1D3POqMV7INAjVpwBtkX60NE2N6fvx2e4cuG1hrmOyDXV/yG
	iupvar/bRDQ==
X-Google-Smtp-Source: AGHT+IGP+dW5JJKzFKLXxy/HlO3yMx/cBi7s4H8RkP367OSZjHpjGrd1N3bNbsq4XivT50vo+JKDmX1Oa8h+
X-Received: from oabrd10.prod.google.com ([2002:a05:6871:620a:b0:295:ef58:6002])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:109:b0:2bd:455e:c22e
 with SMTP id 586e51a60fabf-2efed6a5c5emr10257932fac.19.1751301089498; Mon, 30
 Jun 2025 09:31:29 -0700 (PDT)
Date: Mon, 30 Jun 2025 09:30:58 -0700
In-Reply-To: <20250630163101.1920170-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630163101.1920170-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630163101.1920170-14-irogers@google.com>
Subject: [PATCH v2 13/15] perf vendor events: Update SierraForest events
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
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
2.50.0.727.gbf7dc18ff4-goog

