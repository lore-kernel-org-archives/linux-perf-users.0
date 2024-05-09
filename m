Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115BF10979
	for <linux-perf-users@vger.kernel.org>; Thu,  9 May 2024 02:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220941; cv=none; b=EvWd494OyI/bLlXhgU+JLO3D7ShTc0zF/9K9e2Rva9nLQpRDk6zc0Hdyu4xUADchjbl0PsaaE5C8mSmv2AjMORItTpkAbNARaB4ewWKo6dASVDv6OIfSGTS4rPx6KqpK+scZfvLnvOdBsi3tp02ju5PRciaapBac4M+Ozg3m+zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220941; c=relaxed/simple;
	bh=wuDUuTTy+KrNSH/rocyrHJVWg6fDksTXDSr+0TcbgLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ry+0UhH8ssseXC3G26IuTnB4nGUQA8DeIUE5QcnbLXivpopWO1oy25sUU3YWVXdcnQ2bqhrBli9OpR+inygNDrLHcSnxpUXASbjJhk3lkAiUAmpjc9PYhYm7rYVSKdUYp3XuJ2zaoy87hIL7SK652DO67te7ctJ5sGkv+UU7Ef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Q1YSfK/4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Q1YSfK/4"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1eecc71311eso2701815ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 19:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715220939; x=1715825739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsqnhxaQmP+8s5AUmhtjZOLCmUrK+sfDqwiHe1ZPGJs=;
        b=Q1YSfK/4spfGq8Gdkz/9oMwvA5UdwBOSi+t3YQbK0Sr4qJvfQbnNmPH6+kIYNcIvAE
         PgArOXnnnibSJBTmY4LJ4BoIJjL1tgPoemIGu9gJVh7cuScuc85Vi2tWn/Llvxn/GMPy
         wVOxyjaBLQJNzF09hpJHs5Y2wq3eNp1G2umxovw4GRY6NoKdisb+Y7usIC1/gSN2OvZu
         CAklQLYHZkkzeYARyBbqkGRZ2qd/Fb9v6HjYfyX8GvBrLayfznzIYIwZgdo+OGM1Pg+4
         rHQALBsH6del8ci2bJsvPFnTl5YHbye1W6Mcstx8qdKUzgt136dCr3qL1uByYGK5Ij13
         mlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715220939; x=1715825739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsqnhxaQmP+8s5AUmhtjZOLCmUrK+sfDqwiHe1ZPGJs=;
        b=NIiSkinGZjL/okQDhsKiTm3BwN+IvNZcT3hnFz4MdNkWzwwzl6LXa2UJIeoeM07Bup
         U/genV6pidMXVMTNZCJR9GwoSqSiaoerGTUOxrv58WrcRQCnxqJoxT4yvytP7ePocnsh
         iJMJdBy70JuIKX4KvBfLMOQKX4duxvi83ay+2mUoE+JAQ1esn58f4NpMgP0NQquGUKxh
         rdzHXv14KUVqU4Nt+14j51ie35n4MglxFNE81AjiKqWlJshCBtjcwBhWMpe69oB1UXqp
         i5KiFJmcAajelljs9/tcJJE+7ZrmoJfWBkKOElvhOA4rAmFd7YtSenzmC3uhO3grd01F
         C9+g==
X-Forwarded-Encrypted: i=1; AJvYcCUTWJf/TBn0a5E3eIeq+K9aY5/WQ+b8v6jfMYSNstCuOcAZz9uzXjPxPgQOPdqcYUCLCVjk9L0dOXrUG0mgliC02Thabp3kPKFLdtmHPprMbQ==
X-Gm-Message-State: AOJu0YwN8P85Z3yS0/BiftqHjctamX+LttJdBHu7b8crH2ct25+3o4mN
	ruS0+4z9SF7flUDS+31XqChd/k3CZtXl356RujAMNa8PFx1vTnBQkqrhzYGgYpT1KJmqRDRG2kC
	o
X-Google-Smtp-Source: AGHT+IFggpqzp2voiW6Dn5QX5CcCPey3mFBNvNVLgEW7f6Fdb3zuwjAxPItMpaPovLTf+PBcqAQ7Kg==
X-Received: by 2002:a17:902:8486:b0:1eb:77ed:8fba with SMTP id d9443c01a7336-1eeb01a63f6mr46134765ad.17.1715220939401;
        Wed, 08 May 2024 19:15:39 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d176fsm2339115ad.58.2024.05.08.19.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 19:15:39 -0700 (PDT)
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
Subject: [PATCH 4/7] perf vendor events riscv: Add SiFive Bullet version 0x07 events
Date: Wed,  8 May 2024 19:14:57 -0700
Message-ID: <20240509021531.680920-5-samuel.holland@sifive.com>
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
0x07 or greater add new PMU events to support debug, trace, and counter
sampling and filtering (Sscofpmf).

All other PMU events are unchanged from earlier Bullet cores.

Signed-off-by: Eric Lin <eric.lin@sifive.com>
Co-developed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 tools/perf/pmu-events/arch/riscv/mapfile.csv  |  1 +
 .../cycle-and-instruction-count.json          | 12 ++++
 .../arch/riscv/sifive/bullet-07/firmware.json |  1 +
 .../riscv/sifive/bullet-07/instruction.json   |  1 +
 .../arch/riscv/sifive/bullet-07/memory.json   |  1 +
 .../riscv/sifive/bullet-07/microarch.json     | 62 +++++++++++++++++++
 .../riscv/sifive/bullet-07/watchpoint.json    | 42 +++++++++++++
 7 files changed, 120 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/cycle-and-instruction-count.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/firmware.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/instruction.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/microarch.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/watchpoint.json

diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
index 521f416b0006..8706d289215e 100644
--- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -15,6 +15,7 @@
 #
 #MVENDORID-MARCHID-MIMPID,Version,Filename,EventType
 0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/bullet,core
+0x489-0x8000000000000[1-9a-e]07-0x[78ac][[:xdigit:]]+,v1,sifive/bullet-07,core
 0x5b7-0x0-0x0,v1,thead/c900-legacy,core
 0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core
 0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet-07/cycle-and-instruction-count.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet-07/cycle-and-instruction-count.json
new file mode 100644
index 000000000000..5c8124cfe926
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet-07/cycle-and-instruction-count.json
@@ -0,0 +1,12 @@
+[
+  {
+    "EventName": "CORE_CLOCK_CYCLES",
+    "EventCode": "0x165",
+    "BriefDescription": "Counts core clock cycles"
+  },
+  {
+    "EventName": "INSTRUCTIONS_RETIRED",
+    "EventCode": "0x265",
+    "BriefDescription": "Counts instructions retired"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet-07/firmware.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet-07/firmware.json
new file mode 120000
index 000000000000..34e5c2870eee
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet-07/firmware.json
@@ -0,0 +1 @@
+../bullet/firmware.json
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet-07/instruction.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet-07/instruction.json
new file mode 120000
index 000000000000..62eacc2d7497
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet-07/instruction.json
@@ -0,0 +1 @@
+../bullet/instruction.json
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet-07/memory.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet-07/memory.json
new file mode 120000
index 000000000000..df50fc47a5fe
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet-07/memory.json
@@ -0,0 +1 @@
+../bullet/memory.json
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet-07/microarch.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet-07/microarch.json
new file mode 100644
index 000000000000..de8efd7b8b34
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet-07/microarch.json
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
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet-07/watchpoint.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet-07/watchpoint.json
new file mode 100644
index 000000000000..aa7a12818521
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet-07/watchpoint.json
@@ -0,0 +1,42 @@
+[
+  {
+    "EventName": "WATCHPOINT_0",
+    "EventCode": "0x164",
+    "BriefDescription": "Counts occurrences of watchpoint 0 with action=8"
+  },
+  {
+    "EventName": "WATCHPOINT_1",
+    "EventCode": "0x264",
+    "BriefDescription": "Counts occurrences of watchpoint 1 with action=8"
+  },
+  {
+    "EventName": "WATCHPOINT_2",
+    "EventCode": "0x464",
+    "BriefDescription": "Counts occurrences of watchpoint 2 with action=8"
+  },
+  {
+    "EventName": "WATCHPOINT_3",
+    "EventCode": "0x864",
+    "BriefDescription": "Counts occurrences of watchpoint 3 with action=8"
+  },
+  {
+    "EventName": "WATCHPOINT_4",
+    "EventCode": "0x1064",
+    "BriefDescription": "Counts occurrences of watchpoint 4 with action=8"
+  },
+  {
+    "EventName": "WATCHPOINT_5",
+    "EventCode": "0x2064",
+    "BriefDescription": "Counts occurrences of watchpoint 5 with action=8"
+  },
+  {
+    "EventName": "WATCHPOINT_6",
+    "EventCode": "0x4064",
+    "BriefDescription": "Counts occurrences of watchpoint 6 with action=8"
+  },
+  {
+    "EventName": "WATCHPOINT_7",
+    "EventCode": "0x8064",
+    "BriefDescription": "Counts occurrences of watchpoint 7 with action=8"
+  }
+]
-- 
2.44.0

