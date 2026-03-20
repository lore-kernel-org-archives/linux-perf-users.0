Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04386375AAB
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994169; cv=none; b=eWD4nhzQcjesbd3oWrvHhQkKVEJMnJ4DHPxlud6EV8Tvtr5liLVqWnGInARrCPolW5Cx3syGOJGXZUfF99fsqRcMFkp9TmxLoF85BOd1xNySMao6IUrFr6MfEn3UDO2HtvXpDlvXan+ipNKu6ss91DRPshh6B/jYQbDfULldjuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994169; c=relaxed/simple;
	bh=3n96E9V/4QhhKs4hWAjfN7C8Br55p1AJ1VBaBO3fk2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G4qOlaDzPjlMW8cEYMp1Y6l06bcOlVKHPCjAAb5TcLAIkJxA41GOHaiQ9R+2CzbIYNOcMaKbwKBzjgl+tQEaX6GCBXxQpJ98ubBgAR0QSGfMukX7uVhEqU1q/QyS9iRonLLtWcINHnreq3VTMVD5i0qTIsnVZnwoR5WPXZ+bVoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GgQ+lcYG; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GgQ+lcYG"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so290588eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 01:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773994167; x=1774598967; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=imsNgYZdY1tqbGGPfOlwwoZDMdJ12rSBPWNrXkSgWrs=;
        b=GgQ+lcYG4OBM/IOY2NP+jTdxOCRh8YVAuZUHEmq53Ec8171LwkYyZRGQh48Lp8myiY
         Ro+X4xBs9YtE/mV5wfoHan5wD+aR7c1AV7UxcWU7i9vtR/VQmACdoMATaUkcb9jIKzUQ
         K3wV02Gi6ZCeyXlG/BUs9pOlS6KvKHNAGRUfemar9OVs5MEfZN3lyt6sEoR/UZ/Tf2pz
         9CD9/mcbMmpewS4/azGvNbPAF50B107AQMZYBvsQFxBxdq9PkJKmech1j5FpLea+Pz5W
         aa8wnWrouEx6LUMdVT/Og+TTVBD6PCJk+1k2FfwDE4enbDdh+G1l1ku1FOV+QPv2UAQ5
         Phag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773994167; x=1774598967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=imsNgYZdY1tqbGGPfOlwwoZDMdJ12rSBPWNrXkSgWrs=;
        b=VNbCFJ2PjQ0cx/BRrlGvOnfgZs/FEWV7xcCHIM5DiCsggShaarIg3CGj3IPvpvJfYU
         sohZ25FYTDn8/anK88V6WrSEYKgfvdGGPA6eYofdNSvXpK9dFjnIThbiS3bXacqMpPeO
         /DQISGSM0J21R/MRHEFlWtYlZsBcfeBE7WTbqmKtFeTJ1njeBlouXTyA0xwNYdKdg8FC
         +2a+7B2M/Xb2PUR8to87Z9Leju6IJhk19+E9VYCGdMROmbGPBVDIDark6/D2tImX+SBE
         f4AWrRKfX8FK1pID2BDLyy89rVNUDw/Jxy6gwT7rKEOi52M9xqMEFQzA+KNBSmvYfUFI
         kbGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfJlTcUINBh/nwGvHahHSMxNZpORRjbrXFbLXFqIYb9oS8Wt7NAjBQUi0j5EWzOvRDO/gqDy+OwAI1zL51DFW6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbp9mmDzH5Ddti/voV1db1s1C2vB2ZN+24o9ZnRPA7ARhh0x2R
	kaaVPMoANnbowPdD2fq8DCxmMbInDYwJqJUGDhajh+PbnO9C0oeCGLPpxZ9MS3rhlPS4p5rkPp3
	SgaBLSjd8jg==
X-Received: from dycol10.prod.google.com ([2002:a05:7301:db8a:b0:2c0:bd37:a753])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ed06:b0:2c0:dae2:9c5f
 with SMTP id 5a478bee46e88-2c109563c3fmr1001101eec.2.1773994166967; Fri, 20
 Mar 2026 01:09:26 -0700 (PDT)
Date: Fri, 20 Mar 2026 01:08:30 -0700
In-Reply-To: <20260320080835.724836-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319232334.287517-1-irogers@google.com> <20260320080835.724836-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320080835.724836-22-irogers@google.com>
Subject: [PATCH v3 21/25] perf trace: Don't pass evsel with sample
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

The sample contains the evsel and so it is unnecessary to pass the
evsel as well. In trace__handle_event try to use the evsel from the
sample to avoid recomputation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 385a9ac2ae96..c4ec4f603d5f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2580,7 +2580,7 @@ static struct syscall *trace__find_syscall(struct trace *trace, int e_machine, i
 	return sc;
 }
 
-typedef int (*tracepoint_handler)(struct trace *trace, struct evsel *evsel,
+typedef int (*tracepoint_handler)(struct trace *trace,
 				  union perf_event *event,
 				  struct perf_sample *sample);
 
@@ -2775,10 +2775,11 @@ static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sam
 	return NULL;
 }
 
-static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
+static int trace__sys_enter(struct trace *trace,
 			    union perf_event *event __maybe_unused,
 			    struct perf_sample *sample)
 {
+	struct evsel *evsel = sample->evsel;
 	char *msg;
 	void *args;
 	int printed = 0;
@@ -2921,10 +2922,11 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
 	return sample__fprintf_callchain(sample, 38, print_opts, get_tls_callchain_cursor(), symbol_conf.bt_stop_list, trace->output);
 }
 
-static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
+static int trace__sys_exit(struct trace *trace,
 			   union perf_event *event __maybe_unused,
 			   struct perf_sample *sample)
 {
+	struct evsel *evsel = sample->evsel;
 	long ret;
 	u64 duration = 0;
 	bool duration_calculated = false;
@@ -3059,7 +3061,7 @@ errno_print: {
 	return err;
 }
 
-static int trace__vfs_getname(struct trace *trace, struct evsel *evsel __maybe_unused,
+static int trace__vfs_getname(struct trace *trace,
 			      union perf_event *event __maybe_unused,
 			      struct perf_sample *sample)
 {
@@ -3120,7 +3122,7 @@ static int trace__vfs_getname(struct trace *trace, struct evsel *evsel __maybe_u
 	return 0;
 }
 
-static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
+static int trace__sched_stat_runtime(struct trace *trace,
 				     union perf_event *event __maybe_unused,
 				     struct perf_sample *sample)
 {
@@ -3142,7 +3144,7 @@ static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
 
 out_dump:
 	fprintf(trace->output, "%s: comm=%s,pid=%u,runtime=%" PRIu64 ",vruntime=%" PRIu64 ")\n",
-	       evsel->name,
+	       sample->evsel->name,
 	       perf_sample__strval(sample, "comm"),
 	       (pid_t)perf_sample__intval(sample, "pid"),
 	       runtime,
@@ -3253,10 +3255,11 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
 	return fprintf(trace->output, "%.*s", (int)printed, bf);
 }
 
-static int trace__event_handler(struct trace *trace, struct evsel *evsel,
+static int trace__event_handler(struct trace *trace,
 				union perf_event *event __maybe_unused,
 				struct perf_sample *sample)
 {
+	struct evsel *evsel = sample->evsel;
 	struct thread *thread;
 	int callchain_ret = 0;
 
@@ -3444,7 +3447,6 @@ static int trace__pgfault(struct trace *trace,
 }
 
 static void trace__set_base_time(struct trace *trace,
-				 struct evsel *evsel,
 				 struct perf_sample *sample)
 {
 	/*
@@ -3456,7 +3458,7 @@ static void trace__set_base_time(struct trace *trace,
 	 * appears in our event stream (vfs_getname comes to mind).
 	 */
 	if (trace->base_time == 0 && !trace->full_time &&
-	    (evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
+	    (sample->evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
 		trace->base_time = sample->time;
 }
 
@@ -3476,11 +3478,11 @@ static int trace__process_sample(const struct perf_tool *tool,
 	if (thread && thread__is_filtered(thread))
 		goto out;
 
-	trace__set_base_time(trace, evsel, sample);
+	trace__set_base_time(trace, sample);
 
 	if (handler) {
 		++trace->nr_events;
-		handler(trace, evsel, event, sample);
+		handler(trace, event, sample);
 	}
 out:
 	thread__put(thread);
@@ -3622,14 +3624,16 @@ static void evlist__free_syscall_tp_fields(struct evlist *evlist)
 static void trace__handle_event(struct trace *trace, union perf_event *event, struct perf_sample *sample)
 {
 	const u32 type = event->header.type;
-	struct evsel *evsel;
+	struct evsel *evsel = sample->evsel;
 
 	if (type != PERF_RECORD_SAMPLE) {
 		trace__process_event(trace, trace->host, event, sample);
 		return;
 	}
 
-	evsel = evlist__id2evsel(trace->evlist, sample->id);
+	if (evsel == NULL)
+		evsel = evlist__id2evsel(trace->evlist, sample->id);
+
 	if (evsel == NULL) {
 		fprintf(trace->output, "Unknown tp ID %" PRIu64 ", skipping...\n", sample->id);
 		return;
@@ -3638,7 +3642,7 @@ static void trace__handle_event(struct trace *trace, union perf_event *event, st
 	if (evswitch__discard(&trace->evswitch, evsel))
 		return;
 
-	trace__set_base_time(trace, evsel, sample);
+	trace__set_base_time(trace, sample);
 
 	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT &&
 	    sample->raw_data == NULL) {
@@ -3647,7 +3651,7 @@ static void trace__handle_event(struct trace *trace, union perf_event *event, st
 		       sample->cpu, sample->raw_size);
 	} else {
 		tracepoint_handler handler = evsel->handler;
-		handler(trace, evsel, event, sample);
+		handler(trace, event, sample);
 	}
 
 	if (trace->nr_events_printed >= trace->max_events && trace->max_events != ULONG_MAX)
-- 
2.53.0.959.g497ff81fa9-goog

