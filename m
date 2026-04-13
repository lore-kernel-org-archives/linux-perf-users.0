Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D47537F8DC
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053573; cv=none; b=lgngMMYOyEvjGM3VsLIdP9WwM4ypQvkM5xjCvLdV/R/8lOZJfVg2G4Oh5szwKcg79QeYvNynaKYiD1LI/DlLvaVd/6Ly8karYH4eECodqV3R7CmJS+D+AvV6hIWhJCI70DE7TrT9eeibn3Cn2SdQKLXusVVQ3qmvKiemS9LkQ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053573; c=relaxed/simple;
	bh=aBbjJYLIj3JlgKicEywSIpg8iDK6n1Z+4CENOSS2sBg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eUcy7HKzou0ZQBoj1p3XSSV2COBLdhwpVt8C29jPvPzseo0srCJGGUC2wFSP7C0SK2xv5Cfn4ikLCVtqgJ748iOnQFyGsBu+80//G7snTjdCL8I4USxxuDwTkzxwCgYXhY75V1Vxc/Sa0X8YMzEzqogUzAEYzqceF0l7WJhLAlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RAGZQKmf; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RAGZQKmf"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12711ec96fbso12929113c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 21:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776053563; x=1776658363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kwG1W24uSzD7B/5afwjU1RRK24gDCHemA91ftb3lUmE=;
        b=RAGZQKmfMaZH9oQ7n2CUo3W+AimN79JfRtJn1UD3mdmKYZXDeFc7VlXOU+5b1BipOy
         uVhCcBLVMH1J509KUNS+So59Fi1TAlCcTrK/UP2UPD7UgGN+/j0aWRzQjacR2YMHoLlL
         z/RArTkb4lxcOQfGgthgIvYFde/D3dlBjjOAcVe3S6sJU/mcGIUG/D8I+A1O0FO/Gpd3
         +85qaoKVLr7aefycZGHp0EYuX3VxwnEExsRdZH8cagibh8opZiFgjfewO+gIxqJrTZjt
         vLeMFxdEEsFdUwl6y99ShaU/ZJiuNuskLwtawnUDb2uY8o/6iljfkxQQOH4b2veeSIod
         25Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053563; x=1776658363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kwG1W24uSzD7B/5afwjU1RRK24gDCHemA91ftb3lUmE=;
        b=gg6rqyTOWt3/21iNYI2Fz0Tseh4KL+r255BA4BKPd2F50kS6EBLsjSlE7PK15ndyj3
         K/cExp/BmEl8/bTPTF1O4o5U6yUGaFALWQOzI3gZq4uZDi4zn8t6hq6gS+0frlDYOH4a
         r6hAj26XUh9yk0Ky6GxUZQefmq/YNLUsHNugB6gi1QObItIZtKhqlScDBEQgBTUIKydn
         7HiLRET0wxpFOMdBZ8XCVXcdcOI7ZYn2hlRRjlLb7KA0lTq5iyB8B4SdWl2GTbpt8+38
         X8j6l0ruj8VuVruhdJL+qSU95yaCxeS3PuEdARXmWb2/3aIOM6RhlAYE7y46KyRGyjmc
         qsfw==
X-Forwarded-Encrypted: i=1; AJvYcCVPyIC1MhIYg+t+tiBiiXAO6NY1k0oJLmRZ744DtZvJZppgQkmjfNJXDwDQj5BldRDYiS/CRCr6QSbSbhxpneNU@vger.kernel.org
X-Gm-Message-State: AOJu0YxLhkiVw+D66mSnvUaAiGim6551gFcqCw7fVvVESZgHDu0MzrLe
	6sPOTuRFF8iEXlWsqOcQ6Nbm/jKzPF88JuLLotuLLBIrNtoUV/Vfp2SAgIhf8iuMZQWtPcz366N
	zhBfAol5ZPg==
X-Received: from dld26.prod.google.com ([2002:a05:7022:31a:b0:12b:fe5e:215])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6629:b0:12a:713b:896a
 with SMTP id a92af1059eb24-12c34eedc16mr7356350c88.17.1776053562666; Sun, 12
 Apr 2026 21:12:42 -0700 (PDT)
Date: Sun, 12 Apr 2026 21:11:30 -0700
In-Reply-To: <20260413041143.1736055-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413012227.1089445-1-irogers@google.com> <20260413041143.1736055-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413041143.1736055-21-irogers@google.com>
Subject: [PATCH v12 20/33] perf script: Don't pass evsel with sample
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
index 6ea739f20495..c8ecf250577f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2418,12 +2418,13 @@ static bool show_event(struct perf_sample *sample,
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
@@ -2715,9 +2716,9 @@ static int process_sample_event(const struct perf_tool *tool,
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
@@ -2893,9 +2894,12 @@ static int print_event_with_time(const struct perf_tool *tool,
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
index af0d514b2397..7a18ea4b7d50 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -257,7 +257,6 @@ static void define_event_symbols(struct tep_event *event,
 }
 
 static SV *perl_process_callchain(struct perf_sample *sample,
-				  struct evsel *evsel __maybe_unused,
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
index 9e1069ec0578..8edd2f36e5a9 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -390,7 +390,6 @@ static unsigned long get_offset(struct symbol *sym, struct addr_location *al)
 }
 
 static PyObject *python_process_callchain(struct perf_sample *sample,
-					 struct evsel *evsel __maybe_unused,
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
2.53.0.1213.gd9a14994de-goog

