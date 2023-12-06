Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpI5S7KZ"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA69B18D
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 10:35:37 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d3911218b3so559877b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 10:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701887737; x=1702492537; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B2/YElcFb78YmCVTTtjEUczkDmkglR+f6tXmRIs88Pc=;
        b=lpI5S7KZve6rDwSg9JJuwFXZi3JkCxVRCkaFNLUCQlGo9HFSQI1at6FI526w7WbY3R
         ntP5ih+FAqVRNL3o1ZV4A4EZuppjCU4bp1IlDErRnOAzhbMIGuoy0YXCOZdynmztQ1qa
         a6ieddnGtqPT1gMMhhXHYPjAClSqmu8JWSriqMFYv1eIg5IpJw20+JYVpT9X3EDymwOm
         DGHuk+767I4cQmjyMCYRvZiF/qavx5EDSL4PgxNuMsXXVbCQH01iyMY77N+GtbT/P3BW
         Wk+BHlZFv11jl9hVMkNRX3KdW6cY/xmHhZF0Iwmm/GmYEERduyErsKcEWb+XrQa653P2
         Yo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701887737; x=1702492537;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B2/YElcFb78YmCVTTtjEUczkDmkglR+f6tXmRIs88Pc=;
        b=SqcCrAq6mWco7nMUj6ex+MziPV1hbrb9sz0aACpqPAt/RoOAFT+R1SPfViY4/4GIpY
         0vX9GEZT7UJP9irgESD5wtTZzgbnYHyKMy4nzOvpLZ75dsuIVGvPlEr8PMXFB2/Rja/9
         Eluz3yByWO6TguJDAOwMrfZOC0/1cvfD57o5fx+c74urQ5JEs77XjnhmXc6QeBaf6AH8
         h1MU7eUcdHI0gtcZqS2Fwo1WIEAwFuxeSP82kTMTdtLY8wXT2nqdXKLDJf5BpDetJ9SV
         aN5bb5Nx8Ctre4Zpu8vvvqTvEUDVxDwaZYbmeRqLeEnwaep0sObiKnvi0gQBQ2OJmbS2
         Qytw==
X-Gm-Message-State: AOJu0Yzhkp2byu/aZiuT5O0uBTXnsIVK+p4JG+WdE0yqemEdlBbv6QsC
	WL9G5ksZm/V5o80gCBao6HEsEA9epTf/
X-Google-Smtp-Source: AGHT+IFZUxuND2td+Pez2UzFtuP3tourqWfU0yR+9nJpAFBDlD4Cc/EBL7A37Z5pgGaT7kEPMo9vpuaFfND5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fe7d:8e90:65a9:5cbe])
 (user=irogers job=sendgmr) by 2002:a81:af04:0:b0:5d8:95b:af70 with SMTP id
 n4-20020a81af04000000b005d8095baf70mr21731ywh.4.1701887737162; Wed, 06 Dec
 2023 10:35:37 -0800 (PST)
Date: Wed,  6 Dec 2023 10:35:33 -0800
Message-Id: <20231206183533.972028-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1] perf stat: Exit perf stat if parse groups fails
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Metrics were added by a callback but commit a4b8cfcabb1d ("perf stat:
Delay metric parsing") postponed this to allow optimizations based on
the CPU configuration. In doing so it stopped errors in metric parsing
from causing perf stat termination. This change adds the termination
for bad metric names back in.

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Closes: https://lore.kernel.org/lkml/ZXByT1K6enTh2EHT@kernel.org/
Fixes: a4b8cfcabb1d ("perf stat: Delay metric parsing")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d8e5d6f7a87a..d22228eddccb 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2695,15 +2695,19 @@ int cmd_stat(int argc, const char **argv)
 	 */
 	if (metrics) {
 		const char *pmu = parse_events_option_args.pmu_filter ?: "all";
+		int ret = metricgroup__parse_groups(evsel_list, pmu, metrics,
+						stat_config.metric_no_group,
+						stat_config.metric_no_merge,
+						stat_config.metric_no_threshold,
+						stat_config.user_requested_cpu_list,
+						stat_config.system_wide,
+						&stat_config.metric_events);
 
-		metricgroup__parse_groups(evsel_list, pmu, metrics,
-					stat_config.metric_no_group,
-					stat_config.metric_no_merge,
-					stat_config.metric_no_threshold,
-					stat_config.user_requested_cpu_list,
-					stat_config.system_wide,
-					&stat_config.metric_events);
 		zfree(&metrics);
+		if (ret) {
+			status = ret;
+			goto out;
+		}
 	}
 
 	if (add_default_attributes())
-- 
2.43.0.rc2.451.g8631bc7472-goog

