Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E823939A5
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658882; cv=none; b=W1/PWacOaGOQNlGB7+gYh65FNLILwLldI7zu2rKpEOd/PdOnshj7VZQjNNDmNx0xZWd96haSoQnYsuqEU9UmFpMRPceMDDr2VSxuyHNXt4rqC4to4N6/9t2LnP6nJettmkCUjyHHAqR4lSoe5pInWXn1huXa5v/VzdgsJMbOMqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658882; c=relaxed/simple;
	bh=Bun0Aw//FOyMCwfGs65rwWj1kQUhxKzAgk1gLvXecoI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bOBSQpQcud5ds0KJhFe/0fTaXHn0Lz1BqQj6jZ9LBv4ZsnFnRBvOC3jhFYXJUpQAPIi3RylHq5VGsRHr4mpbNd07j9eWQmwLEUKyXJZgcmIyTVP4Yj4SQfCG0xgdJ7Gj7ak11agcpC5dhutCDDppqmxji08AdraLHRwc6oycaDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fhk/39lg; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fhk/39lg"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1270dcd11c1so2746069c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 09:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770658882; x=1771263682; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xzj3MwkNPRRwtlx4772x7AEJnrcz9v536SGhsa+Q668=;
        b=Fhk/39lgR0O7qy/NQ2A2PWp5M/7YLpB0aSh4+6he95nc2qgMvrZ1j/swMSVboHEg+r
         oYq3/7Fbaywv08CfsVLiThK6hVk9k5s1SlC6ztBzqMYPj6WR70ZLZW4x23LaBtP699TN
         JEi7J6IqTm5MJiLjpwhH2hlFWD24I1r7++UxK0xPVxcCDwSo0AvwMXJBPhYRWAs14uqp
         nipd1asgNAlg2DS+Klcl+TrvxI+GhgsSQWFWM0xzCm1wArewUwHjjOKdpfsobhZBAy16
         4WeVTS7dqSujVaAscf1BbiFRvmyDX34CSg245zRstkDynx5dRCKh9kBJF7yVRmQCYK1g
         TJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658882; x=1771263682;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xzj3MwkNPRRwtlx4772x7AEJnrcz9v536SGhsa+Q668=;
        b=sDfnMyx9JmsDMmyKikmmGDcyK/aF3oQKymUO0ZZrBQsQ5OXzUBVB+X2eSv044/yeXb
         kdwX6CMfPq2r2GBlwX+I1cZsS9GDkgEB7hkKilC/wanGvyHSyh2fdeczqQR+ll4OL0h6
         2v8GY8srfQ3h364OrLTmifK77leViRTRSFy7mOeEwCqeXjRuuPz6lyhNoOXzMewhma7Z
         upt9/seCuJaoUTti62DQ23HhvP+3D4qRyCTZ1gxKq2BlYUg0XNRsPTmpVnhKmOhkzuyY
         ajUP95PMkUmemmFcSkS1pll6oEqOw5m5c8IWcBkljoKO0NZWZ6ou9LzceFymfb/WSgMw
         Kf/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhrmX1rBKbROT862KZiHmfBa+KRfkho88ux/15LGfwZaSP3vloZj07w/RNG8mBpgAHcjqCCkMIJsjYmS/YV2LX@vger.kernel.org
X-Gm-Message-State: AOJu0YzqjDQdFSW/pNUmn2C3GPHEk/Nfpc5KJhxcxro5naUsQyM0DKCk
	t4j/qJ9BdvzDJlJsZtIoY2E5LrAjpX84wCRMKupZH8KgBx/hfd1GDVdLHD6k0Z/rAxl/2MLQFoO
	GrwV56XqgnA==
X-Received: from dlw12.prod.google.com ([2002:a05:7022:4c:b0:126:f7ed:3a69])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f97:b0:119:e56b:98be
 with SMTP id a92af1059eb24-1270405aa41mr5712354c88.37.1770658881591; Mon, 09
 Feb 2026 09:41:21 -0800 (PST)
Date: Mon,  9 Feb 2026 09:40:25 -0800
In-Reply-To: <20260209174032.4142096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209174032.4142096-19-irogers@google.com>
Subject: [PATCH v1 18/25] perf kwork: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Leo Yan <leo.yan@arm.com>, Tianyou Li <tianyou.li@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, tanze <tanze@kylinos.cn>, 
	Hrishikesh Suresh <hrishikesh123s@gmail.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Chen Ni <nichen@iscas.ac.cn>, Blake Jones <blakejones@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The sample contains the evsel and so it is unnecessary to pass the
evsel as well. Remove the evsel from struct kwork_class.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kwork.c | 74 +++++++++++++-------------------------
 tools/perf/util/kwork.h    |  9 +++--
 2 files changed, 28 insertions(+), 55 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index bd62616af476..eb3bc47c248d 100644
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
2.53.0.239.g8d8fc8a987-goog

