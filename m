Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409D01EB5EB
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Mar 2025 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184280; cv=none; b=rDJWuKdavL+jz6e+1DngUN/zudMI3Un42VDlAadG4Qb7uckJnyGXNrmpQ3lJpwh82MqCpDSkNoicE+8SwXL8JVFVsJFBYSqSLW2Oj9GUPL0GlCKSSjHctgxC2VB/N/f4jxxYgGjVjHhYZZ4Ko2Y5GdyFOD7gHCVYoYCcBll3z3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184280; c=relaxed/simple;
	bh=jhC27Zaa9rTrkKMgldvX9P8aqnSagvdFSdc7U7Jyn3M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SXrd6L+qRW2I8BdSTdUJ+CBTP8Jfkbwlh6EJTTUL6eX5LKLErddtL4KPmSwdeLAlI8n2exXixFy93D/xaVdtxVtzE4YGIa8tBVfboNkN9tnP2yb8e5WOnyEioRkidF3YM6apkWdsG1vSITTmsnY0OcZMI9w5z35UDGnlEkQ6Tgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZY1VfFj/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZY1VfFj/"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff7f9a0b9bso3816274a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Mar 2025 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743184272; x=1743789072; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTzW5K68zOFl8tHWsLxW3KBGNqm+tt/wZjBTGwX9wNE=;
        b=ZY1VfFj/zMYq5qW3C2+lRc6PMrKcqhUrb2Fy/RvAU1WJJldTDMzYALK3dLnmIcKDKO
         0txvXUhCVraxwn31VrYvYUWulF9r+lLC3tjkpZ5jnxuxC7aBqObl6fJzMj3j9z/lN96Y
         xJySjOWjMQz6ninDPEtPkbm91F1tMArOfxsPlC5jG/RkRuaCd9YYwudPfgItLrDnWXFo
         NLyakcsOqo2Yzo0rcKfvxZo40oRUm39pg5H9DZDdHQKs+nMXsg9A+M9VzjThh/yBRxOY
         F9DSvNtb+o1T+vCjYA5dZGQ4xUY2S4y0/igSB9nIwqzCaIBuuN55tRcb+wUPouj76D0F
         Jokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743184272; x=1743789072;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTzW5K68zOFl8tHWsLxW3KBGNqm+tt/wZjBTGwX9wNE=;
        b=pzylDitkNecB7z9vnlsl2N+qSwm2ZPTPaVl039LCuBbc7GHve53bxio32gUYnKCAPP
         jipY8x3qcyAPO/wFGMFfTNpwy/D9NehS72TDopx9byS0tSMGnZJgosribd+aoCZNQUoj
         Wiop1cWHA2SjtNeHU4FvrNPxhfIXQRIChgaOVY0Mv5KLV+iw4UU0gZHXG/G2OmeTnWzN
         g3hzaw1PWU7xaToQbjBhPEiOCY8ddemZ2OLo/6eQCjsoUUaU9GqCIUVxT2QjkoNrbW7g
         469y3UHIj7B/YghJtAZ9KGOF0291koZ9x9rzmK3NKYgbAyRTGgHRewnHkpWpCOl586dL
         1vXw==
X-Forwarded-Encrypted: i=1; AJvYcCWg62QR1FuD3ginaeYLtuINR83dWaa6FyOryy5iD08p0wuG20NjjwxvDqyu8Dp9T8NrKj3Y1+P3oj/KpBj9IZOs@vger.kernel.org
X-Gm-Message-State: AOJu0YzTq+AdoaQW7ivj6Okk78H5gMUVQUsWzSDu3IhUyQ6nDsOPjq3q
	ubhIuq+/hX/8u7DHYfYuv4lU38q2d9QQdGkI4PXo3mxIp+bqiSg2yn20piF9MKFI1qCz1fYAGK4
	KHHOHTA==
X-Google-Smtp-Source: AGHT+IEpoqDsLNfFDG2B0+s19DfJD6eoaqnHAmvuMcI3TQLKixPYl42RVNsjOwUOk6XsLEAPT4Fm5kkcciSp
X-Received: from pjbso14.prod.google.com ([2002:a17:90b:1f8e:b0:2ff:84e6:b2bd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5244:b0:305:2d68:8d91
 with SMTP id 98e67ed59e1d1-30532165d91mr217042a91.28.1743184272369; Fri, 28
 Mar 2025 10:51:12 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:49:54 -0700
In-Reply-To: <20250328175006.43110-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250328175006.43110-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250328175006.43110-24-irogers@google.com>
Subject: [PATCH v5 23/35] perf vendor events: Update nehalemep events
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

