Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j38Jd5Hb"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2921B2
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 14:36:10 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db53919e062so9723276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 14:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701297370; x=1701902170; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WXS7/e2VY4X2gQe3kEWDUpAXAmm4xsAO1n9z3bPt+MA=;
        b=j38Jd5HbasSPeHNKCfmy4mnlVxhAxOWxmBqpBdlqRWcQngjrlYGNIS8/H9NSFysi73
         6sc25+fADc0JDTW5gqYuGUF/3k8/OMNPxp0fvEvhjEGsX5Rkn/CGdQttKLVkKUHQRtfN
         3FQCi9bOGiGJMXfJdjp9pqIms/IITxcyIsJ09MXzuPl6yj4pLqrYj/qVEeOgN/KtkFnI
         siOL48+kIUPMMgFYIeXvkw74TqFi79oV7fav9Erm6Zy5betC9OEcjQ/g3+nzp7wgPP98
         8LVJx4397j7r1qtJeyPDM3J4pxiiaTn0QKdqgNOEE1Iw6eUQLaRz4bwGDtH099EuPxA9
         VJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701297370; x=1701902170;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXS7/e2VY4X2gQe3kEWDUpAXAmm4xsAO1n9z3bPt+MA=;
        b=gjdq9a9xQbNQtFp9KnVo+bH2kFZnKR9O3H8TYueFVAT1ty8BGe/TYqmDn8y6pu4gMQ
         IeebalAxdlEXExBhh8uEjMfHMILXZLk6MJ5P3pkg525CCGbyLAYtPuLOUnWYeTn4IEcY
         EQRIuLMee9yUgia5Ioj1EEUf198cv2+hLiPhghGqjpP/gQngRqbcw7E1i5G0QqKMiJH7
         7mYEnk0Y4TW3QoWf8fBIHdW1NEMyjKFE4Wu+USASGDom8B2Oc2sD/TuCVE7y+e9jYvKg
         7sT5LOqaWvKO0PS4GxroJfima5SHe84VJ/2pVSgIrWHEron2jX7cwrDRFYSNZsag2p6J
         SyFg==
X-Gm-Message-State: AOJu0Yx3XpC4vfgIFkSsB2I+qV1gql0sd7A61b9w7nzvBSouaZTh59Qb
	QWb27WtsO8Zgc3XGpfsJUGlWQdla9jAM
X-Google-Smtp-Source: AGHT+IGyIcR99e16Ql+7yHk9cIo1V6bGooAvuqVpsvfGfU0chUWlBlm5DOUyxAipjVYAsyWt9PiLLaEIu6yW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:70ed:81b4:2b6c:fbc0])
 (user=irogers job=sendgmr) by 2002:a25:24d8:0:b0:db5:2a4:c55b with SMTP id
 k207-20020a2524d8000000b00db502a4c55bmr189209ybk.2.1701297369900; Wed, 29 Nov
 2023 14:36:09 -0800 (PST)
Date: Wed, 29 Nov 2023 14:35:40 -0800
Message-Id: <20231129223540.2247030-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1] perf stat: Fix help message for --metric-no-threshold option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Copy-paste error led to help message for metric-no-threshold repeating
that of metric-no-merge.

Reported-by: Stephane Eranian <eranian@google.com>
Fixes: 1fd09e299bdd ("perf metric: Add --metric-no-threshold option")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a3af805a1d57..c77a3308d3fb 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1255,7 +1255,7 @@ static struct option stat_options[] = {
 	OPT_BOOLEAN(0, "metric-no-merge", &stat_config.metric_no_merge,
 		       "don't try to share events between metrics in a group"),
 	OPT_BOOLEAN(0, "metric-no-threshold", &stat_config.metric_no_threshold,
-		       "don't try to share events between metrics in a group  "),
+		       "disable adding events for the metric threshold calculation"),
 	OPT_BOOLEAN(0, "topdown", &topdown_run,
 			"measure top-down statistics"),
 	OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
-- 
2.43.0.rc1.413.gea7ed67945-goog

