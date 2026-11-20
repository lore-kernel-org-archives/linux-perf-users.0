Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212949;
	b=KHytEsbXCeGZQ5o8O8jYL4v5MkAxhTDgHa1XQlSzrj2ohn3ysoisg/5t9mBbafKNfGMT
	 jofTEg+0RxiLSGSyLAMatge66I3EuFL1TbIcKIAJtqPrHxFRQkcmSgkQvNB6EeK/KYSJf
	 tILW6Tu/u2Sxqpe37tzn7dP9tCZ6GuXGTSy6UzStBQbCg4I4FYoPqzAacmcGvkptg5MnI
	 yGjBOaD2Tw3Po1KWSblHEu9DJbLcdlmZJR+/oRW6AyWFb/aa0E4/WpiR5td9Gj4fXXBH+
	 98nB9oVxoJ0ad+xregYjRxn0BBniEiLtZHqTOGnO4ojjPo8VzRj6px3V/rqNHCdCqzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212949;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=VdpcP9WP0vVl+tdJg7sdWbUAUkv/2aKzpjU1W/XHBiI=;
	b=C2FgWuOjmaAgn3iDEoLrwxCXJdzZaaRdniZiXxMDkZFxMkj+GPQJCtAJnSrvTmrOl474
	 3k2KszlYSARgHHBiS+4NMgjoG6ofSbuiUmnq9qNFfTwRBed1GNrhpUv+AyCNDYuXXutxL
	 c+CHVwVZGtuYo8aCsfpDTJ8hIf0mRBusZIghmDs1OphKVoqGb4n1O9jbs0TkcrhrFU+ow
	 BEqMHnXTtesXPA+Hm7RajBEbNieIYTJji46F4UWXeoMAe23dU3wXY5SM9PBqYyiQkiulg
	 NZo2gY0kNk8QY2JG1qrU2+OJDvahI7HVba3idph7TnhXwr7Gc/93jR1PVYY65W6xDqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dRNAO7pv;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF49D60A260C
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF49D60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dRNAO7pv
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3869865a304so926546eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795212945; x=1795817745; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VdpcP9WP0vVl+tdJg7sdWbUAUkv/2aKzpjU1W/XHBiI=;
        b=dRNAO7pvO5sHlaZSfZHkcK+1/qjhi9FF9pKDrMzGmDUkztTDwBD2HkGvbcXEjVX7vN
         mhdzvJ+V0+EJI4qNokiY0vy6SQyzWExF7pzFMz4GKHooqsFEu13awhrP2S7bDr/hq6ve
         YMk6pWkREedNeZOLSKK9nVrflCbch4uCB+bCNznajevZxrjBQqE6NZkNGSDuH2oq8OHa
         +/GGiPWnj2AxwbWAlQCaMOlZlR6733nuCwBWWAqRQD4XD+dy1eme2RAMxmUDXarftKA/
         7vsWI5dLjaurdVBti8cCgRV2uZmkkRlrBNTOYXFia/tPjpmrwBVgTup+jgzMdD9jH5kV
         Jd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212945; x=1795817745;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VdpcP9WP0vVl+tdJg7sdWbUAUkv/2aKzpjU1W/XHBiI=;
        b=rIvMwct+YgTgNDpZII1vD+dUmxsXiKO8Rkntt/y1eZwbNAUT1gJUZ9FZR08ZTNn75V
         +JXe9+YhtaT4yVKPHwQfdFwN5TdQ+lmRkL2doGtr8TIX8WZAcXrX2v3A3GQ/Ufrr/v6f
         KET6+1FDnr7iLJ5Wm0HnCJOBM39MFsA4qwhMQ6YA3HfhPFEGHZBkk9hoqzirOrIfy/T2
         MxJ7l2qpGvKpv8/xAo06k5HAXh6+FwzHLto+ppW9pSfQVspT11ZVjCPTTLvnaTnd3CRt
         3wW2yN1Rvep2zo8g+QGXmuy6TI8LzpeALEXYD7v1o0npX6GPSyNSdCwDst6UPvgwB7E+
         RjoA==
X-Gm-Message-State: APuU4Z/z+tvIZBHhdnwnshwZ3D8T51J0FsnRgIXklC3zyMACBCyWmhTs
	HBtgWO2Tw27XIAIhSabhyl4XBVm0/Um17QRs5BrNsNBQuHT25aoxJynyh2tARNCqofSCZx1AU3U
	W0gftoGdB0w==
X-Received: from dyu12.prod.google.com ([2002:a05:693c:810c:b0:35d:1771:4816])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d583:b0:380:d99d:ce1d
 with SMTP id 5a478bee46e88-386992b3fdemr876018eec.15.1795212944703; Fri, 20
 Nov 2026 14:15:44 -0800 (PST)
Date: Fri, 20 Nov 2026 14:13:26 -0800
In-Reply-To: <20261120221332.2245191-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120221332.2245191-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120221332.2245191-26-irogers@google.com>
Subject: [PATCH v3 25/30] perf pmus: Add perf_pmus__read_from_env()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add perf_pmus__read_from_env() and perf_pmu__add_cap() to reconstruct
core_pmus and other_pmus lists and their capabilities in a
struct perf_pmus from HEADER_PMU_MAPPINGS, HEADER_HYBRID_TOPOLOGY,
HEADER_PMU_CAPS, and HEADER_CPU_PMU_CAPS in a perf.data header
environment, and lazily populate env->pmus in perf_env__pmus(). An
environment without any PMU header metadata, such as one used while
recording, falls back to the live host's PMUs rather than re-reading
sysfs into its own copy.

Ensure core_pmus is never left empty by creating a fallback "cpu" core
PMU when no core PMU was found in the headers. Because perf.data headers
do not record sysfs format definitions, only attach core_table to PMUs
with matching entries and teach perf_pmu__for_each_name_from_config() to
delegate to a matching live host PMU or fall back to legacy hardware and
cache event names.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/env.c    |  19 +++
 tools/perf/util/env.h    |   5 +
 tools/perf/util/header.c |  23 ++++
 tools/perf/util/pmu.c    |  56 ++++++++-
 tools/perf/util/pmu.h    |   9 ++
 tools/perf/util/pmus.c   | 247 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmus.h   |  15 ++-
 7 files changed, 372 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index fec6a5a8ecb6..a6f0baef3ccf 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -341,6 +341,25 @@ struct perf_env *host_env(void)
 
 struct perf_pmus *perf_env__pmus(struct perf_env *env)
 {
+	struct perf_env *host = host_env();
+
+	if (env == host ||
+	    (env->pmus.read_pmu_types == 0 &&
+	     !(env->nr_pmu_mappings || env->nr_hybrid_nodes ||
+	       env->nr_cpu_pmu_caps || env->nr_pmus_with_caps))) {
+		/* No PMU metadata of its own, use the live host's PMUs. */
+		return &host->pmus;
+	}
+
+	mutex_lock(&env->lock);
+	if (!env->pmus.core_pmus.next || !env->pmus.other_pmus.next)
+		perf_pmus__init(&env->pmus);
+	mutex_unlock(&env->lock);
+
+	mutex_lock(&env->pmus.lock);
+	if (env->pmus.read_pmu_types == 0)
+		perf_pmus__read_from_env(&env->pmus, env);
+	mutex_unlock(&env->pmus.lock);
 	return &env->pmus;
 }
 
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index e38e953060c9..ef583161583f 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -238,6 +238,11 @@ struct perf_env *host_env(void);
  * perf_env__pmus() - Return the struct perf_pmus associated with @env.
  * @env: Environment whose PMU collection to retrieve.
  *
+ * For non-host environments with PMU header metadata (HEADER_PMU_MAPPINGS,
+ * HEADER_HYBRID_TOPOLOGY, HEADER_CPU_PMU_CAPS or HEADER_PMU_CAPS), lazily
+ * populates @env->pmus from the perf.data header on first access. If @env has
+ * no PMU metadata of its own, falls back to the live host's PMU collection.
+ *
  * Return: Pointer to the struct perf_pmus for @env.
  */
 struct perf_pmus *perf_env__pmus(struct perf_env *env);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index c1f77babcb70..48b7a86f6f9d 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -5762,6 +5762,29 @@ int perf_event__process_feature(const struct perf_tool *tool __maybe_unused,
 		goto out;
 	}
 
+	switch (feat) {
+	case HEADER_ARCH:
+	case HEADER_CPUID:
+	case HEADER_NRCPUS:
+	case HEADER_PMU_MAPPINGS:
+	case HEADER_CPU_PMU_CAPS:
+	case HEADER_HYBRID_TOPOLOGY:
+	case HEADER_PMU_CAPS:
+	case HEADER_E_MACHINE:
+		mutex_lock(&header->env.pmus.lock);
+		if (session->evlist) {
+			struct evsel *evsel;
+
+			evlist__for_each_entry(session->evlist, evsel)
+				evsel->pmu = NULL;
+		}
+		perf_pmus__exit(&header->env.pmus);
+		mutex_unlock(&header->env.pmus.lock);
+		break;
+	default:
+		break;
+	}
+
 	if (session->tool->show_feat_hdr) {
 		if (!feat_ops[feat].full_only ||
 		    session->tool->show_feat_hdr >= SHOW_FEAT_HEADER_FULL_INFO) {
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b4541fbfc9c0..1d3cfa082347 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2250,7 +2250,7 @@ static bool perf_pmu_alias__check_deprecated(struct perf_pmu *pmu, struct perf_p
 	const char *check_terms;
 	bool has_legacy_config;
 
-	if (alias->legacy_deprecated_checked)
+	if (pmu->from_env || alias->legacy_deprecated_checked)
 		return alias->deprecated;
 
 	alias->legacy_deprecated_checked = true;
@@ -2583,6 +2583,37 @@ static int perf_pmu__new_caps(struct list_head *list, char *name, char *value)
 	return -ENOMEM;
 }
 
+int perf_pmu__add_cap(struct perf_pmu *pmu, const char *name, const char *value)
+{
+	struct perf_pmu_caps *caps;
+
+	if (!pmu || !name || !value)
+		return -EINVAL;
+	if (perf_pmu__get_cap(pmu, name))
+		return 0;
+
+	caps = zalloc(sizeof(*caps));
+	if (!caps)
+		return -ENOMEM;
+
+	caps->name = strdup(name);
+	if (!caps->name) {
+		free(caps);
+		return -ENOMEM;
+	}
+	caps->value = strdup(value);
+	if (!caps->value) {
+		zfree(&caps->name);
+		free(caps);
+		return -ENOMEM;
+	}
+	list_add_tail(&caps->list, &pmu->caps);
+	pmu->nr_caps++;
+	if (!strcmp(name, "max_precise"))
+		pmu->max_precise = atoi(value);
+	return 0;
+}
+
 static void perf_pmu__del_caps(struct perf_pmu *pmu)
 {
 	struct perf_pmu_caps *caps, *tmp;
@@ -2881,6 +2912,28 @@ int perf_pmu__for_each_name_from_config(struct perf_pmu *pmu, __u32 type, u64 co
 	if (!pmu)
 		return 0;
 
+	/*
+	 * PMUs reconstructed from perf.data headers lack sysfs format files, so
+	 * format-based JSON aliases cannot be parsed directly. Delegate to the
+	 * matching live host PMU when available, otherwise only resolve legacy
+	 * hardware and cache encodings.
+	 */
+	if (pmu->from_env && list_empty(&pmu->format) &&
+	    pmu->events_table != perf_pmu__default_core_events_table()) {
+		struct perf_pmu *host_pmu =
+			perf_pmus__find(perf_env__pmus(host_env()), pmu->name);
+
+		if (host_pmu && !host_pmu->from_env &&
+		    host_pmu->events_table == pmu->events_table &&
+		    (pmu->events_table || !pmu->is_core)) {
+			__u32 match_type = (type == pmu->type) ? host_pmu->type : type;
+
+			return perf_pmu__for_each_name_from_config(host_pmu, match_type,
+								   config, cb, data);
+		}
+		goto legacy_names;
+	}
+
 	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
 	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
@@ -2894,6 +2947,7 @@ int perf_pmu__for_each_name_from_config(struct perf_pmu *pmu, __u32 type, u64 co
 		if (ret)
 			return ret;
 	}
+legacy_names:
 	if (pmu->is_core && (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE)) {
 		struct legacy_name_args args = {
 			.type = type,
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index ab7123964423..b556ec51fdeb 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -334,6 +334,15 @@ bool pmu_uncore_identifier_match(const char *compat, const char *id);
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
 struct perf_pmu_caps *perf_pmu__get_cap(struct perf_pmu *pmu, const char *name);
+/**
+ * perf_pmu__add_cap() - Add a name/value capability entry to @pmu->caps.
+ * @pmu: The PMU to add the capability to.
+ * @name: Capability name.
+ * @value: Capability value string.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int perf_pmu__add_cap(struct perf_pmu *pmu, const char *name, const char *value);
 
 int perf_pmu__caps_parse(struct perf_pmu *pmu);
 
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 1c3cb53c3d4f..c5ef22ef00dc 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -7,13 +7,16 @@
 #include <subcmd/pager.h>
 #include <sys/types.h>
 #include <ctype.h>
+#include <errno.h>
 #include <pthread.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
 #include "cpumap.h"
 #include "debug.h"
 #include "drm_pmu.h"
+#include "dwarf-regs.h"
 #include "env.h"
 #include "evsel.h"
 #include "pmus.h"
@@ -1004,3 +1007,247 @@ struct perf_pmu *perf_pmus__fake_pmu(void)
 
 	return &fake;
 }
+
+/*
+ * Determine whether a PMU name reconstructed from perf.data headers is a
+ * core PMU, checking common core PMU prefixes, hybrid topology nodes, and
+ * the host architecture's is_pmu_core() when architectures match.
+ */
+static bool env_is_pmu_core(const char *name, struct perf_env *env)
+{
+	if (!strcmp(name, "cpu") || !strcmp(name, "cpum_cf") ||
+	    !strcmp(name, "default_core") || !strcmp(name, "arc_pct") ||
+	    strstarts(name, "cpu_") || strstarts(name, "armv") ||
+	    (strstarts(name, "apple_") && strstr(name, "_pmu")))
+		return true;
+
+	if (env && env->hybrid_nodes) {
+		for (int i = 0; i < env->nr_hybrid_nodes; i++) {
+			const char *pmu_name = env->hybrid_nodes[i].pmu_name;
+
+			if (pmu_name && !strcmp(name, pmu_name))
+				return true;
+		}
+		return false;
+	}
+
+	if (!env || e_machine__same_arch(perf_env__e_machine(env, /*e_flags=*/NULL),
+					 perf_env__e_machine(host_env(), /*e_flags=*/NULL)))
+		return is_pmu_core(name);
+
+	return false;
+}
+
+/*
+ * Look up @name in @pmus or allocate and initialize a new perf_env-backed
+ * struct perf_pmu, upgrading PERF_PMU_TYPE_FAKE if a real type is later
+ * discovered.
+ */
+static struct perf_pmu *env_pmu_find_or_add(struct perf_pmus *pmus,
+					    const char *name, __u32 type,
+					    struct perf_env *env,
+					    const struct pmu_events_table *core_table)
+{
+	struct perf_pmu *pmu = pmu_find(pmus, name);
+
+	if (type == PERF_PMU_TYPE_FAKE) {
+		if (!strcmp(name, "software"))
+			type = PERF_TYPE_SOFTWARE;
+		else if (!strcmp(name, "tracepoint"))
+			type = PERF_TYPE_TRACEPOINT;
+		else if (!strcmp(name, "breakpoint"))
+			type = PERF_TYPE_BREAKPOINT;
+		else if (!strcmp(name, "tool"))
+			type = PERF_PMU_TYPE_TOOL;
+	}
+
+	if (pmu) {
+		if (pmu->type == PERF_PMU_TYPE_FAKE && type != PERF_PMU_TYPE_FAKE) {
+			pmu->type = type;
+			if (!pmu->is_core && type == PERF_TYPE_RAW) {
+				pmu->is_core = true;
+				list_move_tail(&pmu->list, &pmus->core_pmus);
+			}
+			pmu->is_uncore = !pmu->is_core && !pmu->auxtrace &&
+					 !perf_pmu__is_software(pmu) &&
+					 perf_pmu__kind(pmu) == PERF_PMU_KIND_PE;
+			if (!pmu->is_core && !pmu->is_uncore &&
+			    pmu->events_table == core_table) {
+				pmu->events_table = NULL;
+			} else if (!pmu->events_table && (pmu->is_core || pmu->is_uncore) &&
+				   pmu_events_table__num_events(core_table, pmu) > 0) {
+				pmu->events_table = core_table;
+			}
+		}
+		return pmu;
+	}
+
+	pmu = zalloc(sizeof(*pmu));
+	if (!pmu)
+		return NULL;
+
+	if (perf_pmu__init(pmu, type, name, /*from_env=*/true) != 0) {
+		perf_pmu__delete(pmu);
+		return NULL;
+	}
+
+	pmu->pmus = pmus;
+	pmu->sysfs_aliases_loaded = true;
+	pmu->caps_initialized = true;
+	pmu->max_precise = -1;
+	pmu->is_core = type == PERF_TYPE_RAW || env_is_pmu_core(name, env);
+	pmu->auxtrace = !strcmp(name, "intel_pt") ||
+			!strcmp(name, "intel_bts") ||
+			!strcmp(name, "cs_etm") ||
+			strstarts(name, "arm_spe") ||
+			strstarts(name, "hisi_ptt");
+	pmu->is_uncore = !pmu->is_core && !pmu->auxtrace &&
+			 !perf_pmu__is_software(pmu) &&
+			 (perf_pmu__kind(pmu) == PERF_PMU_KIND_PE ||
+			  pmu->type == PERF_PMU_TYPE_FAKE);
+
+	if (!strcmp(name, "software") || !strcmp(name, "tool"))
+		pmu->events_table = perf_pmu__default_core_events_table();
+	else if ((pmu->is_core || pmu->is_uncore) &&
+		 pmu_events_table__num_events(core_table, pmu) > 0)
+		pmu->events_table = core_table;
+
+	list_add_tail(&pmu->list, pmu->is_core ? &pmus->core_pmus : &pmus->other_pmus);
+	return pmu;
+}
+
+/* Parse "key=value" capability strings from perf_env into @pmu->caps. */
+static void env_pmu_add_caps_strings(struct perf_pmu *pmu, int nr_caps, char **caps)
+{
+	if (!pmu || nr_caps <= 0 || !caps)
+		return;
+
+	for (int i = 0; i < nr_caps; i++) {
+		const char *eq;
+
+		if (!caps[i])
+			continue;
+		eq = strchr(caps[i], '=');
+
+		if (eq) {
+			char *key = strndup(caps[i], eq - caps[i]);
+
+			if (key) {
+				perf_pmu__add_cap(pmu, key, eq + 1);
+				free(key);
+			}
+		} else {
+			perf_pmu__add_cap(pmu, caps[i], "");
+		}
+	}
+}
+
+int perf_pmus__read_from_env(struct perf_pmus *pmus, struct perf_env *env)
+{
+	const struct pmu_events_table *core_table = NULL;
+	struct perf_pmu *pmu;
+
+	if (!pmus || !env)
+		return -EINVAL;
+
+	perf_pmus__exit(pmus);
+	pmus->read_pmu_types = PERF_TOOL_PMU_TYPE_ALL_MASK;
+
+	if (env->cpuid)
+		core_table = find_core_events_table(perf_env__e_machine(env, /*e_flags=*/NULL),
+						    env->cpuid);
+
+	/* 1. Populate from HEADER_PMU_MAPPINGS */
+	if (env->nr_pmu_mappings > 0 && env->pmu_mappings) {
+		char *str = env->pmu_mappings;
+
+		for (int i = 0; i < env->nr_pmu_mappings; i++) {
+			char *colon = NULL;
+			unsigned long type = strtoul(str, &colon, 0);
+
+			if (!colon || *colon != ':')
+				break;
+			str = colon + 1;
+			env_pmu_find_or_add(pmus, str, (__u32)type, env, core_table);
+			str += strlen(str) + 1;
+		}
+	}
+
+	/* 2. Populate/enrich from HEADER_HYBRID_TOPOLOGY */
+	for (int i = 0; i < env->nr_hybrid_nodes; i++) {
+		struct hybrid_node *hn = &env->hybrid_nodes[i];
+
+		if (!hn->pmu_name)
+			continue;
+		pmu = env_pmu_find_or_add(pmus, hn->pmu_name, PERF_PMU_TYPE_FAKE,
+					  env, core_table);
+		if (!pmu)
+			continue;
+		if (!pmu->is_core) {
+			pmu->is_core = true;
+			pmu->is_uncore = false;
+			if (!pmu->events_table &&
+			    pmu_events_table__num_events(core_table, pmu) > 0)
+				pmu->events_table = core_table;
+			list_move_tail(&pmu->list, &pmus->core_pmus);
+		}
+		if (hn->cpus && !pmu->cpus)
+			pmu->cpus = perf_cpu_map__new(hn->cpus);
+	}
+
+	/* 3. Populate/enrich from HEADER_PMU_CAPS */
+	for (int i = 0; i < env->nr_pmus_with_caps; i++) {
+		struct pmu_caps *pc = &env->pmu_caps[i];
+
+		if (!pc->pmu_name)
+			continue;
+		pmu = env_pmu_find_or_add(pmus, pc->pmu_name, PERF_PMU_TYPE_FAKE,
+					  env, core_table);
+		if (pmu)
+			env_pmu_add_caps_strings(pmu, pc->nr_caps, pc->caps);
+	}
+
+	/*
+	 * 4. Populate/enrich from HEADER_CPU_PMU_CAPS.
+	 * HEADER_CPU_PMU_CAPS holds the capabilities of the first core PMU,
+	 * named "cpu" on x86 but e.g. "armv8_pmuv3_0" or "cpum_cf" elsewhere.
+	 * On hybrid systems it duplicates the first core PMU's entry in
+	 * HEADER_PMU_CAPS. Attach the capabilities to "cpu" if present,
+	 * otherwise to the first core PMU when it has no capabilities yet,
+	 * creating a "cpu" PMU only if no core PMUs exist.
+	 */
+	if (env->nr_cpu_pmu_caps > 0 && env->cpu_pmu_caps) {
+		pmu = pmu_find(pmus, "cpu");
+		if (!pmu && !list_empty(&pmus->core_pmus)) {
+			/* Match the writer's perf_pmus__find_core_pmu() order. */
+			list_sort(NULL, &pmus->core_pmus, pmus_cmp);
+			pmu = list_first_entry(&pmus->core_pmus, struct perf_pmu, list);
+			if (pmu->nr_caps > 0)
+				pmu = NULL;
+		} else if (!pmu) {
+			pmu = env_pmu_find_or_add(pmus, "cpu", PERF_TYPE_RAW,
+						  env, core_table);
+		}
+		if (pmu)
+			env_pmu_add_caps_strings(pmu, env->nr_cpu_pmu_caps, env->cpu_pmu_caps);
+	}
+
+	/* Ensure core_pmus is non-empty, matching pmu_read_sysfs()'s placeholder. */
+	if (list_empty(&pmus->core_pmus))
+		env_pmu_find_or_add(pmus, "cpu", PERF_TYPE_RAW, env, core_table);
+
+	/* 5. Set default core CPUs on non-hybrid systems */
+	if (env->nr_cpus_avail > 0 && env->nr_hybrid_nodes == 0) {
+		char buf[64];
+
+		snprintf(buf, sizeof(buf), "0-%d", env->nr_cpus_avail - 1);
+		list_for_each_entry(pmu, &pmus->core_pmus, list) {
+			if (!pmu->cpus)
+				pmu->cpus = perf_cpu_map__new(buf);
+		}
+	}
+
+	list_sort(NULL, &pmus->core_pmus, pmus_cmp);
+	list_sort(NULL, &pmus->other_pmus, pmus_cmp);
+	return 0;
+}
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 6e7c9f857aaf..2b784cf648f3 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -8,6 +8,7 @@
 #include "mutex.h"
 
 struct perf_event_attr;
+struct perf_env;
 struct perf_pmu;
 struct print_callbacks;
 
@@ -49,7 +50,10 @@ struct perf_pmus {
 	 * encoding in perf_event_attr::config is supported.
 	 */
 	enum perf_pmus_extended_type extended_type;
-	/** @lock: Protects lazy initialization of @extended_type. */
+	/**
+	 * @lock: Protects lazy initialization of @extended_type and
+	 * perf_pmus__read_from_env().
+	 */
 	struct mutex lock;
 };
 
@@ -75,6 +79,15 @@ void perf_pmus__init(struct perf_pmus *pmus);
  */
 void perf_pmus__exit(struct perf_pmus *pmus);
 
+/**
+ * perf_pmus__read_from_env() - Populate @pmus from perf.data header metadata.
+ * @pmus: The PMU collection to populate.
+ * @env: The perf_env containing header PMU mappings, hybrid topology, and caps.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int perf_pmus__read_from_env(struct perf_pmus *pmus, struct perf_env *env);
+
 /**
  * perf_pmus__find() - Find a PMU by name in @pmus.
  * @pmus: The PMU collection to search.
-- 
2.56.1.750.gf70dc682cf-goog

