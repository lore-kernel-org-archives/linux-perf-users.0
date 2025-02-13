Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D4026E145
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 22:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484235; cv=none; b=dwmahtsQiDAM9B7jhN8Ai/+MhXkArUcCuTxaHc+ZkMMNgRmJlVolzFlutgHhiNcfKNpSIfkYAdvyM4kekgCf/XD1Rz7/ItffXACQX9K3wfOFO9SBUon9B2i+Gz4SsNtw9Wi1wqBaMpDOcvYJWFVTTAnYSRcmX4rnuccov64MQIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484235; c=relaxed/simple;
	bh=BO70A/UWBisZdnd3LKEcvDmGCVLX2gKos8oxhHHMvZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhy/6pkqMHX/RebD3T86zaw5SC5/HxEr0o8PoEOYa+UdJVEQ50AyCTHSjt1jONllKmef3CDNlyvitMTUuwhK6cA+Iiwb8todKbvIWBcSdycfXSls2GrjuYlwn2yD0ocyqAO34lqUXLZ8rwyk2AbmvaxgosRafYU8Wu80X2PIrSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=IhQ8PEOd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IhQ8PEOd"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220c8f38febso24708545ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 14:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1739484232; x=1740089032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18UWmkwgQnETzvo0Aj9eOHJgSlzdNFYfZZtF5VBdI4M=;
        b=IhQ8PEOdu6IJck/7zpQ595tTCJPfFaFQJ6gKNxTbI2FG1WoG2CrkDOxTCnVx+C9iXJ
         rixcv7o63C0PGs1RZXp000xI3vxBoXwibfQG2AjyMlGLrXeWNmWstAQ3gF3+WUGEgCfI
         a5VhHfnkMXQEwlbdkFiopmhhgMYUroUkzOSAhG5iUKSZhXQd/8+I9t2V0Ic4f1rmYrmy
         Lj+BTrZLtm3q2UgiF641cT5C3MDmhJU3Gt9W0thweaOQxUjjkF+3+g9a5v1lYn+qecYh
         ut3SDgbS5mzY8jW50jzae3SY6s8r53y6tzZgA5V8bDHys5gvXxviAxPiaQ0DNYWyq3cD
         Cutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739484232; x=1740089032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18UWmkwgQnETzvo0Aj9eOHJgSlzdNFYfZZtF5VBdI4M=;
        b=a8mypqZiQTHbBrUsUJE1pavWu85SzKc1gcnHiJ3qoEv9lectu8UL692uceA63nLLEo
         BXsbrLkGE/Vi2BePWYRCxEMCBbVvP3FYylFS9aftPCMTi6qNaNnjUzlzopBNZ1f3VDci
         rfW7Gp6aEV6/LDiO+mwLk0S9V6fl9lD4Hh88WUMdOa+YnEkPPEwhZHoJHRZCVIgL9evL
         WJYeCRhmQLODCrwwQG5C2HHgvadmI3HgNtNNf4AP0qE4irBPAWnVe9x4/F8Ao5uyYQlV
         V38YuqjNFLxxXN3Gg1fOnpw416x4j4gp27tA0zjbIi8OVYz2brYETI+RQJWQH7DZMfG8
         EaVw==
X-Forwarded-Encrypted: i=1; AJvYcCUI8xx76vl+7PxN2Cw5I0+b2ufPNwmOha8Vl4JTgtI5AOzTyrEGkDa9enhfAOAfwrd5MHR3ivAtkPZh9JUsF27g@vger.kernel.org
X-Gm-Message-State: AOJu0YyqwdBOZ87oIr0FSy1Dvxr7v2cB8ZNTPX8R4Sp0GwtP8zfZGZ5I
	x0+ID38eUWsPJWdWUfoyj3wYKFjfbI8aviNCot3MKUsQLDXOYfhtOriPLs8jh7Q=
X-Gm-Gg: ASbGncv4Z7X6hccNWxeWjuQim2bHjMblvg8uudBz66pLVjPNB7CY4sPwzFCsAtf9ywO
	0l8pIk9KkohVfPHmh/dPUnt7FqKCQImqA8DB99OB6rJCOZU+vffVx+OyW4688MV1VfJgl/iuMey
	YbOJTk9Hc1uppVLr1h6flRWurAeWbKCwBVqPwbcFR2aIiIeLu442mSfY+cPiwTqXOvLO6Ud6MoL
	4ct0PYPgGzqthaEqwIL4SFYqZOCqN3MOu4yss2YOgYc//NHG2A353kMlxLfQIdWuByLFCrdElD8
	/TBqd3u3kIEu74tbrFipnuYPfYkGHoLJ3HMPxQ==
X-Google-Smtp-Source: AGHT+IGLTppNEBIeBL2TiGhJ2DPAD3uNJTiM4rrl/8BgBXGEKYmmklPnZ313IiR6VvxKReIiceuQYA==
X-Received: by 2002:a05:6a21:10c:b0:1ed:a6d7:3c07 with SMTP id adf61e73a8af0-1ee5e530dbdmr14915863637.4.1739484232128;
        Thu, 13 Feb 2025 14:03:52 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e438sm1847491b3a.94.2025.02.13.14.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:03:51 -0800 (PST)
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
Subject: [RESEND PATCH 6/7] perf vendor events riscv: Add SiFive P550 events
Date: Wed, 12 Feb 2025 17:21:39 -0800
Message-ID: <20250213220341.3215660-7-samuel.holland@sifive.com>
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

The SiFive Performance P550 core features an out-of-order
microarchitecture which exposes the same PMU events as Bullet,
plus events for UTLB hits and PTE cache misses/hits.

Add support for specifying these events using symbolic names.

Signed-off-by: Eric Lin <eric.lin@sifive.com>
Co-developed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 tools/perf/pmu-events/arch/riscv/mapfile.csv  |  1 +
 .../arch/riscv/sifive/p550/firmware.json      |  1 +
 .../arch/riscv/sifive/p550/instruction.json   |  1 +
 .../arch/riscv/sifive/p550/memory.json        | 47 +++++++++++++++++++
 .../arch/riscv/sifive/p550/microarch.json     |  1 +
 5 files changed, 51 insertions(+)
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/firmware.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p550/memory.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/microarch.json

diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
index 9e9bd7ac0ebe..a301e9dbfd5a 100644
--- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -17,6 +17,7 @@
 0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/bullet,core
 0x489-0x8000000000000[1-9a-e]07-0x[78ac][[:xdigit:]]+,v1,sifive/bullet-07,core
 0x489-0x8000000000000[1-9a-e]07-0xd[[:xdigit:]]+,v1,sifive/bullet-0d,core
+0x489-0x8000000000000008-0x[[:xdigit:]]+,v1,sifive/p550,core
 0x5b7-0x0-0x0,v1,thead/c900-legacy,core
 0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core
 0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/p550/firmware.json b/tools/perf/pmu-events/arch/riscv/sifive/p550/firmware.json
new file mode 120000
index 000000000000..34e5c2870eee
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/p550/firmware.json
@@ -0,0 +1 @@
+../bullet/firmware.json
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/p550/instruction.json b/tools/perf/pmu-events/arch/riscv/sifive/p550/instruction.json
new file mode 120000
index 000000000000..62eacc2d7497
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/p550/instruction.json
@@ -0,0 +1 @@
+../bullet/instruction.json
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/p550/memory.json b/tools/perf/pmu-events/arch/riscv/sifive/p550/memory.json
new file mode 100644
index 000000000000..8393f81b2cf0
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/p550/memory.json
@@ -0,0 +1,47 @@
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
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/p550/microarch.json b/tools/perf/pmu-events/arch/riscv/sifive/p550/microarch.json
new file mode 120000
index 000000000000..ba5dd2960e9f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/p550/microarch.json
@@ -0,0 +1 @@
+../bullet/microarch.json
\ No newline at end of file
-- 
2.47.0

