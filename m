Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B9D222584
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896424; cv=none; b=n5gE+b6/Vw3duEtiBU0QmKJTTUBmk2M0W+il4l4BinIzzK9sovykGwVDMNTnnVU3sUMeD7MGLg49POw/iUza1gnvlOe7IwKly+9+4B0DW7cloSp5xOyMwgx8rX4g6EtCg2yryeUJCg0lBrvHIpl3KUnECmCrAC3EFD2XQZXku6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896424; c=relaxed/simple;
	bh=TK5jsPUddoVqcWXgIyzdTH/6UP97uh46LEr347Po1cA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jGjaVgBJVtnppLrFkJwR+XPtxIo4s1+i6iKL4so2YoKS1oQmOASLDwcB5o0rY/z5vGOJgURBIvBeJ1jNgVzb3aiXV0SlwrYZE5PpGcdwG4rnOOgL8LEqypwXbZQ+ZWoSVxQ5tmrh/SmMjWTStGQFast12+4K8kddvGsJpWXOk9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ER2/FXL; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ER2/FXL"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e53bf9e60e4so14743749276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 15:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736896422; x=1737501222; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N1xjM3wphMNYu1Ks6TVH7fA4hJ036I4dNmv6CTOW45Q=;
        b=1ER2/FXL/7UCxzaN40Ds9MA0VVhLmxOF9U3yhHXxo9UVSLwzb9CGOvoTMJXeqT0/69
         XE8bIYFcAkVewOnOn1U8QV0k3l9lttW4VeN6SkULz854PJ0GDJWN9jT4tE2g49W5/ryx
         84JRrNtX6ozGWiF6uW1pINvxN/YQVU1gt+4+FZFb9I3iTreq4NKzycEy25d4NbhvBgR5
         GJJKyJq3jIqhBn9mHcPfBfARQVIApC2Y/RI+QJgwucbHYze/aha84EjIz1wpxGpGiyYC
         9X/RDG3wXN/RUWXuUjFiQzgQW4f6sAysfMIQZvJhL6XZeItw/JyQYNii65ZhabO/YLFr
         QAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736896422; x=1737501222;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1xjM3wphMNYu1Ks6TVH7fA4hJ036I4dNmv6CTOW45Q=;
        b=KFxnqXb7REnlbERxfSaVNs2BMOz7MCwcEGC2u12SdEIzYi+nd9hl6ScaGi3/Bnzxe3
         O7tZtNkFSv+zL91N8SQoG7hwljzn/FF6ClONeC3r1UyUiqxMFpqLI3azxD6iq+BxVxNr
         PORPC5ny2BeRM4aY7O50Mi3INioWg/axfyEMP9oGsWjOcvqN5RF1bOhcYigLXDodQfmo
         JYclJ4Pdsy5r5On53KpLQKSVkBHREaKHZlaTaB4+i+29gT6f5RP6qf9KqnrvNSrjggmO
         7TN3nZsvAketvb6QQg+SRQRLWih1IfBpnEE3GCN4lnVyA3jlONHVePbss/KwxSGnIRNA
         5hhg==
X-Forwarded-Encrypted: i=1; AJvYcCXt5BdTXDOzfBwr4aTOjsT5LIXLtlL17dBmEkRVHbwG3apQcMsqH9XA1qoYmXBvfSwRE8la4xfhB4UUPI//xHmm@vger.kernel.org
X-Gm-Message-State: AOJu0YyqsbdFjGE31cX3FWAnH70eOqm3jY2jsuhPHLJWcbIQZuZbDnS1
	JrAI5YJYuyZ6e1/zGAKQ4GPtPYlrrd8k5X0eo/U+N/6MPWp9eXd68BXztYCPmhed/aK56yfuoYZ
	vOz9ngg==
X-Google-Smtp-Source: AGHT+IE6vfJevlH8r7yu7Dpu1i9qXKvuoPLqRHx5pq+3+JCv3a3eukT2BmKSixvpexe5/MBkmW1GzX281wQl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:b3e8:96da:3fa1:5494])
 (user=irogers job=sendgmr) by 2002:a25:c7d4:0:b0:e57:3e87:8c17 with SMTP id
 3f1490d57ef6-e573e878d01mr27597276.5.1736896422209; Tue, 14 Jan 2025 15:13:42
 -0800 (PST)
Date: Tue, 14 Jan 2025 15:13:31 -0800
In-Reply-To: <20250114231332.13419-1-irogers@google.com>
Message-Id: <20250114231332.13419-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250114231332.13419-1-irogers@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Subject: [PATCH v1 3/4] perf stat: Don't merge counters purely on name
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Counter merging was added in commit 942c5593393d ("perf stat: Add
perf_stat_merge_counters()"), however, it merges events with the same
name on different PMUs regardless of whether the different PMUs are
actually of the same type (ie they differ only in the suffix on the
PMU). For hwmon events there may be a temp1 event on every PMU, but
the PMU names are all unique and don't differ just by a suffix. The
merging is over eager and will merge all the hwmon counters together
meaning an aggregated and very large temp1 value is shown. The same
would be true for say cache events and memory controller events where
the PMUs differ but the event names are the same.

Fix the problem by correctly saying two PMUs alias when they differ
only by suffix.

Note, there is an overlap with evsel's merged_stat with aggregation
and the evsel's metric_leader where aggregation happens for metrics.

Fixes: 942c5593393d ("perf stat: Add perf_stat_merge_counters()")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 7c2ccdcc3fdb..cfdb6d55df9b 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -535,7 +535,10 @@ static int evsel__merge_aggr_counters(struct evsel *evsel, struct evsel *alias)
 
 	return 0;
 }
-/* events should have the same name, scale, unit, cgroup but on different PMUs */
+/*
+ * Events should have the same name, scale, unit, cgroup but on different core
+ * PMUs or on different but matching uncore PMUs.
+ */
 static bool evsel__is_alias(struct evsel *evsel_a, struct evsel *evsel_b)
 {
 	if (strcmp(evsel__name(evsel_a), evsel__name(evsel_b)))
@@ -553,7 +556,13 @@ static bool evsel__is_alias(struct evsel *evsel_a, struct evsel *evsel_b)
 	if (evsel__is_clock(evsel_a) != evsel__is_clock(evsel_b))
 		return false;
 
-	return evsel_a->pmu != evsel_b->pmu;
+	if (evsel_a->pmu == evsel_b->pmu || evsel_a->pmu == NULL || evsel_b->pmu == NULL)
+		return false;
+
+	if (evsel_a->pmu->is_core)
+		return evsel_b->pmu->is_core;
+
+	return pmu__name_match(evsel_a->pmu, evsel_b->pmu->name);
 }
 
 static void evsel__merge_aliases(struct evsel *evsel)
-- 
2.48.0.rc2.279.g1de40edade-goog

