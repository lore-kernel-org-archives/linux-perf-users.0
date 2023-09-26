Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27FE347D2
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 21:00:05 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D0E1BE4
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 14:00:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d865f1447a2so11990758276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 14:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695762003; x=1696366803; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQnaArfhDPSVH9QeRtaNpT5HTPg1FQF78B6YuJbQa7A=;
        b=gSkkc104VizNnjW7bbR2P4+uiT2fDribqeMwhcb17tAyJHqNJcNtGsFAW927g3pk+L
         9ZfzfFsYKigkH1yWUKhaN0gF19jaP8IT+Dp5gYOz20p2lhVWE+2pDcb11Ex4Zzhsgqou
         U4/v6WglRt/MaGTxzdOuJAno+xeJXqjNAbb/8RLm6N7+RqcHAOZEqy3ChfaoSrZj4K/Y
         YhK5kNvxuoHD5ScXyyHaJKtmScaYf5IwzQhPSwpeb5HIlirB8NAUwQJjk5P9PiY9Hacf
         3U9cKfXim1PmQuWq5Z5PCReFMS4kz241GRSoqV6VtQkYahXnBAh6U5MoPkqTndzyeOBQ
         HZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695762003; x=1696366803;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQnaArfhDPSVH9QeRtaNpT5HTPg1FQF78B6YuJbQa7A=;
        b=CQMoKVsb5Rjt/kttku9YvqjhuJ9Y+q24bZPYraJs/bv5Qx5Q/v3bIfMNonLQd58Y4l
         J0u+yY4FpGKg4Dl+jP54GeR4kBsf29+kt51i/SKuuICN60eUFlaRa82m/9xRFphsP1eA
         bXP0QlFRH2iQTIAtWTfMiO3o6bQy6huKLTjknolJZ9nmedOMkAi0pJ3g4CDa61gcX+B0
         /FgDCtZIux6scXnWVnCktv/960Lp9R5itSXeGn9FiRf1WY9jc/j16lT+FTtmgZ4cQh20
         yOaV4fJY8LclifdO3dGNXTyMiCXybeqDkLAFDVmus0HKIzLlxc8Tx0kJ8cyYCjbPvjWF
         HsBA==
X-Gm-Message-State: AOJu0Yx8ysTA75E/7FdtzIhvwLEOUW7/2GBtKUmsObQiJyGGuXrF48wM
	sckHH4m3tsz78NH8xX7XZEmYrVxrh+iN
X-Google-Smtp-Source: AGHT+IGDMGsj7bvYX+HaDo/Jk4a72DZDjqyms95T200s2QqHgm5zxFUMwPbDl8e3FtXNmIEOLGtgWQj55zOq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8ff0:2e1:80b2:e4a])
 (user=irogers job=sendgmr) by 2002:a5b:c83:0:b0:d7f:2cb6:7d8a with SMTP id
 i3-20020a5b0c83000000b00d7f2cb67d8amr366ybq.11.1695762003614; Tue, 26 Sep
 2023 14:00:03 -0700 (PDT)
Date: Tue, 26 Sep 2023 13:59:48 -0700
In-Reply-To: <20230926205948.1399594-1-irogers@google.com>
Message-Id: <20230926205948.1399594-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230926205948.1399594-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v2 3/3] perf vendor events intel: Add tigerlake two metrics
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
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add tma_info_system_socket_clks and uncore_freq metrics.

The associated converter script fix is in:
https://github.com/intel/perfmon/pull/112

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/tigerlake/tgl-metrics.json   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json b/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
index fab084e1bc69..820d85c2933b 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
@@ -62,6 +62,12 @@
         "MetricName": "C9_Pkg_Residency",
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
@@ -1026,6 +1032,12 @@
         "MetricGroup": "SMT",
         "MetricName": "tma_info_system_smt_2t_utilization"
     },
+    {
+        "BriefDescription": "Socket actual clocks when any core is active on that socket",
+        "MetricExpr": "UNC_CLOCK.SOCKET",
+        "MetricGroup": "SoC",
+        "MetricName": "tma_info_system_socket_clks"
+    },
     {
         "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricExpr": "tma_info_thread_clks / CPU_CLK_UNHALTED.REF_TSC",
-- 
2.42.0.515.g380fc7ccd1-goog

