Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148CF1E833B
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114273; cv=none; b=JnJLevUBDCWU2MON367UQSa1RatGKYyIXihvRrnT8AvyulybpgIw83zBsp0q9u20FCuCeG/X/hxyhOMgMMV/c2JelAZxWKshjOngGdJcipXCU0dA/MP6lC4keb+bvScKDEP+5IIfvuBDzIfRXVSkm58ZKxS3cWbAZ5FPtmfTSa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114273; c=relaxed/simple;
	bh=BsZ4beG/3MY0LIlMnfOtq+u6ug+ZXaSOs8YIhhZ38Cg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YwxAu4p1P3dTgnAtY8PBCT2h/UrDYxF75JW6kqKvwqgAE0hySp5AJ3xqIen5NA5kN+4R/9sCC9s2BhNhcy9aHmDhKse+hPHQyLP1Te8hMwlwhLdADf1OJvUSYcVyRXAdwde8dr/2uwa4tQ3w41resrm8do2YyGuodoFyGcagwuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uxCV7WBT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uxCV7WBT"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-227ed471999so24154325ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 15:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743114267; x=1743719067; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LtdlsqM6blzGroFn64X29nm7pFzYH4kvfvsnMdFHGUE=;
        b=uxCV7WBTESXGyEtoYMREHNPTGWWIS4F3j8nfwvmrUgUrASnfNoIaUGIXpUNqw6ph3o
         b4dm4/Qe3JmcztMVeLWCdwAIdNfWEzmVym8lSxaHwywxWiGALL4cBQIBW8dk5Nx1JKk3
         kmdZ7XWZEnfIoRcJXuhK9McFLjqRw+OJyeeruk4WYh4rHGyX9/ouRZ4HDioHIqlkg5hM
         JIoP/y2mKqG2wRhqJbUPL64+cTQfoW99y7WTy2dylV2jLqYTTGiQdzczhIAhAaEZjpI6
         33RHDe+JRNSaJbtFDtpYHw8NrutdPTFglUgAj+wDRHz3jYJlZaGxzAlPdOF34VobHE2E
         pMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743114267; x=1743719067;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LtdlsqM6blzGroFn64X29nm7pFzYH4kvfvsnMdFHGUE=;
        b=KCsIrH6DuaUKPPguZ9HrPdY/nkJhHhdjVzIG8s5mXYkaIhFQFXoYp7MaL8faQt9sPz
         9Hi8ScoGWlxgXQ0MvqAgupIZrU3FwtGSqxYoS6NOMgTjZyCj3WCN+VY/Nu9WudeuNqMy
         DAFN39/2wbqZcmZkPVkPbs+/cL3k2Dd3/+kFvwnuo1R/6KOFPkIP50s1VjVJoqvSUamM
         QlQB4lEuL3eB5xuzDn/Tw48rnM19Fs4J7rcQDUVRvl7Wopygjdarp7btU3pexScfoNQj
         F1MzkcPj2MlbuccXLr1MJ3JFyaC5QEIi39i4azoViDIDa3CPI2E4lEDcFn0wgdlkVEih
         TrCA==
X-Forwarded-Encrypted: i=1; AJvYcCUSRviZn/MosjtHMElIuVNngckovlTvhe4pKcHGXDCA5VT133w5qzuz1kxbHrp+qGo3GvcOkUF+4gZ3wtswciB+@vger.kernel.org
X-Gm-Message-State: AOJu0YxKruca3gTgT/DmClMUXlTs8H1OlQvbcNxflH4GE1MLb3Du/pHQ
	bL4+CpxdB/2VsxL8Z2/5Qn7MTJLLF6LsLEr0y2B28ax3SP5OPOEVKzbc4tei3b/+E0es/RIJPMS
	nywVc1A==
X-Google-Smtp-Source: AGHT+IETcJiUn3A/4xUzAhkVVO/EWpFOAKvAMHkhyEtVipvJc6YK61SLppyUlPMQmlehbJEl6uPJeJJonHqx
X-Received: from pfbgo11.prod.google.com ([2002:a05:6a00:3b0b:b0:736:4313:e6bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:11c7:b0:224:1c41:a4c0
 with SMTP id d9443c01a7336-2280481ceafmr71003245ad.9.1743114267296; Thu, 27
 Mar 2025 15:24:27 -0700 (PDT)
Date: Thu, 27 Mar 2025 15:23:19 -0700
In-Reply-To: <20250327222331.117701-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250327222331.117701-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250327222331.117701-25-irogers@google.com>
Subject: [PATCH v4 24/35] perf vendor events: Update nehalemex events
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
2.49.0.472.ge94155a9ec-goog

