Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96383998BA
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348290; cv=none; b=LUouZnSPh37V/FHDDQaKhD7M7MrTyzAbYSN4pAV5ttTUQKkZ9DgRhhu180yBynf4//xYxj0U7bPktR8YNOQj99ItFLr/14RrZmdelMdcBmvDEzL4xMwfPpyXZ78jFswzky0GsVzxcv1MWgvFYxW6Wh3t0bw0T4/ybjEKdUOWMIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348290; c=relaxed/simple;
	bh=M5bXVLuc0x8lBuTutbBwd25MT/WroNw+AYKDP4kaVxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kjsPxV5Yiy5jVo9pQGOKkmpp98tY2ed+TpFPQWsi3+67S4M4Va795b7LlOnPiKh8COSCYVTMOjF+WO9N3zM8v8UcAkOxNeqj4QAKawPjs8LaWl5HYexylsalSzO3dRQMpum8BT2YH5X9JCdqam4xa6/Zmejc0hijSHkUD9AQPgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V8Rg0hgh; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V8Rg0hgh"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so9870039eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 00:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779348285; x=1779953085; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6m9EXKwSTsrrPfp/aS5MADZfGlUtrbkMt9KfRNRiRsA=;
        b=V8Rg0hghIZ6mhUghk8l9+r8krlZaRgOTNQlmKN3Df2GzsNnOfihUmLh375mV6jMtuC
         hjbaz0dLYvG7HiZdoFpL+JfSR3BOhWoeAXfp+GQvvDDA4qGv1qlLPBS49d0VQQ8YcmtL
         Hdm78UaehtwZaEbRLe+Jr/luGCEAzXHYllrlsZ+KSAucyEuhwv/WqpaFkp5QL1t3yw5B
         Aax76elvgwezVpmXf7ysEkeUR/86pyegCcbPKLNTs74aSYWHrglvhNEPQkbbnAqp3NXL
         khLazuMJcJNuL7pQh7YrdQWPLStbQfrH3ApoSlQf/y61dEBCieI1tNqEvLMC/PA0Va3f
         spcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779348285; x=1779953085;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6m9EXKwSTsrrPfp/aS5MADZfGlUtrbkMt9KfRNRiRsA=;
        b=HzY9a5r3SswMyN3x1EXLBaNoN/TtD93nu2/NjkFpIjdgqCJJcsPTz35DA356kcspfd
         om5lkGVefjMLb0LOLmprfEbI6nb6gq0JIXbt04YnNK8AM9iT+VFfBF0k1G1hq6AdAadj
         MmEiRGGYcTlTS7pIPtkvs9bXaOk88T1COreNqJNh+oKyiZAUYBCSy+OshZeOxjXBdWvb
         3DYTj3tphTrGJtzpzOnd1hLqzBwPY81Oep1f1wvzrUvlasGOase8SAHEecBvhHIwwiZo
         spxEF/gFg1M4IPbIvU0qjaKCBaS0h+UEZonAfrqYu8h6qlDztTWHC8bYNjrWZGMyz/zr
         MEwg==
X-Forwarded-Encrypted: i=1; AFNElJ86wQ61hY51l4P3pMWbqOj3eIVNyY9H7gMowMTwAQbKWb4vb3no+HoeYnyG/u9qUCYhYDKCCTeGqQlq0GGCsREo@vger.kernel.org
X-Gm-Message-State: AOJu0YwY/Lx56+06sr+WYhCjTNBPXDfH+XDxo8D7UpWGF8HvowvzyeQZ
	vH3bWOCSrWqa0taQa+x7hMAYgTWEDyc6kndHqn5ulmD+T7F52c1bIhumfEeVjP1MKFCWX2CudM5
	6jJKXEtKYlA==
X-Received: from dybnl19.prod.google.com ([2002:a05:7300:cf93:b0:2f9:af7:504a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e82b:b0:2dd:c066:c02
 with SMTP id 5a478bee46e88-3042f94e725mr1030027eec.22.1779348285043; Thu, 21
 May 2026 00:24:45 -0700 (PDT)
Date: Thu, 21 May 2026 00:24:29 -0700
In-Reply-To: <20260521072429.1283423-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521072429.1283423-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260521072429.1283423-4-irogers@google.com>
Subject: [PATCH v1 3/3] perf kwork: Fix memory management of kwork_work
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
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
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-kwork.c  | 121 ++++++++++++++++++++++++++++--------
 tools/perf/util/bpf_kwork.c |  14 +++--
 tools/perf/util/kwork.h     |   9 +++
 3 files changed, 115 insertions(+), 29 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index a4604e152002..f793ea578515 100644
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
@@ -371,11 +371,54 @@ static struct kwork_work *work_new(struct kwork_work *key)
 
 	work->id = key->id;
 	work->cpu = key->cpu;
-	work->name = key->name;
+	work->name = key->name ? strdup(key->name) : NULL;
 	work->class = key->class;
 	return work;
 }
 
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
@@ -453,25 +496,29 @@ static int work_push_atom(struct perf_kwork *kwork,
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
@@ -498,8 +545,9 @@ static int work_push_atom(struct perf_kwork *kwork,
 	}
 
 	list_add_tail(&atom->list, &work->atom_list[src_type]);
-
-	return 0;
+out:
+	work_exit(&key);
+	return ret;
 }
 
 static struct kwork_atom *work_pop_atom(struct perf_kwork *kwork,
@@ -510,7 +558,7 @@ static struct kwork_atom *work_pop_atom(struct perf_kwork *kwork,
 					struct machine *machine,
 					struct kwork_work **ret_work)
 {
-	struct kwork_atom *atom, *src_atom;
+	struct kwork_atom *atom = NULL, *src_atom;
 	struct kwork_work *work, key;
 
 	BUG_ON(class->work_init == NULL);
@@ -521,15 +569,15 @@ static struct kwork_atom *work_pop_atom(struct perf_kwork *kwork,
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
@@ -538,8 +586,9 @@ static struct kwork_atom *work_pop_atom(struct perf_kwork *kwork,
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
@@ -1002,13 +1051,16 @@ static void irq_work_init(struct perf_kwork *kwork,
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
@@ -1135,7 +1187,10 @@ static void softirq_work_init(struct perf_kwork *kwork,
 
 static void softirq_work_name(struct kwork_work *work, char *buf, int len)
 {
-	snprintf(buf, len, "(s)%s:%" PRIu64 "", work->name, work->id);
+	if (work->name != NULL)
+		snprintf(buf, len, "(s)%s:%" PRIu64 "", work->name, work->id);
+	else
+		snprintf(buf, len, "(s)%" PRIu64 "", work->id);
 }
 
 static struct kwork_class kwork_softirq = {
@@ -1220,8 +1275,14 @@ static void workqueue_work_init(struct perf_kwork *kwork __maybe_unused,
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
@@ -1284,16 +1345,16 @@ static void sched_work_init(struct perf_kwork *kwork __maybe_unused,
 
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
@@ -2100,8 +2161,10 @@ static void top_merge_tasks(struct perf_kwork *kwork)
 		rb_erase_cached(node, &class->work_root);
 		data = rb_entry(node, struct kwork_work, node);
 
-		if (!profile_name_match(kwork, data))
+		if (!profile_name_match(kwork, data)) {
+			work_delete(data);
 			continue;
+		}
 
 		cpu = data->cpu;
 		merged_work = find_work_by_id(&merged_root, data->id,
@@ -2109,11 +2172,17 @@ static void top_merge_tasks(struct perf_kwork *kwork)
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
@@ -2523,6 +2592,8 @@ int cmd_kwork(int argc, const char **argv)
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
index abf637d44794..81d39a7f78c8 100644
--- a/tools/perf/util/kwork.h
+++ b/tools/perf/util/kwork.h
@@ -5,6 +5,7 @@
 #include "util/tool.h"
 #include "util/time-utils.h"
 
+#include <stdlib.h>
 #include <linux/bitmap.h>
 #include <linux/list.h>
 #include <linux/rbtree.h>
@@ -164,6 +165,14 @@ struct kwork_class {
 			  char *buf, int len);
 };
 
+static inline void work_exit(struct kwork_work *work)
+{
+	if (work) {
+		free(work->name);
+		work->name = NULL;
+	}
+}
+
 struct trace_kwork_handler {
 	int (*raise_event)(struct perf_kwork *kwork,
 			   struct kwork_class *class,
-- 
2.54.0.746.g67dd491aae-goog

