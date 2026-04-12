Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B5631D371
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775959759; cv=none; b=NbsQJClFFZNhIayGDeItIDPaCgaYCw4XRquGygg5/LIx0we059YqnzT1R0yrO6iVRJ0Zvk2UbyEW2mY5H85MWh+O9fESy4TpJC5D+/t4OJa9EC42rijHDYl/Gw62GKdHeLAwGdgUGxXR1edWTlMo2w9vS07lRGSqCvgq4D3i5qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775959759; c=relaxed/simple;
	bh=SE3cJDOBvf3PgP8DFewKacgMwSl2GoO2JdgZlKmqibg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jEDn5ltiesQCfRpCDhY/Ye4pDoh88oSZmB69oyO1VMSQTiU4W4MjGnKSQ7utMCksHMTv4VhD/wPQbmJVLfVgo6c1xAn+6l6V7mckSACeE6PcbA+zKtlCWfJVzOG0o9kA01hHnILPAjNjOGJeLaV7fCWM+Ne3CZdM6l+QjRzzc8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vh1y8hl9; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vh1y8hl9"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c20d5d7f4so10380392c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775959757; x=1776564557; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kwN00VUURJ6vnbttYkG+wVIS3y4I1aMoOpY9cSqnbDI=;
        b=Vh1y8hl98iwTbl7rIEy2nFzeWHky2jI0HpoLQHRqISPGT5bhILYc1aKU/wFQ2cYvAA
         rNOVKsLn3DpCROSkg/jgCE2d0A4CTEdvljcvbl1QVSsWULqxbDw5E4Iuvfn6Lcu8vZ27
         LpaV/xx3pXTnUspDucW9omqPvO2lQVzm1Zg/nuiTZN0SC4C1vc8tfyW7v9IycRrRccUa
         Uj5RdHH+SqUL2geTUohMMiu+PxLSET/cmmXG8duKTC9qhwrZQ9Vsup1TA+rbe0zPEzqe
         Dq200LphqseUmf5xNZHcwuntX22WbZNcGLUr4JsmUPU20dTpVfcM1t0fYzMDn0XIwZF3
         PGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775959757; x=1776564557;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kwN00VUURJ6vnbttYkG+wVIS3y4I1aMoOpY9cSqnbDI=;
        b=DdXHzLynu412OA384gpJ4ueQNQFU3nraSIbqwzenjCZ0FRU0A161B7bayH4g+4iXgH
         KrWug4k2C7MFW4vAamZXSMcQfsgRVrh+nGeBYIgTZ3/DLFxCblR5su53zsOu1umWYfyy
         aChJ6lI2M4kDPPKEgZRLLNgtidg7pDhrvRXnt+gQIjY8G80hj19kKRpY3Za2VCz2oOQO
         9bNwcwKxpOUln5K6w2PfU7ZATtDEvDrxTUIIM9z7c+FveD1R51XodZPXxAPtt7soqRt7
         pAc1AXMpzpQgewY1NWN0UkdBRhAdLoQXmkzvJDYDZAHUdvq3F3gYi8HHulV7hYjCKSIe
         TikQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4SUXtrfznMlgSZQIgkOfXAy45hZGpJyh3oPa80y/F5gBaqnet14Hmw2fVhewoeJU/NdJ+9LC+fYZcXI6YKQ9U@vger.kernel.org
X-Gm-Message-State: AOJu0Yyns8yLPAYbjpqBz9qu3Jv1aeT+wdtCyUZbpvFQxLoCLZpn087H
	2lXPyFUPVn/OAGkFuFld/6ceMst8Q2+8HpDYjW30EP8YYnEwjinChKI9yIIYRotL9djuafO2TDG
	Sk405mUGNYQ==
X-Received: from dlbrl10.prod.google.com ([2002:a05:7022:f50a:b0:12a:8455:30a0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6197:b0:11d:f440:b743
 with SMTP id a92af1059eb24-12c34e48f39mr4811817c88.7.1775959756619; Sat, 11
 Apr 2026 19:09:16 -0700 (PDT)
Date: Sat, 11 Apr 2026 19:08:19 -0700
In-Reply-To: <20260412020833.641177-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260412020833.641177-17-irogers@google.com>
Subject: [PATCH v10 16/29] perf kwork: Don't pass evsel with sample
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

The sample contains the evsel and so it is unnecessary to pass the
evsel as well. Remove the evsel from struct kwork_class.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kwork.c | 74 +++++++++++++-------------------------
 tools/perf/util/kwork.h    |  9 +++--
 2 files changed, 28 insertions(+), 55 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 177491eadb70..ab17d3198b93 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -448,7 +448,6 @@ static int work_push_atom(struct perf_kwork *kwork,
 			  struct kwork_class *class,
 			  enum kwork_trace_type src_type,
 			  enum kwork_trace_type dst_type,
-			  struct evsel *evsel,
 			  struct perf_sample *sample,
 			  struct machine *machine,
 			  struct kwork_work **ret_work,
@@ -458,7 +457,7 @@ static int work_push_atom(struct perf_kwork *kwork,
 	struct kwork_work *work, key;
 
 	BUG_ON(class->work_init == NULL);
-	class->work_init(kwork, class, &key, src_type, evsel, sample, machine);
+	class->work_init(kwork, class, &key, src_type, sample, machine);
 
 	atom = atom_new(kwork, sample);
 	if (atom == NULL)
@@ -507,7 +506,6 @@ static struct kwork_atom *work_pop_atom(struct perf_kwork *kwork,
 					struct kwork_class *class,
 					enum kwork_trace_type src_type,
 					enum kwork_trace_type dst_type,
-					struct evsel *evsel,
 					struct perf_sample *sample,
 					struct machine *machine,
 					struct kwork_work **ret_work)
@@ -516,7 +514,7 @@ static struct kwork_atom *work_pop_atom(struct perf_kwork *kwork,
 	struct kwork_work *work, key;
 
 	BUG_ON(class->work_init == NULL);
-	class->work_init(kwork, class, &key, src_type, evsel, sample, machine);
+	class->work_init(kwork, class, &key, src_type, sample, machine);
 
 	work = work_findnew(&class->work_root, &key, &kwork->cmp_id);
 	if (ret_work != NULL)
@@ -599,18 +597,16 @@ static void report_update_exit_event(struct kwork_work *work,
 
 static int report_entry_event(struct perf_kwork *kwork,
 			      struct kwork_class *class,
-			      struct evsel *evsel,
 			      struct perf_sample *sample,
 			      struct machine *machine)
 {
 	return work_push_atom(kwork, class, KWORK_TRACE_ENTRY,
-			      KWORK_TRACE_MAX, evsel, sample,
+			      KWORK_TRACE_MAX, sample,
 			      machine, NULL, true);
 }
 
 static int report_exit_event(struct perf_kwork *kwork,
 			     struct kwork_class *class,
-			     struct evsel *evsel,
 			     struct perf_sample *sample,
 			     struct machine *machine)
 {
@@ -618,7 +614,7 @@ static int report_exit_event(struct perf_kwork *kwork,
 	struct kwork_work *work = NULL;
 
 	atom = work_pop_atom(kwork, class, KWORK_TRACE_EXIT,
-			     KWORK_TRACE_ENTRY, evsel, sample,
+			     KWORK_TRACE_ENTRY, sample,
 			     machine, &work);
 	if (work == NULL)
 		return -1;
@@ -654,18 +650,16 @@ static void latency_update_entry_event(struct kwork_work *work,
 
 static int latency_raise_event(struct perf_kwork *kwork,
 			       struct kwork_class *class,
-			       struct evsel *evsel,
 			       struct perf_sample *sample,
 			       struct machine *machine)
 {
 	return work_push_atom(kwork, class, KWORK_TRACE_RAISE,
-			      KWORK_TRACE_MAX, evsel, sample,
+			      KWORK_TRACE_MAX, sample,
 			      machine, NULL, true);
 }
 
 static int latency_entry_event(struct perf_kwork *kwork,
 			       struct kwork_class *class,
-			       struct evsel *evsel,
 			       struct perf_sample *sample,
 			       struct machine *machine)
 {
@@ -673,7 +667,7 @@ static int latency_entry_event(struct perf_kwork *kwork,
 	struct kwork_work *work = NULL;
 
 	atom = work_pop_atom(kwork, class, KWORK_TRACE_ENTRY,
-			     KWORK_TRACE_RAISE, evsel, sample,
+			     KWORK_TRACE_RAISE, sample,
 			     machine, &work);
 	if (work == NULL)
 		return -1;
@@ -812,18 +806,16 @@ static void timehist_print_event(struct perf_kwork *kwork,
 
 static int timehist_raise_event(struct perf_kwork *kwork,
 				struct kwork_class *class,
-				struct evsel *evsel,
 				struct perf_sample *sample,
 				struct machine *machine)
 {
 	return work_push_atom(kwork, class, KWORK_TRACE_RAISE,
-			      KWORK_TRACE_MAX, evsel, sample,
+			      KWORK_TRACE_MAX, sample,
 			      machine, NULL, true);
 }
 
 static int timehist_entry_event(struct perf_kwork *kwork,
 				struct kwork_class *class,
-				struct evsel *evsel,
 				struct perf_sample *sample,
 				struct machine *machine)
 {
@@ -831,7 +823,7 @@ static int timehist_entry_event(struct perf_kwork *kwork,
 	struct kwork_work *work = NULL;
 
 	ret = work_push_atom(kwork, class, KWORK_TRACE_ENTRY,
-			     KWORK_TRACE_RAISE, evsel, sample,
+			     KWORK_TRACE_RAISE, sample,
 			     machine, &work, true);
 	if (ret)
 		return ret;
@@ -844,7 +836,6 @@ static int timehist_entry_event(struct perf_kwork *kwork,
 
 static int timehist_exit_event(struct perf_kwork *kwork,
 			       struct kwork_class *class,
-			       struct evsel *evsel,
 			       struct perf_sample *sample,
 			       struct machine *machine)
 {
@@ -861,7 +852,7 @@ static int timehist_exit_event(struct perf_kwork *kwork,
 	}
 
 	atom = work_pop_atom(kwork, class, KWORK_TRACE_EXIT,
-			     KWORK_TRACE_ENTRY, evsel, sample,
+			     KWORK_TRACE_ENTRY, sample,
 			     machine, &work);
 	if (work == NULL) {
 		ret = -1;
@@ -895,18 +886,16 @@ static void top_update_runtime(struct kwork_work *work,
 
 static int top_entry_event(struct perf_kwork *kwork,
 			   struct kwork_class *class,
-			   struct evsel *evsel,
 			   struct perf_sample *sample,
 			   struct machine *machine)
 {
 	return work_push_atom(kwork, class, KWORK_TRACE_ENTRY,
-			      KWORK_TRACE_MAX, evsel, sample,
+			      KWORK_TRACE_MAX, sample,
 			      machine, NULL, true);
 }
 
 static int top_exit_event(struct perf_kwork *kwork,
 			  struct kwork_class *class,
-			  struct evsel *evsel,
 			  struct perf_sample *sample,
 			  struct machine *machine)
 {
@@ -915,7 +904,7 @@ static int top_exit_event(struct perf_kwork *kwork,
 	struct kwork_atom *atom;
 
 	atom = work_pop_atom(kwork, class, KWORK_TRACE_EXIT,
-			     KWORK_TRACE_ENTRY, evsel, sample,
+			     KWORK_TRACE_ENTRY, sample,
 			     machine, &work);
 	if (!work)
 		return -1;
@@ -936,7 +925,6 @@ static int top_exit_event(struct perf_kwork *kwork,
 
 static int top_sched_switch_event(struct perf_kwork *kwork,
 				  struct kwork_class *class,
-				  struct evsel *evsel,
 				  struct perf_sample *sample,
 				  struct machine *machine)
 {
@@ -944,7 +932,7 @@ static int top_sched_switch_event(struct perf_kwork *kwork,
 	struct kwork_work *work;
 
 	atom = work_pop_atom(kwork, class, KWORK_TRACE_EXIT,
-			     KWORK_TRACE_ENTRY, evsel, sample,
+			     KWORK_TRACE_ENTRY, sample,
 			     machine, &work);
 	if (!work)
 		return -1;
@@ -954,12 +942,11 @@ static int top_sched_switch_event(struct perf_kwork *kwork,
 		atom_del(atom);
 	}
 
-	return top_entry_event(kwork, class, evsel, sample, machine);
+	return top_entry_event(kwork, class, sample, machine);
 }
 
 static struct kwork_class kwork_irq;
 static int process_irq_handler_entry_event(const struct perf_tool *tool,
-					   struct evsel *evsel,
 					   struct perf_sample *sample,
 					   struct machine *machine)
 {
@@ -967,12 +954,11 @@ static int process_irq_handler_entry_event(const struct perf_tool *tool,
 
 	if (kwork->tp_handler->entry_event)
 		return kwork->tp_handler->entry_event(kwork, &kwork_irq,
-						      evsel, sample, machine);
+						      sample, machine);
 	return 0;
 }
 
 static int process_irq_handler_exit_event(const struct perf_tool *tool,
-					  struct evsel *evsel,
 					  struct perf_sample *sample,
 					  struct machine *machine)
 {
@@ -980,7 +966,7 @@ static int process_irq_handler_exit_event(const struct perf_tool *tool,
 
 	if (kwork->tp_handler->exit_event)
 		return kwork->tp_handler->exit_event(kwork, &kwork_irq,
-						     evsel, sample, machine);
+						     sample, machine);
 	return 0;
 }
 
@@ -1005,7 +991,6 @@ static void irq_work_init(struct perf_kwork *kwork,
 			  struct kwork_class *class,
 			  struct kwork_work *work,
 			  enum kwork_trace_type src_type __maybe_unused,
-			  struct evsel *evsel __maybe_unused,
 			  struct perf_sample *sample,
 			  struct machine *machine __maybe_unused)
 {
@@ -1038,7 +1023,6 @@ static struct kwork_class kwork_irq = {
 
 static struct kwork_class kwork_softirq;
 static int process_softirq_raise_event(const struct perf_tool *tool,
-				       struct evsel *evsel,
 				       struct perf_sample *sample,
 				       struct machine *machine)
 {
@@ -1046,13 +1030,12 @@ static int process_softirq_raise_event(const struct perf_tool *tool,
 
 	if (kwork->tp_handler->raise_event)
 		return kwork->tp_handler->raise_event(kwork, &kwork_softirq,
-						      evsel, sample, machine);
+						      sample, machine);
 
 	return 0;
 }
 
 static int process_softirq_entry_event(const struct perf_tool *tool,
-				       struct evsel *evsel,
 				       struct perf_sample *sample,
 				       struct machine *machine)
 {
@@ -1060,13 +1043,12 @@ static int process_softirq_entry_event(const struct perf_tool *tool,
 
 	if (kwork->tp_handler->entry_event)
 		return kwork->tp_handler->entry_event(kwork, &kwork_softirq,
-						      evsel, sample, machine);
+						      sample, machine);
 
 	return 0;
 }
 
 static int process_softirq_exit_event(const struct perf_tool *tool,
-				      struct evsel *evsel,
 				      struct perf_sample *sample,
 				      struct machine *machine)
 {
@@ -1074,7 +1056,7 @@ static int process_softirq_exit_event(const struct perf_tool *tool,
 
 	if (kwork->tp_handler->exit_event)
 		return kwork->tp_handler->exit_event(kwork, &kwork_softirq,
-						     evsel, sample, machine);
+						     sample, machine);
 
 	return 0;
 }
@@ -1133,7 +1115,6 @@ static void softirq_work_init(struct perf_kwork *kwork,
 			      struct kwork_class *class,
 			      struct kwork_work *work,
 			      enum kwork_trace_type src_type __maybe_unused,
-			      struct evsel *evsel,
 			      struct perf_sample *sample,
 			      struct machine *machine __maybe_unused)
 {
@@ -1148,7 +1129,7 @@ static void softirq_work_init(struct perf_kwork *kwork,
 	} else {
 		num = perf_sample__intval(sample, "vec");
 		work->id = num;
-		work->name = evsel__softirq_name(evsel, num);
+		work->name = evsel__softirq_name(sample->evsel, num);
 	}
 }
 
@@ -1169,7 +1150,6 @@ static struct kwork_class kwork_softirq = {
 
 static struct kwork_class kwork_workqueue;
 static int process_workqueue_activate_work_event(const struct perf_tool *tool,
-						 struct evsel *evsel,
 						 struct perf_sample *sample,
 						 struct machine *machine)
 {
@@ -1177,13 +1157,12 @@ static int process_workqueue_activate_work_event(const struct perf_tool *tool,
 
 	if (kwork->tp_handler->raise_event)
 		return kwork->tp_handler->raise_event(kwork, &kwork_workqueue,
-						    evsel, sample, machine);
+						      sample, machine);
 
 	return 0;
 }
 
 static int process_workqueue_execute_start_event(const struct perf_tool *tool,
-						 struct evsel *evsel,
 						 struct perf_sample *sample,
 						 struct machine *machine)
 {
@@ -1191,13 +1170,12 @@ static int process_workqueue_execute_start_event(const struct perf_tool *tool,
 
 	if (kwork->tp_handler->entry_event)
 		return kwork->tp_handler->entry_event(kwork, &kwork_workqueue,
-						    evsel, sample, machine);
+						      sample, machine);
 
 	return 0;
 }
 
 static int process_workqueue_execute_end_event(const struct perf_tool *tool,
-					       struct evsel *evsel,
 					       struct perf_sample *sample,
 					       struct machine *machine)
 {
@@ -1205,7 +1183,7 @@ static int process_workqueue_execute_end_event(const struct perf_tool *tool,
 
 	if (kwork->tp_handler->exit_event)
 		return kwork->tp_handler->exit_event(kwork, &kwork_workqueue,
-						   evsel, sample, machine);
+						     sample, machine);
 
 	return 0;
 }
@@ -1233,7 +1211,6 @@ static void workqueue_work_init(struct perf_kwork *kwork __maybe_unused,
 				struct kwork_class *class,
 				struct kwork_work *work,
 				enum kwork_trace_type src_type __maybe_unused,
-				struct evsel *evsel __maybe_unused,
 				struct perf_sample *sample,
 				struct machine *machine)
 {
@@ -1267,7 +1244,6 @@ static struct kwork_class kwork_workqueue = {
 
 static struct kwork_class kwork_sched;
 static int process_sched_switch_event(const struct perf_tool *tool,
-				      struct evsel *evsel,
 				      struct perf_sample *sample,
 				      struct machine *machine)
 {
@@ -1275,7 +1251,7 @@ static int process_sched_switch_event(const struct perf_tool *tool,
 
 	if (kwork->tp_handler->sched_switch_event)
 		return kwork->tp_handler->sched_switch_event(kwork, &kwork_sched,
-							     evsel, sample, machine);
+							     sample, machine);
 	return 0;
 }
 
@@ -1300,7 +1276,6 @@ static void sched_work_init(struct perf_kwork *kwork __maybe_unused,
 			    struct kwork_class *class,
 			    struct kwork_work *work,
 			    enum kwork_trace_type src_type,
-			    struct evsel *evsel __maybe_unused,
 			    struct perf_sample *sample,
 			    struct machine *machine __maybe_unused)
 {
@@ -1946,7 +1921,6 @@ static int perf_kwork__report(struct perf_kwork *kwork)
 }
 
 typedef int (*tracepoint_handler)(const struct perf_tool *tool,
-				  struct evsel *evsel,
 				  struct perf_sample *sample,
 				  struct machine *machine);
 
@@ -1961,7 +1935,7 @@ static int perf_kwork__process_tracepoint_sample(const struct perf_tool *tool,
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
 
-		err = f(tool, evsel, sample, machine);
+		err = f(tool, sample, machine);
 	}
 
 	return err;
diff --git a/tools/perf/util/kwork.h b/tools/perf/util/kwork.h
index db00269b73f2..abf637d44794 100644
--- a/tools/perf/util/kwork.h
+++ b/tools/perf/util/kwork.h
@@ -157,7 +157,6 @@ struct kwork_class {
 			  struct kwork_class *class,
 			  struct kwork_work *work,
 			  enum kwork_trace_type src_type,
-			  struct evsel *evsel,
 			  struct perf_sample *sample,
 			  struct machine *machine);
 
@@ -167,19 +166,19 @@ struct kwork_class {
 
 struct trace_kwork_handler {
 	int (*raise_event)(struct perf_kwork *kwork,
-			   struct kwork_class *class, struct evsel *evsel,
+			   struct kwork_class *class,
 			   struct perf_sample *sample, struct machine *machine);
 
 	int (*entry_event)(struct perf_kwork *kwork,
-			   struct kwork_class *class, struct evsel *evsel,
+			   struct kwork_class *class,
 			   struct perf_sample *sample, struct machine *machine);
 
 	int (*exit_event)(struct perf_kwork *kwork,
-			  struct kwork_class *class, struct evsel *evsel,
+			  struct kwork_class *class,
 			  struct perf_sample *sample, struct machine *machine);
 
 	int (*sched_switch_event)(struct perf_kwork *kwork,
-				  struct kwork_class *class, struct evsel *evsel,
+				  struct kwork_class *class,
 				  struct perf_sample *sample, struct machine *machine);
 };
 
-- 
2.53.0.1213.gd9a14994de-goog

