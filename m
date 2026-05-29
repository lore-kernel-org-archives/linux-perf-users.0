Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FFF38BF62
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 04:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780030407; cv=none; b=tWdumx5yJ7kiNn2Lfv9L+lGhLJRLqkX4WIsy+oTpUC8xcovIVpewTJoy4sWiVA1GSQvh5yQZznYyh2jSsWEUP2VwmSnW5ZxT5c0DvH+f59zhjAQqbp8aoiP9T8OMJdisSDbaK5tX91KFwKZWXpQp25+AvpJs9RhMnpw5rF5QM+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780030407; c=relaxed/simple;
	bh=bJcxWKPUaFnJbB0umqVBmetW2gaoBUs5LeJgvBscVWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FTiaDKSARBxEDqN0iv9oA+Ziv71THRfcVGyFL/s4p80yBzLNUZye2jvffBL7+eB+5pawVs4P0Pc+KtpYeCIDjJ2djdPC/GhHVXEEtwb+H+7Uyw19RS96oaVclKimF0FNqdEVb/5mEzcCBXokbl1gTxMrtYIYC6JTfh0D60PzG+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WBd/vQdB; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBd/vQdB"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc763c7256so282480835ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 21:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780030400; x=1780635200; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C+2KakjiGELsNFIT2DybF7feBoJgYLzVkzakl+teFEg=;
        b=WBd/vQdBxtYlK7HhXDMGBdr/wge1E0kIITEDLBOU17OwtFSby8A523ECGmepxDTVjH
         xE4aU1SzO/Q2r0gAYhMzxzY9CcbUMwnLBnAypXurALSSV94vaWpBBjokKrvhck7jXZHZ
         CyFUDbImq6yFWjNiB5D5OuTYs2fOn2rJZmAoEzQuAO8cREn1MZWs8oi+HQlJ0ui0R79M
         eYyieIuLScb6YY9jvbn3pSDbgxX6wWGvYXwpv8bMRr6EXuTa5q2fPjMMJy603zw7FnGL
         xfjhkO+xbPqjbTfoess5GlfU5eumVSXJFRsEkL0oq+g3efhW6m4DnaF/k7GT5BkSEVop
         ioXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780030400; x=1780635200;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+2KakjiGELsNFIT2DybF7feBoJgYLzVkzakl+teFEg=;
        b=QnwWrwg4pihUpvlPQ6Vw/C2sMYCsS6SoWE0Pu9nW1zTiagDV44yyAeaMWllmVHRqAQ
         yk8RsQUk15l0gZ5Fs4KD9Q/yeOD94zEpzJqtstJrM9/csvZa+j3ULEtZ3T1OfSmdYyFL
         eJQA+FaYCLy/bs7fjNF7MNoq3TcC3c65GqIZq7cxwUH4OsWXXbsWJK6Z5N9uFRfL2Qzw
         xD8QalFpAh2snLT6w/zVIU1a0hhvmK7Q1R2lN5VHbMmtP/idd7vbyL/D+hLl/ao4XwiA
         d3X7HjdcFMY9CcownnCC5sNYefXH7KDHhXt2mghp9JE1ouuBEFpnSqCs3N3vkWzSJuKe
         hnRg==
X-Forwarded-Encrypted: i=1; AFNElJ8Zsy7Ii1h87EP6wRU83IvJZLIv4CcxdIHmFeuhySC3UWxPDLbQnQ9qA0+D2o4zN0t3gC/Mw3OGU/Ia8LpH4GdY@vger.kernel.org
X-Gm-Message-State: AOJu0YzkkHf2eMo1Eh8moRvBFxlSy8P0Ndh2aTixyAPqxqJe1K4rXSlH
	NcJ1FU87d1lA2CBvySL8b2a7SP/HBq6oja4HCaCUpaCDIDSZLf3LF5Zu2bgBi93R4Je5dkqNScU
	sfT9VikclCg==
X-Received: from plht11.prod.google.com ([2002:a17:903:2f0b:b0:2bd:6cdd:fe0a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce0d:b0:2b2:4d36:7aa
 with SMTP id d9443c01a7336-2bf20bbd5c1mr16671385ad.35.1780030400307; Thu, 28
 May 2026 21:53:20 -0700 (PDT)
Date: Thu, 28 May 2026 21:51:53 -0700
In-Reply-To: <20260529045155.311805-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529045155.311805-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529045155.311805-12-irogers@google.com>
Subject: [PATCH v1 11/12] perf vendor events intel: Update sapphirerapids
 events from 1.36 to 1.39
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The updated events and metrics were published in:
https://github.com/intel/perfmon/commit/0718b785554ba9bb7f87ad2b838cf25bab5bfa9c
https://github.com/intel/perfmon/commit/42fe96774f8bda1d67c6ad7ef7f45b27fae7c696

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../arch/x86/sapphirerapids/cache.json        | 27 +++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 70ba1af93822..dbe1fe5a68f6 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -29,7 +29,7 @@ GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-(CC|D5),v1.05,pantherlake,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
-GenuineIntel-6-8F,v1.36,sapphirerapids,core
+GenuineIntel-6-8F,v1.39,sapphirerapids,core
 GenuineIntel-6-AF,v1.15,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
index 373b26c84448..4c096b5e6766 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
@@ -181,6 +181,15 @@
         "SampleAfterValue": "200003",
         "UMask": "0xff"
     },
+    {
+        "BriefDescription": "All requests that hit L2 cache [This event is alias to L2_RQSTS.HIT]",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HIT",
+        "PublicDescription": "Counts all requests that hit L2 cache. [This event is alias to L2_RQSTS.HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xdf"
+    },
     {
         "BriefDescription": "Read requests with true-miss in L2 cache. [This event is alias to L2_RQSTS.MISS]",
         "Counter": "0,1,2,3",
@@ -279,6 +288,15 @@
         "SampleAfterValue": "200003",
         "UMask": "0x21"
     },
+    {
+        "BriefDescription": "All requests that hit L2 cache [This event is alias to L2_REQUEST.HIT]",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.HIT",
+        "PublicDescription": "Counts all requests that hit L2 cache. [This event is alias to L2_REQUEST.HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xdf"
+    },
     {
         "BriefDescription": "L2_RQSTS.HWPF_MISS",
         "Counter": "0,1,2,3",
@@ -350,6 +368,15 @@
         "SampleAfterValue": "200003",
         "UMask": "0x40"
     },
+    {
+        "BriefDescription": "Cycles when L1D is locked",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x42",
+        "EventName": "LOCK_CYCLES.CACHE_LOCK_DURATION",
+        "PublicDescription": "This event counts the number of cycles when the L1D is locked. It is a superset of the 0x1 mask (BUS_LOCK_CLOCKS.BUS_LOCK_DURATION).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
     {
         "BriefDescription": "Core-originated cacheable requests that missed L3  (Except hardware prefetches to the L3)",
         "Counter": "0,1,2,3,4,5,6,7",
-- 
2.54.0.823.g6e5bcc1fc9-goog

