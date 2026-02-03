Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BC23793A2
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 22:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770159107; cv=none; b=XcaZUNKtFsuLeojf9GD4Tuy7K1q/1XC3NiOKgY121ZnIc7Q3JN3frs2cSLhlqTVWfwj0x1dIQb7QI8S+ST3YWJIAFVVN3V0ApaPNbcaTvO/Ku9fgqsCUGP0XRYwz3Qn5yl7zzNNxlg4YqPytOeJHMv24G/EHob8iiH50CzXNrXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770159107; c=relaxed/simple;
	bh=y3Mk9sAgkuN3mOITzM5MtblmDiqpA0EdmXDSE+EyzZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=K5LvYUVM0P0UxBboRTlUKgmGYznNbYvYjdroSWGLsxXKQK+EuitsDxkeJqUS6zNwR9NZiH0W3VZSbUZr2nQ8HSF8EDYZy4tcFQ7J/ll3GEXdybLksEFH+6XbVBCQc8nM59LUWrZU0j/FlJXDoXmjpHO28dZKL3UPpsUe6iCazSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ayvevPY+; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ayvevPY+"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-124a2d3d1b7so7646738c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 14:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770159105; x=1770763905; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zzsKRSqRCFvt6FoeMViytQ7VfwZPfcB23PzvAjYa0/g=;
        b=ayvevPY+tMIRfl/1yZkq+4CslQjsNa9mK2TDULJfMqhvyyIv98GnTVr84nNE6iHD4S
         lzjcvBMgK0cdV1+1rkhjX9GMTYKDisaTnW8V+jYZv283imyJS5i6sePRQhRtEBjBFpmI
         rDtkH1JyWPCJ3rLDHVNVawn9O7PX66FU1iQqWhpMN2Qfb/Xu3PhwrzHfzzMNpuawnKqP
         8b3R0oR16uuHbGGKop6YoUXiiyzKAMyslSgYIzXET1qxE8quliE6TO9KYVNnXiql8M66
         Q+S/F8TvXxsB4ZMcfo+Rq1G2Kp2MyNRt3hmbJv5FIYKLfsUG8jJl+gEfsRDTl4lGBpRk
         JvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770159105; x=1770763905;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zzsKRSqRCFvt6FoeMViytQ7VfwZPfcB23PzvAjYa0/g=;
        b=i8xfE9wIvwEw4BqHhdh+mivj7BIsB8RmtmhnSOz4Fbc7NJ1KQixQTrVjneWgF0BDsS
         NP3CUwIC6Tg5xGLoS7XG2D64dFzq1F9URNFkkCWw2bpCjHLhmaK9ZtvKcKG21r9xap4T
         HMC5YMykNdQn96hCWxp7LSe6KY2VnMgBaPJQbiPgbPomGmPqVdb0MS3W8g+QrxBM4RmK
         laeHFKNOlPglyEV2nUSQCZRJEjfjySj1e1wlGNhSqpg8PlvK68IziIZz1pfcyaAbKsJI
         lwokkCH2XhM/C06/D2ywDWNz0ue1QBzUHvONpopjHEaUWMxWITa6MsjvfhW3IWTmtuw4
         rPuw==
X-Forwarded-Encrypted: i=1; AJvYcCWIGUm/9EkS3gbndbgZ0wYj0MY4DTg9LVp0drv/63N6CPzeg9fDVime4NGTrDpyKZojvVbHA5kPOHgKSVLIsQ7V@vger.kernel.org
X-Gm-Message-State: AOJu0Yw88yG9j4MP34qmHt85pafDYuFeRJZST4NSmM8YncBCxNxSa/Qh
	jDYQOkZkmwYw2CiyVyrSIlzFOjyMkGGp8XKzqvZKj4t4b8hJ+ompblnsLLcKx8HByD/yvc3WEj2
	3ONzpqvKV4w==
X-Received: from dlbsn10.prod.google.com ([2002:a05:7022:b90a:b0:126:d3ab:7af6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6892:b0:11b:c1fb:89a
 with SMTP id a92af1059eb24-126f47cbf2dmr456724c88.32.1770159104993; Tue, 03
 Feb 2026 14:51:44 -0800 (PST)
Date: Tue,  3 Feb 2026 14:51:25 -0800
In-Reply-To: <20260203225129.4077140-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203225129.4077140-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203225129.4077140-3-irogers@google.com>
Subject: [PATCH v7 2/6] perf stat-shadow: In prepare_metric fix guard on
 reading NULL perf_stat_evsel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Andres Freund <andres@anarazel.de>
Content-Type: text/plain; charset="UTF-8"

The aggr value is setup to always be non-null creating a redundant
guard for reading from it. Switch to using the perf_stat_evsel (ps)
and narrow the scope of aggr so that it is known valid when used.

Reported-by: Andres Freund <andres@anarazel.de>
Closes: https://lore.kernel.org/linux-perf-users/cgja46br2smmznxs7kbeabs6zgv3b4olfqgh2fdp5mxk2yom4v@w6jjgov6hdi6/
Fixes: 3d65f6445fd9 ("perf stat-shadow: Read tool events directly")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 9c83f7d96caa..7a481b2960a5 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -57,7 +57,6 @@ static int prepare_metric(struct perf_stat_config *config,
 		bool is_tool_time =
 			tool_pmu__is_time_event(config, metric_events[i], &tool_aggr_idx);
 		struct perf_stat_evsel *ps = metric_events[i]->stats;
-		struct perf_stat_aggr *aggr;
 		char *n;
 		double val;
 
@@ -82,8 +81,7 @@ static int prepare_metric(struct perf_stat_config *config,
 			}
 		}
 		/* Time events are always on CPU0, the first aggregation index. */
-		aggr = &ps->aggr[is_tool_time ? tool_aggr_idx : aggr_idx];
-		if (!aggr || !metric_events[i]->supported) {
+		if (!ps || !metric_events[i]->supported) {
 			/*
 			 * Not supported events will have a count of 0, which
 			 * can be confusing in a metric. Explicitly set the
@@ -93,6 +91,9 @@ static int prepare_metric(struct perf_stat_config *config,
 			val = NAN;
 			source_count = 0;
 		} else {
+			struct perf_stat_aggr *aggr =
+				&ps->aggr[is_tool_time ? tool_aggr_idx : aggr_idx];
+
 			val = aggr->counts.val;
 			if (is_tool_time)
 				val *= 1e-9; /* Convert time event nanoseconds to seconds. */
-- 
2.53.0.rc2.204.g2597b5adb4-goog

