Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C623F13C9AD
	for <linux-perf-users@vger.kernel.org>; Thu,  9 May 2024 02:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220943; cv=none; b=dRlYjjQVlvl9EG+rV3VgGKtivuXc/wZQvGE7MupfYf7sxWYmGax8sZFBNppD9+wrdJ2U5J39ItEMqH/LuxpVqPhHM45F4D7yBLEltQ9FJf4xz5O/Op8iUgUJlm/qR+lwfmJTrEK6SpwcNLyiVpLCzPgydBONAEKCpFzV3e8nVm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220943; c=relaxed/simple;
	bh=4v0CV4GcYGJGWn+10dNhRRuee7j4kJ0e91LVXSJW7bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xzg8P1fKQmRJnvhla/UVjbI2DDM9fluQ4C4rXiu1Uy3VGptBmyP6eLmTRqv8dcgFZ+xDjlOe2fIukV+Py7Z91t8ptdnn+rL42XTVmFuhprgNfsfCfN1maRgwdS7Dunm0Us5OFDom/3a/tg08qe+6pw1mdTMHLz74GexEry36zps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=JRIzRCoz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JRIzRCoz"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e83a2a4f2cso1750965ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 19:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715220941; x=1715825741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXfa/PXX0wNxcWsuTnJvVKBz5xkIckXoldeqVQ+uY6s=;
        b=JRIzRCozrPJNU0NJ6CuoOSC6EIDaJmjWrNlEhCtLL1+qxDT+u5Hsbp4VUfHOcRujTx
         wuvinTCLCLKxom0Q8JHkB9s3QAc7xP5lbFh1L3TYAWVPbMiKhIWUGLKeDwu8gzE85FI7
         3rCMM+w+jYEaiHDa52kdejYuVcRCJtFxEl0lh4f3RIoSBbMoQVYeaJlgYicYCQfDLe9y
         L5R1zEVBrwvgI3qW5PwC6IkP1QdXFcsnzT6ayO88OBog3B5yuECwC54LEAkKOpIZyWwN
         R+ny+H5gydx+9R5Nq5ilvnv6j1g1kTvn5IIeJaU4yHeIalA/x27v/MrWPgXjhQbX2UiJ
         BM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715220941; x=1715825741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXfa/PXX0wNxcWsuTnJvVKBz5xkIckXoldeqVQ+uY6s=;
        b=wqKeXZTwAC4n3dHMwMqnVMYsezGrx3efLuCIQnh4SHO1H4kwcpHuTg92RjGWhDgTGC
         hcpdRXU4KjTWEFWjSAMz36TftU9syp8aR/jvtH976r9efsT05axXn6ny5xJlB27QHst9
         ZnKX5wNZlCfXpqqDwatdBOb3cVUpzxsCir4xAk6nwDoHKaCDd89yQTXY2GxTTNFrKJNG
         C5dhZ2C8cSwtIqlEWtU4jFihfCS2L7KKgiFfZtX0qxhhXrv5QIXfALy4XQON5YvyL1vP
         dYSkSKJUfqrmngyAfmktHZDWsT2Vy74zeo5ySWW3TJLZhMVh0DCD1IVMfbt3DOpwHFKj
         Jtgg==
X-Forwarded-Encrypted: i=1; AJvYcCVHLcr9SJhtMpttJf+361F43z8FfUnE9aIKxpc4NblklsU47rK5k2AVYRjqFvjoKRlDj+SOPWxrEUSvJi99M6btjzDyrKqwthCQnreQv+x28A==
X-Gm-Message-State: AOJu0YyAJZS/4K0hFJwzq4QXnIbadNVxekht02B4V4vJ+Dk2CZjr0leK
	UMrVBq5SXxfUK7VTGI1QV0v4NYx6niY+Ow6B8lNq/4IhG9Q2GtWtsUk09wLUDts1itET9hRAt6g
	n
X-Google-Smtp-Source: AGHT+IE9ZoyucFXxbdSGw7XJTOvvL/daIX0wCHcvpRgNlMZzb6xM1tdXMzrCLA56bysKpPynTf/B8w==
X-Received: by 2002:a17:902:f548:b0:1e5:8629:44d with SMTP id d9443c01a7336-1eeb03a6a1dmr52745165ad.1.1715220941080;
        Wed, 08 May 2024 19:15:41 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d176fsm2339115ad.58.2024.05.08.19.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 19:15:40 -0700 (PDT)
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
Subject: [PATCH 5/7] perf vendor events riscv: Add SiFive Bullet version 0x0d events
Date: Wed,  8 May 2024 19:14:58 -0700
Message-ID: <20240509021531.680920-6-samuel.holland@sifive.com>
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

SiFive Bullet microarchitecture cores with mimpid values starting with
0x0d or greater add new PMU events to count TLB miss stall cycles.

All other PMU events are unchanged from earlier Bullet cores.

Signed-off-by: Eric Lin <eric.lin@sifive.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 tools/perf/pmu-events/arch/riscv/mapfile.csv  |  1 +
 .../cycle-and-instruction-count.json          |  1 +
 .../arch/riscv/sifive/bullet-0d/firmware.json |  1 +
 .../riscv/sifive/bullet-0d/instruction.json   |  1 +
 .../arch/riscv/sifive/bullet-0d/memory.json   |  1 +
 .../riscv/sifive/bullet-0d/microarch.json     | 72 +++++++++++++++++++
 .../riscv/sifive/bullet-0d/watchpoint.json    |  1 +
 7 files changed, 78 insertions(+)
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/cycle-and-instruction-count.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/firmware.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/instruction.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/microarch.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/watchpoint.json

diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
index 8706d289215e..9e9bd7ac0ebe 100644
--- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -16,6 +16,7 @@
 #MVENDORID-MARCHID-MIMPID,Version,Filename,EventType
 0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/bullet,core
 0x489-0x8000000000000[1-9a-e]07-0x[78ac][[:xdigit:]]+,v1,sifive/bullet-07,core
+0x489-0x8000000000000[1-9a-e]07-0xd[[:xdigit:]]+,v1,sifive/bullet-0d,core
 0x5b7-0x0-0x0,v1,thead/c900-legacy,core
 0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core
 0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/cycle-and-instruction-count.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/cycle-and-instruction-count.json
new file mode 120000
index 000000000000..ccd29278f61b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/cycle-and-instruction-count.json
@@ -0,0 +1 @@
+../bullet-07/cycle-and-instruction-count.json
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/firmware.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/firmware.json
new file mode 120000
index 000000000000..34e5c2870eee
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/firmware.json
@@ -0,0 +1 @@
+../bullet/firmware.json
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/instruction.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/instruction.json
new file mode 120000
index 000000000000..62eacc2d7497
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/instruction.json
@@ -0,0 +1 @@
+../bullet/instruction.json
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/memory.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/memory.json
new file mode 120000
index 000000000000..df50fc47a5fe
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/memory.json
@@ -0,0 +1 @@
+../bullet/memory.json
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/microarch.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/microarch.json
new file mode 100644
index 000000000000..6573b24788eb
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/microarch.json
@@ -0,0 +1,72 @@
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
+  },
+  {
+    "EventName": "ITLB_MISS_STALL",
+    "EventCode": "0x100001",
+    "BriefDescription": "Counts cycles in which the core pipeline is stalled due to ITLB Miss"
+  },
+  {
+    "EventName": "DTLB_MISS_STALL",
+    "EventCode": "0x200001",
+    "BriefDescription": "Counts cycles in which the core pipeline is stalled due to DTLB Miss"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/watchpoint.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/watchpoint.json
new file mode 120000
index 000000000000..e88b98bfc5c8
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/watchpoint.json
@@ -0,0 +1 @@
+../bullet-07/watchpoint.json
\ No newline at end of file
-- 
2.44.0

