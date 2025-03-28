Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAE81F418F
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Mar 2025 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184303; cv=none; b=L947Zh50A7BApBhB8v3GLU2fwuCdsIFwbnaN8VMWxiLznWcyThWudXWiiVWg8VfoXFOQ5GQv3gyiOg/eqBQF9EOSPsU1CwiYic2f+xUS5Bj5+JvY9DTbn1/+lUzeaVp6Q2Gq7UlmteobLhPaeljvjbO8AILn5clR5G+fmvo0bJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184303; c=relaxed/simple;
	bh=Vb8Zw2G8yDaioPTnls3nU7UxwtuE80WVgK353Gkw6uQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=gGFOBzSYGpt3ap7p8WIY1ge5QLZdaRnDJkDwI/mnyAlQIuJND3X0Gr4sKXr2cIHOtP1JL1sq8uIh7coqfG/TOJfMlqWj6ich3fJELqYo6u9AZC7WB0FxePaSOpa9prWI0RfKvdohMrfYRcsm20ReNV4LhOA7Cxl4JEKW2GU12Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M3hsMrep; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M3hsMrep"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2241e7e3addso40058295ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Mar 2025 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743184296; x=1743789096; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DD+qgAbA2jbLVZa6aUPEYkzjGKc51TnF+sfLKzMQeFc=;
        b=M3hsMrep6vRfvWrbAqkqb4WvIVmFWUSt1rhbF20uC9D5nbC7dCdVHk1P5vqlvisJlK
         4WEFT8Y6fPIKfyHAe4NpijQ4rB4jt8O1hG9M8miKPlH6xQVvruNts8oAsdEA96OIRlV+
         LdkRzhLmahZiJgNsY7xXDjMndb0R3QW47H2ZL2pK8Rb5Hw/MxldtPCvWIKAUxlyJ7sew
         jsDu78G2hbq5WL2ZRxvV123aEPEsHde76wkr6LqOjc9Xp6Le87e2SV+7mjDwuFsTp/Me
         Tk98yUxeYvaCxSOYf88ymW8RLdDh6gqzpBArrquRBFiF8l84wY4UA/3EWPirRe6ljkEm
         Wofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743184296; x=1743789096;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DD+qgAbA2jbLVZa6aUPEYkzjGKc51TnF+sfLKzMQeFc=;
        b=XsZs5VRIASS63OwAXO4162hjz4McoOQ93xHqk9+7/XPvIaDBJNG/+BMQjcL4R40AzB
         t7c16JzFHGp5ZaUIU9f8uvO91o/QHID3nHsWSu+FX9EiFhKO6dCb93mIT9VHYsX4qQx0
         b8v6PuMfgT7y7+zibYt3vinUoiOyA5qMkDIXKUeuhmKf+NUevg2mOM0Nzj/MO7HSsWjR
         aQy0XeNt3fA2uHtO6bD92L6Is/wY5e7AiVsaPcySuLylPwjz3JoCgtw/sFsiJP32CDEx
         r/ZlJFXG77hbMbCQIf+g1kZhxNyZAi9BpTHyWy7f6+nTf3qWUtjCxzU2DhImqVeax1zH
         kDNA==
X-Forwarded-Encrypted: i=1; AJvYcCWmLJWxDEb/8ExVxOTs1vqTOopD7cmsRHWjW7oIqq8mX1eQnhMAphk7ohELlvYXqI1SP5TGApch3X0boJqF816y@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/cmw0S5GQaxjLpGDdTlod2Tr3m3rGCkFBZnJ9a6iIFS9GksKR
	stIOdXlZc87NqTbZrhi7+7iB3aLtAQW7c9Kq0Rz2ttsPb84FGBg1mmmxHab+I6qSZZWN6GRVmmx
	M+XYmLg==
X-Google-Smtp-Source: AGHT+IFsmWWdQTvozkILE//7Ob6SL7BiANQFVN0YKIJqJ1MYj92y0pgJuWlRPXIkhznjT663QT8Nnjef/uc2
X-Received: from pltm7.prod.google.com ([2002:a17:902:6bc7:b0:223:58e2:570d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea02:b0:221:78a1:27fb
 with SMTP id d9443c01a7336-2292f94499emr1007995ad.11.1743184295682; Fri, 28
 Mar 2025 10:51:35 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:50:05 -0700
In-Reply-To: <20250328175006.43110-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250328175006.43110-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250328175006.43110-35-irogers@google.com>
Subject: [PATCH v5 34/35] perf vendor events: Update westmereep-dp events
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
2.49.0.472.ge94155a9ec-goog

