Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D543039478D
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622996; cv=none; b=K8x8ZXBTcc0uz9runYqzNsojVFJUJF/BC6Lb+iq8a+pXF3gXhhGzDtAVHWPTiQLF6nAD6NIgvvOlMBJeMuoE0NSpqlqN3M5y7jRKF37QGQuAbHjYm0JMAY3pmQut61im3s4kojNJzr5zPOxRcb/4pJCNroUSYhQqsJ+jB7kMpVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622996; c=relaxed/simple;
	bh=DikkUMdXss2dvZ76KwzXDiG41+v6I1NFAKWSIQqaku8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tqcLsZbZO3bIS020cV2kbEA2l9tmVp1Y6ce4B9bEq8qBEuaPFXy93V2ZHmVPwxXO2v7bFrKJhlAPOai46i18KpD52lDIRFEUlSJRl3zlpp1/qlgXkmkI8xKvQyBk3vz2njVTyBmFQzVKImEL9TEeApklFHpc1a2B8DI6/pdUSLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oYJ078ZF; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYJ078ZF"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2eebb099efbso8286705eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 14:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778622993; x=1779227793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zGr5and8X7kHHPpwe03XWFWLC6mW0y8J+B5ESeLIKl8=;
        b=oYJ078ZFzrRbNJ4FeNfi+3TDhkclM974lI9SjX8piKghNlrdcLyyAoLRLGDv+CE6ev
         9FwH3ex3K7IhxYsl21d6t7Mzhva+ZvhmN14VD3cgwUOUMsswnOdFAmQ+oLwCYpKKaFPB
         isue8hVldsXuIhoMWcd36u/OqAilFQTH2flwgHy4sR4WVk6qydYuS9cMm+RHvNJe4Y82
         tYhUIbujwH/5gvMax3sxHL1WfS71+Dv+DGSzRd1mE8/FzmQ9E7Hip2UsIEUwH7Gnyjx7
         rgdO/F9vRehDFncHLYHfjE6cGI7GdTUILuSY9+qMgsX0Kkj1s1EEvkGtsgybwfOryuOe
         jsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778622993; x=1779227793;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zGr5and8X7kHHPpwe03XWFWLC6mW0y8J+B5ESeLIKl8=;
        b=gPFqasuQzzoMUhGA3Oon4JVz6yWNdJp3xmJzh8nS7M+lKjFBMwWGH74sIr4vnjIPNa
         wkr7KTbKgbMmmu91ytuQ14dVAGoYe7B+Bq6neyOiY9O0qrDcXXCOh2aGE0bOqGfSQHjE
         c+iwPaC/2bj/BBKczONxsCEYpTiK4EGkrxMY2X3Qr0BkfY3DngQCZHLRraBX9DfO6PGY
         JG7NiEE1AUNH9OQxUhJtYJI82pg6jusMyJj4AX9LhXpXseUB83cCno3nFYR5Pz3TXFzo
         UH/uJbW9P464awwlCLtYwYFwbXI1jJdO2V7VxkvL7cnyqO+7d1JFLDliCdOjZ6kjRfAO
         UYOA==
X-Forwarded-Encrypted: i=1; AFNElJ8OaXjjO1GTKtVmshZsu/BEuHnJuiS5AWzHqBjcj97mlQ3i9b1pwf3nxa2jAZQ3ipCnAge64kqcvCxvlT3lQ5mE@vger.kernel.org
X-Gm-Message-State: AOJu0YxDtSRDjJF6WzsrPhz76aqNDhu548NNj+/NydJXU/l3y2LTngNf
	FVrVDmIagJSFwyixikajfKHrWMcY+C7weLxPW+E3QpZm5hVMcQauMrgYZG6zlYRHUtyCvdofOLt
	HGrsRhDRroQ==
X-Received: from dybmw18.prod.google.com ([2002:a05:7300:cd92:b0:2d8:36c2:7c59])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2907:b0:2dd:c066:bf7
 with SMTP id 5a478bee46e88-30153fc345dmr42133eec.11.1778622992713; Tue, 12
 May 2026 14:56:32 -0700 (PDT)
Date: Tue, 12 May 2026 14:56:21 -0700
In-Reply-To: <20260512215621.468685-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fXMtbO=7JMg2YvhQNbqOEFH_ze=8EifYM7bDfR945=KHA@mail.gmail.com>
 <20260512215621.468685-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512215621.468685-2-irogers@google.com>
Subject: [PATCH 2/2] perf data convert ctf: Initial babeltrace2 support
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, derek.foreman@collabora.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, mingo@redhat.com, mjeanson@efficios.com, 
	namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"

The libbabeltrace support is incomplete but as libbabeltrace is no
longer developed it is hard to debug what is happening. Add some
minimal libbabeltrace2 support that allows logging. When the support
is comparable to the libbabeltrace 1 support it'd be worth dropping
the libbabeltrace 1 support.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config        |   13 +-
 tools/perf/util/data-convert-bt.c | 1044 ++++++++++++++++++++++++-----
 tools/perf/util/data-convert.h    |    2 +-
 3 files changed, 878 insertions(+), 181 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 06d7a3f9990c..af70f9436586 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -203,6 +203,8 @@ ifdef LIBBABELTRACE_DIR
 endif
 FEATURE_CHECK_CFLAGS-libbabeltrace := $(LIBBABELTRACE_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libbabeltrace := $(LIBBABELTRACE_LDFLAGS) -lbabeltrace-ctf
+FEATURE_CHECK_CFLAGS-libbabeltrace2 := $(LIBBABELTRACE_CFLAGS)
+FEATURE_CHECK_LDFLAGS-libbabeltrace2 := $(LIBBABELTRACE_LDFLAGS) -lbabeltrace2
 
 # for linking with debug library, run like:
 # make DEBUG=1 LIBCAPSTONE_DIR=/opt/capstone/
@@ -1067,7 +1069,16 @@ ifndef NO_LIBBABELTRACE
     EXTLIBS += -lbabeltrace-ctf
     $(call detected,CONFIG_LIBBABELTRACE)
   else
-    $(warning No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev)
+    $(call feature_check,libbabeltrace2)
+    ifeq ($(feature-libbabeltrace2), 1)
+      $(info Experimental libbabeltrace2 support enabled)
+      CFLAGS += -DHAVE_LIBBABELTRACE2_SUPPORT $(LIBBABELTRACE_CFLAGS)
+      LDFLAGS += $(LIBBABELTRACE_LDFLAGS)
+      EXTLIBS += -lbabeltrace2
+      $(call detected,CONFIG_LIBBABELTRACE)
+    else
+      $(warning No libbabeltrace found, disables 'perf data' CTF format support)
+    endif
   endif
 endif
 
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 3b8f2df823a9..b16544f8b9b9 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -6,11 +6,34 @@
  * Copyright (C) 2014, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
  */
 
+#include "clockid.h"
+#include "config.h"
+#include "data-convert.h"
+#include "debug.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "header.h"
+#include "machine.h"
+#include "session.h"
+#include "tool.h"
+#include "util.h"
+#include "sample.h"
+#include "time-utils.h"
+
 #include <errno.h>
 #include <inttypes.h>
+#include <internal/lib.h>
 #include <linux/compiler.h>
+#include <linux/ctype.h>
+#include <linux/err.h>
 #include <linux/kernel.h>
+#include <linux/time64.h>
 #include <linux/zalloc.h>
+#include <perf/event.h>
+
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+#include <babeltrace2/babeltrace.h>
+#elif defined(HAVE_LIBBABELTRACE_SUPPORT)
 #include <babeltrace/ctf-writer/writer.h>
 #include <babeltrace/ctf-writer/clock.h>
 #include <babeltrace/ctf-writer/stream.h>
@@ -19,26 +42,8 @@
 #include <babeltrace/ctf-writer/event-fields.h>
 #include <babeltrace/ctf-ir/utils.h>
 #include <babeltrace/ctf/events.h>
-#include "asm/bug.h"
-#include "data-convert.h"
-#include "session.h"
-#include "debug.h"
-#include "tool.h"
-#include "evlist.h"
-#include "evsel.h"
-#include "machine.h"
-#include "config.h"
-#include <linux/ctype.h>
-#include <linux/err.h>
-#include <linux/time64.h>
-#include "util.h"
-#include "clockid.h"
-#include "util/sample.h"
-#include "util/time-utils.h"
-#include "header.h"
-
-#ifdef HAVE_LIBTRACEEVENT
-#include <event-parse.h>
+#else
+#error "Missing libbabeltrace2/libbabeltrace support"
 #endif
 
 #define pr_N(n, fmt, ...) \
@@ -47,51 +52,91 @@
 #define pr(fmt, ...)  pr_N(1, pr_fmt(fmt), ##__VA_ARGS__)
 #define pr2(fmt, ...) pr_N(2, pr_fmt(fmt), ##__VA_ARGS__)
 
-#define pr_time2(t, fmt, ...) pr_time_N(2, debug_data_convert, t, pr_fmt(fmt), ##__VA_ARGS__)
+#define STREAM_FLUSH_COUNT 100000
+#define QUEUE_SIZE	16384
+#define MAX_CPUS	4096
 
 struct evsel_priv {
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+	bt_event_class *event_class;
+#else
 	struct bt_ctf_event_class *event_class;
+#endif
 };
 
-#define MAX_CPUS	4096
-
 struct ctf_stream {
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+	bt_stream *stream;
+	bt_packet *packet;
+#else
 	struct bt_ctf_stream *stream;
+#endif
 	int cpu;
 	u32 count;
 };
 
 struct ctf_writer {
-	/* writer primitives */
-	struct bt_ctf_writer		 *writer;
 	struct ctf_stream		**stream;
 	int				  stream_cnt;
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+	/* writer primitives */
+	bt_graph *graph;
+	const bt_component_source *source;
+	const bt_component_sink *sink;
+	bt_trace_class *trace_class;
+	bt_stream_class *stream_class;
+	bt_clock_class *clock_class;
+	bt_trace *trace;
+
+	/* runtime */
+	bt_self_component_source *self_comp;
+	bt_self_message_iterator *self_iter;
+
+	/* data types */
+	struct {
+		bt_field_class *s64;
+		bt_field_class *u64;
+		bt_field_class *s32;
+		bt_field_class *u32;
+		bt_field_class *string;
+		bt_field_class *u32_hex;
+		bt_field_class *u64_hex;
+	} data;
+
+	/* event classes */
+	bt_event_class *comm_class;
+	bt_event_class *exit_class;
+	bt_event_class *fork_class;
+	bt_event_class *mmap_class;
+	bt_event_class *mmap2_class;
+#else
+	/* writer primitives */
+	struct bt_ctf_writer		 *writer;
 	struct bt_ctf_stream_class	 *stream_class;
 	struct bt_ctf_clock		 *clock;
 
 	/* data types */
-	union {
-		struct {
-			struct bt_ctf_field_type	*s64;
-			struct bt_ctf_field_type	*u64;
-			struct bt_ctf_field_type	*s32;
-			struct bt_ctf_field_type	*u32;
-			struct bt_ctf_field_type	*string;
-			struct bt_ctf_field_type	*u32_hex;
-			struct bt_ctf_field_type	*u64_hex;
-		};
-		struct bt_ctf_field_type *array[6];
+	struct {
+		struct bt_ctf_field_type	*s64;
+		struct bt_ctf_field_type	*u64;
+		struct bt_ctf_field_type	*s32;
+		struct bt_ctf_field_type	*u32;
+		struct bt_ctf_field_type	*string;
+		struct bt_ctf_field_type	*u32_hex;
+		struct bt_ctf_field_type	*u64_hex;
 	} data;
 	struct bt_ctf_event_class	*comm_class;
 	struct bt_ctf_event_class	*exit_class;
 	struct bt_ctf_event_class	*fork_class;
 	struct bt_ctf_event_class	*mmap_class;
 	struct bt_ctf_event_class	*mmap2_class;
+#endif
 };
 
 struct convert {
 	struct perf_tool	tool;
 	struct ctf_writer	writer;
+	struct perf_session	*session;
 
 	struct perf_time_interval *ptime_range;
 	int range_size;
@@ -101,11 +146,97 @@ struct convert {
 	u64			events_count;
 	u64			non_sample_count;
 	u64			skipped;
+	u64			last_ts;
 
 	/* Ordered events configured queue size. */
 	u64			queue_size;
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+	/* message queue */
+	bt_message **queue;
+	unsigned int queue_head;
+	unsigned int queue_tail;
+	unsigned int queue_mask;
+#endif
+	bool finished;
+
 };
 
+static void ctf_writer__cleanup(struct ctf_writer *cw);
+
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+static int ctf_writer__flush_queue(struct convert *c)
+{
+	bt_graph_run_once_status status = bt_graph_run_once(c->writer.graph);
+
+	if (status == BT_GRAPH_RUN_ONCE_STATUS_OK)
+		return 0;
+	if (status == BT_GRAPH_RUN_ONCE_STATUS_AGAIN)
+		return 0; /* Should retry, but let's assume made progress or empty */
+	return -1;
+}
+
+static void queue_push(struct convert *c, bt_message *msg)
+{
+	unsigned int next_head = (c->queue_head + 1) & c->queue_mask;
+
+	while (next_head == c->queue_tail) {
+		/* Queue is full, drive the graph to consume */
+		if (ctf_writer__flush_queue(c) < 0)
+			break;
+		next_head = (c->queue_head + 1) & c->queue_mask;
+	}
+
+	c->queue[c->queue_head] = msg;
+	c->queue_head = next_head;
+}
+
+static bt_message *queue_pop(struct convert *c)
+{
+	bt_message *msg;
+
+	if (c->queue_head == c->queue_tail)
+		return NULL;
+
+	msg = c->queue[c->queue_tail];
+	c->queue_tail = (c->queue_tail + 1) & c->queue_mask;
+	return msg;
+}
+
+/* Helper to set field value */
+static int value_set(bt_field *field, u64 val)
+{
+	const bt_field_class *type = bt_field_borrow_class_const(field);
+	bt_field_class_type class_type = bt_field_class_get_type(type);
+
+	if (class_type == BT_FIELD_CLASS_TYPE_UNSIGNED_INTEGER ||
+	    class_type == BT_FIELD_CLASS_TYPE_UNSIGNED_ENUMERATION) {
+		bt_field_integer_unsigned_set_value(field, val);
+	} else if (class_type == BT_FIELD_CLASS_TYPE_SIGNED_INTEGER ||
+		   class_type == BT_FIELD_CLASS_TYPE_SIGNED_ENUMERATION) {
+		bt_field_integer_signed_set_value(field, (int64_t)val);
+	} else {
+		return -1;
+	}
+	return 0;
+}
+
+static int value_set_from_type(bt_event *event, const char *name, u64 val)
+{
+	bt_field *field = bt_event_borrow_payload_field(event);
+	bt_field *member;
+
+	if (!field) {
+		pr_err("failed to find payload field\n");
+		return -1;
+	}
+	member = bt_field_structure_borrow_member_field_by_name(field, name);
+	if (!member) {
+		pr_err("failed to find payload field %s\n", name);
+		return -1;
+	}
+	return value_set(member, val);
+}
+#else
 static int value_set(struct bt_ctf_field_type *type,
 		     struct bt_ctf_event *event,
 		     const char *name, u64 val)
@@ -148,7 +279,7 @@ static int value_set(struct bt_ctf_field_type *type,
 }
 
 #define __FUNC_VALUE_SET(_name, _val_type)				\
-static __maybe_unused int value_set_##_name(struct ctf_writer *cw,	\
+static int value_set_##_name(struct ctf_writer *cw,			\
 			     struct bt_ctf_event *event,		\
 			     const char *name,				\
 			     _val_type val)				\
@@ -161,12 +292,11 @@ static __maybe_unused int value_set_##_name(struct ctf_writer *cw,	\
 
 FUNC_VALUE_SET(s32)
 FUNC_VALUE_SET(u32)
-FUNC_VALUE_SET(s64)
 FUNC_VALUE_SET(u64)
 __FUNC_VALUE_SET(u64_hex, u64)
 
 static int string_set_value(struct bt_ctf_field *field, const char *string);
-static __maybe_unused int
+static int
 value_set_string(struct ctf_writer *cw, struct bt_ctf_event *event,
 		 const char *name, const char *string)
 {
@@ -599,9 +729,14 @@ add_callchain_output_values(struct bt_ctf_event_class *event_class,
 	bt_ctf_field_type_put(len_type);
 	return ret;
 }
+#endif
 
-static int add_generic_values(struct ctf_writer *cw,
+static int add_generic_values(struct ctf_writer *cw __maybe_unused,
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+			      bt_event *event,
+#else
 			      struct bt_ctf_event *event,
+#endif
 			      struct evsel *evsel,
 			      struct perf_sample *sample)
 {
@@ -620,56 +755,90 @@ static int add_generic_values(struct ctf_writer *cw,
 	 */
 
 	if (type & PERF_SAMPLE_IP) {
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+		ret = value_set_from_type(event, "perf_ip", sample->ip);
+#else
 		ret = value_set_u64_hex(cw, event, "perf_ip", sample->ip);
+#endif
 		if (ret)
 			return -1;
 	}
 
 	if (type & PERF_SAMPLE_TID) {
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+		ret = value_set_from_type(event, "perf_tid", sample->tid);
+#else
 		ret = value_set_s32(cw, event, "perf_tid", sample->tid);
+#endif
 		if (ret)
 			return -1;
 
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+		ret = value_set_from_type(event, "perf_pid", sample->pid);
+#else
 		ret = value_set_s32(cw, event, "perf_pid", sample->pid);
+#endif
 		if (ret)
 			return -1;
 	}
 
 	if ((type & PERF_SAMPLE_ID) ||
 	    (type & PERF_SAMPLE_IDENTIFIER)) {
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+		ret = value_set_from_type(event, "perf_id", sample->id);
+#else
 		ret = value_set_u64(cw, event, "perf_id", sample->id);
+#endif
 		if (ret)
 			return -1;
 	}
 
 	if (type & PERF_SAMPLE_STREAM_ID) {
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+		ret = value_set_from_type(event, "perf_stream_id", sample->stream_id);
+#else
 		ret = value_set_u64(cw, event, "perf_stream_id", sample->stream_id);
+#endif
 		if (ret)
 			return -1;
 	}
 
 	if (type & PERF_SAMPLE_PERIOD) {
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+		ret = value_set_from_type(event, "perf_period", sample->period);
+#else
 		ret = value_set_u64(cw, event, "perf_period", sample->period);
+#endif
 		if (ret)
 			return -1;
 	}
 
 	if (type & PERF_SAMPLE_WEIGHT) {
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+		ret = value_set_from_type(event, "perf_weight", sample->weight);
+#else
 		ret = value_set_u64(cw, event, "perf_weight", sample->weight);
+#endif
 		if (ret)
 			return -1;
 	}
 
 	if (type & PERF_SAMPLE_DATA_SRC) {
-		ret = value_set_u64(cw, event, "perf_data_src",
-				sample->data_src);
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+		ret = value_set_from_type(event, "perf_data_src", sample->data_src);
+#else
+		ret = value_set_u64(cw, event, "perf_data_src", sample->data_src);
+#endif
 		if (ret)
 			return -1;
 	}
 
 	if (type & PERF_SAMPLE_TRANSACTION) {
-		ret = value_set_u64(cw, event, "perf_transaction",
-				sample->transaction);
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+		ret = value_set_from_type(event, "perf_transaction", sample->transaction);
+#else
+		ret = value_set_u64(cw, event, "perf_transaction", sample->transaction);
+#endif
 		if (ret)
 			return -1;
 	}
@@ -677,24 +846,43 @@ static int add_generic_values(struct ctf_writer *cw,
 	return 0;
 }
 
-static int ctf_stream__flush(struct ctf_stream *cs)
+static int ctf_stream__flush(struct convert *c __maybe_unused, struct ctf_stream *cs,
+			     u64 time __maybe_unused)
 {
-	int err = 0;
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+	struct ctf_writer *cw = &c->writer;
+	bt_message *msg;
 
-	if (cs) {
-		err = bt_ctf_stream_flush(cs->stream);
-		if (err)
-			pr_err("CTF stream %d flush failed\n", cs->cpu);
+	if (!cs->packet)
+		return 0;
 
-		pr("Flush stream for cpu %d (%u samples)\n",
-		   cs->cpu, cs->count);
+	msg = bt_message_packet_end_create_with_default_clock_snapshot(cw->self_iter,
+								       cs->packet, time);
+	if (!msg)
+		return -1;
 
-		cs->count = 0;
-	}
+	queue_push(c, msg);
+	bt_packet_put_ref(cs->packet);
+	cs->packet = NULL;
+	cs->count = 0;
+	return 0;
+#else
+	int err;
 
-	return err;
+	if (!cs)
+		return 0;
+
+	err = bt_ctf_stream_flush(cs->stream);
+	if (err)
+		pr_err("CTF stream %d flush failed\n", cs->cpu);
+
+	pr("Flush stream for cpu %d (%u samples)\n", cs->cpu, cs->count);
+	cs->count = 0;
+	return  err;
+#endif
 }
 
+#ifndef HAVE_LIBBABELTRACE2_SUPPORT
 static struct ctf_stream *ctf_stream__create(struct ctf_writer *cw, int cpu)
 {
 	struct ctf_stream *cs;
@@ -757,16 +945,37 @@ static void ctf_stream__delete(struct ctf_stream *cs)
 		free(cs);
 	}
 }
+#endif
 
-static struct ctf_stream *ctf_stream(struct ctf_writer *cw, int cpu)
+static struct ctf_stream *ctf_stream(struct convert *c, int cpu)
 {
-	struct ctf_stream *cs = cw->stream[cpu];
+	struct ctf_writer *cw = &c->writer;
+	struct ctf_stream *cs;
+
+	if (cpu >= cw->stream_cnt)
+		return NULL;
 
+	cs = cw->stream[cpu];
 	if (!cs) {
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+		bt_message *msg;
+
+		cs = zalloc(sizeof(*cs));
+		if (!cs)
+			return NULL;
+		cs->cpu = cpu;
+		cs->stream = bt_stream_create_with_id(cw->stream_class, cw->trace, cpu);
+		if (!cs->stream) {
+			free(cs);
+			return NULL;
+		}
+		msg = bt_message_stream_beginning_create(cw->self_iter, cs->stream);
+		queue_push(c, msg);
+#else
 		cs = ctf_stream__create(cw, cpu);
+#endif
 		cw->stream[cpu] = cs;
 	}
-
 	return cs;
 }
 
@@ -774,20 +983,47 @@ static int get_sample_cpu(struct ctf_writer *cw, struct perf_sample *sample,
 			  struct evsel *evsel)
 {
 	int cpu = 0;
-
 	if (evsel->core.attr.sample_type & PERF_SAMPLE_CPU)
 		cpu = sample->cpu;
 
-	if (cpu > cw->stream_cnt) {
-		pr_err("Event was recorded for CPU %d, limit is at %d.\n",
+	if (cpu < 0 || cpu >= cw->stream_cnt) {
+		pr_debug("Event recorded for CPU %d, limit is %d. Using CPU 0.\n",
 			cpu, cw->stream_cnt);
 		cpu = 0;
 	}
-
 	return cpu;
 }
 
-#define STREAM_FLUSH_COUNT 100000
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+static int ctf_stream__create_packet(struct convert *c, struct ctf_stream *cs, u64 time)
+{
+	struct ctf_writer *cw = &c->writer;
+	bt_message *msg;
+	bt_field *pc;
+
+	if (cs->packet)
+		return 0;
+
+	cs->packet = bt_packet_create(cs->stream);
+	if (!cs->packet)
+		return -1;
+
+	msg = bt_message_packet_beginning_create_with_default_clock_snapshot(cw->self_iter,
+									     cs->packet, time);
+	if (!msg)
+		return -1;
+
+	pc = bt_packet_borrow_context_field(cs->packet);
+	if (pc) {
+		bt_field *cpu = bt_field_structure_borrow_member_field_by_name(pc, "cpu_id");
+		if (cpu)
+			bt_field_integer_unsigned_set_value(cpu, cs->cpu);
+	}
+
+	queue_push(c, msg);
+	return 0;
+}
+#endif
 
 /*
  * Currently we have no other way to determine the
@@ -810,28 +1046,60 @@ static int process_sample_event(const struct perf_tool *tool,
 	struct evsel_priv *priv = evsel->priv;
 	struct ctf_writer *cw = &c->writer;
 	struct ctf_stream *cs;
-	struct bt_ctf_event_class *event_class;
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+	bt_event *event;
+	bt_message *msg;
+#else
 	struct bt_ctf_event *event;
+#endif
 	int ret;
-	unsigned long type = evsel->core.attr.sample_type;
 
-	if (WARN_ONCE(!priv, "Failed to setup all events.\n"))
+	if (!priv) {
+		pr_warning_once("Failed to setup all events.\n");
 		return 0;
+	}
+
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+	if (!cw->self_iter)
+		return 0;
+#endif
 
 	if (perf_time__ranges_skip_sample(c->ptime_range, c->range_num, sample->time)) {
-		++c->skipped;
+		c->skipped++;
 		return 0;
 	}
 
-	event_class = priv->event_class;
-
-	/* update stats */
 	c->events_count++;
 	c->events_size += _event->header.size;
+	c->last_ts = sample->time;
 
-	pr_time2(sample->time, "sample %" PRIu64 "\n", c->events_count);
+	cs = ctf_stream(c, get_sample_cpu(cw, sample, evsel));
+	if (!cs)
+		return -1;
+
+	if (is_flush_needed(cs))
+		ctf_stream__flush(c, cs, sample->time);
+
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+	if (ctf_stream__create_packet(c, cs, sample->time))
+		return -1;
 
-	event = bt_ctf_event_create(event_class);
+	/* Create event with default clock snapshot if possible */
+	msg = bt_message_event_create_with_default_clock_snapshot(cw->self_iter,
+								  priv->event_class,
+								  cs->stream,
+								  sample->time);
+	if (!msg)
+		return -1;
+
+	event = bt_message_event_borrow_event(msg);
+	/* bt_event_set_packet removed as it is implicit in message creation */
+
+	ret = add_generic_values(cw, event, evsel, sample);
+
+	queue_push(c, msg);
+#else
+	event = bt_ctf_event_create(priv->event_class);
 	if (!event) {
 		pr_err("Failed to create an CTF event\n");
 		return -1;
@@ -844,38 +1112,32 @@ static int process_sample_event(const struct perf_tool *tool,
 		return -1;
 
 	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
-		ret = add_tracepoint_values(cw, event_class, event,
+		ret = add_tracepoint_values(cw, priv->event_class, event,
 					    evsel, sample);
 		if (ret)
 			return -1;
 	}
 
-	if (type & PERF_SAMPLE_CALLCHAIN) {
-		ret = add_callchain_output_values(event_class,
-				event, sample->callchain);
+	if (evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
+		ret = add_callchain_output_values(priv->event_class, event, sample->callchain);
 		if (ret)
 			return -1;
 	}
 
 	if (evsel__is_bpf_output(evsel)) {
-		ret = add_bpf_output_values(event_class, event, sample);
+		ret = add_bpf_output_values(priv->event_class, event, sample);
 		if (ret)
 			return -1;
 	}
 
-	cs = ctf_stream(cw, get_sample_cpu(cw, sample, evsel));
-	if (cs) {
-		if (is_flush_needed(cs))
-			ctf_stream__flush(cs);
-
-		cs->count++;
-		bt_ctf_stream_append_event(cs->stream, event);
-	}
-
+	bt_ctf_stream_append_event(cs->stream, event);
 	bt_ctf_event_put(event);
-	return cs ? 0 : -1;
+#endif
+	cs->count++;
+	return ret;
 }
 
+#ifndef HAVE_LIBBABELTRACE2_SUPPORT
 #define __NON_SAMPLE_SET_FIELD(_name, _type, _field) 	\
 do {							\
 	ret = value_set_##_type(cw, event, #_field, _event->_name._field);\
@@ -906,10 +1168,10 @@ static int process_##_name##_event(const struct perf_tool *tool,	\
 								\
 	bt_ctf_clock_set_time(cw->clock, sample->time);		\
 	body							\
-	cs = ctf_stream(cw, 0);					\
+	cs = ctf_stream(c, 0);					\
 	if (cs) {						\
 		if (is_flush_needed(cs))			\
-			ctf_stream__flush(cs);			\
+			ctf_stream__flush(c, cs, c->last_ts);	\
 								\
 		cs->count++;					\
 		bt_ctf_stream_append_event(cs->stream, event);	\
@@ -989,7 +1251,22 @@ static char *change_name(char *name, char *orig_name, int dup)
 		free(name);
 	return new_name;
 }
+#endif
+
+static int add_environment_string(struct ctf_writer *cw, const char *name, const char *value)
+{
+	if (!value)
+		return 0;
 
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+	bt_trace_set_environment_entry_string(cw->trace, name, value);
+	return 0;
+#else
+	return bt_ctf_writer_add_environment_field(cw->writer, name, value);
+#endif
+}
+
+#ifndef HAVE_LIBBABELTRACE2_SUPPORT
 static int event_class_add_field(struct bt_ctf_event_class *event_class,
 		struct bt_ctf_field_type *type,
 		struct tep_format_field *field)
@@ -1079,7 +1356,7 @@ static int add_tracepoint_types(struct ctf_writer *cw,
 {
 	const struct tep_event *tp_format = evsel__tp_format(evsel);
 	struct tep_format_field *common_fields = tp_format ? tp_format->format.common_fields : NULL;
-	struct tep_format_field *fields        = tp_format ? tp_format->format.fields : NULL;
+	struct tep_format_field *fields	= tp_format ? tp_format->format.fields : NULL;
 	int ret;
 
 	ret = add_tracepoint_fields_types(cw, common_fields, class);
@@ -1107,7 +1384,108 @@ static int add_bpf_output_types(struct ctf_writer *cw,
 
 	return bt_ctf_event_class_add_field(class, seq_type, "raw_data");
 }
+#endif
+
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+static bt_field_class *create_unsigned_int(bt_trace_class *tc, int size, bool hex) {
+	bt_field_class *fc = bt_field_class_integer_unsigned_create(tc);
+
+	bt_field_class_integer_set_field_value_range(fc, size);
+	if (hex) {
+		bt_field_class_integer_set_preferred_display_base(fc,
+			BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_HEXADECIMAL);
+	}
+	return fc;
+}
+
+static bt_field_class *create_signed_int(bt_trace_class *tc, int size) {
+	bt_field_class *fc = bt_field_class_integer_signed_create(tc);
+	bt_field_class_integer_set_field_value_range(fc, size);
+	return fc;
+}
+
+/* Component methods */
+static bt_component_class_get_supported_mip_versions_method_status
+source_get_supported_mip_versions(
+		bt_self_component_class_source *self_component_class __maybe_unused,
+		const bt_value *params __maybe_unused,
+		void *init_method_data __maybe_unused,
+		bt_logging_level logging_level __maybe_unused,
+		bt_integer_range_set_unsigned *supported_versions)
+{
+	bt_integer_range_set_add_range_status status;
+
+	status = bt_integer_range_set_unsigned_add_range(supported_versions, 0, 1);
+	if (status != BT_INTEGER_RANGE_SET_ADD_RANGE_STATUS_OK)
+		return BT_COMPONENT_CLASS_GET_SUPPORTED_MIP_VERSIONS_METHOD_STATUS_ERROR;
+
+	return BT_COMPONENT_CLASS_GET_SUPPORTED_MIP_VERSIONS_METHOD_STATUS_OK;
+}
+
+static int add_generic_types(struct ctf_writer *cw, struct evsel *evsel,
+			bt_event_class *event_class)
+{
+	bt_trace_class *tc = cw->trace_class;
+	u64 type = evsel->core.attr.sample_type;
+	bt_field_class *payload_fc = bt_event_class_borrow_payload_field_class(event_class);
+	bt_field_class *fc;
+
+	/*
+	 * missing:
+	 *   PERF_SAMPLE_TIME         - not needed as we have it in
+	 *                              ctf event header
+	 *   PERF_SAMPLE_READ         - TODO
+	 *   PERF_SAMPLE_CALLCHAIN    - TODO
+	 *   PERF_SAMPLE_RAW          - tracepoint fields and BPF output
+	 *                              are handled separately
+	 *   PERF_SAMPLE_BRANCH_STACK - TODO
+	 *   PERF_SAMPLE_REGS_USER    - TODO
+	 *   PERF_SAMPLE_STACK_USER   - TODO
+	 */
+
+#define ADD_FIELD(t, n)						\
+	do {								\
+		fc = t;							\
+		if (!fc) return -1;					\
+		if (bt_field_class_structure_append_member(payload_fc, n, fc)) { \
+			bt_field_class_put_ref(fc);			\
+			pr_err("Failed to add field '%s';\n", n);	\
+			return -1;					\
+		}							\
+		bt_field_class_put_ref(fc);				\
+	} while (0)
+
+	if (type & PERF_SAMPLE_IP)
+		ADD_FIELD(create_unsigned_int(tc, 64, true), "perf_ip");
+
+	if (type & PERF_SAMPLE_TID) {
+		ADD_FIELD(create_signed_int(tc, 32), "perf_tid");
+		ADD_FIELD(create_signed_int(tc, 32), "perf_pid");
+	}
+
+	if ((type & PERF_SAMPLE_ID) ||
+	    (type & PERF_SAMPLE_IDENTIFIER))
+		ADD_FIELD(create_unsigned_int(tc, 64, false), "perf_id");
+
+	if (type & PERF_SAMPLE_STREAM_ID)
+		ADD_FIELD(create_unsigned_int(tc, 64, false), "perf_stream_id");
+
+	if (type & PERF_SAMPLE_PERIOD)
+		ADD_FIELD(create_unsigned_int(tc, 64, false), "perf_period");
+
+	if (type & PERF_SAMPLE_WEIGHT)
+		ADD_FIELD(create_unsigned_int(tc, 64, false), "perf_weight");
+
+	if (type & PERF_SAMPLE_DATA_SRC)
+		ADD_FIELD(create_unsigned_int(tc, 64, false), "perf_data_src");
 
+	if (type & PERF_SAMPLE_TRANSACTION)
+		ADD_FIELD(create_unsigned_int(tc, 64, false), "perf_transaction");
+
+#undef ADD_FIELD
+	return 0;
+}
+#else
 static int add_generic_types(struct ctf_writer *cw, struct evsel *evsel,
 			     struct bt_ctf_event_class *event_class)
 {
@@ -1173,10 +1551,16 @@ static int add_generic_types(struct ctf_writer *cw, struct evsel *evsel,
 #undef ADD_FIELD
 	return 0;
 }
+#endif
 
 static int add_event(struct ctf_writer *cw, struct evsel *evsel)
 {
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+	bt_event_class *event_class;
+	bt_field_class *fc;
+#else
 	struct bt_ctf_event_class *event_class;
+#endif
 	struct evsel_priv *priv;
 	const char *name = evsel__name(evsel);
 	int ret;
@@ -1187,31 +1571,62 @@ static int add_event(struct ctf_writer *cw, struct evsel *evsel)
 	}
 	pr("Adding event '%s' (type %d)\n", name, evsel->core.attr.type);
 
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+	event_class = bt_event_class_create(cw->stream_class);
+	if (!event_class)
+		return -1;
+
+	if (bt_event_class_set_name(event_class, name)) {
+		pr_err("Failed to set event name\n");
+		goto err;
+	}
+
+	if (evsel->priv) {
+		bt_event_class_put_ref(event_class);
+		return 0;
+	}
+
+	fc = bt_field_class_structure_create(cw->trace_class);
+	if (!fc) goto err;
+	bt_event_class_set_payload_field_class(event_class, fc);
+	bt_field_class_put_ref(fc);
+#else
 	event_class = bt_ctf_event_class_create(name);
 	if (!event_class)
 		return -1;
+#endif
 
 	ret = add_generic_types(cw, evsel, event_class);
 	if (ret)
 		goto err;
 
 	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+		/* TODO: Add tracepoint types types */
+#else
 		ret = add_tracepoint_types(cw, evsel, event_class);
 		if (ret)
 			goto err;
+#endif
 	}
 
 	if (evsel__is_bpf_output(evsel)) {
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+		/* TODO: Add BPF output types */
+#else
 		ret = add_bpf_output_types(cw, event_class);
 		if (ret)
 			goto err;
+#endif
 	}
 
+#ifndef HAVE_LIBBABELTRACE2_SUPPORT
 	ret = bt_ctf_stream_class_add_event_class(cw->stream_class, event_class);
 	if (ret) {
 		pr("Failed to add event class into stream.\n");
 		goto err;
 	}
+#endif
 
 	priv = malloc(sizeof(*priv));
 	if (!priv)
@@ -1222,7 +1637,11 @@ static int add_event(struct ctf_writer *cw, struct evsel *evsel)
 	return 0;
 
 err:
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+	bt_event_class_put_ref(event_class);
+#else
 	bt_ctf_event_class_put(event_class);
+#endif
 	pr_err("Failed to add event '%s'.\n", name);
 	return -1;
 }
@@ -1256,6 +1675,7 @@ static int setup_events(struct ctf_writer *cw, struct perf_session *session,
 	return 0;
 }
 
+#ifndef HAVE_LIBBABELTRACE2_SUPPORT
 #define __NON_SAMPLE_ADD_FIELD(t, n)						\
 	do {							\
 		pr2("  field '%s'\n", #n);			\
@@ -1348,6 +1768,7 @@ static int setup_non_sample_events(struct ctf_writer *cw,
 		return ret;
 	return 0;
 }
+#endif
 
 static void cleanup_events(struct perf_session *session)
 {
@@ -1358,9 +1779,14 @@ static void cleanup_events(struct perf_session *session)
 		struct evsel_priv *priv;
 
 		priv = evsel->priv;
-		if (priv)
+		if (priv) {
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+			bt_event_class_put_ref(priv->event_class);
+#else
 			bt_ctf_event_class_put(priv->event_class);
-		zfree(&evsel->priv);
+#endif
+			zfree(&evsel->priv);
+		}
 	}
 
 	evlist__delete(evlist);
@@ -1392,10 +1818,12 @@ static int setup_streams(struct ctf_writer *cw, struct perf_session *session)
 
 static void free_streams(struct ctf_writer *cw)
 {
+#ifndef HAVE_LIBBABELTRACE2_SUPPORT
 	int cpu;
 
 	for (cpu = 0; cpu < cw->stream_cnt; cpu++)
 		ctf_stream__delete(cw->stream[cpu]);
+#endif
 
 	zfree(&cw->stream);
 }
@@ -1404,23 +1832,15 @@ static int ctf_writer__setup_env(struct ctf_writer *cw,
 				 struct perf_session *session)
 {
 	struct perf_env *env = perf_session__env(session);
-	struct bt_ctf_writer *writer = cw->writer;
 
-#define ADD(__n, __v)							\
-do {									\
-	if (__v && bt_ctf_writer_add_environment_field(writer, __n, __v))	\
-		return -1;						\
-} while (0)
-
-	ADD("host",    env->hostname);
-	ADD("sysname", "Linux");
-	ADD("release", env->os_release);
-	ADD("version", env->version);
-	ADD("machine", env->arch);
-	ADD("domain", "kernel");
-	ADD("tracer_name", "perf");
+	add_environment_string(cw, "host",    env->hostname);
+	add_environment_string(cw, "sysname", "Linux");
+	add_environment_string(cw, "release", env->os_release);
+	add_environment_string(cw, "version", env->version);
+	add_environment_string(cw, "machine", env->arch);
+	add_environment_string(cw, "domain", "kernel");
+	add_environment_string(cw, "tracer_name", "perf");
 
-#undef ADD
 	return 0;
 }
 
@@ -1450,33 +1870,16 @@ static int process_feature_event(const struct perf_tool *tool,
 		 */
 		return setup_events(cw, session, SETUP_EVENTS_NOT_TRACEPOINT);
 	case HEADER_HOSTNAME:
-		if (session->header.env.hostname) {
-			return bt_ctf_writer_add_environment_field(cw->writer, "host",
-								   session->header.env.hostname);
-		}
-		break;
+		return add_environment_string(cw, "host", session->header.env.hostname);
 	case HEADER_OSRELEASE:
-		if (session->header.env.os_release) {
-			return bt_ctf_writer_add_environment_field(cw->writer, "release",
-								   session->header.env.os_release);
-		}
-		break;
+		return add_environment_string(cw, "release", session->header.env.os_release);
 	case HEADER_VERSION:
-		if (session->header.env.version) {
-			return bt_ctf_writer_add_environment_field(cw->writer, "version",
-								   session->header.env.version);
-		}
-		break;
+		return add_environment_string(cw, "version", session->header.env.version);
 	case HEADER_ARCH:
-		if (session->header.env.arch) {
-			return bt_ctf_writer_add_environment_field(cw->writer, "machine",
-								   session->header.env.arch);
-		}
-		break;
+		return add_environment_string(cw, "machine", session->header.env.arch);
 	default:
-		break;
+		return 0;
 	}
-	return 0;
 }
 
 static int process_tracing_data(const struct perf_tool *tool,
@@ -1499,6 +1902,7 @@ static int process_tracing_data(const struct perf_tool *tool,
 	return setup_events(cw, session, SETUP_EVENTS_TRACEPOINT_ONLY);
 }
 
+#ifndef HAVE_LIBBABELTRACE2_SUPPORT
 static int ctf_writer__setup_clock(struct ctf_writer *cw,
 				   struct perf_session *session,
 				   bool tod)
@@ -1535,7 +1939,105 @@ do {						\
 #undef SET
 	return 0;
 }
+#endif
+
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+static int ctf_writer__setup_packet_context(struct ctf_writer *cw)
+{
+	bt_field_class *fc = bt_field_class_structure_create(cw->trace_class);
+	bt_field_class *cpu_fc = bt_field_class_integer_unsigned_create(cw->trace_class);
 
+	bt_field_class_integer_set_field_value_range(cpu_fc, 32);
+	bt_field_class_structure_append_member(fc, "cpu_id", cpu_fc);
+	bt_field_class_put_ref(cpu_fc);
+
+	bt_stream_class_set_packet_context_field_class(cw->stream_class, fc);
+	bt_field_class_put_ref(fc);
+	return 0;
+}
+
+static bt_component_class_initialize_method_status
+source_init(bt_self_component_source *self_comp,
+	    bt_self_component_source_configuration *config __maybe_unused,
+	    const bt_value *params __maybe_unused,
+	    void *init_method_data)
+{
+	struct convert *c = init_method_data;
+	struct ctf_writer *cw = &c->writer;
+	cw->self_comp = self_comp;
+
+	bt_self_component_set_data(bt_self_component_source_as_self_component(self_comp), c);
+
+	/* Create trace class */
+	cw->trace_class = bt_trace_class_create(bt_self_component_source_as_self_component(self_comp));
+	if (!cw->trace_class) return BT_COMPONENT_CLASS_INITIALIZE_METHOD_STATUS_ERROR;
+
+	/* Create clock class */
+	cw->clock_class = bt_clock_class_create(bt_self_component_source_as_self_component(self_comp));
+	bt_clock_class_set_frequency(cw->clock_class, 1000000000);
+
+	/* Create stream class */
+	cw->stream_class = bt_stream_class_create(cw->trace_class);
+	bt_stream_class_set_assigns_automatic_stream_id(cw->stream_class, BT_FALSE);
+	bt_stream_class_set_default_clock_class(cw->stream_class, cw->clock_class);
+	bt_stream_class_set_supports_packets(cw->stream_class, BT_TRUE, BT_TRUE, BT_TRUE);
+
+	if (ctf_writer__setup_packet_context(cw))
+		return BT_COMPONENT_CLASS_INITIALIZE_METHOD_STATUS_ERROR;
+
+	/* Create trace */
+	cw->trace = bt_trace_create(cw->trace_class);
+
+	if (ctf_writer__setup_env(cw, c->session))
+		return BT_COMPONENT_CLASS_INITIALIZE_METHOD_STATUS_ERROR;
+
+	bt_self_component_source_add_output_port(self_comp, "out", NULL, NULL);
+	return BT_COMPONENT_CLASS_INITIALIZE_METHOD_STATUS_OK;
+}
+
+static bt_message_iterator_class_next_method_status
+iter_next(bt_self_message_iterator *self_iter,
+	  bt_message_array_const msgs, uint64_t capacity,
+	  uint64_t *count)
+{
+	struct convert *c = bt_self_message_iterator_get_data(self_iter);
+	bt_message *msg;
+	uint64_t i = 0;
+
+	if (!c->writer.self_iter)
+		c->writer.self_iter = self_iter;
+
+	while (i < capacity) {
+		msg = queue_pop(c);
+		if (!msg) {
+			if (c->finished) {
+				*count = i;
+				return i > 0 ? BT_MESSAGE_ITERATOR_CLASS_NEXT_METHOD_STATUS_OK :
+					       BT_MESSAGE_ITERATOR_CLASS_NEXT_METHOD_STATUS_END;
+			}
+			break; /* Return what we have, or AGAIN */
+		}
+		msgs[i++] = msg;
+	}
+
+	*count = i;
+	if (i > 0)
+		return BT_MESSAGE_ITERATOR_CLASS_NEXT_METHOD_STATUS_OK;
+	return BT_MESSAGE_ITERATOR_CLASS_NEXT_METHOD_STATUS_AGAIN;
+}
+
+static bt_message_iterator_class_initialize_method_status
+iter_init(bt_self_message_iterator *self_iter,
+	  bt_self_message_iterator_configuration *config __maybe_unused,
+	  bt_self_component_port_output *port __maybe_unused)
+{
+	struct convert *c = bt_self_component_get_data(
+		bt_self_message_iterator_borrow_component(self_iter));
+	bt_self_message_iterator_set_data(self_iter, c);
+	c->writer.self_iter = self_iter;
+	return BT_MESSAGE_ITERATOR_CLASS_INITIALIZE_METHOD_STATUS_OK;
+}
+#else
 static struct bt_ctf_field_type *create_int_type(int size, bool sign, bool hex)
 {
 	struct bt_ctf_field_type *type;
@@ -1566,15 +2068,35 @@ static struct bt_ctf_field_type *create_int_type(int size, bool sign, bool hex)
 	bt_ctf_field_type_put(type);
 	return NULL;
 }
+#endif
 
 static void ctf_writer__cleanup_data(struct ctf_writer *cw)
 {
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(cw->data.array); i++)
-		bt_ctf_field_type_put(cw->data.array[i]);
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+#define CLEANUP(type)					\
+	if (cw->data.type) {				\
+		bt_field_class_put_ref(cw->data.s64);	\
+		cw->data.s64 = NULL;			\
+	}
+#else
+#define CLEANUP(type)					\
+	if (cw->data.type) {				\
+		bt_ctf_field_type_put(cw->data.s64);	\
+		cw->data.s64 = NULL;			\
+	}
+#endif
+	CLEANUP(s64);
+	CLEANUP(u64);
+	CLEANUP(s32);
+	CLEANUP(u32);
+	CLEANUP(string);
+	CLEANUP(u32_hex);
+	CLEANUP(u64_hex);
+#undef CLEANUP
 }
 
+
+#ifndef HAVE_LIBBABELTRACE2_SUPPORT
 static int ctf_writer__init_data(struct ctf_writer *cw)
 {
 #define CREATE_INT_TYPE(type, size, sign, hex)		\
@@ -1600,23 +2122,124 @@ do {							\
 	pr_err("Failed to create data types.\n");
 	return -1;
 }
+#endif
 
 static void ctf_writer__cleanup(struct ctf_writer *cw)
 {
+	/* Release data type field classes */
 	ctf_writer__cleanup_data(cw);
-
-	bt_ctf_clock_put(cw->clock);
 	free_streams(cw);
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+	if (cw->graph) {
+		bt_graph_put_ref(cw->graph);
+		cw->graph = NULL;
+	}
+	if (cw->source) {
+		bt_component_put_ref(bt_component_source_as_component_const(cw->source));
+		cw->source = NULL;
+	}
+	if (cw->sink) {
+		bt_component_put_ref(bt_component_sink_as_component_const(cw->sink));
+		cw->sink = NULL;
+	}
+	if (cw->trace) {
+		bt_trace_put_ref(cw->trace);
+		cw->trace = NULL;
+	}
+	if (cw->stream_class) {
+		bt_stream_class_put_ref(cw->stream_class);
+		cw->stream_class = NULL;
+	}
+	if (cw->clock_class) {
+		bt_clock_class_put_ref(cw->clock_class);
+		cw->clock_class = NULL;
+	}
+	if (cw->trace_class) {
+		bt_trace_class_put_ref(cw->trace_class);
+		cw->trace_class = NULL;
+	}
+#else
+	bt_ctf_clock_put(cw->clock);
 	bt_ctf_stream_class_put(cw->stream_class);
 	bt_ctf_writer_put(cw->writer);
 
 	/* and NULL all the pointers */
 	memset(cw, 0, sizeof(*cw));
+#endif
 }
 
 static int ctf_writer__init(struct ctf_writer *cw, const char *path,
-			    struct perf_session *session, bool tod)
+			    struct perf_session *session __maybe_unused,
+			    bool tod __maybe_unused, struct convert *c __maybe_unused)
 {
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+	bt_component_class_source *src_comp_class = NULL;
+	bt_message_iterator_class *iter_class = NULL;
+	bt_component_class_sink *sink_comp_class = NULL;
+	const bt_plugin *plugin = NULL;
+	bt_value *sink_params = NULL;
+	int status, err = -1;
+
+	/* Setup babeltrace2 graph */
+	cw->graph = bt_graph_create(1);
+	if (!cw->graph)
+		goto err;
+
+	iter_class = bt_message_iterator_class_create(iter_next);
+	bt_message_iterator_class_set_initialize_method(iter_class, iter_init);
+
+	src_comp_class = bt_component_class_source_create("perf", iter_class);
+	bt_component_class_source_set_initialize_method(src_comp_class, source_init);
+	bt_component_class_source_set_get_supported_mip_versions_method(src_comp_class, source_get_supported_mip_versions);
+
+	bt_graph_add_source_component_with_initialize_method_data(cw->graph, src_comp_class,
+								  "perf_source", NULL, c,
+								  BT_LOGGING_LEVEL_NONE,
+								  &cw->source);
+
+	/* Sink */
+	bt_plugin_find("ctf", BT_TRUE, BT_TRUE, BT_TRUE, BT_TRUE, BT_TRUE, &plugin);
+	if (plugin) {
+		sink_comp_class = (bt_component_class_sink *) bt_plugin_borrow_sink_component_class_by_name_const(plugin, "fs");
+		bt_component_class_get_ref(bt_component_class_sink_as_component_class(sink_comp_class));
+		bt_plugin_put_ref(plugin);
+	}
+	if (!sink_comp_class) {
+		pr_err("Failed to find ctf.fs sink component\n");
+		goto err;
+	}
+
+	sink_params = bt_value_map_create();
+	bt_value_map_insert_string_entry(sink_params, "path", path);
+
+	status = bt_graph_add_sink_component(cw->graph, sink_comp_class, "ctf_sink", sink_params, BT_LOGGING_LEVEL_WARNING, (const bt_component_sink **) &cw->sink);
+	if (status < 0) {
+		pr_err("Failed to add ctf.fs sink component, status: %d\n", status);
+		goto err;
+	}
+	bt_value_put_ref(sink_params);
+
+	/* Connect */
+	bt_graph_connect_ports(cw->graph,
+		bt_component_source_borrow_output_port_by_index_const(cw->source, 0),
+		bt_component_sink_borrow_input_port_by_index_const(cw->sink, 0), NULL);
+
+	err = setup_streams(cw, session);
+err:
+	if (sink_comp_class)
+		bt_component_class_sink_put_ref(sink_comp_class);
+	if (src_comp_class)
+		bt_component_class_source_put_ref(src_comp_class);
+	if (iter_class)
+		bt_message_iterator_class_put_ref(iter_class);
+	return 0;
+
+	ctf_writer__cleanup(cw);
+	if (err)
+		pr_err("Failed to setup CTF writer.\n");
+	return err;
+
+#else
 	struct bt_ctf_writer		*writer;
 	struct bt_ctf_stream_class	*stream_class;
 	struct bt_ctf_clock		*clock;
@@ -1678,21 +2301,62 @@ static int ctf_writer__init(struct ctf_writer *cw, const char *path,
 		goto err_cleanup;
 	}
 
-	return 0;
+	/* CTF writer env setup  */
+	if (ctf_writer__setup_env(cw, session))
+		goto err_cleanup;
+
+	ret = setup_streams(cw, session);
+	if (!ret)
+		return 0;
 
 err_cleanup:
 	ctf_writer__cleanup(cw);
 err:
 	pr_err("Failed to setup CTF writer.\n");
 	return -1;
+#endif
 }
 
-static int ctf_writer__flush_streams(struct ctf_writer *cw)
+static int ctf_writer__flush_streams(struct convert *c)
 {
-	int cpu, ret = 0;
+	int cpu;
+	int ret = 0;
+
+	for (cpu = 0; cpu < c->writer.stream_cnt; cpu++) {
+		struct ctf_stream *cs = c->writer.stream[cpu];
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+		bt_message *msg;
+#endif
+		if (!cs)
+			continue;
+
+		if (ctf_stream__flush(c, cs, c->last_ts)) {
+			ret = -1;
+			break;
+		}
+
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+		/* Also end the stream */
+		msg = bt_message_stream_end_create(c->writer.self_iter, cs->stream);
+		if (!msg)
+			ret = -1;
+		else
+			queue_push(c, msg);
+
+		bt_stream_put_ref(cs->stream);
+		cs->stream = NULL;
+		free(cs);
+		c->writer.stream[cpu] = NULL;
+#endif
+	}
+
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+	while (c->queue_head != c->queue_tail)
+		ctf_writer__flush_queue(c);
 
-	for (cpu = 0; cpu < cw->stream_cnt && !ret; cpu++)
-		ret = ctf_stream__flush(cw->stream[cpu]);
+	/* Run until end */
+	while (bt_graph_run_once(c->writer.graph) == BT_GRAPH_RUN_ONCE_STATUS_OK);
+#endif
 
 	return ret;
 }
@@ -1707,6 +2371,13 @@ static int convert__config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+static int process_finished_init_event(const struct perf_tool *tool __maybe_unused,
+				       struct perf_session *session __maybe_unused,
+				       union perf_event *event __maybe_unused)
+{
+	return 0;
+}
+
 int bt_convert__perf2ctf(const char *input, const char *path,
 			 struct perf_data_convert_opts *opts)
 {
@@ -1716,10 +2387,19 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 		.mode      = PERF_DATA_MODE_READ,
 		.force     = opts->force,
 	};
-	struct convert c = {};
-	struct ctf_writer *cw = &c.writer;
-	int err;
+	struct convert c = {0};
+	int err = -1;
+
+	dump_trace = 1;
+	debug_data_convert = 3;
+	/* Setup queue */
+	c.queue_size = QUEUE_SIZE;
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+	c.queue = zalloc(sizeof(bt_message *) * c.queue_size);
+	c.queue_mask = c.queue_size - 1;
+#endif
 
+	/* Setup tool */
 	perf_tool__init(&c.tool, /*ordered_events=*/true);
 	c.tool.sample          = process_sample_event;
 	c.tool.mmap            = perf_event__process_mmap;
@@ -1732,10 +2412,12 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 	c.tool.build_id        = perf_event__process_build_id;
 	c.tool.namespaces      = perf_event__process_namespaces;
 	c.tool.finished_round  = perf_event__process_finished_round;
+	c.tool.finished_init   = process_finished_init_event;
 	c.tool.attr            = perf_event__process_attr;
 	c.tool.feature         = process_feature_event;
 	c.tool.ordering_requires_timestamps = true;
 
+#ifndef HAVE_LIBBABELTRACE2_SUPPORT
 	if (opts->all) {
 		c.tool.comm = process_comm_event;
 		c.tool.exit = process_exit_event;
@@ -1743,6 +2425,7 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 		c.tool.mmap = process_mmap_event;
 		c.tool.mmap2 = process_mmap2_event;
 	}
+#endif
 
 	err = perf_config(convert__config, &c);
 	if (err)
@@ -1753,6 +2436,7 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 	session = perf_session__new(&data, &c.tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
+	c.session = session;
 
 	if (opts->time_str) {
 		err = perf_time__parse_for_ranges(opts->time_str, session,
@@ -1760,40 +2444,52 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 						  &c.range_size,
 						  &c.range_num);
 		if (err < 0)
-			goto free_session;
+			goto out;
 	}
 
 	/* CTF writer */
-	if (ctf_writer__init(cw, path, session, opts->tod))
-		goto free_session;
+	if (ctf_writer__init(&c.writer, path, session, opts->tod, &c))
+		goto out;
+
 
+#ifdef HAVE_LIBBABELTRACE2_SUPPORT
+	/* Run graph once to trigger iterator init */
+	while (!c.writer.self_iter) {
+		int status = bt_graph_run_once(c.writer.graph);
+
+		if (status != BT_GRAPH_RUN_ONCE_STATUS_OK && status != BT_GRAPH_RUN_ONCE_STATUS_AGAIN) {
+			pr_err("Failed to run graph for iterator init, status: %d\n", status);
+			goto out;
+		}
+	}
+#else
 	if (c.queue_size) {
 		ordered_events__set_alloc_size(&session->ordered_events,
 					       c.queue_size);
 	}
-
-	/* CTF writer env/clock setup  */
-	if (ctf_writer__setup_env(cw, session))
-		goto free_writer;
+#endif
 
 	/*
 	 * CTF events setup. Note, in pipe mode no events exist yet (they come
 	 * in via header feature events) and so this does nothing.
 	 */
-	if (setup_events(cw, session, SETUP_EVENTS_ALL))
-		goto free_writer;
-
-	if (opts->all && setup_non_sample_events(cw, session))
-		goto free_writer;
+	if (setup_events(&c.writer, session, SETUP_EVENTS_ALL))
+		goto out;
 
-	if (setup_streams(cw, session))
-		goto free_writer;
+#ifndef HAVE_LIBBABELTRACE2_SUPPORT
+	if (opts->all && setup_non_sample_events(&c.writer, session))
+		goto out;
+#endif
 
+	/* Process events */
 	err = perf_session__process_events(session);
-	if (!err)
-		err = ctf_writer__flush_streams(cw);
-	else
-		pr_err("Error during conversion.\n");
+	if (err)
+		pr_err("Error during conversion (%d).\n", err);
+
+	/* Flush remaining */
+	c.finished = true;
+
+	err = ctf_writer__flush_streams(&c);
 
 	fprintf(stderr,	"[ perf data convert: Converted '%s' into CTF data '%s' ]\n",
 		data.path, path);
@@ -1807,27 +2503,17 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 	else
 		fprintf(stderr, ", %" PRIu64 " non-samples) ]\n", c.non_sample_count);
 
-	if (c.skipped) {
-		fprintf(stderr,	"[ perf data convert: Skipped %" PRIu64 " samples ]\n",
-			c.skipped);
-	}
-
+	if (c.skipped)
+		fprintf(stderr,	"[ perf data convert: Skipped %" PRIu64 " samples ]\n", c.skipped);
+out:
 	if (c.ptime_range)
 		zfree(&c.ptime_range);
 
 	cleanup_events(session);
 	perf_session__delete(session);
-	ctf_writer__cleanup(cw);
-
-	return err;
-
-free_writer:
-	ctf_writer__cleanup(cw);
-free_session:
-	if (c.ptime_range)
-		zfree(&c.ptime_range);
-
-	perf_session__delete(session);
-	pr_err("Error during conversion setup.\n");
+	ctf_writer__cleanup(&c.writer);
+#ifndef HAVE_LIBBABELTRACE2_SUPPORT
+	ctf_writer__cleanup(&c.writer);
+#endif
 	return err;
 }
diff --git a/tools/perf/util/data-convert.h b/tools/perf/util/data-convert.h
index ee651fa680a1..75c835496cbd 100644
--- a/tools/perf/util/data-convert.h
+++ b/tools/perf/util/data-convert.h
@@ -11,7 +11,7 @@ struct perf_data_convert_opts {
 	const char *time_str;
 };
 
-#ifdef HAVE_LIBBABELTRACE_SUPPORT
+#if defined(HAVE_LIBBABELTRACE_SUPPORT) || defined(HAVE_LIBBABELTRACE2_SUPPORT)
 int bt_convert__perf2ctf(const char *input_name, const char *to_ctf,
 			 struct perf_data_convert_opts *opts);
 #endif /* HAVE_LIBBABELTRACE_SUPPORT */
-- 
2.54.0.563.g4f69b47b94-goog

