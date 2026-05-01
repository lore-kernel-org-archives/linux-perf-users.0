Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C3740DFDB
	for <linux-perf-users@vger.kernel.org>; Fri,  1 May 2026 22:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777674867; cv=none; b=H/1rMrJxuhIRFSQvz77nw//eTyzbfHiPTkB2KszPrJhFyZVSMZuEmF92thHyVPGjROKCxST7tf2nnP0h91w7xmFG8Im3SfOa/xIN4qJkeXTjY96W3tMli91GF7FwK8kr4Dlvd0DPi6alB05GTKdimi9mc/NJsG54eUxL/0oKbpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777674867; c=relaxed/simple;
	bh=3h6Hz0LMnr0BkilddAoxtEj6HL3x3DYYBAPic6OGe/I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ih3LzTWwsz9CdKo7G5fPvuuBDoOqEJBOrnKUMskmMN7cqadU80XtmRuWMgZipHgBEJjtpV4x3GmmpfD8XtXzRDlBL0FsBKwusVum4rH2tJymqy8msRKXGInmMBICmB/YcdvrT3tOytu3/SicE38aWdsPdyFkyVOkMb50at4Bsk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=konJJm1q; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="konJJm1q"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-126e8ee6227so3836664c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 May 2026 15:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777674865; x=1778279665; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P/KZ3/j8VHeltjlky9FRqZCcTp8iehTn2ztVyPmfTek=;
        b=konJJm1qVioSuRQX/f4BdMP2Mk8bIzhPlSDmXbMvyEWbbbOVVrjVsg7ZfD82NyqbF/
         /a5j8Wmy86L9SRhw/0EoVYTVdElzDRp/C4yUQZD0iaKNLCu2QiRI4HIx7FwaXsnpWJ+W
         eL/NNt5294e5xgeJbPFeLodZTLFP+0tWIj+fQ2jBm7sbEnrRZvWO4jZIJxtfuiqwkEmb
         4Q+MAH18vY/v3GZKaD2r9pqcpOd01wY3NjY296ONPC1yUCPOOWsXWgVuzKOyatNyIt7b
         U6GMiXHV3s7SHf7WxJI/jkwvC6p71M4I8fsjlqv+V9+Vw5T9WAfDrqeNFAT8XFL8s1xG
         wOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777674865; x=1778279665;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/KZ3/j8VHeltjlky9FRqZCcTp8iehTn2ztVyPmfTek=;
        b=aJdYdBTFmUPkmkU1ugfewBV0mr6kF4uKLBi6Wls4nu1UqlG0v1rKCvDytZZQpslJfP
         QpkgfELOaqRvuIPbZqSpvYFUxaaDSoTKWxKUeSA4JjmDXDk7NbwNK4AducO2bKBAC5Fu
         3rWXzUVcqcn7myr2qCXCeDeoEHiyCZNE5/UZDl7tdmMwYx189ghyNGIrqxWDRY+kMNnt
         PYfA0DsC6xABQv0D+Y3HmkmxmNggbxtD27c3j2AOqH3jbZCkcIDn9fah2Y2s2wxckJwI
         uePXeKfDZh0tD+SO2BWovQnn+lKGyXafTFNzsWoJQvmg/PGBCOC0jKtWO7+65JoxZQas
         F5Mg==
X-Forwarded-Encrypted: i=1; AFNElJ+xABW5vtAalBnc2iePrH/81lS5svtW1x/byiMvgH9KlqU+0XpHTgfqmufGvhLGm5zSR1XVWEECJcvWEfNIbHOs@vger.kernel.org
X-Gm-Message-State: AOJu0YxcFNvS1Yk9kaBP8sRVcF6dSKKBrAY2I6zWpbqKIzwn/rNkdgDq
	+smEu5dKUEKYhbdGaI1I4M7QAZvMx8yJ8ADEDrieLyGUfx/T4Iy9lja2j2mkEBfik9I2sT43nEQ
	embiREA==
X-Received: from dlae25.prod.google.com ([2002:a05:701b:2319:b0:12d:c516:f51])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6285:b0:127:5cd6:fa45
 with SMTP id a92af1059eb24-12dfd7f46ccmr457667c88.14.1777674865205; Fri, 01
 May 2026 15:34:25 -0700 (PDT)
Date: Fri,  1 May 2026 15:33:47 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501223413.1001483-1-ctshao@google.com>
Subject: [PATCH v2] perf tools: Ensure event leader stays at head of evlist
 after sorting
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>, Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, thomas.falcon@intel.com, tmricht@linux.ibm.com, 
	linux-perf-users@vger.kernel.org
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

Tested on device lacks uncore_iio_0, and `perf test` looks good.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
v2:
  Adding missing Signed-off-by from Ian Rogers.
  Renaming variable `l` to `orig_leader`.

v1: lore.kernel.org/20260501043532.790711-1-ctshao@google.com

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

