Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599632;
	b=qLv9XYkWU+mUxQ3o6R0nwGjL6Qt96/Zkp4bdff7IyHTwZtaYctf0PmDx+YPE0iRde/xP
	 9LpmG9YnkIw0rgEwAvOEdC935I/5D+BWB0vbU1sSf5csBuj34kN+raYGKCawGwx6RYhDs
	 LvoTmp0P4rx9zICjYL+dbRVWMfpWeDldvCle7ZFmJvDvvLmLo8zWtVwv/LJCAE7oaKIG0
	 Dm8o7sqUNcv+zI5BlD+pMmMIeR6/knYEN5o/uyAHj2r/YqISvB3/ranBbzsh8YreIw5lZ
	 zLZsUoPhMpvLR2hI4fzQkT4TNI7HX+m/W9mgdImghkp2GJJP3N6ys4g1fTQqxE/YMfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=elSjDda1eUGYP7L0T1a5ytEO6RwVU73u/iOHfi0NJMo=;
	b=t7Mkn3cXrJDprnJBnSaabXQd8IcdN7GMVNtkl0xEt4rkjdup0CAt7ESsLtBMy3t9L9lc
	 M8M/rjaPnH8znKYldAMO2srzaDrTsEk7E9/32DUOFgaEVxaqi9nuUEzWML2K0YD1xWrLG
	 SsRHG8/YkOHoqOXG0a/lC3XxxJptYSx6zNUnNnQOt6kvwlpiwavUSDojN0kHdyTonUx3F
	 cK/yikHo024jqkcQgJ3D/dYFgBuYAdbgwmMjeaJ5KKVZ/KMJm4doJUouiRMNCYaV4pWsc
	 C39XZMVhEz62n0wAYyVGKRxilJVwAECjXRoCUHaL6B85WCd1hywfWAh8hltI6ygBSUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gBlXDnNZ;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C73606A893
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56C73606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gBlXDnNZ
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso1728874eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599631; x=1795204431; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=elSjDda1eUGYP7L0T1a5ytEO6RwVU73u/iOHfi0NJMo=;
        b=gBlXDnNZsTZve/NMkbnDRwCi24zPgXem+kRiLFztk8Ml1IQUcObOPfxjKstCLBF/Gw
         EvKAgPo5etldjfSsVdll5fbEnIVch640UzlD5+Ug8+pj20cCxt5jTCRcVd0LLLjdMF44
         kmwQC09WvFppIvpuLqfO4YWsk8qF71Zw13Gi2s24Hg9Qaabs/G2iHa09vo1CqICqg9Us
         MQCS8Z1T7hUf+FxQEGlF1uFIOdM6xa0RFPA1pvoPnzCBOmofAzURfK8JXxqWXgPIntcU
         EUNOfcOtyvTeVww8chNTZ6uBVU7ZPCK2F3qzamJZLOgJzyhLlF8Nu6DV45Pkmap1ZscE
         JjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599631; x=1795204431;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=elSjDda1eUGYP7L0T1a5ytEO6RwVU73u/iOHfi0NJMo=;
        b=Y6BWoWrKIupylZwtWqqVAHEkNYhKYtQho9+RYUhPvJV750sHy01EzOumFWiuBc3Ktp
         z7oqI/Hx4j5xeBr4JBWawWiKX5tc6qS2Yz3jFczSdeHxlUzYCfC3AJb/q1oUvEkeJ7Ra
         H3vyBBMHxi5klnyN/vfKqeJfFfFVj6UYKo2cp8AIWpLtJJNamipxvuR/Uq/aE3Ow51Pz
         OPd95+BEa7dUG5sgFcMhAJ5PvNA+q9B1oK1y9uL42u7+YgSlABEICM5acxOEwRE9htSc
         ABAvylRi9bQW4DmI5zAwFAayNuu0A1P62TzpBsXw3Gegmy/NTz6Gs+XPz9aMmdLaOQUh
         tFbA==
X-Gm-Message-State: APuU4Z+ZOhjl9RkgPWkotulhutX2xt1p25wAjxHibqUj9V/gqunhNEFR
	u3tUvtL3ggogpyX/lYkyGXze9Et5VmCXL4RS8x3IASkERuP/cRN1Tn2OIBcP2v+yYVIYV4Pu++Y
	Jm2lFtBq9yQ==
X-Received: from dyaw18-n1.prod.google.com ([2002:a05:693c:4152:10b0:373:6c70:7c9c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8816:20b0:36f:350b:3838
 with SMTP id 5a478bee46e88-379671247e7mr3024865eec.31.1794599631070; Fri, 13
 Nov 2026 11:53:51 -0800 (PST)
Date: Fri, 13 Nov 2026 11:53:10 -0800
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
Message-ID: <20261113195335.2865725-6-irogers@google.com>
Subject: [PATCH v2 05/30] perf env: Make lazy perf_env initialization thread-safe
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Guard lazy initialization of kernel_is_64_bit, nr_cpus_avail, e_machine,
cpuid, nr_pmu_mappings, pmu_mappings, and numa_map in struct perf_env
with env->lock, and use DO_ONCE() to initialize the cached host utsname
structure. This prevents data races when multiple threads concurrently
query a shared struct perf_env.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/env.c     | 178 +++++++++++++++++++++++++-------------
 tools/perf/util/session.c |  15 +++-
 2 files changed, 131 insertions(+), 62 deletions(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 50993b0dedc5..4ab46ca6b4ef 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -313,18 +313,17 @@ void perf_env__init(struct perf_env *env)
 	mutex_init(&env->lock);
 }
 
-static void perf_env__init_kernel_mode(struct perf_env *env)
+static const char *uts_machine(void)
 {
-	const char *arch = env->arch;
+	static struct utsname uts;
 
-	if (!arch) {
-		static struct utsname uts = { .machine[0] = '\0', };
+	DO_ONCE(uname, &uts);
+	return uts.machine[0] != '\0' ? uts.machine : NULL;
+}
 
-		if (uts.machine[0] == '\0')
-			uname(&uts);
-		if (uts.machine[0] != '\0')
-			arch = uts.machine;
-	}
+static void perf_env__init_kernel_mode(struct perf_env *env)
+{
+	const char *arch = env->arch ?: uts_machine();
 
 	if (arch) {
 		if (strstr(arch, "64") || strstr(arch, "s390x"))
@@ -340,10 +339,15 @@ static void perf_env__init_kernel_mode(struct perf_env *env)
 
 int perf_env__kernel_is_64_bit(struct perf_env *env)
 {
+	int is_64_bit;
+
+	mutex_lock(&env->lock);
 	if (env->kernel_is_64_bit == -1)
 		perf_env__init_kernel_mode(env);
+	is_64_bit = env->kernel_is_64_bit;
+	mutex_unlock(&env->lock);
 
-	return env->kernel_is_64_bit;
+	return is_64_bit;
 }
 
 bool perf_arch_is_big_endian(const char *arch)
@@ -474,7 +478,6 @@ int perf_env__read_pmu_mappings(struct perf_env *env)
 		pr_debug("pmu mappings not available\n");
 		return -ENOENT;
 	}
-	env->nr_pmu_mappings = pmu_num;
 
 	if (strbuf_init(&sb, 128 * pmu_num) < 0)
 		return -ENOMEM;
@@ -488,6 +491,7 @@ int perf_env__read_pmu_mappings(struct perf_env *env)
 	}
 
 	env->pmu_mappings = strbuf_detach(&sb, NULL);
+	env->nr_pmu_mappings = pmu_num;
 
 	return 0;
 
@@ -632,7 +636,17 @@ int perf_env__read_core_pmu_caps(struct perf_env *env)
 
 int perf_env__nr_cpus_avail(struct perf_env *env)
 {
-	return env && !perf_env__read_nr_cpus_avail(env) ? env->nr_cpus_avail : 0;
+	int nr_cpus = 0;
+
+	if (!env)
+		return 0;
+
+	mutex_lock(&env->lock);
+	if (!perf_env__read_nr_cpus_avail(env))
+		nr_cpus = env->nr_cpus_avail;
+	mutex_unlock(&env->lock);
+
+	return nr_cpus;
 }
 
 void cpu_cache_level__free(struct cpu_cache_level *cache)
@@ -780,7 +794,7 @@ static const char *e_machine_to_perf_arch(uint16_t e_machine)
 	return "unknown";
 }
 
-uint16_t perf_env__e_machine_nocache(struct perf_env *env, uint32_t *e_flags)
+static uint16_t __perf_env__e_machine_nocache(struct perf_env *env, uint32_t *e_flags)
 {
 	uint16_t e_machine = EM_NONE;
 	const char *arch = NULL;
@@ -794,14 +808,8 @@ uint16_t perf_env__e_machine_nocache(struct perf_env *env, uint32_t *e_flags)
 		is_64_bit = env->kernel_is_64_bit;
 	}
 
-	if (!arch) {
-		static struct utsname uts = { .machine[0] = '\0', };
-
-		if (uts.machine[0] == '\0')
-			uname(&uts);
-		if (uts.machine[0] != '\0')
-			arch = uts.machine;
-	}
+	if (!arch)
+		arch = uts_machine();
 
 	e_machine = perf_arch_to_e_machine(arch, is_64_bit);
 
@@ -811,18 +819,37 @@ uint16_t perf_env__e_machine_nocache(struct perf_env *env, uint32_t *e_flags)
 	return e_machine;
 }
 
+uint16_t perf_env__e_machine_nocache(struct perf_env *env, uint32_t *e_flags)
+{
+	uint16_t e_machine;
+
+	if (!env)
+		return __perf_env__e_machine_nocache(NULL, e_flags);
+
+	mutex_lock(&env->lock);
+	e_machine = __perf_env__e_machine_nocache(env, e_flags);
+	mutex_unlock(&env->lock);
+
+	return e_machine;
+}
+
 uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags)
 {
 	uint16_t e_machine;
 	uint32_t local_e_flags = 0;
 
-	if (env && env->e_machine != EM_NONE) {
+	if (!env)
+		return __perf_env__e_machine_nocache(NULL, e_flags);
+
+	mutex_lock(&env->lock);
+	if (env->e_machine != EM_NONE) {
 		if (e_flags)
 			*e_flags = env->e_flags;
-
-		return env->e_machine;
+		e_machine = env->e_machine;
+		mutex_unlock(&env->lock);
+		return e_machine;
 	}
-	e_machine = perf_env__e_machine_nocache(env, &local_e_flags);
+	e_machine = __perf_env__e_machine_nocache(env, &local_e_flags);
 	/*
 	 * Only cache the e_machine in perf_env if env->arch is not NULL.
 	 * If env->arch is NULL, the e_machine is just a fallback to EM_HOST.
@@ -830,10 +857,12 @@ uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags)
 	 * thread-based session e_machine scanning later in
 	 * perf_session__e_machine().
 	 */
-	if (env && env->arch) {
+	if (env->arch) {
 		env->e_machine = e_machine;
 		env->e_flags = local_e_flags;
 	}
+	mutex_unlock(&env->lock);
+
 	if (e_flags)
 		*e_flags = local_e_flags;
 
@@ -846,13 +875,11 @@ const char *perf_env__arch(struct perf_env *env)
 	const char *arch;
 
 	if (!env) {
-		static struct utsname uts = { .machine[0] = '\0', };
-		uint16_t host_e_machine;
+		const char *host_arch = uts_machine();
+
+		if (host_arch) {
+			uint16_t host_e_machine = perf_arch_to_e_machine(host_arch, -1);
 
-		if (uts.machine[0] == '\0')
-			uname(&uts);
-		if (uts.machine[0] != '\0') {
-			host_e_machine = perf_arch_to_e_machine(uts.machine, -1);
 			return e_machine_to_perf_arch(host_e_machine);
 		}
 		return e_machine_to_perf_arch(EM_HOST);
@@ -884,45 +911,60 @@ const char *perf_env__arch_strerrno(uint16_t e_machine, int err)
 
 const char *perf_env__cpuid(struct perf_env *env)
 {
-	int status;
+	const char *cpuid;
 
+	mutex_lock(&env->lock);
 	if (!env->cpuid) { /* Assume local operation */
-		status = perf_env__read_cpuid(env);
-		if (status)
+		if (perf_env__read_cpuid(env)) {
+			mutex_unlock(&env->lock);
 			return NULL;
+		}
 	}
+	cpuid = env->cpuid;
+	mutex_unlock(&env->lock);
 
-	return env->cpuid;
+	return cpuid;
 }
 
 int perf_env__nr_pmu_mappings(struct perf_env *env)
 {
-	int status;
+	int nr;
 
+	mutex_lock(&env->lock);
 	if (!env->nr_pmu_mappings) { /* Assume local operation */
-		status = perf_env__read_pmu_mappings(env);
-		if (status)
+		if (perf_env__read_pmu_mappings(env)) {
+			mutex_unlock(&env->lock);
 			return 0;
+		}
 	}
+	nr = env->nr_pmu_mappings;
+	mutex_unlock(&env->lock);
 
-	return env->nr_pmu_mappings;
+	return nr;
 }
 
 const char *perf_env__pmu_mappings(struct perf_env *env)
 {
-	int status;
+	const char *mappings;
 
+	mutex_lock(&env->lock);
 	if (!env->pmu_mappings) { /* Assume local operation */
-		status = perf_env__read_pmu_mappings(env);
-		if (status)
+		if (perf_env__read_pmu_mappings(env)) {
+			mutex_unlock(&env->lock);
 			return NULL;
+		}
 	}
+	mappings = env->pmu_mappings;
+	mutex_unlock(&env->lock);
 
-	return env->pmu_mappings;
+	return mappings;
 }
 
 int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu)
 {
+	int node;
+
+	mutex_lock(&env->lock);
 	if (!env->nr_numa_map) {
 		struct numa_node *nn;
 		int i, nr = 0;
@@ -939,8 +981,10 @@ int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu)
 		 * it for missing cpus, which return node -1
 		 */
 		env->numa_map = malloc(nr * sizeof(int));
-		if (!env->numa_map)
+		if (!env->numa_map) {
+			mutex_unlock(&env->lock);
 			return -1;
+		}
 
 		for (i = 0; i < nr; i++)
 			env->numa_map[i] = -1;
@@ -957,25 +1001,37 @@ int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu)
 		}
 	}
 
-	return cpu.cpu >= 0 && cpu.cpu < env->nr_numa_map ? env->numa_map[cpu.cpu] : -1;
+	node = cpu.cpu >= 0 && cpu.cpu < env->nr_numa_map ? env->numa_map[cpu.cpu] : -1;
+	mutex_unlock(&env->lock);
+
+	return node;
 }
 
 bool perf_env__has_pmu_mapping(struct perf_env *env, const char *pmu_name)
 {
-	char *pmu_mapping = env->pmu_mappings, *colon;
+	char *pmu_mapping, *colon;
+	bool ret = false;
+
+	mutex_lock(&env->lock);
+	pmu_mapping = env->pmu_mappings;
+	if (!pmu_mapping)
+		goto out_unlock;
 
 	for (int i = 0; i < env->nr_pmu_mappings; ++i) {
 		if (strtoul(pmu_mapping, &colon, 0) == ULONG_MAX || *colon != ':')
-			goto out_error;
+			goto out_unlock;
 
 		pmu_mapping = colon + 1;
-		if (strcmp(pmu_mapping, pmu_name) == 0)
-			return true;
+		if (strcmp(pmu_mapping, pmu_name) == 0) {
+			ret = true;
+			break;
+		}
 
 		pmu_mapping += strlen(pmu_mapping) + 1;
 	}
-out_error:
-	return false;
+out_unlock:
+	mutex_unlock(&env->lock);
+	return ret;
 }
 
 char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
@@ -1043,12 +1099,13 @@ void perf_env__find_br_cntr_info(struct perf_env *env,
 
 bool perf_env__is_x86_amd_cpu(struct perf_env *env)
 {
-	static int is_amd; /* 0: Uninitialized, 1: Yes, -1: No */
+	bool is_amd;
 
-	if (is_amd == 0)
-		is_amd = env->cpuid && strstarts(env->cpuid, "AuthenticAMD") ? 1 : -1;
+	mutex_lock(&env->lock);
+	is_amd = env->cpuid && strstarts(env->cpuid, "AuthenticAMD");
+	mutex_unlock(&env->lock);
 
-	return is_amd >= 1 ? true : false;
+	return is_amd;
 }
 
 bool x86__is_amd_cpu(void)
@@ -1066,12 +1123,13 @@ bool x86__is_amd_cpu(void)
 
 bool perf_env__is_x86_intel_cpu(struct perf_env *env)
 {
-	static int is_intel; /* 0: Uninitialized, 1: Yes, -1: No */
+	bool is_intel;
 
-	if (is_intel == 0)
-		is_intel = env->cpuid && strstarts(env->cpuid, "GenuineIntel") ? 1 : -1;
+	mutex_lock(&env->lock);
+	is_intel = env->cpuid && strstarts(env->cpuid, "GenuineIntel");
+	mutex_unlock(&env->lock);
 
-	return is_intel >= 1 ? true : false;
+	return is_intel;
 }
 
 bool x86__is_intel_cpu(void)
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 56a5e57ec512..f35d6867e816 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -4235,8 +4235,17 @@ uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags
 	 * more accurate threads.
 	 */
 	env = perf_session__env(session);
-	if (env && env->e_machine != EM_NONE)
-		return perf_env__e_machine(env, e_flags);
+	if (env) {
+		uint16_t e_machine;
+
+		mutex_lock(&env->lock);
+		e_machine = env->e_machine;
+		if (e_machine != EM_NONE && e_flags)
+			*e_flags = env->e_flags;
+		mutex_unlock(&env->lock);
+		if (e_machine != EM_NONE)
+			return e_machine;
+	}
 
 	/*
 	 * Compute from threads, note this is more accurate than
@@ -4249,8 +4258,10 @@ uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags
 
 	if (args.e_machine != EM_NONE) {
 		if (env) {
+			mutex_lock(&env->lock);
 			env->e_machine = args.e_machine;
 			env->e_flags = args.e_flags;
+			mutex_unlock(&env->lock);
 		}
 		if (e_flags)
 			*e_flags = args.e_flags;
-- 
2.56.1.703.gf848ed807c-goog

