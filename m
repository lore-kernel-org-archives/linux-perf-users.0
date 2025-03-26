Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8381433CB
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Mar 2025 00:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742947720; cv=none; b=cjLQWV2+zh88fNyLTGyTCDZJh08VJrTEcqDxw7wBue44GEvDqUg+DhzQIxWaY+cjpz9z16O+ujGVTavcRGkkKY+ikbBlauJX9yFL1z0WVBBkHu5t+WY+lXcoFQmoq5A1PWpp0EkU4xDIWD3EDnT02ZIihrJm72r6uqzMSRmGyk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742947720; c=relaxed/simple;
	bh=Zy0jRafJxRLJGt4ZHFy+/ySVLU1klhzlJJANwxxpiE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NpMIcIgK5BWuDkE0tC3nCNXxQIetm/K2LrO2dtZe/81mrC8FyQe5xbXglM+Uw0tTXaRlnup4jkTB8RZspltlzfNmtZbLm2mXinFUBhNbV962GaZhKYcIYeoe2ZhaWHzeMSe9GNxr+DVSd5DQ/cpQkrbdFxuboACSdj2CTWO0d74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aWmbI1/0; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aWmbI1/0"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2264e5b2b7cso93788455ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 17:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742947718; x=1743552518; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kWTSLGRSQc6JnxhtpbR0m8qTat7TUVK+43G8X5ABzRg=;
        b=aWmbI1/0IE1wfvQQ5unrKbb0v9yhs003nX1kfI47f8m7NXO++zbDfqCnNQYWfEGmPp
         lIuyjBb0yQG4luHl3i5T+l6yEERnZhQtlkyRKxL132MMOzfa1o2EnTWzJBSFi/tZFnK6
         OUumF7kq1xSsXexjYB4HsOvIdQmP273TLlnJs0hDpjIS0d50EY7OtFmG5eURGPEgsQ7a
         I5mPNM825JBfLMkUyjgVgTmHzyFwRr9mvsb5DazRLuMz8rCQ7tnDL0ruRjj8yIednLPq
         htgTzpjlaX+eC4eMGjWVA5eQSwh9gvW9jiCwBqOTM/sLGHYd5XrjN9SIk9pWfGqOmzEC
         j9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742947718; x=1743552518;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kWTSLGRSQc6JnxhtpbR0m8qTat7TUVK+43G8X5ABzRg=;
        b=NUevJRbH96gitAmLjTZPzYHKzpd0C8V5gt9v4PaWoNz0eXbYgG2aCdH3dtJPMNj489
         FOWi/urK1GlRz1b6+4Y6Qhm0hprIzL7DDhYgv1dxasC+eY3Y+by0bCQbNV2E0Gij1EqK
         RgXO7rwhWYy1B0YmV+fZhGp4eHtU45l7cPzEWlhgIErsvT39aWw7hcpZeRh+OemPEJ+u
         uaKg4cu1NrerR5rSYXSg+kU7DvFe6VaSMREvjL0HqG6vmWCOsfWMf+h/sJS3kFTEaSja
         fiA6XONfuEK8sqVMLrULo70FuGYL/WgovgySlD2hwV/+ONbKnDOUchAWAxMSq69AgAcC
         cIOA==
X-Forwarded-Encrypted: i=1; AJvYcCVoXLn4Fh05IprmO2pkiGly1JBUG5Z4FHB0dJcNCXCG4ZJ4oWzCoDf0mQJ6d+tpwToPnLXWafAsjCSL05cyW8Py@vger.kernel.org
X-Gm-Message-State: AOJu0YxlFEi66jf8j6wp6ZhBVZUieQ//A4kf4rMwEl7v1GYrSOhMKPsT
	CeFN8am0hcamPhz+IGZ8tIbiysYrZTrEzmuhktN1i0gRZxCQ3w5eIIG68oRxl1TWsukErm5PtH9
	MYK/SRg==
X-Google-Smtp-Source: AGHT+IHloYEajhMtWC8hG1puIlY5v+wg4/tY5K4aV5d1Aea9Uw6SEBzc2wmss5k2k7hZqE9FrWd4Z/8m0D2a
X-Received: from plpm4.prod.google.com ([2002:a17:903:3de4:b0:223:55e1:4789])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f642:b0:211:e812:3948
 with SMTP id d9443c01a7336-22780ba2e00mr289913145ad.0.1742947718236; Tue, 25
 Mar 2025 17:08:38 -0700 (PDT)
Date: Tue, 25 Mar 2025 17:04:22 -0700
In-Reply-To: <20250326000434.83325-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250326000434.83325-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326000434.83325-25-irogers@google.com>
Subject: [PATCH v3 24/35] perf vendor events: Update nehalemex events
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

