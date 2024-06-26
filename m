Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE524194127
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 20:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434211; cv=none; b=JmB3gvsnrvJdgG9HIwtH/IWrTIph++fPD5KVRCMrq2c/fKCKUsGyegmYKonbU0IGhMB0zvNW0rgdeV9MLdCi9O/NjL1yclK0opgo2hbMel1Ty7oxVRfhxsC8GxaAupSCISSnyNf29Wjho/7kgRKffFo6XITyIG1Dy2krHzRYL1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434211; c=relaxed/simple;
	bh=VKK1AIjHXi4a9HW1orZ4Igmv/qCmECDTDbqF8i0o/hw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SqFoG3JTm3M4sPFli/A8wAh2aTc9kmF4de+35HCeWcWBA3G3ZCJJJqUcJKFv7NfZRRtiuBSektXzFmCN4A248hkDlohwbsEcAcka6VPKNb/Pjr0jc3G9ISPLDihjOoz55rJ5NPK1hkZGix65oaCu4PBH5+pI4No+t7BUdjN0EOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ojt/3QI8; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ojt/3QI8"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62f43c95de4so160211647b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 13:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434208; x=1720039008; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rfG2WYmeDLtN+34chinyjKQUHIa82B2o0vCuY2npW1g=;
        b=Ojt/3QI86RK8ZgFJYPj3+XWSQn/+KeHiCxnhXnhA92Pnng4nZNAfJD2EcnOybKOpcP
         2REkg5HKDP+7oP11XC9mDwkiWQM7B0sYPOGj/YaxPpdSHXnOBQJQbslFanFRKBEWwtt0
         8nzZarBLkkkOhmNpM/Z2oXmvicCO/yCylqzR4eGWYuk/YuWZ07Ktcc9N2ek/zlNK16j7
         mvk5F/RLvrbVxxsre7eddeID1lGxfc2z3pU5b+/vprTWFbOBjqGwIU4b9rclXnUP1AYy
         +EFYQh0DrZSC1w5a7FTue2m/OJ/CS9EXBm5+C8BKkXBjahV5im/gfYSaWqUN1vAPAtyY
         bQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434208; x=1720039008;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfG2WYmeDLtN+34chinyjKQUHIa82B2o0vCuY2npW1g=;
        b=pphV2HTO154OlVTS2ZrzSvs5jv0cAYHMSgtk52FC/5dtCJMzowYi7qkbnhNeBadYPR
         8QmEpbmmEocDFdYh4v3mxJsrZBpijlzpYhH5Zmi65seQ05dUZfeXOLgK6wjkMvJSwSA+
         8Bw3TOLxyDp+9FGWzZJff1LeP87tFHr4+v+kCS1XzHIHHdKjH8Sa01Cw4p/5GEk5G8u4
         xlA0quUDcfakaPQb3YiMt/8txkkKPMrvRo9hvY/7oFzdg3e9crFa2dw8mBMTi6BPUUwU
         yhlTIydq16TNYf2NEje24Y1L95wHDRuAolWMwRBVX0efKgO91zKuU9C4STvgZKIw9XOv
         RQRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs4SWL7rYmihnyNT7lSm5lkfINsDi20NotNhywMmQ5iKj96pADScZwpr02Ga1OFiC+blXoDD/hsHdxZSIfkz4HejXaeznC0xdE4Q5cZiYDqA==
X-Gm-Message-State: AOJu0YySjM7LTLD9TWd79KHwxlN/1sJ+9H5l2yhzkihkuNiMLikU1b6D
	GtRQmgV8Hd63p0jFQOaI9vjk1hlnOiJlv8o2w6gd64v41TwYiroHrFijOQlN6V4dxHgHTF11OiV
	k76Oy2g==
X-Google-Smtp-Source: AGHT+IEkp2yaZ/d/lqoPmm5Xo17WAvc0CLH2LVlPpd6GVeWqJi0FCVKRcD9AEqusi9l6roNYlpCp3ny6E/gC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:690c:25c7:b0:62a:45ce:a268 with SMTP
 id 00721157ae682-6429db2094cmr405537b3.9.1719434207976; Wed, 26 Jun 2024
 13:36:47 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:06 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 04/27] perf tool: Move fill defaults into tool.c
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

The aim here is to eventually make perf_tool__fill_defaults an init
function so that the tools struct is more const.

Create a tool.c to go along with tool.h. Move perf_tool__fill_defaults
out of session.c into tool.c along with the default stub values. Add
perf_tool__compressed_is_stub for a test in
perf_session__process_user_event.

perf_session__process_compressed_event is only used from being default
initialized so migrate into tool.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build     |   1 +
 tools/perf/util/session.c | 310 +-----------------------------------
 tools/perf/util/session.h |   2 -
 tools/perf/util/tool.c    | 325 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/tool.h    |   4 +
 5 files changed, 331 insertions(+), 311 deletions(-)
 create mode 100644 tools/perf/util/tool.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index da64efd8718f..b412a17bae6b 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -65,6 +65,7 @@ perf-y += map.o
 perf-y += maps.o
 perf-y += pstack.o
 perf-y += session.o
+perf-y += tool.o
 perf-y += sample-raw.o
 perf-y += s390-sample-raw.o
 perf-y += amd-sample-raw.o
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 278955b8e73a..e1d38d91a1b6 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -38,68 +38,6 @@
 #include "units.h"
 #include <internal/lib.h>
 
-#ifdef HAVE_ZSTD_SUPPORT
-static int perf_session__process_compressed_event(struct perf_session *session,
-						  union perf_event *event, u64 file_offset,
-						  const char *file_path)
-{
-	void *src;
-	size_t decomp_size, src_size;
-	u64 decomp_last_rem = 0;
-	size_t mmap_len, decomp_len = session->header.env.comp_mmap_len;
-	struct decomp *decomp, *decomp_last = session->active_decomp->decomp_last;
-
-	if (decomp_last) {
-		decomp_last_rem = decomp_last->size - decomp_last->head;
-		decomp_len += decomp_last_rem;
-	}
-
-	mmap_len = sizeof(struct decomp) + decomp_len;
-	decomp = mmap(NULL, mmap_len, PROT_READ|PROT_WRITE,
-		      MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
-	if (decomp == MAP_FAILED) {
-		pr_err("Couldn't allocate memory for decompression\n");
-		return -1;
-	}
-
-	decomp->file_pos = file_offset;
-	decomp->file_path = file_path;
-	decomp->mmap_len = mmap_len;
-	decomp->head = 0;
-
-	if (decomp_last_rem) {
-		memcpy(decomp->data, &(decomp_last->data[decomp_last->head]), decomp_last_rem);
-		decomp->size = decomp_last_rem;
-	}
-
-	src = (void *)event + sizeof(struct perf_record_compressed);
-	src_size = event->pack.header.size - sizeof(struct perf_record_compressed);
-
-	decomp_size = zstd_decompress_stream(session->active_decomp->zstd_decomp, src, src_size,
-				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
-	if (!decomp_size) {
-		munmap(decomp, mmap_len);
-		pr_err("Couldn't decompress data\n");
-		return -1;
-	}
-
-	decomp->size += decomp_size;
-
-	if (session->active_decomp->decomp == NULL)
-		session->active_decomp->decomp = decomp;
-	else
-		session->active_decomp->decomp_last->next = decomp;
-
-	session->active_decomp->decomp_last = decomp;
-
-	pr_debug("decomp (B): %zd to %zd\n", src_size, decomp_size);
-
-	return 0;
-}
-#else /* !HAVE_ZSTD_SUPPORT */
-#define perf_session__process_compressed_event perf_session__process_compressed_event_stub
-#endif
-
 static int perf_session__deliver_event(struct perf_session *session,
 				       union perf_event *event,
 				       const struct perf_tool *tool,
@@ -319,251 +257,6 @@ void perf_session__delete(struct perf_session *session)
 	free(session);
 }
 
-static int process_event_synth_tracing_data_stub(struct perf_session *session
-						 __maybe_unused,
-						 union perf_event *event
-						 __maybe_unused)
-{
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static int process_event_synth_attr_stub(const struct perf_tool *tool __maybe_unused,
-					 union perf_event *event __maybe_unused,
-					 struct evlist **pevlist
-					 __maybe_unused)
-{
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static int process_event_synth_event_update_stub(const struct perf_tool *tool __maybe_unused,
-						 union perf_event *event __maybe_unused,
-						 struct evlist **pevlist
-						 __maybe_unused)
-{
-	if (dump_trace)
-		perf_event__fprintf_event_update(event, stdout);
-
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static int process_event_sample_stub(const struct perf_tool *tool __maybe_unused,
-				     union perf_event *event __maybe_unused,
-				     struct perf_sample *sample __maybe_unused,
-				     struct evsel *evsel __maybe_unused,
-				     struct machine *machine __maybe_unused)
-{
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static int process_event_stub(const struct perf_tool *tool __maybe_unused,
-			      union perf_event *event __maybe_unused,
-			      struct perf_sample *sample __maybe_unused,
-			      struct machine *machine __maybe_unused)
-{
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static int process_finished_round_stub(const struct perf_tool *tool __maybe_unused,
-				       union perf_event *event __maybe_unused,
-				       struct ordered_events *oe __maybe_unused)
-{
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static int skipn(int fd, off_t n)
-{
-	char buf[4096];
-	ssize_t ret;
-
-	while (n > 0) {
-		ret = read(fd, buf, min(n, (off_t)sizeof(buf)));
-		if (ret <= 0)
-			return ret;
-		n -= ret;
-	}
-
-	return 0;
-}
-
-static s64 process_event_auxtrace_stub(struct perf_session *session __maybe_unused,
-				       union perf_event *event)
-{
-	dump_printf(": unhandled!\n");
-	if (perf_data__is_pipe(session->data))
-		skipn(perf_data__fd(session->data), event->auxtrace.size);
-	return event->auxtrace.size;
-}
-
-static int process_event_op2_stub(struct perf_session *session __maybe_unused,
-				  union perf_event *event __maybe_unused)
-{
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-
-static
-int process_event_thread_map_stub(struct perf_session *session __maybe_unused,
-				  union perf_event *event __maybe_unused)
-{
-	if (dump_trace)
-		perf_event__fprintf_thread_map(event, stdout);
-
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static
-int process_event_cpu_map_stub(struct perf_session *session __maybe_unused,
-			       union perf_event *event __maybe_unused)
-{
-	if (dump_trace)
-		perf_event__fprintf_cpu_map(event, stdout);
-
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static
-int process_event_stat_config_stub(struct perf_session *session __maybe_unused,
-				   union perf_event *event __maybe_unused)
-{
-	if (dump_trace)
-		perf_event__fprintf_stat_config(event, stdout);
-
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static int process_stat_stub(struct perf_session *perf_session __maybe_unused,
-			     union perf_event *event)
-{
-	if (dump_trace)
-		perf_event__fprintf_stat(event, stdout);
-
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static int process_stat_round_stub(struct perf_session *perf_session __maybe_unused,
-				   union perf_event *event)
-{
-	if (dump_trace)
-		perf_event__fprintf_stat_round(event, stdout);
-
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static int process_event_time_conv_stub(struct perf_session *perf_session __maybe_unused,
-					union perf_event *event)
-{
-	if (dump_trace)
-		perf_event__fprintf_time_conv(event, stdout);
-
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static int perf_session__process_compressed_event_stub(struct perf_session *session __maybe_unused,
-						       union perf_event *event __maybe_unused,
-						       u64 file_offset __maybe_unused,
-						       const char *file_path __maybe_unused)
-{
-       dump_printf(": unhandled!\n");
-       return 0;
-}
-
-void perf_tool__fill_defaults(struct perf_tool *tool)
-{
-	if (tool->sample == NULL)
-		tool->sample = process_event_sample_stub;
-	if (tool->mmap == NULL)
-		tool->mmap = process_event_stub;
-	if (tool->mmap2 == NULL)
-		tool->mmap2 = process_event_stub;
-	if (tool->comm == NULL)
-		tool->comm = process_event_stub;
-	if (tool->namespaces == NULL)
-		tool->namespaces = process_event_stub;
-	if (tool->cgroup == NULL)
-		tool->cgroup = process_event_stub;
-	if (tool->fork == NULL)
-		tool->fork = process_event_stub;
-	if (tool->exit == NULL)
-		tool->exit = process_event_stub;
-	if (tool->lost == NULL)
-		tool->lost = perf_event__process_lost;
-	if (tool->lost_samples == NULL)
-		tool->lost_samples = perf_event__process_lost_samples;
-	if (tool->aux == NULL)
-		tool->aux = perf_event__process_aux;
-	if (tool->itrace_start == NULL)
-		tool->itrace_start = perf_event__process_itrace_start;
-	if (tool->context_switch == NULL)
-		tool->context_switch = perf_event__process_switch;
-	if (tool->ksymbol == NULL)
-		tool->ksymbol = perf_event__process_ksymbol;
-	if (tool->bpf == NULL)
-		tool->bpf = perf_event__process_bpf;
-	if (tool->text_poke == NULL)
-		tool->text_poke = perf_event__process_text_poke;
-	if (tool->aux_output_hw_id == NULL)
-		tool->aux_output_hw_id = perf_event__process_aux_output_hw_id;
-	if (tool->read == NULL)
-		tool->read = process_event_sample_stub;
-	if (tool->throttle == NULL)
-		tool->throttle = process_event_stub;
-	if (tool->unthrottle == NULL)
-		tool->unthrottle = process_event_stub;
-	if (tool->attr == NULL)
-		tool->attr = process_event_synth_attr_stub;
-	if (tool->event_update == NULL)
-		tool->event_update = process_event_synth_event_update_stub;
-	if (tool->tracing_data == NULL)
-		tool->tracing_data = process_event_synth_tracing_data_stub;
-	if (tool->build_id == NULL)
-		tool->build_id = process_event_op2_stub;
-	if (tool->finished_round == NULL) {
-		if (tool->ordered_events)
-			tool->finished_round = perf_event__process_finished_round;
-		else
-			tool->finished_round = process_finished_round_stub;
-	}
-	if (tool->id_index == NULL)
-		tool->id_index = process_event_op2_stub;
-	if (tool->auxtrace_info == NULL)
-		tool->auxtrace_info = process_event_op2_stub;
-	if (tool->auxtrace == NULL)
-		tool->auxtrace = process_event_auxtrace_stub;
-	if (tool->auxtrace_error == NULL)
-		tool->auxtrace_error = process_event_op2_stub;
-	if (tool->thread_map == NULL)
-		tool->thread_map = process_event_thread_map_stub;
-	if (tool->cpu_map == NULL)
-		tool->cpu_map = process_event_cpu_map_stub;
-	if (tool->stat_config == NULL)
-		tool->stat_config = process_event_stat_config_stub;
-	if (tool->stat == NULL)
-		tool->stat = process_stat_stub;
-	if (tool->stat_round == NULL)
-		tool->stat_round = process_stat_round_stub;
-	if (tool->time_conv == NULL)
-		tool->time_conv = process_event_time_conv_stub;
-	if (tool->feature == NULL)
-		tool->feature = process_event_op2_stub;
-	if (tool->compressed == NULL)
-		tool->compressed = perf_session__process_compressed_event;
-	if (tool->finished_init == NULL)
-		tool->finished_init = process_event_op2_stub;
-}
-
 static void swap_sample_id_all(union perf_event *event, void *data)
 {
 	void *end = (void *) event + event->header.size;
@@ -1672,8 +1365,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	int fd = perf_data__fd(session->data);
 	int err;
 
-	if (event->header.type != PERF_RECORD_COMPRESSED ||
-	    tool->compressed == perf_session__process_compressed_event_stub)
+	if (event->header.type != PERF_RECORD_COMPRESSED || perf_tool__compressed_is_stub(tool))
 		dump_event(session->evlist, event, file_offset, &sample, file_path);
 
 	/* These events are processed right away */
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index a298de3c85d8..9c9c531052fd 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -92,8 +92,6 @@ int perf_session__process_events(struct perf_session *session);
 int perf_session__queue_event(struct perf_session *s, union perf_event *event,
 			      u64 timestamp, u64 file_offset, const char *file_path);
 
-void perf_tool__fill_defaults(struct perf_tool *tool);
-
 int perf_session__resolve_callchain(struct perf_session *session,
 				    struct evsel *evsel,
 				    struct thread *thread,
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
new file mode 100644
index 000000000000..17219ecb8fa6
--- /dev/null
+++ b/tools/perf/util/tool.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "data.h"
+#include "debug.h"
+#include "header.h"
+#include "session.h"
+#include "stat.h"
+#include "tool.h"
+#include "tsc.h"
+#include <sys/mman.h>
+#include <unistd.h>
+
+#ifdef HAVE_ZSTD_SUPPORT
+static int perf_session__process_compressed_event(struct perf_session *session,
+						  union perf_event *event, u64 file_offset,
+						  const char *file_path)
+{
+	void *src;
+	size_t decomp_size, src_size;
+	u64 decomp_last_rem = 0;
+	size_t mmap_len, decomp_len = session->header.env.comp_mmap_len;
+	struct decomp *decomp, *decomp_last = session->active_decomp->decomp_last;
+
+	if (decomp_last) {
+		decomp_last_rem = decomp_last->size - decomp_last->head;
+		decomp_len += decomp_last_rem;
+	}
+
+	mmap_len = sizeof(struct decomp) + decomp_len;
+	decomp = mmap(NULL, mmap_len, PROT_READ|PROT_WRITE,
+		      MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+	if (decomp == MAP_FAILED) {
+		pr_err("Couldn't allocate memory for decompression\n");
+		return -1;
+	}
+
+	decomp->file_pos = file_offset;
+	decomp->file_path = file_path;
+	decomp->mmap_len = mmap_len;
+	decomp->head = 0;
+
+	if (decomp_last_rem) {
+		memcpy(decomp->data, &(decomp_last->data[decomp_last->head]), decomp_last_rem);
+		decomp->size = decomp_last_rem;
+	}
+
+	src = (void *)event + sizeof(struct perf_record_compressed);
+	src_size = event->pack.header.size - sizeof(struct perf_record_compressed);
+
+	decomp_size = zstd_decompress_stream(session->active_decomp->zstd_decomp, src, src_size,
+				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
+	if (!decomp_size) {
+		munmap(decomp, mmap_len);
+		pr_err("Couldn't decompress data\n");
+		return -1;
+	}
+
+	decomp->size += decomp_size;
+
+	if (session->active_decomp->decomp == NULL)
+		session->active_decomp->decomp = decomp;
+	else
+		session->active_decomp->decomp_last->next = decomp;
+
+	session->active_decomp->decomp_last = decomp;
+
+	pr_debug("decomp (B): %zd to %zd\n", src_size, decomp_size);
+
+	return 0;
+}
+#endif
+
+static int process_event_synth_tracing_data_stub(struct perf_session *session
+						 __maybe_unused,
+						 union perf_event *event
+						 __maybe_unused)
+{
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static int process_event_synth_attr_stub(const struct perf_tool *tool __maybe_unused,
+					 union perf_event *event __maybe_unused,
+					 struct evlist **pevlist
+					 __maybe_unused)
+{
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static int process_event_synth_event_update_stub(const struct perf_tool *tool __maybe_unused,
+						 union perf_event *event __maybe_unused,
+						 struct evlist **pevlist
+						 __maybe_unused)
+{
+	if (dump_trace)
+		perf_event__fprintf_event_update(event, stdout);
+
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static int process_event_sample_stub(const struct perf_tool *tool __maybe_unused,
+				     union perf_event *event __maybe_unused,
+				     struct perf_sample *sample __maybe_unused,
+				     struct evsel *evsel __maybe_unused,
+				     struct machine *machine __maybe_unused)
+{
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static int process_event_stub(const struct perf_tool *tool __maybe_unused,
+			      union perf_event *event __maybe_unused,
+			      struct perf_sample *sample __maybe_unused,
+			      struct machine *machine __maybe_unused)
+{
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static int process_finished_round_stub(const struct perf_tool *tool __maybe_unused,
+				       union perf_event *event __maybe_unused,
+				       struct ordered_events *oe __maybe_unused)
+{
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static int skipn(int fd, off_t n)
+{
+	char buf[4096];
+	ssize_t ret;
+
+	while (n > 0) {
+		ret = read(fd, buf, min(n, (off_t)sizeof(buf)));
+		if (ret <= 0)
+			return ret;
+		n -= ret;
+	}
+
+	return 0;
+}
+
+static s64 process_event_auxtrace_stub(struct perf_session *session __maybe_unused,
+				       union perf_event *event)
+{
+	dump_printf(": unhandled!\n");
+	if (perf_data__is_pipe(session->data))
+		skipn(perf_data__fd(session->data), event->auxtrace.size);
+	return event->auxtrace.size;
+}
+
+static int process_event_op2_stub(struct perf_session *session __maybe_unused,
+				  union perf_event *event __maybe_unused)
+{
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+
+static
+int process_event_thread_map_stub(struct perf_session *session __maybe_unused,
+				  union perf_event *event __maybe_unused)
+{
+	if (dump_trace)
+		perf_event__fprintf_thread_map(event, stdout);
+
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static
+int process_event_cpu_map_stub(struct perf_session *session __maybe_unused,
+			       union perf_event *event __maybe_unused)
+{
+	if (dump_trace)
+		perf_event__fprintf_cpu_map(event, stdout);
+
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static
+int process_event_stat_config_stub(struct perf_session *session __maybe_unused,
+				   union perf_event *event __maybe_unused)
+{
+	if (dump_trace)
+		perf_event__fprintf_stat_config(event, stdout);
+
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static int process_stat_stub(struct perf_session *perf_session __maybe_unused,
+			     union perf_event *event)
+{
+	if (dump_trace)
+		perf_event__fprintf_stat(event, stdout);
+
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static int process_stat_round_stub(struct perf_session *perf_session __maybe_unused,
+				   union perf_event *event)
+{
+	if (dump_trace)
+		perf_event__fprintf_stat_round(event, stdout);
+
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static int process_event_time_conv_stub(struct perf_session *perf_session __maybe_unused,
+					union perf_event *event)
+{
+	if (dump_trace)
+		perf_event__fprintf_time_conv(event, stdout);
+
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static int perf_session__process_compressed_event_stub(struct perf_session *session __maybe_unused,
+						       union perf_event *event __maybe_unused,
+						       u64 file_offset __maybe_unused,
+						       const char *file_path __maybe_unused)
+{
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+void perf_tool__fill_defaults(struct perf_tool *tool)
+{
+	if (tool->sample == NULL)
+		tool->sample = process_event_sample_stub;
+	if (tool->mmap == NULL)
+		tool->mmap = process_event_stub;
+	if (tool->mmap2 == NULL)
+		tool->mmap2 = process_event_stub;
+	if (tool->comm == NULL)
+		tool->comm = process_event_stub;
+	if (tool->namespaces == NULL)
+		tool->namespaces = process_event_stub;
+	if (tool->cgroup == NULL)
+		tool->cgroup = process_event_stub;
+	if (tool->fork == NULL)
+		tool->fork = process_event_stub;
+	if (tool->exit == NULL)
+		tool->exit = process_event_stub;
+	if (tool->lost == NULL)
+		tool->lost = perf_event__process_lost;
+	if (tool->lost_samples == NULL)
+		tool->lost_samples = perf_event__process_lost_samples;
+	if (tool->aux == NULL)
+		tool->aux = perf_event__process_aux;
+	if (tool->itrace_start == NULL)
+		tool->itrace_start = perf_event__process_itrace_start;
+	if (tool->context_switch == NULL)
+		tool->context_switch = perf_event__process_switch;
+	if (tool->ksymbol == NULL)
+		tool->ksymbol = perf_event__process_ksymbol;
+	if (tool->bpf == NULL)
+		tool->bpf = perf_event__process_bpf;
+	if (tool->text_poke == NULL)
+		tool->text_poke = perf_event__process_text_poke;
+	if (tool->aux_output_hw_id == NULL)
+		tool->aux_output_hw_id = perf_event__process_aux_output_hw_id;
+	if (tool->read == NULL)
+		tool->read = process_event_sample_stub;
+	if (tool->throttle == NULL)
+		tool->throttle = process_event_stub;
+	if (tool->unthrottle == NULL)
+		tool->unthrottle = process_event_stub;
+	if (tool->attr == NULL)
+		tool->attr = process_event_synth_attr_stub;
+	if (tool->event_update == NULL)
+		tool->event_update = process_event_synth_event_update_stub;
+	if (tool->tracing_data == NULL)
+		tool->tracing_data = process_event_synth_tracing_data_stub;
+	if (tool->build_id == NULL)
+		tool->build_id = process_event_op2_stub;
+	if (tool->finished_round == NULL) {
+		if (tool->ordered_events)
+			tool->finished_round = perf_event__process_finished_round;
+		else
+			tool->finished_round = process_finished_round_stub;
+	}
+	if (tool->id_index == NULL)
+		tool->id_index = process_event_op2_stub;
+	if (tool->auxtrace_info == NULL)
+		tool->auxtrace_info = process_event_op2_stub;
+	if (tool->auxtrace == NULL)
+		tool->auxtrace = process_event_auxtrace_stub;
+	if (tool->auxtrace_error == NULL)
+		tool->auxtrace_error = process_event_op2_stub;
+	if (tool->thread_map == NULL)
+		tool->thread_map = process_event_thread_map_stub;
+	if (tool->cpu_map == NULL)
+		tool->cpu_map = process_event_cpu_map_stub;
+	if (tool->stat_config == NULL)
+		tool->stat_config = process_event_stat_config_stub;
+	if (tool->stat == NULL)
+		tool->stat = process_stat_stub;
+	if (tool->stat_round == NULL)
+		tool->stat_round = process_stat_round_stub;
+	if (tool->time_conv == NULL)
+		tool->time_conv = process_event_time_conv_stub;
+	if (tool->feature == NULL)
+		tool->feature = process_event_op2_stub;
+	if (tool->compressed == NULL) {
+#ifdef HAVE_ZSTD_SUPPORT
+		tool->compressed = perf_session__process_compressed_event;
+#else
+		tool->compressed = perf_session__process_compressed_event_stub;
+#endif
+	}
+	if (tool->finished_init == NULL)
+		tool->finished_init = process_event_op2_stub;
+}
+
+bool perf_tool__compressed_is_stub(const struct perf_tool *tool)
+{
+	return tool->compressed == perf_session__process_compressed_event_stub;
+}
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index b192d44fe91f..7913b698033a 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -88,4 +88,8 @@ struct perf_tool {
 	enum show_feature_header show_feat_hdr;
 };
 
+void perf_tool__fill_defaults(struct perf_tool *tool);
+
+bool perf_tool__compressed_is_stub(const struct perf_tool *tool);
+
 #endif /* __PERF_TOOL_H */
-- 
2.45.2.741.gdbec12cfda-goog

