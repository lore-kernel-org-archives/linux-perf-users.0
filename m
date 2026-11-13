Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604279;
	b=3kV72oRZbAg4dDlMsd3wE1QRqTM7KAvBLh0QnXaQbhPsZzmSFrL3JvTQFge5KhQ3GtQm
	 Wou88tpih3hor68vD5d+H2ScAPMUz1Muk12RsqGJbeeOIwc82LeZvQFJzHnHYeQ9GmfeT
	 87NWxnc3mKHQeq7QdjGvlNYcir2na8vhyv+7Rj2EFVDEOanRujJlG2eqlPGdQnZRALxkC
	 L+PT8baVFY5EKZ5IFBZv9pswRhqsjshlsfWQwurtY2h6lBcPmNBfJnIasFxaVrehAKLce
	 xRIlEBvzFfAB1DS9pYuKZ24azSZHeDzPoImeiN08uMqGijzfdCDaPDV5buNcaaIKqrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=YsiYtw77nexKINbrsfEcFfxTmoEvLTa55kFVcmL7JuI=;
	b=X2+aSX8KyHeP2SvWilGNqwuRxFwglmR8jq3lws3fwlx8DHtEqwFSOWHmLbYc40G9NbjV
	 JycXf8HAJv7sbnwnxKGOI439Cw92pPanwuR3aIjly/l1VgQRrxyO749w5mkYfv0faKsfR
	 Ka6l6h0TVapj75Fm1X7FroMaIifOcCyTl9nZEsd49MeFOokcyhrDuESguzTKVp2jb/xR+
	 PvcgTSCGRcP5BONmbFtxap8ZEhUtyncdafxnlM3SNNqyHkG3Et6rtZgL910fLZqlyCDP4
	 4avPBeaA/F4cW250FOp4RPmQ6iAfiybTwCvlBOVlN7jAgbYO2cZuBaiLr/eWptjZfjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lPIE1Csu;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB814606A8B8
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB814606A8B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lPIE1Csu
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-341eff9e381so2127993eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794604278; x=1795209078; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YsiYtw77nexKINbrsfEcFfxTmoEvLTa55kFVcmL7JuI=;
        b=lPIE1Csu89M4N0NIMdAZGruT5zIODetm49Zz4XskoANXrmRL53mralk7rnWitjXP/a
         IeIXALFhmk6Kp0gQHoPQuBKKPMlpcU7q4W4XCyosZmvOptpKt7KyqIUkyeuvvd0MczVO
         2NR+xAufJbvRCF43Chltnf9hXrmU+tG04Aqg/uc/xpB4DgwUr8PPe2iYqwB7F8+Pnd7s
         37KbbYp0b458PbiU2OW6BBBE6UcF11MlfU3k6PGd3pSwp9/BjrnnqSpiDm9v+aLqUZxw
         PnQIkfgs+8TK3xzqBVeDPJ4LjbMUHg5erqH/uN3gDjpdchzakORK1U0U1yRhNuTqy20m
         Ig7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604278; x=1795209078;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YsiYtw77nexKINbrsfEcFfxTmoEvLTa55kFVcmL7JuI=;
        b=cfcO4ImfDEJyz/9mB+rCMX5Q/ZBeFRUgKpzMf5WBhLzEkiWkiEtZvn2I/B0FmKyexz
         ltPFiyLNV4fHtApAB0KKBOLhQZsOAF92hS141rTAWZMFrvRhJM8ao7eSPvxCKAJQh16L
         tWHUaDZE5bTcmC5JN0WtvpGDaJs+zd+tb5atISNmlSqR4g5vgMqEKYe/EP1+JIEszL3c
         2WMIS+tLX084TzlBnemEhXYWDTZUmXG//8DbOa8Aq1+5pHnyRvafn4x9lk6Ta1CMgTzt
         3hk04p6vnH3UGq8ozAPIXl27JOhRhSpvTykVhtOkv3GB0UNY/S+cuxCU3jFWmto8fwbI
         wOnw==
X-Forwarded-Encrypted: i=1; AL+hErGp4NZKFFPiyLneIOs6GNM8LOeK+swzZUwHsFqT1qSSJui07O2pWtcN38AsR88FwNV1pvbn698GKW+FpvjdIcPX@vger.kernel.org
X-Gm-Message-State: APuU4Z8LVoFICpkVvD/RHrjEBEgbD7QqlWkM9L+s37sDNwlO4wjyp/k1
	ezf7LdG3Rn0J1lwN9Wm4UieseiOjIPyZ+ltMh/Mwu6EwnkhkgxmuHmvllrnaLVjjyDUuXGHElAj
	b+j+bwFzetQ==
X-Received: from dyaa19.prod.google.com ([2002:a05:693c:40d3:b0:376:3d5d:fcba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a21f:b0:36e:c85c:3bbc
 with SMTP id 5a478bee46e88-37965ca778amr3129703eec.12.1794604277402; Fri, 13
 Nov 2026 13:11:17 -0800 (PST)
Date: Fri, 13 Nov 2026 13:10:54 -0800
In-Reply-To: <20261113211105.3118281-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113211105.3118281-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113211105.3118281-4-irogers@google.com>
Subject: [PATCH 03/11] perf pmu-layer: Introduce stateless struct pmu_layer
 abstraction and builtin adapter
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce tools/perf/util/pmu-layer.[ch] defining a stateless VTable
abstraction (struct pmu_layer_ops) for resolving and enumerating PMU
events, metrics, and metricgroup descriptions top-down into struct
perf_pmu's owned aliases, metrics, and metricgroups hashmaps, sharing
struct perf_pmu_alias, struct perf_pmu_metric, and struct
perf_pmu_metricgroup privately between pmu.c and pmu-layer.c via
pmu-layer.h rather than exposing them in pmu.h.

Implement the compiled-in block-compressed adapters
(PMU_LAYER_BUILTIN_CPU and PMU_LAYER_BUILTIN_COMMON) wrapping
pmu_events_table, pmu_metrics_table, uncore/system PMU compat tables,
and describe_metricgroup() with "first non-empty attribute wins"
merging semantics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build       |    1 +
 tools/perf/util/pmu-layer.c | 1003 +++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu-layer.h |  170 ++++++
 tools/perf/util/pmu.c       |  175 +-----
 4 files changed, 1182 insertions(+), 167 deletions(-)
 create mode 100644 tools/perf/util/pmu-layer.c
 create mode 100644 tools/perf/util/pmu-layer.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 2c1f880c4c47..ae681b863ea7 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -86,6 +86,7 @@ perf-util-y += thread_map.o
 perf-util-y += parse-events-flex.o
 perf-util-y += parse-events-bison.o
 perf-util-y += pmu.o
+perf-util-y += pmu-layer.o
 perf-util-y += pmus.o
 perf-util-y += pmu-flex.o
 perf-util-y += pmu-bison.o
diff --git a/tools/perf/util/pmu-layer.c b/tools/perf/util/pmu-layer.c
new file mode 100644
index 000000000000..e4c50cc6d1ea
--- /dev/null
+++ b/tools/perf/util/pmu-layer.c
@@ -0,0 +1,1003 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <strings.h>
+#include <linux/compiler.h>
+#include <linux/err.h>
+#include <linux/zalloc.h>
+#include "debug.h"
+#include "hashmap.h"
+#include "pmu.h"
+#include "pmu-layer.h"
+#include "pmu-events/pmu-events.h"
+
+static struct pmu_layer *pmu_layers;
+static size_t nr_pmu_layers;
+static bool pmu_layers_initialized;
+
+static struct perf_pmu_alias *pmu_layer_alloc_alias(const char *name)
+{
+	struct perf_pmu_alias *alias = zalloc(sizeof(*alias));
+
+	if (!alias)
+		return NULL;
+
+	alias->name = strdup(name);
+	if (!alias->name) {
+		free(alias);
+		return NULL;
+	}
+	alias->scale = 1.0;
+	alias->unit[0] = '\0';
+	return alias;
+}
+
+static struct perf_pmu_alias *pmu_layer_get_or_create_alias(struct perf_pmu *pmu,
+							    const char *name)
+{
+	struct perf_pmu_alias *alias = NULL, *old_alias = NULL;
+
+	if (hashmap__find(pmu->aliases, name, &alias))
+		return alias;
+
+	alias = pmu_layer_alloc_alias(name);
+	if (!alias)
+		return NULL;
+
+	if (hashmap__set(pmu->aliases, alias->name, alias,
+			 /*old_key=*/NULL, &old_alias)) {
+		perf_pmu_free_alias(alias);
+		return NULL;
+	}
+	perf_pmu_free_alias(old_alias);
+	return alias;
+}
+
+static struct perf_pmu_metric *pmu_layer_alloc_metric(const char *name)
+{
+	struct perf_pmu_metric *metric = zalloc(sizeof(*metric));
+
+	if (!metric)
+		return NULL;
+
+	metric->metric_name = strdup(name);
+	if (!metric->metric_name) {
+		free(metric);
+		return NULL;
+	}
+	return metric;
+}
+
+static struct perf_pmu_metric *pmu_layer_get_or_create_metric(struct perf_pmu *pmu,
+							      const char *name)
+{
+	struct perf_pmu_metric *metric = NULL, *old_metric = NULL;
+
+	if (hashmap__find(pmu->metrics, name, &metric))
+		return metric;
+
+	metric = pmu_layer_alloc_metric(name);
+	if (!metric)
+		return NULL;
+
+	if (hashmap__set(pmu->metrics, metric->metric_name, metric,
+			 /*old_key=*/NULL, &old_metric)) {
+		perf_pmu_free_metric(metric);
+		return NULL;
+	}
+	perf_pmu_free_metric(old_metric);
+	return metric;
+}
+
+static int pmu_layer_merge_pe(struct perf_pmu_alias *alias,
+			      const struct pmu_event *pe,
+			      bool is_common)
+{
+	int ret = 0;
+
+	if (pe->event) {
+		if (is_common) {
+			if (!alias->legacy_terms) {
+				alias->legacy_terms = strdup(pe->event);
+				if (!alias->legacy_terms)
+					return -ENOMEM;
+			}
+		} else if (!alias->terms) {
+			alias->terms = strdup(pe->event);
+			if (!alias->terms)
+				return -ENOMEM;
+		}
+	}
+
+	if (!alias->desc && pe->desc) {
+		alias->desc = strdup(pe->desc);
+		if (!alias->desc)
+			return -ENOMEM;
+	}
+	if (!alias->long_desc && pe->long_desc) {
+		alias->long_desc = strdup(pe->long_desc);
+		if (!alias->long_desc)
+			return -ENOMEM;
+	}
+	if (!alias->topic && pe->topic) {
+		alias->topic = strdup(pe->topic);
+		if (!alias->topic)
+			return -ENOMEM;
+	}
+	if (!alias->pmu_name && pe->pmu && strcmp(pe->pmu, "default_core")) {
+		alias->pmu_name = strdup(pe->pmu);
+		if (!alias->pmu_name)
+			return -ENOMEM;
+	}
+	if (!alias->compat && pe->compat) {
+		alias->compat = strdup(pe->compat);
+		if (!alias->compat)
+			return -ENOMEM;
+	}
+
+	if (!alias->has_per_pkg && pe->perpkg) {
+		alias->per_pkg = true;
+		alias->has_per_pkg = true;
+	}
+	if (!alias->has_deprecated && pe->deprecated) {
+		alias->deprecated = true;
+		alias->has_deprecated = true;
+	}
+
+	if (pe->unit && (!alias->has_scale || !alias->has_unit)) {
+		char *unit_str = NULL;
+		double sval = 1.0;
+
+		ret = perf_pmu__convert_scale(pe->unit, &unit_str, &sval);
+		if (ret)
+			return ret;
+		if (!alias->has_scale) {
+			alias->scale = sval;
+			alias->has_scale = true;
+		}
+		if (!alias->has_unit && unit_str) {
+			snprintf(alias->unit, sizeof(alias->unit), "%s", unit_str);
+			alias->has_unit = true;
+		}
+	}
+
+	if (!alias->has_retire_lat_mean && pe->retirement_latency_mean) {
+		ret = perf_pmu__convert_scale(pe->retirement_latency_mean, NULL,
+					      &alias->retirement_latency_mean);
+		if (ret)
+			return ret;
+		alias->has_retire_lat_mean = true;
+	}
+	if (!alias->has_retire_lat_min && pe->retirement_latency_min) {
+		ret = perf_pmu__convert_scale(pe->retirement_latency_min, NULL,
+					      &alias->retirement_latency_min);
+		if (ret)
+			return ret;
+		alias->has_retire_lat_min = true;
+	}
+	if (!alias->has_retire_lat_max && pe->retirement_latency_max) {
+		ret = perf_pmu__convert_scale(pe->retirement_latency_max, NULL,
+					      &alias->retirement_latency_max);
+		if (ret)
+			return ret;
+		alias->has_retire_lat_max = true;
+	}
+
+	return 0;
+}
+
+static int pmu_layer_merge_pm(struct perf_pmu_metric *metric,
+			      const struct pmu_metric *pm)
+{
+	if (!metric->pmu && pm->pmu) {
+		metric->pmu = strdup(pm->pmu);
+		if (!metric->pmu)
+			return -ENOMEM;
+	}
+	if (!metric->metric_expr && pm->metric_expr) {
+		metric->metric_expr = strdup(pm->metric_expr);
+		if (!metric->metric_expr)
+			return -ENOMEM;
+	}
+	if (!metric->metric_group && pm->metric_group) {
+		metric->metric_group = strdup(pm->metric_group);
+		if (!metric->metric_group)
+			return -ENOMEM;
+	}
+	if (!metric->metric_threshold && pm->metric_threshold) {
+		metric->metric_threshold = strdup(pm->metric_threshold);
+		if (!metric->metric_threshold)
+			return -ENOMEM;
+	}
+	if (!metric->unit && pm->unit) {
+		metric->unit = strdup(pm->unit);
+		if (!metric->unit)
+			return -ENOMEM;
+	}
+	if (!metric->compat && pm->compat) {
+		metric->compat = strdup(pm->compat);
+		if (!metric->compat)
+			return -ENOMEM;
+	}
+	if (!metric->desc && pm->desc) {
+		metric->desc = strdup(pm->desc);
+		if (!metric->desc)
+			return -ENOMEM;
+	}
+	if (!metric->long_desc && pm->long_desc) {
+		metric->long_desc = strdup(pm->long_desc);
+		if (!metric->long_desc)
+			return -ENOMEM;
+	}
+	if (!metric->metricgroup_no_group && pm->metricgroup_no_group) {
+		metric->metricgroup_no_group = strdup(pm->metricgroup_no_group);
+		if (!metric->metricgroup_no_group)
+			return -ENOMEM;
+	}
+	if (!metric->default_metricgroup_name && pm->default_metricgroup_name) {
+		metric->default_metricgroup_name = strdup(pm->default_metricgroup_name);
+		if (!metric->default_metricgroup_name)
+			return -ENOMEM;
+	}
+	if (!metric->has_aggr_mode && pm->aggr_mode) {
+		metric->aggr_mode = pm->aggr_mode;
+		metric->has_aggr_mode = true;
+	}
+	if (!metric->has_event_grouping && pm->event_grouping != MetricGroupEvents) {
+		metric->event_grouping = pm->event_grouping;
+		metric->has_event_grouping = true;
+	}
+	if (!metric->has_default_show_events && pm->default_show_events) {
+		metric->default_show_events = true;
+		metric->has_default_show_events = true;
+	}
+	return 0;
+}
+
+struct builtin_find_event_ctx {
+	struct perf_pmu *pmu;
+	const char *name;
+	struct perf_pmu_alias *alias;
+	bool is_common;
+};
+
+static int builtin_find_event_cb(const struct pmu_event *pe,
+				 const struct pmu_events_table *table __maybe_unused,
+				 void *vdata)
+{
+	struct builtin_find_event_ctx *ctx = vdata;
+
+	return pmu_layer_merge_pe(ctx->alias, pe, ctx->is_common);
+}
+
+static int builtin_find_sys_event_cb(const struct pmu_event *pe,
+				     const struct pmu_events_table *table __maybe_unused,
+				     void *vdata)
+{
+	struct builtin_find_event_ctx *ctx = vdata;
+
+	if (!pe->name || !pe->compat || !pe->pmu)
+		return 0;
+	if (strcasecmp(pe->name, ctx->name) != 0)
+		return 0;
+	if (!perf_pmu__name_wildcard_match(ctx->pmu, pe->pmu))
+		return 0;
+	if (!pmu_uncore_identifier_match(pe->compat, ctx->pmu->id))
+		return 0;
+	return pmu_layer_merge_pe(ctx->alias, pe, /*is_common=*/false);
+}
+
+struct builtin_iter_event_ctx {
+	struct perf_pmu *pmu;
+	bool is_common;
+	bool override_existing;
+};
+
+static int pmu_layer_override_pe(struct perf_pmu_alias *alias,
+				 const struct pmu_event *pe)
+{
+	if (pe->event) {
+		char *dup_terms = strdup(pe->event);
+
+		if (!dup_terms)
+			return -ENOMEM;
+		if (alias->terms_from_legacy && !alias->legacy_terms) {
+			alias->legacy_terms = alias->terms;
+			alias->terms = NULL;
+			alias->terms_from_legacy = false;
+		} else {
+			zfree(&alias->terms);
+		}
+		alias->terms = dup_terms;
+	}
+	if (pe->desc)
+		zfree(&alias->desc);
+	if (pe->long_desc)
+		zfree(&alias->long_desc);
+	if (pe->topic)
+		zfree(&alias->topic);
+	if (pe->pmu && strcmp(pe->pmu, "default_core"))
+		zfree(&alias->pmu_name);
+	if (pe->compat)
+		zfree(&alias->compat);
+	if (pe->perpkg)
+		alias->has_per_pkg = false;
+	if (pe->deprecated)
+		alias->has_deprecated = false;
+	if (pe->unit) {
+		alias->has_scale = false;
+		alias->has_unit = false;
+	}
+	if (pe->retirement_latency_mean)
+		alias->has_retire_lat_mean = false;
+	if (pe->retirement_latency_min)
+		alias->has_retire_lat_min = false;
+	if (pe->retirement_latency_max)
+		alias->has_retire_lat_max = false;
+
+	return pmu_layer_merge_pe(alias, pe, /*is_common=*/false);
+}
+
+static int builtin_for_each_event_cb(const struct pmu_event *pe,
+				     const struct pmu_events_table *table __maybe_unused,
+				     void *vdata)
+{
+	struct builtin_iter_event_ctx *ctx = vdata;
+	struct perf_pmu_alias *alias;
+
+	if (!pe->name)
+		return 0;
+
+	alias = pmu_layer_get_or_create_alias(ctx->pmu, pe->name);
+	if (!alias)
+		return -ENOMEM;
+	if (ctx->override_existing)
+		return pmu_layer_override_pe(alias, pe);
+	if (alias->resolved)
+		return 0;
+
+	return pmu_layer_merge_pe(alias, pe, ctx->is_common);
+}
+
+static int builtin_for_each_sys_event_cb(const struct pmu_event *pe,
+					 const struct pmu_events_table *table __maybe_unused,
+					 void *vdata)
+{
+	struct builtin_iter_event_ctx *ctx = vdata;
+	struct perf_pmu_alias *alias;
+
+	if (!pe->name || !pe->compat || !pe->pmu)
+		return 0;
+	if (!perf_pmu__name_wildcard_match(ctx->pmu, pe->pmu))
+		return 0;
+	if (!pmu_uncore_identifier_match(pe->compat, ctx->pmu->id))
+		return 0;
+
+	alias = pmu_layer_get_or_create_alias(ctx->pmu, pe->name);
+	if (!alias)
+		return -ENOMEM;
+	if (ctx->override_existing)
+		return pmu_layer_override_pe(alias, pe);
+	if (alias->resolved)
+		return 0;
+
+	return pmu_layer_merge_pe(alias, pe, /*is_common=*/false);
+}
+
+struct builtin_find_metric_ctx {
+	struct perf_pmu *pmu;
+	const char *name;
+	struct perf_pmu_metric *metric;
+};
+
+static int builtin_find_metric_cb(const struct pmu_metric *pm,
+				  const struct pmu_metrics_table *table __maybe_unused,
+				  void *vdata)
+{
+	struct builtin_find_metric_ctx *ctx = vdata;
+
+	return pmu_layer_merge_pm(ctx->metric, pm);
+}
+
+static int builtin_find_sys_metric_cb(const struct pmu_metric *pm,
+				      const struct pmu_metrics_table *table __maybe_unused,
+				      void *vdata)
+{
+	struct builtin_find_metric_ctx *ctx = vdata;
+
+	if (!pm->metric_name || !pm->compat || !pm->pmu)
+		return 0;
+	if (strcmp(pm->metric_name, ctx->name) != 0)
+		return 0;
+	if (!perf_pmu__name_wildcard_match(ctx->pmu, pm->pmu))
+		return 0;
+	if (!pmu_uncore_identifier_match(pm->compat, ctx->pmu->id))
+		return 0;
+	return pmu_layer_merge_pm(ctx->metric, pm);
+}
+
+static int builtin_for_each_metric_cb(const struct pmu_metric *pm,
+				      const struct pmu_metrics_table *table __maybe_unused,
+				      void *vdata)
+{
+	struct perf_pmu *pmu = vdata;
+	struct perf_pmu_metric *metric;
+
+	if (!pm->metric_name)
+		return 0;
+	if (pm->pmu && !perf_pmu__name_wildcard_match(pmu, pm->pmu))
+		return 0;
+
+	metric = pmu_layer_get_or_create_metric(pmu, pm->metric_name);
+	if (!metric)
+		return -ENOMEM;
+
+	return pmu_layer_merge_pm(metric, pm);
+}
+
+static int builtin_for_each_sys_metric_cb(const struct pmu_metric *pm,
+					  const struct pmu_metrics_table *table __maybe_unused,
+					  void *vdata)
+{
+	struct perf_pmu *pmu = vdata;
+	struct perf_pmu_metric *metric;
+
+	if (!pm->metric_name || !pm->compat || !pm->pmu)
+		return 0;
+	if (!perf_pmu__name_wildcard_match(pmu, pm->pmu))
+		return 0;
+	if (!pmu_uncore_identifier_match(pm->compat, pmu->id))
+		return 0;
+
+	metric = pmu_layer_get_or_create_metric(pmu, pm->metric_name);
+	if (!metric)
+		return -ENOMEM;
+
+	return pmu_layer_merge_pm(metric, pm);
+}
+
+static int builtin_cpu_find_event(const struct pmu_layer *layer __maybe_unused,
+				  struct perf_pmu *pmu, const char *name,
+				  struct perf_pmu_alias *alias)
+{
+	struct builtin_find_event_ctx ctx = {
+		.pmu = pmu,
+		.name = name,
+		.alias = alias,
+		.is_common = false,
+	};
+	int ret;
+
+	if (pmu->events_table) {
+		ret = pmu_events_table__find_event(pmu->events_table, pmu, name,
+						   builtin_find_event_cb, &ctx);
+		if (ret && ret != PMU_EVENTS__NOT_FOUND)
+			return ret;
+	}
+	if (pmu->id) {
+		ret = pmu_for_each_sys_event(builtin_find_sys_event_cb, &ctx);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int builtin_cpu_for_each_event(const struct pmu_layer *layer __maybe_unused,
+				      struct perf_pmu *pmu)
+{
+	struct builtin_iter_event_ctx ctx = {
+		.pmu = pmu,
+		.is_common = false,
+	};
+	int ret;
+
+	if (pmu->events_table) {
+		ret = pmu_events_table__for_each_event(pmu->events_table, pmu,
+						       builtin_for_each_event_cb, &ctx);
+		if (ret)
+			return ret;
+	}
+	if (pmu->id) {
+		ret = pmu_for_each_sys_event(builtin_for_each_sys_event_cb, &ctx);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int builtin_cpu_find_metric(const struct pmu_layer *layer __maybe_unused,
+				   struct perf_pmu *pmu, const char *name,
+				   struct perf_pmu_metric *metric)
+{
+	struct builtin_find_metric_ctx ctx = {
+		.pmu = pmu,
+		.name = name,
+		.metric = metric,
+	};
+	int ret;
+
+	if (pmu->metrics_table) {
+		ret = pmu_metrics_table__find_metric(pmu->metrics_table, pmu, name,
+						     builtin_find_metric_cb, &ctx);
+		if (ret && ret != PMU_METRICS__NOT_FOUND)
+			return ret;
+	}
+	if (pmu->id) {
+		ret = pmu_for_each_sys_metric(builtin_find_sys_metric_cb, &ctx);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int builtin_cpu_for_each_metric(const struct pmu_layer *layer __maybe_unused,
+				       struct perf_pmu *pmu)
+{
+	int ret;
+
+	if (pmu->metrics_table) {
+		ret = pmu_metrics_table__for_each_metric(pmu->metrics_table,
+							 builtin_for_each_metric_cb, pmu);
+		if (ret)
+			return ret;
+	}
+	if (pmu->id) {
+		ret = pmu_for_each_sys_metric(builtin_for_each_sys_metric_cb, pmu);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static const struct pmu_layer_ops builtin_cpu_layer_ops = {
+	.find_event = builtin_cpu_find_event,
+	.for_each_event = builtin_cpu_for_each_event,
+	.find_metric = builtin_cpu_find_metric,
+	.for_each_metric = builtin_cpu_for_each_metric,
+};
+
+static int builtin_common_find_event(const struct pmu_layer *layer __maybe_unused,
+				     struct perf_pmu *pmu, const char *name,
+				     struct perf_pmu_alias *alias)
+{
+	const struct pmu_events_table *table;
+	struct builtin_find_event_ctx ctx = {
+		.pmu = pmu,
+		.name = name,
+		.alias = alias,
+		.is_common = true,
+	};
+	int ret;
+
+	if (!pmu->is_core)
+		return 0;
+
+	table = perf_pmu__default_core_events_table();
+	if (!table)
+		return 0;
+
+	ret = pmu_events_table__find_event(table, pmu, name,
+					   builtin_find_event_cb, &ctx);
+	if (ret == PMU_EVENTS__NOT_FOUND)
+		return 0;
+	return ret;
+}
+
+static int builtin_common_for_each_event(const struct pmu_layer *layer __maybe_unused,
+					 struct perf_pmu *pmu)
+{
+	const struct pmu_events_table *table;
+	struct builtin_iter_event_ctx ctx = {
+		.pmu = pmu,
+		.is_common = true,
+	};
+
+	if (!pmu->is_core)
+		return 0;
+
+	table = perf_pmu__default_core_events_table();
+	if (!table)
+		return 0;
+
+	return pmu_events_table__for_each_event(table, pmu,
+						builtin_for_each_event_cb, &ctx);
+}
+
+static int builtin_common_find_metric(const struct pmu_layer *layer __maybe_unused,
+				      struct perf_pmu *pmu, const char *name,
+				      struct perf_pmu_metric *metric)
+{
+	const struct pmu_metrics_table *table;
+	struct builtin_find_metric_ctx ctx = {
+		.pmu = pmu,
+		.name = name,
+		.metric = metric,
+	};
+	int ret;
+
+	if (!pmu->is_core)
+		return 0;
+
+	table = pmu_metrics_table__default();
+	if (!table)
+		return 0;
+
+	ret = pmu_metrics_table__find_metric(table, pmu, name,
+					     builtin_find_metric_cb, &ctx);
+	if (ret == PMU_METRICS__NOT_FOUND)
+		return 0;
+	return ret;
+}
+
+static int builtin_common_for_each_metric(const struct pmu_layer *layer __maybe_unused,
+					  struct perf_pmu *pmu)
+{
+	const struct pmu_metrics_table *table;
+
+	if (!pmu->is_core)
+		return 0;
+
+	table = pmu_metrics_table__default();
+	if (!table)
+		return 0;
+
+	return pmu_metrics_table__for_each_metric(table,
+						  builtin_for_each_metric_cb, pmu);
+}
+
+static int builtin_common_load_metricgroup(const struct pmu_layer *layer __maybe_unused,
+					   struct perf_pmu *pmu,
+					   const char *group,
+					   struct perf_pmu_metricgroup *mg)
+{
+	const char *desc;
+
+	if (!pmu->is_core || mg->desc)
+		return 0;
+
+	desc = describe_metricgroup(group);
+	if (!desc)
+		return 0;
+
+	mg->desc = strdup(desc);
+	if (!mg->desc)
+		return -ENOMEM;
+	mg->from_builtin = true;
+	return 0;
+}
+
+static const struct pmu_layer_ops builtin_common_layer_ops = {
+	.find_event = builtin_common_find_event,
+	.for_each_event = builtin_common_for_each_event,
+	.find_metric = builtin_common_find_metric,
+	.for_each_metric = builtin_common_for_each_metric,
+	.load_metricgroup = builtin_common_load_metricgroup,
+};
+
+static int pmu_layers_append(enum pmu_layer_kind kind,
+			     const struct pmu_layer_ops *ops,
+			     const char *root_path)
+{
+	struct pmu_layer *next;
+	char *dup_path = NULL;
+
+	if (root_path) {
+		dup_path = strdup(root_path);
+		if (!dup_path)
+			return -ENOMEM;
+	}
+
+	next = realloc(pmu_layers, (nr_pmu_layers + 1) * sizeof(*pmu_layers));
+	if (!next) {
+		free(dup_path);
+		return -ENOMEM;
+	}
+	pmu_layers = next;
+	pmu_layers[nr_pmu_layers++] = (struct pmu_layer){
+		.kind = kind,
+		.ops = ops,
+		.root_path = dup_path,
+	};
+	return 0;
+}
+
+void pmu_layers__exit(void)
+{
+	for (size_t i = 0; i < nr_pmu_layers; i++)
+		zfree(&pmu_layers[i].root_path);
+	zfree(&pmu_layers);
+	nr_pmu_layers = 0;
+	pmu_layers_initialized = false;
+}
+
+static int pmu_layers_ensure_init(void)
+{
+	int ret;
+
+	if (pmu_layers_initialized)
+		return 0;
+
+	ret = pmu_layers_append(PMU_LAYER_BUILTIN_CPU, &builtin_cpu_layer_ops, NULL);
+	if (ret)
+		goto err;
+
+	ret = pmu_layers_append(PMU_LAYER_BUILTIN_COMMON, &builtin_common_layer_ops, NULL);
+	if (ret)
+		goto err;
+
+	pmu_layers_initialized = true;
+	return 0;
+
+err:
+	pmu_layers__exit();
+	return ret;
+}
+
+static void pmu_layer_finalize_aliases(struct perf_pmu *pmu, bool promote_legacy)
+{
+	struct hashmap_entry *cur, *tmp;
+	size_t bkt;
+
+	hashmap__for_each_entry_safe(pmu->aliases, cur, tmp, bkt) {
+		struct perf_pmu_alias *alias = cur->pvalue;
+
+		if (promote_legacy && !alias->terms && alias->legacy_terms) {
+			alias->terms = alias->legacy_terms;
+			alias->legacy_terms = NULL;
+			alias->terms_from_legacy = true;
+		}
+		if (!alias->terms) {
+			hashmap__delete(pmu->aliases, cur->pkey, NULL, NULL);
+			perf_pmu_free_alias(alias);
+		} else if (promote_legacy) {
+			alias->resolved = true;
+		}
+	}
+}
+
+static void pmu_layer_prune_incomplete_metrics(struct perf_pmu *pmu)
+{
+	struct hashmap_entry *cur, *tmp;
+	size_t bkt;
+
+	hashmap__for_each_entry_safe(pmu->metrics, cur, tmp, bkt) {
+		struct perf_pmu_metric *metric = cur->pvalue;
+
+		if (!metric->metric_expr) {
+			hashmap__delete(pmu->metrics, cur->pkey, NULL, NULL);
+			perf_pmu_free_metric(metric);
+		}
+	}
+}
+
+struct perf_pmu_alias *pmu_layer__find_event(struct perf_pmu *pmu,
+					     const char *name)
+{
+	struct perf_pmu_alias *alias = NULL, *old_alias = NULL;
+
+	if (!pmu || !name || !name[0] || name[0] == '.' ||
+	    pmu_event_file_kind(name, NULL) != PMU_EVENT_FILE_BASE)
+		return NULL;
+
+	if (hashmap__find(pmu->aliases, name, &alias))
+		return alias->terms ? alias : NULL;
+
+	if (pmu->aliases_loaded)
+		return NULL;
+
+	if (pmu_layers_ensure_init())
+		return NULL;
+
+	alias = pmu_layer_alloc_alias(name);
+	if (!alias)
+		return NULL;
+
+	for (size_t i = 0; i < nr_pmu_layers; i++) {
+		const struct pmu_layer *layer = &pmu_layers[i];
+
+		if (!layer->ops->find_event)
+			continue;
+		if (layer->ops->find_event(layer, pmu, name, alias) < 0) {
+			perf_pmu_free_alias(alias);
+			return NULL;
+		}
+	}
+
+	if (!alias->terms && alias->legacy_terms) {
+		alias->terms = alias->legacy_terms;
+		alias->legacy_terms = NULL;
+		alias->terms_from_legacy = true;
+	}
+
+	if (!alias->terms) {
+		perf_pmu_free_alias(alias);
+		return NULL;
+	}
+
+	alias->resolved = true;
+	if (hashmap__set(pmu->aliases, alias->name, alias,
+			 /*old_key=*/NULL, &old_alias)) {
+		perf_pmu_free_alias(alias);
+		return NULL;
+	}
+	perf_pmu_free_alias(old_alias);
+	return alias;
+}
+
+int pmu_layer__load_events(struct perf_pmu *pmu)
+{
+	int ret;
+
+	if (!pmu || pmu->aliases_loaded)
+		return 0;
+
+	ret = pmu_layers_ensure_init();
+	if (ret)
+		return ret;
+
+	/*
+	 * Any single-event entries cached before full enumeration remain in
+	 * pmu->aliases; top-down iteration fills any missing events cleanly.
+	 */
+	for (size_t i = 0; i < nr_pmu_layers; i++) {
+		const struct pmu_layer *layer = &pmu_layers[i];
+
+		if (!layer->ops->for_each_event)
+			continue;
+		ret = layer->ops->for_each_event(layer, pmu);
+		if (ret) {
+			pmu_layer_finalize_aliases(pmu, /*promote_legacy=*/false);
+			return ret;
+		}
+	}
+
+	pmu_layer_finalize_aliases(pmu, /*promote_legacy=*/true);
+	pmu->aliases_loaded = true;
+	return 0;
+}
+
+int pmu_layer__merge_event_table(struct perf_pmu *pmu,
+				 const struct pmu_events_table *table)
+{
+	struct builtin_iter_event_ctx ctx = {
+		.pmu = pmu,
+		.is_common = false,
+		.override_existing = true,
+	};
+
+	if (!pmu || !table)
+		return 0;
+
+	return pmu_events_table__for_each_event(table, pmu,
+						builtin_for_each_event_cb, &ctx);
+}
+
+struct perf_pmu_metric *pmu_layer__find_metric(struct perf_pmu *pmu,
+					       const char *name)
+{
+	struct perf_pmu_metric *metric = NULL, *old_metric = NULL;
+
+	if (!pmu || !name || !name[0] || name[0] == '.' ||
+	    pmu_metric_file_kind(name, NULL) != PMU_METRIC_FILE_BASE)
+		return NULL;
+
+	if (hashmap__find(pmu->metrics, name, &metric))
+		return metric->metric_expr ? metric : NULL;
+
+	if (pmu->metrics_loaded)
+		return NULL;
+
+	if (pmu_layers_ensure_init())
+		return NULL;
+
+	metric = pmu_layer_alloc_metric(name);
+	if (!metric)
+		return NULL;
+
+	for (size_t i = 0; i < nr_pmu_layers; i++) {
+		const struct pmu_layer *layer = &pmu_layers[i];
+
+		if (!layer->ops->find_metric)
+			continue;
+		if (layer->ops->find_metric(layer, pmu, name, metric) < 0) {
+			perf_pmu_free_metric(metric);
+			return NULL;
+		}
+	}
+
+	if (!metric->metric_expr) {
+		perf_pmu_free_metric(metric);
+		return NULL;
+	}
+
+	if (hashmap__set(pmu->metrics, metric->metric_name, metric,
+			 /*old_key=*/NULL, &old_metric)) {
+		perf_pmu_free_metric(metric);
+		return NULL;
+	}
+	perf_pmu_free_metric(old_metric);
+	return metric;
+}
+
+int pmu_layer__load_metrics(struct perf_pmu *pmu)
+{
+	int ret;
+
+	if (!pmu || pmu->metrics_loaded)
+		return 0;
+
+	ret = pmu_layers_ensure_init();
+	if (ret)
+		return ret;
+
+	for (size_t i = 0; i < nr_pmu_layers; i++) {
+		const struct pmu_layer *layer = &pmu_layers[i];
+
+		if (!layer->ops->for_each_metric)
+			continue;
+		ret = layer->ops->for_each_metric(layer, pmu);
+		if (ret) {
+			pmu_layer_prune_incomplete_metrics(pmu);
+			return ret;
+		}
+	}
+
+	pmu_layer_prune_incomplete_metrics(pmu);
+	pmu->metrics_loaded = true;
+	return 0;
+}
+
+const char *pmu_layer__describe_metricgroup(struct perf_pmu *pmu,
+					    const char *group)
+{
+	struct perf_pmu_metricgroup *mg = NULL, *old_mg = NULL;
+
+	if (!pmu || !group || !group[0] || group[0] == '.')
+		return NULL;
+
+	if (hashmap__find(pmu->metricgroups, group, &mg))
+		return mg->desc;
+
+	if (pmu_layers_ensure_init())
+		return NULL;
+
+	mg = zalloc(sizeof(*mg));
+	if (!mg)
+		return NULL;
+
+	mg->name = strdup(group);
+	if (!mg->name) {
+		free(mg);
+		return NULL;
+	}
+
+	for (size_t i = 0; i < nr_pmu_layers; i++) {
+		const struct pmu_layer *layer = &pmu_layers[i];
+
+		if (!layer->ops->load_metricgroup)
+			continue;
+		if (layer->ops->load_metricgroup(layer, pmu, group, mg) < 0) {
+			perf_pmu_free_metricgroup(mg);
+			return NULL;
+		}
+		if (mg->desc)
+			break;
+	}
+
+	if (!mg->desc) {
+		perf_pmu_free_metricgroup(mg);
+		return NULL;
+	}
+
+	if (hashmap__set(pmu->metricgroups, mg->name, mg,
+			 /*old_key=*/NULL, &old_mg)) {
+		perf_pmu_free_metricgroup(mg);
+		return NULL;
+	}
+	perf_pmu_free_metricgroup(old_mg);
+	return mg->desc;
+}
diff --git a/tools/perf/util/pmu-layer.h b/tools/perf/util/pmu-layer.h
new file mode 100644
index 000000000000..330af9415448
--- /dev/null
+++ b/tools/perf/util/pmu-layer.h
@@ -0,0 +1,170 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PMU_LAYER_H
+#define __PMU_LAYER_H
+
+#include <stdbool.h>
+#include <stddef.h>
+#include "pmu-events/pmu-events.h"
+
+#define UNIT_MAX_LEN 31 /* max length for event unit name */
+
+struct perf_pmu;
+struct pmu_layer;
+
+enum pmu_event_file_kind {
+	PMU_EVENT_FILE_BASE,
+	PMU_EVENT_FILE_UNIT,
+	PMU_EVENT_FILE_SCALE,
+	PMU_EVENT_FILE_PER_PKG,
+	PMU_EVENT_FILE_SNAPSHOT,
+	PMU_EVENT_FILE_SCALE_UNIT,
+	PMU_EVENT_FILE_DESC,
+	PMU_EVENT_FILE_LONG_DESC,
+	PMU_EVENT_FILE_TOPIC,
+	PMU_EVENT_FILE_COMPAT,
+	PMU_EVENT_FILE_DEPRECATED,
+	PMU_EVENT_FILE_LEGACY_TERMS,
+	PMU_EVENT_FILE_RETIRE_LAT_MEAN,
+	PMU_EVENT_FILE_RETIRE_LAT_MIN,
+	PMU_EVENT_FILE_RETIRE_LAT_MAX,
+};
+
+/**
+ * struct perf_pmu_alias - Internal resolved event entry cached on
+ * struct perf_pmu->aliases (shared only between pmu.c and pmu-layer.c).
+ */
+struct perf_pmu_alias {
+	char *name;
+	char *desc;
+	char *long_desc;
+	char *topic;
+	char *terms;
+	char *legacy_terms;
+	char *pmu_name;
+	char *compat;
+	char unit[UNIT_MAX_LEN + 1];
+	double scale;
+	double retirement_latency_mean;
+	double retirement_latency_min;
+	double retirement_latency_max;
+	bool per_pkg;
+	bool snapshot;
+	bool deprecated;
+	bool legacy_deprecated_checked;
+	bool from_sysfs;
+	bool info_loaded;
+	bool resolved;
+	bool terms_from_legacy;
+	bool has_scale;
+	bool has_unit;
+	bool has_per_pkg;
+	bool has_snapshot;
+	bool has_deprecated;
+	bool has_retire_lat_mean;
+	bool has_retire_lat_min;
+	bool has_retire_lat_max;
+};
+
+enum pmu_metric_file_kind {
+	PMU_METRIC_FILE_BASE,
+	PMU_METRIC_FILE_SCALE_UNIT,
+	PMU_METRIC_FILE_DESC,
+	PMU_METRIC_FILE_LONG_DESC,
+	PMU_METRIC_FILE_GROUP,
+	PMU_METRIC_FILE_NO_GROUP,
+	PMU_METRIC_FILE_DEFAULT_GROUP,
+	PMU_METRIC_FILE_THRESHOLD,
+	PMU_METRIC_FILE_COMPAT,
+	PMU_METRIC_FILE_AGGR_MODE,
+	PMU_METRIC_FILE_CONSTRAINT,
+	PMU_METRIC_FILE_SHOW_EVENTS,
+};
+
+/**
+ * struct perf_pmu_metric - Internal resolved metric entry cached on
+ * struct perf_pmu->metrics (shared only between pmu.c and pmu-layer.c).
+ */
+struct perf_pmu_metric {
+	char *pmu;
+	char *metric_name;
+	char *metric_group;
+	char *metric_expr;
+	char *metric_threshold;
+	char *unit;
+	char *compat;
+	char *desc;
+	char *long_desc;
+	char *metricgroup_no_group;
+	char *default_metricgroup_name;
+	enum aggr_mode_class aggr_mode;
+	enum metric_event_groups event_grouping;
+	bool default_show_events;
+	bool has_aggr_mode;
+	bool has_event_grouping;
+	bool has_default_show_events;
+};
+
+/**
+ * struct perf_pmu_metricgroup - Internal metricgroup description cached on
+ * struct perf_pmu->metricgroups.
+ */
+struct perf_pmu_metricgroup {
+	char *name;
+	char *desc;
+	bool from_builtin;
+};
+
+enum pmu_layer_kind {
+	PMU_LAYER_USER_DIR,
+	PMU_LAYER_BUILTIN_CPU,
+	PMU_LAYER_SYSFS,
+	PMU_LAYER_BUILTIN_COMMON,
+};
+
+struct pmu_layer_ops {
+	int (*find_event)(const struct pmu_layer *layer, struct perf_pmu *pmu,
+			  const char *name, struct perf_pmu_alias *alias);
+	int (*for_each_event)(const struct pmu_layer *layer,
+			      struct perf_pmu *pmu);
+
+	int (*find_metric)(const struct pmu_layer *layer, struct perf_pmu *pmu,
+			   const char *name, struct perf_pmu_metric *metric);
+	int (*for_each_metric)(const struct pmu_layer *layer,
+			       struct perf_pmu *pmu);
+
+	int (*load_metricgroup)(const struct pmu_layer *layer,
+				struct perf_pmu *pmu,
+				const char *group,
+				struct perf_pmu_metricgroup *mg);
+};
+
+struct pmu_layer {
+	enum pmu_layer_kind kind;
+	const struct pmu_layer_ops *ops;
+	char *root_path;
+};
+
+void pmu_layers__exit(void);
+
+enum pmu_event_file_kind pmu_event_file_kind(const char *name, size_t *base_len);
+enum pmu_metric_file_kind pmu_metric_file_kind(const char *name, size_t *base_len);
+void perf_pmu_free_alias(struct perf_pmu_alias *alias);
+void perf_pmu_free_metric(struct perf_pmu_metric *metric);
+void perf_pmu_free_metricgroup(struct perf_pmu_metricgroup *mg);
+void perf_pmu_metric__to_pmu_metric(const struct perf_pmu_metric *src,
+				    struct pmu_metric *dst);
+
+struct perf_pmu_alias *pmu_layer__find_event(struct perf_pmu *pmu,
+					     const char *name);
+int pmu_layer__load_events(struct perf_pmu *pmu);
+int pmu_layer__merge_event_table(struct perf_pmu *pmu,
+				 const struct pmu_events_table *table);
+
+struct perf_pmu_metric *pmu_layer__find_metric(struct perf_pmu *pmu,
+					       const char *name);
+int pmu_layer__load_metrics(struct perf_pmu *pmu);
+
+const char *pmu_layer__describe_metricgroup(struct perf_pmu *pmu,
+					    const char *group);
+
+#endif /* __PMU_LAYER_H */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8baeba49d2e8..685c61935f50 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -26,6 +26,7 @@
 #include "debug.h"
 #include "evsel.h"
 #include "pmu.h"
+#include "pmu-layer.h"
 #include "drm_pmu.h"
 #include "hwmon_pmu.h"
 #include "pmus.h"
@@ -43,8 +44,6 @@
 #include "util/evsel_config.h"
 #include <regex.h>
 
-#define UNIT_MAX_LEN	31 /* max length for event unit name */
-
 enum event_source {
 	/* An event loaded from /sys/bus/event_source/devices/<pmu>/events. */
 	EVENT_SRC_SYSFS,
@@ -57,162 +56,6 @@ enum event_source {
 	EVENT_SRC_SYS_JSON,
 };
 
-enum pmu_event_file_kind {
-	PMU_EVENT_FILE_BASE,
-	PMU_EVENT_FILE_UNIT,
-	PMU_EVENT_FILE_SCALE,
-	PMU_EVENT_FILE_PER_PKG,
-	PMU_EVENT_FILE_SNAPSHOT,
-	PMU_EVENT_FILE_SCALE_UNIT,
-	PMU_EVENT_FILE_DESC,
-	PMU_EVENT_FILE_LONG_DESC,
-	PMU_EVENT_FILE_TOPIC,
-	PMU_EVENT_FILE_COMPAT,
-	PMU_EVENT_FILE_DEPRECATED,
-	PMU_EVENT_FILE_LEGACY_TERMS,
-	PMU_EVENT_FILE_RETIRE_LAT_MEAN,
-	PMU_EVENT_FILE_RETIRE_LAT_MIN,
-	PMU_EVENT_FILE_RETIRE_LAT_MAX,
-};
-
-/**
- * struct perf_pmu_alias - An event either read from sysfs, a directory
- * overlay, or builtin in pmu-events.c, created by parsing the pmu-events json
- * files.
- */
-struct perf_pmu_alias {
-	/** @name: Name of the event like "mem-loads". */
-	char *name;
-	/** @desc: Optional short description of the event. */
-	char *desc;
-	/** @long_desc: Optional long description. */
-	char *long_desc;
-	/**
-	 * @topic: Optional topic such as cache or pipeline, particularly for
-	 * json events.
-	 */
-	char *topic;
-	/** @terms: Owned copy of the event terms. */
-	char *terms;
-	/**
-	 * @legacy_terms: If the event aliases a legacy event, holds a copy
-	 * of the legacy event string.
-	 */
-	char *legacy_terms;
-	/**
-	 * @pmu_name: The name copied from the json struct pmu_event. This can
-	 * differ from the PMU name as it won't have suffixes.
-	 */
-	char *pmu_name;
-	/** @compat: Optional uncore/system PMU identifier match pattern. */
-	char *compat;
-	/** @unit: Units for the event, such as bytes or cache lines. */
-	char unit[UNIT_MAX_LEN + 1];
-	/** @scale: Value to scale read counter values by. */
-	double scale;
-	/** @retirement_latency_mean: Value to be given for unsampled retirement latency mean. */
-	double retirement_latency_mean;
-	/** @retirement_latency_min: Value to be given for unsampled retirement latency min. */
-	double retirement_latency_min;
-	/** @retirement_latency_max: Value to be given for unsampled retirement latency max. */
-	double retirement_latency_max;
-	/**
-	 * @per_pkg: Does the file
-	 * <sysfs>/bus/event_source/devices/<pmu_name>/events/<name>.per-pkg or
-	 * equivalent json value exist and have the value 1.
-	 */
-	bool per_pkg;
-	/**
-	 * @snapshot: Does the file
-	 * <sysfs>/bus/event_source/devices/<pmu_name>/events/<name>.snapshot
-	 * exist and have the value 1.
-	 */
-	bool snapshot;
-	/**
-	 * @deprecated: Is the event hidden and so not shown in perf list by
-	 * default.
-	 */
-	bool deprecated;
-	/**
-	 * @legacy_deprecated_checked: Legacy events may not be supported by the
-	 * PMU and need to be checked. If they aren't supported they are marked
-	 * deprecated.
-	 */
-	bool legacy_deprecated_checked;
-	/** @from_sysfs: Was the alias from sysfs or a json event? */
-	bool from_sysfs;
-	/** @info_loaded: Have the scale, unit and other values been read from disk? */
-	bool info_loaded;
-	/** @resolved: Fully resolved across all PMU layers. */
-	bool resolved;
-	/** @terms_from_legacy: @terms was promoted from @legacy_terms. */
-	bool terms_from_legacy;
-	/** @has_scale: Has scale been explicitly set by a layer? */
-	bool has_scale;
-	/** @has_unit: Has unit been explicitly set by a layer? */
-	bool has_unit;
-	/** @has_per_pkg: Has per_pkg been explicitly set by a layer? */
-	bool has_per_pkg;
-	/** @has_snapshot: Has snapshot been explicitly set by a layer? */
-	bool has_snapshot;
-	/** @has_deprecated: Has deprecated been explicitly set by a layer? */
-	bool has_deprecated;
-	/** @has_retire_lat_mean: Has retirement_latency_mean been explicitly set? */
-	bool has_retire_lat_mean;
-	/** @has_retire_lat_min: Has retirement_latency_min been explicitly set? */
-	bool has_retire_lat_min;
-	/** @has_retire_lat_max: Has retirement_latency_max been explicitly set? */
-	bool has_retire_lat_max;
-};
-
-enum pmu_metric_file_kind {
-	PMU_METRIC_FILE_BASE,
-	PMU_METRIC_FILE_SCALE_UNIT,
-	PMU_METRIC_FILE_DESC,
-	PMU_METRIC_FILE_LONG_DESC,
-	PMU_METRIC_FILE_GROUP,
-	PMU_METRIC_FILE_NO_GROUP,
-	PMU_METRIC_FILE_DEFAULT_GROUP,
-	PMU_METRIC_FILE_THRESHOLD,
-	PMU_METRIC_FILE_COMPAT,
-	PMU_METRIC_FILE_AGGR_MODE,
-	PMU_METRIC_FILE_CONSTRAINT,
-	PMU_METRIC_FILE_SHOW_EVENTS,
-};
-
-/**
- * struct perf_pmu_metric - Owned metric entry cached on struct perf_pmu.
- */
-struct perf_pmu_metric {
-	char *pmu;
-	char *metric_name;
-	char *metric_group;
-	char *metric_expr;
-	char *metric_threshold;
-	char *unit;
-	char *compat;
-	char *desc;
-	char *long_desc;
-	char *metricgroup_no_group;
-	char *default_metricgroup_name;
-	enum aggr_mode_class aggr_mode;
-	enum metric_event_groups event_grouping;
-	bool default_show_events;
-	bool has_aggr_mode;
-	bool has_event_grouping;
-	bool has_default_show_events;
-};
-
-/**
- * struct perf_pmu_metricgroup - Owned metricgroup description cached on
- * struct perf_pmu.
- */
-struct perf_pmu_metricgroup {
-	char *name;
-	char *desc;
-	bool from_builtin;
-};
-
 static int pmu_aliases_parse(struct perf_pmu *pmu);
 
 static struct perf_pmu_format *perf_pmu__new_format(struct list_head *list, char *name)
@@ -408,7 +251,7 @@ static const struct {
 	{ ".retire-lat-mean",	16, PMU_EVENT_FILE_RETIRE_LAT_MEAN },
 };
 
-static enum pmu_event_file_kind pmu_event_file_kind(const char *name, size_t *base_len)
+enum pmu_event_file_kind pmu_event_file_kind(const char *name, size_t *base_len)
 {
 	size_t len = strlen(name);
 
@@ -449,8 +292,7 @@ static const struct {
 	{ ".default-group",	14, PMU_METRIC_FILE_DEFAULT_GROUP },
 };
 
-static __maybe_unused enum pmu_metric_file_kind
-pmu_metric_file_kind(const char *name, size_t *base_len)
+enum pmu_metric_file_kind pmu_metric_file_kind(const char *name, size_t *base_len)
 {
 	size_t len = strlen(name);
 
@@ -583,7 +425,7 @@ static void read_alias_info_at(int events_dir_fd, struct perf_pmu_alias *alias)
 }
 
 /* Delete an alias entry. */
-static void perf_pmu_free_alias(struct perf_pmu_alias *alias)
+void perf_pmu_free_alias(struct perf_pmu_alias *alias)
 {
 	if (!alias)
 		return;
@@ -614,7 +456,7 @@ static void perf_pmu__del_aliases(struct perf_pmu *pmu)
 	pmu->aliases = NULL;
 }
 
-static void perf_pmu_free_metric(struct perf_pmu_metric *metric)
+void perf_pmu_free_metric(struct perf_pmu_metric *metric)
 {
 	if (!metric)
 		return;
@@ -633,7 +475,7 @@ static void perf_pmu_free_metric(struct perf_pmu_metric *metric)
 	free(metric);
 }
 
-static void perf_pmu_free_metricgroup(struct perf_pmu_metricgroup *mg)
+void perf_pmu_free_metricgroup(struct perf_pmu_metricgroup *mg)
 {
 	if (!mg)
 		return;
@@ -643,9 +485,8 @@ static void perf_pmu_free_metricgroup(struct perf_pmu_metricgroup *mg)
 	free(mg);
 }
 
-static __maybe_unused void
-perf_pmu_metric__to_pmu_metric(const struct perf_pmu_metric *src,
-			       struct pmu_metric *dst)
+void perf_pmu_metric__to_pmu_metric(const struct perf_pmu_metric *src,
+				    struct pmu_metric *dst)
 {
 	*dst = (struct pmu_metric){
 		.pmu = src->pmu,
-- 
2.56.1.703.gf848ed807c-goog

