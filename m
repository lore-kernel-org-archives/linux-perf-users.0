Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F134038B9AC
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658878; cv=none; b=o2nZQhcgCv0FctEGywM4YQqbJyZowXQFxj5JsRulyH+dcaI3kwc8iArf0mywSzBHsLfGYt8jndOsZ9p848XI+b3yA1kypMQB+EEBy8YscshX7KYGuvkpV2TdM0W83K+jrWfK/RJ7r8k80wmB/bzZ4Y1Zox88Cs6v4irWUQHKU6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658878; c=relaxed/simple;
	bh=6HfLDeXWGrr1hahD7CK2vji/yd93ZAKSGmwH8bm7eoM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EY44sKd2S9FgQXfJvqIMr0nuUcXLN2zlMkqoe0RCY4/q9s6Fo+beDLPdc8ryqlYln3GQ9XnNm3t2K0V9kWCx44YW6AH0G5UbuRgcndUldt0TZKFbwiBpOvBBKpLbDopIx6eBCl7wNZtpgoEmdTFio9SIjXwonvl3T5fbaATlonY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JCrmw5rl; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCrmw5rl"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba66faa692so1157317eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 09:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770658877; x=1771263677; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vo6uNqiZhDbkjGnPA4drLy3CEMgatVf8TTxaOAYsF2M=;
        b=JCrmw5rl4ChNcWyOe4XDmThMzL0lQP+S0Um9fghkUSsmy+4OO31BLj94s9hl7jLKdF
         bzs6ku8zfALpIGhlamyLaQueCXaKdl6f/snfAuPMYSrFK8frr8Fp4jtSUYK5z208Nzr2
         oDkJE6lFwxd6D4YDoICzLENYP6cy5uPYveC/SvaTWderB83URqphm/iwZQZhcCTONoTr
         ahkWuAoMFc/LXOCPMpVZMLtmLcVOxGIMcxEqBcFgKtjYoPrQHPKDwQ/RDqsmcKTO9Arq
         Z97B7RbcogmcDodG9gzLPTmnPem6fOSJeJv+CtDNq4P/QYlMYsKsE0o4t2fXeOPhknZM
         Ntuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658877; x=1771263677;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vo6uNqiZhDbkjGnPA4drLy3CEMgatVf8TTxaOAYsF2M=;
        b=OQzkIOGfhvcqmH13Ftq3EAAwzc20HJR2NkfsEbs/j/4j/mgJ+cbKHcamj99soS+kej
         O3knIG/+/ZYWAbAlQhAaXTp6ZDXVhu1rO+XgwdCeyMVgM45y4qUf3DD2iJT1Rn6WJs/0
         BUqOoQVFfe02ncnchAT6HKX31xOFuYkhnvH2LYg7QfK6ixL2BfxryrYx5/cuYz28MSGa
         xOrw9DVH7g+wCHc1tT5jroguN0ODcqGmJiPP/oDpCdDtb8L/+tvaE9YFyO/c89lke3Vc
         8xQRVISPZB95F372TO5D7k66/7rzC86gM3IojygCz1eKYNqqb9IDkWXKRb+WR8Nh8B5a
         ZYeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIbOpVXoe2GoDLN/PNjOzMSfceDelVGGDMPcIZj/mSIbP1QckWDIGA0Ba3heHKeXVP0vWg9uSsRKwlZhL/XBWw@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk2aBEw69sihN/RWqtfDxI+ASc9kFBvJ2WHp0fEA228irHoGvJ
	+qyxBJWFAYRWfG4nJSeI/xXqt9KKI3raaz/so15XqLor5S76BGiCKliVXQ0JJZHiQ8+Oblaw7Ll
	qwreLKatriA==
X-Received: from dlbdd35.prod.google.com ([2002:a05:7022:aa3:b0:127:1887:64c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7a6:b0:119:e56b:91ec
 with SMTP id a92af1059eb24-12703ff203amr4475049c88.29.1770658877004; Mon, 09
 Feb 2026 09:41:17 -0800 (PST)
Date: Mon,  9 Feb 2026 09:40:23 -0800
In-Reply-To: <20260209174032.4142096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209174032.4142096-17-irogers@google.com>
Subject: [PATCH v1 16/25] perf inject: Don't pass evsel with sample
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
evsel as well.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c        | 37 +++++++++++-------------------
 tools/perf/util/synthetic-events.c |  9 ++++----
 tools/perf/util/synthetic-events.h |  2 --
 3 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 016ad84ac4ab..66038d68277e 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -146,14 +146,12 @@ struct event_entry {
 static int tool__inject_build_id(const struct perf_tool *tool,
 				 struct perf_sample *sample,
 				 struct machine *machine,
-				 const struct evsel *evsel,
 				 __u16 misc,
 				 const char *filename,
 				 struct dso *dso, u32 flags);
 static int tool__inject_mmap2_build_id(const struct perf_tool *tool,
 				      struct perf_sample *sample,
 				      struct machine *machine,
-				      const struct evsel *evsel,
 				      __u16 misc,
 				      __u32 pid, __u32 tid,
 				      __u64 start, __u64 len, __u64 pgoff,
@@ -357,7 +355,6 @@ perf_inject__cut_auxtrace_sample(struct perf_inject *inject,
 typedef int (*inject_handler)(const struct perf_tool *tool,
 			      union perf_event *event,
 			      struct perf_sample *sample,
-			      struct evsel *evsel,
 			      struct machine *machine);
 
 static int perf_event__repipe_sample(const struct perf_tool *tool,
@@ -370,7 +367,7 @@ static int perf_event__repipe_sample(const struct perf_tool *tool,
 
 	if (evsel && evsel->handler) {
 		inject_handler f = evsel->handler;
-		return f(tool, event, sample, evsel, machine);
+		return f(tool, event, sample, machine);
 	}
 
 	build_id__mark_dso_hit(tool, event, sample, machine);
@@ -584,11 +581,14 @@ static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
 		}
 
 		if (dso && !dso__hit(dso)) {
-			struct evsel *evsel = evlist__event2evsel(inject->session->evlist, event);
+			struct evsel *evsel = sample->evsel;
+
+			if (!evsel)
+				evlist__event2evsel(inject->session->evlist, event);
 
 			if (evsel) {
 				dso__set_hit(dso);
-				tool__inject_build_id(tool, sample, machine, evsel,
+				tool__inject_build_id(tool, sample, machine,
 						      /*misc=*/sample->cpumode,
 						      filename, dso, flags);
 			}
@@ -622,7 +622,7 @@ static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
 			dso_sought = true;
 		}
 		if (evsel && dso &&
-		    !tool__inject_mmap2_build_id(tool, sample, machine, evsel,
+		    !tool__inject_mmap2_build_id(tool, sample, machine,
 						 sample->cpumode | PERF_RECORD_MISC_MMAP_BUILD_ID,
 						 pid, tid, start, len, pgoff,
 						 dso,
@@ -836,7 +836,6 @@ static bool perf_inject__lookup_known_build_id(struct perf_inject *inject,
 static int tool__inject_build_id(const struct perf_tool *tool,
 				 struct perf_sample *sample,
 				 struct machine *machine,
-				 const struct evsel *evsel,
 				 __u16 misc,
 				 const char *filename,
 				 struct dso *dso, u32 flags)
@@ -860,7 +859,7 @@ static int tool__inject_build_id(const struct perf_tool *tool,
 
 	err = perf_event__synthesize_build_id(tool, sample, machine,
 					      perf_event__repipe,
-					      evsel, misc, dso__bid(dso),
+					      misc, dso__bid(dso),
 					      filename);
 	if (err) {
 		pr_err("Can't synthesize build_id event for %s\n", filename);
@@ -873,7 +872,6 @@ static int tool__inject_build_id(const struct perf_tool *tool,
 static int tool__inject_mmap2_build_id(const struct perf_tool *tool,
 				       struct perf_sample *sample,
 				       struct machine *machine,
-				       const struct evsel *evsel,
 				       __u16 misc,
 				       __u32 pid, __u32 tid,
 				       __u64 start, __u64 len, __u64 pgoff,
@@ -896,7 +894,6 @@ static int tool__inject_mmap2_build_id(const struct perf_tool *tool,
 
 	err = perf_event__synthesize_mmap2_build_id(tool, sample, machine,
 						    perf_event__repipe,
-						    evsel,
 						    misc, pid, tid,
 						    start, len, pgoff,
 						    dso__bid(dso),
@@ -913,7 +910,6 @@ static int mark_dso_hit(const struct perf_inject *inject,
 			const struct perf_tool *tool,
 			struct perf_sample *sample,
 			struct machine *machine,
-			const struct evsel *mmap_evsel,
 			struct map *map, bool sample_in_dso)
 {
 	struct dso *dso;
@@ -943,7 +939,7 @@ static int mark_dso_hit(const struct perf_inject *inject,
 		if (dso && !dso__hit(dso)) {
 			dso__set_hit(dso);
 			tool__inject_build_id(tool, sample, machine,
-					     mmap_evsel, misc, dso__long_name(dso), dso,
+					     misc, dso__long_name(dso), dso,
 					     map__flags(map));
 		}
 	} else if (inject->build_id_style == BID_RWS__MMAP2_BUILDID_LAZY) {
@@ -955,7 +951,6 @@ static int mark_dso_hit(const struct perf_inject *inject,
 			map__set_hit(map);
 			perf_event__synthesize_mmap2_build_id(tool, sample, machine,
 								perf_event__repipe,
-								mmap_evsel,
 								misc,
 								sample->pid, sample->tid,
 								map__start(map),
@@ -975,7 +970,6 @@ struct mark_dso_hit_args {
 	const struct perf_tool *tool;
 	struct perf_sample *sample;
 	struct machine *machine;
-	const struct evsel *mmap_evsel;
 };
 
 static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
@@ -984,7 +978,7 @@ static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
 	struct map *map = node->ms.map;
 
 	return mark_dso_hit(args->inject, args->tool, args->sample, args->machine,
-			    args->mmap_evsel, map, /*sample_in_dso=*/false);
+			    map, /*sample_in_dso=*/false);
 }
 
 static int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *event,
@@ -1002,7 +996,6 @@ static int perf_event__inject_buildid(const struct perf_tool *tool, union perf_e
 		 */
 		.sample = sample,
 		.machine = machine,
-		.mmap_evsel = inject__mmap_evsel(inject),
 	};
 	struct evsel *saved_evsel = sample->evsel;
 
@@ -1015,7 +1008,7 @@ static int perf_event__inject_buildid(const struct perf_tool *tool, union perf_e
 	}
 
 	if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
-		mark_dso_hit(inject, tool, sample, machine, args.mmap_evsel, al.map,
+		mark_dso_hit(inject, tool, sample, machine, al.map,
 			     /*sample_in_dso=*/true);
 	}
 
@@ -1033,7 +1026,6 @@ static int perf_event__inject_buildid(const struct perf_tool *tool, union perf_e
 static int perf_inject__sched_process_exit(const struct perf_tool *tool,
 					   union perf_event *event __maybe_unused,
 					   struct perf_sample *sample,
-					   struct evsel *evsel __maybe_unused,
 					   struct machine *machine __maybe_unused)
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
@@ -1053,13 +1045,12 @@ static int perf_inject__sched_process_exit(const struct perf_tool *tool,
 static int perf_inject__sched_switch(const struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample,
-				     struct evsel *evsel,
 				     struct machine *machine)
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
 	struct event_entry *ent;
 
-	perf_inject__sched_process_exit(tool, event, sample, evsel, machine);
+	perf_inject__sched_process_exit(tool, event, sample, machine);
 
 	ent = malloc(event->header.size + sizeof(struct event_entry));
 	if (ent == NULL) {
@@ -1078,13 +1069,13 @@ static int perf_inject__sched_switch(const struct perf_tool *tool,
 static int perf_inject__sched_stat(const struct perf_tool *tool,
 				   union perf_event *event __maybe_unused,
 				   struct perf_sample *sample,
-				   struct evsel *evsel,
 				   struct machine *machine)
 {
 	struct event_entry *ent;
 	union perf_event *event_sw;
 	struct perf_sample sample_sw;
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
+	struct evsel *evsel = sample->evsel;
 	u32 pid = perf_sample__intval(sample, "pid");
 	int ret;
 
@@ -1451,7 +1442,7 @@ static int synthesize_build_id(struct perf_inject *inject, struct dso *dso, pid_
 	dso__set_hit(dso);
 
 	return perf_event__synthesize_build_id(&inject->tool, &synth_sample, machine,
-					       process_build_id, inject__mmap_evsel(inject),
+					       process_build_id,
 					       /*misc=*/synth_sample.cpumode,
 					       dso__bid(dso), dso__long_name(dso));
 }
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index ef79433ebc3a..53e411cf33cc 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2247,7 +2247,6 @@ int perf_event__synthesize_build_id(const struct perf_tool *tool,
 				    struct perf_sample *sample,
 				    struct machine *machine,
 				    perf_event__handler_t process,
-				    const struct evsel *evsel,
 				    __u16 misc,
 				    const struct build_id *bid,
 				    const char *filename)
@@ -2270,12 +2269,13 @@ int perf_event__synthesize_build_id(const struct perf_tool *tool,
 	ev.build_id.header.size = len;
 	strcpy(ev.build_id.filename, filename);
 
-	if (evsel) {
+	if (sample->evsel) {
 		void *array = &ev;
 		int ret;
 
 		array += ev.header.size;
-		ret = perf_event__synthesize_id_sample(array, evsel->core.attr.sample_type, sample);
+		ret = perf_event__synthesize_id_sample(array, sample->evsel->core.attr.sample_type,
+						       sample);
 		if (ret < 0)
 			return ret;
 
@@ -2294,7 +2294,6 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 					  struct perf_sample *sample,
 					  struct machine *machine,
 					  perf_event__handler_t process,
-					  const struct evsel *evsel,
 					  __u16 misc,
 					  __u32 pid, __u32 tid,
 					  __u64 start, __u64 len, __u64 pgoff,
@@ -2334,7 +2333,7 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 
 	array = &ev;
 	array += ev.header.size;
-	ret = perf_event__synthesize_id_sample(array, evsel->core.attr.sample_type, sample);
+	ret = perf_event__synthesize_id_sample(array, sample->evsel->core.attr.sample_type, sample);
 	if (ret < 0)
 		return ret;
 
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
index b0edad0c3100..473a43a78993 100644
--- a/tools/perf/util/synthetic-events.h
+++ b/tools/perf/util/synthetic-events.h
@@ -50,7 +50,6 @@ int perf_event__synthesize_build_id(const struct perf_tool *tool,
 				    struct perf_sample *sample,
 				    struct machine *machine,
 				    perf_event__handler_t process,
-				    const struct evsel *evsel,
 				    __u16 misc,
 				    const struct build_id *bid,
 				    const char *filename);
@@ -58,7 +57,6 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 					  struct perf_sample *sample,
 					  struct machine *machine,
 					  perf_event__handler_t process,
-					  const struct evsel *evsel,
 					  __u16 misc,
 					  __u32 pid, __u32 tid,
 					  __u64 start, __u64 len, __u64 pgoff,
-- 
2.53.0.239.g8d8fc8a987-goog

