Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6956D3C0A16;
	Tue, 16 Jun 2026 02:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781576873; cv=none; b=a59LxzHP+cvUqH68vtUhWLIK/rqJdVjDiTr/gpZcrGjBsMPRmPe73mUtJaTWkacRSLMRyj+vSUaZqq++ruwr+Xp3/JKJvgDQrxcURZzlt8WbxrGK2eUc7NYAKSkBH4X0/4n1kkEVWYcqMRUr4wcpF/W3AR007I8RyaNMWijdiQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781576873; c=relaxed/simple;
	bh=Z4v8h1Jy04UF7O6kx2XkG7mmjuO8tERgs6sJc8mNFqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQoSXN/wrIYFr0+egbEdyuIi7EQcaHjogNQj2EbKgZFsTFK/LHCyLHouJH7oSfTUlO4YE4kx5C1BIU3EU4RSYMfkXEuUCAVnWBft+n6wzFHg6WnOHfJU68WPqZzHw+MG5ughpELOANHekAvKvMvDT7738hL70NMw6wDx0JjzQ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxNQybSW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxNQybSW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F217E1F000E9;
	Tue, 16 Jun 2026 02:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781576872;
	bh=Vt8Yue1E8kyHg+sTlZ3iA61RuhznbSSTRtLo504NlYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HxNQybSWQrLl5WbUgR4W9I0aVrvwT2gsFnZazBTRdHUjnvyLXibFs7iGgu5gblD04
	 0IEeYv+JQ//79goKiyWcWOZ6YGpY9d5rJGxWcEzubk02Cg/CcDppdcMZ5Dq4enoDmw
	 PMFqmFAJ/a+wvEPnizpXD7gEhkmk0U0IlPD8ch/JgSXKvYX+Mtq+F/6wwzv8TQFiTb
	 eRAM5ZIAbd8JC8F0ZxRRM5R8CPjvep4//WM2YONZrL4lIzU86pyyXrM/ZQ7UnnjC95
	 eOdqI4Dq3YdN9lmBb07BkaZF0cXFMZbzFuv+wrvMpylvLCCj419zFfcUpgadiIgLz6
	 m4KtC6bPXvM0w==
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
	Song Liu <songliubraving@fb.com>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 8/9] perf bpf: Validate array presence before casting BPF prog info pointers
Date: Mon, 15 Jun 2026 23:27:14 -0300
Message-ID: <20260616022715.5739-9-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616022715.5739-1-acme@kernel.org>
References: <20260616022715.5739-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Several functions cast bpf_prog_info fields (jited_ksyms,
jited_func_lens, jited_prog_insns) from u64 to pointers and
dereference them.  These fields are only valid pointers if
bpil_offs_to_addr() converted their file offsets to addresses, which
only happens when the corresponding PERF_BPIL_* bits are set in
info_linear->arrays.

A crafted perf.data can leave these bits unset while setting non-zero
counts and offset values, causing the functions to dereference raw file
offsets as pointers.

Add array bitmask validation to all perf.data processing paths:

  - __bpf_event__print_bpf_prog_info(): check JITED_KSYMS and
    JITED_FUNC_LENS (changed to take struct perf_bpil *)
  - machine__process_bpf_event_load(): check JITED_KSYMS
  - bpf_read(): check JITED_INSNS before memcpy from jited_prog_insns
  - dso__disassemble_filename(): check JITED_INSNS before returning
    jited_prog_insns pointer

Fixes: f8dfeae009effc0b ("perf bpf: Show more BPF program info in print_bpf_prog_info()")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 20 +++++++++++++++++---
 tools/perf/util/bpf-event.h |  4 ++--
 tools/perf/util/dso.c       | 10 ++++++++++
 tools/perf/util/header.c    |  3 +--
 4 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 57d53ba848359e12..fa3ebc8ea7f09cdd 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -59,6 +59,10 @@ static int machine__process_bpf_event_load(struct machine *machine,
 		return 0;
 	info_linear = info_node->info_linear;
 
+	/* jited_ksyms is only valid if bpil_offs_to_addr() converted it */
+	if (!(info_linear->arrays & (1UL << PERF_BPIL_JITED_KSYMS)))
+		return 0;
+
 	for (i = 0; i < info_linear->info.nr_jited_ksyms; i++) {
 		u64 *addrs = (u64 *)(uintptr_t)(info_linear->info.jited_ksyms);
 		u64 addr = addrs[i];
@@ -959,12 +963,15 @@ int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *env)
 	return evlist__add_sb_event(evlist, &attr, bpf_event__sb_cb, env);
 }
 
-void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
+void __bpf_event__print_bpf_prog_info(struct perf_bpil *info_linear,
 				      struct perf_env *env,
 				      FILE *fp)
 {
-	__u32 *prog_lens = (__u32 *)(uintptr_t)(info->jited_func_lens);
-	__u64 *prog_addrs = (__u64 *)(uintptr_t)(info->jited_ksyms);
+	struct bpf_prog_info *info = &info_linear->info;
+	__u64 required_arrays = (1UL << PERF_BPIL_JITED_KSYMS) |
+				(1UL << PERF_BPIL_JITED_FUNC_LENS);
+	__u32 *prog_lens;
+	__u64 *prog_addrs;
 	char name[KSYM_NAME_LEN];
 	struct btf *btf = NULL;
 	u32 sub_prog_cnt, i;
@@ -974,6 +981,13 @@ void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
 	    sub_prog_cnt != info->nr_jited_func_lens)
 		return;
 
+	/* Ensure the arrays were present and converted by bpil_offs_to_addr() */
+	if ((info_linear->arrays & required_arrays) != required_arrays)
+		return;
+
+	prog_lens = (__u32 *)(uintptr_t)(info->jited_func_lens);
+	prog_addrs = (__u64 *)(uintptr_t)(info->jited_ksyms);
+
 	if (info->btf_id) {
 		struct btf_node *node;
 
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 60d2c6637af5d6eb..da4eeb4a1a73208c 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -40,7 +40,7 @@ struct btf_node {
 int machine__process_bpf(struct machine *machine, union perf_event *event,
 			 struct perf_sample *sample);
 int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *env);
-void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
+void __bpf_event__print_bpf_prog_info(struct perf_bpil *info_linear,
 				      struct perf_env *env,
 				      FILE *fp);
 void bpf_metadata_free(struct bpf_metadata *metadata);
@@ -58,7 +58,7 @@ static inline int evlist__add_bpf_sb_event(struct evlist *evlist __maybe_unused,
 	return 0;
 }
 
-static inline void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info __maybe_unused,
+static inline void __bpf_event__print_bpf_prog_info(struct perf_bpil *info_linear __maybe_unused,
 						    struct perf_env *env __maybe_unused,
 						    FILE *fp __maybe_unused)
 {
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 1a2fc6d18da74d6c..79f1a30f3683d6b3 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -880,6 +880,12 @@ static ssize_t bpf_read(struct dso *dso, u64 offset, char *data)
 		return -1;
 	}
 
+	/* jited_prog_insns is only valid if bpil_offs_to_addr() converted it */
+	if (!(node->info_linear->arrays & (1UL << PERF_BPIL_JITED_INSNS))) {
+		dso__data(dso)->status = DSO_DATA_STATUS_ERROR;
+		return -1;
+	}
+
 	len = node->info_linear->info.jited_prog_len;
 	buf = (u8 *)(uintptr_t)node->info_linear->info.jited_prog_insns;
 
@@ -1995,6 +2001,10 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 			return NULL;
 		}
 		info_linear = info_node->info_linear;
+		if (!(info_linear->arrays & (1UL << PERF_BPIL_JITED_INSNS))) {
+			errno = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
+			return NULL;
+		}
 		assert(len <= info_linear->info.jited_prog_len);
 		*out_buf_len = len;
 		return (const u8 *)(uintptr_t)(info_linear->info.jited_prog_insns);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index d7f41db7322cbcb4..091d8f7f6bd2c9d5 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2107,8 +2107,7 @@ static void print_bpf_prog_info(struct feat_fd *ff __maybe_unused, FILE *fp)
 		node = rb_entry(next, struct bpf_prog_info_node, rb_node);
 		next = rb_next(&node->rb_node);
 
-		__bpf_event__print_bpf_prog_info(&node->info_linear->info,
-						 env, fp);
+		__bpf_event__print_bpf_prog_info(node->info_linear, env, fp);
 	}
 
 	up_read(&env->bpf_progs.lock);
-- 
2.54.0

