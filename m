Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EC12D662B
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 19:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749757790; cv=none; b=VoD9o+HZqudvu+VG672PyxbhOshZPG0mmphWc4zyL/eVAUCbVXCTvLUz2jBQ2GswIg4oq2wExMPAb5k9cwoN2IX8NR/2LRgUm7YuGV0w7ZLYayL1rJ3xHuUFE767uQYUJBhPWmbAeISjcxM1salzbvfdcSvfH8vqswXng8655Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749757790; c=relaxed/simple;
	bh=ia2kNtooLXZtddxtzmjyLOZyIOrYzFIrc2YWBoyTzE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DxprOFFXMign6UXYJ0UPmGg4jxAKFYbq2Pz/8Q5SM4RW7g+aYNCevLzIBqaGbauTOB0CTYzeKhhbOjHltfSPktmlgreNVxl2Ex0x6rvTNC6HduhJglLy/yfGZNMbqJ03lNfmm0T7BvJ3VG/tj38nuZyeYm5e2nXGECmG2QOpsss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Ohk/U6M; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Ohk/U6M"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74880a02689so1414324b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 12:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749757788; x=1750362588; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RwgwORwGUH9uFoqt6oU2k4z3IDDLnBCDkrf4pU2pZuE=;
        b=1Ohk/U6M+HM73qFP/xGDW255KKxSiq2eW1YSJzUK8AmKuRlERHf6M8TS9O5o+ke91q
         BN6Sg51MBNeKt3Xq+FhAZEb2WfQ2mZPyh7x9mYHJiBrBO329NiFlyStDyX5/THsLPg7G
         RL/tv0VKpoYZ6nuP7t3kMrHllKgQ4E2WjWE9rBQnQRkkAGrBdW++xuGVtNCPFcq37ABd
         Vr7byi/ULYmIWHrFFLBfsKWECy2qGFMXjRheh/EgYZ8SfeoDo5Ft1rvbV/1lpRPb57LG
         bbMTH6WhEHvmz5FS1fg6JKFwOH/6m1ghDjfgQLqurGSC5vSKTt38DZRYiOPQn0GkbMiK
         4ZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749757788; x=1750362588;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwgwORwGUH9uFoqt6oU2k4z3IDDLnBCDkrf4pU2pZuE=;
        b=VtFYPRSfHZpJftd60WvdTgbfMQHUFnx9bXKmiadzqmUnN9hEfvNDUzxYhbdtxa67dD
         dEF4JcWqWgLhRjcjUXb3KWsHKQ5XaCHyaqbiWz57lAMMhYH6VMR/pGZKdrCjbEHi24qH
         0fqyrGIMtMr5gkMFOqIMB4g1sL2eow87UeYNekWE7U2+IBgNlEn9vz5PgQaXYaYB956J
         +PIiDBo9HaS+99j2v/p2oPqlK0oivMeX8N/WULGfNV1P0nCrm3LTkQEdf9wM6kitOClk
         M5lDlwHIS3GnLaV9v/jM8/qUYbXuKbrvaGxG4brjKgKcc0iE1LExN9s6AI9AHsiJGN6J
         V/9A==
X-Forwarded-Encrypted: i=1; AJvYcCU6w+clMRuZWE8SEPw9dgBZYemjPQC3J4HTipr0Ubg6jtz4hhs+o2NFdrRFGXvJyTtD7bbz4vKWYq/FkOOrrMzn@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh/sVmgSJgqUcAZB27pE9mvmKgmSFwXktYsTfDK8SPSyO9w20f
	rRJo5hluzsETnQQYTgv/pXfR7Sa6BcxUdMRcHwmdWwJcl+Fq1/V5FthX3CIM6LB+ODy4pUVW3Tj
	SIRpB+ONHSUltsWe25oNn4A==
X-Google-Smtp-Source: AGHT+IGNw4lkpwjaf4v6bXxIOzfZmFO85pS43p7oo8MRgEqWKeMneT7/6nkmbDJ+tkgVhVSPF+Jk1alL6QtQUiX0
X-Received: from pfbkq16.prod.google.com ([2002:a05:6a00:4b10:b0:73c:29d8:b795])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:c89:b0:736:a540:c9ad with SMTP id d2e1a72fcca58-7488f71e782mr688264b3a.20.1749757787828;
 Thu, 12 Jun 2025 12:49:47 -0700 (PDT)
Date: Thu, 12 Jun 2025 12:49:37 -0700
In-Reply-To: <20250612194939.162730-1-blakejones@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250612194939.162730-1-blakejones@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250612194939.162730-4-blakejones@google.com>
Subject: [PATCH v4 3/5] perf: collect BPF metadata from new programs
From: Blake Jones <blakejones@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	Graham Woodward <graham.woodward@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"

This collects metadata for any BPF programs that were loaded during a
"perf record" run, and emits it at the end of the run.

Signed-off-by: Blake Jones <blakejones@google.com>
---
 tools/perf/builtin-record.c        | 10 +++++++
 tools/perf/util/bpf-event.c        | 46 ++++++++++++++++++++++++++++++
 tools/perf/util/bpf-event.h        |  1 +
 tools/perf/util/env.c              | 19 +++++++++++-
 tools/perf/util/env.h              |  6 ++++
 tools/perf/util/header.c           |  1 +
 tools/perf/util/synthetic-events.h |  2 ++
 7 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0b566f300569..53971b9de3ba 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2162,6 +2162,14 @@ static int record__synthesize(struct record *rec, bool tail)
 	return err;
 }
 
+static void record__synthesize_final_bpf_metadata(struct record *rec __maybe_unused)
+{
+#ifdef HAVE_LIBBPF_SUPPORT
+	perf_event__synthesize_final_bpf_metadata(rec->session,
+						  process_synthesized_event);
+#endif
+}
+
 static int record__process_signal_event(union perf_event *event __maybe_unused, void *data)
 {
 	struct record *rec = data;
@@ -2807,6 +2815,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	trigger_off(&auxtrace_snapshot_trigger);
 	trigger_off(&switch_output_trigger);
 
+	record__synthesize_final_bpf_metadata(rec);
+
 	if (opts->auxtrace_snapshot_on_exit)
 		record__auxtrace_snapshot_exit(rec);
 
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 1f6e76ee6024..dc09a4730c50 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -472,6 +472,49 @@ void bpf_metadata_free(struct bpf_metadata *metadata __maybe_unused)
 
 #endif /* HAVE_LIBBPF_STRINGS_SUPPORT */
 
+struct bpf_metadata_final_ctx {
+	const struct perf_tool *tool;
+	perf_event__handler_t process;
+	struct machine *machine;
+};
+
+static void synthesize_final_bpf_metadata_cb(struct bpf_prog_info_node *node,
+					     void *data)
+{
+	struct bpf_metadata_final_ctx *ctx = (struct bpf_metadata_final_ctx *)data;
+	struct bpf_metadata *metadata = node->metadata;
+	int err;
+
+	if (metadata == NULL)
+		return;
+	err = synthesize_perf_record_bpf_metadata(metadata, ctx->tool,
+						  ctx->process, ctx->machine);
+	if (err != 0) {
+		const char *prog_name = metadata->prog_names[0];
+
+		if (prog_name != NULL)
+			pr_warning("Couldn't synthesize final BPF metadata for %s.\n", prog_name);
+		else
+			pr_warning("Couldn't synthesize final BPF metadata.\n");
+	}
+	bpf_metadata_free(metadata);
+	node->metadata = NULL;
+}
+
+void perf_event__synthesize_final_bpf_metadata(struct perf_session *session,
+					       perf_event__handler_t process)
+{
+	struct perf_env *env = &session->header.env;
+	struct bpf_metadata_final_ctx ctx = {
+		.tool = session->tool,
+		.process = process,
+		.machine = &session->machines.host,
+	};
+
+	perf_env__iterate_bpf_prog_info(env, synthesize_final_bpf_metadata_cb,
+					&ctx);
+}
+
 /*
  * Synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for one bpf
  * program. One PERF_RECORD_BPF_EVENT is generated for the program. And
@@ -612,6 +655,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 		}
 
 		info_node->info_linear = info_linear;
+		info_node->metadata = NULL;
 		if (!perf_env__insert_bpf_prog_info(env, info_node)) {
 			free(info_linear);
 			free(info_node);
@@ -803,6 +847,7 @@ static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
 	arrays |= 1UL << PERF_BPIL_JITED_INSNS;
 	arrays |= 1UL << PERF_BPIL_LINE_INFO;
 	arrays |= 1UL << PERF_BPIL_JITED_LINE_INFO;
+	arrays |= 1UL << PERF_BPIL_MAP_IDS;
 
 	info_linear = get_bpf_prog_info_linear(fd, arrays);
 	if (IS_ERR_OR_NULL(info_linear)) {
@@ -815,6 +860,7 @@ static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
 	info_node = malloc(sizeof(struct bpf_prog_info_node));
 	if (info_node) {
 		info_node->info_linear = info_linear;
+		info_node->metadata = bpf_metadata_create(&info_linear->info);
 		if (!perf_env__insert_bpf_prog_info(env, info_node)) {
 			free(info_linear);
 			free(info_node);
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index ef2dd3f1619e..60d2c6637af5 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -25,6 +25,7 @@ struct bpf_metadata {
 
 struct bpf_prog_info_node {
 	struct perf_bpil		*info_linear;
+	struct bpf_metadata		*metadata;
 	struct rb_node			rb_node;
 };
 
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 36411749e007..05a4f2657d72 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -3,8 +3,10 @@
 #include "debug.h"
 #include "env.h"
 #include "util/header.h"
-#include "linux/compiler.h"
+#include "util/rwsem.h"
+#include <linux/compiler.h>
 #include <linux/ctype.h>
+#include <linux/rbtree.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
 #include "cgroup.h"
@@ -89,6 +91,20 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 	return node;
 }
 
+void perf_env__iterate_bpf_prog_info(struct perf_env *env,
+				     void (*cb)(struct bpf_prog_info_node *node,
+						void *data),
+				     void *data)
+{
+	struct rb_node *first;
+
+	down_read(&env->bpf_progs.lock);
+	first = rb_first(&env->bpf_progs.infos);
+	for (struct rb_node *node = first; node != NULL; node = rb_next(node))
+		(*cb)(rb_entry(node, struct bpf_prog_info_node, rb_node), data);
+	up_read(&env->bpf_progs.lock);
+}
+
 bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
 {
 	bool ret;
@@ -174,6 +190,7 @@ static void perf_env__purge_bpf(struct perf_env *env)
 		next = rb_next(&node->rb_node);
 		rb_erase(&node->rb_node, root);
 		zfree(&node->info_linear);
+		bpf_metadata_free(node->metadata);
 		free(node);
 	}
 
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index d90e343cf1fa..c90c1d717e73 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -174,16 +174,22 @@ const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
 
 void perf_env__init(struct perf_env *env);
+#ifdef HAVE_LIBBPF_SUPPORT
 bool __perf_env__insert_bpf_prog_info(struct perf_env *env,
 				      struct bpf_prog_info_node *info_node);
 bool perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node);
 struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 							__u32 prog_id);
+void perf_env__iterate_bpf_prog_info(struct perf_env *env,
+				     void (*cb)(struct bpf_prog_info_node *node,
+						void *data),
+				     void *data);
 bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
 bool __perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
 struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
 struct btf_node *__perf_env__find_btf(struct perf_env *env, __u32 btf_id);
+#endif // HAVE_LIBBPF_SUPPORT
 
 int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu);
 char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e3cdc3b7b4ab..7c477e2a93b3 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3161,6 +3161,7 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
 		/* after reading from file, translate offset to address */
 		bpil_offs_to_addr(info_linear);
 		info_node->info_linear = info_linear;
+		info_node->metadata = NULL;
 		if (!__perf_env__insert_bpf_prog_info(env, info_node)) {
 			free(info_linear);
 			free(info_node);
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
index b9c936b5cfeb..ee29615d68e5 100644
--- a/tools/perf/util/synthetic-events.h
+++ b/tools/perf/util/synthetic-events.h
@@ -92,6 +92,8 @@ int perf_event__synthesize_threads(const struct perf_tool *tool, perf_event__han
 int perf_event__synthesize_tracing_data(const struct perf_tool *tool, int fd, struct evlist *evlist, perf_event__handler_t process);
 int perf_event__synth_time_conv(const struct perf_event_mmap_page *pc, const struct perf_tool *tool, perf_event__handler_t process, struct machine *machine);
 pid_t perf_event__synthesize_comm(const struct perf_tool *tool, union perf_event *event, pid_t pid, perf_event__handler_t process, struct machine *machine);
+void perf_event__synthesize_final_bpf_metadata(struct perf_session *session,
+					       perf_event__handler_t process);
 
 int perf_tool__process_synth_event(const struct perf_tool *tool, union perf_event *event, struct machine *machine, perf_event__handler_t process);
 
-- 
2.50.0.rc1.591.g9c95f17f64-goog

