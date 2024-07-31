Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3752416DEA5;
	Wed, 31 Jul 2024 23:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470107; cv=none; b=NoT4yxU1/A9Kj7VA7CyOLUEaE4mi5zNpdw5csKAuZHDF8EJtfADes6PPw6QWAPpkTeOzfPNa8/ZZTq66j6Yl1DNIAT3Kb8Tu8U60n5DqPQ0qT19wvUQO3hdZgnA9sFHWv0AYZa/kqIPMHJTiyevLtE6NJ/qiTTpDrv9Vr31OH9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470107; c=relaxed/simple;
	bh=Sin1KNDLL+kUSrzMmoBpl5p9aHQKG1CFltG2rFn+nsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbNuBzJNYS+XEastqrc6NIMswGZVeTPwvORtE99KxQaCWNLbwKE+DdJi9PIZcTNyjhuiEnbPpEsTa9T5iLSisHW//0oJDVe+25KFHuOvCkIEMpc6CLmhyIQOvVgw2tEB9JV76CMSg6KxahuHs/d1e1G2lltdmlIXZOZG4WeSo2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrzxBHU+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrzxBHU+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B93AC4AF0C;
	Wed, 31 Jul 2024 23:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470106;
	bh=Sin1KNDLL+kUSrzMmoBpl5p9aHQKG1CFltG2rFn+nsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SrzxBHU+Jv3WTtqExp1XI+gLhkwWerP4/QF2t6PTsaCDJHXXooLxRJ2QyoaTqUe+j
	 5YF54Rbw8OyumNX6A97mTyIoOXy8FlNrmFF7WYh11TRLf6uT31gzDiCYUOxOPjJuDM
	 qrhMqUrZfQfc6PCsAbd7hrFdxeB2YyaEXlEUz/5b8x1CkMK8BVUJkaWy8kJxkRNdBI
	 Xcg5MNg0Dd+izSM8GkxFR65vj3FNqHFoDtVMYTiCs1qFG38Rw/ezu3ZlSf/XjELUqO
	 +dRq2amV+TagcJsis1LctHBtHVjKqz6w5ZOFUXdnaaqWh4IVi5HKmo+czEG5FY3mCV
	 aepsvKv27S09A==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 1/6] perf hist: Correct hist_entry->mem_info refcounts
Date: Wed, 31 Jul 2024 16:55:00 -0700
Message-ID: <20240731235505.710436-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
In-Reply-To: <20240731235505.710436-1-namhyung@kernel.org>
References: <20240731235505.710436-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mem_info is created by iter_prepare_mem_entry() at the beginning and
destroyed by iter_finish_mem_entry() at the end.  So if it's used in a
new hist_entry, it should be cloned.  Simplify (hopefully) the logic
by adding some helper functions and not holding the refcount in the
temporary entry.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/hist.c       | 14 +++++++-------
 tools/perf/util/map_symbol.c | 18 ++++++++++++++++++
 tools/perf/util/map_symbol.h |  3 +++
 tools/perf/util/mem-info.c   | 13 +++++++++++++
 tools/perf/util/mem-info.h   |  1 +
 5 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index f028f113c4fd..f8ee1cd6929d 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -476,6 +476,12 @@ static int hist_entry__init(struct hist_entry *he,
 		he->branch_info->to.ms.map = map__get(he->branch_info->to.ms.map);
 	}
 
+	if (he->mem_info) {
+		he->mem_info = mem_info__clone(template->mem_info);
+		if (he->mem_info == NULL)
+			goto err_infos;
+	}
+
 	if (hist_entry__has_callchains(he) && symbol_conf.use_callchain)
 		callchain_init(he->callchain);
 
@@ -620,12 +626,6 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 			if (symbol_conf.cumulate_callchain)
 				he_stat__add_period(he->stat_acc, period);
 
-			/*
-			 * This mem info was allocated from sample__resolve_mem
-			 * and will not be used anymore.
-			 */
-			mem_info__zput(entry->mem_info);
-
 			block_info__delete(entry->block_info);
 
 			kvm_info__zput(entry->kvm_info);
@@ -739,7 +739,7 @@ __hists__add_entry(struct hists *hists,
 		.filtered = symbol__parent_filter(sym_parent) | al->filtered,
 		.hists	= hists,
 		.branch_info = bi,
-		.mem_info = mem_info__get(mi),
+		.mem_info = mi,
 		.kvm_info = ki,
 		.block_info = block_info,
 		.transaction = sample->transaction,
diff --git a/tools/perf/util/map_symbol.c b/tools/perf/util/map_symbol.c
index bef5079f2403..6ad2960bc289 100644
--- a/tools/perf/util/map_symbol.c
+++ b/tools/perf/util/map_symbol.c
@@ -13,3 +13,21 @@ void addr_map_symbol__exit(struct addr_map_symbol *ams)
 {
 	map_symbol__exit(&ams->ms);
 }
+
+void map_symbol__copy(struct map_symbol *dst, struct map_symbol *src)
+{
+	dst->maps = maps__get(src->maps);
+	dst->map = map__get(src->map);
+	dst->sym = src->sym;
+}
+
+void addr_map_symbol__copy(struct addr_map_symbol *dst, struct addr_map_symbol *src)
+{
+	map_symbol__copy(&dst->ms, &src->ms);
+
+	dst->addr = src->addr;
+	dst->al_addr = src->al_addr;
+	dst->al_level = src->al_level;
+	dst->phys_addr = src->phys_addr;
+	dst->data_page_size = src->data_page_size;
+}
diff --git a/tools/perf/util/map_symbol.h b/tools/perf/util/map_symbol.h
index 72d5ed938ed6..e370bb32ed47 100644
--- a/tools/perf/util/map_symbol.h
+++ b/tools/perf/util/map_symbol.h
@@ -26,4 +26,7 @@ struct addr_map_symbol {
 void map_symbol__exit(struct map_symbol *ms);
 void addr_map_symbol__exit(struct addr_map_symbol *ams);
 
+void map_symbol__copy(struct map_symbol *dst, struct map_symbol *src);
+void addr_map_symbol__copy(struct addr_map_symbol *dst, struct addr_map_symbol *src);
+
 #endif // __PERF_MAP_SYMBOL
diff --git a/tools/perf/util/mem-info.c b/tools/perf/util/mem-info.c
index 27d67721a695..d3efa9c139f2 100644
--- a/tools/perf/util/mem-info.c
+++ b/tools/perf/util/mem-info.c
@@ -33,3 +33,16 @@ struct mem_info *mem_info__new(void)
 
 	return result;
 }
+
+struct mem_info *mem_info__clone(struct mem_info *mi)
+{
+	struct mem_info *result = mem_info__new();
+
+	if (result) {
+		addr_map_symbol__copy(mem_info__iaddr(result), mem_info__iaddr(mi));
+		addr_map_symbol__copy(mem_info__daddr(result), mem_info__daddr(mi));
+		mem_info__data_src(result)->val = mem_info__data_src(mi)->val;
+	}
+
+	return result;
+}
diff --git a/tools/perf/util/mem-info.h b/tools/perf/util/mem-info.h
index 0f68e29f311b..df75e94ed3d0 100644
--- a/tools/perf/util/mem-info.h
+++ b/tools/perf/util/mem-info.h
@@ -15,6 +15,7 @@ DECLARE_RC_STRUCT(mem_info) {
 };
 
 struct mem_info *mem_info__new(void);
+struct mem_info *mem_info__clone(struct mem_info *mi);
 struct mem_info *mem_info__get(struct mem_info *mi);
 void   mem_info__put(struct mem_info *mi);
 
-- 
2.46.0.rc1.232.g9752f9e123-goog

