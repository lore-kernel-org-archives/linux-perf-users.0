Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138B817B50A
	for <linux-perf-users@vger.kernel.org>; Fri,  1 May 2026 04:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777610138; cv=none; b=ZoGCQjVjWkcTxPmzEa0UahUgjbv2AZNUB1pAM6ykjRoxjemf7hb7BiheEsV3L0CFhtnbXgdHusoPPwp8FuwwLLWmAR26rDiYL59/dykfqyzfvubvrQ/WwKpm0orbexPx1ZZg/dG9SmGWb08T1q+/gDWCToNsJhVfYMLAI0Z9ifY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777610138; c=relaxed/simple;
	bh=QCF1s0vzfRnvOOTrrd+W2vEbnTgZI6lht20oQkg9jFg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q1FUf6LSX33kEj7x4enCLI8JAIRO2bz9f4JI0QXs5+NXQWguLTrcujsSonuo/y7FWKazioreIHqcbK1uD7m/PIVgm2LAPGwZ6azmZiaiLFp375AtgP+0I74FnOtnc+AH8Gz677Y1tDiE5mZDUjQHnBR4gVN6JjKESHEKD1Ok9kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b4SkOY1s; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b4SkOY1s"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d93379001eso5555026eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2026 21:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777610136; x=1778214936; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MhzqpKuDaXzIRPNG46Q0i4WTIh65OOq2fEQ6uOXn0ro=;
        b=b4SkOY1sSr3ixmISIEAC8TRZ0cuZzlDeQyNso8vmDFz1jWzg2B4h0OxpvwsqSwiVRN
         oKAkeydsSKzFLRSm/1BjBmrad5cV8a2U6MrZtYqzFKZ7q/a51eUPHvF2nSNf1zq+mXup
         F59+BvL5HcrkTMy746BR6kj3NfQDUTmgIrdn9F1RIwDY7p2POXBJ9Iyi5I3RrP1ni1k0
         hA/Yye1c5j1CFuq9KkoCX5CsunEOFtKLYIfwadlsccXzywLtWEtT3GUqki1K/2NbgRQt
         c8MU8USt7/SLoPn8PDjsuWIjm/Aou+lpr0pm8KQatdu5jDRaWM59ejStTWqyt3aCAo0F
         Rpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777610136; x=1778214936;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MhzqpKuDaXzIRPNG46Q0i4WTIh65OOq2fEQ6uOXn0ro=;
        b=EYaqpNYhm0zcK+cOTgjPqPkPfTYm8BRx7q8KMfh6PINJnzeEd5LqEannBkwR6ILwB/
         wsOTj/sLsg4aMlenDn0NYaKJBkvDSQf2f+ll1CbaK6fAIMt/P8OEtRClwFKtoJ5fV4yl
         rTcxWCbGuOqzSGJgB7Gh8OjyTPgRNu0McOpCY5OKtFKSZIamm+w0o+gUP6ZNzD9FGAfY
         IeXo+o4BTLYh4CZdA/1zveS+VVViMLDP8fKk24eGR9grgCCgUu+9CGZaeHue5Ej4+jXG
         ioJdzBIVWwzXmvxT94QIEgiETfxG287vgLVeOVEptIFWZZNswPvc65yskFWMsOiUqf2+
         S4rg==
X-Forwarded-Encrypted: i=1; AFNElJ+es64LXLQ4YrdYaQk04KEohIKqpubJtJx1fkHxPri1YUdGpELatyfYnKOzPGdMxepTSLZYBXKae3TiTRPF8ZId@vger.kernel.org
X-Gm-Message-State: AOJu0YwFCgzJlriSiE/W3Oxa4Fa8Q6CPxEhLFvcYM6StdbPo9agFX0WO
	p2+y7TRDE3Iff5jIb+mscMRmA7EeaZfUgnjeXGwGz3pEP65fFm8H5D8bVjLoig5pPDnNYvcFUnV
	eBKTypw==
X-Received: from dybmb9.prod.google.com ([2002:a05:7301:1909:b0:2dd:3fe1:f5b2])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6009:b0:2e7:af57:3b72
 with SMTP id 5a478bee46e88-2ed3fe5add0mr2905149eec.29.1777610135968; Thu, 30
 Apr 2026 21:35:35 -0700 (PDT)
Date: Thu, 30 Apr 2026 21:35:10 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501043532.790711-1-ctshao@google.com>
Subject: [PATCH] perf tools: Ensure event leader stays at head of evlist after sorting
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, thomas.falcon@intel.com, 
	tmricht@linux.ibm.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ian Rogers <irogers@google.com>

For evlist of a certain event/metric, the HEAD should be the event
leader. In some scenarios where uncore_xxx_0 does not exist, the event
leader is not the first element after sorting. For example, on my test
machine uncore_iio_0 does not exist, the event leader is uncore_iio_2.

However, in `evlist__cmp`, it was reordered based on the PMU name, which
makes uncore_iio_1 the HEAD of evlist, breaking the following merge
logic in `evsel__merge_aliases`.

The patch adds a loop at the end of
`parse_events__sort_events_and_fix_groups` to make sure the first
wildcard match is the earliest entry in the list, updating pointers
accordingly without breaking reordering detection.

Tested on DUT lacks uncore_iio_0, and `perf test` looks good.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/util/parse-events.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 1497e1f2a08c..be825617321d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2251,6 +2251,33 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 		}
 		last_event_was_forced_leader = (force_grouped_leader == pos);
 	}
+
+	/*
+	 * Make sure the first wildcard match is the earliest entry in the list.
+	 * Since list_sort might have reordered the aliases, the original leader
+	 * might not be at the head of the list anymore. We find the first
+	 * alias in the sorted list and make it the new leader, and redirect
+	 * all other aliases to it.
+	 */
+	list_for_each_entry(pos, list, core.node) {
+		struct evsel *l = pos->first_wildcard_match;
+
+		if (!l)
+			continue;
+
+		if (l->first_wildcard_match) {
+			/* Original leader was redirected to a new leader */
+			pos->first_wildcard_match = l->first_wildcard_match;
+		} else if (pos->core.idx < l->core.idx) {
+			/*
+			 * We are earlier than the original leader in sorted order,
+			 * and no earlier alias has claimed leadership yet.
+			 */
+			l->first_wildcard_match = pos;
+			pos->first_wildcard_match = NULL;
+		}
+	}
+
 	list_for_each_entry(pos, list, core.node) {
 		struct evsel *pos_leader = evsel__leader(pos);
 
-- 
2.54.0.545.g6539524ca2-goog

