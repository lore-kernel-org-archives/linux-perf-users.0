Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA5C18FDBE
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Mar 2025 00:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742947807; cv=none; b=XvdTh0wYYrjcMzRNkzV2zeRjCwO52hlWPhAJ92IDzn4YDn5ZPM6AIGZpdEC0DKgWuG3H7j0+tKcgwfRQKVkyviolcYJWR2IHPMbaEVKzFA9yr4ZiI/8ngE3HDJYcHmQYnrk+dHOsiA8WsafxoTNFaBOiItemvkvr1bmAgxFJxDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742947807; c=relaxed/simple;
	bh=9QtWxO8l2GpcAYbRMHA4inZL25MuZzaCf9TT8yzkl7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=dvRAsYnTzvLtoePUYClZjTRc744SHZ3iSGnRiYohu84Ulu9FFOt3GckKfpPj/ImRqUK546FagEtb6gr6V0g2YsxMADCqf8/hXEgaUibH9BF4XN6//drorT34FOYCH3hjFM0zgYxQ/uFQQ0Q3CH4VWu5BArftmnyaDuoOkX3wizo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VlaCkWvD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VlaCkWvD"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fec3e38c2dso16425817a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 17:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742947805; x=1743552605; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bjcCoWPLeFv7HToZ+VPWd4Z16z9IeZ5E4tfOnaC3rvg=;
        b=VlaCkWvDzEj6lrTpYUy8YCGJEEVYdqCU6eaxVTyQXMAD9tQweUUcyOp6ZkfoIHMCox
         xDS9cIyaQmd+jBJHqCbB2O32AdAPqbTRd2pXfe9dyhzQWabpu6KxiEhY27MUCMhs6z0H
         DbNIsgN+WaEGUks5JBC4yvX+/D/xrAuOdgfrpaD5bu3TpisferpLXxRwIykXAWwgxbim
         KUjpeTvORZdVmv3ZsA0AdSA/YmlJH/TR1v8tlm72K8MBaFpi+2JMADJNkm6Fc+f/hx6t
         ix8oQJrbhSGBRtKT0FYufgTOhc4GNskLnb+8Qkj7uU9Xi+UbOOxyqp6Tg2Yujdk/P0AP
         ByAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742947805; x=1743552605;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bjcCoWPLeFv7HToZ+VPWd4Z16z9IeZ5E4tfOnaC3rvg=;
        b=eO3GVBcjjNAXPrmyc7AKmTIOryJfIQRYAghodw0WnfkucFhh0xjIhE1u8ZOI82LIrA
         +VlLU79/7ApNdTrEDv5NcHjh2VvuzTAsAdxuxPvT3X8c26+/p8l6Kaqel0j/K+D1Bu9+
         yOpQbpDO/JxEPwIs0ZZgxq9wYK4v2qHkl1Zgg5Jh+gOCzJXmbFK0g6QNInCjszPrODXm
         d/PR03P5hAFjEN9O+XjHTbIDYNC9LYI7HRhDPM/NA2mCOs14WHKB8zT23J3gCgnjMj5k
         8/55Sdj410bZZBfmgcNfoJ0Hgq4KZw6TURWouIkvl1yKrJUNVB6LK4wIf1V3mVXAExor
         8M/g==
X-Forwarded-Encrypted: i=1; AJvYcCXMAT1e42hrinws9OFM+p0Su/cz16GQ9nM5bTqMCG0d44Q1KONXX2y0JjivrE+fnjmCkApH+1zAr9NB8cy2SRfk@vger.kernel.org
X-Gm-Message-State: AOJu0YwOPNCMCia6hvG2dy57DLXiHTGWzvuJLzbfWAUfX+gx6rc4iPJb
	Wp4sJH/H9ZR7hFuf/HckpICOfQZz3sW/s5+xFrvBPOd+S9OHK7wxZ3w807qrRgf4HNqSX6bZJNh
	VAG+d8w==
X-Google-Smtp-Source: AGHT+IGPKt0S0YUd4fGnI98Ax+NYjlpCe5sPqtoR7BrjF4gq5QfezF8MF2KvT76zmSRO5elsl+UjMSzged09
X-Received: from pgac3.prod.google.com ([2002:a05:6a02:2943:b0:af9:775:2e8b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:688:b0:1f5:58b9:6d9b
 with SMTP id adf61e73a8af0-1fe42f2c91dmr31426051637.12.1742947804799; Tue, 25
 Mar 2025 17:10:04 -0700 (PDT)
Date: Tue, 25 Mar 2025 17:04:31 -0700
In-Reply-To: <20250326000434.83325-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250326000434.83325-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326000434.83325-34-irogers@google.com>
Subject: [PATCH v3 33/35] perf vendor events: Update westmereep-dp events
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

