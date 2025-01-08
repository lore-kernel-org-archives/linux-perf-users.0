Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892F71AF0D3
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736321846; cv=none; b=G7NJxEBvql817ZuaVhJivFBRNbbFgbOqnQ/wCc6WccKaS7VEdycGAEZMxpJtK0kMg5ij8ntpmpmqkbyqQspa/yZNjlrATNGW+fbQ5VqjEuuwq8sZiKT78w2E7S3KNc8Fq6IvYgCnFyWEHuust8bZsJD8TKxH+Xzg87Pcxl4Rwc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736321846; c=relaxed/simple;
	bh=ssnwSOU4tMluyKpxJ+sQ/AdWQ8sjYkDTemZDSJ9rtF4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ResWk90X50tSamCI+z7jcnsFWHVTF/602W0+Zu9s/x7urXIaGoZonTiWComkMEQbgQ7BJzuAhTS27X+X8X460foCXO8QdT0exqR20we0u4kRIg75dq5Wi5fUGTWYWqpEf6SqopPAWOrruApgoW9ygxi5ihVRrF0/EysPyZNj8qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b0E4akSM; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0E4akSM"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d3ce91c403so11002073a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 23:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736321843; x=1736926643; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0BU7wNT3VVXFhkOsxYWUJLFvqycxhKZviGhJ5Ua6/O8=;
        b=b0E4akSMS2nrxuf/fbGRJGrkOQu4uZHq5itF1eNqSd5JZmUpVAisRwIegz91RIWsBV
         g+C4MkndSmR62Rs3EALoNr5SAqK5Rc8JsCih+gqYMDcv/fTOYSaG1XN2pzIHxjAkTbBW
         +NwbRjf6hzmCf4y4ro2B7Z7reAWODiE+IX4bPJIJ9MquaVfS2f8hl3oekMxRvkToID3V
         qHILo/zhnwgKDScpfaxwEeDo3+/X5ScZkrRkLv7fMGzzJpxmOgukpLfXkg9BgxcwEuAd
         LuGsRaeuE8Ss9aOlrZUkPtLwh0WECMTAWT30wfe0oh6ToODo7D4maydK2qGa25CsnW2d
         kxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736321843; x=1736926643;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BU7wNT3VVXFhkOsxYWUJLFvqycxhKZviGhJ5Ua6/O8=;
        b=hL9FD0ppgV5FeqZizaig659tssx+i6uHQHKToGw3FWtl0hkuy3zFnbM383y5sBxj8F
         7cP1eOQNkARGMoPlXArJorLyy9t9CBPo/1wVdypeocQf6ZfLkQFHQZl4QkTyyQeRm/1y
         lfbnjrZm7CYoVeCkLwrHlz1D1uAeoe5B6HJvC5dCOactOrtbLfANh2uxIf4kPId9Cfi3
         Y6WQDgzlzUVlkpd7cpnsNf7klfku79DcH8iRQjl9DyOkCqNIInMWLu/GOPPYGMk2NV99
         i5B0+JsLYJMyGXS7vrpSUfASnGecHCUEj8ugAzoRnQpfwFl/p+EWOQEYCCuPNPdqnCNa
         CfjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzxp45GlzBVodI3YHS2ZsAi9NU3FuAFwDaTsguhrhw9VJ4mB0JUx9mL6pnSXLB3Us6SmenHaM5rsG50cPNNGWC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu4cdj/U5USUTSjdaYYqBR1YrAFSvmefVZBZCJ8aEjdHXJzW2N
	WTKoTGMYOV+SPysDh/3LO7jl4v7/413OOdVbGYuGSCqq5mLP9LxmJXuNb6QsJmPRki4eoJ0KZZr
	6S3PlXw==
X-Google-Smtp-Source: AGHT+IGZttUKqWLDlQTmcdiOn/ktrXpd6PdsSPlSLiBt36GdcoKfhh2x89jyWxDgZ5hstd3IufmZLKAIeq+n
X-Received: from edhh5.prod.google.com ([2002:a05:6402:e05:b0:5d4:34da:32db])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:40c6:b0:5d0:fe7d:41cf
 with SMTP id 4fb4d7f45d1cf-5d972dfb274mr1373526a12.5.1736321843193; Tue, 07
 Jan 2025 23:37:23 -0800 (PST)
Date: Wed,  8 Jan 2025 08:36:54 +0100
In-Reply-To: <cover.1736321686.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1736321686.git.dvyukov@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <177603055d58e3d82e38f236f3be9fa52dc2d2c5.1736321686.git.dvyukov@google.com>
Subject: [PATCH 2/2] perf hist: Fix bogus profiles when filters are enabled
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com
Cc: Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
index 8e4e844425370..b70170d854a0c 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1303,9 +1303,18 @@ hist_entry__cmp_impl(struct perf_hpp_list *hpp_list, struct hist_entry *left,
 	typedef int64_t (*fn_t)(struct perf_hpp_fmt *, struct hist_entry *, struct hist_entry *);
 	struct hists *hists = left->hists;
 	struct perf_hpp_fmt *fmt;
-	int64_t cmp = 0;
+	int64_t cmp;
 	fn_t fn;
 
+	/*
+	 * Never collapse filtered and non-filtered entries.
+	 * Note this is not the same as having an extra (invisible) fmt
+	 * that corresponds to the filtered status.
+	 */
+	cmp = (int64_t)!!left->filtered - (int64_t)!!right->filtered;
+	if (cmp)
+		return cmp;
+
 	perf_hpp_list__for_each_sort_list(hpp_list, fmt) {
 		if (ignore_dynamic && perf_hpp__is_dynamic_entry(fmt) &&
 		    !perf_hpp__defined_dynamic_entry(fmt, hists))
-- 
2.47.1.613.gc27f4b7a9f-goog

