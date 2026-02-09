Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9813A1E6B
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658893; cv=none; b=pY9FdG0cmyUTwciN5/bL0qw2DIridFXeomhu2Mt4JCTCsGQSO09Q56D2iAtxIYzHI7hX02aiUFe2q8fMwf/cmwerdunKIE2x4SZToBwLsWOqcJitmfwzs8493RzN4oL5Y9b3lQky1aYk9ZXoAcPsdYzk+Uau4ungeP40/RRC4SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658893; c=relaxed/simple;
	bh=CXh+eFU5YtRUOBXtV2IECoJ2dCMUwGTcMJgRGhjVckY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bJnEK/VDCmIaRDhEeLKuSO/dJAfwvoArYgWdHfMWwQTgskVCwNVnPJpxJEZI597AIJJyUYIVy0WUb2SXWwh7S9Wsk8z/J9/qjBDU/G4UTc7Q48YIkygTfrzsZa0TcfcvkN2kLMe+6Ma0Pnj7YJPgIWnMASv1WaPPu1veMtG4yo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tpMkobR+; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tpMkobR+"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-124a38e8980so3816866c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 09:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770658893; x=1771263693; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/QcBbxvHOyiN8NjYfndkJsVEnF1q6+c6eApGTKX1f8c=;
        b=tpMkobR+EHS9lP4F64pj00SyPXwswZT7idEj9Tj1wqn7pJfmRN8X2fcfXPzwW3jNPW
         qq5VMy8hkiiDqe3wNuOSD7AJKF6bUHWj+EzJPjbfjvPuUg2v5NdqYyZJBbTapgWX8Gym
         wMuehLod8sq9dxVJmgpNMq2qSvX5M4187z0gI6A790zVuvZ2ayRKEff9t9NGwi4BZXDu
         T3fWkx/NEh9MHVQIVEqiKjMPPEOVLEv5FvIGnId0FqyoP00zhnWGMdciughwrPvIr0Yd
         iiHYy6GqEl+VL4fzYjNAH/z/S+QX6QlBhGT61k9TWtDA1Or2SESbhnrc6e72Yes1oQMd
         fTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658893; x=1771263693;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QcBbxvHOyiN8NjYfndkJsVEnF1q6+c6eApGTKX1f8c=;
        b=c7JAyP3oH5CcFJuHY5GKikMNomLU4PnH39XLHP/AgNl06jtEFDfXPo8+iBHfc9xf+s
         XE8JcKR3RRg+mVx7wv1jkwEL71wx0tIfarnXq5Dc3tSMLKZxk4PDRki0E3FTtFgzoOH2
         GcJqnrDpywT0g1jao7SESoqb8yUn8fW0gvyDClQMAVzxBuzHZE6g6OHoNKQ16nhAgF/E
         kXLyLMsL7qNO/YVY+Y7ot53nEm8cw1Ify8J0kf571kE0YppyVAUF4LnabQ8zuBDXYypz
         qngTnHSs5HIdSPUe3g+pnVMFoqYHxYR9biV628K+Uh9iPlZu9iJUJ4lQagfUrApnGrcz
         vrgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4HVwtVS8wWrLsn2N25ds8hZsTDC2OjBqxS70PH5S7Bu4CQ0znlXP9Vd6514IWi60RrQSRF1Aeo4cNf+OHAlzG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Zd9WwrHWbVbn/LVzLh0Xpp35nLjx09zLZLP+8YJwkDyg5vSe
	QgP4fIfvnYIBf4bg8hvEOneNZ/YfFOw2YK/FWREPeeFVtRNwMKJED92m7w4gduOYVxvKjEmu9DD
	C3yU2/8Kx1Q==
X-Received: from dlbrp11.prod.google.com ([2002:a05:7022:160b:b0:123:2800:6acb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3f88:b0:127:dd7:2062
 with SMTP id a92af1059eb24-1270dd720e6mr3532717c88.43.1770658892614; Mon, 09
 Feb 2026 09:41:32 -0800 (PST)
Date: Mon,  9 Feb 2026 09:40:30 -0800
In-Reply-To: <20260209174032.4142096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209174032.4142096-24-irogers@google.com>
Subject: [PATCH v1 23/25] perf script: Don't pass evsel with sample
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
evsel as well. Remove the evsel from the struct scripting_context so
that the sample version is always accessed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c                   | 12 ++++--
 .../util/scripting-engines/trace-event-perl.c | 21 +++++------
 .../scripting-engines/trace-event-python.c    | 37 ++++++++-----------
 tools/perf/util/trace-event-scripting.c       |  5 +--
 tools/perf/util/trace-event.h                 |  3 --
 5 files changed, 33 insertions(+), 45 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 7788a6934a8d..9f7d261b1291 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2414,12 +2414,13 @@ static bool show_event(struct perf_sample *sample,
 }
 
 static void process_event(struct perf_script *script,
-			  struct perf_sample *sample, struct evsel *evsel,
+			  struct perf_sample *sample,
 			  struct addr_location *al,
 			  struct addr_location *addr_al,
 			  struct machine *machine)
 {
 	struct thread *thread = al->thread;
+	struct evsel *evsel = sample->evsel;
 	struct perf_event_attr *attr = &evsel->core.attr;
 	unsigned int type = evsel__output_type(evsel);
 	struct evsel_script *es = evsel->priv;
@@ -2710,9 +2711,9 @@ static int process_sample_event(const struct perf_tool *tool,
 				thread__resolve(al.thread, &addr_al, sample);
 			addr_al_ptr = &addr_al;
 		}
-		scripting_ops->process_event(event, sample, evsel, &al, addr_al_ptr);
+		scripting_ops->process_event(event, sample, &al, addr_al_ptr);
 	} else {
-		process_event(scr, sample, evsel, &al, &addr_al, machine);
+		process_event(scr, sample, &al, &addr_al, machine);
 	}
 
 out_put:
@@ -2888,9 +2889,12 @@ static int print_event_with_time(const struct perf_tool *tool,
 {
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 	struct perf_session *session = script->session;
-	struct evsel *evsel = evlist__id2evsel(session->evlist, sample->id);
+	struct evsel *evsel = sample->evsel;
 	struct thread *thread = NULL;
 
+	if (!evsel)
+		evsel = evlist__id2evsel(session->evlist, sample->id);
+
 	if (evsel && !evsel->core.attr.sample_id_all) {
 		sample->cpu = 0;
 		sample->time = timestamp;
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 850a0048df82..7a18ea4b7d50 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -257,7 +257,6 @@ static void define_event_symbols(struct tep_event *event,
 }
 
 static SV *perl_process_callchain(struct perf_sample *sample,
-				  struct evsel *evsel,
 				  struct addr_location *al)
 {
 	struct callchain_cursor *cursor;
@@ -340,7 +339,6 @@ static SV *perl_process_callchain(struct perf_sample *sample,
 }
 
 static void perl_process_tracepoint(struct perf_sample *sample,
-				    struct evsel *evsel,
 				    struct addr_location *al)
 {
 	struct thread *thread = al->thread;
@@ -355,6 +353,7 @@ static void perl_process_tracepoint(struct perf_sample *sample,
 	unsigned long long nsecs = sample->time;
 	const char *comm = thread__comm_str(thread);
 	DECLARE_BITMAP(events_defined, TRACE_EVENT_TYPE_MAX);
+	struct evsel *evsel = sample->evsel;
 
 	bitmap_zero(events_defined, TRACE_EVENT_TYPE_MAX);
 	dSP;
@@ -389,7 +388,7 @@ static void perl_process_tracepoint(struct perf_sample *sample,
 	XPUSHs(sv_2mortal(newSVuv(ns)));
 	XPUSHs(sv_2mortal(newSViv(pid)));
 	XPUSHs(sv_2mortal(newSVpv(comm, 0)));
-	XPUSHs(sv_2mortal(perl_process_callchain(sample, evsel, al)));
+	XPUSHs(sv_2mortal(perl_process_callchain(sample, al)));
 
 	/* common fields other than pid can be accessed via xsub fns */
 
@@ -426,7 +425,7 @@ static void perl_process_tracepoint(struct perf_sample *sample,
 		XPUSHs(sv_2mortal(newSVuv(nsecs)));
 		XPUSHs(sv_2mortal(newSViv(pid)));
 		XPUSHs(sv_2mortal(newSVpv(comm, 0)));
-		XPUSHs(sv_2mortal(perl_process_callchain(sample, evsel, al)));
+		XPUSHs(sv_2mortal(perl_process_callchain(sample, al)));
 		call_pv("main::trace_unhandled", G_SCALAR);
 	}
 	SPAGAIN;
@@ -435,9 +434,7 @@ static void perl_process_tracepoint(struct perf_sample *sample,
 	LEAVE;
 }
 
-static void perl_process_event_generic(union perf_event *event,
-				       struct perf_sample *sample,
-				       struct evsel *evsel)
+static void perl_process_event_generic(union perf_event *event, struct perf_sample *sample)
 {
 	dSP;
 
@@ -448,7 +445,8 @@ static void perl_process_event_generic(union perf_event *event,
 	SAVETMPS;
 	PUSHMARK(SP);
 	XPUSHs(sv_2mortal(newSVpvn((const char *)event, event->header.size)));
-	XPUSHs(sv_2mortal(newSVpvn((const char *)&evsel->core.attr, sizeof(evsel->core.attr))));
+	XPUSHs(sv_2mortal(newSVpvn((const char *)&sample->evsel->core.attr,
+				   sizeof(sample->evsel->core.attr))));
 	XPUSHs(sv_2mortal(newSVpvn((const char *)sample, sizeof(*sample))));
 	XPUSHs(sv_2mortal(newSVpvn((const char *)sample->raw_data, sample->raw_size)));
 	PUTBACK;
@@ -461,13 +459,12 @@ static void perl_process_event_generic(union perf_event *event,
 
 static void perl_process_event(union perf_event *event,
 			       struct perf_sample *sample,
-			       struct evsel *evsel,
 			       struct addr_location *al,
 			       struct addr_location *addr_al)
 {
-	scripting_context__update(scripting_context, event, sample, evsel, al, addr_al);
-	perl_process_tracepoint(sample, evsel, al);
-	perl_process_event_generic(event, sample, evsel);
+	scripting_context__update(scripting_context, event, sample, al, addr_al);
+	perl_process_tracepoint(sample, al);
+	perl_process_event_generic(event, sample);
 }
 
 static void run_start_sub(void)
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 9f5c6e5e6ebe..63d04b051846 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -390,7 +390,6 @@ static unsigned long get_offset(struct symbol *sym, struct addr_location *al)
 }
 
 static PyObject *python_process_callchain(struct perf_sample *sample,
-					 struct evsel *evsel,
 					 struct addr_location *al)
 {
 	PyObject *pylist;
@@ -651,11 +650,9 @@ static PyObject *get_sample_value_as_tuple(struct sample_read_value *value,
 	return t;
 }
 
-static void set_sample_read_in_dict(PyObject *dict_sample,
-					 struct perf_sample *sample,
-					 struct evsel *evsel)
+static void set_sample_read_in_dict(PyObject *dict_sample, struct perf_sample *sample)
 {
-	u64 read_format = evsel->core.attr.read_format;
+	u64 read_format = sample->evsel->core.attr.read_format;
 	PyObject *values;
 	unsigned int i;
 
@@ -741,11 +738,10 @@ static void regs_map(struct regs_dump *regs, uint64_t mask, uint16_t e_machine,
 
 static int set_regs_in_dict(PyObject *dict,
 			     struct perf_sample *sample,
-			     struct evsel *evsel,
 			     uint16_t e_machine,
 			     uint32_t e_flags)
 {
-	struct perf_event_attr *attr = &evsel->core.attr;
+	struct perf_event_attr *attr = &sample->evsel->core.attr;
 
 	int size = (__sw_hweight64(attr->sample_regs_intr) * MAX_REG_SIZE) + 1;
 	char *bf = NULL;
@@ -831,7 +827,6 @@ static void python_process_sample_flags(struct perf_sample *sample, PyObject *di
 }
 
 static PyObject *get_perf_sample_dict(struct perf_sample *sample,
-					 struct evsel *evsel,
 					 struct addr_location *al,
 					 struct addr_location *addr_al,
 					 PyObject *callchain)
@@ -839,6 +834,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	PyObject *dict, *dict_sample, *brstack, *brstacksym;
 	uint16_t e_machine = EM_HOST;
 	uint32_t e_flags = EF_HOST;
+	struct evsel *evsel = sample->evsel;
 
 	dict = PyDict_New();
 	if (!dict)
@@ -871,7 +867,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 			PyLong_FromUnsignedLongLong(sample->phys_addr));
 	pydict_set_item_string_decref(dict_sample, "addr",
 			PyLong_FromUnsignedLongLong(sample->addr));
-	set_sample_read_in_dict(dict_sample, sample, evsel);
+	set_sample_read_in_dict(dict_sample, sample);
 	pydict_set_item_string_decref(dict_sample, "weight",
 			PyLong_FromUnsignedLongLong(sample->weight));
 	pydict_set_item_string_decref(dict_sample, "ins_lat",
@@ -928,7 +924,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	if (al->thread)
 		e_machine = thread__e_machine(al->thread, /*machine=*/NULL, &e_flags);
 
-	if (set_regs_in_dict(dict, sample, evsel, e_machine, e_flags))
+	if (set_regs_in_dict(dict, sample, e_machine, e_flags))
 		Py_FatalError("Failed to setting regs in dict");
 
 	return dict;
@@ -936,7 +932,6 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 
 #ifdef HAVE_LIBTRACEEVENT
 static void python_process_tracepoint(struct perf_sample *sample,
-				      struct evsel *evsel,
 				      struct addr_location *al,
 				      struct addr_location *addr_al)
 {
@@ -954,6 +949,7 @@ static void python_process_tracepoint(struct perf_sample *sample,
 	const char *comm = thread__comm_str(al->thread);
 	const char *default_handler_name = "trace_unhandled";
 	DECLARE_BITMAP(events_defined, TRACE_EVENT_TYPE_MAX);
+	struct evsel *evsel = sample->evsel;
 
 	bitmap_zero(events_defined, TRACE_EVENT_TYPE_MAX);
 
@@ -995,7 +991,7 @@ static void python_process_tracepoint(struct perf_sample *sample,
 	PyTuple_SetItem(t, n++, context);
 
 	/* ip unwinding */
-	callchain = python_process_callchain(sample, evsel, al);
+	callchain = python_process_callchain(sample, al);
 	/* Need an additional reference for the perf_sample dict */
 	Py_INCREF(callchain);
 
@@ -1051,7 +1047,7 @@ static void python_process_tracepoint(struct perf_sample *sample,
 		PyTuple_SetItem(t, n++, dict);
 
 	if (get_argument_count(handler) == (int) n + 1) {
-		all_entries_dict = get_perf_sample_dict(sample, evsel, al, addr_al,
+		all_entries_dict = get_perf_sample_dict(sample, al, addr_al,
 			callchain);
 		PyTuple_SetItem(t, n++,	all_entries_dict);
 	} else {
@@ -1070,7 +1066,6 @@ static void python_process_tracepoint(struct perf_sample *sample,
 }
 #else
 static void python_process_tracepoint(struct perf_sample *sample __maybe_unused,
-				      struct evsel *evsel __maybe_unused,
 				      struct addr_location *al __maybe_unused,
 				      struct addr_location *addr_al __maybe_unused)
 {
@@ -1465,7 +1460,6 @@ static int python_process_call_return(struct call_return *cr, u64 *parent_db_id,
 }
 
 static void python_process_general_event(struct perf_sample *sample,
-					 struct evsel *evsel,
 					 struct addr_location *al,
 					 struct addr_location *addr_al)
 {
@@ -1488,8 +1482,8 @@ static void python_process_general_event(struct perf_sample *sample,
 		Py_FatalError("couldn't create Python tuple");
 
 	/* ip unwinding */
-	callchain = python_process_callchain(sample, evsel, al);
-	dict = get_perf_sample_dict(sample, evsel, al, addr_al, callchain);
+	callchain = python_process_callchain(sample, al);
+	dict = get_perf_sample_dict(sample, al, addr_al, callchain);
 
 	PyTuple_SetItem(t, n++, dict);
 	if (_PyTuple_Resize(&t, n) == -1)
@@ -1502,24 +1496,23 @@ static void python_process_general_event(struct perf_sample *sample,
 
 static void python_process_event(union perf_event *event,
 				 struct perf_sample *sample,
-				 struct evsel *evsel,
 				 struct addr_location *al,
 				 struct addr_location *addr_al)
 {
 	struct tables *tables = &tables_global;
 
-	scripting_context__update(scripting_context, event, sample, evsel, al, addr_al);
+	scripting_context__update(scripting_context, event, sample, al, addr_al);
 
-	switch (evsel->core.attr.type) {
+	switch (sample->evsel->core.attr.type) {
 	case PERF_TYPE_TRACEPOINT:
-		python_process_tracepoint(sample, evsel, al, addr_al);
+		python_process_tracepoint(sample, al, addr_al);
 		break;
 	/* Reserve for future process_hw/sw/raw APIs */
 	default:
 		if (tables->db_export_mode)
 			db_export__sample(&tables->dbe, event, sample, al, addr_al);
 		else
-			python_process_general_event(sample, evsel, al, addr_al);
+			python_process_general_event(sample, al, addr_al);
 	}
 }
 
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index fa850e44cb46..dc584ac316a3 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -103,12 +103,11 @@ int script_spec__for_each(int (*cb)(struct scripting_ops *ops, const char *spec)
 void scripting_context__update(struct scripting_context *c,
 			       union perf_event *event,
 			       struct perf_sample *sample,
-			       struct evsel *evsel,
 			       struct addr_location *al,
 			       struct addr_location *addr_al)
 {
 #ifdef HAVE_LIBTRACEEVENT
-	const struct tep_event *tp_format = evsel__tp_format(evsel);
+	const struct tep_event *tp_format = evsel__tp_format(sample->evsel);
 
 	c->pevent = tp_format ? tp_format->tep : NULL;
 #else
@@ -117,7 +116,6 @@ void scripting_context__update(struct scripting_context *c,
 	c->event_data = sample->raw_data;
 	c->event = event;
 	c->sample = sample;
-	c->evsel = evsel;
 	c->al = al;
 	c->addr_al = addr_al;
 }
@@ -134,7 +132,6 @@ static int stop_script_unsupported(void)
 
 static void process_event_unsupported(union perf_event *event __maybe_unused,
 				      struct perf_sample *sample __maybe_unused,
-				      struct evsel *evsel __maybe_unused,
 				      struct addr_location *al __maybe_unused,
 				      struct addr_location *addr_al __maybe_unused)
 {
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 914d9b69ed62..720121c74f1d 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -94,7 +94,6 @@ struct scripting_ops {
 	int (*stop_script) (void);
 	void (*process_event) (union perf_event *event,
 			       struct perf_sample *sample,
-			       struct evsel *evsel,
 			       struct addr_location *al,
 			       struct addr_location *addr_al);
 	void (*process_switch)(union perf_event *event,
@@ -124,7 +123,6 @@ struct scripting_context {
 	void *event_data;
 	union perf_event *event;
 	struct perf_sample *sample;
-	struct evsel *evsel;
 	struct addr_location *al;
 	struct addr_location *addr_al;
 	struct perf_session *session;
@@ -133,7 +131,6 @@ struct scripting_context {
 void scripting_context__update(struct scripting_context *scripting_context,
 			       union perf_event *event,
 			       struct perf_sample *sample,
-			       struct evsel *evsel,
 			       struct addr_location *al,
 			       struct addr_location *addr_al);
 
-- 
2.53.0.239.g8d8fc8a987-goog

