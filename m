Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8DC54654
	for <linux-perf-users@vger.kernel.org>; Tue,  5 May 2026 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778016059; cv=none; b=rG1o4zyTLqxgBBDe8X/Z+5VOT54VZY0hU5h/06LlV4m/OSU24BMJMzd6wljOXlOjTKlOLbtPmo9l1BgdskqbVeoMC/hzuGlTYK7qiT5LfPEiqLRkabHV4ZT9lDheTI1V4RgFhZgXLg20E0b2rbeQ+BPrj2US4maAzD1ZZbEmoLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778016059; c=relaxed/simple;
	bh=d5Of11+55O6Fqy/aE6U5IITFEFsMWVZvzZsA9FBfaDc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hnS4VMvJ6+5M3/9FB2kWbSwbncGiFSaDJF2Hf8bVKIBl5s3HO0u/M3O8rFo/iCx8rB/7DVv8V5gWHP+1cYyrZHQNhVFjJeMjHOVmW5yv/5de0QZBDeMk/04GlIeVcrF7STQkrKylQ+FNYs5IOwNohCSGOCE2ecQAC/K21QP1D4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KM1CJHAr; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KM1CJHAr"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c8ccc7593so7379961c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 05 May 2026 14:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778016058; x=1778620858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5A9IEHvBeBYnONRUgAiif7JcNDoW2hLKpQtkAXRwhaw=;
        b=KM1CJHAr7a6lRNvNpCq4Jdg5DA+w9F7AQj3701QrZEMBGVFsIAY8XYxdEeDOvLOur5
         /5NaHIeOg1Lih3wIrFHZnCyH4NN4KsDiRxOPhOmi9UGrUZN3BBgnzLq2kC1fik/LIW/a
         Vpi6K5R4bq2DLAURaBluwp/WYfjbb6u+cZyh6staLHaIYa/95PncjZyjedP6Ne04OSMQ
         +AUQA0lJFe6y/evOuhj4aPTtoxYu5lKgXAu9uZrTMCnMqktZ+Tk/C5I/M7/ZR/tH9PqH
         bV+CwcyTys6wYI0Pk4pC5IyUA4aSjwZuNmMXVNmtVG+4Z5/y7Dka/UOoWK4Il8zmF3NV
         zIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778016058; x=1778620858;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5A9IEHvBeBYnONRUgAiif7JcNDoW2hLKpQtkAXRwhaw=;
        b=eXkTJOGMViZ5js6UON8eD+WG9VDngMh/MEqH/MdeQcrIGXNAM3VT1iiMY4KDZOQti8
         wDoIf3tOj8BVY3GLL6ykNyub5KrZq55cSsrU03tjRRVBap0gh60jrIUDn8GJlQVHA3tv
         TaIzHGXrxsOeUm3vdWs9JiLOfZ4gKzYdSXf35fFDA0eS8ypHN9ckTWE00+Q4k0mI5U1f
         kWi/C5e3N56lyAdTl7NDXQlz/V+vMTs/sLifgTXzhobF6zhSkLC549gYZHzVjVsTSrVO
         DVFcPKUBf5+XfGaROUF8OJhGLreKZX1GWIjoQ+rRFNmsXjsH48inuPDNmTOJ9h3V+9OT
         SV/g==
X-Forwarded-Encrypted: i=1; AFNElJ/QSCWTa7JUPbkPvWpdUa6uzn7KfD/9u36v29drynjYfjmHSrMFS6ryimeTkBOjtBwE5IlrHQc5wTEdJ0vMMkSP@vger.kernel.org
X-Gm-Message-State: AOJu0YwLsYxu36SLj8aVCpJ3cDZ0yZ6gH/OIGf5Z1puExwEisKDyjp7I
	Gun96MKXmGUWsQzCSMlcrNlOtFstqhZfJNRq9F8Xv4G/yGpeDJP+dSwDaV3Uco2tLEuCLkf1Sg6
	Lb0og3w==
X-Received: from dlbpv3.prod.google.com ([2002:a05:7023:903:b0:12c:9097:2891])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2222:b0:128:d219:e169
 with SMTP id a92af1059eb24-131853dc968mr524516c88.10.1778016057368; Tue, 05
 May 2026 14:20:57 -0700 (PDT)
Date: Tue,  5 May 2026 14:19:00 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505211924.1961056-2-ctshao@google.com>
Subject: [RESEND PATCH v2] perf tools: Ensure event leader stays at head of
 evlist after sorting
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
index 1497e1f2a08c..943569e82b82 100644
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
+		struct evsel *orig_leader = pos->first_wildcard_match;
+
+		if (!orig_leader)
+			continue;
+
+		if (orig_leader->first_wildcard_match) {
+			/* Original leader was redirected to a new leader */
+			pos->first_wildcard_match = orig_leader->first_wildcard_match;
+		} else if (pos->core.idx < orig_leader->core.idx) {
+			/*
+			 * We are earlier than the original leader in sorted order,
+			 * and no earlier alias has claimed leadership yet.
+			 */
+			orig_leader->first_wildcard_match = pos;
+			pos->first_wildcard_match = NULL;
+		}
+	}
+
 	list_for_each_entry(pos, list, core.node) {
 		struct evsel *pos_leader = evsel__leader(pos);

--
2.54.0.545.g6539524ca2-goog

