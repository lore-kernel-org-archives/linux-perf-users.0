Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599686;
	b=4LdAItBNhbPqhESwRmVNnNpaHJQ8QBkIpj/c4vzAA2I0vAVddAEjcz5FZuA8C6RRiKI8
	 26bCYdUIIV4UGEU17jvPMdMxWafm3PWm4mbIN5jwq4lWTWgFUMr44GWyzbXkRIW5+lowY
	 9PIlL2ZMrQwWyghqsrYHotYCXaLNeui5nmqt8c5JaNXeOcrWJEcyAiCNACsc2lYDnH/kS
	 yQW8/F4P7vN9qO6RE84CnZ+siw4jc1mAVpwlie6Um/+mKwUF66gKwflP6zSaPdqZRe3o3
	 Gg/0j7vuBEi0jlupCPT43J5Y5RanRuDQSF2Ult/DwKQn1ZjTm8lyJ22BWywmnxLtOdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=DP7GEEgipBOl35E+CuWLaDiax/wuoxuaHmNeGUlvKFc=;
	b=hd2Cnu+X1mbk9Re0gwH29V1uMPXp/4KFn8gWzDukeG9ALmJIKIelnYTRDziT9faDYbKk
	 lDGdAGal2lJ9p4r/g465KxZdS2r1TGZAcDdRfs36r6IdEbmEtX22A78V4hVZHQrtt8yJI
	 XY8p3gE1iWsfUTIJxMPoqiOZYdYkCKrr1CCdpvu1/wQRNJ5rPP8xX+fBZ8Me+E7PmSEIi
	 S/Bkux0LnRkBUXzBxXge6TepN2J02/+f2dYYJrZvUVFL1CTZyMUHzdWxxKBSW3ommujwV
	 1v2cCC7W/QjUZrDM2HaV4FnSVYxB9sqPKyuZvMSLhqeFG2ocY0eWzW8EEJsbZIIaODA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wb6M1R4Q;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549B7606D0C2
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 549B7606D0C2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wb6M1R4Q
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e942b1cc86so12481265ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599685; x=1795204485; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DP7GEEgipBOl35E+CuWLaDiax/wuoxuaHmNeGUlvKFc=;
        b=Wb6M1R4QzwShmgKkvzLrtbdQEx+ayr5mw2WBZqihR9zJXyBoM3a85qTIqcDjMKphGk
         qRuNNHoOjdEI8gN+DykN5YWsDg8AIeoYtcheypP6IpQxpIh2eMvrSdIcM8KwrIGDq6nv
         Vb/1tPyf1LXxqeB5DHw9SnKIXcZfsOqwg8MAP80KRAQkuSsH/yb/nbdkkSDF9HiayrZT
         VJ+6Iz6aCx/jyh0OtqdZ9EgFqCIj4OqSFQW2RK+gRbqNRC+wlp25/BI/cc6WP1ClOk13
         ohc4moOgLAPEJnfbrWo/WYAv8bfHQ0pmCsZwlr5gAzDQdKUFO+bV3WrY6lZ6wta7CJyt
         Pchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599685; x=1795204485;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DP7GEEgipBOl35E+CuWLaDiax/wuoxuaHmNeGUlvKFc=;
        b=p5kfIo9BfgU+tE4njCQxpW9IWHcSNH31+1nlKpCtv7cys0G5PBNUZ4n3rx8D1bBjy1
         +tQkG9VOWGTrXULQQnMDeef70qjZCr28aVjdX5oK3YqqbwEtu/B90/+gTfn8mowRdFjC
         0yzL1d/WZUXOjMiJ9yyogOq5vSsyBrElMZMcfiP5JfWY2QXo3/Z1vXcFimXdrCeMn2G9
         rhOxwvYAlZgrCTD9/q0ZSqZ5TYHXH1kKyMjegi1c2zwow1/liBFdEOz1LMpCYlDHa6YK
         k2zWRbu8toNnnk2IJNImLeVm2Rb1aJS3Q1QN4s+qGfF5cjzgmZEu8m1IBZDWxUGl0q2G
         b2fA==
X-Gm-Message-State: APuU4Z+XwNoE+4A8DlYIQLlXHu9OaBW8kYytxY8j/x6IQasqWCfC91nH
	sx3IkBeWEam5CzBLmGmfqz5A7yEdAp5vmUaOsj78eOE5MLAFknuNwh4vCSjT7aPZ3+Z89SefFSH
	cPB5CWnKIVw==
X-Received: from plbkh3.prod.google.com ([2002:a17:903:643:b0:2ea:a5be:634e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e84a:b0:2ed:d1ff:fa8a
 with SMTP id d9443c01a7336-2ee0dcd0d6dmr30395305ad.36.1794599684519; Fri, 13
 Nov 2026 11:54:44 -0800 (PST)
Date: Fri, 13 Nov 2026 11:53:30 -0800
In-Reply-To: <20261113195335.2865725-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113195335.2865725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195335.2865725-26-irogers@google.com>
Subject: [PATCH v2 25/30] perf pmus: Add perf_pmus__read_from_env()
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/env.c    |  18 +++
 tools/perf/util/env.h    |   5 +
 tools/perf/util/header.c |  23 ++++
 tools/perf/util/pmu.c    |  31 ++++++
 tools/perf/util/pmu.h    |   9 ++
 tools/perf/util/pmus.c   | 234 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmus.h   |  15 ++-
 7 files changed, 334 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index fec6a5a8ecb6..04f4db90cc60 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -341,6 +341,24 @@ struct perf_env *host_env(void)
 
 struct perf_pmus *perf_env__pmus(struct perf_env *env)
 {
+	struct perf_env *host = host_env();
+
+	if (env == host ||
+	    !(env->nr_pmu_mappings || env->nr_hybrid_nodes ||
+	      env->nr_cpu_pmu_caps || env->nr_pmus_with_caps)) {
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
index a442f2a904a9..3708a311e805 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -5765,6 +5765,29 @@ int perf_event__process_feature(const struct perf_tool *tool __maybe_unused,
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
index 381189acfd4a..6db7d7df9c26 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2573,6 +2573,37 @@ static int perf_pmu__new_caps(struct list_head *list, char *name, char *value)
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
index 6d68371107aa..b924ff6180e4 100644
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
@@ -981,3 +984,234 @@ struct perf_pmu *perf_pmus__fake_pmu(void)
 
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
+			pmu->is_uncore = false;
+			pmu->is_uncore = !pmu->is_core && !pmu->auxtrace &&
+					 !perf_pmu__is_software(pmu) &&
+					 perf_pmu__kind(pmu) == PERF_PMU_KIND_PE;
+			if (!pmu->is_core && !pmu->is_uncore &&
+			    pmu->events_table == core_table)
+				pmu->events_table = NULL;
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
+	pmu->is_core = env_is_pmu_core(name, env);
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
+	else if (core_table && (pmu->is_core || pmu->is_uncore))
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
+			if (!pmu->events_table && core_table)
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
2.56.1.703.gf848ed807c-goog

