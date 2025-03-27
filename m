Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C361F4CBC
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114269; cv=none; b=pVD0bXkV0jJ8HUZOHVHlfd5mMA8M3l+EJiHvn/lzW7svNnJo0ZGDj+1hUcYRujvy7Rx3DRlSZF+RKkcDIgrAjTtahIulu9ZM0JrfG4ikE6R90UXOdHoH9uJaU0njGPhm56dt/x7l1XlaIfaWpJ94ZpdHcoZWmE3mduslxNmTwXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114269; c=relaxed/simple;
	bh=jhC27Zaa9rTrkKMgldvX9P8aqnSagvdFSdc7U7Jyn3M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=seiMqswPi30+7E1z1JUuiTBGD/S9dO6jqB3YkxIFewcI3/edG0t4R4mEIV+hZoFQJAGqoZxNwsCSccRNA+WgRrOzbzsmPt7sU/QJeIdL9faB4Xc4uHhiirB3VaqZVZaiaQbCrZeS2FFkHncKpZXAUMayIMCvsOXYsPUxIMoKVck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JjyI5zmH; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JjyI5zmH"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2c2b9ab3829so1034887fac.0
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 15:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743114265; x=1743719065; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTzW5K68zOFl8tHWsLxW3KBGNqm+tt/wZjBTGwX9wNE=;
        b=JjyI5zmHunRiyrgLFz0+f+nAVR9SaqYKr9+LrwTS4YLtvfBDQzFqs92+fKn/rV9/pc
         lpsf2WFKEQtLv10g+xchxqPGy4sjG95mFy7HMvPrf9Y2UCzlkNlCc6cEJDBO7Bgw3RLx
         C9KT9SP2aHzpCfMhSmSejXCfrbuT/D2FSo0knor/GlCfCFQB+HroOE1upW/b5fD/kOlm
         dlZpeItBJTVeyOj7NlumDkMxImzQ2Xh+syjCAxLPsR8b4Ebxu6cEFmf4U7fj82aJsIrV
         JlYd11L/uToN2FxYJQesJjdLULfZ5eouqYG9Y5NbNPAwYRxtQMmaxIq3+iMcuzVPVA0F
         r0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743114265; x=1743719065;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTzW5K68zOFl8tHWsLxW3KBGNqm+tt/wZjBTGwX9wNE=;
        b=lt+MyeCKLSm0PCGLm3H0st3tkH31I+8Z7QeuVdjOVfB/EGjn6swIyLSN0toc9OCnOO
         8bWcMDL9wbXSMAMjV37uSGBNGqJIEklSfnNTPFbK40OdG72FkLS8Sz5oSXHsLKO3xWTY
         B+h9+zquYirqQuOldaquuiDWtqvOWE4AEX8NvATRVLqWnaBEJhYY2+0rTZJthW2TeSJM
         P0D6n0E5xa0ocMAaRdk10qZIFdaxztmAYvRpfec7YwGeqbIMXKt5rK2BefuY9j0owk6+
         4rgld5VlSwLA8M3DvQD/1DaykIxgEf0S+TEA/evv/OqhoxYL5jYysNhibjUXG8e65pQ/
         uP/g==
X-Forwarded-Encrypted: i=1; AJvYcCVw/EIwFMhIkP6/we8hPAWbqECL0Zl7hQzxVcOpj7583nU6GZWwLUsEyLcT2z7Dn2jaeOZJraYIHZqT17kynB/l@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6XYYCXwRy6otgdRXBhF7MmuRSNsjzrxjyx6Ax9LeMxTAIAYMY
	hQzv0De3P0qiU9Rxwb3pNFbwGAFl7HYIDcPbR7P4oZuoWfl3FZ1DsZn7hw21OM8cjcxeNetPJeF
	jp/vPiQ==
X-Google-Smtp-Source: AGHT+IE96i9od6ViUJOkA41ez+UOYkJ8mtB5Vj5H23tEmmWP8dGexiZbjg+0rJfqjTQoMhX/yS9LUSnr2T/t
X-Received: from oabxj1.prod.google.com ([2002:a05:6870:4f81:b0:2bc:69a2:7ea5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:2889:b0:29e:65ed:5c70
 with SMTP id 586e51a60fabf-2c84819f69dmr3397439fac.30.1743114265237; Thu, 27
 Mar 2025 15:24:25 -0700 (PDT)
Date: Thu, 27 Mar 2025 15:23:18 -0700
In-Reply-To: <20250327222331.117701-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250327222331.117701-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250327222331.117701-24-irogers@google.com>
Subject: [PATCH v4 23/35] perf vendor events: Update nehalemep events
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
 .../pmu-events/arch/x86/nehalemep/cache.json  | 32 +++++++++++++++
 .../pmu-events/arch/x86/nehalemep/other.json  | 40 -------------------
 .../arch/x86/nehalemep/virtual-memory.json    |  8 ++++
 3 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/cache.json b/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
index b90026df2ce7..c9d154f1d09a 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
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
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/other.json b/tools/perf/pmu-events/arch/x86/nehalemep/other.json
index f6887b234b0e..5fe5ca778e9f 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/other.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/other.json
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
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json b/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
index e88c0802e679..accd263cfbfd 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
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
2.49.0.472.ge94155a9ec-goog

