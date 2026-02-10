Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CAC32BF41
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 06:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770703450; cv=none; b=K/0O5pOjsEEoWZzHquho+Bc4qRcCpzXPPYIq5FQ1U0IZIkipjUesnzDXgqXe2I3WQT8r7n3kNcTCbVcyTo+b01UvOJRzQy/e/dOfoybL7PyCaVcVDHZOlzVJ/Movj9kFpRQFnsYEfZ/+jBiU8UB3rWXwf8bLf4/G2c41zRhMM0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770703450; c=relaxed/simple;
	bh=TzweULhbFyvVOxzKvm6ziGllewjhlCuvpRxGmN/BS4Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cxsUjy2kyWUXbVlKKboHTQ/3tOjZW3PdEtY2sMLIw2s6L49+VI99pX03lpTN7JWLQNYMi+VGpzb2j+PJKxZrgL1WXWwjPPbuc2HEtNGToYarV3Z06Spot8LNBALiFsquQkv+dsHwn/4OgaBwoyMEnYD3kMHEkw9oLddNKgeTy90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KVCX5bhK; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KVCX5bhK"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b6b9c1249fso4256427eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 22:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770703449; x=1771308249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yDLKVG3tEtlD42Ak1LCzl04+zbbwATgaIYJmxnnK6Qc=;
        b=KVCX5bhKlAY40YdEPKionSJwytrqQFJUktQclUSB/IF2GIMtewnB0/wGDl5/lP3XZd
         i0EqfoRjhjO2RxziLfkMW5M30pB+HaOqAsFRKd7Vz7jinxSHCrzzcYUTF5r/mYL2DX+Y
         Hl2c4GraXtB6kUByf1KUoQtlyYtsJ+QYcjVvnFlqvdTLVBvyuPkhQqew1ReoxtIhmQnR
         u7O529VK4giirpD0gS6QKn5greFveBI/W3c0iSpM4UfKBErnkdwF5dbYODxncYrfy8dN
         2PkqBZrF7WxJdhnSxoXbDZ0TDaBklCrevZmLmUn4jfsaepB4eEyGbiOuvo8bvjBOWvUu
         f2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770703449; x=1771308249;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDLKVG3tEtlD42Ak1LCzl04+zbbwATgaIYJmxnnK6Qc=;
        b=uaZH/Rz36zEft0p94A40gpoZ4LjTFtUaIbgiROkdG9pTUwCT/hAuQkCK5uv95rDeng
         uh/d8jGgT3p4t96xIwsrfnLSRPKI6yOaSfwFoB3uccL/+I27w9flxsKxyvC4bm/+UZMu
         vXnHi8cQ8wE9G1XJwYjmnNyIh6iVIRIpxGmi2ywF/HYCvbvCO9j5ATFW0Fw+kcnazTic
         JovYvudt05nixXYXCWtR+Zb046y8QAMjtTHGq0g5R958feEJew5Np2iYI5k5la9DtE1p
         EZ0ytIDMbYYFR0pVhgviSZ7UfLK/guNUBp+cC9OrnZ7CMSImZNbMVfMd93gk9H7Vu7jT
         kTMA==
X-Forwarded-Encrypted: i=1; AJvYcCXxbJ3XiMFSkeBet5bQEqWQqA75BBnf4hRknXGxEy6P0TJfdFZTLlhxSQzm2ubJEDaBBpYRksgnHVjyKTrtKRrH@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6txc1WO+bq49PfJ81CsgyPXYLYsfY4mHSDZVDGPCtxGpDuyfA
	IJGycnWozSSSRnMsbgMgpHSCZpbXWPSldi9Dp5RiKHjy3oexaMB6FMEfT4lRnPQ2f154sgoxtBx
	nfyakRZtezw==
X-Received: from dlbdd35.prod.google.com ([2002:a05:7022:aa3:b0:127:1887:64c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:a86:b0:123:330b:398
 with SMTP id a92af1059eb24-12703f51b55mr5734557c88.19.1770703448533; Mon, 09
 Feb 2026 22:04:08 -0800 (PST)
Date: Mon,  9 Feb 2026 22:03:55 -0800
In-Reply-To: <20260210060359.2233425-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aYqHTfCoW1bGmJF4@google.com> <20260210060359.2233425-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260210060359.2233425-3-irogers@google.com>
Subject: [PATCH v9 2/6] perf stat-shadow: In prepare_metric fix guard on
 reading NULL perf_stat_evsel
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org, acme@kernel.org
Cc: adrian.hunter@intel.com, ak@linux.intel.com, 
	alexander.shishkin@linux.intel.com, andres@anarazel.de, 
	dapeng1.mi@linux.intel.com, irogers@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	peterz@infradead.org, thomas.falcon@intel.com, tmricht@linux.ibm.com, 
	yang.lee@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

The aggr value is setup to always be non-null creating a redundant
guard for reading from it. Switch to using the perf_stat_evsel (ps)
and narrow the scope of aggr so that it is known valid when used.

Reported-by: Andres Freund <andres@anarazel.de>
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

