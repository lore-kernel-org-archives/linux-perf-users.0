Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66B2BE6C
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Oct 2023 00:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DQ4tt0E1"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C8110D2
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 17:32:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7cf717bacso2943467b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 17:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698280355; x=1698885155; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pfdWwTvyDNmkXJFvpwodNNnDTxsqw7dXofnRZLFRzuI=;
        b=DQ4tt0E1p6X+hUfZjfP4Ze4sYKszXe9Yl9uNI3yoTyLf7Lw7HU0eWZnwsKWDbexfI4
         RyiKvMpo0fui7IWFa58d09TTI/7ppAPGvrFg/B8DUzP3jBU6HhFI6Wv8W0Nqtl6S6IGv
         EoQjxekmXkegoeDn5+xKSYAlQe1Lwya0cn+NpmQd0h2Qkf5w+GGjvJ/2b2oq4pbVx3Yi
         hnIpZp3OfU0FtpWpk91GC6uDNBHCUucUTTu0yGyVaBP0GpdTRHiKf5w68W+HqQgCh0aP
         odxsK7vILWz25EGxPWnvOqPpOX78hAcLv3WjwsACyeC5LvJRagzHwUEdXBJbkgf97Y/o
         q9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698280355; x=1698885155;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfdWwTvyDNmkXJFvpwodNNnDTxsqw7dXofnRZLFRzuI=;
        b=frPvs848PB7J1kC8tLOtYG72xb3ZaFAHomFOtZFFZSMMdax3kdw5aHiDaMjK+Gp0Do
         q+EQlGH+y/6VOqKxGgNXvtK3l55pBT5rjY5lHsEiNzWrQilEuMq9e6BAIFqyEnOc0RM1
         7U+9a41zwT3PHn88U7FbItLTNF+Uo9W6/pCEPhQQkBrmgt2CvnrYHdOJ3MoZWnCPAZ3r
         JH54YL0r0hxn4f+hCN2fv+R1N1D9w98Cc54tRr4w854JpLHPJcKU/ybSOFaroKvBWFJI
         mjkhJToJ6z0VJ7YcC+5+z1VF3tXrFvZqnoRaeFR6tWr+k44xJ4cpU9IiAqLuDPwx8nJL
         BuqA==
X-Gm-Message-State: AOJu0YyxWG4any3N9H0ImoY+q1iDk2SKeJEBvIXTI2ml1qQQxiD6jOXR
	0DlbQUL/Ouj1PIN3IMHNtsiJ0ARjhvyB
X-Google-Smtp-Source: AGHT+IGj1sb54Wr0jVCSUPr2uD28COpn/QjZaVe0JG0Ns95HLoTZaNJs6O9EwxCG51xZhQm0SMnhu2BGvIJ7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:19cd:8b4f:c0f5:e803])
 (user=irogers job=sendgmr) by 2002:a05:6902:105:b0:da0:3da9:ce08 with SMTP id
 o5-20020a056902010500b00da03da9ce08mr137176ybh.10.1698280354791; Wed, 25 Oct
 2023 17:32:34 -0700 (PDT)
Date: Wed, 25 Oct 2023 17:31:49 -0700
In-Reply-To: <20231026003149.3287633-1-irogers@google.com>
Message-Id: <20231026003149.3287633-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231026003149.3287633-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v1 9/9] perf vendor events intel: Update tsx_cycles_per_elision
 metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Zhengjun Xing <zhengjun.xing@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

Update tsx_cycles_per_elision as per:
https://github.com/intel/perfmon/pull/116

Prefer the el-start event rather than cycles-t for detecting whether
the metric will work as HLE may be disabled. Remove the metric from
sapphirerapids that has no el-start event.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json | 2 +-
 tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json    | 2 +-
 tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json   | 2 +-
 tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json | 2 +-
 .../pmu-events/arch/x86/sapphirerapids/spr-metrics.json    | 7 -------
 tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json    | 2 +-
 tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json   | 2 +-
 tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json  | 2 +-
 8 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index fbb111e40829..84c132af3dfa 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -1837,7 +1837,7 @@
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(el\\-start) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
diff --git a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
index a6eed0d9a26d..b43a6c6d8b7f 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
@@ -1525,7 +1525,7 @@
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(el\\-start) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
index 7082ad5ba961..e98602c66707 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
@@ -1821,7 +1821,7 @@
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(el\\-start) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
diff --git a/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json b/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json
index a0191c8b708d..0c880e415669 100644
--- a/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json
@@ -1551,7 +1551,7 @@
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(el\\-start) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
index 222212abd811..06c6d67cb76b 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
@@ -1944,13 +1944,6 @@
         "MetricName": "tsx_aborted_cycles",
         "ScaleUnit": "100%"
     },
-    {
-        "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
-        "MetricGroup": "transaction",
-        "MetricName": "tsx_cycles_per_elision",
-        "ScaleUnit": "1cycles / elision"
-    },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of transactions.",
         "MetricExpr": "(cycles\\-t / tx\\-start if has_event(cycles\\-t) else 0)",
diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
index 2795a404bb58..faa615c57893 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
@@ -1473,7 +1473,7 @@
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(el\\-start) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index fa4209809c57..4a8f8eeb7525 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -1781,7 +1781,7 @@
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(el\\-start) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json b/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
index fab084e1bc69..31738726185e 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
@@ -1539,7 +1539,7 @@
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(el\\-start) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
-- 
2.42.0.758.gaed0368e0e-goog

