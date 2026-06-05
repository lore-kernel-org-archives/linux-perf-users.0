Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36B7380FFD;
	Fri,  5 Jun 2026 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691623; cv=none; b=X0e3y2IJZHdVI6lNrnfx9YJDsnpRWHGsSLENr7YV6arm6liPgH5reJFep5r/huhXGKdQY6OwDoZAaUWKHM1zyV6nX/qGmT/XpUlpWedvKg0VHtK7z+Aos2E3zdELdzdrKviRn7WG9IoIRJddm5FuSGfiQRdRSkFhXfzw174mR4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691623; c=relaxed/simple;
	bh=0MAAfeBHwYeUdp6heW6Bjz4QdacL1KA7uA44fEAIV/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rwz1V1a1BqwZT7uE9PcN94TWZ7kQYBQXyxFv9p7RVOPMwth160iIa7TYeQjzasKHgnRacLuA4SdGWXVrMvgP2rgzfRfQc7iRKgbRIGAfV2Di6I76a8mQLbSj7otJhI2BvjkncxQBvJ0n/8Vu6UopGQDsvoLeARbFSxqhgBuD2kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFOHVOeE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFOHVOeE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F01B1F00898;
	Fri,  5 Jun 2026 20:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780691621;
	bh=Aa99HOLdkmWISjzE0sEk8/YdGuG35CujgOlO9etwj4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fFOHVOeErVGvczbsuYGKq48dRhG35upQkQPNPKpd/KdBzz1WZid0KdOddi9gT0hOP
	 kSxGaT6iveeJGQRcCkn1seEoV964CCvMoVSqN/+FZSkVPS9a11KKQ3M//jaYOb6fFB
	 FGoK7LeE+5A2EnRtiXog1GBoLASyFuY371V99HG2ggNvmyll+/jBIC29KR+rq1TLyL
	 LnogwiKjXOeP0482Uufa4YXFPgydRts4V5OXpmI3O4xodlZzEaiRqU9mLuNMBboR0l
	 Ts8MrugmjM205TBCcNuOgu917DBqXmNckBqUf6dI3lpRIP8Enc6t9aDjT/GtNO/afv
	 DEDuXv0nwXS6w==
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
Subject: [PATCH 3/8] perf c2c: Bounds-check CPU and node IDs before bitmap and array access
Date: Fri,  5 Jun 2026 17:33:11 -0300
Message-ID: <20260605203316.1758661-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605203316.1758661-1-acme@kernel.org>
References: <20260605203316.1758661-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

c2c_he__set_cpu() passes sample->cpu directly to __set_bit(cpu, cpuset)
after only checking for the (u32)-1 sentinel.  The cpuset bitmap is
allocated with c2c.cpus_cnt bits (from env->nr_cpus_avail), so a crafted
perf.data with CPU IDs exceeding that count causes out-of-bounds heap
writes.

c2c_he__set_node() similarly passes the node ID from mem2node__node()
to __set_bit(node, nodeset) after only checking for negative values.
The nodeset bitmap is sized to c2c.nodes_cnt (from env->nr_numa_nodes),
so a node ID exceeding that causes OOB writes.

process_sample_event() indexes c2c.cpu2node[cpu] and
c2c_he->node_stats[node] without bounds checking.  Both arrays are
sized to c2c.cpus_cnt and c2c.nodes_cnt respectively.

Add bounds checks in all three paths:
  - c2c_he__set_cpu(): return if sample->cpu >= c2c.cpus_cnt
  - c2c_he__set_node(): return if node >= c2c.nodes_cnt
  - process_sample_event(): clamp cpu to 0 if >= cpus_cnt,
    guard node_stats access with bounds check

Fixes: 1e181b92a2da ("perf c2c report: Add 'node' sort key")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 3dd45a550fdb772a..b78217d98988a75c 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -245,6 +245,10 @@ static void c2c_he__set_cpu(struct c2c_hist_entry *c2c_he,
 		      "WARNING: no sample cpu value"))
 		return;
 
+	/* cpuset bitmap has c2c.cpus_cnt bits from env->nr_cpus_avail */
+	if (sample->cpu >= (unsigned int)c2c.cpus_cnt)
+		return;
+
 	__set_bit(sample->cpu, c2c_he->cpuset);
 }
 
@@ -262,6 +266,10 @@ static void c2c_he__set_node(struct c2c_hist_entry *c2c_he,
 	if (WARN_ONCE(node < 0, "WARNING: failed to find node\n"))
 		return;
 
+	/* nodeset bitmap has c2c.nodes_cnt bits from env->nr_numa_nodes */
+	if (node >= c2c.nodes_cnt)
+		return;
+
 	__set_bit(node, c2c_he->nodeset);
 
 	if (c2c_he->paddr != sample->phys_addr) {
@@ -391,7 +399,12 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 		 * Doing node stats only for single callchain data.
 		 */
 		int cpu = sample->cpu == (unsigned int) -1 ? 0 : sample->cpu;
-		int node = c2c.cpu2node[cpu];
+		int node;
+
+		/* cpu2node[] has c2c.cpus_cnt entries from env->nr_cpus_avail */
+		if (cpu >= c2c.cpus_cnt)
+			cpu = 0;
+		node = c2c.cpu2node[cpu];
 
 		c2c_hists = he__get_c2c_hists(he, c2c.cl_sort, 2, machine->env);
 		if (!c2c_hists) {
@@ -410,7 +423,9 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 		c2c_he = container_of(he, struct c2c_hist_entry, he);
 		c2c_add_stats(&c2c_he->stats, &stats);
 		c2c_add_stats(&c2c_hists->stats, &stats);
-		c2c_add_stats(&c2c_he->node_stats[node], &stats);
+		/* node_stats[] has c2c.nodes_cnt entries */
+		if (node >= 0 && node < c2c.nodes_cnt)
+			c2c_add_stats(&c2c_he->node_stats[node], &stats);
 
 		compute_stats(c2c_he, &stats, sample->weight);
 
-- 
2.54.0

