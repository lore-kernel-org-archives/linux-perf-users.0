Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F3B37FF5E
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 05:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773726822; cv=none; b=o1YGhkqoHY/GUFhOcDhFZHCv2W/xtKJ0SmH3hPXSvOSLYd94m9nme3hYRwxpAiOrs9ENtxCRP6JcGJwqrdGffBR/a+WB3f67zbwwI/gstxEUVvc/q+wK+Slerv+uim6QVxeEsflLN7YORqHYO/aQnLv3SmMSG/y7Z+ZKt94I7gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773726822; c=relaxed/simple;
	bh=wVIk574MaJ1ryn6M1d5QWZAOYLPanqIo/c++6wESi+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sln4gZhVg+RReIZK8DZmrHeCKIXWSdaRRb5aYR1snATvDnfoonfMkuxhVVHWJpv4UfWmWmDf3IL+0ta7zNcQijUoG9DkPOUB8Y8eTTudywcs00F2KdLcQICfxvzfRvacjXIRHXkawSE50HlbVI11EVx2hUvS4/i+a2efBj0q3w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ax6ohwr8; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ax6ohwr8"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b05d170cadso17462795ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Mar 2026 22:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773726821; x=1774331621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BC7DFlkd9xaG2royXDyXDCwOCftcIJRM1qoiGuRC8ho=;
        b=ax6ohwr8WA5iNkQT7GheNnHzCFcoUrO4PF9UsSmDu/PqDjDAf+XIdSt5Y5pRZfmYNO
         gulZJpme2ugd1JrAlnE6JWUmUGPC2GD/HWKmisLD/Z0Blrd0bP3kNxAjMc249imGDpc0
         PCINEKcuara+Adkoigt0lcXj9LGRSGuIvlfj/IHbC1//vykQeENqE96eSjpU0lQtEdxe
         QVWjGmBNzq3jIJFfoNYEsa7b+OBHvW8bHWVYRaH2yZBvpXhtA1DLuZSWqXdXuvOKDcbX
         V0CHsz5FnObLqWhcIyf/GJSl4YNtLRkXk+T9pS5dhELWiZ0ujk0C+fJ5NOyvxMN7h0jh
         CdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773726821; x=1774331621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BC7DFlkd9xaG2royXDyXDCwOCftcIJRM1qoiGuRC8ho=;
        b=mtoBeDYWu+kwxdQqroq9RN7zuvfbV2DfM72xysCxThGNSFuYF4medJnULM9e2YOqzh
         k4gs4tlZnJzc79758FWgEYGRyJoH0iCIBGCmPq3x+icYw8lBTyGyXGFCumV5n7mh/0WD
         gP8rpDXJwYTO38RFsMV46iqdkiiEEtQnV9uQ6ov4SXSi0NekBtqCmJ3RFg2oZt5dekA7
         et8g4gzNOCSd0DvVKMZji9zXAPATOzFEHxwnPM/vIIfi7uQbySIGcTwN400w6jF/Gh4S
         yACeYJpZFBV4B2no414apRojnE8fkDQd+OkoK27BnLwrK/c70r1/REpDVhDB6BFIK6d2
         oPMA==
X-Forwarded-Encrypted: i=1; AJvYcCUlGSS55Xs6GCH5f5MM1dn7dDBM+XPMyrjZCt9xcp31pnnyc5HWcsREO+oqldSpVoVb1iZQMA+jOfceusJxylGP@vger.kernel.org
X-Gm-Message-State: AOJu0YxF68NLCEuihMoGn25/7oJW0xrZWdg5XuzP+9nsyG2Fw6gHHEtD
	gSjK038qkaIzrWyCY/yP0DCPENULaJq5bUnGeTcK3JZsu1kqo7psl6OVXZJCQreaJDHP85ihj45
	q9ZHa7r862A==
X-Received: from plan1.prod.google.com ([2002:a17:903:4041:b0:2b0:5ba8:77e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c4:b0:2b0:5cb4:d89d
 with SMTP id d9443c01a7336-2b05cb4d98dmr50571635ad.29.1773726820372; Mon, 16
 Mar 2026 22:53:40 -0700 (PDT)
Date: Mon, 16 Mar 2026 22:53:30 -0700
In-Reply-To: <20260317055334.760347-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260317030601.567422-1-irogers@google.com> <20260317055334.760347-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260317055334.760347-2-irogers@google.com>
Subject: [PATCH v5 1/5] perf evsel: Improve falling back from cycles
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Switch to using evsel__match rather than comparing perf_event_attr
values, this is robust on hybrid architectures.
Ensure evsel->pmu matches the evsel->core.attr.
Remove exclude bits that get set in other fallback attempts when
switching the event.
Log the event name with modifiers when switching the event on fallback.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 45 ++++++++++++++++++++++++++++-------------
 tools/perf/util/evsel.h |  2 ++
 2 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f59228c1a39e..bd14d9bbc91f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3785,25 +3785,42 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
 {
 	int paranoid;
 
-	if ((err == ENOENT || err == ENXIO || err == ENODEV) &&
-	    evsel->core.attr.type   == PERF_TYPE_HARDWARE &&
-	    evsel->core.attr.config == PERF_COUNT_HW_CPU_CYCLES) {
+	if ((err == ENODEV || err == ENOENT || err == ENXIO) &&
+	    evsel__match(evsel, HARDWARE, HW_CPU_CYCLES)) {
 		/*
-		 * If it's cycles then fall back to hrtimer based cpu-clock sw
-		 * counter, which is always available even if no PMU support.
-		 *
-		 * PPC returns ENXIO until 2.6.37 (behavior changed with commit
-		 * b0a873e).
+		 * If it's the legacy hardware cycles event fails then fall back
+		 * to hrtimer based cpu-clock sw counter, which is always
+		 * available even if no PMU support. PPC returned ENXIO rather
+		 * than ENODEV or ENOENT until 2.6.37.
 		 */
-		evsel->core.attr.type   = PERF_TYPE_SOFTWARE;
+		evsel->pmu = perf_pmus__find_by_type(PERF_TYPE_SOFTWARE);
+		assert(evsel->pmu); /* software is a "well-known" and can't fail PMU type. */
+
+		/* Configure the event. */
+		evsel->core.attr.type = PERF_TYPE_SOFTWARE;
 		evsel->core.attr.config = target__has_cpu(target)
 			? PERF_COUNT_SW_CPU_CLOCK
 			: PERF_COUNT_SW_TASK_CLOCK;
-		scnprintf(msg, msgsize,
-			"The cycles event is not supported, trying to fall back to %s",
-			target__has_cpu(target) ? "cpu-clock" : "task-clock");
+		evsel->core.is_pmu_core = false;
+
+		/* Remove excludes for new event. */
+		if (evsel->fallenback_eacces) {
+			evsel->core.attr.exclude_kernel = 0;
+			evsel->core.attr.exclude_hv     = 0;
+			evsel->fallenback_eacces = false;
+		}
+		if (evsel->fallenback_eopnotsupp) {
+			evsel->core.attr.exclude_guest = 0;
+			evsel->fallenback_eopnotsupp = false;
+		}
 
+		/* Name is recomputed by evsel__name. */
 		zfree(&evsel->name);
+
+		/* Log message. */
+		scnprintf(msg, msgsize,
+			  "The cycles event is not supported, trying to fall back to %s",
+			  evsel__name(evsel));
 		return true;
 	} else if (err == EACCES && !evsel->core.attr.exclude_kernel &&
 		   (paranoid = perf_event_paranoid()) > 1) {
@@ -3830,7 +3847,7 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
 			  " samples", paranoid);
 		evsel->core.attr.exclude_kernel = 1;
 		evsel->core.attr.exclude_hv     = 1;
-
+		evsel->fallenback_eacces = true;
 		return true;
 	} else if (err == EOPNOTSUPP && !evsel->core.attr.exclude_guest &&
 		   !evsel->exclude_GH) {
@@ -3851,7 +3868,7 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
 		/* Apple M1 requires exclude_guest */
 		scnprintf(msg, msgsize, "Trying to fall back to excluding guest samples");
 		evsel->core.attr.exclude_guest = 1;
-
+		evsel->fallenback_eopnotsupp = true;
 		return true;
 	}
 no_fallback:
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a3d754c029a0..97f57fab28ce 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -124,6 +124,8 @@ struct evsel {
 	bool			default_metricgroup; /* A member of the Default metricgroup */
 	bool			default_show_events; /* If a default group member, show the event */
 	bool			needs_uniquify;
+	bool			fallenback_eacces;
+	bool			fallenback_eopnotsupp;
 	struct hashmap		*per_pkg_mask;
 	int			err;
 	int			script_output_type;
-- 
2.53.0.851.ga537e3e6e9-goog

