Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB4A1FC7EE
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Mar 2025 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163868; cv=none; b=iEsDZqdrp76OIxyn3ZMenJfG6aTNIU40HzywJdW9rIytTOATQ2QEc34S4k/Tm60pZqczFBOgKNjMTmkQKAb9InpjeU5vZ9Hy0JyHqmGszeuf/Vft+vlAekszC+Aio1787qzuamIXW7RHhKXobLX/cXe/G/+UXJd9Nr2k+FnBndU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163868; c=relaxed/simple;
	bh=Jtfvhh878ExLpWMn3BZ7mImC4OkgqJ/GrmL8O5GGJFk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=e2zA4XZBg9wfbeAMiy4kzCTYloU4xgT8dhQJfeOlb6NRfTOWKxfn+bU5KYUgLoyy6qzMR+Ysoyasdja+krvg8HmnAYEjIz3oCCudLYpZNjzTc7zcfbR17Z4BzRpWd5/liZOfcEHXM4zcLsC5sC9t6KlfWqxlTEvm/SMbWUHv33k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tHZ2FGWK; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tHZ2FGWK"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fea1685337so1288224a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Mar 2025 00:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741163866; x=1741768666; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=boJ9ipfyxaYYDuhZilQeC7rcL8GckIWqxbDDjr0kEWg=;
        b=tHZ2FGWKcXnI0pvqjP83p3uRpiA+wu1KU6qJ4lEpAOKs3eD4YaAUJYkvcgDVu9R0oH
         jmfPHvQCFp5kkYtWVXJpPfbvJmnTZTQzs4r6M8ijTC8ttXq7gbzBnCKvcprtw+FWHt1E
         OB4ug3peUZzY0kEr64qQuQj5WgPHKjw0x40wz+9TQ7dE8zVenIc2VZTa99XvLNI7Tm2F
         k5rqBxgsoaJtYQCgV6zR07Gy0Qmve+EaRS4Suz+KKrsJEukLtgYhqU8N5HJMVD8tZtoq
         HdOLGHI2zcMsUtABQOP59s/Tyuntj83/aj+7s2X4Qw+fi8s5PWnH9MTnyzqaqFeH7pmR
         /VyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741163866; x=1741768666;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=boJ9ipfyxaYYDuhZilQeC7rcL8GckIWqxbDDjr0kEWg=;
        b=L3HZRhDNYNcrUjhEt5+u84MWRjq93+YUNdgUzlBhHCU+OZmqMUgX+0iJklD6OgFnsH
         sYum/awfWqIimkDoVrnpr/49PVfcUFeM2luadY4mpcwQsJnfeLPXFt1nZpyIzp59em+l
         Lsyarn6A6hU9KHFYHJ4/25LB62s73oMfLnYApRkiiZINeoUV2zd689lwjOvyPtu31oja
         Vxl5j7maSTyAGSq2km2DWcPoCkxDBowrgKC4qVcf/DRgMwoFcpLD+9IHjNd4jZAZT+tw
         ALarUzRleiym+daWc8l8F0x2ieKxea3fbpwmnafFlBXYiBGFzuWmGrr+uv6Gx6tQgiKL
         2JPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp4APlsTu5AxPmAHCju4R3fPE8mYlSn3N8/ohYgq8jJGJLta0cCxAxpj+vsfb9/u+YiFhLinOsAJiQ5Bf2XQA+@vger.kernel.org
X-Gm-Message-State: AOJu0YxOxGLDAZuuQTniPmiwty+jSTNV26lz7jyJiX34eq7qyoI6yN1w
	tYWPY6SotYTTR5LxKegpNl5WdPOXnturI8TgStIa74YBEymyYSpOtx4FIPhEWz8nR+96pxMCWuK
	Gbk3DJw==
X-Google-Smtp-Source: AGHT+IH1ye3IifMrGiIS0D/6X3yxlcwlhZkoYrwtFohrAvp6YLWEaaB8AnpjoMCAcwWHBQ33k6IgFOaTFjm2
X-Received: from pgbbk9.prod.google.com ([2002:a05:6a02:289:b0:af2:5566:dafd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:516:b0:1db:822f:36d8
 with SMTP id adf61e73a8af0-1f34921fd83mr4767910637.3.1741163865850; Wed, 05
 Mar 2025 00:37:45 -0800 (PST)
Date: Wed,  5 Mar 2025 00:37:35 -0800
In-Reply-To: <20250305083735.393333-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250305083735.393333-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250305083735.393333-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf parse-events: Corrections to topdown sorting
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Andi Kleen <ak@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

In the case of '{instructions,slots},faults,topdown-retiring' the
first event that must be grouped, slots, is ignored causing the
topdown-retiring event not to be adjacent to the group it needs to be
inserted into. Don't ignore the group members when computing the
force_grouped_index.

Make the force_grouped_index be for the leader of the group it is
within and always use it first rather than a group leader index so
that topdown events may be sorted from one group into another.

Reported-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Closes: https://lore.kernel.org/lkml/20250224083306.71813-2-dapeng1.mi@linux.intel.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 54 ++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 35e48fe56dfa..cf32abc496e9 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1983,31 +1983,30 @@ static int evlist__cmp(void *_fg_idx, const struct list_head *l, const struct li
 	bool lhs_has_group, rhs_has_group;
 
 	/*
-	 * First sort by grouping/leader. Read the leader idx only if the evsel
-	 * is part of a group, by default ungrouped events will be sorted
-	 * relative to grouped events based on where the first ungrouped event
-	 * occurs. If both events don't have a group we want to fall-through to
-	 * the arch specific sorting, that can reorder and fix things like
-	 * Intel's topdown events.
+	 * Get the indexes of the 2 events to sort. If the events are
+	 * in groups then the leader's index is used otherwise the
+	 * event's index is used. Events in the same group will be
+	 * sorted by PMU name. An index may be forced for events that
+	 * must be in the same group, namely Intel topdown events.
+	 * When everything is identical arch specific sorting is used,
+	 * that can reorder and fix things like Intel's topdown
+	 * events.
 	 */
-	if (lhs_core->leader != lhs_core || lhs_core->nr_members > 1) {
-		lhs_has_group = true;
+	lhs_has_group = lhs_core->leader != lhs_core || lhs_core->nr_members > 1;
+	if (*force_grouped_idx != -1 && arch_evsel__must_be_in_group(lhs))
+		lhs_sort_idx = *force_grouped_idx;
+	else if (lhs_has_group)
 		lhs_sort_idx = lhs_core->leader->idx;
-	} else {
-		lhs_has_group = false;
-		lhs_sort_idx = *force_grouped_idx != -1 && arch_evsel__must_be_in_group(lhs)
-			? *force_grouped_idx
-			: lhs_core->idx;
-	}
-	if (rhs_core->leader != rhs_core || rhs_core->nr_members > 1) {
-		rhs_has_group = true;
+	else
+		lhs_sort_idx = lhs_core->idx;
+	rhs_has_group = rhs_core->leader != rhs_core || rhs_core->nr_members > 1;
+
+	if (*force_grouped_idx != -1 && arch_evsel__must_be_in_group(rhs))
+		rhs_sort_idx = *force_grouped_idx;
+	else if (rhs_has_group)
 		rhs_sort_idx = rhs_core->leader->idx;
-	} else {
-		rhs_has_group = false;
-		rhs_sort_idx = *force_grouped_idx != -1 && arch_evsel__must_be_in_group(rhs)
-			? *force_grouped_idx
-			: rhs_core->idx;
-	}
+	else
+		rhs_sort_idx = rhs_core->idx;
 
 	if (lhs_sort_idx != rhs_sort_idx)
 		return lhs_sort_idx - rhs_sort_idx;
@@ -2055,10 +2054,13 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 		 */
 		pos->core.idx = idx++;
 
-		/* Remember an index to sort all forced grouped events together to. */
-		if (force_grouped_idx == -1 && pos == pos_leader && pos->core.nr_members < 2 &&
-		    arch_evsel__must_be_in_group(pos))
-			force_grouped_idx = pos->core.idx;
+		/*
+		 * Remember an index to sort all forced grouped events
+		 * together to. Use the group leader as some events
+		 * must appear first within the group.
+		 */
+		if (force_grouped_idx == -1 && arch_evsel__must_be_in_group(pos))
+			force_grouped_idx = pos_leader->core.idx;
 	}
 
 	/* Sort events. */
-- 
2.48.1.711.g2feabab25a-goog

