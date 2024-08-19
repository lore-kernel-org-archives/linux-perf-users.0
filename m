Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4381DF678;
	Mon, 19 Aug 2024 23:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724110566; cv=none; b=Tw5gDdneH9guigI1d71brfQ53ct+Oy1QwBSeO+ERoqql+rWwRhgmV3KqQzRo30ifE9LTGEJF2NQWdx9Y8URjv1GxtRDvjgacNCMZ7kfdHUBSULhBlZIGbgUd4yYnhyi9J7pwNY25f4guZGDV7y+UAQegNwX4stIUCOpigSMf954=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724110566; c=relaxed/simple;
	bh=xP36/MQmt8uKYGRnraypsMsRwtZikYQf2VK1nG/qmGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDjONZvI0sNsnlSU4f4Mroun7xL/mPuxh+DXdiC5iL2BUmYL6/HT4ZKLYUZl4ebx93vNSCnX+1f86lkYHexYaiursXbkaZTMXnB/srUEYzE1qTSI1u43+0J1Xz2rul94nm4Sc6O1GuFENyfP6EGq/hVAVbLlB/AYW9/ytJYK30o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRUtguyb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRUtguyb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E3DC4AF12;
	Mon, 19 Aug 2024 23:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724110565;
	bh=xP36/MQmt8uKYGRnraypsMsRwtZikYQf2VK1nG/qmGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRUtguybGXu3D9bws/gyBCnEdxicJtbdAlmaFkhkmxqRXED1HFnHePESoBvfBPen3
	 3XOqX5abWeG4SNJOCuqs3hNh1Bhq7UogTK3JGDoWNlW9xl4fMSo/p4CvkhxfTDmDQZ
	 l+QMhLHoF/CgiGsCJCP+jgDH80kJdIA2JH57ME1nOUpNVQxP0E9mR9jfgOUG9JkGOm
	 Kf2X2pe7X+1ngrckdFK5fhcc637a4/Ns5nHV/+t/tI3ohzf/01tX7ldG4aAbX/xFT+
	 IP26LVXjCwyS/dt+DbsjoVmi2dJ2gRU4hj9j0eq+nFYOzR8/QRWPqlUQLow69AUyx8
	 Jxo3DmenWwZEg==
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 2/2] perf annotate-data: Add 'typecln' sort key
Date: Mon, 19 Aug 2024 16:36:03 -0700
Message-ID: <20240819233603.54941-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240819233603.54941-1-namhyung@kernel.org>
References: <20240819233603.54941-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes it's useful to organize member fields in cache-line boundary.
The 'typecln' sort key is short for type-cacheline and to show samples
in each cacheline.  The cacheline size is fixed to 64 for now, but it
can read the actual size once it saves the value from sysfs.

For example, you maybe want to which cacheline in a target is hot or
cold.  The following shows members in the cfs_rq's first cache line.

  $ perf report -s type,typecln,typeoff -H
  ...
  -    2.67%        struct cfs_rq
     +    1.23%        struct cfs_rq: cache-line 2
     +    0.57%        struct cfs_rq: cache-line 4
     +    0.46%        struct cfs_rq: cache-line 6
     -    0.41%        struct cfs_rq: cache-line 0
             0.39%        struct cfs_rq +0x14 (h_nr_running)
             0.02%        struct cfs_rq +0x38 (tasks_timeline.rb_leftmost)
  ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/hist.h |  1 +
 tools/perf/util/sort.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/sort.h |  1 +
 3 files changed, 54 insertions(+)

diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 30c13fc8cbe4..deb1087c5948 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -86,6 +86,7 @@ enum hist_column {
 	HISTC_TYPE,
 	HISTC_TYPE_OFFSET,
 	HISTC_SYMBOL_OFFSET,
+	HISTC_TYPE_CACHELINE,
 	HISTC_NR_COLS, /* Last entry */
 };
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index d315308f9170..013020f33ece 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2326,6 +2326,57 @@ struct sort_entry sort_type_offset = {
 	.se_width_idx	= HISTC_TYPE_OFFSET,
 };
 
+/* --sort typecln */
+
+/* TODO: use actual value in the system */
+#define TYPE_CACHELINE_SIZE  64
+
+static int64_t
+sort__typecln_sort(struct hist_entry *left, struct hist_entry *right)
+{
+	struct annotated_data_type *left_type = left->mem_type;
+	struct annotated_data_type *right_type = right->mem_type;
+	int64_t left_cln, right_cln;
+	int64_t ret;
+
+	if (!left_type) {
+		sort__type_init(left);
+		left_type = left->mem_type;
+	}
+
+	if (!right_type) {
+		sort__type_init(right);
+		right_type = right->mem_type;
+	}
+
+	ret = strcmp(left_type->self.type_name, right_type->self.type_name);
+	if (ret)
+		return ret;
+
+	left_cln = left->mem_type_off / TYPE_CACHELINE_SIZE;
+	right_cln = right->mem_type_off / TYPE_CACHELINE_SIZE;
+	return left_cln - right_cln;
+}
+
+static int hist_entry__typecln_snprintf(struct hist_entry *he, char *bf,
+				     size_t size, unsigned int width __maybe_unused)
+{
+	struct annotated_data_type *he_type = he->mem_type;
+
+	return repsep_snprintf(bf, size, "%s: cache-line %d", he_type->self.type_name,
+			       he->mem_type_off / TYPE_CACHELINE_SIZE);
+}
+
+struct sort_entry sort_type_cacheline = {
+	.se_header	= "Data Type Cacheline",
+	.se_cmp		= sort__type_cmp,
+	.se_collapse	= sort__typecln_sort,
+	.se_sort	= sort__typecln_sort,
+	.se_init	= sort__type_init,
+	.se_snprintf	= hist_entry__typecln_snprintf,
+	.se_width_idx	= HISTC_TYPE_CACHELINE,
+};
+
 
 struct sort_dimension {
 	const char		*name;
@@ -2384,6 +2435,7 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_ANNOTATE_DATA_TYPE, "type", sort_type),
 	DIM(SORT_ANNOTATE_DATA_TYPE_OFFSET, "typeoff", sort_type_offset),
 	DIM(SORT_SYM_OFFSET, "symoff", sort_sym_offset),
+	DIM(SORT_ANNOTATE_DATA_TYPE_CACHELINE, "typecln", sort_type_cacheline),
 };
 
 #undef DIM
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 6357bc32c5ca..9ff68c6786e7 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -71,6 +71,7 @@ enum sort_type {
 	SORT_ANNOTATE_DATA_TYPE,
 	SORT_ANNOTATE_DATA_TYPE_OFFSET,
 	SORT_SYM_OFFSET,
+	SORT_ANNOTATE_DATA_TYPE_CACHELINE,
 
 	/* branch stack specific sort keys */
 	__SORT_BRANCH_STACK,
-- 
2.46.0.184.g6999bdac58-goog

