Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C0413C9CB
	for <linux-perf-users@vger.kernel.org>; Thu,  9 May 2024 02:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220940; cv=none; b=K7JTaU+0gui06Xg/x3Hf/clJWP9eV2zmRIn+M2jyLw52Jyvzwfe5/eshbvAMfN2fIj8AfFPBuWILP3kr1IhntJzW5P8g4DBz56xGENYjsrea1eGh6oiM/KxRQ67zS8d5tJNtCAkA5e1YYdeJ/ZIdtxi8C/nj6wHNHeJgp0lJEyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220940; c=relaxed/simple;
	bh=gYfuQNBgX05hVsUme8PEnHHZuoKficjKLm0pPItjSx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZ5bj7MJZ5/YAL292D87fRnlxwYhNugGpixB/fYOaQyGu8wNv2Rjaka8EE8UToR7XGf+G1NiDP0njZ1PzdZ8LvAi6iGond0hURUjftjuQoomVIYJiVDlKSkf4Wzwcb3jklUKZxGpcn9wIkdZWVqaBWYlgXW1Aj8W2ViIAW1d+LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XCEORo5P; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XCEORo5P"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so3074105ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 19:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715220938; x=1715825738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVX1AVarNYsYqEk2iTaoGsFIw6kwEnSe6amYs5WTVwI=;
        b=XCEORo5POtSzKskvLOWszyZWWZqzi52TzaIXlLoIiIs3Bz2o5B4gG23C9ZBn3kp3um
         ORsamtxOy7N/1CiocxahZYTWNpROc8np4C3q1MwrISDf+uGOntdjWpYtejOU0GD+NDZ/
         8xOwBtGI60BJRteq/uMP2/ypd33U+YNC3lgnG6B4fTaVlRXsHK85ZbSxNeBibIc0GpfA
         CGzsrsteiiKvhrXD2CfuLVaQwscoOMDLY1PVINsBdM0WKlVXkTyatgkQyw37ZclGiRnj
         e3etcqshO9zkO4RNmScDZ5D7tLNadxX7B9DtmPdB63vQlnaULFBufoe1Ka/ec3AB/4J8
         qu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715220938; x=1715825738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVX1AVarNYsYqEk2iTaoGsFIw6kwEnSe6amYs5WTVwI=;
        b=e189kiMXHKDnYux89PNYPEbMNYY8QE2ugDhOh58XltYwa68aEJ5lpFqY4rfiwj3usj
         glblsAHbu50NCa1pWmLE29BdI+9p9gcWe2b0sZLiNcq+rch1yqhvlAokyRvAqkgSPRv2
         1KSOB1661cpS8SbK6WgIhzf0kJodFc729Ln+ZEtReYW+Sv/EaDzaWDfIXOuZVFYPojTg
         kzP7mow1Q8oYfbKvO3UuMGBZ7qPp+CHZ+07sz3PNt6tycUPaaZdDec4nFmV1arKMrX3C
         /NHSqzX/d+EL+6jK/C7S8FKtX1oI/yKxKfP46K+ZbjTgct1q4lnGwsoTfap3sxA28SZ3
         tKag==
X-Forwarded-Encrypted: i=1; AJvYcCVZ6HyhOTknjax7S3zgHmysr6iQ8yusGzXwT7sFugSIXw2S0zLZkUXdhrl8b4XWik4yXAyfZp38GfP76y3ayxhoLjSNSa1kuO+K4YV85sNLuQ==
X-Gm-Message-State: AOJu0YyQm4B3kt5urla75WiUMOkr4PMW8JJHN2ya7H2CK1+UAcffGj9u
	HKp1lJnR6qGd1mT7hBKC5x7BSBNXDGGeHKm21JD+AquilsLG4PO0/3+xnTbrPgc=
X-Google-Smtp-Source: AGHT+IFK9OYAavzgvJxA3bxME7rzZkkTLe7InTSY7SBx9TvLLfwBlbpZ62AEO0ZSuoYnroDCESxf+A==
X-Received: by 2002:a17:903:32cf:b0:1e7:e7ed:7787 with SMTP id d9443c01a7336-1eeb0791c68mr53092695ad.51.1715220937846;
        Wed, 08 May 2024 19:15:37 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d176fsm2339115ad.58.2024.05.08.19.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 19:15:37 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Eric Lin <eric.lin@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 3/7] perf vendor events riscv: Update SiFive Bullet events
Date: Wed,  8 May 2024 19:14:56 -0700
Message-ID: <20240509021531.680920-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509021531.680920-1-samuel.holland@sifive.com>
References: <20240509021531.680920-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Lin <eric.lin@sifive.com>

Regenerate the event lists from the original hardware description. This
makes them consistent with the event lists for newer versions of the
hardware, allowing most files to be reused across hardware versions.

Signed-off-by: Eric Lin <eric.lin@sifive.com>
Co-developed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 .../arch/riscv/sifive/bullet/instruction.json | 44 +++++++++----------
 .../arch/riscv/sifive/bullet/memory.json      | 24 +++++-----
 .../arch/riscv/sifive/bullet/microarch.json   | 38 ++++++++--------
 3 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet/instruction.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet/instruction.json
index d5c370f70819..284e4c1566e0 100644
--- a/tools/perf/pmu-events/arch/riscv/sifive/bullet/instruction.json
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet/instruction.json
@@ -2,91 +2,91 @@
   {
     "EventName": "EXCEPTION_TAKEN",
     "EventCode": "0x100",
-    "BriefDescription": "Exception taken"
+    "BriefDescription": "Counts exceptions taken"
   },
   {
     "EventName": "INTEGER_LOAD_RETIRED",
     "EventCode": "0x200",
-    "BriefDescription": "Integer load instruction retired"
+    "BriefDescription": "Counts integer load instructions retired"
   },
   {
     "EventName": "INTEGER_STORE_RETIRED",
     "EventCode": "0x400",
-    "BriefDescription": "Integer store instruction retired"
+    "BriefDescription": "Counts integer store instructions retired"
   },
   {
     "EventName": "ATOMIC_MEMORY_RETIRED",
     "EventCode": "0x800",
-    "BriefDescription": "Atomic memory operation retired"
+    "BriefDescription": "Counts atomic memory instructions retired"
   },
   {
     "EventName": "SYSTEM_INSTRUCTION_RETIRED",
     "EventCode": "0x1000",
-    "BriefDescription": "System instruction retired"
+    "BriefDescription": "Counts system instructions retired (CSR, WFI, MRET, etc.)"
   },
   {
     "EventName": "INTEGER_ARITHMETIC_RETIRED",
     "EventCode": "0x2000",
-    "BriefDescription": "Integer arithmetic instruction retired"
+    "BriefDescription": "Counts integer arithmetic instructions retired"
   },
   {
     "EventName": "CONDITIONAL_BRANCH_RETIRED",
     "EventCode": "0x4000",
-    "BriefDescription": "Conditional branch retired"
+    "BriefDescription": "Counts conditional branch instructions retired"
   },
   {
     "EventName": "JAL_INSTRUCTION_RETIRED",
     "EventCode": "0x8000",
-    "BriefDescription": "JAL instruction retired"
+    "BriefDescription": "Counts jump-and-link instructions retired"
   },
   {
     "EventName": "JALR_INSTRUCTION_RETIRED",
     "EventCode": "0x10000",
-    "BriefDescription": "JALR instruction retired"
+    "BriefDescription": "Counts indirect jump instructions (JALR) retired"
   },
   {
     "EventName": "INTEGER_MULTIPLICATION_RETIRED",
     "EventCode": "0x20000",
-    "BriefDescription": "Integer multiplication instruction retired"
+    "BriefDescription": "Counts integer multiplication instructions retired"
   },
   {
     "EventName": "INTEGER_DIVISION_RETIRED",
     "EventCode": "0x40000",
-    "BriefDescription": "Integer division instruction retired"
+    "BriefDescription": "Counts integer division instructions retired"
   },
   {
     "EventName": "FP_LOAD_RETIRED",
     "EventCode": "0x80000",
-    "BriefDescription": "Floating-point load instruction retired"
+    "BriefDescription": "Counts floating-point load instructions retired"
   },
   {
     "EventName": "FP_STORE_RETIRED",
     "EventCode": "0x100000",
-    "BriefDescription": "Floating-point store instruction retired"
+    "BriefDescription": "Counts floating-point store instructions retired"
   },
   {
-    "EventName": "FP_ADDITION_RETIRED",
+    "EventName": "FP_ADD_RETIRED",
     "EventCode": "0x200000",
-    "BriefDescription": "Floating-point addition retired"
+    "BriefDescription": "Counts floating-point add instructions retired"
   },
   {
-    "EventName": "FP_MULTIPLICATION_RETIRED",
+    "EventName": "FP_MUL_RETIRED",
     "EventCode": "0x400000",
-    "BriefDescription": "Floating-point multiplication retired"
+    "BriefDescription": "Counts floating-point multiply instructions retired"
   },
   {
-    "EventName": "FP_FUSEDMADD_RETIRED",
+    "EventName": "FP_MULADD_RETIRED",
     "EventCode": "0x800000",
-    "BriefDescription": "Floating-point fused multiply-add retired"
+    "BriefDescription": "Counts floating-point fused multiply-add instructions retired"
   },
   {
     "EventName": "FP_DIV_SQRT_RETIRED",
     "EventCode": "0x1000000",
-    "BriefDescription": "Floating-point division or square-root retired"
+    "BriefDescription": "Counts floating point divide or square root instructions retired"
   },
   {
     "EventName": "OTHER_FP_RETIRED",
     "EventCode": "0x2000000",
-    "BriefDescription": "Other floating-point instruction retired"
+    "BriefDescription": "Counts other floating-point instructions retired"
   }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet/memory.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet/memory.json
index ba3168f8a4cd..70441a55dd66 100644
--- a/tools/perf/pmu-events/arch/riscv/sifive/bullet/memory.json
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet/memory.json
@@ -1,32 +1,32 @@
 [
   {
-    "EventName": "ICACHE_RETIRED",
+    "EventName": "ICACHE_MISS",
     "EventCode": "0x102",
-    "BriefDescription": "Instruction cache miss"
+    "BriefDescription": "Counts instruction cache misses"
   },
   {
-    "EventName": "DCACHE_MISS_MMIO_ACCESSES",
+    "EventName": "DCACHE_MISS",
     "EventCode": "0x202",
-    "BriefDescription": "Data cache miss or memory-mapped I/O access"
+    "BriefDescription": "Counts data cache misses"
   },
   {
-    "EventName": "DCACHE_WRITEBACK",
+    "EventName": "DCACHE_RELEASE",
     "EventCode": "0x402",
-    "BriefDescription": "Data cache write-back"
+    "BriefDescription": "Counts writeback requests from the data cache"
   },
   {
-    "EventName": "INST_TLB_MISS",
+    "EventName": "ITLB_MISS",
     "EventCode": "0x802",
-    "BriefDescription": "Instruction TLB miss"
+    "BriefDescription": "Counts Instruction TLB misses caused by instruction address translation requests"
   },
   {
-    "EventName": "DATA_TLB_MISS",
+    "EventName": "DTLB_MISS",
     "EventCode": "0x1002",
-    "BriefDescription": "Data TLB miss"
+    "BriefDescription": "Counts Data TLB misses caused by data address translation requests"
   },
   {
     "EventName": "UTLB_MISS",
     "EventCode": "0x2002",
-    "BriefDescription": "UTLB miss"
+    "BriefDescription": "Counts Unified TLB misses caused by address translation requests"
   }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet/microarch.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet/microarch.json
index 8036e72fb0d4..d9cdb7d747ee 100644
--- a/tools/perf/pmu-events/arch/riscv/sifive/bullet/microarch.json
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet/microarch.json
@@ -2,56 +2,56 @@
   {
     "EventName": "ADDRESSGEN_INTERLOCK",
     "EventCode": "0x101",
-    "BriefDescription": "Address-generation interlock"
+    "BriefDescription": "Counts cycles with an address-generation interlock"
   },
   {
-    "EventName": "LONGLAT_INTERLOCK",
+    "EventName": "LONGLATENCY_INTERLOCK",
     "EventCode": "0x201",
-    "BriefDescription": "Long-latency interlock"
+    "BriefDescription": "Counts cycles with a long-latency interlock"
   },
   {
-    "EventName": "CSR_READ_INTERLOCK",
+    "EventName": "CSR_INTERLOCK",
     "EventCode": "0x401",
-    "BriefDescription": "CSR read interlock"
+    "BriefDescription": "Counts cycles with a CSR interlock"
   },
   {
-    "EventName": "ICACHE_ITIM_BUSY",
+    "EventName": "ICACHE_BLOCKED",
     "EventCode": "0x801",
-    "BriefDescription": "Instruction cache/ITIM busy"
+    "BriefDescription": "Counts cycles in which the instruction cache was not able to provide an instruction"
   },
   {
-    "EventName": "DCACHE_DTIM_BUSY",
+    "EventName": "DCACHE_BLOCKED",
     "EventCode": "0x1001",
-    "BriefDescription": "Data cache/DTIM busy"
+    "BriefDescription": "Counts cycles in which the data cache blocked an instruction"
   },
   {
     "EventName": "BRANCH_DIRECTION_MISPREDICTION",
     "EventCode": "0x2001",
-    "BriefDescription": "Branch direction misprediction"
+    "BriefDescription": "Counts mispredictions of conditional branch direction (taken/not taken)"
   },
   {
     "EventName": "BRANCH_TARGET_MISPREDICTION",
     "EventCode": "0x4001",
-    "BriefDescription": "Branch/jump target misprediction"
+    "BriefDescription": "Counts mispredictions of the target PC of control-flow instructions"
   },
   {
-    "EventName": "PIPE_FLUSH_CSR_WRITE",
+    "EventName": "PIPELINE_FLUSH",
     "EventCode": "0x8001",
-    "BriefDescription": "Pipeline flush from CSR write"
+    "BriefDescription": "Counts flushes of the core pipeline. Common causes include fence.i and CSR accesses"
   },
   {
-    "EventName": "PIPE_FLUSH_OTHER_EVENT",
+    "EventName": "REPLAY",
     "EventCode": "0x10001",
-    "BriefDescription": "Pipeline flush from other event"
+    "BriefDescription": "Counts instruction replays"
   },
   {
-    "EventName": "INTEGER_MULTIPLICATION_INTERLOCK",
+    "EventName": "INTEGER_MUL_DIV_INTERLOCK",
     "EventCode": "0x20001",
-    "BriefDescription": "Integer multiplication interlock"
+    "BriefDescription": "Counts cycles with a multiply or divide interlock"
   },
   {
     "EventName": "FP_INTERLOCK",
     "EventCode": "0x40001",
-    "BriefDescription": "Floating-point interlock"
+    "BriefDescription": "Counts cycles with a floating-point interlock"
   }
-]
\ No newline at end of file
+]
-- 
2.44.0

