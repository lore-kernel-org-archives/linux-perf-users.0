Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8DA1F4194
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 22:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114294; cv=none; b=IuEP//EnFFW5TJaAAkoeKtQhdQNeQL+i6ie6o0yR6Aysoxyx2idoptYo5m5nWH+1pvgb6TZRvIjbJIHZgi8JzajpCXoQbU/7go9mP7OdsHw7X5om77A8j2OktuLaZvMj2PCRRPRVicngHPMHHkFmVk8OpoGfd1nEaRIDfrqFE7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114294; c=relaxed/simple;
	bh=Vb8Zw2G8yDaioPTnls3nU7UxwtuE80WVgK353Gkw6uQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=U9fHNhYN2w1E2lJQSQ4qmGbEL761BeH4RNvksNv7VdYvo0Nr13Z4wE2k/UmSC9PZZVkyvQxeciDIPRpaR8NZuASz6f+vjaYtpxr4IUQuFuWao/tYXPPVr4jbsYvnVpI4MqJ1b/jC8IVcCRW0WSF2e94BqtuzpdTke330nI4jJrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CAPuW1Js; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CAPuW1Js"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2254e0b4b85so25198535ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 15:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743114287; x=1743719087; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DD+qgAbA2jbLVZa6aUPEYkzjGKc51TnF+sfLKzMQeFc=;
        b=CAPuW1JskB3d6IBj2ZXYlpTdjK94LYqmchHmTQ4Bspav/awKifEvPO868ApkU4u889
         DgHCcXS3qc0BJH0KE5EKJ83OuCtLcV+D2byeZBrUxWU2KYbiuEEcjQJ/o3hZw5V3V5bi
         jHqYRlHSaQw915T/xZQotAl9YzRoNvl6DMbZgBajY/TXOCME9IzD3jORr2jDs/Re0CLx
         VhaWjarRi9lQmAF8D3eEiSAz0kUJ0ZyJDMeC7G6UTCiAclapgKig4HA5jSE9+hhszOHe
         UQh2LpTiDTUvJTe7aHgGlyKmSp6CEkYcV+plGKl0ZVv9Fv5XTPeMpYbX36v19+rkxINC
         DF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743114287; x=1743719087;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DD+qgAbA2jbLVZa6aUPEYkzjGKc51TnF+sfLKzMQeFc=;
        b=pr0DpeOmRkDKBJpJoqPMm/mKYRcl7hNLTN2xkk2iY2OP5GK0LX4VRLJBMZQAke9YCp
         P6/5uh5eF0xbQs4wTO6P5JE8qFGUqUKlWacmFon/v8saqRPd4i2zEayiIKeYNihDYI4/
         kgspWM4m/fIDDQ6xG+xvm4/GH1o+lauyYIaqENDZXJVdYsD0hRVCdLPxq0kiQtmCihDQ
         ZpOji9GdDY6DOT4J3PB3SP3s5FG+J2/C0KFA/PCRmQusp24eGPRNfCv/2p5XBVO95Yr6
         nH38lSyc1Bul2OCZJyuuVyv4wf0IV+K5BnXGAzxhIjqmwdyFEy6JbTzOrz4pcWT2Ozd8
         5j0g==
X-Forwarded-Encrypted: i=1; AJvYcCW6mpaRXTXgUInDWW068MFiDG87Z6YHOVuN8GS/viRika8pP67SKSD2Sv+ZVd1A3rbRRXa3GMUQLpGxNcze2JdD@vger.kernel.org
X-Gm-Message-State: AOJu0YwwNQUMzVVH3ayS21XKHQtP8rmttaTAaJoFdlI+e8Y8EMZIG956
	W7etVLCZn2EN2bV6K01zwTT7EP2iBnBHdVBc/A2B75w6ZHC84dyCV4P3V4VWidBtZ4PBKa0qXb4
	HgIxbyQ==
X-Google-Smtp-Source: AGHT+IHuxE7aXI9zklTF2dsGNNOyQdhT7bzLM5pyZGWDdL6YccflfMpnwz+zbzl9xiQoqCdpn2xV0Pf2inHA
X-Received: from plhl11.prod.google.com ([2002:a17:903:120b:b0:224:179d:4b74])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d485:b0:223:fb95:b019
 with SMTP id d9443c01a7336-22921d4fc97mr6994695ad.24.1743114287487; Thu, 27
 Mar 2025 15:24:47 -0700 (PDT)
Date: Thu, 27 Mar 2025 15:23:29 -0700
In-Reply-To: <20250327222331.117701-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250327222331.117701-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250327222331.117701-35-irogers@google.com>
Subject: [PATCH v4 34/35] perf vendor events: Update westmereep-dp events
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

