Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BEC347FC6
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328753; cv=none; b=AyKuUT9u5Ri64PJyqMGNU+TV327OZJg3kfWompJJao7RhXo8SKfZ96BqMGCb+wUdD9YyEpmj+KkK/zcccGQJ584MpzxawaHrAXCOsWbhKBoQAxkch0N8FUgIGUFuiFxRW+0rpshSkqh4sEhsR/IJzc/szfCCC8k6alWrrVSVu38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328753; c=relaxed/simple;
	bh=xOECeydUAevHBImyehHqQIDEGR3heRJ/Ena8jgNX4vo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kN7KWXaNK6tciCGIlL98McRyWF4hChBsoS9LkDmi5oVhkz8WNDz1P5x55xa2GKGUMz/diw6PVR3/sxC9uXnAMIA1L8rm51YNKTtJKn/6wCFS+nEzqsh/H+dtUZk+Gm+Ynm9gE7gmwxcOVKkd7P1nZXP67HLtfWYaNjX064tfT7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GnXpz8ec; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GnXpz8ec"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-28a5b8b12bbso58445205ad.2
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 10:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328751; x=1761933551; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=98oLZpU0UKUZs5WlacgZXv8UPFSEP004mNHHINow/FA=;
        b=GnXpz8ecjIkB71UIuCyJiHBHs+S/hV2dXt8h6Xnl4jHWIajy7oUQ7rneOo2xzWiP4v
         iIwz7zscuSoLwGPxubrMM7WOKXUqpxmaszHccmkvNemejzLZAP3y5HhF5Ii60m9E367X
         PO7peALLj8EPzQfDOtHf0kIrSq95pCZ2Ql6YSB5cdlLyJ6XgZEBBqeQIbIy3cZ8H7AYR
         w7wdtupUolfdiAX5cM1eZknFyjTEWGzmsjd/0zoUKyDdtyv2OXE5DncNPjFa1y7WQ63Y
         mzBfSSAfnkA+lJTESTl36I20S9oEjZZEjp3/kjE5WqgzOdCTnuSDbyeputrbod3GIGtJ
         CyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328751; x=1761933551;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98oLZpU0UKUZs5WlacgZXv8UPFSEP004mNHHINow/FA=;
        b=IyVsgFSKbGWlaFb6oFlRsEzwdXQ3kfrE0P/AzrjGbVbmla6tymgWWVpKUgIpyueb84
         8nVv1OYHAnjVkFCBlRhKDqWGTCLfaDaaie0Ld8gMu0ZMZj7uPtNRGu72vA+gpdnySOQf
         8E7xLyJQ4/CgfNShcIiOQppoC1HsgWwf9alUSDZtq6xNxC1GIXCVBnFvvSmrIak65l1R
         e+qbeAU4d9M3b47fCXTLthCSg5nHwR2kmz45SyvZsLi3g5tQdephL81YMfyLZMXKa+l1
         k7BF0BtE4E8WaXQzdYWGKDn+B/SJpv2MpwbrQ0D/kyYgtingD7bskGpwpmonAAEp9tCp
         e1bA==
X-Forwarded-Encrypted: i=1; AJvYcCUJk4Z+AS7BPYLs8/P3G4J9K91f5XM/gIo1TkQ9mvTYouww7HUw9oAFkaG6WF7ufXSQwNatCuB1ePvgxHHp456H@vger.kernel.org
X-Gm-Message-State: AOJu0YzTzMY4TTFWJUfMF2vxsP+Am1TABzuUnlWOWq5enycNOIYZ7bfV
	4zYguTUodebpQ6cYVrEGEoB5wDIRymsJXql2xiP8rjOwF+5w4t/Tvbuhf/Vdz4wPv0LoIokDmD2
	ev8Jtlb6Y9g==
X-Google-Smtp-Source: AGHT+IGURs6TgqUzd4+g7oypheTbZWq/9fAOSSxydJkcNYBtbW3Uk34LKWNJlF637subW+6jd5Zcg4J1sRSb
X-Received: from plsm23.prod.google.com ([2002:a17:902:bb97:b0:268:842a:ea02])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:18d:b0:269:b2ff:5c0e
 with SMTP id d9443c01a7336-2948ba5aac4mr43836265ad.46.1761328751064; Fri, 24
 Oct 2025 10:59:11 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:40 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-6-irogers@google.com>
Subject: [PATCH v1 05/22] perf metricgroup: Add care to picking the evsel for
 displaying a metric
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rather than using the first evsel in the matched events, try to find
the least shared non-tool evsel. The aim is to pick the first evsel
that typifies the metric within the list of metrics.

This addresses an issue where Default metric group metrics may lose
their counter value due to how the stat displaying hides counters for
default event/metric output.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 48 ++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 48936e517803..76092ee26761 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1323,6 +1323,51 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
 	return ret;
 }
 
+/* How many times will a given evsel be used in a set of metrics? */
+static int count_uses(struct list_head *metric_list, struct evsel *evsel)
+{
+	const char *metric_id = evsel__metric_id(evsel);
+	struct metric *m;
+	int uses = 0;
+
+	list_for_each_entry(m, metric_list, nd) {
+		if (hashmap__find(m->pctx->ids, metric_id, NULL))
+			uses++;
+	}
+	return uses;
+}
+
+/*
+ * Select the evsel that stat-display will use to trigger shadow/metric
+ * printing. Pick the least shared non-tool evsel, encouraging metrics to be
+ * with a hardware counter that is specific to them.
+ */
+static struct evsel *pick_display_evsel(struct list_head *metric_list,
+					struct evsel **metric_events)
+{
+	struct evsel *selected = metric_events[0];
+	size_t selected_uses;
+	bool selected_is_tool;
+
+	if (!selected)
+		return NULL;
+
+	selected_uses = count_uses(metric_list, selected);
+	selected_is_tool = evsel__is_tool(selected);
+	for (int i = 1; metric_events[i]; i++) {
+		struct evsel *candidate = metric_events[i];
+		size_t candidate_uses = count_uses(metric_list, candidate);
+
+		if ((selected_is_tool && !evsel__is_tool(candidate)) ||
+		    (candidate_uses < selected_uses)) {
+			selected = candidate;
+			selected_uses = candidate_uses;
+			selected_is_tool = evsel__is_tool(selected);
+		}
+	}
+	return selected;
+}
+
 static int parse_groups(struct evlist *perf_evlist,
 			const char *pmu, const char *str,
 			bool metric_no_group,
@@ -1430,7 +1475,8 @@ static int parse_groups(struct evlist *perf_evlist,
 			goto out;
 		}
 
-		me = metricgroup__lookup(&perf_evlist->metric_events, metric_events[0],
+		me = metricgroup__lookup(&perf_evlist->metric_events,
+					 pick_display_evsel(&metric_list, metric_events),
 					 /*create=*/true);
 
 		expr = malloc(sizeof(struct metric_expr));
-- 
2.51.1.821.gb6fe4d2222-goog

