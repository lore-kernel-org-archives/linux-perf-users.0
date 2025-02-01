Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3742149C57
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Feb 2025 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738395815; cv=none; b=VABI+qpZ+36jtKUVRUb5XGcxsSqz6srRYbN8bs726OxrbwfG5Nvc5cHz3dlBrPS5grNp5NdiLrMkq546RCxQzlWE2n2XTm04I/wVovoeSQ79HVKuvYuTz0WuhBpRp+z95IiM1AtkXa9gAiQzCyFRg6AMo+WCEBgiS6Ha8LWcxUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738395815; c=relaxed/simple;
	bh=nINTy0QfUSr+b+fCFJjE54GMM6PEl3mq0nlShfK8yOE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=B9g3LZSBk/3xj94buQpsL7AYwYj07gvTjGoOKo+9UUyRa3Hv0L0+Au0VPB8nWufyRg5D4vakZccOHxCjdELkLUWfojaJnm2voLPrXaw1I37TWl9FVYQHigKquwDsTpVTHtwe847o9XQQ//z6PoyN5YQo4gWjNInT1adejPybGV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bFAd3OtQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFAd3OtQ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e586f6c6289so4973988276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 31 Jan 2025 23:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738395813; x=1739000613; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=swenkO7H/Yph0FPokf8bwN7sBhS4UNKula0agE1RJYc=;
        b=bFAd3OtQjRu5ke777pZScG2ui/AcSHAMwVuczYoHfhmQbUq+NvRN/SGYZtOT5iLL6O
         5/pOl9oOUyXXQLUjoKGlfBJ4zSv5wA4jU4w5TIUY9muQStMMaD5S2ABiISrBkzYEtd6g
         maTmt1SNkkCheva6VCheqZP/rnF2PtgspDqK7G7av2Q8cbZjgg25f59se/4ZtyXHvyJB
         ZKhI9L5CwgPWp/qQ2mYFwG+R0GMcYS5NWxnBfekKmUlHw2huoB/Jq+mHtfv48urvvCTz
         Nck/wtSJmd4juvGzSp1FjmV/ntLkR538kSWdU/eKl3WWD8RJKZa6YkhBBCXOrVOPElBn
         a02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738395813; x=1739000613;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swenkO7H/Yph0FPokf8bwN7sBhS4UNKula0agE1RJYc=;
        b=gP+ReYIhrfKjVUvpQ2gc4xky+sSWfa1oBSLYtt1SP6/ho9+ko7mHk2xvSXv+ejpQ2z
         W7apdoF/E7CDozQQqdpk2/QTyz8fKV9Kga4tsyMmyo6kYfrkXk2oDciYtATxK12HHE+s
         eWL8jbj7P/pNl0gF+zDPSjIfx7OLH+CJiwj9iS1lzLjCN1FlyN0qKUmtJhH5G70vpQxW
         ny+1smhuPAnLT5RnhnWEz/1cQew2z48+u9f4IDPBAYAMQLR3r5+8z4hw+D//zLNRwW0x
         uRatu80PpE5DJrpZAJAUNylhiwmtJBi5J/T750/rVv8uqKKjmk0TxbdZ6+SCaP/WF42h
         zOgw==
X-Forwarded-Encrypted: i=1; AJvYcCX4N8QO5Z/fr1Y8VNoESrh9tcc8BIBfI8ZFkyFCn9kONEw04cBUSoYzRx9I6J0oPNG/+wTIDiLjg4FGb+ITwj3q@vger.kernel.org
X-Gm-Message-State: AOJu0YzNObNrahCWm6HVMbuJcb9WB8ungEOzExAJ+n3QXwRSesFOlo1n
	4eGdjnTlhbXbCr8yVRUeX2sMhfReWQAcoz4qCjAgkKnzk/68nQ4j3uIDL+kxfY4w2EhDXECnwtT
	EQdA1ag==
X-Google-Smtp-Source: AGHT+IEq+tO7zJipQm5Z26Jz+fi2wwX96nVVAs05Gk0Pe17ZuwMM7ddACnQ2qCjVugZ7pikFUIaAWZedM1s9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:de26:87db:e4d0:62b6])
 (user=irogers job=sendgmr) by 2002:a25:b103:0:b0:e58:98ba:77a8 with SMTP id
 3f1490d57ef6-e58a4be579fmr31848276.6.1738395812929; Fri, 31 Jan 2025 23:43:32
 -0800 (PST)
Date: Fri, 31 Jan 2025 23:43:19 -0800
In-Reply-To: <20250201074320.746259-1-irogers@google.com>
Message-Id: <20250201074320.746259-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201074320.746259-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Subject: [PATCH v3 4/5] perf stat: Don't merge counters purely on name
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
index 7c2ccdcc3fdb..1f7abd8754c7 100644
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
+	return perf_pmu__name_no_suffix_match(evsel_a->pmu, evsel_b->pmu->name);
 }
 
 static void evsel__merge_aliases(struct evsel *evsel)
-- 
2.48.1.362.g079036d154-goog

