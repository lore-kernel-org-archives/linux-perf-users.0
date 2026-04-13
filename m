Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A5538AC87
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053599; cv=none; b=BllKyWSBtshDolfvUhRkla2pNfmTIb1mD0VDVLnOiMY0UnSiyujT7q/hDSoQCmBU9DKOOQhtMOxwbgjaHXfdT4Tc7CBUwiksQDy8RTXTnwSHqcXi663vbNwcINhqaWUHVBANwnyFQYjkwLwNDVxR3jsWuEETFPWp46ohpJyQ+jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053599; c=relaxed/simple;
	bh=o+libGjGGnh0PZHJw+kVOgmbQh9zxpxsvn3EuaHS1hA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V9hjoQgBb4u8cn59ik7GyvOR7MAj2ztuA/RD5HbuzjLFXMXRDyDWbWVUQU3mAGD+LFlEd769GkncBeBKsAyZrA23LW0ytNqpmeiw7hGn6UuZY49QHrU/spqx0O55cuOXPmN/l5BsBeIxwJZD/Zrxoq2LWrv0UXDfp/fUWXMToNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZemXixf3; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZemXixf3"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d8a677cdfaso787281eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 21:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776053595; x=1776658395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qTdwOD5MvJj+i4G9bVPQNL0PRv4ibjmw6Xi5PZQFnqk=;
        b=ZemXixf3AusxeI6TcDjaQG0VYd0yiFtUt55nfWORzxWukp0AC58zFeZVi6liMXOzjQ
         upR28Q74QItrD3K7Vxw+Q5PSmk7Bfp0MJYvnHnXWVCF7LX5IutxJK4Kiidg+bMd1u7Lm
         8gxgjm9HXvSfF5J/+RXHnQdT3gQlbxGI54gLoQY6SjUqAuWWMAJKaePRUWMkzg/M5kaO
         t9TmIaoPZ2P1ZmXrMFYYKF4Zn3hJ7wjjcVymT5FhhHaGr1Py1sk6BcwjLrX5wcqBiyfj
         Om5HaFq2wHg48ffo8q1XzQmQON6tnZpPZy8RBUsuVXTqVibaD77OqAJcVChVCFWYPhxG
         D55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053595; x=1776658395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qTdwOD5MvJj+i4G9bVPQNL0PRv4ibjmw6Xi5PZQFnqk=;
        b=s5qfNAEpufS3iD8VzgZCgqokkUVyUgJZoejiAo4sRv5xR9w05c619qBD4s+yK97F5w
         sF7Xad7/uHZIeFtoVkA852qkeLlLE+cxQmg5XyuXuW5A/izZwMHtZvxEij24VORMfHeZ
         2s3U8wJx+gOFWwv2jvg9x+9s1/75riNf6xLpE6N7TNq+2QYhKG+/7J2BC9R50CeSSaEd
         j9TEPuQxnEdbAUmRQFd8lYlfZIpizeh2vYsVu///WbuTs7HtT3m9OARqkhtKZQbzFpV6
         MVLCbOV5NcUAPjn4WPgWniIpEZCYvIJu+kERQggMX+nHLiyKbKBanQFgzk3mPpy+XJ+0
         UATg==
X-Forwarded-Encrypted: i=1; AFNElJ8ZWnC1QiEj4Fqy8vBXLIjU4KMdie4cK/cNZFIv5On1UDKhITupi00sWmuTXDPq8ld3n7ws57FrmCf0dUERaqF6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+UMGp0ETWmKlYKY+2Gz6tcSA613xFnXUlwTCIrensXxzike+e
	u3r/598SJM91al7hQUKqdttbfjujb/XgPzrK28lId6NL5HimidcQBzzLdNbPaFGKAWS1zL1l/+x
	pyiPapwVlvg==
X-Received: from dykp36.prod.google.com ([2002:a05:7300:ca4:b0:2d1:54d:3d96])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2c84:b0:2c5:d833:a4f3
 with SMTP id 5a478bee46e88-2d58907b4admr6687484eec.18.1776053594645; Sun, 12
 Apr 2026 21:13:14 -0700 (PDT)
Date: Sun, 12 Apr 2026 21:11:43 -0700
In-Reply-To: <20260413041143.1736055-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413012227.1089445-1-irogers@google.com> <20260413041143.1736055-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413041143.1736055-34-irogers@google.com>
Subject: [PATCH v12 33/33] perf kwork: Fix memory management of kwork_work
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

This commit addresses several memory management issues in builtin-kwork.c:
1. Implements a global cleanup function perf_kwork__exit to free all
   kwork_work and kwork_atom_page objects at the end of the command.
2. Ensures all 'name' fields in struct kwork_work are malloc-ed (or NULL)
   and properly freed by using strdup and zfree.
3. Fixes memory leaks in top_merge_tasks where kwork_work objects were
   dropped without being freed.
4. Adds robustness with NULL checks for name fields.
5. Fixes workqueue_work_init to correctly resolve and strdup kernel
   function names, preventing bad-free errors.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kwork.c  | 125 ++++++++++++++++++++++++++++--------
 tools/perf/util/bpf_kwork.c |  14 ++--
 tools/perf/util/kwork.h     |   2 +
 3 files changed, 112 insertions(+), 29 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index a4604e152002..75c50073c350 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -323,8 +323,8 @@ static struct kwork_work *work_search(struct rb_root_cached *root,
 		else if (cmp < 0)
 			node = node->rb_right;
 		else {
-			if (work->name == NULL)
-				work->name = key->name;
+			if (work->name == NULL && key->name != NULL)
+				work->name = strdup(key->name);
 			return work;
 		}
 	}
@@ -371,11 +371,58 @@ static struct kwork_work *work_new(struct kwork_work *key)
 
 	work->id = key->id;
 	work->cpu = key->cpu;
-	work->name = key->name;
+	work->name = key->name ? strdup(key->name) : NULL;
 	work->class = key->class;
 	return work;
 }
 
+void work_exit(struct kwork_work *work)
+{
+	zfree(&work->name);
+}
+
+static void work_delete(struct kwork_work *work)
+{
+	if (work) {
+		work_exit(work);
+		free(work);
+	}
+}
+
+static void kwork_work__free_root(struct rb_root_cached *root)
+{
+	struct rb_node *next;
+	struct kwork_work *work;
+
+	while ((next = rb_first_cached(root))) {
+		work = rb_entry(next, struct kwork_work, node);
+		rb_erase_cached(next, root);
+		work_delete(work);
+	}
+}
+
+static void perf_kwork__exit(struct perf_kwork *kwork)
+{
+	struct kwork_class *class;
+	struct kwork_atom_page *page, *tmp_page;
+
+	list_for_each_entry(class, &kwork->class_list, list) {
+		kwork_work__free_root(&class->work_root);
+	}
+
+	kwork_work__free_root(&kwork->sorted_work_root);
+
+	list_for_each_entry_safe(page, tmp_page, &kwork->atom_page_list, list) {
+		list_del_init(&page->list);
+		free(page);
+	}
+
+	INIT_LIST_HEAD(&kwork->class_list);
+	INIT_LIST_HEAD(&kwork->atom_page_list);
+	INIT_LIST_HEAD(&kwork->sort_list);
+	INIT_LIST_HEAD(&kwork->cmp_id);
+}
+
 static struct kwork_work *work_findnew(struct rb_root_cached *root,
 				       struct kwork_work *key,
 				       struct list_head *sort_list)
@@ -453,25 +500,29 @@ static int work_push_atom(struct perf_kwork *kwork,
 			  struct kwork_work **ret_work,
 			  bool overwrite)
 {
-	struct kwork_atom *atom, *dst_atom, *last_atom;
+	struct kwork_atom *atom = NULL, *dst_atom, *last_atom;
 	struct kwork_work *work, key;
+	int ret = 0;
 
 	BUG_ON(class->work_init == NULL);
 	class->work_init(kwork, class, &key, src_type, sample, machine);
 
 	atom = atom_new(kwork, sample);
-	if (atom == NULL)
-		return -1;
+	if (atom == NULL) {
+		ret = -1;
+		goto out;
+	}
 
 	work = work_findnew(&class->work_root, &key, &kwork->cmp_id);
 	if (work == NULL) {
 		atom_free(atom);
-		return -1;
+		ret = -1;
+		goto out;
 	}
 
 	if (!profile_event_match(kwork, work, sample)) {
 		atom_free(atom);
-		return 0;
+		goto out;
 	}
 
 	if (dst_type < KWORK_TRACE_MAX) {
@@ -498,8 +549,9 @@ static int work_push_atom(struct perf_kwork *kwork,
 	}
 
 	list_add_tail(&atom->list, &work->atom_list[src_type]);
-
-	return 0;
+out:
+	work_exit(&key);
+	return ret;
 }
 
 static struct kwork_atom *work_pop_atom(struct perf_kwork *kwork,
@@ -510,7 +562,7 @@ static struct kwork_atom *work_pop_atom(struct perf_kwork *kwork,
 					struct machine *machine,
 					struct kwork_work **ret_work)
 {
-	struct kwork_atom *atom, *src_atom;
+	struct kwork_atom *atom = NULL, *src_atom;
 	struct kwork_work *work, key;
 
 	BUG_ON(class->work_init == NULL);
@@ -521,15 +573,15 @@ static struct kwork_atom *work_pop_atom(struct perf_kwork *kwork,
 		*ret_work = work;
 
 	if (work == NULL)
-		return NULL;
+		goto out;
 
 	if (!profile_event_match(kwork, work, sample))
-		return NULL;
+		goto out;
 
 	atom = list_last_entry_or_null(&work->atom_list[dst_type],
 				       struct kwork_atom, list);
 	if (atom != NULL)
-		return atom;
+		goto out;
 
 	src_atom = atom_new(kwork, sample);
 	if (src_atom != NULL)
@@ -538,8 +590,9 @@ static struct kwork_atom *work_pop_atom(struct perf_kwork *kwork,
 		if (ret_work != NULL)
 			*ret_work = NULL;
 	}
-
-	return NULL;
+out:
+	work_exit(&key);
+	return atom;
 }
 
 static struct kwork_work *find_work_by_id(struct rb_root_cached *root,
@@ -1002,13 +1055,16 @@ static void irq_work_init(struct perf_kwork *kwork,
 		work->name = NULL;
 	} else {
 		work->id = perf_sample__intval(sample, "irq");
-		work->name = perf_sample__strval(sample, "name");
+		work->name = strdup(perf_sample__strval(sample, "name") ?: "<unknown>");
 	}
 }
 
 static void irq_work_name(struct kwork_work *work, char *buf, int len)
 {
-	snprintf(buf, len, "%s:%" PRIu64 "", work->name, work->id);
+	if (work->name != NULL)
+		snprintf(buf, len, "%s:%" PRIu64 "", work->name, work->id);
+	else
+		snprintf(buf, len, "%" PRIu64 "", work->id);
 }
 
 static struct kwork_class kwork_irq = {
@@ -1135,7 +1191,10 @@ static void softirq_work_init(struct perf_kwork *kwork,
 
 static void softirq_work_name(struct kwork_work *work, char *buf, int len)
 {
-	snprintf(buf, len, "(s)%s:%" PRIu64 "", work->name, work->id);
+	if (work->name != NULL)
+		snprintf(buf, len, "(s)%s:%" PRIu64 "", work->name, work->id);
+	else
+		snprintf(buf, len, "(s)%" PRIu64 "", work->id);
 }
 
 static struct kwork_class kwork_softirq = {
@@ -1220,8 +1279,14 @@ static void workqueue_work_init(struct perf_kwork *kwork __maybe_unused,
 	work->class = class;
 	work->cpu = sample->cpu;
 	work->id = perf_sample__intval(sample, "work");
-	work->name = function_addr == 0 ? NULL :
-		machine__resolve_kernel_addr(machine, &function_addr, &modp);
+	work->name = NULL;
+
+	if (function_addr != 0) {
+		const char *name = machine__resolve_kernel_addr(machine, &function_addr, &modp);
+
+		if (name)
+			work->name = strdup(name);
+	}
 }
 
 static void workqueue_work_name(struct kwork_work *work, char *buf, int len)
@@ -1284,16 +1349,16 @@ static void sched_work_init(struct perf_kwork *kwork __maybe_unused,
 
 	if (src_type == KWORK_TRACE_EXIT) {
 		work->id = perf_sample__intval(sample, "prev_pid");
-		work->name = strdup(perf_sample__strval(sample, "prev_comm"));
+		work->name = strdup(perf_sample__strval(sample, "prev_comm") ?: "<unknown>");
 	} else if (src_type == KWORK_TRACE_ENTRY) {
 		work->id = perf_sample__intval(sample, "next_pid");
-		work->name = strdup(perf_sample__strval(sample, "next_comm"));
+		work->name = strdup(perf_sample__strval(sample, "next_comm") ?: "<unknown>");
 	}
 }
 
 static void sched_work_name(struct kwork_work *work, char *buf, int len)
 {
-	snprintf(buf, len, "%s", work->name);
+	snprintf(buf, len, "%s", work->name ?: "");
 }
 
 static struct kwork_class kwork_sched = {
@@ -2100,8 +2165,10 @@ static void top_merge_tasks(struct perf_kwork *kwork)
 		rb_erase_cached(node, &class->work_root);
 		data = rb_entry(node, struct kwork_work, node);
 
-		if (!profile_name_match(kwork, data))
+		if (!profile_name_match(kwork, data)) {
+			work_delete(data);
 			continue;
+		}
 
 		cpu = data->cpu;
 		merged_work = find_work_by_id(&merged_root, data->id,
@@ -2109,11 +2176,17 @@ static void top_merge_tasks(struct perf_kwork *kwork)
 		if (!merged_work) {
 			work_insert(&merged_root, data, &kwork->cmp_id);
 		} else {
+			if (merged_work->name == NULL && data->name != NULL)
+				merged_work->name = strdup(data->name);
+
 			merged_work->total_runtime += data->total_runtime;
 			merged_work->cpu_usage += data->cpu_usage;
 		}
 
 		top_calc_load_runtime(kwork, data);
+
+		if (merged_work)
+			work_delete(data);
 	}
 
 	work_sort(kwork, class, &merged_root);
@@ -2523,6 +2596,8 @@ int cmd_kwork(int argc, const char **argv)
 	} else
 		usage_with_options(kwork_usage, kwork_options);
 
+	perf_kwork__exit(&kwork);
+
 	/* free usage string allocated by parse_options_subcommand */
 	free((void *)kwork_usage[0]);
 
diff --git a/tools/perf/util/bpf_kwork.c b/tools/perf/util/bpf_kwork.c
index d3a2e548f2b6..2248f462a847 100644
--- a/tools/perf/util/bpf_kwork.c
+++ b/tools/perf/util/bpf_kwork.c
@@ -273,6 +273,7 @@ static int add_work(struct perf_kwork *kwork,
 		.cpu = key->cpu,
 	};
 	enum kwork_class_type type = key->type;
+	int ret = 0;
 
 	if (!valid_kwork_class_type(type)) {
 		pr_debug("Invalid class type %d to add work\n", type);
@@ -287,8 +288,10 @@ static int add_work(struct perf_kwork *kwork,
 		return -1;
 
 	work = kwork->add_work(kwork, tmp.class, &tmp);
-	if (work == NULL)
-		return -1;
+	if (work == NULL) {
+		ret = -1;
+		goto out;
+	}
 
 	if (kwork->report == KWORK_REPORT_RUNTIME) {
 		work->nr_atoms = data->nr;
@@ -304,13 +307,16 @@ static int add_work(struct perf_kwork *kwork,
 		work->max_latency_end = data->max_time_end;
 	} else {
 		pr_debug("Invalid bpf report type %d\n", kwork->report);
-		return -1;
+		ret = -1;
+		goto out;
 	}
 
 	kwork->timestart = (u64)ts_start.tv_sec * NSEC_PER_SEC + ts_start.tv_nsec;
 	kwork->timeend = (u64)ts_end.tv_sec * NSEC_PER_SEC + ts_end.tv_nsec;
 
-	return 0;
+out:
+	work_exit(&tmp);
+	return ret;
 }
 
 int perf_kwork__report_read_bpf(struct perf_kwork *kwork)
diff --git a/tools/perf/util/kwork.h b/tools/perf/util/kwork.h
index abf637d44794..c96f388b3159 100644
--- a/tools/perf/util/kwork.h
+++ b/tools/perf/util/kwork.h
@@ -164,6 +164,8 @@ struct kwork_class {
 			  char *buf, int len);
 };
 
+void work_exit(struct kwork_work *work);
+
 struct trace_kwork_handler {
 	int (*raise_event)(struct perf_kwork *kwork,
 			   struct kwork_class *class,
-- 
2.53.0.1213.gd9a14994de-goog

