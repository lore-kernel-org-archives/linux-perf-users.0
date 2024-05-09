Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3984E13C9AF
	for <linux-perf-users@vger.kernel.org>; Thu,  9 May 2024 02:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220944; cv=none; b=NBamtmVwwQz0VOgXfODH27soZhZtPkReyUbpMhTlT5LYp/WPT5lE5FUu3XWNYrJEoCjWCXNTCzR4LfpjemzeVMGoy+j/f2CZs94g5qduDxf9Visxaz2gsl5iksszExdcFSfgJM3mlOFT8sryuSBT83kNGO8v/qymDirwjh0CPbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220944; c=relaxed/simple;
	bh=Iu311TczZIsix8mkevqQfADdJvVDpzmvTK6U0CE+LSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bodlGtsafs3PuRKFk3XSCTkPL3bpZ7RAVe6u/5UQkOFyoTwxvxB3vufG26SWk1xdDxjohIvQ6QkpATZ9jHudNFx19K2V+PN2WVQF1lnA0NRsgmAMkotbZISRX9REZDNuC4p/GJgo92qSpq/2upCukOqJMWFa/COpNtsmGzxCkp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=HwEld+i6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HwEld+i6"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ee42b97b32so2446455ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 19:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715220942; x=1715825742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87E4iSRmo9mrgwWJanbsXZLAcY2dYepbAJhcT3XMrhE=;
        b=HwEld+i6tBEGByeb5DO/gpz17ndng4VVi+St8PxOn7EoaDcH/zOxkebk8c3/QQeBgZ
         GtLER/gCjOwBwxAPfrMZYulSdZi4IbHVkw+7qY0+dfD/7rqpZr7Q9HCg6zDQWbH8APfL
         IHpbKzFObd++pxV/Uq1glbRyVG9E4c92y2RpGTlMGxqPVdIEpYgw/dxh8QGI1RFOAl7Y
         IX2fFXYjwXkwHdes3CvVLrVhxWGvL+upSMFErQVIgIZYiJnMoR86Oy4t863rRmwe+2lM
         H4upppeRrqbFaBaKP7hP3PmdK2Ebotf2vUzbbdyRudYqdnup+5E12yFVblWgJZbjakc5
         Y+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715220942; x=1715825742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87E4iSRmo9mrgwWJanbsXZLAcY2dYepbAJhcT3XMrhE=;
        b=hrAzSjHcl6RPkaoE9/k+uyVSV3MVspow33eZZoX9p1JpUCkEOQPlKbyji9s19uWz+V
         eTQum5zxF/sTCM32E+tTovYX5KwltDUyjwEEG94URa2RaecDl5d+RqEOPEo9hV4ZmvMu
         +d8Hbk7dvV9y10Kid0hFU3dHNvRGIbjHryV4YRfwROkyrxhZrejg3tPVMFiih7ywDEkf
         mMQNUCw1m6XrVb1KGjCvLOOMUlJR7VYETsK4wCj5bsRa01G4XM7O26TtPa1KctMv9EgY
         7YcH90o5rrYT1CGGwH7VGNNs9ZVo+GBzOBXsgwMM5U/zD8bW1gxEy97HXHsLZ1O+eZ22
         GCmg==
X-Forwarded-Encrypted: i=1; AJvYcCWb+zOlYfrww1MnJOq0lTPTkaTovAybYQRfE9nrWwzmwX5QAJtF3uSac6J1FHDTPEKHxMo5ilAfUr34pD+HIjOKQyQVDLksvbHTRcya46yF0w==
X-Gm-Message-State: AOJu0YywHl1O/+9zqgaAMPXif4iebqm8gtpQXODCdChhaPbN1fv1Ahvx
	C5iWSc5TKx1MSn1bcHwtflMJn5gixY/OfGjflt+hI3xHFwjqIjLRQr/jAMGH1Mo=
X-Google-Smtp-Source: AGHT+IHsVW6mAhGNlmhstEPNjmMVMS6IDZM08cHLd8W2dyhnJB0vPhFCSwQ0a8gQZNg3Ah0DLaRzzg==
X-Received: by 2002:a17:902:e801:b0:1e4:31e9:83ba with SMTP id d9443c01a7336-1eeb049b32emr55875905ad.1.1715220942625;
        Wed, 08 May 2024 19:15:42 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d176fsm2339115ad.58.2024.05.08.19.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 19:15:42 -0700 (PDT)
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
Subject: [PATCH 6/7] perf vendor events riscv: Add SiFive P550 events
Date: Wed,  8 May 2024 19:14:59 -0700
Message-ID: <20240509021531.680920-7-samuel.holland@sifive.com>
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
2.44.0

