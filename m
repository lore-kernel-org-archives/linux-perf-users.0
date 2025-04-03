Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5F11F460A
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Apr 2025 20:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743711894; cv=none; b=pYWMX7ftdbevw9Wg+gCTZGFMTmra5+MpKDR56Ns6pHjZqWiay2AiObW6OJPAnaB4V1OVSocaKFBBL32/2SDhRlyqqTsj+TMdeFcTcfkb3jOSMIOwdWSNfOZmkNeoKB2kual/fe3MNLiqgdUGWHwCYnTWlQEkSV+V3wCH4ZxVZ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743711894; c=relaxed/simple;
	bh=90KggfginsQzDP95X+k629D/YxTbuK86i9pbsXIr3+g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N9JBkRWMv8VTy4V94hDnMU2QtqNyl6XisgsFPpn13fjckx54FG22qNKkLHK0xU80ROzDq6WTQcGD8BTUKh5ulbJYoCKImodNcMue2BBlcjN8K9b3lkgKQqKPK/z9OSENXavBWlCPGEMJ1wrmRWsL7GZQIoUXr/A13LfMX68cOs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1W7TrG0h; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1W7TrG0h"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af8f28f85a7so894038a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Apr 2025 13:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743711892; x=1744316692; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tilk3aFHymzdwH/49hi2NVgSsKIEgE1zvVteMHXS+8s=;
        b=1W7TrG0h2Ybjmbv94SZ9gSNLTeJLlOKtUKpm9w+Luj5BLFNpi54oITOSqXZtqEUxlI
         RoWjM++Y7OiqVcRVQLXyeABQrDc9ECgKZCLLw+EQtrbLXlBa4BMhSe4JEFRfHY8MA/xE
         JFFo7TeWV99Z6FQItNNWm8lHB/cCNKDXsGP+f/Pw1f021YDvvTl1k/sE9FTdHbCQHGDc
         CGoxIA+YQ8DzGqRq77qFO3CDTLKqMSCSao/nE+hkolbydgEU8Z5EpKj1L6aeVJzkEZuV
         qshUivyCPBL7JmaiRne9yF+iU1xqYNVDC4awwyKZcDHpGd2/Xqsy7ESlKGCZ3g28x4Ed
         Iz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743711892; x=1744316692;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tilk3aFHymzdwH/49hi2NVgSsKIEgE1zvVteMHXS+8s=;
        b=wTg1gLQqini4AJeI2VrHgFuonRwfdsO1Ti1/5TFZhi70RbeSZYiWCAUpJ/oXc9qYoi
         EaeZgqz7N/i/45X0Maaa54EXaRKAeU7/FYM5kNroLQoTNzel1DaDuZ21Dhnh9kMXeXph
         wqP+XTTijabsaV1W0qLk6w+lVkldsrZlsV2FbzVyiYEIhrsrDNDtV3UMyO5WF0ZXwjfS
         jESBm7ktj7XHcp1cv+rn5SZxSwPp2K8vN83BXsuArF3AST6AQhwWmtGHlH/saHLnzocB
         ILuOr2mruOxEkXhHMCSlbTyk82FYTTzqwtm9OEwFtidiT3wjc5YO8KgxteAU9kXIa6jI
         ewGA==
X-Forwarded-Encrypted: i=1; AJvYcCVWyU90g+HJZDXPsDbH5mLf8H07Ej/Nt1A22HxOCqpbGZo5hdZI61n2pb2kyN++AkyH/re8z3paRiUnrKwIAgwS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4pVIEL87SnqvOVoXjrcrrHnYrNVjjtyHod43cFsWm4B9f8q8+
	aSafHuZ6lxPl4h+4h9sJD99VjVSy7eDNTtnPtOE/Zts4L8qxPQZmqMJpYVTpsKFc3QnOJFFOW0B
	dxFSM2A==
X-Google-Smtp-Source: AGHT+IEryC+x1Td+fTmPyBksTzhsJltkWaZNz7ZcV3ft48rRChAcFSC8nQC73Hy3G/qeYPy+qRrlXc4bl5d8
X-Received: from pjbqn7.prod.google.com ([2002:a17:90b:3d47:b0:2ff:5f6a:835c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:514e:b0:304:ec28:4437
 with SMTP id 98e67ed59e1d1-306a4b70e72mr996487a91.22.1743711892605; Thu, 03
 Apr 2025 13:24:52 -0700 (PDT)
Date: Thu,  3 Apr 2025 13:24:37 -0700
In-Reply-To: <20250403202439.57791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250403202439.57791-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250403202439.57791-3-irogers@google.com>
Subject: [PATCH v3 2/4] perf parse-events: Avoid scanning PMUs that can't
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
2.49.0.504.g3bcea36a83-goog

