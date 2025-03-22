Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94151EEA3D
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Mar 2025 06:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742625324; cv=none; b=YQ42hoi90CgPmdpzNsTrlpHaB+v8O4ihRmTxYkAXYGEjKyMAby91Q3UJpsDfhiGYkLaZczdS/LWybNeTLL6mFz7QPKrT4gaVVbGEW0m24BN2M9MZ2Gdg8HvSs5PX5zg3CPCrOdXRv/SPfU7QC6ryTm+GGZl/O23PK5yupQ6UNcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742625324; c=relaxed/simple;
	bh=8ECLI9MH8G6GS+TQuT+0Q+DWep0ey0sdDAegVmCJBw4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fwe17ayE5GGNXltk+k6967A7cK9xQj0DuXcyLvtDIkA7eX4UuCI8y47ATE7D88ZACeNQ66ZbD3Y4jAet0nzZdivL0qRP6KlRUKBITPuPhrhAAtNhpTPkGAQbmymAsJdrOzy8DVnrp/MEwEeb6wzLTmh2HIpM4ofuaSkPQCpnoRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hL2ukoSA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hL2ukoSA"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fef68b65c7so39023627b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Mar 2025 23:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742625320; x=1743230120; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NTidQqUKCPDZIA1M8BUtNh4exn5q3fZouzrUCwjO3OM=;
        b=hL2ukoSAbFoh0T1H3pNTUBluThMNL43CyR6DNi9TcEYkcphKUkJqlF4DPUsgIkrbbK
         q0/cpLmM/dFFYllfP/W15vAZmGLiDYoetatrtDywvJvYl6bDlBXt0xxUwToK6h+/fRuz
         rCDADDEll/UhTPJXhUeQIyAXq0WjoOzriVWbyZvqfTXzSkvu3uvgRRzOE+9/J9MPPL0o
         Abt8uML9n+dVE3da/r5aGSFJXBmso3k3GQV/bOeCrtM50FyD6CCzFEF3CZC6XS2nSaAn
         tl6BKg/slsstEKcYKqnygiO+jbg3V5MGRY/0gGd22MEvTi4l5irOJlwPi1faCrxpT7yq
         DDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742625320; x=1743230120;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTidQqUKCPDZIA1M8BUtNh4exn5q3fZouzrUCwjO3OM=;
        b=SRvOBakLaImAmwJN/es1bw1V1byNLlseSZ2xSfLb9Qo8Rxsac6L/jNDGoa8cMb68oa
         ms+U4PY7D1jSkLdn0eLha0hM1VZnUKYHgXTSpDGR6HxJ14qa6sIJptkCxjK9bxCUBPDZ
         pZqMdDiPT5cawDNB0Wgm9DHvX4F8IEWyMrVS/Ygr0n17NLpmwXmfunKBkLAToyh+A7bh
         6aLPzHh9M7ZB8A8Chn1JgzUVv0LyAPGXsnMzzyGWnDKK7NsWPIMEL9KxJX6Of9tSRE1h
         7WLxSzPXB2b7/lABYsFB4L3iFJrU2CXs7LwXryK8qNl0D1WzxCsTPlXejsSdDA1whGNF
         5OqA==
X-Forwarded-Encrypted: i=1; AJvYcCU2Dx4Gh61q3dgUEkeLlLVE+Hdzq42MzFkWnXp1zaoswMBSfQYBDFdk5uuHm+i8E0LGKH3Ed1hqVzpA1MyW9kwO@vger.kernel.org
X-Gm-Message-State: AOJu0YyyKmA2kx3xJE3WObkQudAyUfI1K5uQKnHpGTUmbTphpbo9EyZr
	PU17U0d0J5m2wJRUPYLky/ic9gxhqVnBEGoRfat1e3kYA892YRdv8l176kZxdw+wFNseMdKtn+o
	422GXDw==
X-Google-Smtp-Source: AGHT+IHEsM8kxSNExm7drga3vJyZ45993Hm8XS45hdWCxlaPPb50fmcZUr1lIFkO77tC66DDN5nXw8NchStZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c16d:a1c1:1823:1d0e])
 (user=irogers job=sendgmr) by 2002:a05:690c:2f0e:b0:6ff:1fac:c4ec with SMTP
 id 00721157ae682-700bad55687mr298257b3.7.1742625320483; Fri, 21 Mar 2025
 23:35:20 -0700 (PDT)
Date: Fri, 21 Mar 2025 23:33:51 -0700
In-Reply-To: <20250322063403.364981-1-irogers@google.com>
Message-Id: <20250322063403.364981-24-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250322063403.364981-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v1 23/35] perf vendor events: Update nehalemep events
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
2.49.0.395.g12beb8f557-goog

