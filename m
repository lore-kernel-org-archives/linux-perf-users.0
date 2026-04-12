Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4A219ADA4
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775959729; cv=none; b=EvhWYWATgnjWjZYggTNx5VpT9/Rxy37hYZ71GfzGfVvUZWkxrVaTw1zBtS0EYWG+iHFgi/ZQlot1LU7SGmle3m9UsDQeSo29wF8WfCaL7kavyhJsRSkFigb6npB9bR/dKlIxdCJ/LyfKbL9PihLPMXot9+GP7ItNkOhglreqzws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775959729; c=relaxed/simple;
	bh=D2LmpeIXXNFxNYtdbJKZhFsf8yMiyUbtQqFGDqqj5Dw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VI7zeGH1eJpvlVqINI7OagyaJnaAvuOFUUIN0xTtpzs0XA68Nac6JCrM6XNY1yhYHeV31+uRYrY4gtDnNZz34vh9MjtLavAbRoo9khKUORzxy0DLY3CAFnchmz/WcZASlMlnVTqF4nPpB14fvils02oKzQ0goJ0bE9QjinkNnQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DP5ZE1t8; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DP5ZE1t8"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bda35eab74so2803334eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775959726; x=1776564526; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dECIl3pcWvkbowXs982Da0zWX/YfqGxLaug4qN5VbeM=;
        b=DP5ZE1t8bkcLOlJvZyTN41H9pZYZtEksT6QnVrDmB0Mdeu4kU0cC6L2JhcEZAYvt2O
         GJdrMRsmwDEzUCEWZf6hh4G0abHjtbqdKoLGHeG65DxvwhyfcgoWnutjmQ1a8B+ghCHl
         LcohzZjOIuFCiBz2D1h2ZaLK0IfdPz1pRicgRaYKtwNfQFRW2h4IcYswrYTTKQJJX9UC
         YWfXxm7MEzIfoTTQ/KB8iV+V2Ov0UQxZQz2mP6+PLeoMrUTvxbpHE1XBOVbSF3FX0p/K
         ckTkeaRayvD6G1L0a2VH2N6+G8VSSbqSXP+TN59sVCFrhviiwITvG0iBYJ0HEh9H98Ow
         o2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775959726; x=1776564526;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dECIl3pcWvkbowXs982Da0zWX/YfqGxLaug4qN5VbeM=;
        b=HnUw7LFXQu0tS0zj5bVSHV0+a/bfUIOhdmMkGGeJETlt6s9+dTbUK6fwlb9hDpGaAh
         RYOIdSX26GwG/+CQcYRC9nHpVjUbUbUpWXTj3aQJyFDxFc3DQAQwuvLFz88OrHW8bVJo
         8WwuXiBlJgRFK16ZwWmVsO3QHFwVR6n2dcTvKQy/ah2gMWiYXh3/YNWB0N+/z538jxLw
         Iij57YKpSxk+b0aNSFNeD9/oMihUkmB4qkar1/kTUI65votGh5LmsXDdHBT7nlaYZ89W
         wW2XCSkOzIbH+n8s6VOhJxVupKzTWjV+AR8DTK4RJcwum/JmWNlqoOYUyPyWZqXMT33I
         TWLA==
X-Forwarded-Encrypted: i=1; AFNElJ8YkO6TFFRQP8cJkpEdhIAWHxZQ9hDe/5xLcgjzTPqN+msRgtZwXSFgKsepqBCK1GQDlfUCmtKyQUpqPKi9644v@vger.kernel.org
X-Gm-Message-State: AOJu0YwjCDx0WeLn3Sc0Y81JQqEodjl62ulY0SucAWOVy2PxHaOosoCi
	Pe13g+Y/mntFlvarD3Z4kX+CkVhYoI5hgVIdrOqf28XXUYyqPP3ev8QCDg6UFfvKbYcE60yh+Fj
	CZg9pmS2vTw==
X-Received: from dybmi42.prod.google.com ([2002:a05:7301:faa:b0:2c5:f8b4:33a4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:3104:b0:2cf:8de3:d48d
 with SMTP id 5a478bee46e88-2d40ddfc4dfmr6655270eec.2.1775959725694; Sat, 11
 Apr 2026 19:08:45 -0700 (PDT)
Date: Sat, 11 Apr 2026 19:08:07 -0700
In-Reply-To: <20260412020833.641177-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260412020833.641177-5-irogers@google.com>
Subject: [PATCH v10 04/29] perf evsel: Refactor evsel tracepoint sample
 accessors perf_sample
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

The evsel argument to evsel__intval, evsel__rawptr, and similar
functions, is unnecessary as it can be read from the sample. Remove
the evsel and rename the function to match that the data is coming
from the sample.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c                   |  2 +-
 tools/perf/builtin-kmem.c                     | 34 +++----
 tools/perf/builtin-kvm.c                      |  2 +-
 tools/perf/builtin-kwork.c                    | 29 +++---
 tools/perf/builtin-lock.c                     | 32 +++----
 tools/perf/builtin-sched.c                    | 92 +++++++++----------
 tools/perf/builtin-timechart.c                | 88 +++++++++---------
 tools/perf/builtin-trace.c                    | 12 +--
 tools/perf/tests/openat-syscall-tp-fields.c   |  2 +-
 tools/perf/tests/switch-tracking.c            |  4 +-
 tools/perf/util/evsel.c                       | 22 ++---
 tools/perf/util/evsel.h                       | 12 +--
 tools/perf/util/intel-pt.c                    |  2 +-
 .../perf/util/kvm-stat-arch/kvm-stat-arm64.c  |  6 +-
 .../util/kvm-stat-arch/kvm-stat-loongarch.c   |  2 +-
 .../util/kvm-stat-arch/kvm-stat-powerpc.c     |  2 +-
 .../perf/util/kvm-stat-arch/kvm-stat-riscv.c  |  3 +-
 tools/perf/util/kvm-stat-arch/kvm-stat-s390.c |  8 +-
 tools/perf/util/kvm-stat-arch/kvm-stat-x86.c  | 16 ++--
 tools/perf/util/kvm-stat.c                    |  2 +-
 20 files changed, 183 insertions(+), 189 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 6ba489452777..3d3f3272918c 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -1081,7 +1081,7 @@ static int perf_inject__sched_stat(const struct perf_tool *tool,
 	union perf_event *event_sw;
 	struct perf_sample sample_sw;
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
-	u32 pid = evsel__intval(evsel, sample, "pid");
+	u32 pid = perf_sample__intval(sample, "pid");
 	int ret;
 
 	list_for_each_entry(ent, &inject->samples, node) {
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 45b383fa9ce9..d7233a8b43be 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -173,10 +173,10 @@ static int insert_caller_stat(unsigned long call_site,
 
 static int evsel__process_alloc_event(struct evsel *evsel, struct perf_sample *sample)
 {
-	unsigned long ptr = evsel__intval(evsel, sample, "ptr"),
-		      call_site = evsel__intval(evsel, sample, "call_site");
-	int bytes_req = evsel__intval(evsel, sample, "bytes_req"),
-	    bytes_alloc = evsel__intval(evsel, sample, "bytes_alloc");
+	unsigned long ptr = perf_sample__intval(sample, "ptr"),
+		      call_site = perf_sample__intval(sample, "call_site");
+	int bytes_req = perf_sample__intval(sample, "bytes_req"),
+	    bytes_alloc = perf_sample__intval(sample, "bytes_alloc");
 
 	if (insert_alloc_stat(call_site, ptr, bytes_req, bytes_alloc, sample->cpu) ||
 	    insert_caller_stat(call_site, bytes_req, bytes_alloc))
@@ -202,7 +202,7 @@ static int evsel__process_alloc_event(struct evsel *evsel, struct perf_sample *s
 		int node1, node2;
 
 		node1 = cpu__get_node((struct perf_cpu){.cpu = sample->cpu});
-		node2 = evsel__intval(evsel, sample, "node");
+		node2 = perf_sample__intval(sample, "node");
 
 		/*
 		 * If the field "node" is NUMA_NO_NODE (-1), we don't take it
@@ -243,9 +243,9 @@ static struct alloc_stat *search_alloc_stat(unsigned long ptr,
 	return NULL;
 }
 
-static int evsel__process_free_event(struct evsel *evsel, struct perf_sample *sample)
+static int evsel__process_free_event(struct evsel *evsel __maybe_unused, struct perf_sample *sample)
 {
-	unsigned long ptr = evsel__intval(evsel, sample, "ptr");
+	unsigned long ptr = perf_sample__intval(sample, "ptr");
 	struct alloc_stat *s_alloc, *s_caller;
 
 	s_alloc = search_alloc_stat(ptr, 0, &root_alloc_stat, ptr_cmp);
@@ -808,10 +808,9 @@ static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
 static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_sample *sample)
 {
 	u64 page;
-	unsigned int order = evsel__intval(evsel, sample, "order");
-	unsigned int gfp_flags = evsel__intval(evsel, sample, "gfp_flags");
-	unsigned int migrate_type = evsel__intval(evsel, sample,
-						       "migratetype");
+	unsigned int order = perf_sample__intval(sample, "order");
+	unsigned int gfp_flags = perf_sample__intval(sample, "gfp_flags");
+	unsigned int migrate_type = perf_sample__intval(sample, "migratetype");
 	u64 bytes = kmem_page_size << order;
 	u64 callsite;
 	struct page_stat *pstat;
@@ -822,9 +821,9 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
 	};
 
 	if (use_pfn)
-		page = evsel__intval(evsel, sample, "pfn");
+		page = perf_sample__intval(sample, "pfn");
 	else
-		page = evsel__intval(evsel, sample, "page");
+		page = perf_sample__intval(sample, "page");
 
 	nr_page_allocs++;
 	total_page_alloc_bytes += bytes;
@@ -877,10 +876,11 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
 	return 0;
 }
 
-static int evsel__process_page_free_event(struct evsel *evsel, struct perf_sample *sample)
+static int evsel__process_page_free_event(struct evsel *evsel __maybe_unused,
+					  struct perf_sample *sample)
 {
 	u64 page;
-	unsigned int order = evsel__intval(evsel, sample, "order");
+	unsigned int order = perf_sample__intval(sample, "order");
 	u64 bytes = kmem_page_size << order;
 	struct page_stat *pstat;
 	struct page_stat this = {
@@ -888,9 +888,9 @@ static int evsel__process_page_free_event(struct evsel *evsel, struct perf_sampl
 	};
 
 	if (use_pfn)
-		page = evsel__intval(evsel, sample, "pfn");
+		page = perf_sample__intval(sample, "pfn");
 	else
-		page = evsel__intval(evsel, sample, "page");
+		page = perf_sample__intval(sample, "page");
 
 	nr_page_frees++;
 	total_page_free_bytes += bytes;
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index d9b9792894a8..dd2ed21596aa 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -930,7 +930,7 @@ struct vcpu_event_record *per_vcpu_record(struct thread *thread,
 			return NULL;
 		}
 
-		vcpu_record->vcpu_id = evsel__intval(sample->evsel, sample, vcpu_id_str(e_machine));
+		vcpu_record->vcpu_id = perf_sample__intval(sample, vcpu_id_str(e_machine));
 		thread__set_priv(thread, vcpu_record);
 	}
 
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index d4bb19ed91b5..8ba5ea201bf9 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -1006,7 +1006,7 @@ static void irq_work_init(struct perf_kwork *kwork,
 			  struct kwork_class *class,
 			  struct kwork_work *work,
 			  enum kwork_trace_type src_type __maybe_unused,
-			  struct evsel *evsel,
+			  struct evsel *evsel __maybe_unused,
 			  struct perf_sample *sample,
 			  struct machine *machine __maybe_unused)
 {
@@ -1014,11 +1014,11 @@ static void irq_work_init(struct perf_kwork *kwork,
 	work->cpu = sample->cpu;
 
 	if (kwork->report == KWORK_REPORT_TOP) {
-		work->id = evsel__intval_common(evsel, sample, "common_pid");
+		work->id = perf_sample__intval_common(sample, "common_pid");
 		work->name = NULL;
 	} else {
-		work->id = evsel__intval(evsel, sample, "irq");
-		work->name = evsel__strval(evsel, sample, "name");
+		work->id = perf_sample__intval(sample, "irq");
+		work->name = perf_sample__strval(sample, "name");
 	}
 }
 
@@ -1144,10 +1144,10 @@ static void softirq_work_init(struct perf_kwork *kwork,
 	work->cpu = sample->cpu;
 
 	if (kwork->report == KWORK_REPORT_TOP) {
-		work->id = evsel__intval_common(evsel, sample, "common_pid");
+		work->id = perf_sample__intval_common(sample, "common_pid");
 		work->name = NULL;
 	} else {
-		num = evsel__intval(evsel, sample, "vec");
+		num = perf_sample__intval(sample, "vec");
 		work->id = num;
 		work->name = evsel__softirq_name(evsel, num);
 	}
@@ -1234,17 +1234,16 @@ static void workqueue_work_init(struct perf_kwork *kwork __maybe_unused,
 				struct kwork_class *class,
 				struct kwork_work *work,
 				enum kwork_trace_type src_type __maybe_unused,
-				struct evsel *evsel,
+				struct evsel *evsel __maybe_unused,
 				struct perf_sample *sample,
 				struct machine *machine)
 {
 	char *modp = NULL;
-	unsigned long long function_addr = evsel__intval(evsel,
-							 sample, "function");
+	unsigned long long function_addr = perf_sample__intval(sample, "function");
 
 	work->class = class;
 	work->cpu = sample->cpu;
-	work->id = evsel__intval(evsel, sample, "work");
+	work->id = perf_sample__intval(sample, "work");
 	work->name = function_addr == 0 ? NULL :
 		machine__resolve_kernel_addr(machine, &function_addr, &modp);
 }
@@ -1302,7 +1301,7 @@ static void sched_work_init(struct perf_kwork *kwork __maybe_unused,
 			    struct kwork_class *class,
 			    struct kwork_work *work,
 			    enum kwork_trace_type src_type,
-			    struct evsel *evsel,
+			    struct evsel *evsel __maybe_unused,
 			    struct perf_sample *sample,
 			    struct machine *machine __maybe_unused)
 {
@@ -1310,11 +1309,11 @@ static void sched_work_init(struct perf_kwork *kwork __maybe_unused,
 	work->cpu = sample->cpu;
 
 	if (src_type == KWORK_TRACE_EXIT) {
-		work->id = evsel__intval(evsel, sample, "prev_pid");
-		work->name = strdup(evsel__strval(evsel, sample, "prev_comm"));
+		work->id = perf_sample__intval(sample, "prev_pid");
+		work->name = perf_sample__strval(sample, "prev_comm");
 	} else if (src_type == KWORK_TRACE_ENTRY) {
-		work->id = evsel__intval(evsel, sample, "next_pid");
-		work->name = strdup(evsel__strval(evsel, sample, "next_comm"));
+		work->id = perf_sample__intval(sample, "next_pid");
+		work->name = perf_sample__strval(sample, "next_comm");
 	}
 }
 
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 4d8ddf6391e8..cbf3a39c7837 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -563,15 +563,15 @@ static int get_key_by_aggr_mode(u64 *key, u64 addr, struct evsel *evsel,
 	return get_key_by_aggr_mode_simple(key, addr, sample->tid);
 }
 
-static int report_lock_acquire_event(struct evsel *evsel,
+static int report_lock_acquire_event(struct evsel *evsel __maybe_unused,
 				     struct perf_sample *sample)
 {
 	struct lock_stat *ls;
 	struct thread_stat *ts;
 	struct lock_seq_stat *seq;
-	const char *name = evsel__strval(evsel, sample, "name");
-	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
-	int flag = evsel__intval(evsel, sample, "flags");
+	const char *name = perf_sample__strval(sample, "name");
+	u64 addr = perf_sample__intval(sample, "lockdep_addr");
+	int flag = perf_sample__intval(sample, "flags");
 	u64 key;
 	int ret;
 
@@ -638,15 +638,15 @@ static int report_lock_acquire_event(struct evsel *evsel,
 	return 0;
 }
 
-static int report_lock_acquired_event(struct evsel *evsel,
+static int report_lock_acquired_event(struct evsel *evsel __maybe_unused,
 				      struct perf_sample *sample)
 {
 	struct lock_stat *ls;
 	struct thread_stat *ts;
 	struct lock_seq_stat *seq;
 	u64 contended_term;
-	const char *name = evsel__strval(evsel, sample, "name");
-	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
+	const char *name = perf_sample__strval(sample, "name");
+	u64 addr = perf_sample__intval(sample, "lockdep_addr");
 	u64 key;
 	int ret;
 
@@ -704,14 +704,14 @@ static int report_lock_acquired_event(struct evsel *evsel,
 	return 0;
 }
 
-static int report_lock_contended_event(struct evsel *evsel,
+static int report_lock_contended_event(struct evsel *evsel  __maybe_unused,
 				       struct perf_sample *sample)
 {
 	struct lock_stat *ls;
 	struct thread_stat *ts;
 	struct lock_seq_stat *seq;
-	const char *name = evsel__strval(evsel, sample, "name");
-	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
+	const char *name = perf_sample__strval(sample, "name");
+	u64 addr = perf_sample__intval(sample, "lockdep_addr");
 	u64 key;
 	int ret;
 
@@ -762,14 +762,14 @@ static int report_lock_contended_event(struct evsel *evsel,
 	return 0;
 }
 
-static int report_lock_release_event(struct evsel *evsel,
+static int report_lock_release_event(struct evsel *evsel  __maybe_unused,
 				     struct perf_sample *sample)
 {
 	struct lock_stat *ls;
 	struct thread_stat *ts;
 	struct lock_seq_stat *seq;
-	const char *name = evsel__strval(evsel, sample, "name");
-	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
+	const char *name = perf_sample__strval(sample, "name");
+	u64 addr = perf_sample__intval(sample, "lockdep_addr");
 	u64 key;
 	int ret;
 
@@ -969,8 +969,8 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 	struct lock_stat *ls;
 	struct thread_stat *ts;
 	struct lock_seq_stat *seq;
-	u64 addr = evsel__intval(evsel, sample, "lock_addr");
-	unsigned int flags = evsel__intval(evsel, sample, "flags");
+	u64 addr = perf_sample__intval(sample, "lock_addr");
+	unsigned int flags = perf_sample__intval(sample, "flags");
 	u64 key;
 	int i, ret;
 	static bool kmap_loaded;
@@ -1134,7 +1134,7 @@ static int report_lock_contention_end_event(struct evsel *evsel,
 	struct thread_stat *ts;
 	struct lock_seq_stat *seq;
 	u64 contended_term;
-	u64 addr = evsel__intval(evsel, sample, "lock_addr");
+	u64 addr = perf_sample__intval(sample, "lock_addr");
 	u64 key;
 	int ret;
 
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 0713e6b28f92..f15b64157589 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -829,8 +829,8 @@ replay_wakeup_event(struct perf_sched *sched,
 		    struct evsel *evsel, struct perf_sample *sample,
 		    struct machine *machine __maybe_unused)
 {
-	const char *comm = evsel__strval(evsel, sample, "comm");
-	const u32 pid	 = evsel__intval(evsel, sample, "pid");
+	const char *comm = perf_sample__strval(sample, "comm");
+	const u32 pid	 = perf_sample__intval(sample, "pid");
 	struct task_desc *waker, *wakee;
 
 	if (verbose > 0) {
@@ -851,10 +851,10 @@ static int replay_switch_event(struct perf_sched *sched,
 			       struct perf_sample *sample,
 			       struct machine *machine __maybe_unused)
 {
-	const char *prev_comm  = evsel__strval(evsel, sample, "prev_comm"),
-		   *next_comm  = evsel__strval(evsel, sample, "next_comm");
-	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
-		  next_pid = evsel__intval(evsel, sample, "next_pid");
+	const char *prev_comm  = perf_sample__strval(sample, "prev_comm"),
+		   *next_comm  = perf_sample__strval(sample, "next_comm");
+	const u32 prev_pid = perf_sample__intval(sample, "prev_pid"),
+		  next_pid = perf_sample__intval(sample, "next_pid");
 	struct task_desc *prev, __maybe_unused *next;
 	u64 timestamp0, timestamp = sample->time;
 	int cpu = sample->cpu;
@@ -1134,13 +1134,13 @@ static void free_work_atoms(struct work_atoms *atoms)
 }
 
 static int latency_switch_event(struct perf_sched *sched,
-				struct evsel *evsel,
+				struct evsel *evsel __maybe_unused,
 				struct perf_sample *sample,
 				struct machine *machine)
 {
-	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
-		  next_pid = evsel__intval(evsel, sample, "next_pid");
-	const char prev_state = evsel__taskstate(evsel, sample, "prev_state");
+	const u32 prev_pid = perf_sample__intval(sample, "prev_pid"),
+		  next_pid = perf_sample__intval(sample, "next_pid");
+	const char prev_state = perf_sample__taskstate(sample, "prev_state");
 	struct work_atoms *out_events, *in_events;
 	struct thread *sched_out, *sched_in;
 	u64 timestamp0, timestamp = sample->time;
@@ -1204,12 +1204,12 @@ static int latency_switch_event(struct perf_sched *sched,
 }
 
 static int latency_runtime_event(struct perf_sched *sched,
-				 struct evsel *evsel,
+				 struct evsel *evsel __maybe_unused,
 				 struct perf_sample *sample,
 				 struct machine *machine)
 {
-	const u32 pid	   = evsel__intval(evsel, sample, "pid");
-	const u64 runtime  = evsel__intval(evsel, sample, "runtime");
+	const u32 pid	   = perf_sample__intval(sample, "pid");
+	const u64 runtime  = perf_sample__intval(sample, "runtime");
 	struct thread *thread = machine__findnew_thread(machine, -1, pid);
 	struct work_atoms *atoms = thread_atoms_search(&sched->atom_root, thread, &sched->cmp_pid);
 	u64 timestamp = sample->time;
@@ -1239,11 +1239,11 @@ static int latency_runtime_event(struct perf_sched *sched,
 }
 
 static int latency_wakeup_event(struct perf_sched *sched,
-				struct evsel *evsel,
+				struct evsel *evsel __maybe_unused,
 				struct perf_sample *sample,
 				struct machine *machine)
 {
-	const u32 pid	  = evsel__intval(evsel, sample, "pid");
+	const u32 pid	  = perf_sample__intval(sample, "pid");
 	struct work_atoms *atoms;
 	struct work_atom *atom;
 	struct thread *wakee;
@@ -1300,11 +1300,11 @@ static int latency_wakeup_event(struct perf_sched *sched,
 }
 
 static int latency_migrate_task_event(struct perf_sched *sched,
-				      struct evsel *evsel,
+				      struct evsel *evsel __maybe_unused,
 				      struct perf_sample *sample,
 				      struct machine *machine)
 {
-	const u32 pid = evsel__intval(evsel, sample, "pid");
+	const u32 pid = perf_sample__intval(sample, "pid");
 	u64 timestamp = sample->time;
 	struct work_atoms *atoms;
 	struct work_atom *atom;
@@ -1626,11 +1626,11 @@ static void print_sched_map(struct perf_sched *sched, struct perf_cpu this_cpu,
 	}
 }
 
-static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
+static int map_switch_event(struct perf_sched *sched, struct evsel *evsel __maybe_unused,
 			    struct perf_sample *sample, struct machine *machine)
 {
-	const u32 next_pid = evsel__intval(evsel, sample, "next_pid");
-	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid");
+	const u32 next_pid = perf_sample__intval(sample, "next_pid");
+	const u32 prev_pid = perf_sample__intval(sample, "prev_pid");
 	struct thread *sched_in, *sched_out;
 	struct thread_runtime *tr;
 	int new_shortname;
@@ -1797,8 +1797,8 @@ static int process_sched_switch_event(const struct perf_tool *tool,
 {
 	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
 	int this_cpu = sample->cpu, err = 0;
-	u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
-	    next_pid = evsel__intval(evsel, sample, "next_pid");
+	u32 prev_pid = perf_sample__intval(sample, "prev_pid"),
+	    next_pid = perf_sample__intval(sample, "next_pid");
 
 	if (sched->curr_pid[this_cpu] != (u32)-1) {
 		/*
@@ -2068,12 +2068,11 @@ static char *timehist_get_commstr(struct thread *thread)
 
 /* prio field format: xxx or xxx->yyy */
 #define MAX_PRIO_STR_LEN 8
-static char *timehist_get_priostr(struct evsel *evsel,
-				  struct thread *thread,
+static char *timehist_get_priostr(struct thread *thread,
 				  struct perf_sample *sample)
 {
 	static char prio_str[16];
-	int prev_prio = (int)evsel__intval(evsel, sample, "prev_prio");
+	int prev_prio = (int)perf_sample__intval(sample, "prev_prio");
 	struct thread_runtime *tr = thread__priv(thread);
 
 	if (tr->prio != prev_prio && tr->prio != -1)
@@ -2161,15 +2160,14 @@ static void timehist_header(struct perf_sched *sched)
 }
 
 static void timehist_print_sample(struct perf_sched *sched,
-				  struct evsel *evsel,
 				  struct perf_sample *sample,
 				  struct addr_location *al,
 				  struct thread *thread,
 				  u64 t, const char state)
 {
 	struct thread_runtime *tr = thread__priv(thread);
-	const char *next_comm = evsel__strval(evsel, sample, "next_comm");
-	const u32 next_pid = evsel__intval(evsel, sample, "next_pid");
+	const char *next_comm = perf_sample__strval(sample, "next_comm");
+	const u32 next_pid = perf_sample__intval(sample, "next_pid");
 	u32 max_cpus = sched->max_cpu.cpu + 1;
 	char tstr[64];
 	char nstr[30];
@@ -2198,14 +2196,15 @@ static void timehist_print_sample(struct perf_sched *sched,
 	}
 
 	if (!thread__comm_set(thread)) {
-                const char *prev_comm = evsel__strval(evsel, sample, "prev_comm");
-                thread__set_comm(thread, prev_comm, sample->time);
+		const char *prev_comm = perf_sample__strval(sample, "prev_comm");
+
+		thread__set_comm(thread, prev_comm, sample->time);
         }
 
 	printf(" %-*s ", comm_width, timehist_get_commstr(thread));
 
 	if (sched->show_prio)
-		printf(" %-*s ", MAX_PRIO_STR_LEN, timehist_get_priostr(evsel, thread, sample));
+		printf(" %-*s ", MAX_PRIO_STR_LEN, timehist_get_priostr(thread, sample));
 
 	wait_time = tr->dt_sleep + tr->dt_iowait + tr->dt_preempt;
 	print_sched_time(wait_time, 6);
@@ -2319,7 +2318,7 @@ static bool is_idle_sample(struct perf_sample *sample,
 {
 	/* pid 0 == swapper == idle task */
 	if (evsel__name_is(evsel, "sched:sched_switch"))
-		return evsel__intval(evsel, sample, "prev_pid") == 0;
+		return perf_sample__intval(sample, "prev_pid") == 0;
 
 	return sample->pid == 0;
 }
@@ -2539,7 +2538,7 @@ static struct thread *timehist_get_thread(struct perf_sched *sched,
 			itr->last_thread = thread__get(thread);
 
 			/* copy task callchain when entering to idle */
-			if (evsel__intval(evsel, sample, "next_pid") == 0)
+			if (perf_sample__intval(sample, "next_pid") == 0)
 				save_idle_callchain(sched, itr, sample);
 		}
 	}
@@ -2572,7 +2571,7 @@ static bool timehist_skip_sample(struct perf_sched *sched,
 		if (tr && tr->prio != -1)
 			prio = tr->prio;
 		else if (evsel__name_is(evsel, "sched:sched_switch"))
-			prio = evsel__intval(evsel, sample, "prev_prio");
+			prio = perf_sample__intval(sample, "prev_prio");
 
 		if (prio != -1 && !test_bit(prio, sched->prio_bitmap)) {
 			rc = true;
@@ -2583,8 +2582,8 @@ static bool timehist_skip_sample(struct perf_sched *sched,
 	if (sched->idle_hist) {
 		if (!evsel__name_is(evsel, "sched:sched_switch"))
 			rc = true;
-		else if (evsel__intval(evsel, sample, "prev_pid") != 0 &&
-			 evsel__intval(evsel, sample, "next_pid") != 0)
+		else if (perf_sample__intval(sample, "prev_pid") != 0 &&
+			 perf_sample__intval(sample, "next_pid") != 0)
 			rc = true;
 	}
 
@@ -2647,7 +2646,7 @@ static int timehist_sched_wakeup_event(const struct perf_tool *tool,
 	struct thread *thread;
 	struct thread_runtime *tr = NULL;
 	/* want pid of awakened task not pid in sample */
-	const u32 pid = evsel__intval(evsel, sample, "pid");
+	const u32 pid = perf_sample__intval(sample, "pid");
 
 	thread = machine__findnew_thread(machine, 0, pid);
 	if (thread == NULL)
@@ -2686,8 +2685,8 @@ static void timehist_print_migration_event(struct perf_sched *sched,
 		return;
 
 	max_cpus = sched->max_cpu.cpu + 1;
-	ocpu = evsel__intval(evsel, sample, "orig_cpu");
-	dcpu = evsel__intval(evsel, sample, "dest_cpu");
+	ocpu = perf_sample__intval(sample, "orig_cpu");
+	dcpu = perf_sample__intval(sample, "dest_cpu");
 
 	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
 	if (thread == NULL)
@@ -2736,7 +2735,7 @@ static int timehist_migrate_task_event(const struct perf_tool *tool,
 	struct thread *thread;
 	struct thread_runtime *tr = NULL;
 	/* want pid of migrated task not pid in sample */
-	const u32 pid = evsel__intval(evsel, sample, "pid");
+	const u32 pid = perf_sample__intval(sample, "pid");
 
 	thread = machine__findnew_thread(machine, 0, pid);
 	if (thread == NULL)
@@ -2761,14 +2760,13 @@ static int timehist_migrate_task_event(const struct perf_tool *tool,
 	return 0;
 }
 
-static void timehist_update_task_prio(struct evsel *evsel,
-				      struct perf_sample *sample,
+static void timehist_update_task_prio(struct perf_sample *sample,
 				      struct machine *machine)
 {
 	struct thread *thread;
 	struct thread_runtime *tr = NULL;
-	const u32 next_pid = evsel__intval(evsel, sample, "next_pid");
-	const u32 next_prio = evsel__intval(evsel, sample, "next_prio");
+	const u32 next_pid = perf_sample__intval(sample, "next_pid");
+	const u32 next_prio = perf_sample__intval(sample, "next_prio");
 
 	if (next_pid == 0)
 		thread = get_idle_thread(sample->cpu);
@@ -2798,7 +2796,7 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 	struct thread_runtime *tr = NULL;
 	u64 tprev, t = sample->time;
 	int rc = 0;
-	const char state = evsel__taskstate(evsel, sample, "prev_state");
+	const char state = perf_sample__taskstate(sample, "prev_state");
 
 	addr_location__init(&al);
 	if (machine__resolve(machine, &al, sample) < 0) {
@@ -2809,7 +2807,7 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 	}
 
 	if (sched->show_prio || sched->prio_str)
-		timehist_update_task_prio(evsel, sample, machine);
+		timehist_update_task_prio(sample, machine);
 
 	thread = timehist_get_thread(sched, sample, machine, evsel);
 	if (thread == NULL) {
@@ -2891,7 +2889,7 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 		}
 
 		if (!sched->summary_only)
-			timehist_print_sample(sched, evsel, sample, &al, thread, t, state);
+			timehist_print_sample(sched, sample, &al, thread, t, state);
 	}
 
 out:
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 8692d11ccd29..034e0ba3f9cb 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -597,12 +597,12 @@ static int process_sample_event(const struct perf_tool *tool,
 
 static int
 process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
-			struct evsel *evsel,
+			struct evsel *evsel __maybe_unused,
 			struct perf_sample *sample,
 			const char *backtrace __maybe_unused)
 {
-	u32 state  = evsel__intval(evsel, sample, "state");
-	u32 cpu_id = evsel__intval(evsel, sample, "cpu_id");
+	u32 state  = perf_sample__intval(sample, "state");
+	u32 cpu_id = perf_sample__intval(sample, "cpu_id");
 
 	if (state == (u32)PWR_EVENT_EXIT)
 		c_state_end(tchart, cpu_id, sample->time);
@@ -613,12 +613,12 @@ process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
 
 static int
 process_sample_cpu_frequency(struct timechart *tchart,
-			     struct evsel *evsel,
+			     struct evsel *evsel __maybe_unused,
 			     struct perf_sample *sample,
 			     const char *backtrace __maybe_unused)
 {
-	u32 state  = evsel__intval(evsel, sample, "state");
-	u32 cpu_id = evsel__intval(evsel, sample, "cpu_id");
+	u32 state  = perf_sample__intval(sample, "state");
+	u32 cpu_id = perf_sample__intval(sample, "cpu_id");
 
 	p_state_change(tchart, cpu_id, sample->time, state);
 	return 0;
@@ -626,13 +626,13 @@ process_sample_cpu_frequency(struct timechart *tchart,
 
 static int
 process_sample_sched_wakeup(struct timechart *tchart,
-			    struct evsel *evsel,
+			    struct evsel *evsel __maybe_unused,
 			    struct perf_sample *sample,
 			    const char *backtrace)
 {
-	u8 flags  = evsel__intval(evsel, sample, "common_flags");
-	int waker = evsel__intval(evsel, sample, "common_pid");
-	int wakee = evsel__intval(evsel, sample, "pid");
+	u8 flags  = perf_sample__intval(sample, "common_flags");
+	int waker = perf_sample__intval(sample, "common_pid");
+	int wakee = perf_sample__intval(sample, "pid");
 
 	sched_wakeup(tchart, sample->cpu, sample->time, waker, wakee, flags, backtrace);
 	return 0;
@@ -640,13 +640,13 @@ process_sample_sched_wakeup(struct timechart *tchart,
 
 static int
 process_sample_sched_switch(struct timechart *tchart,
-			    struct evsel *evsel,
+			    struct evsel *evsel __maybe_unused,
 			    struct perf_sample *sample,
 			    const char *backtrace)
 {
-	int prev_pid   = evsel__intval(evsel, sample, "prev_pid");
-	int next_pid   = evsel__intval(evsel, sample, "next_pid");
-	u64 prev_state = evsel__intval(evsel, sample, "prev_state");
+	int prev_pid   = perf_sample__intval(sample, "prev_pid");
+	int next_pid   = perf_sample__intval(sample, "next_pid");
+	u64 prev_state = perf_sample__intval(sample, "prev_state");
 
 	sched_switch(tchart, sample->cpu, sample->time, prev_pid, next_pid,
 		     prev_state, backtrace);
@@ -656,12 +656,12 @@ process_sample_sched_switch(struct timechart *tchart,
 #ifdef SUPPORT_OLD_POWER_EVENTS
 static int
 process_sample_power_start(struct timechart *tchart __maybe_unused,
-			   struct evsel *evsel,
+			   struct evsel *evsel __maybe_unused,
 			   struct perf_sample *sample,
 			   const char *backtrace __maybe_unused)
 {
-	u64 cpu_id = evsel__intval(evsel, sample, "cpu_id");
-	u64 value  = evsel__intval(evsel, sample, "value");
+	u64 cpu_id = perf_sample__intval(sample, "cpu_id");
+	u64 value  = perf_sample__intval(sample, "value");
 
 	c_state_start(cpu_id, sample->time, value);
 	return 0;
@@ -679,12 +679,12 @@ process_sample_power_end(struct timechart *tchart,
 
 static int
 process_sample_power_frequency(struct timechart *tchart,
-			       struct evsel *evsel,
+			       struct evsel *evsel __maybe_unused,
 			       struct perf_sample *sample,
 			       const char *backtrace __maybe_unused)
 {
-	u64 cpu_id = evsel__intval(evsel, sample, "cpu_id");
-	u64 value  = evsel__intval(evsel, sample, "value");
+	u64 cpu_id = perf_sample__intval(sample, "cpu_id");
+	u64 value  = perf_sample__intval(sample, "value");
 
 	p_state_change(tchart, cpu_id, sample->time, value);
 	return 0;
@@ -849,120 +849,120 @@ static int pid_end_io_sample(struct timechart *tchart, int pid, int type,
 
 static int
 process_enter_read(struct timechart *tchart,
-		   struct evsel *evsel,
+		   struct evsel *evsel __maybe_unused,
 		   struct perf_sample *sample)
 {
-	long fd = evsel__intval(evsel, sample, "fd");
+	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_READ,
 				   sample->time, fd);
 }
 
 static int
 process_exit_read(struct timechart *tchart,
-		  struct evsel *evsel,
+		  struct evsel *evsel __maybe_unused,
 		  struct perf_sample *sample)
 {
-	long ret = evsel__intval(evsel, sample, "ret");
+	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_READ,
 				 sample->time, ret);
 }
 
 static int
 process_enter_write(struct timechart *tchart,
-		    struct evsel *evsel,
+		    struct evsel *evsel __maybe_unused,
 		    struct perf_sample *sample)
 {
-	long fd = evsel__intval(evsel, sample, "fd");
+	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_WRITE,
 				   sample->time, fd);
 }
 
 static int
 process_exit_write(struct timechart *tchart,
-		   struct evsel *evsel,
+		   struct evsel *evsel __maybe_unused,
 		   struct perf_sample *sample)
 {
-	long ret = evsel__intval(evsel, sample, "ret");
+	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_WRITE,
 				 sample->time, ret);
 }
 
 static int
 process_enter_sync(struct timechart *tchart,
-		   struct evsel *evsel,
+		   struct evsel *evsel __maybe_unused,
 		   struct perf_sample *sample)
 {
-	long fd = evsel__intval(evsel, sample, "fd");
+	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_SYNC,
 				   sample->time, fd);
 }
 
 static int
 process_exit_sync(struct timechart *tchart,
-		  struct evsel *evsel,
+		  struct evsel *evsel __maybe_unused,
 		  struct perf_sample *sample)
 {
-	long ret = evsel__intval(evsel, sample, "ret");
+	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_SYNC,
 				 sample->time, ret);
 }
 
 static int
 process_enter_tx(struct timechart *tchart,
-		 struct evsel *evsel,
+		 struct evsel *evsel __maybe_unused,
 		 struct perf_sample *sample)
 {
-	long fd = evsel__intval(evsel, sample, "fd");
+	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_TX,
 				   sample->time, fd);
 }
 
 static int
 process_exit_tx(struct timechart *tchart,
-		struct evsel *evsel,
+		struct evsel *evsel __maybe_unused,
 		struct perf_sample *sample)
 {
-	long ret = evsel__intval(evsel, sample, "ret");
+	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_TX,
 				 sample->time, ret);
 }
 
 static int
 process_enter_rx(struct timechart *tchart,
-		 struct evsel *evsel,
+		 struct evsel *evsel __maybe_unused,
 		 struct perf_sample *sample)
 {
-	long fd = evsel__intval(evsel, sample, "fd");
+	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_RX,
 				   sample->time, fd);
 }
 
 static int
 process_exit_rx(struct timechart *tchart,
-		struct evsel *evsel,
+		struct evsel *evsel __maybe_unused,
 		struct perf_sample *sample)
 {
-	long ret = evsel__intval(evsel, sample, "ret");
+	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_RX,
 				 sample->time, ret);
 }
 
 static int
 process_enter_poll(struct timechart *tchart,
-		   struct evsel *evsel,
+		   struct evsel *evsel __maybe_unused,
 		   struct perf_sample *sample)
 {
-	long fd = evsel__intval(evsel, sample, "fd");
+	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_POLL,
 				   sample->time, fd);
 }
 
 static int
 process_exit_poll(struct timechart *tchart,
-		  struct evsel *evsel,
+		  struct evsel *evsel __maybe_unused,
 		  struct perf_sample *sample)
 {
-	long ret = evsel__intval(evsel, sample, "ret");
+	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_POLL,
 				 sample->time, ret);
 }
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d9e80740e9ac..f05782f03d6c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3061,7 +3061,7 @@ errno_print: {
 	return err;
 }
 
-static int trace__vfs_getname(struct trace *trace, struct evsel *evsel,
+static int trace__vfs_getname(struct trace *trace, struct evsel *evsel __maybe_unused,
 			      union perf_event *event __maybe_unused,
 			      struct perf_sample *sample)
 {
@@ -3070,7 +3070,7 @@ static int trace__vfs_getname(struct trace *trace, struct evsel *evsel,
 	size_t filename_len, entry_str_len, to_move;
 	ssize_t remaining_space;
 	char *pos;
-	const char *filename = evsel__rawptr(evsel, sample, "pathname");
+	const char *filename = perf_sample__strval(sample, "pathname");
 
 	if (!thread)
 		goto out;
@@ -3126,7 +3126,7 @@ static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
 				     union perf_event *event __maybe_unused,
 				     struct perf_sample *sample)
 {
-        u64 runtime = evsel__intval(evsel, sample, "runtime");
+	u64 runtime = perf_sample__intval(sample, "runtime");
 	double runtime_ms = (double)runtime / NSEC_PER_MSEC;
 	struct thread *thread = machine__findnew_thread(trace->host,
 							sample->pid,
@@ -3145,10 +3145,10 @@ static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
 out_dump:
 	fprintf(trace->output, "%s: comm=%s,pid=%u,runtime=%" PRIu64 ",vruntime=%" PRIu64 ")\n",
 	       evsel->name,
-	       evsel__strval(evsel, sample, "comm"),
-	       (pid_t)evsel__intval(evsel, sample, "pid"),
+	       perf_sample__strval(sample, "comm"),
+	       (pid_t)perf_sample__intval(sample, "pid"),
 	       runtime,
-	       evsel__intval(evsel, sample, "vruntime"));
+	       perf_sample__intval(sample, "vruntime"));
 	goto out_put;
 }
 
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 2a139d2781a8..97550b349418 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -118,7 +118,7 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
 					goto out_delete_evlist;
 				}
 
-				tp_flags = evsel__intval(evsel, &sample, "flags");
+				tp_flags = perf_sample__intval(&sample, "flags");
 				perf_sample__exit(&sample);
 				if (flags != tp_flags) {
 					pr_debug("%s: Expected flags=%#x, got %#x\n",
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 72a8289e846d..22b0302252db 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -140,8 +140,8 @@ static int process_sample_event(struct evlist *evlist,
 
 	evsel = evlist__id2evsel(evlist, sample.id);
 	if (evsel == switch_tracking->switch_evsel) {
-		next_tid = evsel__intval(evsel, &sample, "next_pid");
-		prev_tid = evsel__intval(evsel, &sample, "prev_pid");
+		next_tid = perf_sample__intval(&sample, "next_pid");
+		prev_tid = perf_sample__intval(&sample, "prev_pid");
 		cpu = sample.cpu;
 		pr_debug3("sched_switch: cpu: %d prev_tid %d next_tid %d\n",
 			  cpu, prev_tid, next_tid);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2ee87fd84d3e..ee30e15af054 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3687,9 +3687,9 @@ struct tep_format_field *evsel__common_field(struct evsel *evsel, const char *na
 	return tp_format ? tep_find_common_field(tp_format, name) : NULL;
 }
 
-void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char *name)
+void *perf_sample__rawptr(struct perf_sample *sample, const char *name)
 {
-	struct tep_format_field *field = evsel__field(evsel, name);
+	struct tep_format_field *field = evsel__field(sample->evsel, name);
 	int offset;
 
 	if (!field)
@@ -3746,21 +3746,21 @@ u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sam
 	return 0;
 }
 
-u64 evsel__intval(struct evsel *evsel, struct perf_sample *sample, const char *name)
+u64 perf_sample__intval(struct perf_sample *sample, const char *name)
 {
-	struct tep_format_field *field = evsel__field(evsel, name);
+	struct tep_format_field *field = evsel__field(sample->evsel, name);
 
-	return field ? format_field__intval(field, sample, evsel->needs_swap) : 0;
+	return field ? format_field__intval(field, sample, sample->evsel->needs_swap) : 0;
 }
 
-u64 evsel__intval_common(struct evsel *evsel, struct perf_sample *sample, const char *name)
+u64 perf_sample__intval_common(struct perf_sample *sample, const char *name)
 {
-	struct tep_format_field *field = evsel__common_field(evsel, name);
+	struct tep_format_field *field = evsel__common_field(sample->evsel, name);
 
-	return field ? format_field__intval(field, sample, evsel->needs_swap) : 0;
+	return field ? format_field__intval(field, sample, sample->evsel->needs_swap) : 0;
 }
 
-char evsel__taskstate(struct evsel *evsel, struct perf_sample *sample, const char *name)
+char perf_sample__taskstate(struct perf_sample *sample, const char *name)
 {
 	static struct tep_format_field *prev_state_field;
 	static const char *states;
@@ -3769,7 +3769,7 @@ char evsel__taskstate(struct evsel *evsel, struct perf_sample *sample, const cha
 	unsigned int bit;
 	char state = '?'; /* '?' denotes unknown task state */
 
-	field = evsel__field(evsel, name);
+	field = evsel__field(sample->evsel, name);
 
 	if (!field)
 		return state;
@@ -3788,7 +3788,7 @@ char evsel__taskstate(struct evsel *evsel, struct perf_sample *sample, const cha
 	 *
 	 * We can change this if we have a good reason in the future.
 	 */
-	val = evsel__intval(evsel, sample, name);
+	val = perf_sample__intval(sample, name);
 	bit = val ? ffs(val) : 0;
 	state = (!bit || bit > strlen(states)) ? 'R' : states[bit-1];
 	return state;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 339b5c08a33d..927e5b4756cc 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -371,14 +371,14 @@ bool evsel__precise_ip_fallback(struct evsel *evsel);
 struct perf_sample;
 
 #ifdef HAVE_LIBTRACEEVENT
-void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char *name);
-u64 evsel__intval(struct evsel *evsel, struct perf_sample *sample, const char *name);
-u64 evsel__intval_common(struct evsel *evsel, struct perf_sample *sample, const char *name);
-char evsel__taskstate(struct evsel *evsel, struct perf_sample *sample, const char *name);
+void *perf_sample__rawptr(struct perf_sample *sample, const char *name);
+u64 perf_sample__intval(struct perf_sample *sample, const char *name);
+u64 perf_sample__intval_common(struct perf_sample *sample, const char *name);
+char perf_sample__taskstate(struct perf_sample *sample, const char *name);
 
-static inline char *evsel__strval(struct evsel *evsel, struct perf_sample *sample, const char *name)
+static inline char *perf_sample__strval(struct perf_sample *sample, const char *name)
 {
-	return evsel__rawptr(evsel, sample, name);
+	return perf_sample__rawptr(sample, name);
 }
 #endif
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index fc9eec8b54b8..dab23a96b1d8 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3426,7 +3426,7 @@ static int intel_pt_process_switch(struct intel_pt *pt,
 	if (evsel != pt->switch_evsel)
 		return 0;
 
-	tid = evsel__intval(evsel, sample, "next_pid");
+	tid = perf_sample__intval(sample, "next_pid");
 	cpu = sample->cpu;
 
 	intel_pt_log("sched_switch: cpu %d tid %d time %"PRIu64" tsc %#"PRIx64"\n",
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-arm64.c b/tools/perf/util/kvm-stat-arch/kvm-stat-arm64.c
index 1e76906f719c..018b0db0e6e7 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-arm64.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-arm64.c
@@ -20,10 +20,8 @@ static const char * const __kvm_events_tp[] = {
 static void event_get_key(struct perf_sample *sample,
 			  struct event_key *key)
 {
-	struct evsel *evsel = sample->evsel;
-
 	key->info = 0;
-	key->key = evsel__intval(evsel, sample, kvm_exit_reason(EM_AARCH64));
+	key->key = perf_sample__intval(sample, kvm_exit_reason(EM_AARCH64));
 	key->exit_reasons = arm64_exit_reasons;
 
 	/*
@@ -32,7 +30,7 @@ static void event_get_key(struct perf_sample *sample,
 	 * properly decode event's est_ec.
 	 */
 	if (key->key == ARM_EXCEPTION_TRAP) {
-		key->key = evsel__intval(evsel, sample, kvm_trap_exit_reason);
+		key->key = perf_sample__intval(sample, kvm_trap_exit_reason);
 		key->exit_reasons = arm64_trap_exit_reasons;
 	}
 }
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-loongarch.c b/tools/perf/util/kvm-stat-arch/kvm-stat-loongarch.c
index 9d6265290f6d..a04cd09e3361 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-loongarch.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-loongarch.c
@@ -78,7 +78,7 @@ static void event_gspr_get_key(struct perf_sample *sample, struct event_key *key
 	unsigned int insn;
 
 	key->key = LOONGARCH_EXCEPTION_OTHERS;
-	insn = evsel__intval(sample->evsel, sample, "inst_word");
+	insn = perf_sample__intval(sample, "inst_word");
 
 	switch (insn >> 24) {
 	case 0:
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c b/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c
index 5158d7e88ee6..96d9c4ae0209 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c
@@ -32,7 +32,7 @@ static void hcall_event_get_key(struct perf_sample *sample,
 				struct event_key *key)
 {
 	key->info = 0;
-	key->key = evsel__intval(sample->evsel, sample, "req");
+	key->key = perf_sample__intval(sample, "req");
 }
 
 static const char *get_hcall_exit_reason(u64 exit_code)
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c b/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c
index e8db8b4f8e2e..967bba261a47 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c
@@ -26,8 +26,7 @@ static void event_get_key(struct perf_sample *sample,
 	int xlen = 64; // TODO: 32-bit support.
 
 	key->info = 0;
-	key->key = evsel__intval(sample->evsel, sample,
-				 kvm_exit_reason(EM_RISCV)) & ~CAUSE_IRQ_FLAG(xlen);
+	key->key = perf_sample__intval(sample, kvm_exit_reason(EM_RISCV)) & ~CAUSE_IRQ_FLAG(xlen);
 	key->exit_reasons = riscv_exit_reasons;
 }
 
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-s390.c b/tools/perf/util/kvm-stat-arch/kvm-stat-s390.c
index 158372ba0205..4771fc69fa39 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-s390.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-s390.c
@@ -23,7 +23,7 @@ static void event_icpt_insn_get_key(struct perf_sample *sample,
 {
 	u64 insn;
 
-	insn = evsel__intval(sample->evsel, sample, "instruction");
+	insn = perf_sample__intval(sample, "instruction");
 	key->key = icpt_insn_decoder(insn);
 	key->exit_reasons = sie_icpt_insn_codes;
 }
@@ -31,21 +31,21 @@ static void event_icpt_insn_get_key(struct perf_sample *sample,
 static void event_sigp_get_key(struct perf_sample *sample,
 			       struct event_key *key)
 {
-	key->key = evsel__intval(sample->evsel, sample, "order_code");
+	key->key = perf_sample__intval(sample, "order_code");
 	key->exit_reasons = sie_sigp_order_codes;
 }
 
 static void event_diag_get_key(struct perf_sample *sample,
 			       struct event_key *key)
 {
-	key->key = evsel__intval(sample->evsel, sample, "code");
+	key->key = perf_sample__intval(sample, "code");
 	key->exit_reasons = sie_diagnose_codes;
 }
 
 static void event_icpt_prog_get_key(struct perf_sample *sample,
 				    struct event_key *key)
 {
-	key->key = evsel__intval(sample->evsel, sample, "code");
+	key->key = perf_sample__intval(sample, "code");
 	key->exit_reasons = sie_icpt_prog_codes;
 }
 
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
index 0ce543d82850..788d216f0852 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
@@ -27,8 +27,8 @@ static const struct kvm_events_ops exit_events = {
 static void mmio_event_get_key(struct perf_sample *sample,
 			       struct event_key *key)
 {
-	key->key  = evsel__intval(sample->evsel, sample, "gpa");
-	key->info = evsel__intval(sample->evsel, sample, "type");
+	key->key  = perf_sample__intval(sample, "gpa");
+	key->info = perf_sample__intval(sample, "type");
 }
 
 #define KVM_TRACE_MMIO_READ_UNSATISFIED 0
@@ -43,7 +43,7 @@ static bool mmio_event_begin(struct perf_sample *sample, struct event_key *key)
 
 	/* MMIO write begin event in kernel. */
 	if (evsel__name_is(sample->evsel, "kvm:kvm_mmio") &&
-	    evsel__intval(sample->evsel, sample, "type") == KVM_TRACE_MMIO_WRITE) {
+	    perf_sample__intval(sample, "type") == KVM_TRACE_MMIO_WRITE) {
 		mmio_event_get_key(sample, key);
 		return true;
 	}
@@ -59,7 +59,7 @@ static bool mmio_event_end(struct perf_sample *sample, struct event_key *key)
 
 	/* MMIO read end event in kernel.*/
 	if (evsel__name_is(sample->evsel, "kvm:kvm_mmio") &&
-	    evsel__intval(sample->evsel, sample, "type") == KVM_TRACE_MMIO_READ) {
+	    perf_sample__intval(sample, "type") == KVM_TRACE_MMIO_READ) {
 		mmio_event_get_key(sample, key);
 		return true;
 	}
@@ -87,8 +87,8 @@ static const struct kvm_events_ops mmio_events = {
 static void ioport_event_get_key(struct perf_sample *sample,
 				 struct event_key *key)
 {
-	key->key  = evsel__intval(sample->evsel, sample, "port");
-	key->info = evsel__intval(sample->evsel, sample, "rw");
+	key->key  = perf_sample__intval(sample, "port");
+	key->info = perf_sample__intval(sample, "rw");
 }
 
 static bool ioport_event_begin(struct perf_sample *sample,
@@ -126,8 +126,8 @@ static const struct kvm_events_ops ioport_events = {
  /* The time of emulation msr is from kvm_msr to kvm_entry. */
 static void msr_event_get_key(struct perf_sample *sample, struct event_key *key)
 {
-	key->key  = evsel__intval(sample->evsel, sample, "ecx");
-	key->info = evsel__intval(sample->evsel, sample, "write");
+	key->key  = perf_sample__intval(sample, "ecx");
+	key->info = perf_sample__intval(sample, "write");
 }
 
 static bool msr_event_begin(struct perf_sample *sample, struct event_key *key)
diff --git a/tools/perf/util/kvm-stat.c b/tools/perf/util/kvm-stat.c
index f17a6132958d..755ab659a05c 100644
--- a/tools/perf/util/kvm-stat.c
+++ b/tools/perf/util/kvm-stat.c
@@ -17,7 +17,7 @@ void exit_event_get_key(struct perf_sample *sample,
 	uint16_t e_machine = evsel__e_machine(sample->evsel, /*e_flags=*/NULL);
 
 	key->info = 0;
-	key->key  = evsel__intval(sample->evsel, sample, kvm_exit_reason(e_machine));
+	key->key  = perf_sample__intval(sample, kvm_exit_reason(e_machine));
 }
 
 
-- 
2.53.0.1213.gd9a14994de-goog

