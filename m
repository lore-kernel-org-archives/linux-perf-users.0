Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6731EF0AC
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Mar 2025 06:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742625327; cv=none; b=e7WDa26oiHH4Mm16VsMaYOENDfGyI6nbW45e2z4hPEgiz+AYypgEokH8SmGaRgwCxDS5pvTQwdpCGdDE84IgYNZ706lQHN4u/p5Wy0yK1ME+20wkdMFrCDJWZCCXwRdCQh1sXVRSeSIcQnl7dJR7Men2YHdeJrSzrhb3Grdffug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742625327; c=relaxed/simple;
	bh=Zy0jRafJxRLJGt4ZHFy+/ySVLU1klhzlJJANwxxpiE0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gwGeJvH5ZlkNSLXK2UHp/Nr5V+zsoRX0lx/eTqJYfZ+uDEqX/jm5bzJckzGTfM+PRT6mjzrRuhWKIZXwgu9nBlnL3Ne7Lyj5GGc6qydgOpl9XboNF8JDk+6nKVqppTxnESRqTDfgyhYRpAPL5NVuFbdxKfzSAGl2lsHbZOoHyno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K7aLPiRu; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K7aLPiRu"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e63533f0a65so3286057276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Mar 2025 23:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742625322; x=1743230122; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kWTSLGRSQc6JnxhtpbR0m8qTat7TUVK+43G8X5ABzRg=;
        b=K7aLPiRuMuUhzssm/055SjpA5uiYdUJtr2U5C3wZxDf61G/e6npE/59NdHki9f7QvG
         q5sUoyFJVU8L/GSDMnoxLMOX0oikKZj63Dfpm44Ql8ga3O5U1T/vyYkljLzSoyTOQb9q
         jajPtlcnYg1km6oI+Llz3m/4ur1MMmlpJ840D7XdQIPFuYOg+KlQKSgB4TjaVjfXrf2O
         l8RC/6gG0QMNTU3bKVpKp/qzAmZTGWMfxgpIgTb2rCSUc1l8prP++K9NVqS21faK9Tf1
         /HcK5Gn0r/5nIdBYAH8cPtd74x64tGnODzlmaPBWONJDx+sQw7LibR8KmF7QeMROyXeV
         HYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742625322; x=1743230122;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kWTSLGRSQc6JnxhtpbR0m8qTat7TUVK+43G8X5ABzRg=;
        b=a3sZn08WJpZg6hdkgD4PpRy/2V9PH2d7eQXhpT0PiJgM3w0n1o9NKOk2Vl4m/GJ6fF
         2AoSvrrcmILid/ep0ImETGWdZvjCSBIKeUIP0OMFoyoHnmvMSQvhb5jcIconbgz3sI+j
         inILpN8yDGjg17MvaXnFpLrY6zrMQCvnylEDZuDTv8wQ4IYOyY0kxh/qdEMJ2hOqGg3a
         0FgwHWY+silAqUOt0Ek8dOgOhjFTKlta2Dz3HvRMomD2C/zgD3NQqifTy3VttapZodsB
         TJedrreSM9gnNejSuoxqsCWKvzUt5o3LKXlUo6rDXwSQXpDzCJplyQp1hrqNflfqizoP
         K/Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUqvOHAa1VdAIhXFZ6O2g+7Gw+FF96AKzDYVOPV0nr2+4yJp3dP0SCQ6S2+RRh4WDPfpgTaxkrcmZmEmDrOWcA2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3hB/6kdprMo9E4vGszXyiEsQE2wScnM31gxO8M26lHwCUYP0P
	BcwGnW4p1PE/6++XHwXFu/oLYOvcWR2vUWpjLnA1gnx2zOCPWPOtv5dDtwgBYPlig5Mjx/cam30
	u5WTmUQ==
X-Google-Smtp-Source: AGHT+IGSbm8DZTNj2tJOV8rbZgMWyrPfl+jo6jeiPT8Kbr8VSUps3O4D1Bq9dlrB4SH+pQQcwHWPvmEz+w+2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c16d:a1c1:1823:1d0e])
 (user=irogers job=sendgmr) by 2002:a25:9108:0:b0:e60:90e0:fa83 with SMTP id
 3f1490d57ef6-e66a31a5fb5mr11276276.1.1742625322493; Fri, 21 Mar 2025 23:35:22
 -0700 (PDT)
Date: Fri, 21 Mar 2025 23:33:52 -0700
In-Reply-To: <20250322063403.364981-1-irogers@google.com>
Message-Id: <20250322063403.364981-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250322063403.364981-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v1 24/35] perf vendor events: Update nehalemex events
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

