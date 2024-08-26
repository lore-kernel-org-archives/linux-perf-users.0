Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BBD19D095;
	Mon, 26 Aug 2024 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710248; cv=none; b=S7PbEAnA83NTyT3lIwM887Q8CXIkdFUEKezLhfgguqk7KmhT6e6hCUW8jxAd0pur799WpCjS49k2c3pAxQ9icTyUCbKRnwQ8P8gGVnoOWyvb0sI8CYWB9todIOf4xJ3sl/QN6t81XB1mwg9K48f+9l41VSuk565YJlpLoKEFkjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710248; c=relaxed/simple;
	bh=Qdgofb7vp62wStMKGFnw4VWBW7ZkAIyyM4zGeyvSIgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTOoGnI8shDsXdYZmlF5vaMsorpLVlE5sEkZjqnyua2aGQQn9LpRUj/6jNg+hCxjj7BWuRUMjdM1qTjy/xw00Rw+eza6v/4vEUqBaLULj5wvofXqmvjv1tygLv6Go0+25UhNMMw1gFL6WVQwQvh5YTO5+pzivFlKsJEb9jmQz/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZZQwuJA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZZQwuJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BB7C8B7DB;
	Mon, 26 Aug 2024 22:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724710248;
	bh=Qdgofb7vp62wStMKGFnw4VWBW7ZkAIyyM4zGeyvSIgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZZQwuJAIwXSv3lDa40afhaM/OGW5O/Q9JLHW9E/IUjv0QnFdfjBzTl0S356KKGUx
	 WFOm95FWbUsEX1lKNOGziSLcQNbAfEVN0kc55O2ONkuRJCpPurggv41VD8E+iSZ0mz
	 POYHZZGtkrAvBng4ByXvxYuFxUT2QG76vuTIIpLxXkynBG7J/nxDQU+9TRS2GzG4ZJ
	 yBGBM3cJEDANkcIaKVY2kH0LDKF8xti+DemqHvMLuN65BjkgnLFgXxOriw2Wqyrv/Q
	 01TitS0ebtoTU/N8S5vQBgh/aP69beDra/mtcKyAXvgoGAxqjmNI3Izc6yp1Z947Oa
	 s/qyD/AfAm+Fw==
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
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 3/4] perf bpf-filter: Support filtering on cgroups
Date: Mon, 26 Aug 2024 15:10:44 -0700
Message-ID: <20240826221045.1202305-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240826221045.1202305-1-namhyung@kernel.org>
References: <20240826221045.1202305-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new cgroup filter can take either of '==' or '!=' operator and a
pathname for the target cgroup.

  $ perf record -a --all-cgroups -e cycles --filter 'cgroup == /abc/def' -- sleep 1

Users should have --all-cgroups option in the command line to enable
cgroup filtering.  Technically it doesn't need to have the option as
it can get the current task's cgroup info directly from BPF.  But I want
to follow the convention for the other sample info.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf-filter.c                 |  1 +
 tools/perf/util/bpf-filter.l                 | 28 ++++++++++++++++----
 tools/perf/util/bpf-filter.y                 | 28 ++++++++++++++++++--
 tools/perf/util/bpf_skel/sample-filter.h     |  2 +-
 tools/perf/util/bpf_skel/sample_filter.bpf.c |  4 ++-
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h   |  1 +
 6 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 0a1832564dd2..e87b6789eb9e 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -100,6 +100,7 @@ static const struct perf_sample_info {
 	PERF_SAMPLE_TYPE(TRANSACTION, "--transaction"),
 	PERF_SAMPLE_TYPE(CODE_PAGE_SIZE, "--code-page-size"),
 	PERF_SAMPLE_TYPE(DATA_PAGE_SIZE, "--data-page-size"),
+	PERF_SAMPLE_TYPE(CGROUP, "--all-cgroups"),
 };
 
 static int get_pinned_fd(const char *name);
diff --git a/tools/perf/util/bpf-filter.l b/tools/perf/util/bpf-filter.l
index 2a7c839f3fae..f313404f95a9 100644
--- a/tools/perf/util/bpf-filter.l
+++ b/tools/perf/util/bpf-filter.l
@@ -9,8 +9,11 @@
 #include "bpf-filter.h"
 #include "bpf-filter-bison.h"
 
+extern int perf_bpf_filter_needs_path;
+
 static int sample(enum perf_bpf_filter_term term)
 {
+	perf_bpf_filter_needs_path = 0;
 	perf_bpf_filter_lval.sample.term = term;
 	perf_bpf_filter_lval.sample.part = 0;
 	return BFT_SAMPLE;
@@ -18,11 +21,20 @@ static int sample(enum perf_bpf_filter_term term)
 
 static int sample_part(enum perf_bpf_filter_term term, int part)
 {
+	perf_bpf_filter_needs_path = 0;
 	perf_bpf_filter_lval.sample.term = term;
 	perf_bpf_filter_lval.sample.part = part;
 	return BFT_SAMPLE;
 }
 
+static int sample_path(enum perf_bpf_filter_term term)
+{
+	perf_bpf_filter_needs_path = 1;
+	perf_bpf_filter_lval.sample.term = term;
+	perf_bpf_filter_lval.sample.part = 0;
+	return BFT_SAMPLE_PATH;
+}
+
 static int operator(enum perf_bpf_filter_op op)
 {
 	perf_bpf_filter_lval.op = op;
@@ -48,10 +60,15 @@ static int constant(int val)
 	return BFT_NUM;
 }
 
-static int error(const char *str)
+static int path_or_error(void)
 {
-	printf("perf_bpf_filter: Unexpected filter %s: %s\n", str, perf_bpf_filter_text);
-	return BFT_ERROR;
+	if (!perf_bpf_filter_needs_path) {
+		printf("perf_bpf_filter: Error: Unexpected item: %s\n",
+			perf_bpf_filter_text);
+		return BFT_ERROR;
+	}
+	perf_bpf_filter_lval.path = perf_bpf_filter_text;
+	return BFT_PATH;
 }
 
 %}
@@ -59,6 +76,7 @@ static int error(const char *str)
 num_dec		[0-9]+
 num_hex		0[Xx][0-9a-fA-F]+
 space		[ \t]+
+path		[^ \t\n]+
 ident		[_a-zA-Z][_a-zA-Z0-9]+
 
 %%
@@ -97,6 +115,7 @@ mem_blk		{ return sample_part(PBF_TERM_DATA_SRC, 7); }
 mem_hops	{ return sample_part(PBF_TERM_DATA_SRC, 8); }
 uid		{ return sample(PBF_TERM_UID); }
 gid		{ return sample(PBF_TERM_GID); }
+cgroup		{ return sample_path(PBF_TERM_CGROUP); }
 
 "=="		{ return operator(PBF_OP_EQ); }
 "!="		{ return operator(PBF_OP_NEQ); }
@@ -155,7 +174,6 @@ hops3		{ return constant(PERF_MEM_HOPS_3); }
 ","		{ return ','; }
 "||"		{ return BFT_LOGICAL_OR; }
 
-{ident}		{ return error("ident"); }
-.		{ return error("input"); }
+{path}		{ return path_or_error(); }
 
 %%
diff --git a/tools/perf/util/bpf-filter.y b/tools/perf/util/bpf-filter.y
index 0c56fccb8874..5a79a8e7a45b 100644
--- a/tools/perf/util/bpf-filter.y
+++ b/tools/perf/util/bpf-filter.y
@@ -12,9 +12,13 @@
 #include <linux/compiler.h>
 #include <linux/list.h>
 #include "bpf-filter.h"
+#include "cgroup.h"
 
 int perf_bpf_filter_lex(void);
 
+/* To indicate if the current term needs a pathname or not */
+int perf_bpf_filter_needs_path;
+
 static void perf_bpf_filter_error(struct list_head *expr __maybe_unused,
 				  char const *msg)
 {
@@ -26,6 +30,7 @@ static void perf_bpf_filter_error(struct list_head *expr __maybe_unused,
 %union
 {
 	unsigned long num;
+	char *path;
 	struct {
 		enum perf_bpf_filter_term term;
 		int part;
@@ -34,12 +39,13 @@ static void perf_bpf_filter_error(struct list_head *expr __maybe_unused,
 	struct perf_bpf_filter_expr *expr;
 }
 
-%token BFT_SAMPLE BFT_OP BFT_ERROR BFT_NUM BFT_LOGICAL_OR
+%token BFT_SAMPLE BFT_SAMPLE_PATH BFT_OP BFT_ERROR BFT_NUM BFT_LOGICAL_OR BFT_PATH
 %type <expr> filter_term filter_expr
 %destructor { free ($$); } <expr>
-%type <sample> BFT_SAMPLE
+%type <sample> BFT_SAMPLE BFT_SAMPLE_PATH
 %type <op> BFT_OP
 %type <num> BFT_NUM
+%type <path> BFT_PATH
 
 %%
 
@@ -81,5 +87,23 @@ BFT_SAMPLE BFT_OP BFT_NUM
 {
 	$$ = perf_bpf_filter_expr__new($1.term, $1.part, $2, $3);
 }
+|
+BFT_SAMPLE_PATH BFT_OP BFT_PATH
+{
+	struct cgroup *cgrp;
+	unsigned long cgroup_id = 0;
+
+	if ($2 != PBF_OP_EQ && $2 != PBF_OP_NEQ) {
+		printf("perf_bpf_filter: cgroup accepts '==' or '!=' only\n");
+		YYERROR;
+	}
+
+	cgrp = cgroup__new($3, /*do_open=*/false);
+	if (cgrp && read_cgroup_id(cgrp) == 0)
+		cgroup_id = cgrp->id;
+
+	$$ = perf_bpf_filter_expr__new($1.term, $1.part, $2, cgroup_id);
+	cgroup__put(cgrp);
+}
 
 %%
diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/bpf_skel/sample-filter.h
index 5f0c8e4e83d3..683fec85e71e 100644
--- a/tools/perf/util/bpf_skel/sample-filter.h
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -45,7 +45,7 @@ enum perf_bpf_filter_term {
 	__PBF_UNUSED_TERM18	= PBF_TERM_SAMPLE_START + 18, /* SAMPLE_REGS_INTR = 1U << 18 */
 	PBF_TERM_PHYS_ADDR	= PBF_TERM_SAMPLE_START + 19, /* SAMPLE_PHYS_ADDR = 1U << 19 */
 	__PBF_UNUSED_TERM20	= PBF_TERM_SAMPLE_START + 20, /* SAMPLE_AUX = 1U << 20 */
-	__PBF_UNUSED_TERM21	= PBF_TERM_SAMPLE_START + 21, /* SAMPLE_CGROUP = 1U << 21 */
+	PBF_TERM_CGROUP		= PBF_TERM_SAMPLE_START + 21, /* SAMPLE_CGROUP = 1U << 21 */
 	PBF_TERM_DATA_PAGE_SIZE	= PBF_TERM_SAMPLE_START + 22, /* SAMPLE_DATA_PAGE_SIZE = 1U << 22 */
 	PBF_TERM_CODE_PAGE_SIZE	= PBF_TERM_SAMPLE_START + 23, /* SAMPLE_CODE_PAGE_SIZE = 1U << 23 */
 	PBF_TERM_WEIGHT_STRUCT	= PBF_TERM_SAMPLE_START + 24, /* SAMPLE_WEIGHT_STRUCT = 1U << 24 */
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index 4872a16eedfd..b195e6efeb8b 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -93,6 +93,7 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 	BUILD_CHECK_SAMPLE(DATA_SRC);
 	BUILD_CHECK_SAMPLE(TRANSACTION);
 	BUILD_CHECK_SAMPLE(PHYS_ADDR);
+	BUILD_CHECK_SAMPLE(CGROUP);
 	BUILD_CHECK_SAMPLE(DATA_PAGE_SIZE);
 	BUILD_CHECK_SAMPLE(CODE_PAGE_SIZE);
 	BUILD_CHECK_SAMPLE(WEIGHT_STRUCT);
@@ -135,6 +136,8 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 		return kctx->data->weight.full;
 	case PBF_TERM_PHYS_ADDR:
 		return kctx->data->phys_addr;
+	case PBF_TERM_CGROUP:
+		return kctx->data->cgroup;
 	case PBF_TERM_CODE_PAGE_SIZE:
 		return kctx->data->code_page_size;
 	case PBF_TERM_DATA_PAGE_SIZE:
@@ -183,7 +186,6 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 	case __PBF_UNUSED_TERM16:
 	case __PBF_UNUSED_TERM18:
 	case __PBF_UNUSED_TERM20:
-	case __PBF_UNUSED_TERM21:
 	default:
 		break;
 	}
diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
index 4fa21468487e..4dcad7b682bd 100644
--- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
+++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
@@ -171,6 +171,7 @@ struct perf_sample_data {
 		u32		 cpu;
 	} cpu_entry;
 	u64			 phys_addr;
+	u64			 cgroup;
 	u64			 data_page_size;
 	u64			 code_page_size;
 } __attribute__((__aligned__(64))) __attribute__((preserve_access_index));
-- 
2.46.0.295.g3b9ea8a38a-goog

