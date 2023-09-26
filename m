Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E3D7F
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 03:10:40 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5B6B4
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Sep 2023 20:10:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f8134eb83so58021817b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Sep 2023 20:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695697838; x=1696302638; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qgojMLtTPS7ALj3bYas//tFq8eo4J8/6f82zm1IrmKo=;
        b=YaRZ+521cZY+Hg12Te953aAn4ryWTswlg2S/qICNnNHLAY6SYlo/VmiLGdv8dt5xcS
         PNq5PSFl49UNUsFEUUtB8trZYZBNCyD9LtFuLD3SpaUpODyfpLnUs51rUy3BJYpNgt0I
         BXYry7TNZDsll8VeQlKrF3Ch/cjhPM4HgAKJf+Ez0f8nUKeOkpRSBAFaOPwUnUjGRFvP
         nNShgxa59uNFO2mLQCMM63TxWnIY3Aho5GEQcRvyzWAd4+ePAD1Tg9QLlPLH3IU/uZUP
         q/cywqhwRevUhaSMvVZOHI0OOQ1bv12HMbCN6KQxZDroBaLAUpht2sH8VziGiWz2PaHr
         sVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695697838; x=1696302638;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qgojMLtTPS7ALj3bYas//tFq8eo4J8/6f82zm1IrmKo=;
        b=ZH4UgN5wVJzrFzoErpbFENl7E9uKupgnTNc1MrlhoRq5D82157Rn1PanP2h1QOgQi9
         I85PW2YP4IOy3BlA9GCqT1pXX4MGkCTy6Z65DFUGXL4QmeEZek5AmDL1gkdNdjIHGqRE
         PLQkb4y0gGb5Ce0kKoKGO6x9lv2ZjvAgH+llIQ3gs+Z+3FivJECKWGYn0Jo8BQt2HHAA
         7fQOmUvhQMSbrNbVP7YVsRORoLDOWUiG+1HYcyEK1VKy6lubPr1unQDIjBg1fPpX/ABO
         hg1lFpZOPtIfh4BD2xdTxf1AV3fswKEwh1EnTNTWWenFCpAH0Htm5IjkvnoRwqj3sNFk
         4NQA==
X-Gm-Message-State: AOJu0YzckmJp2+8l1cQTW6JKgEkvhEr95aflROgLWnWD6k4RmpuOn6XN
	0J1sYMo8O49yvNhXHj1HtvaMzIKTD6xl
X-Google-Smtp-Source: AGHT+IHxZckfVhFdCEU9eZntTCWfkRDlN6iE5MYOyucP3Lj0GJr7OMGaCQ9kes65z2V5oznPcfvM37kKJJGG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:12aa:898c:dbdf:d8b6])
 (user=irogers job=sendgmr) by 2002:a81:b148:0:b0:59b:f3a2:cd79 with SMTP id
 p69-20020a81b148000000b0059bf3a2cd79mr110510ywh.8.1695697837883; Mon, 25 Sep
 2023 20:10:37 -0700 (PDT)
Date: Mon, 25 Sep 2023 20:10:34 -0700
Message-Id: <20230926031034.1201145-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1] perf vendor events intel: Fix broadwellde
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
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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

