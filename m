Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606596;
	b=tA+XVqgDmelLnD8yhRTebFuXvGEGWAlYYpi4nXdGH5FMKkBNooMjQ/1+sPA7GGzOR7YT
	 YQhpMgUC1fbK1hYXgWC76nsasFBukHLJOspG2962aYu11GCx6hw6UJznDATbMLQIky1zT
	 hy/OTvwFMXsWO6fPUkghZsMihtJFSkUbTyT2PGgS++uf1rcITLhMaC6GQdx0xXJGMYgpP
	 kSf/VObtoTPqbECIWmpaeAWBzWU5Ec1m+6YsrVrFRN7UxcGNjQkj8/7kckwIkLrwhi1l8
	 Sru6+/0WW/R+mlglFIHi2Z+zF3SWQT1U1v/Hyn6ZVtB+FePU8hJ59ThMESdgp1LN06w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=nLD4qM4XG/rpfCJk3ZgOR1EzhcLkauvaS8Vzarvb5p0=;
	b=V897LaQzt75CSmggcGLinJcFVGJAAeAiL6olaWJGphxWF3h/WSFssU/onHaHR3OELu2c
	 c0dVCivwNLQ6uT9DYnNfPMz9+Z/8/pLEIb7K3EEQT6QnigXBahAJ8pk/7Crps7EYCI5LT
	 xbzhqPoUE5vZQ69BXNuhzNozwLHg74JCaQTDWCV+4m1vKsd5QP0On5dWiPsD1ZTOmPPVE
	 Zymy0k+DOxCv/NQCKD2B8H4BGsD4DW/SuNmGQ+sVTgvBLcG7DiMGgtBPZiHYLUkS9MbiR
	 x0hvr9YKW+G+v9+AIMqn1De/QMwPCgIaAU+/dtfIzGi9DUTmz428poxZE32Nc6a8YkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X76nw+Tj;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0D860A6F6A
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B0D860A6F6A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X76nw+Tj
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33713e5e6daso1335808eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606594; x=1795211394; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nLD4qM4XG/rpfCJk3ZgOR1EzhcLkauvaS8Vzarvb5p0=;
        b=X76nw+TjPX73aU2/NHU1UN4ANQmvMvqQl76HW4Mg5LrX8cR+X1M1iHFh+GfDrTT4Zq
         lQ/SV8MCm8Yy4zhq43Ham5bB/gsk2ybw8As5jvfOQUyN1WMTRxgAUWfPXTyRmy5bPxso
         lYG2hzQDC7dSfOjfMImV9LK8sD+WP74grH5eSXCf+81s1DtVgxPoxMz5lBKKdF+tnxG4
         s4YcK0UI2OFagaC3P0M0pugasgodCh1P4oQORuimc0E2boImmZf9pxOinCkwALq9bTRw
         BkYxWeRbXPHK0RxQIvSbeLs3JKfqIuRM0ipKk6XSG/QRvj2JoC4xGW0mFNfPdP6vkLHx
         LAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606594; x=1795211394;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nLD4qM4XG/rpfCJk3ZgOR1EzhcLkauvaS8Vzarvb5p0=;
        b=CZbRBHHJ/4J+/w6ZCdnhlOL9fQmcQikJyr4n7JbxbLbDgQ6tgt3yjk2YwPx2nQuJ09
         EC3cNA5lwmo3SN6BKowqTf8yades/WCjdfbTnZULKy7Wyl/8zYCqc3akTSXHxk0LqbBw
         9ZctlBPHT59CQDwor5LvR1K2bHUZR62UlfDNEFmvsWKj9vkv1r+lrrZmjuZ9NkHchO9G
         r0RY+PrRQVKSb/sDn8FPE+eDSblcKn9Rx4yL3+AE77l29E98oUCcYaHSF9zeNU5fX+yo
         BsEWKhZdByTEVeQU2Ufgz0JFrKo3IA87VlRdpHINcwvmOlg8mmUa6UYVRY1uzmi5qZIn
         Bntg==
X-Forwarded-Encrypted: i=1; AL+hErFR2aZTdXhmq8qOs7kzqiCUm6NI8x/MB6TE1dOWKOSCkfH+tDZp2bPQsnYHZt1IX5wkkaJ4wqUuSUH3b+fPo9L1@vger.kernel.org
X-Gm-Message-State: APuU4Z81TvYqljlcrloJFsTLTqeJYsmFXkpUrqF26jOn8ouk7mNO+cgF
	kC7mim+tSueidxJ5nD7FmxsCyWiQwZjbZt6KF63cgVJXXIfj8czvzS9AHnFz6RmfQTea2xTsLc2
	calv6tei3Qg==
X-Received: from dyclv15-n2.prod.google.com ([2002:a05:7301:618f:20b0:368:2c6d:de10])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d40b:b0:376:b957:c08
 with SMTP id 5a478bee46e88-37966c489d6mr3671047eec.9.1794606593930; Fri, 13
 Nov 2026 13:49:53 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:40 -0800
In-Reply-To: <20261113214850.3329699-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113214850.3329699-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113214850.3329699-17-irogers@google.com>
Subject: [PATCH v1 16/26] perf pmu: Use generic hashmap for pmu aliases
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Convert perf_pmu::aliases in util/pmu.{c,h} to
DECLARE_HASHMAP(pmu_aliases_map, const char *, struct perf_pmu_alias *)
and replace hashmap__for_each_entry() loops with hashmap__for_each().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 30 ++++++++++++++----------------
 tools/perf/util/pmu.h |  7 +++++--
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index a63fa0d9cfa5..cabc14260719 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -425,16 +425,16 @@ static void perf_pmu_free_alias(struct perf_pmu_alias *alias)
 
 static void perf_pmu__del_aliases(struct perf_pmu *pmu)
 {
-	struct hashmap_entry *entry;
-	size_t bkt;
+	const char *key;
+	struct perf_pmu_alias *val;
 
 	if (!pmu->aliases)
 		return;
 
-	hashmap__for_each_entry(pmu->aliases, entry, bkt)
-		perf_pmu_free_alias(entry->pvalue);
+	hashmap__for_each(pmu->aliases, key, val)
+		perf_pmu_free_alias(val);
 
-	hashmap__free(pmu->aliases);
+	pmu_aliases_map__free(pmu->aliases);
 	pmu->aliases = NULL;
 }
 
@@ -676,7 +676,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 		break;
 
 	}
-	hashmap__set(pmu->aliases, alias->name, alias, /*old_key=*/ NULL, &old_alias);
+	hashmap__set(pmu->aliases, alias->name, alias, /*old_key=*/NULL, &old_alias);
 	perf_pmu_free_alias(old_alias);
 	return 0;
 }
@@ -1198,7 +1198,7 @@ int perf_pmu__init(struct perf_pmu *pmu, __u32 type, const char *name)
 	if (!pmu->name)
 		return -ENOMEM;
 
-	pmu->aliases = hashmap__new(aliases__hash, aliases__equal, /*ctx=*/ NULL);
+	pmu->aliases = pmu_aliases_map__new(aliases__hash, aliases__equal, /*ctx=*/NULL);
 	if (!pmu->aliases)
 		return -ENOMEM;
 
@@ -1313,7 +1313,7 @@ struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pm
 	pmu->cpus = cpu_map__online();
 
 	INIT_LIST_HEAD(&pmu->format);
-	pmu->aliases = hashmap__new(aliases__hash, aliases__equal, /*ctx=*/ NULL);
+	pmu->aliases = pmu_aliases_map__new(aliases__hash, aliases__equal, /*ctx=*/NULL);
 	if (!pmu->aliases) {
 		perf_cpu_map__put(pmu->cpus);
 		free((char *)pmu->name);
@@ -2276,8 +2276,8 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 		.event_type_desc = "Kernel PMU event",
 	};
 	int ret = 0;
-	struct hashmap_entry *entry;
-	size_t bkt;
+	const char *key;
+	struct perf_pmu_alias *event;
 	size_t size_rem;
 
 	if (perf_pmu__is_tracepoint(pmu))
@@ -2289,8 +2289,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 
 	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
-	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
-		struct perf_pmu_alias *event = entry->pvalue;
+	hashmap__for_each(pmu->aliases, key, event) {
 		size_t buf_used, pmu_name_len;
 
 		if (perf_pmu__is_tool(pmu) && tool_pmu__skip_event(event->name))
@@ -2809,16 +2808,15 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 
 const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 {
-	struct hashmap_entry *entry;
-	size_t bkt;
+	const char *key;
+	struct perf_pmu_alias *event;
 
 	if (!pmu)
 		return NULL;
 
 	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
-	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
-		struct perf_pmu_alias *event = entry->pvalue;
+	hashmap__for_each(pmu->aliases, key, event) {
 		struct perf_event_attr attr = {.config = 0,};
 		int ret = perf_pmu__parse_terms_to_attr(pmu, event->terms, &attr);
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 2c8916ad073e..928aee2486e7 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -10,15 +10,18 @@
 #include <stdio.h>
 #include "parse-events.h"
 #include "pmu-events/pmu-events.h"
+#include "hashmap.h"
 #include "map_symbol.h"
 #include "mem-events.h"
 
 struct evsel_config_term;
-struct hashmap;
 struct perf_cpu_map;
 struct perf_env;
+struct perf_pmu_alias;
 struct print_callbacks;
 
+DECLARE_HASHMAP(pmu_aliases_map, const char *, struct perf_pmu_alias *);
+
 enum {
 	PERF_PMU_FORMAT_VALUE_CONFIG,
 	PERF_PMU_FORMAT_VALUE_CONFIG1,
@@ -143,7 +146,7 @@ struct perf_pmu {
 	 * event read from <sysfs>/bus/event_source/devices/<name>/events/ or
 	 * from json events in pmu-events.c.
 	 */
-	struct hashmap *aliases;
+	struct pmu_aliases_map *aliases;
 	/**
 	 * @events_table: The events table for json events in pmu-events.c.
 	 */
-- 
2.56.1.703.gf848ed807c-goog

