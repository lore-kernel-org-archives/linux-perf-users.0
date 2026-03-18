Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335D36164C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773856705; cv=none; b=XRhPiknU5u/gSQW8Ca9pTov29EGHwvx+e8+S/kw/ZOrH0PYdJDn3l3L9X/lyC1iy/DnicfYj/Mck2XsfQ+h3ja8TMRBRmbyuJ3Pr/5mESnZa0Rei15txeJr/PByhedLQ6gK4HRUnYgr3sALIzctEdbKj+Z1TB2xcViTNTfW5+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773856705; c=relaxed/simple;
	bh=U8LqxsgGl8pPzMoHQSm3GXUaosjRDy/a3rvRqghM3i4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KKDLHW+U1SkfBIivk66d9+1TGynwEBraWgvdEJlTFsYbOQYkLzypWi5YX5uVlfhQwBJdYOldocJBD2VLetHKYOZxaFt6YYuzFGt6KUbMYXV/LxOTAnl99SOJ8XyzuhbmLyfNGMl/Bkz1gbDMBzlP9uJE8EiAuAAuQjQ0vJnvDtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JA0k50oH; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JA0k50oH"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1275c6fc58aso166413c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 10:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773856702; x=1774461502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FHgnOqAqVJ/nZ21E+abJVIPEw9OV5mDZ+DHTpPzA2N8=;
        b=JA0k50oH5poHg4/kXNAnc4gPF9T3Dwnqk37EXF1oL8KJoqlKEtJaK0lXZBKQec2TJZ
         Mfk1oVCT1dfBHwSCowONqy13YU+dVTsxHj+yk2x69QYggWhs+2KD5P67zcaRCNnULo8+
         vSa195qe/2yRz3M65wgLo0mPH+mZsA9hd89WeAC7yN1DPLLL4PJSIeASnVerduXKJ3NT
         WkE+62lYA1fy+OJEEo7F7JCJCztnvdzQQ+ne23dopJ/vocTPytvsrC6EPbYI9v/iPy6E
         6gPQh2QxK/MrWibtLaAE3Bh6lmf2oLra8N/+g97Tp4sZRfmMTTOPgDoMz+Ve7RxMWVeH
         U2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773856702; x=1774461502;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FHgnOqAqVJ/nZ21E+abJVIPEw9OV5mDZ+DHTpPzA2N8=;
        b=rVZ4EWrXeByF4EJ5rwOHcs5XCUOjz38FowXW7fc9z1glm5mqUcqsp4WJk6tOrsZWl4
         06++FCzi2XMpHehTmFefoPgbOetYa0h9Ou46Cxl50eFY7sLIae6fI/YAUpSHF96koX4x
         5db53oiZsmCLPszcY3eKRkss5QX7krtX/lNVo7ZPyJwc2wuJYqbltRSdrbBDI5dYvrhw
         h+Sp7ad6FGc4XErvk6JhTQkbreuS+bcbFkEXcbJdaNp/yK9V3aP1stj1SiQB58lyuQ/5
         rRESIIn79PZGeyp+tT1Cg9LMFlNgA5qIXNDoZe9wjXubvyb8x8ktw9AGUYVrTwbDdasl
         L6+w==
X-Forwarded-Encrypted: i=1; AJvYcCXLmrGyHGWvqHCmql8jgSeDdsqFYRXsJ8atKyCjj4VBX2Tf5O6JZujzlzwsQv7zkkVLeC5LS/0Tr6yBHd4yXs7Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyyLQQoJ7Rq+mulaC1S9++BRjnCURkJyLJeWQVoFUw4L3d+yMIw
	EkGPz5s6OcD48GUF4pt452lYqPbjNb4WpgqbcLjaq1FHhjZb3IhWAneZwHt02chMHjbDd67Z4tk
	5BqOOGqvOxw==
X-Received: from dlam9-n1.prod.google.com ([2002:a05:701b:2089:10b0:128:d017:6507])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:60f:b0:128:df3d:cd97
 with SMTP id a92af1059eb24-129a7177e06mr1946352c88.35.1773856701973; Wed, 18
 Mar 2026 10:58:21 -0700 (PDT)
Date: Wed, 18 Mar 2026 10:58:04 -0700
In-Reply-To: <20260318175808.582009-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fWCf1TFMW8epW8moOcUbMuzRjrG1r38SWFevH35mqR0+w@mail.gmail.com>
 <20260318175808.582009-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260318175808.582009-2-irogers@google.com>
Subject: [PATCH v7 1/5] perf evsel: Improve falling back from cycles
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
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
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

