Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF81F36120
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Apr 2024 06:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163007; cv=none; b=rQQakBJYLd7n1kEndu/1HEX2zwT0OWtyWq4/uz6l+S8MDeGWjEQcXMplZm796z4X2lt9LxDlbBa/uQq5DpI8qG2WoACuP9F9jeHNgxlIimsrhjS3jTSYY2zkOgNgzVM4jF9pi4XortJkGvdKRm+G5a96r36OTboE/O4xgswLzMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163007; c=relaxed/simple;
	bh=0qNUELlBjl8dO1+sdDUCDBg6O9xZvVY5pIsvof/yf3Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=tH2BdaA0iL1ZMAJm/e97IyTlDBJuevioHXT74U1D8STJQpnj7WMGV9h0LRjz432y6tjZrY4chJ9IG7cVQ3uoVwU4+D3v3SzbhULjaju0p2a9aN0NTSFQWmfUU9Oxc6aj15jiGfy0MLzLj6vOeNiart3R/rLRNEC8r2I6HDj6FNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=whYhHOca; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="whYhHOca"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd944567b6cso3721803276.2
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Apr 2024 23:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713163005; x=1713767805; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hx/Ta0rDGqfG4yTzEhISDdPx4oXkJbCeHRtXa2sGNYw=;
        b=whYhHOcapG2gxVPKNsrJ1t/iUzeCyUiF0iaJ41cp+kFsRWALiNmG+NCp/AnlVjNFNO
         zwwbbpDQftH6OGur+ZQvBZSJ3nu3USJqpbgHXlHbKZypi71MMByRGWHOTUmcFL04oBFb
         8jDglc0tYbWojnI2nWcO2FhR+jlR5CyvJyrstEhCts9ucqVunhELgGUmbSEu0km/j40m
         9wY545dSOaGSE1r8wl4vzjmNmLEca3QmJbcbTzxvG3m8nUSWLbuzToMU7+6yYPT4ACZS
         b8oW/hqwD+EcG4MBKsgUgs1I9MfN488WOpVYcWj18eNLANbnpabydyh2yU2kttCPopHv
         Ii2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713163005; x=1713767805;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hx/Ta0rDGqfG4yTzEhISDdPx4oXkJbCeHRtXa2sGNYw=;
        b=b2+UGKCXFmlTI3joehLCHLXMU4eD9ewfma2vM6ayXPcgIFfVc8n+e9UQVsk8NmvONh
         B8+q4/z0BgaOWEAw3f6zczLkAkHxRbnBJ1z3t7oplo+FcZ+fpqLVvr2LxyVtWlHv58Ko
         yxBTXQwPvJ9/BY6LacqNwbtdWP7rZHgziWnVv2Cd5KkVam7mXJPi4fFqHEBbO6BmFxMw
         OTMxdf4Y7ryH0xm0ZgpCkAZ/gpnJJOvq2vD0r86AdEzfhgfrCjAuUdavc5U2qpD7q/J8
         y9uFIRWuqj48cj6uQ3xbVi3LxDYZIzjWrwBEPVqOgXxAlApPd7yrSU1jjKwOKll0gw7J
         tbdw==
X-Forwarded-Encrypted: i=1; AJvYcCURVpaDkgtbbtgxJeDCdEM9/MktMkIbNYVFw8u922j5tXeBoC8GvHk7Uf59gtD+pXh6F4YlQn2pTz/mRQzJvEyAwbPl2JJcV/WxzxpOnBmCgw==
X-Gm-Message-State: AOJu0Yxsn0rU/5l2p54LfeA7XduitY3FX4FFUxTIqS99/vkN2m2JLP/W
	QBjLh/qDxiSKhy8AnQKqqUdXdk0myCDQxLD48luwkDc2BwZQ+OxEQkH8dusb34o//h0UeDPacns
	c1mC8ig==
X-Google-Smtp-Source: AGHT+IGKjbFopUbPAz4023seU2rQZ1FOntIZ8rt7x+OCB1yu2RcNgzS+jPNzrST2MfTWwwugdpm9slVKlTFo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f304:d776:d707:4b57])
 (user=irogers job=sendgmr) by 2002:a05:6902:120b:b0:de0:ecc6:87b with SMTP id
 s11-20020a056902120b00b00de0ecc6087bmr742661ybu.1.1713163004978; Sun, 14 Apr
 2024 23:36:44 -0700 (PDT)
Date: Sun, 14 Apr 2024 23:36:23 -0700
In-Reply-To: <20240415063626.453987-1-irogers@google.com>
Message-Id: <20240415063626.453987-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415063626.453987-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v1 6/9] perf parse-events: Legacy cache names on all PMUs and
 lower priority
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Prior behavior is to not look for legacy cache names in sysfs/json and
to create events on all core PMUs. New behavior is to look for
sysfs/json events first on all PMUs, for core PMUs add a legacy event
if the sysfs/json event isn't present.

This is done so that there is consistency with how event names in
terms are handled and their prioritization of sysfs/json over
legacy. It may make sense to use a legacy cache event name as an event
name on a non-core PMU so we should allow it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 38 +++++++++++++++++++++++++++-------
 tools/perf/util/parse-events.h |  2 +-
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f4de374dab59..f711ad9b18f0 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -442,17 +442,21 @@ bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
 	return strcmp(parse_state->pmu_filter, pmu->name) != 0;
 }
 
+static int parse_events_add_pmu(struct parse_events_state *parse_state,
+				struct list_head *list, struct perf_pmu *pmu,
+				const struct parse_events_terms *const_parsed_terms,
+				bool auto_merge_stats);
+
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
-			   struct parse_events_terms *head_config)
+			   struct parse_events_terms *parsed_terms)
 {
 	struct perf_pmu *pmu = NULL;
 	bool found_supported = false;
-	const char *config_name = get_config_name(head_config);
-	const char *metric_id = get_config_metric_id(head_config);
+	const char *config_name = get_config_name(parsed_terms);
+	const char *metric_id = get_config_metric_id(parsed_terms);
 
-	/* Legacy cache events are only supported by core PMUs. */
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
 		LIST_HEAD(config_terms);
 		struct perf_event_attr attr;
 		int ret;
@@ -460,6 +464,24 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 		if (parse_events__filter_pmu(parse_state, pmu))
 			continue;
 
+		if (perf_pmu__have_event(pmu, name)) {
+			/*
+			 * The PMU has the event so add as not a legacy cache
+			 * event.
+			 */
+			ret = parse_events_add_pmu(parse_state, list, pmu,
+						   parsed_terms,
+						   perf_pmu__auto_merge_stats(pmu));
+			if (ret)
+				return ret;
+			continue;
+		}
+
+		if (!pmu->is_core) {
+			/* Legacy cache events are only supported by core PMUs. */
+			continue;
+		}
+
 		memset(&attr, 0, sizeof(attr));
 		attr.type = PERF_TYPE_HW_CACHE;
 
@@ -469,11 +491,11 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 
 		found_supported = true;
 
-		if (head_config) {
-			if (config_attr(&attr, head_config, parse_state->error, config_term_common))
+		if (parsed_terms) {
+			if (config_attr(&attr, parsed_terms, parse_state->error, config_term_common))
 				return -EINVAL;
 
-			if (get_config_terms(head_config, &config_terms))
+			if (get_config_terms(parsed_terms, &config_terms))
 				return -ENOMEM;
 		}
 
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index a331b9f0da2b..db47913e54bc 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -203,7 +203,7 @@ int parse_events_add_tool(struct parse_events_state *parse_state,
 			  int tool_event);
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
-			   struct parse_events_terms *head_config);
+			   struct parse_events_terms *parsed_terms);
 int parse_events__decode_legacy_cache(const char *name, int pmu_type, __u64 *config);
 int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 				struct list_head *list,
-- 
2.44.0.683.g7961c838ac-goog

