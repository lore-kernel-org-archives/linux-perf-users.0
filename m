Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q92XS/kE"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839D5107
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 10:23:38 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db7d201be93so2520330276.2
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Dec 2023 10:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701714217; x=1702319017; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X7oIwN0gwgnh0JH2uoSPjyFXY7LBES97cup/kWuAMDc=;
        b=q92XS/kE26MVTRpPzE2bIiAyjv9qbVKDQsWy1X7HPBmXk5UD1My1tKNPadBkxZX291
         j5CRjW4DGyTjtALsasg6vgp+lUaRbhiYArI4+d9G5zJcBCiz2RPfVsUSW7sjfxpNZQkc
         iYMBWAewjLxEVkZb8UmH6SWJE0KXOurqWE9oac+BB5KlwQcuLKIllzO+CByr7kWyh2j/
         ZZoWLB0wwnGOAmgGEhud/yW+H/QXNlm1TTXnUcpOZ4H9NUQhpeyFMcXrZdmym6Ck8XIm
         syVam1m3pwm9Wdxlqd2hKY/kfpNH2H7R4HIi2Ik7jjlPgrGzG24BXJfMIjWUpRgnpKWa
         HxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701714217; x=1702319017;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X7oIwN0gwgnh0JH2uoSPjyFXY7LBES97cup/kWuAMDc=;
        b=tgNMGSVt1prGTwQiMW211HSIsGYXp02wTGb4BnZW0hmGquPxEl7gDvoUC//5dFCIkA
         gVNdIDY6KevKk+f4LRWWjYdKA0q2h7KoGkUcX+yoMJmwT6p7yLBitaMjL6E/BDN3Jy9y
         uLHFxTOh8K1ZsA1HQB/++JiZLzck1YQ29iQ8z96NVtyX7IeDwMpPDPtiMsB8kVFhaDDI
         0DYVgCY0iM5cK/LG+ofp8wjcwWAVaYvxxdAFLcwFOkBGQHqPvxxvoZjTPfzeSe+uGS0Y
         /tn5/yvS2+2n8r/ajmbg2HucWGRlx2ZEqx12aEhsb6iM28aarF1/0Bm2UHXOOL2/EhbJ
         3Gyg==
X-Gm-Message-State: AOJu0YyUpriGcNmjl+siyn+IDAniZJBDXCHdqHde516ldOqD+RNwWYmN
	hXMR9BcxxDbNL0hJhCyBLZ9Eqbpz4LiA
X-Google-Smtp-Source: AGHT+IHOBK+GAxccPQiMkDdDXauTrztmqup3Xwe1oIP3fGM+SQUEpNnshkLn78GxvBotlA0CjlE9r9x7oN0t
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b241:d804:967e:c827])
 (user=irogers job=sendgmr) by 2002:a25:d4cc:0:b0:db9:772b:1020 with SMTP id
 m195-20020a25d4cc000000b00db9772b1020mr44975ybf.5.1701714217695; Mon, 04 Dec
 2023 10:23:37 -0800 (PST)
Date: Mon,  4 Dec 2023 10:23:30 -0800
In-Reply-To: <20231204182330.654255-1-irogers@google.com>
Message-Id: <20231204182330.654255-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231204182330.654255-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 2/2] perf vendor events arm64: Fix default AmpereOne metrics
From: Ian Rogers <irogers@google.com>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add default metric group name for TopdownL1 metrics.

Fixes: 59faeaf80d02 ("perf vendor events arm64: Fix for AmpereOne metrics")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
index e2848a9d4848..afcdad58ef89 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
@@ -231,6 +231,7 @@
         "MetricName": "slots_lost_misspeculation_fraction",
         "MetricExpr": "100 * ((OP_SPEC - OP_RETIRED) / (CPU_CYCLES * #slots))",
         "BriefDescription": "Fraction of slots lost due to misspeculation",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricGroup": "Default;TopdownL1",
         "ScaleUnit": "1percent of slots"
     },
@@ -238,6 +239,7 @@
         "MetricName": "retired_fraction",
         "MetricExpr": "100 * (OP_RETIRED / (CPU_CYCLES * #slots))",
         "BriefDescription": "Fraction of slots retiring, useful work",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricGroup": "Default;TopdownL1",
 	"ScaleUnit": "1percent of slots"
     },
-- 
2.43.0.rc2.451.g8631bc7472-goog

