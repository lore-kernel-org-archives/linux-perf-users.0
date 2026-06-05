Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D62F3BBFDB;
	Fri,  5 Jun 2026 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780702743; cv=none; b=cZ/W+NUwHUSw9iTRRGcJdPl+6H4kNmd1A5lY4kXA4QAiwGEpSDozyN5FSfo5zjzTZP0lkVuI/MKBWNq+Rt9CjZSSZQEFYe6B7zFpwP/IPnoP9ALvcOhhtTarCZH9+VLzjnwgaFCDU4o3F10wsAvVjin05X3rgsABa7kGZwQXN8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780702743; c=relaxed/simple;
	bh=pwvR8w2UjjI/8KEV+WmN7gI1K8WY8+krXN+FKiuq4Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euvtnL8CpbynLDPDYk3dpUJW62LxF+FIkhBHAufzigKK2vmLEg7LvE7Wz9YSnzN6tYeAlQbAzKWq6JdHgNQlZG+zF2GhnNOzwV2WgievynYbh5Qtp+fh4mMW4M+Nlds+3q0eYhRPVpbgegT3r5vKuSBHSCEXveWTJ5DYqlqcHjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQ7geLtk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ7geLtk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F8E1F00898;
	Fri,  5 Jun 2026 23:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780702741;
	bh=LH/ITcZtqV/imoJd8hoOXrXcGvyAMyBhfSkua7qTUgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YQ7geLtkRvi4fauUyC9j2p233MZqMVHfAi1Brt+APrsvIlPUlacTsDNlYam2boaSx
	 ijzj9IU3GRW1wohTBifSKXmghG68xMPv8KPY81bm/5vMD4y+nGTSPvu/WHsxiZEE9E
	 lv1F4PoV0hScNdywJBEBe4UHSBRywMCKPxM50MHkqds//Aq7H2kdMPmIjhr2poZJPp
	 Hx+f2uESTcbezsc9zf4+U2mdTPNT+QsT/sv6USyuOC2YQ39fyxbm72bkpD0sPc+tzs
	 6TlMefniFNKFLoRoatAYI/RHgozn4jzzVCTcJAuJzyQKqQl2P1Q6KLnIAvYJRMA4fA
	 pze2XtbY6Lv1A==
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
Subject: [PATCH 3/9] perf c2c: Bounds-check CPU and node IDs before bitmap and array access
Date: Fri,  5 Jun 2026 20:38:31 -0300
Message-ID: <20260605233837.1773732-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605233837.1773732-1-acme@kernel.org>
References: <20260605233837.1773732-1-acme@kernel.org>
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
index 3dd45a550fdb772a..f060dfbe11c285bf 100644
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
+		/* cpu2node[] has c2c.cpus_cnt entries; large u32 wraps signed negative */
+		if (cpu < 0 || cpu >= c2c.cpus_cnt)
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

