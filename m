Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF3D1F5820
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 06:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748328135; cv=none; b=ja9uHiyC9KxCUlqM8C7pVhQycTqNA8jKonk3Nu/MqeboM7dWpQnxeeVeKavAtVE3xz7S3lcTl9GNgXfuCyLT3STS9n6Z2WIjsz1qd56AZsYFEMLxA1yFVmoe1uVOELaKKDR4EFWqSU1TB5N0w/42oWwNh5leKl/NVWnlScmOcz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748328135; c=relaxed/simple;
	bh=ryw2eoYjACTIGQRMkd4hz0ET0kZ3Vh9p4lk/pjBkwTY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=G8khEE+sk63DU676XwTvLju1rUcuh7IAEvC8iKDgFPkagv0iNj5UOer5DnbmmeHi4XwzadyI350Ze34I49uLatsG/RCvrSQdtsfwQ+MYZw7LEMQhuDPTan3uXlXppAvJgLDROnH/Y/P4WBTKdpan424qxvNyFaSPHZc7MwB2ZCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rWMmoZ9a; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rWMmoZ9a"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-231e059b34dso19999865ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 May 2025 23:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748328133; x=1748932933; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MUnLtN4WGSVmNn4Wi8d1LDZQIGLwuZhZKvVW1jdBqts=;
        b=rWMmoZ9aZtc/ywiv4F2meX6p+UgaCJiKmxp/ui8So87UMxGGl21gY3wcbv2C3ZwQez
         z+xDd0ccpZyQXUwSWMexvMMvZokHVQIkw0DZQPr4ffx1BCxzNcH9L20In7A91U/7t8Db
         iC07U1FPylVyiLJeT3TBqtasZpL3ezcy8xCVF7HC9FcOGXgSv+WyTmtQUR9ElcHLcdZR
         lSrGfpfnsfeyA94MgBGhLP9pX7nuVjzVdxKluZOl6HSu6XcTiF4g/2csqm34aURiw7L5
         64uMzvLjum1LfE3B9eodUgOdwnmBPwJAwE/G/E4FlyYusmzyZKmz1SkMLBiU+KYNM+3d
         vwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748328133; x=1748932933;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MUnLtN4WGSVmNn4Wi8d1LDZQIGLwuZhZKvVW1jdBqts=;
        b=e2EVVUJwI44VUYmgHj8+LU5Frn0MRVWwuwawmGOwn1tY4hnks6k31iGOLwNZfmFjzJ
         Jm1vKBKVgmoiF7b2o5q5oNa4Jy1Q0J0DGmroEmoJJmlY+/ZE3/ZD3hZ/frAW9UZuzh8x
         Gex3jADIjNxFBndK5yLb+EzQLyN3SqHgx1UzmA6FKAujPUGIM8vls6W2xbjR0raSrOmW
         zNiZj/XkOzUcnxI4FlhZnNULLVSrCvIUGqzhCRXrvNpOX7CJ+GF2jdo53HGHFmOHUzJB
         /evXAhb7HOF4EYE/rkoGY+z4n0cKEcDoAbOegQ0abGV/UZpIB+LKJDNRntsG5gXtUkBN
         1Kkw==
X-Forwarded-Encrypted: i=1; AJvYcCUeBL1DjmSNqk0iaPdrGkEvCrAHOXnFDX79XFhkXrroYjGEpKU6CG+50Dns7Q+p7oEkbVpdHwyttcEGYkXcg4pC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1KKIA2YBe/q2QHjsDDYgY+DIsO68VCn0u3VUYKjgkuKssGuOC
	oZmfFJ2q4ql3nExw/mUmPEeBoKqT0diCe+CCg1Vt9BSDG+T6eJ4kXcrXl5QrNYPpT6OjxnvIRcz
	JNq22pmTjIQ==
X-Google-Smtp-Source: AGHT+IGHKk5a7AWx1PjC3QXyGO8PNB5ZFjuWpmgN79JUKqYAxatNVA8sujVhm0NZ0Vz4B0jASoO7rX0EVWw9
X-Received: from plmt11.prod.google.com ([2002:a17:903:3d4b:b0:234:659b:127c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41cc:b0:22c:3294:f038
 with SMTP id d9443c01a7336-23414f5cda8mr160849955ad.18.1748328132578; Mon, 26
 May 2025 23:42:12 -0700 (PDT)
Date: Mon, 26 May 2025 23:41:46 -0700
In-Reply-To: <20250527064153.149939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250527064153.149939-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250527064153.149939-5-irogers@google.com>
Subject: [PATCH v1 04/11] perf header: Clean up use of perf_env
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Weilin Wang <weilin.wang@intel.com>, Michael Petlan <mpetlan@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Chun-Tse Shao <ctshao@google.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Always use the perf_env from the feat_fd's perf_header. Cache the
value on entry to a function in `env` and use `env->` consistently in
the code. Ensure the header is initialized for use in
perf_session__do_write_header.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 178 ++++++++++++++++++++++-----------------
 1 file changed, 100 insertions(+), 78 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index c3621f718cb3..2e9a05e10ed5 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -557,6 +557,7 @@ static int write_event_desc(struct feat_fd *ff,
 static int write_cmdline(struct feat_fd *ff,
 			 struct evlist *evlist __maybe_unused)
 {
+	struct perf_env *env = &ff->ph->env;
 	char pbuf[MAXPATHLEN], *buf;
 	int i, ret, n;
 
@@ -564,7 +565,7 @@ static int write_cmdline(struct feat_fd *ff,
 	buf = perf_exe(pbuf, MAXPATHLEN);
 
 	/* account for binary path */
-	n = perf_env.nr_cmdline + 1;
+	n = env->nr_cmdline + 1;
 
 	ret = do_write(ff, &n, sizeof(n));
 	if (ret < 0)
@@ -574,8 +575,8 @@ static int write_cmdline(struct feat_fd *ff,
 	if (ret < 0)
 		return ret;
 
-	for (i = 0 ; i < perf_env.nr_cmdline; i++) {
-		ret = do_write_string(ff, perf_env.cmdline_argv[i]);
+	for (i = 0 ; i < env->nr_cmdline; i++) {
+		ret = do_write_string(ff, env->cmdline_argv[i]);
 		if (ret < 0)
 			return ret;
 	}
@@ -586,6 +587,7 @@ static int write_cmdline(struct feat_fd *ff,
 static int write_cpu_topology(struct feat_fd *ff,
 			      struct evlist *evlist __maybe_unused)
 {
+	struct perf_env *env = &ff->ph->env;
 	struct cpu_topology *tp;
 	u32 i;
 	int ret, j;
@@ -613,17 +615,17 @@ static int write_cpu_topology(struct feat_fd *ff,
 			break;
 	}
 
-	ret = perf_env__read_cpu_topology_map(&perf_env);
+	ret = perf_env__read_cpu_topology_map(env);
 	if (ret < 0)
 		goto done;
 
-	for (j = 0; j < perf_env.nr_cpus_avail; j++) {
-		ret = do_write(ff, &perf_env.cpu[j].core_id,
-			       sizeof(perf_env.cpu[j].core_id));
+	for (j = 0; j < env->nr_cpus_avail; j++) {
+		ret = do_write(ff, &env->cpu[j].core_id,
+			       sizeof(env->cpu[j].core_id));
 		if (ret < 0)
 			return ret;
-		ret = do_write(ff, &perf_env.cpu[j].socket_id,
-			       sizeof(perf_env.cpu[j].socket_id));
+		ret = do_write(ff, &env->cpu[j].socket_id,
+			       sizeof(env->cpu[j].socket_id));
 		if (ret < 0)
 			return ret;
 	}
@@ -641,9 +643,9 @@ static int write_cpu_topology(struct feat_fd *ff,
 			goto done;
 	}
 
-	for (j = 0; j < perf_env.nr_cpus_avail; j++) {
-		ret = do_write(ff, &perf_env.cpu[j].die_id,
-			       sizeof(perf_env.cpu[j].die_id));
+	for (j = 0; j < env->nr_cpus_avail; j++) {
+		ret = do_write(ff, &env->cpu[j].die_id,
+			       sizeof(env->cpu[j].die_id));
 		if (ret < 0)
 			return ret;
 	}
@@ -2111,17 +2113,18 @@ static void print_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
 
 static void print_pmu_caps(struct feat_fd *ff, FILE *fp)
 {
+	struct perf_env *env = &ff->ph->env;
 	struct pmu_caps *pmu_caps;
 
-	for (int i = 0; i < ff->ph->env.nr_pmus_with_caps; i++) {
-		pmu_caps = &ff->ph->env.pmu_caps[i];
+	for (int i = 0; i < env->nr_pmus_with_caps; i++) {
+		pmu_caps = &env->pmu_caps[i];
 		__print_pmu_caps(fp, pmu_caps->nr_caps, pmu_caps->caps,
 				 pmu_caps->pmu_name);
 	}
 
-	if (strcmp(perf_env__arch(&ff->ph->env), "x86") == 0 &&
-	    perf_env__has_pmu_mapping(&ff->ph->env, "ibs_op")) {
-		char *max_precise = perf_env__find_pmu_cap(&ff->ph->env, "cpu", "max_precise");
+	if (strcmp(perf_env__arch(env), "x86") == 0 &&
+	    perf_env__has_pmu_mapping(env, "ibs_op")) {
+		char *max_precise = perf_env__find_pmu_cap(env, "cpu", "max_precise");
 
 		if (max_precise != NULL && atoi(max_precise) == 0)
 			fprintf(fp, "# AMD systems uses ibs_op// PMU for some precise events, e.g.: cycles:p, see the 'perf list' man page for further details.\n");
@@ -2130,18 +2133,19 @@ static void print_pmu_caps(struct feat_fd *ff, FILE *fp)
 
 static void print_pmu_mappings(struct feat_fd *ff, FILE *fp)
 {
+	struct perf_env *env = &ff->ph->env;
 	const char *delimiter = "# pmu mappings: ";
 	char *str, *tmp;
 	u32 pmu_num;
 	u32 type;
 
-	pmu_num = ff->ph->env.nr_pmu_mappings;
+	pmu_num = env->nr_pmu_mappings;
 	if (!pmu_num) {
 		fprintf(fp, "# pmu mappings: not available\n");
 		return;
 	}
 
-	str = ff->ph->env.pmu_mappings;
+	str = env->pmu_mappings;
 
 	while (pmu_num) {
 		type = strtoul(str, &tmp, 0);
@@ -2223,17 +2227,18 @@ static void memory_node__fprintf(struct memory_node *n,
 
 static void print_mem_topology(struct feat_fd *ff, FILE *fp)
 {
+	struct perf_env *env = &ff->ph->env;
 	struct memory_node *nodes;
 	int i, nr;
 
-	nodes = ff->ph->env.memory_nodes;
-	nr    = ff->ph->env.nr_memory_nodes;
+	nodes = env->memory_nodes;
+	nr    = env->nr_memory_nodes;
 
 	fprintf(fp, "# memory nodes (nr %d, block size 0x%llx):\n",
-		nr, ff->ph->env.memory_bsize);
+		nr, env->memory_bsize);
 
 	for (i = 0; i < nr; i++) {
-		memory_node__fprintf(&nodes[i], ff->ph->env.memory_bsize, fp);
+		memory_node__fprintf(&nodes[i], env->memory_bsize, fp);
 	}
 }
 
@@ -2431,6 +2436,7 @@ static int process_build_id(struct feat_fd *ff, void *data __maybe_unused)
 
 static int process_nrcpus(struct feat_fd *ff, void *data __maybe_unused)
 {
+	struct perf_env *env = &ff->ph->env;
 	int ret;
 	u32 nr_cpus_avail, nr_cpus_online;
 
@@ -2441,20 +2447,21 @@ static int process_nrcpus(struct feat_fd *ff, void *data __maybe_unused)
 	ret = do_read_u32(ff, &nr_cpus_online);
 	if (ret)
 		return ret;
-	ff->ph->env.nr_cpus_avail = (int)nr_cpus_avail;
-	ff->ph->env.nr_cpus_online = (int)nr_cpus_online;
+	env->nr_cpus_avail = (int)nr_cpus_avail;
+	env->nr_cpus_online = (int)nr_cpus_online;
 	return 0;
 }
 
 static int process_total_mem(struct feat_fd *ff, void *data __maybe_unused)
 {
+	struct perf_env *env = &ff->ph->env;
 	u64 total_mem;
 	int ret;
 
 	ret = do_read_u64(ff, &total_mem);
 	if (ret)
 		return -1;
-	ff->ph->env.total_mem = (unsigned long long)total_mem;
+	env->total_mem = (unsigned long long)total_mem;
 	return 0;
 }
 
@@ -2515,13 +2522,14 @@ process_event_desc(struct feat_fd *ff, void *data __maybe_unused)
 
 static int process_cmdline(struct feat_fd *ff, void *data __maybe_unused)
 {
+	struct perf_env *env = &ff->ph->env;
 	char *str, *cmdline = NULL, **argv = NULL;
 	u32 nr, i, len = 0;
 
 	if (do_read_u32(ff, &nr))
 		return -1;
 
-	ff->ph->env.nr_cmdline = nr;
+	env->nr_cmdline = nr;
 
 	cmdline = zalloc(ff->size + nr + 1);
 	if (!cmdline)
@@ -2541,8 +2549,8 @@ static int process_cmdline(struct feat_fd *ff, void *data __maybe_unused)
 		len += strlen(str) + 1;
 		free(str);
 	}
-	ff->ph->env.cmdline = cmdline;
-	ff->ph->env.cmdline_argv = (const char **) argv;
+	env->cmdline = cmdline;
+	env->cmdline_argv = (const char **) argv;
 	return 0;
 
 error:
@@ -2556,19 +2564,19 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 	u32 nr, i;
 	char *str = NULL;
 	struct strbuf sb;
-	int cpu_nr = ff->ph->env.nr_cpus_avail;
+	struct perf_env *env = &ff->ph->env;
+	int cpu_nr = env->nr_cpus_avail;
 	u64 size = 0;
-	struct perf_header *ph = ff->ph;
 	bool do_core_id_test = true;
 
-	ph->env.cpu = calloc(cpu_nr, sizeof(*ph->env.cpu));
-	if (!ph->env.cpu)
+	env->cpu = calloc(cpu_nr, sizeof(*env->cpu));
+	if (!env->cpu)
 		return -1;
 
 	if (do_read_u32(ff, &nr))
 		goto free_cpu;
 
-	ph->env.nr_sibling_cores = nr;
+	env->nr_sibling_cores = nr;
 	size += sizeof(u32);
 	if (strbuf_init(&sb, 128) < 0)
 		goto free_cpu;
@@ -2584,12 +2592,12 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		size += string_size(str);
 		zfree(&str);
 	}
-	ph->env.sibling_cores = strbuf_detach(&sb, NULL);
+	env->sibling_cores = strbuf_detach(&sb, NULL);
 
 	if (do_read_u32(ff, &nr))
 		return -1;
 
-	ph->env.nr_sibling_threads = nr;
+	env->nr_sibling_threads = nr;
 	size += sizeof(u32);
 
 	for (i = 0; i < nr; i++) {
@@ -2603,14 +2611,14 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		size += string_size(str);
 		zfree(&str);
 	}
-	ph->env.sibling_threads = strbuf_detach(&sb, NULL);
+	env->sibling_threads = strbuf_detach(&sb, NULL);
 
 	/*
 	 * The header may be from old perf,
 	 * which doesn't include core id and socket id information.
 	 */
 	if (ff->size <= size) {
-		zfree(&ph->env.cpu);
+		zfree(&env->cpu);
 		return 0;
 	}
 
@@ -2619,15 +2627,15 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 	 * This depends on the configuration.
 	 * AArch64 is the same.
 	 */
-	if (ph->env.arch && (!strncmp(ph->env.arch, "s390", 4)
-			  || !strncmp(ph->env.arch, "aarch64", 7)))
+	if (env->arch && (!strncmp(env->arch, "s390", 4)
+		       || !strncmp(env->arch, "aarch64", 7)))
 		do_core_id_test = false;
 
 	for (i = 0; i < (u32)cpu_nr; i++) {
 		if (do_read_u32(ff, &nr))
 			goto free_cpu;
 
-		ph->env.cpu[i].core_id = nr;
+		env->cpu[i].core_id = nr;
 		size += sizeof(u32);
 
 		if (do_read_u32(ff, &nr))
@@ -2639,7 +2647,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 			goto free_cpu;
 		}
 
-		ph->env.cpu[i].socket_id = nr;
+		env->cpu[i].socket_id = nr;
 		size += sizeof(u32);
 	}
 
@@ -2653,7 +2661,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 	if (do_read_u32(ff, &nr))
 		return -1;
 
-	ph->env.nr_sibling_dies = nr;
+	env->nr_sibling_dies = nr;
 	size += sizeof(u32);
 
 	for (i = 0; i < nr; i++) {
@@ -2667,13 +2675,13 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		size += string_size(str);
 		zfree(&str);
 	}
-	ph->env.sibling_dies = strbuf_detach(&sb, NULL);
+	env->sibling_dies = strbuf_detach(&sb, NULL);
 
 	for (i = 0; i < (u32)cpu_nr; i++) {
 		if (do_read_u32(ff, &nr))
 			goto free_cpu;
 
-		ph->env.cpu[i].die_id = nr;
+		env->cpu[i].die_id = nr;
 	}
 
 	return 0;
@@ -2682,12 +2690,13 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 	strbuf_release(&sb);
 	zfree(&str);
 free_cpu:
-	zfree(&ph->env.cpu);
+	zfree(&env->cpu);
 	return -1;
 }
 
 static int process_numa_topology(struct feat_fd *ff, void *data __maybe_unused)
 {
+	struct perf_env *env = &ff->ph->env;
 	struct numa_node *nodes, *n;
 	u32 nr, i;
 	char *str;
@@ -2722,8 +2731,8 @@ static int process_numa_topology(struct feat_fd *ff, void *data __maybe_unused)
 		if (!n->map)
 			goto error;
 	}
-	ff->ph->env.nr_numa_nodes = nr;
-	ff->ph->env.numa_nodes = nodes;
+	env->nr_numa_nodes = nr;
+	env->numa_nodes = nodes;
 	return 0;
 
 error:
@@ -2733,6 +2742,7 @@ static int process_numa_topology(struct feat_fd *ff, void *data __maybe_unused)
 
 static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
 {
+	struct perf_env *env = &ff->ph->env;
 	char *name;
 	u32 pmu_num;
 	u32 type;
@@ -2746,7 +2756,7 @@ static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
 		return 0;
 	}
 
-	ff->ph->env.nr_pmu_mappings = pmu_num;
+	env->nr_pmu_mappings = pmu_num;
 	if (strbuf_init(&sb, 128) < 0)
 		return -1;
 
@@ -2765,14 +2775,14 @@ static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
 			goto error;
 
 		if (!strcmp(name, "msr"))
-			ff->ph->env.msr_pmu_type = type;
+			env->msr_pmu_type = type;
 
 		free(name);
 		pmu_num--;
 	}
 	/* AMD may set it by evlist__has_amd_ibs() from perf_session__new() */
-	free(ff->ph->env.pmu_mappings);
-	ff->ph->env.pmu_mappings = strbuf_detach(&sb, NULL);
+	free(env->pmu_mappings);
+	env->pmu_mappings = strbuf_detach(&sb, NULL);
 	return 0;
 
 error:
@@ -2782,6 +2792,7 @@ static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
 
 static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 {
+	struct perf_env *env = &ff->ph->env;
 	size_t ret = -1;
 	u32 i, nr, nr_groups;
 	struct perf_session *session;
@@ -2795,7 +2806,7 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 	if (do_read_u32(ff, &nr_groups))
 		return -1;
 
-	ff->ph->env.nr_groups = nr_groups;
+	env->nr_groups = nr_groups;
 	if (!nr_groups) {
 		pr_debug("group desc not available\n");
 		return 0;
@@ -2879,6 +2890,7 @@ static int process_auxtrace(struct feat_fd *ff, void *data __maybe_unused)
 
 static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
 {
+	struct perf_env *env = &ff->ph->env;
 	struct cpu_cache_level *caches;
 	u32 cnt, i, version;
 
@@ -2919,8 +2931,8 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
 		#undef _R
 	}
 
-	ff->ph->env.caches = caches;
-	ff->ph->env.caches_cnt = cnt;
+	env->caches = caches;
+	env->caches_cnt = cnt;
 	return 0;
 out_free_caches:
 	for (i = 0; i < cnt; i++) {
@@ -2956,6 +2968,7 @@ static int process_sample_time(struct feat_fd *ff, void *data __maybe_unused)
 static int process_mem_topology(struct feat_fd *ff,
 				void *data __maybe_unused)
 {
+	struct perf_env *env = &ff->ph->env;
 	struct memory_node *nodes;
 	u64 version, i, nr, bsize;
 	int ret = -1;
@@ -2994,9 +3007,9 @@ static int process_mem_topology(struct feat_fd *ff,
 		nodes[i] = n;
 	}
 
-	ff->ph->env.memory_bsize    = bsize;
-	ff->ph->env.memory_nodes    = nodes;
-	ff->ph->env.nr_memory_nodes = nr;
+	env->memory_bsize    = bsize;
+	env->memory_nodes    = nodes;
+	env->nr_memory_nodes = nr;
 	ret = 0;
 
 out:
@@ -3008,7 +3021,9 @@ static int process_mem_topology(struct feat_fd *ff,
 static int process_clockid(struct feat_fd *ff,
 			   void *data __maybe_unused)
 {
-	if (do_read_u64(ff, &ff->ph->env.clock.clockid_res_ns))
+	struct perf_env *env = &ff->ph->env;
+
+	if (do_read_u64(ff, &env->clock.clockid_res_ns))
 		return -1;
 
 	return 0;
@@ -3017,6 +3032,7 @@ static int process_clockid(struct feat_fd *ff,
 static int process_clock_data(struct feat_fd *ff,
 			      void *_data __maybe_unused)
 {
+	struct perf_env *env = &ff->ph->env;
 	u32 data32;
 	u64 data64;
 
@@ -3031,26 +3047,27 @@ static int process_clock_data(struct feat_fd *ff,
 	if (do_read_u32(ff, &data32))
 		return -1;
 
-	ff->ph->env.clock.clockid = data32;
+	env->clock.clockid = data32;
 
 	/* TOD ref time */
 	if (do_read_u64(ff, &data64))
 		return -1;
 
-	ff->ph->env.clock.tod_ns = data64;
+	env->clock.tod_ns = data64;
 
 	/* clockid ref time */
 	if (do_read_u64(ff, &data64))
 		return -1;
 
-	ff->ph->env.clock.clockid_ns = data64;
-	ff->ph->env.clock.enabled = true;
+	env->clock.clockid_ns = data64;
+	env->clock.enabled = true;
 	return 0;
 }
 
 static int process_hybrid_topology(struct feat_fd *ff,
 				   void *data __maybe_unused)
 {
+	struct perf_env *env = &ff->ph->env;
 	struct hybrid_node *nodes, *n;
 	u32 nr, i;
 
@@ -3074,8 +3091,8 @@ static int process_hybrid_topology(struct feat_fd *ff,
 			goto error;
 	}
 
-	ff->ph->env.nr_hybrid_nodes = nr;
-	ff->ph->env.hybrid_nodes = nodes;
+	env->nr_hybrid_nodes = nr;
+	env->hybrid_nodes = nodes;
 	return 0;
 
 error:
@@ -3227,19 +3244,21 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
 static int process_compressed(struct feat_fd *ff,
 			      void *data __maybe_unused)
 {
-	if (do_read_u32(ff, &(ff->ph->env.comp_ver)))
+	struct perf_env *env = &ff->ph->env;
+
+	if (do_read_u32(ff, &(env->comp_ver)))
 		return -1;
 
-	if (do_read_u32(ff, &(ff->ph->env.comp_type)))
+	if (do_read_u32(ff, &(env->comp_type)))
 		return -1;
 
-	if (do_read_u32(ff, &(ff->ph->env.comp_level)))
+	if (do_read_u32(ff, &(env->comp_level)))
 		return -1;
 
-	if (do_read_u32(ff, &(ff->ph->env.comp_ratio)))
+	if (do_read_u32(ff, &(env->comp_ratio)))
 		return -1;
 
-	if (do_read_u32(ff, &(ff->ph->env.comp_mmap_len)))
+	if (do_read_u32(ff, &(env->comp_mmap_len)))
 		return -1;
 
 	return 0;
@@ -3311,19 +3330,21 @@ static int __process_pmu_caps(struct feat_fd *ff, int *nr_caps,
 static int process_cpu_pmu_caps(struct feat_fd *ff,
 				void *data __maybe_unused)
 {
-	int ret = __process_pmu_caps(ff, &ff->ph->env.nr_cpu_pmu_caps,
-				     &ff->ph->env.cpu_pmu_caps,
-				     &ff->ph->env.max_branches,
-				     &ff->ph->env.br_cntr_nr,
-				     &ff->ph->env.br_cntr_width);
+	struct perf_env *env = &ff->ph->env;
+	int ret = __process_pmu_caps(ff, &env->nr_cpu_pmu_caps,
+				     &env->cpu_pmu_caps,
+				     &env->max_branches,
+				     &env->br_cntr_nr,
+				     &env->br_cntr_width);
 
-	if (!ret && !ff->ph->env.cpu_pmu_caps)
+	if (!ret && !env->cpu_pmu_caps)
 		pr_debug("cpu pmu capabilities not available\n");
 	return ret;
 }
 
 static int process_pmu_caps(struct feat_fd *ff, void *data __maybe_unused)
 {
+	struct perf_env *env = &ff->ph->env;
 	struct pmu_caps *pmu_caps;
 	u32 nr_pmu, i;
 	int ret;
@@ -3361,8 +3382,8 @@ static int process_pmu_caps(struct feat_fd *ff, void *data __maybe_unused)
 		}
 	}
 
-	ff->ph->env.nr_pmus_with_caps = nr_pmu;
-	ff->ph->env.pmu_caps = pmu_caps;
+	env->nr_pmus_with_caps = nr_pmu;
+	env->pmu_caps = pmu_caps;
 	return 0;
 
 err:
@@ -3660,6 +3681,7 @@ static int perf_session__do_write_header(struct perf_session *session,
 	struct perf_header *header = &session->header;
 	struct evsel *evsel;
 	struct feat_fd ff = {
+		.ph = header,
 		.fd = fd,
 	};
 	u64 attr_offset = sizeof(f_header), attr_size = 0;
-- 
2.49.0.1151.ga128411c76-goog

