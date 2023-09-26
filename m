Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1934347D2
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 21:00:03 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C691BDF
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 14:00:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81c02bf2beso14781857276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 14:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695762001; x=1696366801; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bPlBM3jJXh8NVH88UtLu8oL9H+fkXnh1TC9GtfvoblQ=;
        b=nynMp7SpE4Au+fyExLOHHa/JYZEAC05WnhxGmqJJeHneSzfPWc0y/7SByp6WjwzoPx
         Cwl1Hh4nif42xIOBFmCqdYw0XnccaBt9NY4EiJMogaslPfDGeXG9C8jL8l6HMc+ogeF7
         f+KXGdNU5PDqGPcIsjBn3V2SfFoYHGIctsVpJj+u3dgTWtL1pqEd5UTDCu0vod6l5Mnh
         1egs6LrWCYQvAualQI3Q8WN4OX7xTTsIdFuLO9MUoxsBEmtJfxih4LuCpZC98+ym/Fqh
         Sz2r4+hyhPVjglUqbSbVNhwW8wBj00la4tSfYGMCBISurxAW+qdggSYoAkSLsZuGFV5P
         gRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695762001; x=1696366801;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPlBM3jJXh8NVH88UtLu8oL9H+fkXnh1TC9GtfvoblQ=;
        b=nYGG8mOIR0HnJ+h82nMYtb2ZUohNEiMncZzzGrprgiEFZy7WlHO0qLTkFGEa/+iZjc
         dPZjH+cRJQAqqx3E/WPcRegu0qgWTz768+njOjMDRPC8ps+Ouwlqwm7yEhG0Xp7XpBgY
         hrOuTHMrIUeCww0BvrV1xPS/tx579Xpl+jWAAZASNhT765Ugdoc3XNOyn2FB3V415bbo
         DNgeK/B2+iCW5Qp5NoPi6yknKqOe5IXCdZoKKcEau+0O44cCpCq/nbJzEc3/8ba3VBmq
         B1i+GARM/k1rYi51LSHq5yXlaE1hgNrknwjkTJYRKZwOGimEbTYgIXMtXatIwFeiGoCn
         wj6w==
X-Gm-Message-State: AOJu0YyTRDJlCAvmluG+T43duFGPSugDclg+/qMs+HspWKmrbIHOlk4L
	9gQzodUWOk+Ridwa9eEnSIbpF9E+qCxQ
X-Google-Smtp-Source: AGHT+IG8cssxOjcO1yNg2FBC2jY+PbBtJIgqxfwRdWukqiHfGERqjP45UFvTZ+Cu2kHnzNJWqgAtGkFv25LR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8ff0:2e1:80b2:e4a])
 (user=irogers job=sendgmr) by 2002:a25:ce4c:0:b0:d07:e80c:412e with SMTP id
 x73-20020a25ce4c000000b00d07e80c412emr234ybe.12.1695762001426; Tue, 26 Sep
 2023 14:00:01 -0700 (PDT)
Date: Tue, 26 Sep 2023 13:59:47 -0700
In-Reply-To: <20230926205948.1399594-1-irogers@google.com>
Message-Id: <20230926205948.1399594-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230926205948.1399594-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v2 2/3] perf vendor events intel: Add broadwellde two metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add tma_info_system_socket_clks and uncore_freq metrics that require a
broadwellx style uncore event for UNC_CLOCK.

The associated converter script fix is in:
https://github.com/intel/perfmon/pull/112

Fixes: 7d124303d620 ("perf vendor events intel: Update broadwell variant events/metrics")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/broadwellde/bdwde-metrics.json          | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
index d0ef46c9bb61..e1f55fcfa0d0 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
@@ -48,6 +48,12 @@
         "MetricName": "C7_Pkg_Residency",
         "ScaleUnit": "100%"
     },
+    {
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "tma_info_system_socket_clks / #num_dies / duration_time / 1e9",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ"
+    },
     {
         "BriefDescription": "Percentage of cycles spent in System Management Interrupts.",
         "MetricExpr": "((msr@aperf@ - cycles) / msr@aperf@ if msr@smi@ > 0 else 0)",
@@ -690,6 +696,12 @@
         "MetricGroup": "SMT",
         "MetricName": "tma_info_system_smt_2t_utilization"
     },
+    {
+        "BriefDescription": "Socket actual clocks when any core is active on that socket",
+        "MetricExpr": "cbox_0@event\\=0x0@",
+        "MetricGroup": "SoC",
+        "MetricName": "tma_info_system_socket_clks"
+    },
     {
         "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricExpr": "tma_info_thread_clks / CPU_CLK_UNHALTED.REF_TSC",
-- 
2.42.0.515.g380fc7ccd1-goog

