Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561C420B7EB
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484236; cv=none; b=X47PFhYqHQaPHzthOu7Vfecv2kcJuHhaA6xoX1bSgpbSToQ9fjSvPAocEPlP2DSV3/PBZU36Nsud2yYkwTs3J/4MZ992uifP8sE1rzWRxcJpyHzQgi+nmPtpbJG715dZYgCy+bzOlCkUCpboOs66OrQ0IRExBpEHP1zvPBW6ucA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484236; c=relaxed/simple;
	bh=7UWzz/kHUGkRXwxaH3cOfq/XM/zfVy5YfESVFo6RKEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJrDDX6iDlWtAb0ly0s+UbQDH1EwKCvFg+h2dIpnFcNbRKucmbTXxRIDyGr+Mg/OktIzwS9lQWZqhZMAdGNIRji1iBX5SuA8XHhhp1HsIJGu+Av6YVUwQE48k8L6Q4Cjg0j1Ck7pQ7q5y+oA5SPB7zM9LOIxzAPoXICRpnflwhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KPJ6t7H+; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KPJ6t7H+"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fc261d4ec4so1034220a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 14:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1739484233; x=1740089033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UG2nUTyFuD2bRxBTq88e6guJsvcgmcc0Y542suaRIS4=;
        b=KPJ6t7H+a2ApDRr1lfM22oli+1YAVt0TZuRgAm7BEPSbE5GcAnu5P+5NqT7WLNhxCg
         giApm9RyPTKOHOqJ8+R7wmkxcF1VbN5899GvB612g2bvKfDP+ejSn+u1GO1K9kLKK3wq
         kvfUMoOBPh3QKmCgPVCWxsq/02D7VFIhikOqmBVxl6mzdVazJiQwgtArSEtJ8YDJ7gEs
         lJ0+mU4HoDYOaSyWf5ylQfBrFU5HWb4y8XmVUVui/+l2POd2/npUoLUvlGXpZl3v0CUv
         faTPktDt/H0BUbxGP8/MaKh48Rz/4Oy5eo9NTaNoEzBOhpC8+bVLkUWEptrtwtrjU/IX
         qRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739484233; x=1740089033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UG2nUTyFuD2bRxBTq88e6guJsvcgmcc0Y542suaRIS4=;
        b=U4RT29tDFxozKdyOVzuA+FWthw9ug981YSPah7KvbsXOpONvEmi7ibx5ROb9aJvC62
         1M08ka0SLbkmAr3Wp8wHdJTvGFP9QaLTdY9wnC8qOZanM34zj46SaKxk4xJj4fCmLvd2
         fIUv/5W/8nmb2dE4HadzSJI7Ttcx0FMd18Trp2Orw9aDvuPLer427onf5cgaldE5iZGn
         Ldb7if6hhgr3iuA7hwS03JQDi5TqxfuCdeAV9NuqvKcAkYfuTdKwrcisEwBOnT+97eES
         N6ly9RLzRioGdbZWHHaleBkO7RnoRV6eezPOIt0LxYmdBfiWmwPxuF3JiTI1yiTzvx4A
         IoOA==
X-Forwarded-Encrypted: i=1; AJvYcCXacrBfVvRKJfAFwkYSbq2wRmpLywaBDsrpewquKWsNdkqh7cbdiTbHxBmg+7/GlRqOgq6fyy7ck7JS524ZfPst@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/VJYGRH3nOht05a1Fsi06Wek7z7XJCfKb+eScfn893+1fnFNU
	NCMyf21QKS3hVoTDOQSbNpZf/9U0XvjS6UR6aWmalLhEGSQLVQIqBuLgDVrJTLs=
X-Gm-Gg: ASbGnct+kto1mpLW9ugcQfoQvxhPlbGVmrzXUlBLsvIkWVfNsdA36gRYGxwwUM7T1xl
	Sm0j70Y5jXvQdPfMVz++XExFxxxZLrILKXk6ZcgEUz/1ZnUZit3dM69182DPekLB3MDRFp9ZBL/
	tlneY87/PgLKrnkVWZTBh0K9JzMy7qt+c0Vdx8D9bc+ZtBYU6nEIaXvW173xbxnLLfHwdyQaO9Q
	EU7RZzOkFXT+OEbL0BBHlZ+0DrJdimok2K4+iAEAgYHcC2NYXAZgpl0EpFcLipX97GGjvAzMz9C
	LZV9Z2j7o+Ft71RSRnJqfcAmJmUBa5FYrJ1s6w==
X-Google-Smtp-Source: AGHT+IHkEtK2WtSJediFZTvGiONr45YnHwEk70ZnPDsoNzA31ly3EjT2ofcGhhgCoHTMyKTliYHMHw==
X-Received: by 2002:a05:6a00:2e84:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-7322c373ebamr16624287b3a.3.1739484233450;
        Thu, 13 Feb 2025 14:03:53 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e438sm1847491b3a.94.2025.02.13.14.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:03:53 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Eric Lin <eric.lin@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [RESEND PATCH 7/7] perf vendor events riscv: Add SiFive P650 events
Date: Wed, 12 Feb 2025 17:21:40 -0800
Message-ID: <20250213220341.3215660-8-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250213220341.3215660-1-samuel.holland@sifive.com>
References: <20250213220341.3215660-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Lin <eric.lin@sifive.com>

The SiFive Performance P650 core (including the vector-enabled P670 and
area-optimized P450/P470 variants) updates the P550 microarchitecture.
It brings in the debug, trace, and counter events from newer Bullet
cores, and adds new events for iTLB and dTLB multi-hits.

All other PMU events are unchanged from the P550 core.

Signed-off-by: Eric Lin <eric.lin@sifive.com>
Co-developed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 tools/perf/pmu-events/arch/riscv/mapfile.csv  |  1 +
 .../p650/cycle-and-instruction-count.json     |  1 +
 .../arch/riscv/sifive/p650/firmware.json      |  1 +
 .../arch/riscv/sifive/p650/instruction.json   |  1 +
 .../arch/riscv/sifive/p650/memory.json        | 57 +++++++++++++++++
 .../arch/riscv/sifive/p650/microarch.json     | 62 +++++++++++++++++++
 .../arch/riscv/sifive/p650/watchpoint.json    |  1 +
 7 files changed, 124 insertions(+)
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/cycle-and-instruction-count.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/firmware.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p650/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p650/microarch.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/watchpoint.json

diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
index a301e9dbfd5a..0a7e7dcc81be 100644
--- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -18,6 +18,7 @@
 0x489-0x8000000000000[1-9a-e]07-0x[78ac][[:xdigit:]]+,v1,sifive/bullet-07,core
 0x489-0x8000000000000[1-9a-e]07-0xd[[:xdigit:]]+,v1,sifive/bullet-0d,core
 0x489-0x8000000000000008-0x[[:xdigit:]]+,v1,sifive/p550,core
+0x489-0x8000000000000[1-6]08-0x[9b][[:xdigit:]]+,v1,sifive/p650,core
 0x5b7-0x0-0x0,v1,thead/c900-legacy,core
 0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core
 0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/p650/cycle-and-instruction-count.json b/tools/perf/pmu-events/arch/riscv/sifive/p650/cycle-and-instruction-count.json
new file mode 120000
index 000000000000..ccd29278f61b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/p650/cycle-and-instruction-count.json
@@ -0,0 +1 @@
+../bullet-07/cycle-and-instruction-count.json
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/p650/firmware.json b/tools/perf/pmu-events/arch/riscv/sifive/p650/firmware.json
new file mode 120000
index 000000000000..34e5c2870eee
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/p650/firmware.json
@@ -0,0 +1 @@
+../bullet/firmware.json
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/p650/instruction.json b/tools/perf/pmu-events/arch/riscv/sifive/p650/instruction.json
new file mode 120000
index 000000000000..62eacc2d7497
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/p650/instruction.json
@@ -0,0 +1 @@
+../bullet/instruction.json
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/p650/memory.json b/tools/perf/pmu-events/arch/riscv/sifive/p650/memory.json
new file mode 100644
index 000000000000..f1431b339c7f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/p650/memory.json
@@ -0,0 +1,57 @@
+[
+  {
+    "EventName": "ICACHE_MISS",
+    "EventCode": "0x102",
+    "BriefDescription": "Counts instruction cache misses"
+  },
+  {
+    "EventName": "DCACHE_MISS",
+    "EventCode": "0x202",
+    "BriefDescription": "Counts data cache misses"
+  },
+  {
+    "EventName": "DCACHE_RELEASE",
+    "EventCode": "0x402",
+    "BriefDescription": "Counts writeback requests from the data cache"
+  },
+  {
+    "EventName": "ITLB_MISS",
+    "EventCode": "0x802",
+    "BriefDescription": "Counts Instruction TLB misses caused by instruction address translation requests"
+  },
+  {
+    "EventName": "DTLB_MISS",
+    "EventCode": "0x1002",
+    "BriefDescription": "Counts Data TLB misses caused by data address translation requests"
+  },
+  {
+    "EventName": "UTLB_MISS",
+    "EventCode": "0x2002",
+    "BriefDescription": "Counts Unified TLB misses caused by address translation requests"
+  },
+  {
+    "EventName": "UTLB_HIT",
+    "EventCode": "0x4002",
+    "BriefDescription": "Counts Unified TLB hits for address translation requests"
+  },
+  {
+    "EventName": "PTE_CACHE_MISS",
+    "EventCode": "0x8002",
+    "BriefDescription": "Counts Page Table Entry cache misses"
+  },
+  {
+    "EventName": "PTE_CACHE_HIT",
+    "EventCode": "0x10002",
+    "BriefDescription": "Counts Page Table Entry cache hits"
+  },
+  {
+    "EventName": "ITLB_MULTI_HIT",
+    "EventCode": "0x20002",
+    "BriefDescription": "Counts Instruction TLB multi-hits"
+  },
+  {
+    "EventName": "DTLB_MULTI_HIT",
+    "EventCode": "0x40002",
+    "BriefDescription": "Counts Data TLB multi-hits"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/p650/microarch.json b/tools/perf/pmu-events/arch/riscv/sifive/p650/microarch.json
new file mode 100644
index 000000000000..de8efd7b8b34
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/p650/microarch.json
@@ -0,0 +1,62 @@
+[
+  {
+    "EventName": "ADDRESSGEN_INTERLOCK",
+    "EventCode": "0x101",
+    "BriefDescription": "Counts cycles with an address-generation interlock"
+  },
+  {
+    "EventName": "LONGLATENCY_INTERLOCK",
+    "EventCode": "0x201",
+    "BriefDescription": "Counts cycles with a long-latency interlock"
+  },
+  {
+    "EventName": "CSR_INTERLOCK",
+    "EventCode": "0x401",
+    "BriefDescription": "Counts cycles with a CSR interlock"
+  },
+  {
+    "EventName": "ICACHE_BLOCKED",
+    "EventCode": "0x801",
+    "BriefDescription": "Counts cycles in which the instruction cache was not able to provide an instruction"
+  },
+  {
+    "EventName": "DCACHE_BLOCKED",
+    "EventCode": "0x1001",
+    "BriefDescription": "Counts cycles in which the data cache blocked an instruction"
+  },
+  {
+    "EventName": "BRANCH_DIRECTION_MISPREDICTION",
+    "EventCode": "0x2001",
+    "BriefDescription": "Counts mispredictions of conditional branch direction (taken/not taken)"
+  },
+  {
+    "EventName": "BRANCH_TARGET_MISPREDICTION",
+    "EventCode": "0x4001",
+    "BriefDescription": "Counts mispredictions of the target PC of control-flow instructions"
+  },
+  {
+    "EventName": "PIPELINE_FLUSH",
+    "EventCode": "0x8001",
+    "BriefDescription": "Counts flushes of the core pipeline. Common causes include fence.i and CSR accesses"
+  },
+  {
+    "EventName": "REPLAY",
+    "EventCode": "0x10001",
+    "BriefDescription": "Counts instruction replays"
+  },
+  {
+    "EventName": "INTEGER_MUL_DIV_INTERLOCK",
+    "EventCode": "0x20001",
+    "BriefDescription": "Counts cycles with a multiply or divide interlock"
+  },
+  {
+    "EventName": "FP_INTERLOCK",
+    "EventCode": "0x40001",
+    "BriefDescription": "Counts cycles with a floating-point interlock"
+  },
+  {
+    "EventName": "TRACE_STALL",
+    "EventCode": "0x80001",
+    "BriefDescription": "Counts cycles in which the core pipeline is stalled due to backpressure from the Trace Encoder"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/p650/watchpoint.json b/tools/perf/pmu-events/arch/riscv/sifive/p650/watchpoint.json
new file mode 120000
index 000000000000..e88b98bfc5c8
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/p650/watchpoint.json
@@ -0,0 +1 @@
+../bullet-07/watchpoint.json
\ No newline at end of file
-- 
2.47.0

