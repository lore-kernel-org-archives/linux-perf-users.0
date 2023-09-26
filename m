Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E235823D7
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 21:00:01 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE20F1BD6
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 13:59:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d86dac81f8fso8180497276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 13:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695761999; x=1696366799; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qgojMLtTPS7ALj3bYas//tFq8eo4J8/6f82zm1IrmKo=;
        b=w2Ft1LXAEmSLtC9q/HcLLlEk76TP801HJSIg3VEL3ncr98RNDUSNqCAXcOBcO6X4tI
         npSopTtiUAjNoIpCqSJySjDJgTjSXiAed4tM/2fxZClUbaRtzU+jj83GtGMxfi5NQD/B
         nMfjX2KjTH/FqCfssGStKhx2ON1a8h/DhSJJL4Pfel4W4QdY9DZE1KPYkaVxLZxv3Img
         Dpoyk2d38CYWak/iWz5zn4I+OPhdCxBIC69uUckjeof3dZvZTMRmEIA87MoySlRx+HMF
         5xHfGA22vpLsSbrWF6hxX6+73ONZGYgqaAvwuCbgNwE3dhrDCzo6hmbZAUJny3IdY6tu
         6tMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695761999; x=1696366799;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qgojMLtTPS7ALj3bYas//tFq8eo4J8/6f82zm1IrmKo=;
        b=UWJIm1Yrj/iBo+5K2LsBbvwmomCPh/SKA/gg5uWTzFS2cTKUe0+sVvqn/Im+3x/Jit
         car96uOZhtNxQcQV9kYfPrlX7r/9KS6kldfMK+tX7jnuE3X5VvHcc3D2hRd3oHssnAxl
         QiswBAx4LNR9GeKQvOCgr3ezxDbQG+IhSFB8GKEoYqZ7odTJsF2xYMIBll/salYmte04
         5g/hrR+NB18s33ggHRVaat2mvZGo2LAZJmAKGSCX/+OmafZnw6q7fVvVf5a08kleGyNK
         ao9jJPrJSyexxSNOtI+jjX2jUBhCEMDp8F0csTVvDGH7hEyUv+15jXEEDWrPBFJmQDKC
         JtDg==
X-Gm-Message-State: AOJu0YxN6S8CsdAGyDnKUCAJFjVU4LzPgT25EQcEE/rWTwyiVZKu1QNV
	DI2QdPiCmSkz5NH5Wrxlf85EgNFjprX1
X-Google-Smtp-Source: AGHT+IFZch+e7xyynHkKeoQ60ImjQAp+3ISkdHv20tIxWwLK1OAFPY5v8V2D4S6j74yS0I3sfetA/k16SO/x
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8ff0:2e1:80b2:e4a])
 (user=irogers job=sendgmr) by 2002:a25:b0c:0:b0:d89:4382:6d14 with SMTP id
 12-20020a250b0c000000b00d8943826d14mr413ybl.6.1695761999020; Tue, 26 Sep 2023
 13:59:59 -0700 (PDT)
Date: Tue, 26 Sep 2023 13:59:46 -0700
Message-Id: <20230926205948.1399594-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v2 1/3] perf vendor events intel: Fix broadwellde
 tma_info_system_dram_bw_use metric
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Broadwell-de has a consumer core and server uncore. The uncore_arb PMU
isn't present and the broadwellx style cbox PMU should be used
instead. Fix the tma_info_system_dram_bw_use metric to use the server
metric rather than client.

The associated converter script fix is in:
https://github.com/intel/perfmon/pull/111

Fixes: 7d124303d620 ("perf vendor events intel: Update broadwell variant events/metrics")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
index 8fc62b8f667d..d0ef46c9bb61 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
@@ -652,7 +652,7 @@
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
-        "MetricExpr": "64 * (arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@) / 1e6 / duration_time / 1e3",
+        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e9 / duration_time",
         "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
         "MetricName": "tma_info_system_dram_bw_use",
         "PublicDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]. Related metrics: tma_fb_full, tma_mem_bandwidth, tma_sq_full"
-- 
2.42.0.515.g380fc7ccd1-goog

