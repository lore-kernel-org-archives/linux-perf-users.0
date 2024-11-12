Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1F92038B3
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427289; cv=none; b=p7h2QFObr6BcezPrsxzVYDxyWFjyn+7pk57/uUiVTOB6vZIfnbWAGDGpjGJtMsC5lucznT862AEHTnrHc8BQ06ZzMabG+v5EToRNVyY+CUjuLa4VycY35zRGC/P+9Q0i1zFtbBib+Cw2NH8RseNnLapLpRx3FBu64jzTM4wmbDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427289; c=relaxed/simple;
	bh=1rzp7Xl7P06k2CmvvFaVmBBb4PRTEjX38R5QLmMlCTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BQsLPphI9KV66zTbMu3Gsu25CDkE99cjCfkMCf8/TivnywCqgLuZSu+v04ADV5aaA8N/Unjg+V/biHxpOdQ3AYBbWn8uaOPEIyhfZO3dqRdvrPaSVYbsUZCjMKoBG0/a7RVqvZw15gZ94aHCTzFClx+YODp0uSokFVIxYMEbfV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SQcPztln; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SQcPztln"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb5111747cso51811221fa.2
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 08:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731427284; x=1732032084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISx4HBtk0wLWMcNI0N/GFnJvPZUjZ9eymzjpVwEnOrg=;
        b=SQcPztlnbSGOMkTrOcZ0d/HVkF0rrOVzVjmkdcQRAyqErhqfukMj0KyDH64JVw2gmB
         NZDLubopxO9Y7ecxgtga9BGSy5TajHHc2h+LUyxQ//MaeuP8C4wiM3QCP1McrEI3FIcb
         vleF1PFp5LFE+CT7ZjoH+ZD9Mkmn1kWrUn6llyP08DG6JwDlENtzxwJz8WPzFRX2I1QQ
         8pq8Z5m4FZd/ivtYw3bsX5Jeg0VDDBkxvH4Gd1Xv+i0hCOWKd4ZGwuECzrdcfD6cJaaC
         70bJCmjIheYLmkn0WljPSRvNbv6rbSFaT9qhEmcPka2KlvrGEL6puycATPAsEvTAUDcs
         oDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427284; x=1732032084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISx4HBtk0wLWMcNI0N/GFnJvPZUjZ9eymzjpVwEnOrg=;
        b=Ymg6YUTMzqbRTpRQOzz3NRBPiiAl7/k/LaSMfahXnFGUroBbd846v5ebp1EEp36oS5
         h9DfEqJW1VwJwHKsfbWozemduedyza2lmZsuur80Qi4prUZFG+wv7rmCBQvR5SZIkjgy
         dsl5LbXprfyFQIhGy4mxzzKD6dcLT03WLOtR4fM4pgcJ3u8W+iQ1GmA46t8ipFsj1Mu9
         3j3+okYcEo5Q/REGi5AUGhS8rpIoAWv/tMY1KLjeyBTGaazI0I+HTN/2sVOxpuF+90XH
         PxFRkUltA5tkZrIYPP4VnFgmLBJc0pN1R5zO4MS1x/C93eURnnioqAsaZ8Ax7e8UTA3W
         XNkQ==
X-Gm-Message-State: AOJu0Yx3rexQn8rGK8sx6Yyh7RidbjZ5MuTiL1gY6IIuf5X2yWzxoBeV
	KKgfD+S8svohV+xZBqZHTs5EPKeQDdCwyGuvEFYYrAPC2t9UfOfUZxLN2/VWWQv8SWmBE3vEnj3
	w9NM=
X-Google-Smtp-Source: AGHT+IHgpDbdyzkDT/BkZIl2yFqZeTww3F6522828HUJTjSk4nrZ91f4e8V+Rz4bFuQLgoFWQ6mAHg==
X-Received: by 2002:a05:651c:881:b0:2fb:628c:2580 with SMTP id 38308e7fff4ca-2ff201e6d03mr90939261fa.2.1731427283738;
        Tue, 12 Nov 2024 08:01:23 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb760fsm6148172a12.47.2024.11.12.08.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 08:01:23 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	tim.c.chen@linux.intel.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] perf stat: Remove empty new_line_metric function
Date: Tue, 12 Nov 2024 16:00:43 +0000
Message-Id: <20241112160048.951213-4-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112160048.951213-1-james.clark@linaro.org>
References: <20241112160048.951213-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Despite the name new_line_metric doesn't make a new line, it actually
does nothing. Change it to NULL to avoid confusion.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/stat-display.c | 13 ++++---------
 tools/perf/util/stat-shadow.c  |  5 +++--
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 0e16eecfbad8..aa74543ae298 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -673,11 +673,6 @@ static void print_metric_only_json(struct perf_stat_config *config __maybe_unuse
 	json_out(os, "\"%s\" : \"%s\"", unit, vals);
 }
 
-static void new_line_metric(struct perf_stat_config *config __maybe_unused,
-			    void *ctx __maybe_unused)
-{
-}
-
 static void print_metric_header(struct perf_stat_config *config,
 				void *ctx,
 				enum metric_threshold_classify thresh __maybe_unused,
@@ -839,16 +834,16 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 
 	if (config->csv_output) {
 		pm = config->metric_only ? print_metric_only_csv : print_metric_csv;
-		nl = config->metric_only ? new_line_metric : new_line_csv;
+		nl = config->metric_only ? NULL : new_line_csv;
 		pmh = print_metricgroup_header_csv;
 		os->nfields = 4 + (counter->cgrp ? 1 : 0);
 	} else if (config->json_output) {
 		pm = config->metric_only ? print_metric_only_json : print_metric_json;
-		nl = config->metric_only ? new_line_metric : new_line_json;
+		nl = config->metric_only ? NULL : new_line_json;
 		pmh = print_metricgroup_header_json;
 	} else {
 		pm = config->metric_only ? print_metric_only : print_metric_std;
-		nl = config->metric_only ? new_line_metric : new_line_std;
+		nl = config->metric_only ? NULL : new_line_std;
 		pmh = print_metricgroup_header_std;
 	}
 
@@ -1319,7 +1314,7 @@ static void print_metric_headers(struct perf_stat_config *config,
 	struct perf_stat_output_ctx out = {
 		.ctx = &os,
 		.print_metric = print_metric_header,
-		.new_line = new_line_metric,
+		.new_line = NULL,
 		.force_header = true,
 	};
 
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 47718610d5d8..fa8b2a1048ff 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -327,7 +327,8 @@ static void print_instructions(struct perf_stat_config *config,
 			     "insn per cycle", 0);
 	}
 	if (max_stalled && instructions) {
-		out->new_line(config, ctxp);
+		if (out->new_line)
+			out->new_line(config, ctxp);
 		print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, "%7.2f ",
 			     "stalled cycles per insn", max_stalled / instructions);
 	}
@@ -670,7 +671,7 @@ void *perf_stat__print_shadow_stats_metricgroup(struct perf_stat_config *config,
 			}
 		}
 
-		if ((*num)++ > 0)
+		if ((*num)++ > 0 && out->new_line)
 			out->new_line(config, ctxp);
 		generic_metric(config, mexp, evsel, aggr_idx, out);
 	}
-- 
2.34.1

