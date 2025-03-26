Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A995199FAF
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Mar 2025 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742947819; cv=none; b=tCV5quwg3hiu5vAaNeFY5QgTd1EJ5tB4ioQphY4UzT0iNTGiiDhFSpHwg+d9E7gDrSVPt7mRBM3s8FuUqXamjMB+ZOa/IeopZfhv1yiLDZzCnXj/kIDarrAIjp5qTjsGValBkdajhIWK6FdGiJAon3uGOp0qrcfsrK11RwD1uTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742947819; c=relaxed/simple;
	bh=9yS94I0V+aj5EaLixu70v/BvSVLiAUj4x7/o+VoVa7U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ex/ohtilZV3lWogW51kjxSncEVZY0BipJmmYe6BuuQEAgZL0XCKV4GLyoclp4SfKXWCJ3FtUANmUkWslLaf+unJPbp21BTWpgUFG5y89mh8VGRriLbvFREdp5QzeGS6Crt7sf4CsZpznVEq6Gr8IH8MupZFfDmSoJylPYl5a3n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RqoGBz+E; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqoGBz+E"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff53a4754aso16909809a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 17:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742947817; x=1743552617; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RPugHL8eCvwfstte7zHSdBSJ9ey/olpTRBhxpg/Uv8M=;
        b=RqoGBz+E7ckHDTH86lALFdudhtnuDiQKfyXLIdLxSQgUrVRd5EjDRQv2ABmhbm3KWZ
         2byMdaZNgdELWQCmNoBBTdmGmKnQHHsKw+ztD6ffnGJPSPqnpDnvcKLgrk4JPt/c+ipd
         5KpjcNb+c50w0l8YetKPEgcPU2+aIFeM3UTKXwGN2XRJcXLpVAs1Wv8rG77CA8DmHJ/n
         Ye3eP/6jp9ktbZObU+FqKxk9wvG+SDfuDUYOg7EAYTAnm1Q8/Eqc92ODN0bnCbQOdYHU
         xW3HtYw4BuTmyYIqHSG0hgMjtptvm5PudF4wSJ7M+LrlM7vYNHY39sMTNHZlhMtW7KFu
         NqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742947817; x=1743552617;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPugHL8eCvwfstte7zHSdBSJ9ey/olpTRBhxpg/Uv8M=;
        b=T44n/y/gSdRtl2DlsyxugYe3byuIH9pU51GPyRY3IghuVx3XWIkZftaUMfCGPfXfZT
         OtDfmwRknmUosZSvJ/2goAu2ujQAVycRG9DcTLYPHis16PSpT8fgXdT3Xr88QoCpl/3Y
         DKZk84/oOUR7QcJuBgoCJ+IRBfoko2iGCcnLk725zcQlxkGSYb1GuNPd9+b2f+g1e30W
         TRx490dPM27x/cjdlD0TgOOqawsg69B9HFkVDpj1V96Do2TEro3X0j/2dBOzqsHmqxjc
         i8OGVDRboPvNFMWFaAcUlYhXT990cbpO5xaHZFMwa9p+BtbLo/uCZAUHf61wI2mDxQZB
         HcxA==
X-Forwarded-Encrypted: i=1; AJvYcCVv7EzAF8W/f+1y1l3FJUX0UBrKpTlcSlJ1LibIGcPpEFrvDEowpKD0H6xzxaLSWx7isuLPNl2puLBThVRnjoqJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzMoNvaEWPZTPGp5QzIGVQIlpym/6pCGX6JOXBmQoY1GGvwpdpq
	2xBi4BVeFNU20yRHmD6vAgK9GAilEvW+Omh1pSd5CIegqfC9zXwoMEjMTCkt3N8T8g4fQs7zWON
	fTouuFw==
X-Google-Smtp-Source: AGHT+IHB1Assd3GXiq7n7MR3LAdzwPPD57kW6fdNmjyVWfM8Ut/1geDGx/Lt8tX0rb7MoadYj0eZjOwOJvCr
X-Received: from pgjg11.prod.google.com ([2002:a63:dd4b:0:b0:af8:eb05:4022])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a0e:b0:1f5:9098:e448
 with SMTP id adf61e73a8af0-1fe42f2a0bemr23636329637.5.1742947816712; Tue, 25
 Mar 2025 17:10:16 -0700 (PDT)
Date: Tue, 25 Mar 2025 17:04:32 -0700
In-Reply-To: <20250326000434.83325-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250326000434.83325-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326000434.83325-35-irogers@google.com>
Subject: [PATCH v3 34/35] perf vendor events: Update westmereep-dp events
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

