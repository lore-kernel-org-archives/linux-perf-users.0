Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43392ED848
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374825; cv=none; b=OB+x6wUL9fpbrGfjI3A/v3zedVsJ1mGOVTc4tDfrO9CPgujJV9PJz52NnY0Vy6b2500QtXgC+r3HiINg78aYOUbQ6fV1k8s7DGV79L2/S8mVbNuid7Uix7ktLraTbIrqLkWMe06SpXiry/puY+85pHsN005WsU79RMnewgFrMyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374825; c=relaxed/simple;
	bh=yGSh4X7XdoDwP/XNm5tByh8EInjitmt1+/yS78PRG70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=JYMs2F3pM9h9sLAgURgj8KQ1KCzHXAVFe3cgBMr8MwaFb5Z1oGKxeYfN6gZrulBFeuxd0trFOYT9l0CR9kZoa9tVVL0qpLpcrJx2MKQFdjFT5jTc7OW9Co6/LZatw9qyUWbf2dOCYPh/fooLbFDPJUm2Tz/a6j2ENiLMFnd7h4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F+zXjG31; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F+zXjG31"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23632fd6248so12121345ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 09:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753374822; x=1753979622; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vPNCzyxfy4XXIcb2fDEErvAFWE2sdBLPvOrMGYrTagM=;
        b=F+zXjG31yUpQKiXTjZkv+DarH17nI7r6/u8kmLf/aChqGphth266qt85+dUTSEmFXz
         5jPTIom/IZar9uYQJ7k+Okn0J60E8XpDguvxIxY+J+dzEg9foQcNk0zGNzZT0Jtipy6e
         QlNwcG0gO/ZYdDHYNQEooqb675WeYEb8706Scr0O8XUjJSMK3bpDkXSO02iqko7sstHP
         u8suCHOWSGlD2A3zngw2hZlWo6pVUmSvolpUNUv4I48z5Q9JmKWcRNlPKy0oh2veDLwR
         ycYIl+bA2rZGvHq/3Z8nWDdQkw5IyFlpTusN+5ffoxCaGBWlv44sDjv/Sq4fzcInNgCR
         TOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374822; x=1753979622;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPNCzyxfy4XXIcb2fDEErvAFWE2sdBLPvOrMGYrTagM=;
        b=QnWmLhLPmuPD5Rdib7hCpMpNkqXKEP1dU6Eaf9bqIF3YzldKidd0NJZAmc6glLQXrS
         7rTcnTGtyXEURC/Z51xgtpcRX7X0gSzvZsDtSIV8Bo026snTh2HS4M2USfZFTGVXrjtf
         AaO1RyXir7O4Ppl4Q404GQ5Y3D3TZ12lzg1pZVwikvE35ugH8XNyIcSpC2R6okIcD8fs
         Chk95GAs+U471sIzWB0lfbfTH2VfgEexAcxzF8eQfOF/XdHssR2NtLRbcuJNDsgUuI3e
         J1iraTx5cKsZYXQjY8v8LELeadXSAE/vTGUu/EbGr5JWOgL2jbizCZcK4uooQrsKgFYc
         1e8w==
X-Forwarded-Encrypted: i=1; AJvYcCWtEWcVwNhTuiYOzFxPHbS0uia90+skXISZLkW0s8/LaAJ0PKGPwHoilhrVirhbFXSANiP1fpLqI/aS2+nI/QM8@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjp96VlxMkNZvoD22YZ/UdeENR52ncEiTXl9gqBNtkuSCc1W4o
	4fq01o9r/G4k6mP/WCwobD/Yz+PA9bDfSJZTqtNy2drCUnyF0IDCPIH2ncEexu9c2ZRVaSxzvgc
	/lNlD6I27hw==
X-Google-Smtp-Source: AGHT+IFWT6BOL+6aTxUcrq+uPDzVJYv31JbUGlhLrN873B2nul9RqKGgG9i36nst6mAyrhy7TnmoJaqt5YdK
X-Received: from pjyr5.prod.google.com ([2002:a17:90a:e185:b0:31c:2fe4:33be])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:46ce:b0:234:c5c1:9b7a
 with SMTP id d9443c01a7336-23f9816414dmr86102115ad.8.1753374822125; Thu, 24
 Jul 2025 09:33:42 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:32:51 -0700
In-Reply-To: <20250724163302.596743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724163302.596743-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250724163302.596743-12-irogers@google.com>
Subject: [PATCH v6 11/22] perf header: Clean up use of perf_env
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Graham Woodward <graham.woodward@arm.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Chun-Tse Shao <ctshao@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Levi Yun <yeoreum.yun@arm.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Matt Fleming <matt@readmodwrite.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Always use the perf_env from the feat_fd's perf_header. Cache the
value on entry to a function in `env` and use `env->` consistently in
the code. Ensure the header is initialized for use in
perf_session__do_write_header.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 174 ++++++++++++++++++++++-----------------
 1 file changed, 98 insertions(+), 76 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index dcef7f815fa1..b493399f9fc6 100644
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
@@ -2123,17 +2125,18 @@ static void print_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
 
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
@@ -2142,18 +2145,19 @@ static void print_pmu_caps(struct feat_fd *ff, FILE *fp)
 
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
@@ -2235,17 +2239,18 @@ static void memory_node__fprintf(struct memory_node *n,
 
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
 
@@ -2443,6 +2448,7 @@ static int process_build_id(struct feat_fd *ff, void *data __maybe_unused)
 
 static int process_nrcpus(struct feat_fd *ff, void *data __maybe_unused)
 {
+	struct perf_env *env = &ff->ph->env;
 	int ret;
 	u32 nr_cpus_avail, nr_cpus_online;
 
@@ -2453,20 +2459,21 @@ static int process_nrcpus(struct feat_fd *ff, void *data __maybe_unused)
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
 
@@ -2527,13 +2534,14 @@ process_event_desc(struct feat_fd *ff, void *data __maybe_unused)
 
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
@@ -2553,8 +2561,8 @@ static int process_cmdline(struct feat_fd *ff, void *data __maybe_unused)
 		len += strlen(str) + 1;
 		free(str);
 	}
-	ff->ph->env.cmdline = cmdline;
-	ff->ph->env.cmdline_argv = (const char **) argv;
+	env->cmdline = cmdline;
+	env->cmdline_argv = (const char **) argv;
 	return 0;
 
 error:
@@ -2568,18 +2576,18 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 	u32 nr, i;
 	char *str = NULL;
 	struct strbuf sb;
-	int cpu_nr = ff->ph->env.nr_cpus_avail;
+	struct perf_env *env = &ff->ph->env;
+	int cpu_nr = env->nr_cpus_avail;
 	u64 size = 0;
-	struct perf_header *ph = ff->ph;
 
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
@@ -2595,12 +2603,12 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
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
@@ -2614,14 +2622,14 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
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
 
@@ -2629,13 +2637,13 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		if (do_read_u32(ff, &nr))
 			goto free_cpu;
 
-		ph->env.cpu[i].core_id = nr;
+		env->cpu[i].core_id = nr;
 		size += sizeof(u32);
 
 		if (do_read_u32(ff, &nr))
 			goto free_cpu;
 
-		ph->env.cpu[i].socket_id = nr;
+		env->cpu[i].socket_id = nr;
 		size += sizeof(u32);
 	}
 
@@ -2649,7 +2657,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 	if (do_read_u32(ff, &nr))
 		return -1;
 
-	ph->env.nr_sibling_dies = nr;
+	env->nr_sibling_dies = nr;
 	size += sizeof(u32);
 
 	for (i = 0; i < nr; i++) {
@@ -2663,13 +2671,13 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
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
@@ -2678,12 +2686,13 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
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
@@ -2718,8 +2727,8 @@ static int process_numa_topology(struct feat_fd *ff, void *data __maybe_unused)
 		if (!n->map)
 			goto error;
 	}
-	ff->ph->env.nr_numa_nodes = nr;
-	ff->ph->env.numa_nodes = nodes;
+	env->nr_numa_nodes = nr;
+	env->numa_nodes = nodes;
 	return 0;
 
 error:
@@ -2729,6 +2738,7 @@ static int process_numa_topology(struct feat_fd *ff, void *data __maybe_unused)
 
 static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
 {
+	struct perf_env *env = &ff->ph->env;
 	char *name;
 	u32 pmu_num;
 	u32 type;
@@ -2742,7 +2752,7 @@ static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
 		return 0;
 	}
 
-	ff->ph->env.nr_pmu_mappings = pmu_num;
+	env->nr_pmu_mappings = pmu_num;
 	if (strbuf_init(&sb, 128) < 0)
 		return -1;
 
@@ -2761,14 +2771,14 @@ static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
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
@@ -2778,6 +2788,7 @@ static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
 
 static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 {
+	struct perf_env *env = &ff->ph->env;
 	size_t ret = -1;
 	u32 i, nr, nr_groups;
 	struct perf_session *session;
@@ -2791,7 +2802,7 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 	if (do_read_u32(ff, &nr_groups))
 		return -1;
 
-	ff->ph->env.nr_groups = nr_groups;
+	env->nr_groups = nr_groups;
 	if (!nr_groups) {
 		pr_debug("group desc not available\n");
 		return 0;
@@ -2875,6 +2886,7 @@ static int process_auxtrace(struct feat_fd *ff, void *data __maybe_unused)
 
 static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
 {
+	struct perf_env *env = &ff->ph->env;
 	struct cpu_cache_level *caches;
 	u32 cnt, i, version;
 
@@ -2915,8 +2927,8 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
 		#undef _R
 	}
 
-	ff->ph->env.caches = caches;
-	ff->ph->env.caches_cnt = cnt;
+	env->caches = caches;
+	env->caches_cnt = cnt;
 	return 0;
 out_free_caches:
 	for (i = 0; i < cnt; i++) {
@@ -2952,6 +2964,7 @@ static int process_sample_time(struct feat_fd *ff, void *data __maybe_unused)
 static int process_mem_topology(struct feat_fd *ff,
 				void *data __maybe_unused)
 {
+	struct perf_env *env = &ff->ph->env;
 	struct memory_node *nodes;
 	u64 version, i, nr, bsize;
 	int ret = -1;
@@ -2990,9 +3003,9 @@ static int process_mem_topology(struct feat_fd *ff,
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
@@ -3004,7 +3017,9 @@ static int process_mem_topology(struct feat_fd *ff,
 static int process_clockid(struct feat_fd *ff,
 			   void *data __maybe_unused)
 {
-	if (do_read_u64(ff, &ff->ph->env.clock.clockid_res_ns))
+	struct perf_env *env = &ff->ph->env;
+
+	if (do_read_u64(ff, &env->clock.clockid_res_ns))
 		return -1;
 
 	return 0;
@@ -3013,6 +3028,7 @@ static int process_clockid(struct feat_fd *ff,
 static int process_clock_data(struct feat_fd *ff,
 			      void *_data __maybe_unused)
 {
+	struct perf_env *env = &ff->ph->env;
 	u32 data32;
 	u64 data64;
 
@@ -3027,26 +3043,27 @@ static int process_clock_data(struct feat_fd *ff,
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
 
@@ -3070,8 +3087,8 @@ static int process_hybrid_topology(struct feat_fd *ff,
 			goto error;
 	}
 
-	ff->ph->env.nr_hybrid_nodes = nr;
-	ff->ph->env.hybrid_nodes = nodes;
+	env->nr_hybrid_nodes = nr;
+	env->hybrid_nodes = nodes;
 	return 0;
 
 error:
@@ -3224,19 +3241,21 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
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
@@ -3308,19 +3327,21 @@ static int __process_pmu_caps(struct feat_fd *ff, int *nr_caps,
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
@@ -3358,8 +3379,8 @@ static int process_pmu_caps(struct feat_fd *ff, void *data __maybe_unused)
 		}
 	}
 
-	ff->ph->env.nr_pmus_with_caps = nr_pmu;
-	ff->ph->env.pmu_caps = pmu_caps;
+	env->nr_pmus_with_caps = nr_pmu;
+	env->pmu_caps = pmu_caps;
 	return 0;
 
 err:
@@ -3657,6 +3678,7 @@ static int perf_session__do_write_header(struct perf_session *session,
 	struct perf_header *header = &session->header;
 	struct evsel *evsel;
 	struct feat_fd ff = {
+		.ph = header,
 		.fd = fd,
 	};
 	u64 attr_offset = sizeof(f_header), attr_size = 0;
-- 
2.50.0.727.gbf7dc18ff4-goog

