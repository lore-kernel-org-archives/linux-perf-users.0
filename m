Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1F910979
	for <linux-perf-users@vger.kernel.org>; Thu,  9 May 2024 02:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220946; cv=none; b=rIfR+A6orXB+HoV2bwRd4SulOS2A6gWXz93Lo6a3OUy23J/KKkbf0+Cmr4ynRMpPiITtRIvnhUxhsBWNgzkedzU/SGtaljeCz4a1MXyPwOhZVrr2YyhuoY3AT5bHqSZoI9x2YfJIMvH7V4dbw5TwZsAhryQhwOYDQbaHnSYOiFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220946; c=relaxed/simple;
	bh=obqbFuCF0+EZFTfNgpkSG5EBGXrYr9QCD91ZqqrEax8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYWB5oS1JO49QPeuOL/Vhkxs8ajQpkwKt3EumWmxhJF2CSP0NkQgtA32FCnLxzluC0csf4gS7P/svYTExGv0MLQB6Xt61OEPFhpkhgA7uQ9IPRPt83si7TsyTf4rYzhyfjmw824+JHhdDpjXUboVSQD0KIke5fCvhHfg73tU0ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ZPQrWKE/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZPQrWKE/"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ec486198b6so2791375ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 19:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715220944; x=1715825744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pIBduwe3RMg13/lORG0pNA6/JD6DG4hGUAT0C8H3lQ=;
        b=ZPQrWKE/AktryksDEf6NfvzrSQ2ZoKFdbxSzE0FO4+1eQ1v1hnB7MBWiGMN3Psgeqg
         LZZuy7VDbkDu7RI/DxFj7MJikr0JaMi/w7vd7BTPU9QjoZ4Fjb0jAYg6JRuDj48yksvR
         bgOTM4UD6bAOUBDqLxuEKN37UEk6fOGz2O/5oqcPP7uHnSfYzVOKvT7kAvDeO23DM51h
         sgCkkGEtN/VDvTGD/eRGbZVOTLuskyWhYh6JEG6r7A/zpuiVUFDqGf1ybtEQwjOaHDyy
         KSd5aGWsmoM5qeusH/jGP/qik0hfzGIKFnvB2QaM2UHFycGOqSt33DI7KoQK2UsDnpgV
         +QqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715220944; x=1715825744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pIBduwe3RMg13/lORG0pNA6/JD6DG4hGUAT0C8H3lQ=;
        b=pW4Dzj0J8HS7LbW7SBCoBHhZIyfexasqHvszR+8V948ufSdRnc3eAVg0j5CME2TtBq
         4mYivOusJaIMEJoz7gp9PXNh1kLzCAWTdUuCj5AOrkdT2PdtJlwrysmDrxo66IMVwSmP
         iP9oXENLkkgjxbH/ElyZuaNSXwkIndXuFvbyo6IsIDiGQhUihnYzh2XgPZE4lqE6eVPZ
         A7hFl6tq3aVRDbERr46mGWlQ2Erd6sq24RLjca+qXdKgzUZ25JNBR3QN4PGuCX11wBhm
         aZpE0hBhFxd7xnhXkdez+XWdCz/DOLeyGJeNyU/T9ioxpfju54d1HbU23t4shQhiFVu8
         h2WQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4wM6tY8JoxbpcrGM/coXtwzFS31E6tHOYyCEPLHwwj80iU4BiUwEvWQnY91e0BEOTZRQXEddAmS/OIpusNhlwGRk1/nVSCulAZzVnByeicA==
X-Gm-Message-State: AOJu0YxBxSiQcOXSyE3IlX98TOHx4rNa0k/6xWervXjpFNecgZLiXFXy
	DlqjDnUAJcMtUD11iPDHePHPkFwbRw2DvQ8of7WEA1CKmouQAPwR5/PbtN9MXNQ=
X-Google-Smtp-Source: AGHT+IEEZLq+IYfVUB25BnK6cFxTtDl2tlIs8mgbH7oOj7JJJBFEXPS2na9S266EWo8ZuqvpnLlIJA==
X-Received: by 2002:a17:902:d4c7:b0:1e5:d021:cf02 with SMTP id d9443c01a7336-1eeb05976e4mr56002325ad.36.1715220944185;
        Wed, 08 May 2024 19:15:44 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d176fsm2339115ad.58.2024.05.08.19.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 19:15:43 -0700 (PDT)
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
Subject: [PATCH 7/7] perf vendor events riscv: Add SiFive P650 events
Date: Wed,  8 May 2024 19:15:00 -0700
Message-ID: <20240509021531.680920-8-samuel.holland@sifive.com>
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
2.44.0

