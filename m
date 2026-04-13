Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E7B2D8DB5
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043427; cv=none; b=GKFKWlus401PD64dxkzpqE1gvg9jgzJ1K74XgB8wvbte68IoaQUdxUy+zqs1jl49LL64zB0B2fee+ENcWZrELpUGtzJdBe1IaAtsjWngkrr2zPOz11rdMQM+qEqm/eFeVO8zKEJ9/kIBergdXSfR5xWCy7F6pyplfe0l7USa06w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043427; c=relaxed/simple;
	bh=o+libGjGGnh0PZHJw+kVOgmbQh9zxpxsvn3EuaHS1hA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n1aEsJhlrRJvdtnUQtmMMnNAVJjspc4rGXyOHZGJAFD6DWuqfeXpYwDdcBYESGLuLP0FDKv+kGMGeNAFpafdSJdkJkYMjR3J//7mjWCBqomXrC32yYyw76k6V+4yI39wOpl7Ee572nTuyWTdvGlEQrovB1ElHjV/ym9r/vzoQFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IuRxP8da; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IuRxP8da"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-127133794b6so16137444c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043425; x=1776648225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qTdwOD5MvJj+i4G9bVPQNL0PRv4ibjmw6Xi5PZQFnqk=;
        b=IuRxP8dalch4/pZ6BHklpiP8VHEVv44H/ZvWIKA4eMuqMJ8wJ53a9lgixqJgF1J/Ps
         kyCd0l8S/UIYnalnEJaEgnkY/v1J5clqQd2ompaA9ULYBDqx84jxtLb8pRLkfuxyFFSD
         PzIrsGmRcC0onpfSU4vdOjmDH6+XebZuHsan8gGNR1sG4hwIAjbHa4UdrjyaDKXYfVEZ
         TzLZh+vOUHIsQ6QCnZKuvF3MYJ+ohASKpWJ/H2aXcBkY7HOfSiIOxKig8vN4iJ1I7EgV
         klCaiJ5fi89EyXqoPfbdATqymS7MkZcOKQ5y0sLms/NLAfHRdogPictn6Kfi4fdY2kOx
         fmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043425; x=1776648225;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qTdwOD5MvJj+i4G9bVPQNL0PRv4ibjmw6Xi5PZQFnqk=;
        b=VCTWlubvnMVpXEls0dFXX5Xlk5UUDVHIHMgOblZkFgbl5lp2s6XO4wN4IbYumpW2zh
         SRPCxuZjWUP3G1tBEKOPIgOfD6wha6mQFSQdnDCS5lvlwpod+tG6mcrUFhdZIxcnDRGu
         OIw60G8pEhZ3R+J2n05G6ckSRx0gzPmUUNMwoNSOomJWhohARRfTcs7f8snaX72MY0Mf
         wMXhF8Iig+YxSvrd49/d4VPXSUcnsntNrydFMUh9XLUroRirG7X0ntf73UKIPEvtKPM/
         6SIMsFFRf5mlvwqMTuDEPhKuPVV1uzhzkQVaHFRHaZ0KKFlfUDW0P7jELppAM1oG2CjN
         IHZw==
X-Forwarded-Encrypted: i=1; AJvYcCWjeDXuzdSkpTArrXp8iZcu++9rIZ90uOdi3Cei+wDoN+99R/uc84b2kU/94uQD+kvtZ+/mjt0itj2zhTQorovT@vger.kernel.org
X-Gm-Message-State: AOJu0YzZXInitwEtgukwj66h48LCom3hs0Sy4ksnRmuFnSVySmZLg/EV
	un5Bb3aSQEA19QJJYkUr45VGg4VT4lhwhCK/SdK86VfM6EzE8RguHSxMEz552cQkphqBt8YouwO
	iUd8g8Q614w==
X-Received: from dybb21.prod.google.com ([2002:a05:693c:6095:b0:2d9:61d4:4d0e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6726:b0:119:e56c:18ae
 with SMTP id a92af1059eb24-12c34ede8e2mr6175720c88.22.1776043424807; Sun, 12
 Apr 2026 18:23:44 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:22:27 -0700
In-Reply-To: <20260413012227.1089445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com> <20260413012227.1089445-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-34-irogers@google.com>
Subject: [PATCH v11 33/33] perf kwork: Fix memory management of kwork_work
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
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

