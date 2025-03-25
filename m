Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31BE25DB14
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920928; cv=none; b=CCNU5VztdeGNx1J3b7dz9DpUCCvOgxEzSDDgKD9nNRCTJzxnHjHQEIVAUSoHrUIPQEQOP2JqXBkHM1L7QLyyQ5ipWrWumLCUilrYdiWo5rFwHuaat/UTwAq0/G41/btBA+st8Ql0wIf8/cghLe/DXTLVSyCyxjew8uKA5OGcS78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920928; c=relaxed/simple;
	bh=9yS94I0V+aj5EaLixu70v/BvSVLiAUj4x7/o+VoVa7U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uhHqzaY68mHKMansxIvdQTyEsTjOvUuyj6KYnfm++QK7mjzioXdOkrHDLo01qUGXiuKjuQVq5ITBM8enhfATSVlTb2brvX4iGtYAlWX8HmT5EjRl2YE/HdCoP+iYoF1xxQnrw49UrB9HWyEKhuGM//yrnm0DXXP6UkRslRqPmYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ijUYWTp6; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ijUYWTp6"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3a109984a5so6650616276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 09:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742920924; x=1743525724; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RPugHL8eCvwfstte7zHSdBSJ9ey/olpTRBhxpg/Uv8M=;
        b=ijUYWTp6vB7X9x6njfGoLOiSmrh2nPO+vjYu3Hg07bCt7wNAjA9Po9623VXzic4ago
         1hdU6WuDwRiCSBbQSOErxjV2B1TJNMprMeyzhBvQSQ4Qp2PQfj/zqsBUyKdYDwEzUuXO
         rAFhOk9eQITaKiSpqVjW//mO00GvlRBgoWTSTiYf7hQ+2IiSOHUI+17Np5oJTC/MGKn5
         4GAeDchOwPCqLX7j0DLo2BlE5+7BAcx9JQUxoFE552pXyACwt1cmu6KX52I5+/GA26Ox
         Y4pYRRumGEKewHvnD7/4C4G+b9NTYQ+VmwOJtd403hI9D8cDPFNHU6T77cPo/05qDb4e
         4jAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742920924; x=1743525724;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPugHL8eCvwfstte7zHSdBSJ9ey/olpTRBhxpg/Uv8M=;
        b=ITnJj8RvW8FEil8mf/zr2daNwirzxLbOnUB1lhA3Y/MxN4rdaMNVP2UyJXRkJSvO5z
         rGl4WN+GhZ4uT+eBcTv+SvuAfdNMtzVZyi0NhUlUPF5CDQ8+c5COjZRaTwrYZklqdNqm
         iUaqX3OFjkk/GvpmUOeo7vhqSrXihoL9hlkH0E28yqvBthwebTJwdrrXspcFXg0VyjWc
         bmeDMih4+HZUdFHC4NOR82ACP+3W4GFnXx+geMXGz5u/UPi+eeHWGa8z0pLmfSh2YK1b
         ZQXCP0T0QhiEM44V2TyNrNcu//AiB2i/xqcLwP1/opx5WFJPtnLuNtY2UPIitEvzx8Xx
         17Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVTL8/cd61Zk0wpwbvKegwE7+HAX0IrCHMupYPqPT/C9cKPdaBRwOp7EmtabMVhYqgoN3ns1H/Ng/o60MXDfS1v@vger.kernel.org
X-Gm-Message-State: AOJu0YySzbfNK4JTMibmojajFlSn4KbfTLVgtLY4Ruvs9h5ud7YieHH9
	3DU7wKo+c8wDqs7O3xN+nzE9o2Wh5J2aWfxcsWNe4Z9RVJ9b3TVSmVXjxFKGkM7APv2ocRrPSRH
	kDF3Z5A==
X-Google-Smtp-Source: AGHT+IHds7r9R9NDbM+n0zARfRDgEes0cddmvgi2De604ANvOJBFbjpQrm1pSRvVfIXcafcK3ZIDt3q18V1p
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:40b3:9c02:57a5:693c])
 (user=irogers job=sendgmr) by 2002:a05:6902:101:b0:e57:3500:2294 with SMTP id
 3f1490d57ef6-e66a4d42cc0mr7267276.3.1742920924630; Tue, 25 Mar 2025 09:42:04
 -0700 (PDT)
Date: Tue, 25 Mar 2025 08:15:10 -0700
In-Reply-To: <20250325151511.13628-1-irogers@google.com>
Message-Id: <20250325151511.13628-35-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250325151511.13628-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v2 34/35] perf vendor events: Update westmereep-dp events
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
 .../arch/x86/westmereep-sp/cache.json         | 32 +++++++++++++++
 .../arch/x86/westmereep-sp/other.json         | 40 -------------------
 .../x86/westmereep-sp/virtual-memory.json     |  8 ++++
 3 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
index 90cb367f5798..0cd571472dca 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
@@ -119,6 +119,38 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/other.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/other.json
index bcf5bcf637c0..c0cf8bae8074 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-sp/other.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/other.json
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
         "BriefDescription": "Loads that partially overlap an earlier store",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json
index e7affdf7f41b..a1b22c82a9bf 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json
@@ -128,6 +128,14 @@
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

