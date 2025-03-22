Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662151F4C9D
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Mar 2025 06:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742625354; cv=none; b=f19AYl24Yy0wYdOHMzRxV9e/zbKuIAYmXCIrLHeGb4lY6jNqSdS/dzrEKptBv+ikRR1L88sTxMucPdwDxfPtl8lyYv1KpKvc+DmrE77SCeIdlyca2rtYNUdEI+K/gdTeYXMH2yMxAu31K+YR4it1+fT3pWdAU8TCsWajG/besz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742625354; c=relaxed/simple;
	bh=9yS94I0V+aj5EaLixu70v/BvSVLiAUj4x7/o+VoVa7U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fLeCH+mzIp8ZigPmTGjkXNkGHFrdgyAqlDAIqByUePAiZnrank+og9xTuOKP1liqkF6H/rxDGnum0PbxIOEw5F6zV6xxSwFfhG/SMJMZ8AQ1JW5P+7BJ9/D4qcfK91KbAYBbE8ZwTNMX+7coQpLJ/YWKLu0Zmv+mXxxBBvc69SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cx4tmjNG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cx4tmjNG"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e582bfcada6so4392936276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Mar 2025 23:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742625350; x=1743230150; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RPugHL8eCvwfstte7zHSdBSJ9ey/olpTRBhxpg/Uv8M=;
        b=Cx4tmjNGe7FemSucVIa1xrTGlqFkyVtflBIetllrtZxPCD5I7+vr2VK01sL4f3jO66
         bie5y2rtZCKFq9HI/PAOX8flv/Wh3vktQxgyp4hsbCMVctMEd/mCiY1BU4pAGSCS9qfR
         Is/fe1lcpqaYHRJNA4OIFJedyr8PdpD9ZXMnOCwA+hMXlWrXIfWw8UykFIo6GVZ9LXTB
         t8JpHJvgPOURt9bNnAxld9463kGL4VpghplUlASY4IcGDeGQ80cw5Ip3yaS0gzX1dlUC
         PzWU8f01oAxhW6HZ+Mu+eFn4SqHF2pI1S5bKSH9Z6Ls0wkmNuiWU3+4U/W/Z/5gj7uYM
         zznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742625350; x=1743230150;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPugHL8eCvwfstte7zHSdBSJ9ey/olpTRBhxpg/Uv8M=;
        b=ACtz56eIdUVriZ7YY20z0o3Hnc5jSIcJv1P5tpg9x4wmFcZTzx1I5yXYWZ3G5ZouM7
         r6VW8bYdOpCqmrGpziClzZ1MY4nf6lyiBZpFR60zwhP+fK52NNGXYPqYDSUIYhru85XH
         qBNTgT2hDcF/0MmkzftJ0qlpfgweA5wckvURgrwoeI6Q6SEF7d+rtlzHkhx1539kGyXT
         cQYkkWxNedfiWkIA3cMPmxSufAbWXQt7QxnpalTFJ673jJWtTlTCSIJ6jByEIm451i19
         eQNaoCUR/nQpW/w54R9DjcFR53AkJ23Yi4HTPzb8OLraS0DJCkoMe5xIaTiRW695Kq6N
         9zyg==
X-Forwarded-Encrypted: i=1; AJvYcCXU1rtF1RW8/4q28WkIsnl9byelix/NCK9oWWxvQPkJPhK/KC3RAyQNIjnU9EgnBRB23GfzlunKntboyz4L6B31@vger.kernel.org
X-Gm-Message-State: AOJu0YxFYRu6YpLmA7G316GwPl/JU6oQ/JS9WFYIgt/O1qsrQjnSXORF
	jSSs1wJ22O9Kf0q24uHpsk74v4h06/22xQ8BGeSgxgJNNlHXVa0gH78LklAVQa23TfLZWfc/bRa
	6jSTXeg==
X-Google-Smtp-Source: AGHT+IGAHXS3tyy6YtMd/WX/AAFoyykh3syurpSv8CtuFOXyC5ySlA7LHh7KfvrF+hNofP3vnoB97NOTY24o
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c16d:a1c1:1823:1d0e])
 (user=irogers job=sendgmr) by 2002:a25:a290:0:b0:e5b:3241:79f7 with SMTP id
 3f1490d57ef6-e66a50f3111mr5957276.3.1742625350196; Fri, 21 Mar 2025 23:35:50
 -0700 (PDT)
Date: Fri, 21 Mar 2025 23:34:02 -0700
In-Reply-To: <20250322063403.364981-1-irogers@google.com>
Message-Id: <20250322063403.364981-35-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250322063403.364981-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v1 34/35] perf vendor events: Update westmereep-dp events
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

