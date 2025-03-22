Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AB61F463E
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Mar 2025 06:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742625352; cv=none; b=KKRaBKw1mRBZqBFFwsrg/qoriDgR4dwU5mPlkwYoLSqsPndGF3gBlflglbkEF6KMZ8LQUS7UO3qfZUsEsrUPuNpsf5wGBn45IDdnX+2swuWEncbRLnOXDNUdN/j3R98LeknvtlDV9s8JG/9LclVEgcel9bc6sLnGzYUH7UyBVvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742625352; c=relaxed/simple;
	bh=9QtWxO8l2GpcAYbRMHA4inZL25MuZzaCf9TT8yzkl7E=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=D5rLA5Vmcou5oC0edNcgDwUyqxwQ3rUqkCLhixTL/P496RpNy6jLKwi10DjCi5TKGLH2uTCb7gKong1XyuMZ8o3yVDVc/RfSjaq4f2Irfy/00fmMXq3kYnclSW2JLT1PeHMNG7eYCnCG4dJAR3R3aPlNVl7CoJW4PTXhMx3IP7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q+H5tnYo; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q+H5tnYo"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e6373b4cbcfso3551324276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Mar 2025 23:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742625348; x=1743230148; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bjcCoWPLeFv7HToZ+VPWd4Z16z9IeZ5E4tfOnaC3rvg=;
        b=Q+H5tnYoc5ggcLb6jz8i1PS1WaUh5ypJy1XLQEBwBBNtgZ/EDhi1fuAOuFwt4+AdTx
         9+c9gz0iQin+8wybQtknotC48wGzQABDKLrz/6Ago/1YIwSBHD7nf9sBGyc/Rv8c7OEN
         oRiEFKU593Re56lGXbnQyjFDEt2nfKpuz40sG4mb/Lo9i90jwkzOUk9urEkYljqbCich
         G0wqTFu5eo7cp/1JyljZUveP81C91X7LHbXUFUoEPwrJ+sWihSEp224K2y396smBkbiy
         hbKulqqOdIWEqP5N8iRilxwLmRiOU9kw/hGKcy/r12PUl8HtdFKVxVfDoLq5pU/id65W
         k77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742625348; x=1743230148;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bjcCoWPLeFv7HToZ+VPWd4Z16z9IeZ5E4tfOnaC3rvg=;
        b=SKClyl/fg/Y+rTkdgPIXcgprsEyhB2bsq7I3lYak2Rav1P2n1I/QBipvV59uH7umqj
         UcMp6VMdxKBZ21aFjpJQBkVIkmenxsLtMMKEyLA0cwPNkxGDmyLJdgTuq0tNgdDIXMTM
         zzAs4A+N4U+Y6KoxynkxxJiOcDPXiv03P2D8pS4AqJ5jVjUbQsqBD85kG1FscaQ55qFH
         s3/ZLT+Msz9ZnKa2VvaW05OfYlLtnTh8SO2tOepxcx7x55aR78QIgzqPi4dooTNjWafV
         cRxIKhA69Ho/Mw7i3C9Kq1L8nDcpPJ8ajBJTSYRz2f+rF6VkduuyDqHv1z0z0VyiQqlL
         xPHA==
X-Forwarded-Encrypted: i=1; AJvYcCUd+k64WofZWX0CxtURHwTWRlowV+wN/a3aWjYUf1ZNj1pT1/aZJz5o+Fq0EiIb341EKAEBfuN+TYK+ivQhxTrU@vger.kernel.org
X-Gm-Message-State: AOJu0Yyenb8mIXLEdsxVuSC0tHLfsKwiDHIam8W2kRhG7hvPC8zGcWTA
	JywcYzhS30gRt2176CSEItW8hFliBfga0P6eEpDWv3EaUOUumoBdDv/BBOfMBrDDqtd8jdKe50f
	Fv8je3g==
X-Google-Smtp-Source: AGHT+IHlal+F6Vq3p1BPn1wNdGsQ0Opjwsps2JaO4JwoeBUks1WR9j8kYqFa269SIbIlPXdlXWu6LE+81Kk/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c16d:a1c1:1823:1d0e])
 (user=irogers job=sendgmr) by 2002:a5b:80c:0:b0:e60:a204:30cd with SMTP id
 3f1490d57ef6-e66a4a80683mr6653276.0.1742625347764; Fri, 21 Mar 2025 23:35:47
 -0700 (PDT)
Date: Fri, 21 Mar 2025 23:34:01 -0700
In-Reply-To: <20250322063403.364981-1-irogers@google.com>
Message-Id: <20250322063403.364981-34-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250322063403.364981-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v1 33/35] perf vendor events: Update westmereep-dp events
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

