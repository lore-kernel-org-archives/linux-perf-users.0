Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4DE2397A4
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736775276; cv=none; b=C1z1ijPpOkkqsOenrT7AZz8AjYhCgEEf5azzH1zTwrND+WsrLTAei9ELXY0fAngvmM5G+/VfIAVLSfHO1E2L4tvxoJPF4fN5J76FGDBCX7rg9A/YlNRAmeClpYWyJLrPjeh/PBPMrrV4a5fY1//BbYGnof3ctyGBJp0hUoe/hUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736775276; c=relaxed/simple;
	bh=7gV7/AjZhR4oNdmkT1caH3sXe1Th6RrUpFuR2/TcAuw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bd03mtK4iJ4e4d9RZCSMZ+5V5byS/TFineSTuVkBJDOleO1f/fIqaLnQlxYau5PEXVDlkwIH0Lga5V8/8MzgKqf6ePDrQoUIgXdIPKOuucQ8IOHdo8NV5oecssDMDYs6jMhnR8+YmbAvBin4ES9sOnIj+9L6TB3YJtutMyo7SOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H0Wdb4Ud; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H0Wdb4Ud"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d3bf8874dbso4992725a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 05:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736775273; x=1737380073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZa2MaW4jzuKJbVSAfNH0UTGTojW0iro8mrBbBxAobg=;
        b=H0Wdb4UdzqiXp2tIDFwuDS2YVjo8oBAjYYUJBNyMKaDP5Ko7kWZMpU/vNJBbDvRqf+
         aOd7brBjAcjmQZEBGl+z3Bp4ZvVidiW39GyTbacZXsgNF7RS8VI8uNZpHDG/kQ5csdyV
         SHoKj8NvpRA49TD0+c1Sht4c1hYbDXpTONYgLHtksD8ucKIKftCkHUUoeAylK/mLNvcE
         CBIh0dNTbXtta5HVqy6EXbEvB2seeyAKl5nY7nYq1Pd9++7m++kYIJVOgPK4/cWYMBYY
         P+0W89UoI9jyvWa6r7N9Q2FxRB6coOnfIKZBGCs6FqGc8ZUr6djnuAhMJWr0OSQzmW7t
         A6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736775273; x=1737380073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZa2MaW4jzuKJbVSAfNH0UTGTojW0iro8mrBbBxAobg=;
        b=ZQQWAyiwsa/zvPrHoJm0OTjHQlb5+RQcQuN7y6JC/U5wXhb4cpGIiOmddy4kJ2oUaI
         Krp3O5lsvfu9RsYoxKzQA0BoTUEhf96ApsD54C0Jr5DG0vgn56zZs/WE8ps8yJRL3Xq1
         HfIKStfMpOVAi62VCA1B89cKDqeH6PYxMGw73R05Mfk1CyZU53CfPmz0RG33u6wfDAUM
         woX9pPan4GKWr6Tv2HOEHvcG8h7PxYwpEjhZGEUbNHM18UWt90w2PrGrpigNxTV1zbH5
         jpy1zVQRwhVtVjYht7oZZCqJEyZ7cckH64KZX600ZhcfpSQ077vy2hdG1hBngt33o9ad
         YdtQ==
X-Gm-Message-State: AOJu0Yyz3SibTfwc5WSedt+yO1IE8gvIb1T/L1T5PBSxZGqjeX0TSKX+
	tVn9bBEV3tdFsVnRIAgNY2noHqUx71N35aD0Ou0hrsvWJAsO+eN+kjjADTjT21T5+8r0hjqn2W0
	KpaEiXg==
X-Google-Smtp-Source: AGHT+IFVht/UEyxYFjfRoTDHqqRe1oLmlegCbDObLyVH7Igsz1KTWk/zmuvj5HXwsyKCn/blhUx4L1IWweXB
X-Received: from edvr17.prod.google.com ([2002:a05:6402:191:b0:5d8:7f7:ea43])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:4305:b0:5d3:bc1d:e56b
 with SMTP id 4fb4d7f45d1cf-5d972e1a3camr19610020a12.16.1736775272987; Mon, 13
 Jan 2025 05:34:32 -0800 (PST)
Date: Mon, 13 Jan 2025 14:34:15 +0100
In-Reply-To: <cover.1736775109.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1736775109.git.dvyukov@google.com>
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <8f5f7bcd5647168aeb786119d21d954e5f8027db.1736775109.git.dvyukov@google.com>
Subject: [PATCH v2 2/2] perf hist: Fix bogus profiles when filters are enabled
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
index a4b8ec3805565..4d82882a020f6 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1302,9 +1302,18 @@ hist_entry__cmp_impl(struct perf_hpp_list *hpp_list, struct hist_entry *left,
 {
 	struct hists *hists = left->hists;
 	struct perf_hpp_fmt *fmt;
-	int64_t cmp = 0;
+	int64_t cmp;
 	perf_hpp_fmt_cmp_t fn;
 
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
2.47.1.688.g23fc6f90ad-goog

