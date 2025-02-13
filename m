Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E95124BBFE
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484229; cv=none; b=D0iPQw421akwiTSsMTUIGK8SXVJdbmdhklp04GwhbB0A8N+PHGT5UYQX1comA1S6cowEpHPbAWDhl1ySnZvUOir2ghGmfCjunA+bom4875cp3In7fRI8/ofPZzfhbQeCvQ5TPq2VeN5VMDQ2Bo+gsdjaxSpYNwArt5mDZblahfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484229; c=relaxed/simple;
	bh=etl8MBCW1ZwNwSZ5bxxYBExa/7VLcPDSO62xiCVZVo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCf6tGaumsag6t/XfRc4OFf8dVx6cBCy/DKeOIGh6r4NebUlYGVIeT/WlnvOYjV/sidCa8cIz8dtKakJG/UmqTeBSRKPAYrSWpiTQfoti8T8hEjZEUv29bwqH5wI80t+kM1cJdCNrxRAiowfMG4tJjGu1T7HiBkeSRdETfPMpwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=QR+nuSwN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QR+nuSwN"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f3c119fe6so33438185ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 14:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1739484226; x=1740089026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ujrNz6bFEjXMZWyeD7xO+6PAHSEy846AW7WXFdUvFc=;
        b=QR+nuSwNhawlbZvD8qUf3LOrDFiPamzhr35H9odupnag00hD4wvPu7jJcQIEZ9YNVk
         bwkpMaNtLuEb/NpAd7B2s7MP8U1Tk0L5yNr66xBK4B6/ciV+WoG+P4wb2I6pe/vibmad
         E7orz6tkCdmp4zIK2AuSSG4w47MDnjwBtPxpCRwnQQZGdCkxq9qIfZKkC/LSWUdCFbFO
         mlCOgPB1MitBJoGy5SZJZTQK2qJJZDewmIz7KhXbEbo8T3pj97VZwZSyvRlkqDteiC8V
         TYluQ98SJM78ipnLbBFhmeGvvKEgyEpcdR234S9+EGqyoxCXK8Jrq3o6WhJUr8Me4/zU
         yd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739484226; x=1740089026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ujrNz6bFEjXMZWyeD7xO+6PAHSEy846AW7WXFdUvFc=;
        b=JIuYvAs9FjfmMuKco4+PhQjcPuNd6QwYjtwgs+mcTEzApID7sHDvcLx6SukmKXWdTD
         TiKSgOzLgrjqS9Ax1JDpb09JpcgW64g8GEIfGpGBHlu4slhZ8BDYQhTZNShg65lLXApJ
         TLM1oqVGVJ5Ql6I/vy5IWcdqTROFt24AmSX2Xq64l1RpQA8ByOlH6eUyDRc/EY7ePVSw
         ck7XpGLdkoopEgbG/KnbjsE6b4NUuObgwrws2LOU4gB/nRN2CfkkENsOrzJB2CmxkrdV
         EKbqxBF7VVik19aFZE4Iias2bYFU2dVbiOAqJgnt5AfCGyW2Gc5sV1O3gppUMZ5mU3un
         gEqg==
X-Forwarded-Encrypted: i=1; AJvYcCV7Ziq2Gua1Jfl27o2WtjCWpDgcItmilea0z7L6XNiknMoUbc/Ay6qJHaRL1g+j1eMXVyGx+hSg620WABx+Ybp3@vger.kernel.org
X-Gm-Message-State: AOJu0YzQdV0nLsjM+Z7j7SFRreaqijN9DNxLyVA6GaltrThi5seKwQCg
	Jdpw3ruY/IFp1N7gAVHNIYy+1Cnq8fr0R7Xo5zg9/BLqLu/zTlhLXGk0icsawk4=
X-Gm-Gg: ASbGnct8l5Y24Y9Dz+bYk7wJdOhQiVbd3lYNmCvmxi+bB5mDk3PNBCGuuNtVd+/crVQ
	i1KnBKL74vJy1pCjcDKpCAmtGR5PChNfK/kwDkJ4HtTuhp3M6Ox4oX6W1Mnn7oH8b1pDjHBl1XT
	5L2ejjfQQEvYeeZM4SSlgfMMq/lzLJoazUIhYn17CD2epoup83yXGymLdXFJmXkypGP7bMG9Wpx
	iyL940XDKRerkiJOH73CnjuJ9kiuxgeIGfhxwpHxfrKhmrhdqw4DbF4/3bxrEKkzgnXxjNEd2Sc
	yczjcmKMJUruMne5r7YeSlHSbOpWBmu20NzLXg==
X-Google-Smtp-Source: AGHT+IEkWuYu6Mf+HWuIrNOvHWAQyQHQHIN4Af/iLEKahRrF/JeeptdD8j+MBLAWGFNetgsaZ+DGjg==
X-Received: by 2002:a05:6a00:8006:b0:72a:9ddf:55ab with SMTP id d2e1a72fcca58-7322c38b08emr12659266b3a.10.1739484226610;
        Thu, 13 Feb 2025 14:03:46 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e438sm1847491b3a.94.2025.02.13.14.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:03:46 -0800 (PST)
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
	Samuel Holland <samuel.holland@sifive.com>
Subject: [RESEND PATCH 2/7] perf vendor events riscv: Remove leading zeroes
Date: Wed, 12 Feb 2025 17:21:35 -0800
Message-ID: <20250213220341.3215660-3-samuel.holland@sifive.com>
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
2.47.0

