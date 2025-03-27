Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E861FBE8B
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 22:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114295; cv=none; b=UlKbg/RANw6D9ykyl/CZlhmbvTO/6mRlV8+g2S/YCwzBd4LW8+TeBt+txzFtrcv7lib8bRZI1WMXe4KzUv9u6bY/G1zkbHySAOtW/rEDoUnx2CBxMQyq36De/dY1m6qJ5PGRFZ5eMqhM1734VQNACPKQ8J7KtCo2C2nRQPyphYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114295; c=relaxed/simple;
	bh=A9swew5sEkfqImlzOyxaOp5UaSlXTXcPjhn/IFm5au4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Sqm8WV02lqatJ8w4HRae8iqpfcj/K86qo+8ulJU5pX0MehfJ4sPy94C+3PFCg1MWsK0MsfMIf/O+l+5Tkfxbq+P0n3CCE1uOW4oeWYZUCGBxHa6+hazQbczxbmPuW80p8ufdDh+Ysww3LSzJdIYZntjuHFhCyE2HzkIX5zc7WLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HEP28/C8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HEP28/C8"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-224364f2492so26447375ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 15:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743114290; x=1743719090; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B9PeRUEXMecnZbPpuWEaRw8SWk1eFbJD5uYJN5nO9W4=;
        b=HEP28/C8Sf1L55Qf8ujWVoHEcwJ2ASZ6LcsSpnUQyesUqMK8nB1oslMTfrg6Dot//X
         z4SmpmR0KSqwI2ZTqjPSbaU79bVR0GHeCIuF9n+xbE04ykqr+1jWoXMoSnM/YQlFo13p
         SaA+Uw+m/C7QZUfdfhgSpD6rnJtkupz5qPzRnrOups7YKzwyaEOtd8AM1XibSZmI15VD
         8KNeFKQATdD+LZfZCqtoBWYKpXIhDW8Rt5LQ7h1U+MendxgPVd5Rt3nHkh5+IalpM9Dm
         tEDdoOhbwSm4zK6pS2a7XoSCNArL+0GcvBb6rE+4Xh5GNo3nhrxLTYhDnGDih9kVMkfP
         YOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743114290; x=1743719090;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9PeRUEXMecnZbPpuWEaRw8SWk1eFbJD5uYJN5nO9W4=;
        b=gElT7n4nC4jOIE4G83EyAJbVzUVHzL86XeApm26W55KMwuWxSL+KhYt/88Lxsfk1t3
         8wRTrxClgVlPXPP+9OrNTkyh42APlveW/RUPSMyXMR0NqY+OURywOEZJZHuQWOa/0RJb
         a0wSew7BZU3Xnmr6I40ZDvGB1OWkgGVYox1o9rifOiggpY3q4oLykZ4vXDRzOVersQ4s
         B07MiLwXFLIRwECfpebLg1eSSKunTICXC86FUsV71yVSE2a+sMEySOkVm/ToiNFc7L4p
         mSaapBZ16bZCtOByzu7MAQ3o1GrFJTX0CbGZP9c9i1gcnR0FdV1C4B8h14bYrv6WnMdh
         yI+g==
X-Forwarded-Encrypted: i=1; AJvYcCWqNnjSOMwODL5ILpZBK+7nf50CygIlp8PyAa2Mbq4fkaZRSJIkOrmLrthaYsolAfOe97BK9S8R84DtnQjtkqz0@vger.kernel.org
X-Gm-Message-State: AOJu0YzB8YRlSl1c4D5nDob19BU/3HMdcZPzijbRh0gybbTQhqh+WjZM
	b8tNdpwLgTqHRWFTA8qnSRyfgx9gBA10HGpu6Kjjv1UJW7CznExcjbv7Jt95prVJ/VekDCJKUIM
	MuAf5PQ==
X-Google-Smtp-Source: AGHT+IENEOgU3IbieV2oba2DsBzu9CJnBqhdETJP70GZgghFDT/ii+dFCzSlz6gOVlbQz1aA+ohaadSH94HO
X-Received: from plnx10.prod.google.com ([2002:a17:902:820a:b0:223:f487:afc6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e74d:b0:215:9bc2:42ec
 with SMTP id d9443c01a7336-228049593d4mr62276505ad.47.1743114289679; Thu, 27
 Mar 2025 15:24:49 -0700 (PDT)
Date: Thu, 27 Mar 2025 15:23:30 -0700
In-Reply-To: <20250327222331.117701-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250327222331.117701-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250327222331.117701-36-irogers@google.com>
Subject: [PATCH v4 35/35] perf vendor events: Update westmereep-dp events
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
 .../pmu-events/arch/x86/westmereex/cache.json | 32 +++++++++++++++
 .../pmu-events/arch/x86/westmereex/other.json | 40 -------------------
 .../arch/x86/westmereex/virtual-memory.json   |  8 ++++
 3 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/westmereex/cache.json b/tools/perf/pmu-events/arch/x86/westmereex/cache.json
index 9f922370ee8b..2a677d10f688 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/cache.json
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
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/other.json b/tools/perf/pmu-events/arch/x86/westmereex/other.json
index bcf5bcf637c0..c0cf8bae8074 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/other.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/other.json
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
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json b/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
index 0c3501e6e5a3..1800c6ecbf80 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
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
2.49.0.472.ge94155a9ec-goog

