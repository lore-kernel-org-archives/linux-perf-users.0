Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B441A01B0
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920772; cv=none; b=qFSiXvwnKirq7XabE6Dv4R+z6tCXiylrKjjDu4/bdGuOVxbCqk1sALfcVL73IkXmmndIJwg07ufgSJqrcJCdU5rnT3VXwTZRTTuX27vsYrji8OnQG2fAkwyXFSzt5I7u0p/qoe+gOKu2FR88SRCN57M6vGtIRkKg+165Z65NFUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920772; c=relaxed/simple;
	bh=9QtWxO8l2GpcAYbRMHA4inZL25MuZzaCf9TT8yzkl7E=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=s0B+0pg4P20o/RpbTyEef4id9dcZmveRzlr41MpO4OnM6k3jH6ZIobx3nrXu3GfRWwP0Xsb43guGVD2xZKLWEdZNb0zHClp34ysj21cIaIjIPJQWMYum4Q8miywyQ5GoTiGCQ3IzzraKHL3zbu10vA4aYXTBMkogL/YvvDtGjLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=plNEyzah; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="plNEyzah"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6feb1097d64so69835317b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 09:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742920770; x=1743525570; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bjcCoWPLeFv7HToZ+VPWd4Z16z9IeZ5E4tfOnaC3rvg=;
        b=plNEyzahtoVv02YgITTWR9gmNxNMZXu3x7xVZdD6zBJHs6IuAv5mDv3lNvL4JMrGXu
         I0Ox+KJvIK/KzjUszbOAJtItr4pbPzD430O0w/Ny0jrV/vqXRGSFND8W4xKlYf7utrUM
         69uEG/b2hzq1YMzZvgkfaN2LttGivQR23VsT1IDT57/wbpUOj7bk4upPAEnbOY0mdqW3
         TubLo/fwH/X1ueYdJRpgWR/vgRCWYs1iwYS3ULf9ZP+L60rY2/MY9XNqRK1EOiaN2BK6
         6/up63KWei/bt764x9/3DbCqX8GasmSf2XR1WajVvt1maDaLfFz+unOvQMXicdxwT+Td
         zHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742920770; x=1743525570;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bjcCoWPLeFv7HToZ+VPWd4Z16z9IeZ5E4tfOnaC3rvg=;
        b=VYXiLsNetEc8MlX8keBR2i5X+C9weBhnCi51IiXQiJRW6zoCwRGSX1ZeNjGgJOLstv
         EUCHSJxAcEzhGge6TbQRr1El0+73/vrXlbnrgIbHfA+4uAJST9vPHMQwozsIiWfQ2bUZ
         +CZn5kbx8328hiO2YlEgtRzs5PejZwXZAzzeRZl4B4lizkyN0V8MKvrL1BXjT5dbj4NG
         8mdqHk/LLyI36psH3KO44JRmVyclzmkX9vgpbS1va8V/Iu4qjGO9W8Mw8VhF8LQQkUeq
         kLoPPgBSYayUtxvwBMp0bUDkdLxwXr4IUmh1y8Lq+9sUbyUyEO/QXiCwsMW+D+kDhYIt
         /6Cw==
X-Forwarded-Encrypted: i=1; AJvYcCU7gQxuAVqcq5YeAk9O0f1ldVVvOjhzOHTBKjKUk2i4fa55EsD+B0y+8A8qcGaS/ivXVERittyFe3Do+xhwUc1F@vger.kernel.org
X-Gm-Message-State: AOJu0YxT8VZv4LznGMlPG5epLTcYqxAb7oKiRfjw5rndaCmsJTsFbJZd
	xTzuoKLtcc2wElpoYJPAMzek/We27GrwCXf9GMnrRu2JgW7X6SBSj4Wkzm/OUuHltSM+hHA6zIM
	8HjeGAw==
X-Google-Smtp-Source: AGHT+IGdB6wbpBTqFd2Evu7cWcXPKmn5GFxVH0GEAj2YVW+usxSd/sxMFvU4hH09sQcX6fhUOK3tmjHFtHva
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:40b3:9c02:57a5:693c])
 (user=irogers job=sendgmr) by 2002:a25:aa8a:0:b0:e60:8a7d:3e90 with SMTP id
 3f1490d57ef6-e66a4e57117mr7298276.4.1742920770204; Tue, 25 Mar 2025 09:39:30
 -0700 (PDT)
Date: Tue, 25 Mar 2025 08:15:09 -0700
In-Reply-To: <20250325151511.13628-1-irogers@google.com>
Message-Id: <20250325151511.13628-34-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250325151511.13628-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v2 33/35] perf vendor events: Update westmereep-dp events
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
 .../arch/x86/westmereep-dp/cache.json         | 32 +++++++++++++++
 .../arch/x86/westmereep-dp/other.json         | 40 -------------------
 .../x86/westmereep-dp/virtual-memory.json     |  8 ++++
 3 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
index 30845c7dbf08..f6f95f3ff301 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
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
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json
index bcf5bcf637c0..c0cf8bae8074 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json
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
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
index 53d7f76325a3..84c920637b12 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
@@ -152,6 +152,14 @@
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

