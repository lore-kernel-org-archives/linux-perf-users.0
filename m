Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECB0346E7E
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 06:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775890713; cv=none; b=ouerJMfPPBsxRY9TfpaZk1NeLbjnl3xssmOGUKRs2ZVxLBH6jaXisGFghCM7xMcud/Z8Bmo/IIr4KUJnYTeVjgH+Rkw6J03ZFw+Pxc2bOa2yBfaDk27OPRlRVtIKeXovhHfQ/tEWsoNU/EY7PhlKivs3P/jIDjcH7vHntIOdjLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775890713; c=relaxed/simple;
	bh=zl2iXoR7jJW5onRIFm7AdF6HOFWmVFU1urAfIdik9Wg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RT56gs/Mldn+tletFC/uiqxjeOD2Wy2WMMbW+ENmYuJMotD4W7igyjf6mAVqmQaULCwccWF65WcJZVJWymKf2V+FKoHteCJsx43Agvji92n5fT4p1hTympIIDCPHAo84r6wUs54HTdhtnk8bsKGBycd9CCi1bWbs9KTWcpNDER8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fxoPrkL6; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fxoPrkL6"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d51aed14bcso6727674eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 23:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775890711; x=1776495511; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jkI1Zon9nkuDFy5m2Os8lphvXrNBnGz9r7HtqH2SSak=;
        b=fxoPrkL6u4q9OH9Ny/vXhDUx11I+8Eua0BOATmdaOOgjgj/szOoLtxT5EzF+dfDpBl
         M8BkhjJTCGP6U6K1fBQXblKXMR+G0yoD5WvokVT0m1j+P0hk+VPO8Y1D92l8WJfLMLm0
         JiSWID6Cp7SgbHU14HbV3KQUMuUTxEepn0RcnycIpd1awWJICp7nqKieNMCpvYJcDfNw
         OzzUBPH5EDrTit6fyVrC1BGWS7O+svTI4tuMpw1BYkMjsWXmI7Le8ys6bar/ClYcJgJF
         jbKxeaAj17xwfY22sW9Y2ShPBEtSfaPAOYPUl02qqUJVxBI3sHcYJ5LKiGDK/FHjbN05
         I5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775890711; x=1776495511;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jkI1Zon9nkuDFy5m2Os8lphvXrNBnGz9r7HtqH2SSak=;
        b=CXgsg+gcPCsoWwOYir1pJ3JJaH9aTxx7T8iYOrA1LqRlCzDDY1m4Zt2sIUtbeJWlJq
         y+2AcecmCP2F7Duijz7JxNvtwO4OK/b6WGMXNx7qfFftQ9Rt1A6Hy6H0QWrX+sv5d9s+
         Zv3TSQL4X/FqK8V7EPnJsG7JyCWqZaMsPlJ4XM2d2rU4tQb3Bhm1Jbu+EbmobVUDf2dh
         uHdx3ZpZFl+hrZiMBerkReieP1r5IB1qQ6Xc6+s05HxrTXoTwwMZN+Fra7R1vAavjYix
         wq3bA/sn33op09MfWUrTrweIp4lkx+0rmPcbsAyMT+Zh2xEdXkF1HFEjyapoltNXn3jL
         VNfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjl0fmzBSQcxs8jzhozxY0HFKmVxMHFCbR17rnrXJNO+iJ5Akb2z2n/CoWV764YDB6RnzvhijHeR7xau65xaJh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4dpGHzW1HVXBDGf0WAlqlesUUdVxPSEYsLnTTvmhsu6alsNrW
	PlDUHmbykcVTrIw09j7gonDVgYGzdIonoPtypO/+J9jCfmfPFArsrz556I/qMZ40033mET6EIf0
	bLLyS9PSWSQ==
X-Received: from dycmg22.prod.google.com ([2002:a05:693c:2516:b0:2c1:70ef:f2dc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7495:b0:2c6:7f49:a87a
 with SMTP id 5a478bee46e88-2d5874a8a0bmr3382276eec.9.1775890710907; Fri, 10
 Apr 2026 23:58:30 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:57:18 -0700
In-Reply-To: <20260411065718.372240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408072601.210837-1-irogers@google.com> <20260411065718.372240-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411065718.372240-30-irogers@google.com>
Subject: [PATCH v8 29/29] perf kwork: Fix memory management of kwork_work
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
 tools/perf/builtin-kwork.c | 125 +++++++++++++++++++++++++++++--------
 1 file changed, 100 insertions(+), 25 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 8430a79a02ba..1b8d4e216ae7 100644
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
 
+static void work_exit(struct kwork_work *work)
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
-		work->name = perf_sample__strval(sample, "prev_comm");
+		work->name = strdup(perf_sample__strval(sample, "prev_comm") ?: "<unknown>");
 	} else if (src_type == KWORK_TRACE_ENTRY) {
 		work->id = perf_sample__intval(sample, "next_pid");
-		work->name = perf_sample__strval(sample, "next_comm");
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
@@ -2520,6 +2593,8 @@ int cmd_kwork(int argc, const char **argv)
 	} else
 		usage_with_options(kwork_usage, kwork_options);
 
+	perf_kwork__exit(&kwork);
+
 	/* free usage string allocated by parse_options_subcommand */
 	free((void *)kwork_usage[0]);
 
-- 
2.53.0.1213.gd9a14994de-goog

