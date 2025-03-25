Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C82E25C71F
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919438; cv=none; b=aP42MgsvreBrDPoIjzhyrDGp0oUk6B6BVHlRAqJzdO2QOL+BLLov250WOP3ZjDXwgzRiHzuyXk0wQwS9d1dZFETOM911bPRjWrvILBMRQmJR23qXcPM47TTNUTLnjT5zktOVti0w7ey//fd9spaFfX5j5mW+oNI/CkhgOSW6IjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919438; c=relaxed/simple;
	bh=Zy0jRafJxRLJGt4ZHFy+/ySVLU1klhzlJJANwxxpiE0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=UAWMUk2ITS0RAcKYHDca+8YsoDUN8wxAOCSLosRyesdP48wM+DpFFyVhkRnuKcFTkAzq/LJwILTsxiKXCluSdxoIdtTl2sDkptZj2KnnR21qYjWBMFNstkiM5mB7DqX+xQkAF281AxCsCik35QGcpqPDWn+wJ5Ht7NDqmrRMw3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VqZu5Uob; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VqZu5Uob"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6fed889e353so83477997b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 09:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742919434; x=1743524234; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kWTSLGRSQc6JnxhtpbR0m8qTat7TUVK+43G8X5ABzRg=;
        b=VqZu5UobEhVSfBSrl15mJIOjb9/LNXoEY7qDiUVb2O7E5oCcCA6BwGn6mH9HU7selT
         2Fj7ByuxupwCMngL0pY56WH039RzX0DC9DA6o8Jc2IVCpemQriiX6wtilGa7reCglFjj
         rC/FERusXsJLkDvZ1urbPGWJVlYWqiGlY+VycLRhAreMo8KPVqFKM/SJr+yCqGCmVK+D
         Qzuzg9kR4WjzAUGi1wdJ96Q+4kylZ79M008efkok1LIBPkEje8oLmUgxgmz+NZfjo9uK
         whBAW+dQLXO/xiL38VCPhBhgTaW/v2PC8PgeVzNY92IpfJ3Y4rW4dHnGHu8B0crRztHb
         JgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742919434; x=1743524234;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kWTSLGRSQc6JnxhtpbR0m8qTat7TUVK+43G8X5ABzRg=;
        b=CVe61BYz2s2iOhFZ0Sm807A1mXCKqOcackUsQR3Ca9t9PopNEz7t01BeC1vLG4dD2H
         apulTmAUbKh5oSRhk7PdCSea44Frb5M1h29bCRIcDQuNdQUFaxrJ4CgqPBHOa0Hz7wrw
         YkF0ax9MrSALEc7hLfs6nsNV/cIqLyP6Zl9OqKjbS0c27vx9sziVNiqxoTV9fTsEmTYN
         b+tyNldZ9CtBpM6OVpsHW0VhTeIrit2X5Q3QKVgdWoaeDUmO3iSKZNngYpsQ+qqMHqx7
         FRIRZ08RQBKaB7QDDv9d8Y3eU8+vEQHP92E+yHW6uv/nVhQ5egl4LZJJ8KW3GY6wEYuI
         7Z6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqGm/QvHdnluScGDjrInEk6uf9drlBOCro9fafHgylGshMViGq8gKaH1V3I5VRHMfoJnouY+Q+Iw64VBsQ5Yhv@vger.kernel.org
X-Gm-Message-State: AOJu0YxXVwyjiRXUPfIsv30ycVd8SyIWA4xr7amlXPIDAsJ9uRI5TIz1
	sIG4T18AXEpeA2r61Oq9crTKOrLL7cIZxdmoDdiRYkqaY5S1RT1WX6MK3J6tigQ1JTfB4j5ZIGZ
	r63xnIQ==
X-Google-Smtp-Source: AGHT+IEcIafZTeM8RtrSrfxRcrnBbWhlzqvUzwtQ8SLqh5V/te2Nwg7m+oI+ftjZA4tKxki+TX94s1aDpvRP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:40b3:9c02:57a5:693c])
 (user=irogers job=sendgmr) by 2002:a0d:d2c1:0:b0:6fd:2fb9:f109 with SMTP id
 00721157ae682-700bad107f9mr94147b3.7.1742919433646; Tue, 25 Mar 2025 09:17:13
 -0700 (PDT)
Date: Tue, 25 Mar 2025 08:15:00 -0700
In-Reply-To: <20250325151511.13628-1-irogers@google.com>
Message-Id: <20250325151511.13628-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250325151511.13628-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v2 24/35] perf vendor events: Update nehalemex events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Update event topic moving other topic events to cache and virtual
memory.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/nehalemex/cache.json  | 32 +++++++++++++++
 .../pmu-events/arch/x86/nehalemex/other.json  | 40 -------------------
 .../arch/x86/nehalemex/virtual-memory.json    |  8 ++++
 3 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/cache.json b/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
index 2c0ea6f8c4e0..b6c6b22a3188 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
@@ -239,6 +239,38 @@
         "SampleAfterValue": "100000",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "L1I instruction fetch stall cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "L1I.CYCLES_STALLED",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "L1I instruction fetch hits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "L1I.HITS",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "L1I instruction fetch misses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "L1I.MISSES",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "L1I Instruction fetches",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "L1I.READS",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x3"
+    },
     {
         "BriefDescription": "All L2 data requests",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/other.json b/tools/perf/pmu-events/arch/x86/nehalemex/other.json
index f6887b234b0e..5fe5ca778e9f 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemex/other.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemex/other.json
@@ -15,46 +15,6 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "L1I instruction fetch stall cycles",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "L1I.CYCLES_STALLED",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x4"
-    },
-    {
-        "BriefDescription": "L1I instruction fetch hits",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "L1I.HITS",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "L1I instruction fetch misses",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "L1I.MISSES",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "L1I Instruction fetches",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "L1I.READS",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x3"
-    },
-    {
-        "BriefDescription": "Large ITLB hit",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x82",
-        "EventName": "LARGE_ITLB.HIT",
-        "SampleAfterValue": "200000",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "All loads dispatched",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/virtual-memory.json b/tools/perf/pmu-events/arch/x86/nehalemex/virtual-memory.json
index e88c0802e679..accd263cfbfd 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemex/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemex/virtual-memory.json
@@ -88,6 +88,14 @@
         "SampleAfterValue": "200000",
         "UMask": "0x20"
     },
+    {
+        "BriefDescription": "Large ITLB hit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "LARGE_ITLB.HIT",
+        "SampleAfterValue": "200000",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Retired loads that miss the DTLB (Precise Event)",
         "Counter": "0,1,2,3",
-- 
2.49.0.395.g12beb8f557-goog

