Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749543;
	b=d/OU64U1HeQpNelJBDb8e5CLklb1FAj1Utdo2Ude4Xt3UlMV5qjsWkwNCsLYtOZkP2gi
	 wjtBV2WyJC3Xl+A/60gqoGXMEabL6D7nfzfWyqXSnJVSAuu6CI8u9ZSctodSr294mgTic
	 cfC6gzak5p3iFR84xzpwZdUh3fOYD8qaw5xAPkOFzSyCW0OZ7IFfvIhHHB1OIb+j8GQXD
	 rW/s1yet3lkpkpN2bL/Vkff447Nl3AmMSc2LXTGFHqzfjAlzvQGxUFD+lI/PTW68C4j0Z
	 jf6nAFj+P2TyqpHjdRvpoTSocLbRxewyg9gxF79gzsW+Rttw/YlcptvjiJNfmD4l3rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749543;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=nIMJ9hdciBH4J+KtRQhktMuL7c1HadCWq4L+Y0lVVOc=;
	b=K3E3srAQ7lWXhRNxGMFX1lmXJECQ+bNGL/2VUaVoXXe/VBqDPVOO332kOutg/q8uO/sa
	 GgqICgXI8kDLNN7JUcHyZaz4Z5LxSuhtrZM9fQaOp+uTdTErDScaBq31xbEtOpUcLTpLo
	 x1PD7Fmtsa8HF7n/HHZ6e7LvJ7MuYcJ4PWeqIwrWCIgd/E7VnU87Jf3gd6fskQo5C7iE7
	 UWrKQWcK6ULr0jZ6djkwXJ9YwHnmg9eXJ+ttGUcW1U+l+L47knUIr0xxsXF5iYAGBoxaL
	 L+D4MQjOTDpdVMTxnqdWoANqNJlkdgOCayl+QClApDlKJ/IMd/wGTMAIfD9sisfmyvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bLylMLmi;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5E606D83C
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50F5E606D83C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bLylMLmi
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-16bc6f3fdb1so195495c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749542; x=1794354342; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nIMJ9hdciBH4J+KtRQhktMuL7c1HadCWq4L+Y0lVVOc=;
        b=bLylMLmil34bfKtQKIHqLPz9ULAOD3gf0b6AyatjkaRnSsNo5K5UE66yy0v4PyPZYP
         hD4ZpN5r+aQSb803QxsQFY42JMgk5NU+FiFRS6B20crsLMv7VTz9dwmgpjXLDPHXonve
         a2MX6OthSKZ9ULK9khAoWtXm2RQxdBxzGxeLS7KzMy5yxk6ykAkmCjDujDbZ8nFrt5sz
         Kq5kGr3vJHYulqAYASQRkOCRTFVOEN6utA7EXhMGoeyZ0huUdMFEv9l6wxkK8CTBoBKi
         3yIzVYfGYtAaAoCHUNsxdva5sYSSMEWsm4HvWccGSFRQs0cLShQYT7I2D+8VTk7AMBOW
         RIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749542; x=1794354342;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nIMJ9hdciBH4J+KtRQhktMuL7c1HadCWq4L+Y0lVVOc=;
        b=Wsf479OMhwor8hdKdKhXB7PDFCFtoWZ9XITLcHrvGXgyBIGcHGhXUTynBHk3CI/zHV
         UeKDcpOzXvWN0fsyllCqBvqyzKSqGC4UFlWS2hAY0R7EMSnAF4s0yxzNnaaYq1Etq7bZ
         dqPmrxV1ZkWFTRUukkmJvknsk17fhJ7c+Ix8iojBcZY3NOoc0IR74YYGpiB+mnJUH+Vo
         4PIFJ6Ef7vBuPkwGxHTVhk1rtOmA9XycCBctZcRByibhq735KmwY0Ea1F+syOK30lnrS
         Iq3OWxgjaEUidGradtm3LtzWKMOKS/6MZjNCJqLHFh7u5feLkT5MKI5guoHv92XxugEi
         ecqA==
X-Gm-Message-State: APuU4Z/qpCrAvua2FtMCNlPf8Kk/o0obE2Fth+fOBalhaPFySYs/8f3U
	lHS6Fc1vRoj3QFrm7IVmyMZyT/y3ALsQL2vjGnXMJ7tVrKmM/RD8XEtAJ0k7QUsCjr+8at8Gylm
	+2gLaMC3uGK7KA34OyxXA6QWGNxgk+bQuSNjh/bhHZeltAv8xZrqbEwj856sy/NGFNeCrnbj0UO
	ZtG3al7c+lUaecAz/hWL/OuFvlgJq9A9hUVYhEJTwU+5y2pJ4PAyUw07Y=
X-Received: from dlbqc8.prod.google.com ([2002:a05:7023:a88:b0:1ab:a092:67c3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3f0b:b0:1b1:f02b:232c
 with SMTP id a92af1059eb24-1b1f03a6a35mr11981767c88.29.1793749541973; Tue, 03
 Nov 2026 15:45:41 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:29 -0800
In-Reply-To: <20261103234502.1008382-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103234502.1008382-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103234502.1008382-14-irogers@google.com>
Subject: [PATCH v1 13/41] perf pmus: Add perf_pmus__read_from_env()
From: Ian Rogers <irogers@google.com>
To: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, John Garry <john.garry@linux.dev>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ian Rogers <irogers@google.com>
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
 tools/perf/util/env.c    |  18 ++++
 tools/perf/util/env.h    |   5 +
 tools/perf/util/header.c |  22 ++++
 tools/perf/util/pmu.c    |  31 ++++++
 tools/perf/util/pmu.h    |   9 ++
 tools/perf/util/pmus.c   | 219 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmus.h   |  15 ++-
 7 files changed, 318 insertions(+), 1 deletion(-)

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
index a442f2a904a9..27fc21fa3a6a 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -5765,6 +5765,28 @@ int perf_event__process_feature(const struct perf_tool *tool __maybe_unused,
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
index 06c4912d2f65..ee52fd18c927 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2570,6 +2570,37 @@ static int perf_pmu__new_caps(struct list_head *list, char *name, char *value)
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
index 7605c3859337..06f922ce1f68 100644
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
index c3a695ebf2ba..908959abbd3d 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -7,7 +7,9 @@
 #include <subcmd/pager.h>
 #include <sys/types.h>
 #include <ctype.h>
+#include <errno.h>
 #include <pthread.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
@@ -980,3 +982,220 @@ struct perf_pmu *perf_pmus__fake_pmu(void)
 
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
+	if (!env || !strcmp(perf_env__arch(env), perf_env__arch(host_env())))
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
+	if (pmu) {
+		if (pmu->type == PERF_PMU_TYPE_FAKE && type != PERF_PMU_TYPE_FAKE) {
+			pmu->type = type;
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
2.56.0.385.gac671c819a-goog

