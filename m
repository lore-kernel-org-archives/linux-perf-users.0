Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90BD13C9B1
	for <linux-perf-users@vger.kernel.org>; Thu,  9 May 2024 02:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220938; cv=none; b=O+j6OZ0bVtz5ZIi/5O8MTfeqRXymIXe8QRDM1QtUn9xUh3AtmpAqwv9QBxyCWst19l7Bvysi2O3uSkQHYyCH90fnNQERm5fAFNSUGP4PttFv63JoyeoNCHVNuP25siMKnOgxrwCyAzk8fx9/xWWXQlqbDudPlSLdBOGPVnxHI7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220938; c=relaxed/simple;
	bh=iE0nc+pqBlycu1/E1rcy7hCooSNparcn6B0FCvgq9hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOzLQbkgBB1sq/LfJnJugZpI6dLqwmqIX3r/fG+Jee77BdnEcCXdKk16eK3KW5avfdgnn1+etO2rRM3dAG+LjYPMlbkdHUuoB1HbVsxN/Y1dgloQ2JkyAbio3OZY14l1iGRo3v/mozsCN0rEYnsKdrSL92u2qsssH5ECc7WTSAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=jUdQ+t0Z; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jUdQ+t0Z"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ec486198b6so2790625ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 19:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715220936; x=1715825736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1w31VG7dFEHQi12OtWSwU5murL3FH6dEyF6pyBObg2Y=;
        b=jUdQ+t0ZsiHCWNrqh0Ee7HYwoQ/qIWX594eQdBAntAb8JIq534CKKngJ72Gium+0E6
         Tbem1rSvM0tsvAjTXlK4bTmFBkFYzFf/k0dVbMX/4pgTsby/0ckm5ixjm5BaTfsWCaHe
         QuyCTN6k6N0pnKbOtRKb5lo46Py0wuV4GAaSfNwUTNtBWXMIwcOG62EyiB5DdCsoPG4E
         hPSCYwMssi9zVrSmGcr8syNQElAAkZGcj+Pj/+sLVBMfTYqjtkHwps+3LndyA4tCDQKf
         rKNJGJQMitXxObZN49lfNIYSqucOy9JeVAfA6Ab0Px5grdhwi3hgvA+Xfrw2SnvP9vvh
         bVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715220936; x=1715825736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1w31VG7dFEHQi12OtWSwU5murL3FH6dEyF6pyBObg2Y=;
        b=V1YSMVBR+JiZoRhe2TF9uBfUJzQ5hq/XNpsYBiRz+jMbQYGcMIp9TnQZHRNRUZElO8
         37zzQUVJiBaB/aNgZDO8Aan38RkQYRTyHDw0ATSzA7kmBhUsJMTsr0L+TetzPjtaRiRU
         tDZTYluSl0V4R+pQqBP7rBjuV+ojtwS5sI8f0G2p3rTB5J11VSsFHFA9du1Gy7NMCuAe
         eH1zfq4MbKdGWHINfI1MypwOXBdkFB647VOGK4k4+veNBG7gE6J/sxEflorpn5TPHjGg
         pmMl3LnHKkt7sF0wTnApRNU55xweSshtKOgEQcphmAAY9nNXiHtlwVId0nE0qImUWuJc
         QU1w==
X-Forwarded-Encrypted: i=1; AJvYcCVrjrN4jJUWAXadSjbFYiVlno1NE0Tzr1dFKgki3aRJtLxj9DXIdVQeZ3VG6OnVYBa1h73zYQbL+l/2lgacYyVb08A+QnNzhv8dsxGcgp66aw==
X-Gm-Message-State: AOJu0Yxz0psUWggWocD2KfAqVTuW5zRDeKccUFpT2sY58vRSYSI3OWjr
	q5w9GKfsJJ5Q87DdHzqmrAWu6ADRzY9nBPdoiZpSCQSvnA3YGaEHnG71mOoRftQ=
X-Google-Smtp-Source: AGHT+IHTiaNofc4U3P/rwsUFxye22khX46ky/BlrMrvmBPV1NPQpIRm+fTnBzHzUfN8eU3mopldIaQ==
X-Received: by 2002:a17:903:2410:b0:1e2:194a:3d22 with SMTP id d9443c01a7336-1eeb0597692mr50740855ad.32.1715220936117;
        Wed, 08 May 2024 19:15:36 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d176fsm2339115ad.58.2024.05.08.19.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 19:15:35 -0700 (PDT)
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
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 2/7] perf vendor events riscv: Remove leading zeroes
Date: Wed,  8 May 2024 19:14:55 -0700
Message-ID: <20240509021531.680920-3-samuel.holland@sifive.com>
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

The EventCode field (as stored in the mhpmeventN CSRs) is actually 56
bits wide, but there is no need to keep leading zeroes in the JSON
files. Remove them to simplify review of the following change, which
regenerates the files in a way that does not include leading zeroes.

This change was performed automatically with `sed -i "s/0x0*/0x/"`.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 .../arch/riscv/sifive/bullet/instruction.json | 32 +++++++++----------
 .../arch/riscv/sifive/bullet/memory.json      | 12 +++----
 .../arch/riscv/sifive/bullet/microarch.json   | 22 ++++++-------
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet/instruction.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet/instruction.json
index 5eab718c9256..d5c370f70819 100644
--- a/tools/perf/pmu-events/arch/riscv/sifive/bullet/instruction.json
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet/instruction.json
@@ -1,82 +1,82 @@
 [
   {
     "EventName": "EXCEPTION_TAKEN",
-    "EventCode": "0x0000100",
+    "EventCode": "0x100",
     "BriefDescription": "Exception taken"
   },
   {
     "EventName": "INTEGER_LOAD_RETIRED",
-    "EventCode": "0x0000200",
+    "EventCode": "0x200",
     "BriefDescription": "Integer load instruction retired"
   },
   {
     "EventName": "INTEGER_STORE_RETIRED",
-    "EventCode": "0x0000400",
+    "EventCode": "0x400",
     "BriefDescription": "Integer store instruction retired"
   },
   {
     "EventName": "ATOMIC_MEMORY_RETIRED",
-    "EventCode": "0x0000800",
+    "EventCode": "0x800",
     "BriefDescription": "Atomic memory operation retired"
   },
   {
     "EventName": "SYSTEM_INSTRUCTION_RETIRED",
-    "EventCode": "0x0001000",
+    "EventCode": "0x1000",
     "BriefDescription": "System instruction retired"
   },
   {
     "EventName": "INTEGER_ARITHMETIC_RETIRED",
-    "EventCode": "0x0002000",
+    "EventCode": "0x2000",
     "BriefDescription": "Integer arithmetic instruction retired"
   },
   {
     "EventName": "CONDITIONAL_BRANCH_RETIRED",
-    "EventCode": "0x0004000",
+    "EventCode": "0x4000",
     "BriefDescription": "Conditional branch retired"
   },
   {
     "EventName": "JAL_INSTRUCTION_RETIRED",
-    "EventCode": "0x0008000",
+    "EventCode": "0x8000",
     "BriefDescription": "JAL instruction retired"
   },
   {
     "EventName": "JALR_INSTRUCTION_RETIRED",
-    "EventCode": "0x0010000",
+    "EventCode": "0x10000",
     "BriefDescription": "JALR instruction retired"
   },
   {
     "EventName": "INTEGER_MULTIPLICATION_RETIRED",
-    "EventCode": "0x0020000",
+    "EventCode": "0x20000",
     "BriefDescription": "Integer multiplication instruction retired"
   },
   {
     "EventName": "INTEGER_DIVISION_RETIRED",
-    "EventCode": "0x0040000",
+    "EventCode": "0x40000",
     "BriefDescription": "Integer division instruction retired"
   },
   {
     "EventName": "FP_LOAD_RETIRED",
-    "EventCode": "0x0080000",
+    "EventCode": "0x80000",
     "BriefDescription": "Floating-point load instruction retired"
   },
   {
     "EventName": "FP_STORE_RETIRED",
-    "EventCode": "0x0100000",
+    "EventCode": "0x100000",
     "BriefDescription": "Floating-point store instruction retired"
   },
   {
     "EventName": "FP_ADDITION_RETIRED",
-    "EventCode": "0x0200000",
+    "EventCode": "0x200000",
     "BriefDescription": "Floating-point addition retired"
   },
   {
     "EventName": "FP_MULTIPLICATION_RETIRED",
-    "EventCode": "0x0400000",
+    "EventCode": "0x400000",
     "BriefDescription": "Floating-point multiplication retired"
   },
   {
     "EventName": "FP_FUSEDMADD_RETIRED",
-    "EventCode": "0x0800000",
+    "EventCode": "0x800000",
     "BriefDescription": "Floating-point fused multiply-add retired"
   },
   {
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet/memory.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet/memory.json
index be1a46312ac3..ba3168f8a4cd 100644
--- a/tools/perf/pmu-events/arch/riscv/sifive/bullet/memory.json
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet/memory.json
@@ -1,32 +1,32 @@
 [
   {
     "EventName": "ICACHE_RETIRED",
-    "EventCode": "0x0000102",
+    "EventCode": "0x102",
     "BriefDescription": "Instruction cache miss"
   },
   {
     "EventName": "DCACHE_MISS_MMIO_ACCESSES",
-    "EventCode": "0x0000202",
+    "EventCode": "0x202",
     "BriefDescription": "Data cache miss or memory-mapped I/O access"
   },
   {
     "EventName": "DCACHE_WRITEBACK",
-    "EventCode": "0x0000402",
+    "EventCode": "0x402",
     "BriefDescription": "Data cache write-back"
   },
   {
     "EventName": "INST_TLB_MISS",
-    "EventCode": "0x0000802",
+    "EventCode": "0x802",
     "BriefDescription": "Instruction TLB miss"
   },
   {
     "EventName": "DATA_TLB_MISS",
-    "EventCode": "0x0001002",
+    "EventCode": "0x1002",
     "BriefDescription": "Data TLB miss"
   },
   {
     "EventName": "UTLB_MISS",
-    "EventCode": "0x0002002",
+    "EventCode": "0x2002",
     "BriefDescription": "UTLB miss"
   }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet/microarch.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet/microarch.json
index 50ffa55418cb..8036e72fb0d4 100644
--- a/tools/perf/pmu-events/arch/riscv/sifive/bullet/microarch.json
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet/microarch.json
@@ -1,57 +1,57 @@
 [
   {
     "EventName": "ADDRESSGEN_INTERLOCK",
-    "EventCode": "0x0000101",
+    "EventCode": "0x101",
     "BriefDescription": "Address-generation interlock"
   },
   {
     "EventName": "LONGLAT_INTERLOCK",
-    "EventCode": "0x0000201",
+    "EventCode": "0x201",
     "BriefDescription": "Long-latency interlock"
   },
   {
     "EventName": "CSR_READ_INTERLOCK",
-    "EventCode": "0x0000401",
+    "EventCode": "0x401",
     "BriefDescription": "CSR read interlock"
   },
   {
     "EventName": "ICACHE_ITIM_BUSY",
-    "EventCode": "0x0000801",
+    "EventCode": "0x801",
     "BriefDescription": "Instruction cache/ITIM busy"
   },
   {
     "EventName": "DCACHE_DTIM_BUSY",
-    "EventCode": "0x0001001",
+    "EventCode": "0x1001",
     "BriefDescription": "Data cache/DTIM busy"
   },
   {
     "EventName": "BRANCH_DIRECTION_MISPREDICTION",
-    "EventCode": "0x0002001",
+    "EventCode": "0x2001",
     "BriefDescription": "Branch direction misprediction"
   },
   {
     "EventName": "BRANCH_TARGET_MISPREDICTION",
-    "EventCode": "0x0004001",
+    "EventCode": "0x4001",
     "BriefDescription": "Branch/jump target misprediction"
   },
   {
     "EventName": "PIPE_FLUSH_CSR_WRITE",
-    "EventCode": "0x0008001",
+    "EventCode": "0x8001",
     "BriefDescription": "Pipeline flush from CSR write"
   },
   {
     "EventName": "PIPE_FLUSH_OTHER_EVENT",
-    "EventCode": "0x0010001",
+    "EventCode": "0x10001",
     "BriefDescription": "Pipeline flush from other event"
   },
   {
     "EventName": "INTEGER_MULTIPLICATION_INTERLOCK",
-    "EventCode": "0x0020001",
+    "EventCode": "0x20001",
     "BriefDescription": "Integer multiplication interlock"
   },
   {
     "EventName": "FP_INTERLOCK",
-    "EventCode": "0x0040001",
+    "EventCode": "0x40001",
     "BriefDescription": "Floating-point interlock"
   }
 ]
\ No newline at end of file
-- 
2.44.0

