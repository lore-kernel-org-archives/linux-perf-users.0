Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2033617A2F1
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Mar 2025 03:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742961072; cv=none; b=cFfdXH6EpvdHc53YgdMKu4eLECt8+As9DHOOdS6dn8WL9V4nVfxb5ehWbmGC4bfekg3JNs3DqYnZhdeUU9K8pd4zqn1Ir2xSnThShQq5aEbMJhINwv33J7j/4njHkN43c0U8Af87POgzcJ82gESZ5mCZ0+ZzcULZZxMbpsn266Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742961072; c=relaxed/simple;
	bh=6LrIdPRj1HxPT+PbcMIt9Tvx3WbxHdl1wI4+3h2doPs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PGrH69Sof+mWTNILmLNuHnDgXlvD13rLJiSl/FLeI/8xO+wDC/CXaPVILYCTvwQWs4gl9eUKASoZ8+SR6qdbqEH2+K1yTPrSrAGhoRHC35GfbDkDnVP/yAp6AluXSUzRcpSXf1e+go5H07BPtEY/39iwgfplxTKKc9MzzW2053M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3oSGHeT6; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3oSGHeT6"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff64898e2aso799959a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 20:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742961070; x=1743565870; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VDGbOYIOj15E+JsmdSzGj6CuNWcI9S7Zmd8zr8fj0vs=;
        b=3oSGHeT6Q3St/nECgKitBHqETjUD7jFTqgkoApGJuWI32h58cG9ViRnO9VjG0TVGmV
         urOTaar1R+cG7dGTzHaM+m+QeP8GdKag+MDSu0Q0NP0do+5dg8wnDs1rgP1dsBx5OZWP
         mOINAf+pfZ2GIu0y83Wfb9XCxCSgwukrBR+jF1Mmq9diCCEIF5Cq1VrHfwzE/V6Nuy5l
         LMWqeJgApGmLLsipIwG9nyWHYEDQHQETn8PZzVD7AUEjoGQMMwUioqUZOF4O6cRCfkvB
         1vuyWnLtdZM/XjbKogTw8XtC85WanDT8vJ4wieRt4jGWps+WTmyJBP7X9l57RlfJleow
         MzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742961070; x=1743565870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VDGbOYIOj15E+JsmdSzGj6CuNWcI9S7Zmd8zr8fj0vs=;
        b=IeuByFso1BtLGtvMySWiPLsx8de3nzfvMVyyISRthOxk+wXy8yin0yolAzi08cw8Lo
         TrFNifOChl2cnrSjmrtdchwcGn5gJL2F0QjDcanMJiGxl5foDccB4lrgsfOESknqymn0
         EHI5j+MMwPTyTGjoYBYy3uElV6xEjxsj5YYxDEzdcJUls6mNRKcs5BYrFgykLBFss6de
         OeNiBwpPM5tuXleLyXoqMiTMivWMWCz78PFD2Al1BBUshehjMb9KTRkUyZYznZBcE5w6
         r/zGKM7D2VJwRwPaQTB0yMhau2QspI06Oxlq7ndrU2tAH1W1Dk6QcmIScrer/hfFQz8E
         6INQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNLrpXjbyBeqRR2XrAY/Az9jiLeSsp6niYyti+EJ6nFoG5qFr8a7PHfofGT8nEsyzrdj7GVYerAYgHbHSk+GVK@vger.kernel.org
X-Gm-Message-State: AOJu0YxvLxfysnchKJP5dE5pAedo/6J7DFM2e2qEI16hnQ+95mXKLzkx
	93kC7U6VSDlDWmTHHhbKqYfPnHYtGPs/AYeDDJoB5uomUbZob5RcaqtPExuUtbt1rlUxFF00jPJ
	uw0wJgA==
X-Google-Smtp-Source: AGHT+IGG8kf/JIk38ELOkHk95ox9JB8hK5eqE/sVI+IvZADNpn7vVcFc/26jk3ntBtqUIe/wSk//NLgpdJV8
X-Received: from pgnn25.prod.google.com ([2002:a05:6a02:4f19:b0:af2:2c5c:55e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:32a3:b0:1ee:ba29:d8fa
 with SMTP id adf61e73a8af0-1fe9380d489mr3594205637.6.1742961070224; Tue, 25
 Mar 2025 20:51:10 -0700 (PDT)
Date: Tue, 25 Mar 2025 20:50:43 -0700
In-Reply-To: <20250326035045.129440-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250326035045.129440-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326035045.129440-3-irogers@google.com>
Subject: [PATCH v2 2/4] perf parse-events: Avoid scanning PMUs that can't
 match a wildcard
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Junhao He <hejunhao3@huawei.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

Add perf_pmus__scan_matching_wildcard that only reads sysfs for pmus
that could wildcard match. For example, if searching for the event
'inst_retired.any/period=1000000/' first 'inst_retired.any' will try
to be directly looked up as a PMU, then 'inst_retired.any' will try to
be wildcard matched against all PMUs, finally it is assumed
'inst_retired.any' is an event name and opened on all PMUs avoiding
reading PMUs that can't have such an event. However, before this patch
such a case would read all PMUs for the wildcard matching. Now if the
wildcard can't be a hwmon PMU wildcard, reading hwmon PMUs is
avoided. On my laptop this reduces 'perf stat -e inst_retired.any
true' from performing 253 openat system calls down to 234.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 26 +++++++++++----------
 tools/perf/util/pmus.c         | 42 ++++++++++++++++++++++++++++++++++
 tools/perf/util/pmus.h         |  1 +
 3 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d77af1d24985..19caf1ed9f5d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1664,18 +1664,20 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 
 	pmu = NULL;
 	/* Failed to add, try wildcard expansion of event_or_pmu as a PMU name. */
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-		if (!parse_events__filter_pmu(parse_state, pmu) &&
-		    perf_pmu__wildcard_match(pmu, event_or_pmu)) {
-			bool auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
-
-			if (!parse_events_add_pmu(parse_state, *listp, pmu,
-						  const_parsed_terms,
-						  auto_merge_stats,
-						  /*alternate_hw_config=*/PERF_COUNT_HW_MAX)) {
-				ok++;
-				parse_state->wild_card_pmus = true;
-			}
+	while ((pmu = perf_pmus__scan_matching_wildcard(pmu, event_or_pmu)) != NULL) {
+		bool auto_merge_stats;
+
+		if (parse_events__filter_pmu(parse_state, pmu))
+			continue;
+
+		auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
+
+		if (!parse_events_add_pmu(parse_state, *listp, pmu,
+					  const_parsed_terms,
+					  auto_merge_stats,
+					  /*alternate_hw_config=*/PERF_COUNT_HW_MAX)) {
+			ok++;
+			parse_state->wild_card_pmus = true;
 		}
 	}
 	if (ok)
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index f2706c395509..93d5db1c89b4 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -19,6 +19,7 @@
 #include "tool_pmu.h"
 #include "print-events.h"
 #include "strbuf.h"
+#include "string2.h"
 
 /*
  * core_pmus:  A PMU belongs to core_pmus if it's name is "cpu" or it's sysfs
@@ -385,6 +386,47 @@ struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *eve
 	return NULL;
 }
 
+struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const char *wildcard)
+{
+	bool use_core_pmus = !pmu || pmu->is_core;
+
+	if (!pmu) {
+		/*
+		 * Core PMUs, other sysfs PMUs and tool PMU can have any name or
+		 * aren't wother optimizing for.
+		 */
+		unsigned int to_read_pmus =  PERF_TOOL_PMU_TYPE_PE_CORE_MASK |
+			PERF_TOOL_PMU_TYPE_PE_OTHER_MASK |
+			PERF_TOOL_PMU_TYPE_TOOL_MASK;
+
+		/*
+		 * Hwmon PMUs have an alias from a sysfs name like hwmon0,
+		 * hwmon1, etc. or have a name of hwmon_<name>. They therefore
+		 * can only have a wildcard match if the wildcard begins with
+		 * "hwmon".
+		 */
+		if (strisglob(wildcard) ||
+		    (strlen(wildcard) >= 5 && strncmp("hwmon", wildcard, 5) == 0))
+			to_read_pmus |= PERF_TOOL_PMU_TYPE_HWMON_MASK;
+
+		pmu_read_sysfs(to_read_pmus);
+		pmu = list_prepare_entry(pmu, &core_pmus, list);
+	}
+	if (use_core_pmus) {
+		list_for_each_entry_continue(pmu, &core_pmus, list) {
+			if (perf_pmu__wildcard_match(pmu, wildcard))
+				return pmu;
+		}
+		pmu = NULL;
+		pmu = list_prepare_entry(pmu, &other_pmus, list);
+	}
+	list_for_each_entry_continue(pmu, &other_pmus, list) {
+		if (perf_pmu__wildcard_match(pmu, wildcard))
+			return pmu;
+	}
+	return NULL;
+}
+
 static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 {
 	bool use_core_pmus = !pmu || pmu->is_core;
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 213ee65306d6..2794d8c3a466 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -20,6 +20,7 @@ struct perf_pmu *perf_pmus__find_by_type(unsigned int type);
 struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *event);
+struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const char *wildcard);
 
 const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
 
-- 
2.49.0.395.g12beb8f557-goog

