Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF0F1EB5EB
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 22:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114292; cv=none; b=Y1+gsKEu/M41T9HKOJnbV6FFPw2plsj3cdqYrVI2vMQzRk3jIEGQsD7Vf8h0hPbaHYTb/YgRjL8po/55YZOeztUROvhp+ZcNkVztkMT1rjVvuokm6l8EDZsmM6pb7XHBS6lFu99LwKFn6ZbcEbTlE8dwpKne7+zfIv7muX7fKok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114292; c=relaxed/simple;
	bh=rEKsyl5VeXsQYB6M9jGct7xgL9z+rZvIbO9f2wNkGrg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Ijp1Mw3OWpkbYKqZpWzV/h4RvrNnb4HCzcumzh6OyUJoALlu2qP6MUG7PWLi03HCFrcO2uGBlf5wUaarTg0UgSW4VzphWEzMzvpIsjCWCkOb8luH39nOBxwitfdGCFkTCTY+Oh+IvAEfRBEvkYDFSgVbqLpyhC5IMoYCfdVwqPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U1gClDRK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1gClDRK"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2240a960f9cso25762855ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 15:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743114285; x=1743719085; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nlkA6u2yJZ2VVf9mufqU92QMT0mRmr2z4j7mWj8ghPE=;
        b=U1gClDRKAS12n6q6joF5E0AahmBPEHPNsvizceShK+QUhV5wZ2IjLpoPbI0TLNajPG
         ccRX1bvRPa5JliLBI8ZDcNz9AcPibNPABOKYt+4BWFWWKyGLxTWuJOysSgfgD/oQApX7
         /EABXSrKLx9YZQIg/sPQ+TD55eYt4zmcd5w35IBKkCwhmWRKp7azYv9t0xW7iTRxGTlD
         fdc5LitVIPbx/0YC9Gbe647e7t2d2FZuA+O1sLxDS0qXbAzuxKdEHUM4XTcbgHl7TDtc
         TP1Kg9hpSFLLoC+g/OPFBBiBl1iKzMeBA2ghE2I2IYz1vPxUa51ARPdq2hhcLs50JAu+
         TSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743114285; x=1743719085;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlkA6u2yJZ2VVf9mufqU92QMT0mRmr2z4j7mWj8ghPE=;
        b=UOOHG4JFqZ6bDl8xc3OnAZDafCqbAJz1ZlI4ruF8YQRSP4tI1LyPECvl5YVRLQcB+t
         do8P+5ZQMvaj+Ya9+5jQAtM+q7wk11r7qho7ourLziChnnMiVfDZRnxwhoRhK9SGzOuk
         u9FK8+BnlOYAc6CTi1KatyifG5LYbSisadJiGGe3s7mMiCYi4ftGWFFsdyXtbga5a69W
         ZZrpQtZ4GmzBYDKuae31hOVWnzbeskp8peM+ze6XbhGqU9gcQ0Uv8bXARkKlWuZREQL7
         8AbZzlvVBbQfKW6TssAqdh1czniHQwfq9OFuk4kjUO3WpGq0Hya1JXxe4dI23m2zkHvs
         f5Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWG/WomS5lIGE6BZBqNOflUZj0YKD/nDK03GGG3eHhhJAlpnlHIrQxqAdGOUHjVBz5HB9NRvLVmSUDA8M40O9pb@vger.kernel.org
X-Gm-Message-State: AOJu0YzAaYwNuC9skd8NO+GYVNfWrGBcLXGNxu1caka1EgHxckUmlW+7
	rXedPMJf4PBrzqFr8OrcS0wlOj65naMDJQrFF0IEpxvfqKyofgsmDlIiw5PUP0WLT6DD0fV/uRL
	4Q2IjQg==
X-Google-Smtp-Source: AGHT+IEF4opHdQ9Hxc/L3dIlu/t5hGdGcMjfAr8Zk7owIyWx6hP8pRb7hQ6+NgLwhnNBu3HWyYaFkj2cXNWd
X-Received: from pgkn22.prod.google.com ([2002:a63:ee56:0:b0:af2:3541:76e2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748f:b0:1f5:7ba7:69d3
 with SMTP id adf61e73a8af0-1fea2ec32e9mr9618026637.15.1743114285492; Thu, 27
 Mar 2025 15:24:45 -0700 (PDT)
Date: Thu, 27 Mar 2025 15:23:28 -0700
In-Reply-To: <20250327222331.117701-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250327222331.117701-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250327222331.117701-34-irogers@google.com>
Subject: [PATCH v4 33/35] perf vendor events: Update westmereep-dp events
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
2.49.0.472.ge94155a9ec-goog

