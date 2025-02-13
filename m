Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D55269822
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 22:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484230; cv=none; b=ePBbY2fN7baEVSVt2+K8VFKIUFbBZimztGZkTsEYUVG9EN3iPfW26DV5pyqiAJ37FGMm7J7sltu2Pj30NCcN9jK5270VnAqSh3vXbtbVRKz/Zv4/rpv5wFYNXMZ0ypmv7NkJYrHwGaxQaCTFiqm1hPe2bbQRC7cqTLLpdhucLxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484230; c=relaxed/simple;
	bh=JWx3tdIr+wuDKySbKZN4E6+0CA5HuYlLjX0fQtWSip0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ove4Hqzyr3kg8GnbWepIOtAj1TfFfY5lY+HKlLSQ+EQMBRhxErI6Nl8KeavUYCKOO2uqyzQtqCJGbc3JprFiVxkyrkFT7q3e6Cntrh/mZKgcQ3wkIwAp+Y3LjqKzr0M3YczWYWfH/1qFBPTChsl5UnGOIliQFFpnIJvmoFfiNcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=j495ouM3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="j495ouM3"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f42992f608so2323640a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 14:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1739484228; x=1740089028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeNVoNYpyWmAYcTXSWgq1Wck1u4KyPy10iVrXroX1W0=;
        b=j495ouM34VbfBvfEVFLxOqrTdFdjK/NQYo5sF2t9J6Z82NM2jcTUjEIDtBgL4+1pLN
         h3+Ugyqq39Ty5EEnR5oVKIfHLmb3xNyBIAJQmcUMDsMmGciFJp6llrX+g1FHp6kczCnY
         TFHS06lk7LiFowq6zYMNEvl6KNK1fdw0qdAu0Y8de8CvuqdBG1MX2wMiGK23T2j5OgdX
         BEwCkdlUvk4KGex4IMLdryGsj0KZaii2m4U56WC6N/qbPOQA30cwgDPAqHBJ1xO4CJH9
         bBoXdgA3UVwGv5hoSG+8hLqDq7jibWjxfN+q5xEx8kYJrSZa76CfimGkpULcD0t/Gk65
         wfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739484228; x=1740089028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xeNVoNYpyWmAYcTXSWgq1Wck1u4KyPy10iVrXroX1W0=;
        b=XEop+x3EpgeH+oVW9flkqRS5ZRoiC4KqQgGP7I+NHXaLKhdthda6XxK51fLfVdTXNi
         V09OX2bi20URx9JPXC/xO4rqKEt0l7wuDDeUko0ddnf1t/cHhWRhVECO/dXUUToXL8ug
         g7wUv7asu3RTui6KM3yyQxdUpHdaanKqIHlwdckt1cIU+IiCLLunjNE5uqr9E1avq7we
         IpIRNRfzFx3ZpzhaDoXfKPGYMwYwJJsSt/UnQ7s0OPQK/T86HrlHO/JwJsAdTj2OrguU
         VaXiLPmmp+SWyp2R7xctScMhQOriPFQDW99rAFZokR/GIuRlVXNl7ODneqH1FiNGb+av
         CTMg==
X-Forwarded-Encrypted: i=1; AJvYcCUyj5wbWu3gwZ6DH0xh5vr4IbontQa6nsBQz6cTT1ofzTm6iUfpthv3Zu9jRzRCmOxC44HJ0U+v5qPROU2p4joA@vger.kernel.org
X-Gm-Message-State: AOJu0YyyS+1JMcJLtl+bcIScX+AO9058u/mLLQnAO/l6RVc7RsqG0miv
	KIGWL3YXNVWRZvbAnmG3wnXv5vynFTRqbmzdHVt+GmcDvwfXtGSksGuXvKpwNqU=
X-Gm-Gg: ASbGncvz7132J9T3Olb/RrQB2qPmBoDC4mM/mDLrYFXqDwaqTmOWBhN6pnlJo8lpxAO
	RrvKNJR9wQHO5+mQ992n7v38IBdgyysAQXiDaJaR8mhA7xYk85wQMaESlwM29LVJ6jeh3pkNul5
	iSwDZnDQvso99M8Pkj63J1c4JLqDQ1iIxhu9MpTOOXdMebM/b60xVpC696DYDZH6QoC49eqgpVM
	w0z/DVzBF+4rFfAC/2F2Ka4TBD9ffBXJLat1UlzPaTJNR+1C3pXgV7OriCKBdR5Icbnc0n+5qPM
	tkCYkOEIDp1EwMiOoDWxTH2tJ4uc9yuuID7gHQ==
X-Google-Smtp-Source: AGHT+IHnuVlNMFPAoL0Y+6j/6cimg69Ufm3HsDZD07eMDnYdRVpW30E9B1x9uqsr06kWIo67J880Og==
X-Received: by 2002:a05:6a00:aa8e:b0:725:ea30:aafc with SMTP id d2e1a72fcca58-7323c1059f6mr6695686b3a.5.1739484227953;
        Thu, 13 Feb 2025 14:03:47 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e438sm1847491b3a.94.2025.02.13.14.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:03:47 -0800 (PST)
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
Subject: [RESEND PATCH 3/7] perf vendor events riscv: Update SiFive Bullet events
Date: Wed, 12 Feb 2025 17:21:36 -0800
Message-ID: <20250213220341.3215660-4-samuel.holland@sifive.com>
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
2.47.0

