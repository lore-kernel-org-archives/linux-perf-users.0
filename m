Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AB43BA249;
	Sat,  6 Jun 2026 20:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780776384; cv=none; b=JzcLxIgBIJVT1+cI1gNa4YlgQDmutaUCcG+E/KNm7Pi1eSl4mhK8Q+zWGSO6maPuNHb5ot5hCPlLPjqiOR7D/b0pgjev69H5eRWV1ZyovHAfxPqlpYQawT5gzjYyrmCnfJ+LJGT31YnkPeeSi9CYE1FvrFjQEuxGLGxRv+md+rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780776384; c=relaxed/simple;
	bh=4MweEw1Ex4UoFL/cN03InEtalcZOsuLoLYbhKDZvt9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXXiRSBNDax2sRTXIN1o54YS3dw/QoYIWHzjWgxQRlHLo/+D49fJ23hDt12WAi1Ez3KCOT6Y8LF4WlFnkeVkWsRUr2xIGb+cqOhrF8ZiyiuZCbXvnI5uuQA+dHwWfWXJg94Alnbllqyf4Mpm8b3OkxwKfLIwKfHRtm6TYQcAxyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqtWXhlk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqtWXhlk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322F21F00893;
	Sat,  6 Jun 2026 20:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780776382;
	bh=qk3DLbX3tUmGMauFpT8erZ5UhtOZfYQSKysDwJfeVK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jqtWXhlko7N2jbUajW9D7T/Q/5D6EzjfoOFX/iNvxI1ijeBmD2OQZa751qn+P8Jfe
	 Z8dAaYwLTW3ocM+0+eZ1roYktAK76jsPtElv2Ri6+jqXJOMpr991QZ6mh09DbcEdrS
	 wAgmGOldk7z6DPK9K7Wk0zJAXSH2bYQrGBOOCFasoUUATga4LCkj7sUB+lH3NEDORH
	 BEEqZBBmEDUKt/TUHGVP5stFVv4CqLy0KpCt7UDjY48wG53paQnUechuuexwXpsP2M
	 b0KYcS4x8xPIfXmvHfe8+i7CzKsbEvHsPGg1Q6nSdt200zerDqkQVQuvAP92LdRcuU
	 AaWT+MBJAc5EA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 2/7] perf stat: Introduce perf_env__get_cpu_topology() to guard NULL env->cpu
Date: Sat,  6 Jun 2026 17:05:54 -0300
Message-ID: <20260606200601.1861227-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606200601.1861227-1-acme@kernel.org>
References: <20260606200601.1861227-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

process_cpu_topology() in header.c frees env->cpu on old-format
perf.data files that predate topology information, but leaves
nr_cpus_avail set.  The six perf_env__get_*_aggr_by_cpu() functions
in builtin-stat.c pass the bounds check but dereference a NULL
env->cpu pointer, crashing on old recordings.

Introduce perf_env__get_cpu_topology() as a safe accessor that
validates env->cpu, cpu.cpu >= 0, and cpu.cpu < nr_cpus_avail in
one place, returning a struct cpu_topology_map pointer or NULL.
Convert all six topology aggregation callbacks to use it.

Fixes: 88031a0de7d68d13 ("perf stat: Switch to cpu version of cpu_map__get()")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 51 +++++++++++++++++++++------------------
 tools/perf/util/env.h     | 14 +++++++++++
 2 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 9a045811c4197ccd..a04466ea3b0a0657 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1637,10 +1637,10 @@ static struct aggr_cpu_id perf_env__get_socket_aggr_by_cpu(struct perf_cpu cpu,
 {
 	struct perf_env *env = data;
 	struct aggr_cpu_id id = aggr_cpu_id__empty();
+	struct cpu_topology_map *topo = perf_env__get_cpu_topology(env, cpu);
 
-	/* env->cpu[] has env->nr_cpus_avail entries; reject untrusted indices */
-	if (cpu.cpu >= 0 && cpu.cpu < env->nr_cpus_avail)
-		id.socket = env->cpu[cpu.cpu].socket_id;
+	if (topo)
+		id.socket = topo->socket_id;
 
 	return id;
 }
@@ -1649,15 +1649,16 @@ static struct aggr_cpu_id perf_env__get_die_aggr_by_cpu(struct perf_cpu cpu, voi
 {
 	struct perf_env *env = data;
 	struct aggr_cpu_id id = aggr_cpu_id__empty();
+	struct cpu_topology_map *topo = perf_env__get_cpu_topology(env, cpu);
 
-	if (cpu.cpu >= 0 && cpu.cpu < env->nr_cpus_avail) {
+	if (topo) {
 		/*
 		 * die_id is relative to socket, so start
 		 * with the socket ID and then add die to
 		 * make a unique ID.
 		 */
-		id.socket = env->cpu[cpu.cpu].socket_id;
-		id.die = env->cpu[cpu.cpu].die_id;
+		id.socket = topo->socket_id;
+		id.die = topo->die_id;
 	}
 
 	return id;
@@ -1705,12 +1706,13 @@ static struct aggr_cpu_id perf_env__get_cache_aggr_by_cpu(struct perf_cpu cpu,
 {
 	struct perf_env *env = data;
 	struct aggr_cpu_id id = aggr_cpu_id__empty();
+	struct cpu_topology_map *topo = perf_env__get_cpu_topology(env, cpu);
 
-	if (cpu.cpu >= 0 && cpu.cpu < env->nr_cpus_avail) {
+	if (topo) {
 		u32 cache_level = (perf_stat.aggr_level) ?: stat_config.aggr_level;
 
-		id.socket = env->cpu[cpu.cpu].socket_id;
-		id.die = env->cpu[cpu.cpu].die_id;
+		id.socket = topo->socket_id;
+		id.die = topo->die_id;
 		perf_env__get_cache_id_for_cpu(cpu, env, cache_level, &id);
 	}
 
@@ -1722,11 +1724,12 @@ static struct aggr_cpu_id perf_env__get_cluster_aggr_by_cpu(struct perf_cpu cpu,
 {
 	struct perf_env *env = data;
 	struct aggr_cpu_id id = aggr_cpu_id__empty();
+	struct cpu_topology_map *topo = perf_env__get_cpu_topology(env, cpu);
 
-	if (cpu.cpu >= 0 && cpu.cpu < env->nr_cpus_avail) {
-		id.socket = env->cpu[cpu.cpu].socket_id;
-		id.die = env->cpu[cpu.cpu].die_id;
-		id.cluster = env->cpu[cpu.cpu].cluster_id;
+	if (topo) {
+		id.socket = topo->socket_id;
+		id.die = topo->die_id;
+		id.cluster = topo->cluster_id;
 	}
 
 	return id;
@@ -1736,16 +1739,17 @@ static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(struct perf_cpu cpu, vo
 {
 	struct perf_env *env = data;
 	struct aggr_cpu_id id = aggr_cpu_id__empty();
+	struct cpu_topology_map *topo = perf_env__get_cpu_topology(env, cpu);
 
-	if (cpu.cpu >= 0 && cpu.cpu < env->nr_cpus_avail) {
+	if (topo) {
 		/*
 		 * core_id is relative to socket, die and cluster, we need a
 		 * global id. So we set socket, die id, cluster id and core id.
 		 */
-		id.socket = env->cpu[cpu.cpu].socket_id;
-		id.die = env->cpu[cpu.cpu].die_id;
-		id.cluster = env->cpu[cpu.cpu].cluster_id;
-		id.core = env->cpu[cpu.cpu].core_id;
+		id.socket = topo->socket_id;
+		id.die = topo->die_id;
+		id.cluster = topo->cluster_id;
+		id.core = topo->core_id;
 	}
 
 	return id;
@@ -1755,18 +1759,19 @@ static struct aggr_cpu_id perf_env__get_cpu_aggr_by_cpu(struct perf_cpu cpu, voi
 {
 	struct perf_env *env = data;
 	struct aggr_cpu_id id = aggr_cpu_id__empty();
+	struct cpu_topology_map *topo = perf_env__get_cpu_topology(env, cpu);
 
-	if (cpu.cpu >= 0 && cpu.cpu < env->nr_cpus_avail) {
+	if (topo) {
 		/*
 		 * core_id is relative to socket and die,
 		 * we need a global id. So we set
 		 * socket, die id and core id
 		 */
-		id.socket = env->cpu[cpu.cpu].socket_id;
-		id.die = env->cpu[cpu.cpu].die_id;
-		id.core = env->cpu[cpu.cpu].core_id;
-		id.cpu = cpu;
+		id.socket = topo->socket_id;
+		id.die = topo->die_id;
+		id.core = topo->core_id;
 	}
+	id.cpu = cpu;
 
 	return id;
 }
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 7621d1f73b83a341..7acca39b42ff3531 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -187,6 +187,20 @@ const char *perf_env__pmu_mappings(struct perf_env *env);
 
 int perf_env__read_cpu_topology_map(struct perf_env *env);
 
+/*
+ * Safe accessor for env->cpu[] topology array.  env->cpu can be NULL when
+ * reading old-format perf.data that predates topology information —
+ * process_cpu_topology() in header.c frees it while nr_cpus_avail remains
+ * set, so callers must not index env->cpu[] without this check.
+ */
+static inline struct cpu_topology_map *
+perf_env__get_cpu_topology(struct perf_env *env, struct perf_cpu cpu)
+{
+	if (env->cpu && cpu.cpu >= 0 && cpu.cpu < env->nr_cpus_avail)
+		return &env->cpu[cpu.cpu];
+	return NULL;
+}
+
 void cpu_cache_level__free(struct cpu_cache_level *cache);
 
 uint16_t perf_env__e_machine_nocache(struct perf_env *env, uint32_t *e_flags);
-- 
2.54.0

