Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DF22661BA
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484231; cv=none; b=WaP8vD16CWczNDVglveHhJjoVKPMDkQNpWMoaE7xzWPXtb2GjFzatzvkNAin5qPKu7b27emTcjc6lcgIgUyYbS6HNF9w/YC20yiURYWsYKYYLLLCPZNULtFApZPnpzQhdp0rjyOwyJywxJ26DMyusGRtyUHIMnNrnuVoOqqNLO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484231; c=relaxed/simple;
	bh=RH9mTXpLEXxehhM9S/OH71zl3/OTqsGOSeWnCskvVKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2Lhd/Q/9Fo/TtETA8ZKdUnTclHDIE6gIr25t0rxVOJwAjHTd6YuqhA3j0IhbM0nme6o5UcBiO2ktpvB2WEgqyEj1dR1r+ycnPrrK/wJdDumhRqtM11wDHj1Kabl8XxS5wRqBUm4p2DHwvCN34ypRClKfxDZ5WzLy5+oHM+HaIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=H3lEYiag; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="H3lEYiag"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fa8ada664fso2267808a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 14:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1739484229; x=1740089029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/XRmolauA8HsXL+HjHSdxsYuvck1P5cD8Pp1VwoHlc=;
        b=H3lEYiaglNh10jqmSlbMGVvMPMybOlBbrdK6UT6XeciyQW6SXRzu3Dk3cKlIOI842x
         9FSRMBdjEWr2DgC9mDWqjJUPLX5LgmWpO0JcRqFnX09GFmI0qSBQ03w8fJYzBUWzfRmw
         UlLrys8aU/uLk1PLnB5Acx9Hd6VR2O1GcI+tOY+Tx/qOG5xAkfPA860wx1dznpwRNp8O
         3kK97kIrouJwf8hpCQ+CayMo5E60TMj9UzOB76EpgxnAJ4851JamhePrG137cGZ8fsJP
         oQr87RKxZmvjsuEg6UA2kgSAD9OIsJn3J2IytKGYIbfyq/9hxIoot70hHQmPjE2g+6jc
         9qAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739484229; x=1740089029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/XRmolauA8HsXL+HjHSdxsYuvck1P5cD8Pp1VwoHlc=;
        b=s4HoH1mPupcz/GXH7Rrs3IznHkcIXQ7w0iRfT/chY4iN5B/Wrnnrud6u8eCYwh3MSS
         iQQdmxOm0VcHCBuix9y4q3QPRkla+e7/r84hzsENYYBsu6eATohBkLSA1ujH7ta+He1v
         ms7fhOAbU8CDYpkWLxIidPYCx1rBN9so/6DnoeNBrzxrjBol34Ch0vUjnDzHuUrw5qUn
         9Hv84fe71iOFkARyKZ6rdSBLA1ZxoAOCP0rhDsB6vGwrx5KZyKOyiFl02lFAIBaz4GQs
         enliWNl8bfidOaf/mtKyuwr6JYcR3EBN6A7fHYkja1usCTvLuMx0bwhqHe0GuXgDDJ8m
         Fpcg==
X-Forwarded-Encrypted: i=1; AJvYcCV6V7Qxn/RqidZZmAU8YAYGrX3exMdhEGN18qp4UU5twNE/OHh643P3EnlrOox8AXw8NGenh8q6mIa8+0DqOni5@vger.kernel.org
X-Gm-Message-State: AOJu0YzzpcpvRuCrnpkIbFzR04bkyufVkkGIhKbeeOLAmbrcH9EgWcoS
	esX4Yp5r5S8hbWoyUW6mE55YW/2B3XxZMt6YziTd+BI/4o5Ih3fVQpJJ6B2z05E=
X-Gm-Gg: ASbGnctUwUR202Zf+ppFVaWvSaGv++gGSclvYSb9J5/haqo5jU8Xv3Y09Lajbmf27hu
	BS0MztXQusk2JrhufOO8DzUajIxiQkkdSlmDZRNaSKSmxovJGns4YC4a6hHR6OP8F7ZLB0GM/ER
	SLQHBeRd/RUhiFiiG7opMOfRQ9L4jugk9ZrynqqkfYPiWIU9U2j56OsE6/NOq7S7z2Vz03TIqRU
	FPrP+QScqa6oEhvBKSaBrILIdN64mxCBTS87Qq7B9f/Y0PKgDVvsOSyfLI9mi5ToKpjlEKrYCSO
	pNyxsLUVv7uPP4vZ/2evKgItGdhdSroVcGkUcA==
X-Google-Smtp-Source: AGHT+IFr5642PZ4S4cAQu565jWRyFkBlnbXCXSsluhdUxLUrOkhRXXGZABXTDLwLTypE1Yp85dnzGQ==
X-Received: by 2002:a05:6a00:848:b0:730:8d25:4c31 with SMTP id d2e1a72fcca58-7322c38506cmr15085587b3a.8.1739484229334;
        Thu, 13 Feb 2025 14:03:49 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e438sm1847491b3a.94.2025.02.13.14.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:03:49 -0800 (PST)
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
Subject: [RESEND PATCH 4/7] perf vendor events riscv: Add SiFive Bullet version 0x07 events
Date: Wed, 12 Feb 2025 17:21:37 -0800
Message-ID: <20250213220341.3215660-5-samuel.holland@sifive.com>
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
2.47.0

