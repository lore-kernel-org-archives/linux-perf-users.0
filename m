Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F12F30FC06
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770416718; cv=none; b=sXTFbdGbsjiwqXucMUgAxUkTo3/ki56KVXhNb0x4g7OPkS7/BmqpcqUwy5C4JKyLgrKA7o6Cec1AHi4pRGWP8Q6RMhxaCWqYuPOlT7ZSBrsR307hmHDT7g6xl1HEEcHhhhRKLhqNoZDgK+Uo/S/nM2HxIISn2Fi1GS+sh3cuoN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770416718; c=relaxed/simple;
	bh=oCJM+Rr7JVsz+oeqiW3eAWsUmuqxZlKgbkrzgaB0YjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EKyUvThelqAJxPbyMi/h7U0VAGCJUuT+fVh1kOdk/L72OFM3LHu7B+1ngKQwwRia3L0SlBPvNBdEn0Q/HaGrfljQQspeQ2ZyA5Pi2ni6cVJo1lKI3tqYkyEAhMldTVxfqiersXlutZqwh4KJNsXhTqcdscXwHg2ao3XBSHQnHb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VNjsd9M7; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VNjsd9M7"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-124a38e8980so2070084c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 14:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770416718; x=1771021518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hPCduTIdh2srDUZiYkVasbXP897FIHgjqU6XNx2eU5s=;
        b=VNjsd9M7c09GlIVKMoP0JgpTQenGWfDMx4P/LBqFx5QEGI/kgzQJ7qtAQtF3FVHB9H
         b8xr3JRIv6z3Ejqxn/aYiN8ZUl0NXLBd27YVRkLiXtvYLQO479d9KWrBHV3kHUouVkD9
         nG5mHevo0LBBeHd2TDpg9efsBWr4U5hNVkHRgnvw8SA0rC0w9iNWWWY1oboIcASsEle4
         ACgcoNM7UI30DeD5TH+eiIk4Q/kIntV8GMIQ4YtgJR14HLOvuONEf2eLyMLsFDlJ3GER
         0OlTzpCDNIOWxxut6OEx6yiv5/OAN0xQtMtHzplL5FSYZGi0QdDOCMlJW4E6OhSekwoH
         u+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770416718; x=1771021518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPCduTIdh2srDUZiYkVasbXP897FIHgjqU6XNx2eU5s=;
        b=VgB7YQP0DajF12u02PKLanJ135rayRH51+VXLX3cneWjdilrnNaUiAOlX3IVWUYYQM
         g0tVbvA7z8Ei/FfRvCFXTJaz7uRjUpoNYjYKWUzmphnyVKPt/Mrtma7teRvZRxKqcBf4
         Iubiqb0UuLpBhhgcotW1xGQCjBnywre2bdlmxLBs4eZNHIdXq6BdYcQmMXZP8x9/nejB
         tHVPa6dGvoQfd7KHLuPpdxS0Ki5dyHrQc9v9Ye+UAx224ahqDgS2nWVL/TnJjwquUzWN
         oY6MzLkEdYmkwkOx8fg9FzJc8DAiLNLMmXboFhCxEqgIEvNdWbyoZD+5FzdtAW+i/4U/
         MQGA==
X-Forwarded-Encrypted: i=1; AJvYcCUWRt86YZMz8i2v5+OU/aH4tsA7mJ78w8C0feoZBcfk3IgWo6bAfkvaLI1OVhC8gEhYtrk0Mod3tqA5NH1xv5uM@vger.kernel.org
X-Gm-Message-State: AOJu0YzTNisigLvl80bVDz8g5O7fR2yoNjuc19ur0hp/nE/s61sT+DYU
	Aft3BheySFWazI088NOfsIDpA/Z1rf99tBGo+pAZ/gi0wJFASWTNGHijpnmDLayt+l1Cyxlw2N1
	TnnjTAtvHAg==
X-Received: from dlbay9.prod.google.com ([2002:a05:7022:6609:b0:119:78ff:fe1c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:62aa:b0:119:e569:f60d
 with SMTP id a92af1059eb24-12703f3c734mr1809216c88.6.1770416717548; Fri, 06
 Feb 2026 14:25:17 -0800 (PST)
Date: Fri,  6 Feb 2026 14:25:05 -0800
In-Reply-To: <20260206222509.982489-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aYZnkYqWXnKpHd3h@x1> <20260206222509.982489-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260206222509.982489-3-irogers@google.com>
Subject: [PATCH v8 2/6] perf stat-shadow: In prepare_metric fix guard on
 reading NULL perf_stat_evsel
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com, ak@linux.intel.com, 
	alexander.shishkin@linux.intel.com, andres@anarazel.de, 
	dapeng1.mi@linux.intel.com, irogers@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, thomas.falcon@intel.com, 
	tmricht@linux.ibm.com, yang.lee@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

The aggr value is setup to always be non-null creating a redundant
guard for reading from it. Switch to using the perf_stat_evsel (ps)
and narrow the scope of aggr so that it is known valid when used.

Reported-by: Andres Freund <andres@anarazel.de>
Closes: https://lore.kernel.org/linux-perf-users/cgja46br2smmznxs7kbeabs6zgv3b4olfqgh2fdp5mxk2yom4v@w6jjgov6hdi6/
Fixes: 3d65f6445fd9 ("perf stat-shadow: Read tool events directly")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 5d8d09e0e6ae..59d2cd4f2188 100644
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
-		if (!aggr || !metric_events[i]->supported || aggr->counts.run == 0) {
+		if (!ps || !metric_events[i]->supported) {
 			/*
 			 * Not supported events will have a count of 0, which
 			 * can be confusing in a metric. Explicitly set the
@@ -93,11 +91,21 @@ static int prepare_metric(struct perf_stat_config *config,
 			val = NAN;
 			source_count = 0;
 		} else {
-			val = aggr->counts.val;
-			if (is_tool_time)
-				val *= 1e-9; /* Convert time event nanoseconds to seconds. */
-			if (!source_count)
-				source_count = evsel__source_count(metric_events[i]);
+			struct perf_stat_aggr *aggr =
+				&ps->aggr[is_tool_time ? tool_aggr_idx : aggr_idx];
+
+			if (aggr->counts.run == 0) {
+				val = NAN;
+				source_count = 0;
+			} else {
+				val = aggr->counts.val;
+				if (is_tool_time) {
+					/* Convert time event nanoseconds to seconds. */
+					val *= 1e-9;
+				}
+				if (!source_count)
+					source_count = evsel__source_count(metric_events[i]);
+			}
 		}
 		n = strdup(evsel__metric_id(metric_events[i]));
 		if (!n)
-- 
2.53.0.rc2.204.g2597b5adb4-goog

