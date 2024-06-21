Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7126816F273;
	Fri, 21 Jun 2024 22:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719008641; cv=none; b=mEpC5CVtA18vTLcMKbloC6odDnl3Y/E5gJAEdnpGSJh35Bd2eQOMFiC+DT2dSVjng0Kr1gKbrXrt84zwwXUaWtLSSx3gMBMvHGGUh++TDon6niPDdqAowC8ptJ1fTbjVhZvEsp2p6KJ+teZ4UJYgU3PsCndfa702W1sJusfpBF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719008641; c=relaxed/simple;
	bh=egp9ozSEksd36GD3FzpFfqRLU8xFzWxjV3v6ui5H4bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POr2ZeM3pLemsIW5MToQpcXSzwUfLti/r2/1KL71rF9ToDVmR672/RhEknJtC8MCXe7R+SO+bJudIIlAOWR2bwmuH2Ht2t7pnxm9Kd9HuI/V0Wco+Z8oqwHdc3Jps6DlXDWgkMHzSvQaBGmz7j5UM+v3PvODfOXUGjvRwCm0zHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McwWk0xM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McwWk0xM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B1CC4AF07;
	Fri, 21 Jun 2024 22:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719008640;
	bh=egp9ozSEksd36GD3FzpFfqRLU8xFzWxjV3v6ui5H4bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=McwWk0xM5Glzt4DYz1iz26ZASeu7Kmt3Br7c9y4Gf0gYfzj4x30Io/28MNymdYQJH
	 /qUguYSZtes0KFt0yoAC/Vsyh2ssxHInNAXTChAT2LdfMooMiY87CLug/i5eTleIeW
	 kUbvKWF6G2YqIcm9QK+emQXb/Y8nviJ1wHq0q0wQFdIaLF4615MoqQ6bUtfjfUp/nb
	 IUDFsZOblQjfOfY8+m7IAXoFQOzkSmDf/4nO4mymhVpA0hZHvDATG6yCv63BPXR1sB
	 sxl+r1kpR+SyVojLPVsQoeYYPZcWVojdadzvI/alDPJsTLLmjWfWtKMrpQp1IxZ2Ht
	 2SzxAUFniSGrg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 5/8] perf bpf-filter: Support separate lost counts for each filter
Date: Fri, 21 Jun 2024 15:23:54 -0700
Message-ID: <20240621222357.717374-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240621222357.717374-1-namhyung@kernel.org>
References: <20240621222357.717374-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the BPF filter is shared between other processes, it should have its
own counter for each invocation.  Add a new array map (lost_count) to
save the count using the same index as the filter.  It should clear the
count before running the filter.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf-filter.c                 | 37 ++++++++++++++++++--
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 15 ++++++--
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 37ed6c48debf..c5eb0b7eec19 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -260,11 +260,23 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	}
 
 	if (needs_pid_hash && geteuid() != 0) {
+		int zero = 0;
+
 		/* The filters map is shared among other processes */
 		ret = update_pid_hash(evsel, entry);
 		if (ret < 0)
 			goto err;
 
+		fd = get_pinned_fd("dropped");
+		if (fd < 0) {
+			ret = fd;
+			goto err;
+		}
+
+		/* Reset the lost count */
+		bpf_map_update_elem(fd, &pinned_filter_idx, &zero, BPF_ANY);
+		close(fd);
+
 		fd = get_pinned_fd("perf_sample_filter");
 		if (fd < 0) {
 			ret = fd;
@@ -347,9 +359,25 @@ int perf_bpf_filter__destroy(struct evsel *evsel)
 
 u64 perf_bpf_filter__lost_count(struct evsel *evsel)
 {
-	struct sample_filter_bpf *skel = evsel->bpf_skel;
+	int count = 0;
+
+	if (list_empty(&evsel->bpf_filters))
+		return 0;
+
+	if (pinned_filter_idx >= 0) {
+		int fd = get_pinned_fd("dropped");
+
+		bpf_map_lookup_elem(fd, &pinned_filter_idx, &count);
+		close(fd);
+	} else if (evsel->bpf_skel) {
+		struct sample_filter_bpf *skel = evsel->bpf_skel;
+		int fd = bpf_map__fd(skel->maps.dropped);
+		int idx = 0;
 
-	return skel ? skel->bss->dropped : 0;
+		bpf_map_lookup_elem(fd, &idx, &count);
+	}
+
+	return count;
 }
 
 struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(enum perf_bpf_filter_term term,
@@ -402,6 +430,7 @@ int perf_bpf_filter__pin(void)
 	/* pinned program will use pid-hash */
 	bpf_map__set_max_entries(skel->maps.filters, MAX_FILTERS);
 	bpf_map__set_max_entries(skel->maps.pid_hash, MAX_PIDS);
+	bpf_map__set_max_entries(skel->maps.dropped, MAX_FILTERS);
 	skel->rodata->use_pid_hash = 1;
 
 	if (sample_filter_bpf__load(skel) < 0) {
@@ -459,6 +488,10 @@ int perf_bpf_filter__pin(void)
 		pr_debug("chmod for pid_hash failed\n");
 		ret = -errno;
 	}
+	if (fchmodat(dir_fd, "dropped", 0666, 0) < 0) {
+		pr_debug("chmod for dropped failed\n");
+		ret = -errno;
+	}
 
 err_close:
 	close(dir_fd);
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index c5273f06fa45..4c75354b84fd 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -23,7 +23,14 @@ struct pid_hash {
 	__uint(max_entries, 1);
 } pid_hash SEC(".maps");
 
-int dropped;
+/* tgid to filter index */
+struct lost_count {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, 1);
+} dropped SEC(".maps");
+
 volatile const int use_pid_hash;
 
 void *bpf_cast_to_kern_ctx(void *) __ksym;
@@ -189,6 +196,7 @@ int perf_sample_filter(void *ctx)
 	int in_group = 0;
 	int group_result = 0;
 	int i, k;
+	int *losts;
 
 	kctx = bpf_cast_to_kern_ctx(ctx);
 
@@ -252,7 +260,10 @@ int perf_sample_filter(void *ctx)
 	return 1;
 
 drop:
-	__sync_fetch_and_add(&dropped, 1);
+	losts = bpf_map_lookup_elem(&dropped, &k);
+	if (losts != NULL)
+		__sync_fetch_and_add(losts, 1);
+
 	return 0;
 }
 
-- 
2.45.2.741.gdbec12cfda-goog

