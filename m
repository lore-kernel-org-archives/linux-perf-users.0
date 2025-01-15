Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A68236EB6
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jan 2025 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928068; cv=none; b=rG/Kl3zPRojueM7ey5ZtzMRGQ6WuV64JjJNPu1ULFVIYTcvBdXxF7BPS2VH0HoOunduUp32NbFsIQNyDpTxVE6c2wdMQNzZ/2UMaH4QFlr+Ux367Qbm1rG1E0xNKu0fyU0ewAG+8UYGo5dxQaTmROpoDH71BMB3TF188WgvjkTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928068; c=relaxed/simple;
	bh=KR+WO74H0KLVFOGNgOJZh6kbJOu9TObNxexKACaFMGI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t4jKu992T8g1fyzsWVATo4DTtVCZR52lJ6DtuMs5WMoX+1GO/fSiD9HcWm3FiAa+Xh4xpoJr5Qb0nDEmZeZLd7FmgBMN12PwHOwzRNbio34GJ+6uH+HxH7AS6gvddqCgDNGW93b8cbwj4ugIeLLWlMmrVy9C5itO/BG44oNooDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J55QquPY; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J55QquPY"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aa66bc3b46dso460214966b.3
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jan 2025 00:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736928065; x=1737532865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=usWiQpF3MryasBotTIqnPXSZBuDJImkYsCGHtSkpl0o=;
        b=J55QquPYTkMtJ2gDMG0ZyKFaVfpSIWoJG6XzOI9qlqPYVncKctsH0CTaHI84OVgU2Y
         SWe8VfC5fj1bMFEvSdD2lrRr9UsxvGp81g1H1J9Qmz3JkNUbI4HjEwVxJLyG7eaEYLX+
         h3N3XxKIB3IjikZYqm9BpIvJciRvUXIGdfA3XNkpCsLWvLenSHCrxIVuA/M28VW9J+r9
         SLkTGPxEjfBkTCKv9xx0i/FA8Vrr7heflhGjvS9o2GK96dnVW8AWH9HdR6cpiDDs2Ng5
         bDvotx4K8tO4aGhjK0s3ZvxBWa2sJcU2Rr3bWXDShztOH6n5BlVXKq8KHreDhLllTxxf
         OeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736928065; x=1737532865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usWiQpF3MryasBotTIqnPXSZBuDJImkYsCGHtSkpl0o=;
        b=amVig/pvBbNWayY1NO0uSxg0Y4vx6tHHBfQvttvZVP6ZRnjU8f//3c9dJa3LHpWxix
         9/UdVBTb4UCYFSmHh51X35TRF8lc8WmWh3YXFvZdO1wdiArb70N4j73DUQTtHUNluLlY
         B6xi8iByEv2wyo8liXgmyMUvHoJhlR0KNZSAJZ8wz8oaYz9jJFdBcFC6rUlOo1zqb9BD
         cR5gx2H749WGWl5Q3GkpQqELfO50KGuxsLU5GBQSIPQ8eWASve9lIQhZO6ct/vGj5M4S
         kZtTPFEBtG2RoOhcKPU4YniPMO7gp5BsghUexluwRIFdmmFnFg1uavtSM1mAB/8I1Cmd
         UQ+g==
X-Gm-Message-State: AOJu0YzFzuF4Rf/fw7BSLIspva+6Du11Yp/2JVp1xe1DxOyshkN8fG+s
	hSe3/WX2EMB4ryKP7EJr8fZTMWVaZYqx7qWDFaFaKEBcJG3nEwLQcUt1urR9cGvqREDM9YLBU0S
	hj0H70A==
X-Google-Smtp-Source: AGHT+IFubxo6Yp6KVOHXVTLhbeWeYZbE2oZBIMDA+DK9TY45pusOMuk/4qqquUWROJIg1U+NeCCkFy/LUMQQ
X-Received: from edxu14.prod.google.com ([2002:a05:6402:64e:b0:5d9:a5e:5b52])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:530f:b0:5d1:2377:5af3
 with SMTP id 4fb4d7f45d1cf-5d972e00027mr63767378a12.5.1736928065374; Wed, 15
 Jan 2025 00:01:05 -0800 (PST)
Date: Wed, 15 Jan 2025 09:00:42 +0100
In-Reply-To: <cover.1736927981.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1736927981.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <359dc444ce94d20e59d3a9e360c36fbeac833a04.1736927981.git.dvyukov@google.com>
Subject: [PATCH v3 2/2] perf hist: Fix bogus profiles when filters are enabled
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

When a filtered column is not present in the sort order, profiles become
arbitrary broken. Filtered and non-filtered entries are collapsed
together, and the filtered-by field ends up with a random value (either
from a filtered or non-filtered entry). If we end up with filtered
entry/value, then the whole collapsed entry will be filtered out and will
be missing in the profile. If we end up with non-filtered entry/value,
then the overhead value will be wrongly larger (include some subset
of filtered out samples).

This leads to very confusing profiles. The problem is hard to notice,
and if noticed hard to understand. If the filter is for a single value,
then it can be fixed by adding the corresponding field to the sort order
(provided user understood the problem). But if the filter is for multiple
values, it's impossible to fix b/c there is no concept of binary sorting
based on filter predicate (we want to group all non-filtered values in
one bucket, and all filtered values in another).

Examples of affected commands:
perf report --tid=123
perf report --sort overhead,symbol --comm=foo,bar

Fix this by considering filtered status as the highest priority
sort/collapse predicate.

As a side effect this effectively adds a new feature of showing profile
where several lines are combined based on arbitrary filtering predicate.
For example, showing symbols from binaries foo and bar combined together,
but not from other binaries; or showing combined overhead of several
particular threads.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/util/hist.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 493b3cc30eac0..0f30f843c566d 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1303,7 +1303,16 @@ hist_entry__cmp_impl(struct perf_hpp_list *hpp_list, struct hist_entry *left,
 	struct hists *hists = left->hists;
 	struct perf_hpp_fmt *fmt;
 	perf_hpp_fmt_cmp_t *fn;
-	int64_t cmp = 0;
+	int64_t cmp;
+
+	/*
+	 * Never collapse filtered and non-filtered entries.
+	 * Note this is not the same as having an extra (invisible) fmt
+	 * that corresponds to the filtered status.
+	 */
+	cmp = (int64_t)!!left->filtered - (int64_t)!!right->filtered;
+	if (cmp)
+		return cmp;
 
 	perf_hpp_list__for_each_sort_list(hpp_list, fmt) {
 		if (ignore_dynamic && perf_hpp__is_dynamic_entry(fmt) &&
-- 
2.48.0.rc2.279.g1de40edade-goog

