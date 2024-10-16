Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F25189906
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 04:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052682; cv=none; b=TTw3hixUwMk1ERjJo21Iqje/IidNhrA34iEkMjWgRE8WZa9OWkRMRmxP2EnC8MHTSvVpIzNVmncM2rBiBOqwZNSj5sZ92D7Q6S8xgeFl/VtjieawvLnDqeRUQ87EgQsPoEo6SvCnhOjw8sNhpqt4fUUi/g3hBncSIJzVflTve5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052682; c=relaxed/simple;
	bh=7HLL/EuiPte+FBmbhpfQpx2M+PoIuhEyQToTclsBA9Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=W3NhMKIggshR8ok6Da7MJvlSxhe2wmXy41QhRSpjA3LwXnxvI/cD/STSHuB4+UQQHMibG/Kyj9K+sc4BqU3WN1VSm+fqm89q5MhnBrD2wQiKffxxSUPh15qzRMWKZcYoaF/gXkhrCoe0OzVksoStit5+gXYrh7rbsmdbkbHjlIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jxK3APKQ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jxK3APKQ"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2968b2ab27so680238276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 21:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729052679; x=1729657479; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nufIfERJADmt3WQfqYt2dWiE1lZ61+Z8d0TsyXgm8QA=;
        b=jxK3APKQ0CpKf4gNqHqoTXzKfqidj5gtKdyV3qCprxGSVa57iq/8Qs/FUbTw9kh8hT
         X3UBD6B6T1t4w5ShkvKMG4ikE+6WkA+3EqxXMshNr9hQ6XufDFW0ZiLumO+LpStHJhWQ
         etadb5eF1G5fVtFxkwR5UeHf5tjabMF8Rq69U2zJESA1e5WRVlpQ89ZizZYGQ8UVYktx
         Pz3Dm4DmB53DBYAqFOD6dHRMVvN2ZtnRPAXc++i7vP6NjQ5pd83ea65dHHkwj36LljaZ
         o67QzN580p2kwJULGaOIcw4pGecay4xl9uubxMnamAm4l934qeCy42oUttJmmwsNIEhG
         f3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729052679; x=1729657479;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nufIfERJADmt3WQfqYt2dWiE1lZ61+Z8d0TsyXgm8QA=;
        b=McI548G7Q5aNzhYLPypE96neVvI61T/fXslBXONoNKPQIcygvHx92nAHeNuKz7FZQl
         012CplaWRNywA2G3pk0tQO0VxY7MZnnet5yS86Cgs+C6Vn8PNIg5XzXnl16vYL979jHd
         vuTHpcI3QvoK6zzqLn63TbPdNmZmWEaCJRSxN9OLV+V9jSQ9zRv6/Ubh1jms43H4ZCTG
         5dErV77WYwUPFNTfu/nbADVK08AnDzdWgYDcGnu7NRJdNqJdokZTsABfCpBIJmJ+H2aq
         4ZsUGNHGMlItlv9KASV9gQBJvrmyg6qlrdFT/voDIiGBFYwA+JPtLD4R2IQWfUtpDDuj
         TUNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2FjZ5GGL8YyhbpEfbl3AHVmtAQ6S8VrOPrQ4BF6YsQf6CFXyl8jKMssfut5He4iToMCq7AoQEJuNnSLgyb6eP@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdcb/a1s23fLBjYkK9h8cCUynYJ16359/BGyBNsG1ZALmEAaKT
	kvdx7+2reeW5Buw0OJu5cPEGSq5vFZvRvnM59r2+tRVNPOGdxDHypEPVnpazNmB3WxaCFhfrX3M
	vKk8RWA==
X-Google-Smtp-Source: AGHT+IFPX2vMWw8+RmSgjCEtcGdDp/ZV2Q0WFowHXgsi1nor82D1RzJMQdIEu7N1tY3siN0xWu2P77TA71+X
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a5b:f09:0:b0:e29:ad0:a326 with SMTP id
 3f1490d57ef6-e2976fbb30bmr18606276.0.1729052679003; Tue, 15 Oct 2024 21:24:39
 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:24:01 -0700
In-Reply-To: <20241016042415.7552-1-irogers@google.com>
Message-Id: <20241016042415.7552-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016042415.7552-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 02/16] perf python: Constify variables and parameters
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Opportunistically constify variables and parameters when possible.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 55 +++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 02279ab4967c..13dad27169a0 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -62,7 +62,7 @@ struct pyrf_event {
 	sample_member_def(sample_period, period, T_ULONGLONG, "event period"),		 \
 	sample_member_def(sample_cpu, cpu, T_UINT, "event cpu"),
 
-static char pyrf_mmap_event__doc[] = PyDoc_STR("perf mmap event object.");
+static const char pyrf_mmap_event__doc[] = PyDoc_STR("perf mmap event object.");
 
 static PyMemberDef pyrf_mmap_event__members[] = {
 	sample_members
@@ -77,7 +77,7 @@ static PyMemberDef pyrf_mmap_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_mmap_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_mmap_event__repr(const struct pyrf_event *pevent)
 {
 	PyObject *ret;
 	char *s;
@@ -106,7 +106,7 @@ static PyTypeObject pyrf_mmap_event__type = {
 	.tp_repr	= (reprfunc)pyrf_mmap_event__repr,
 };
 
-static char pyrf_task_event__doc[] = PyDoc_STR("perf task (fork/exit) event object.");
+static const char pyrf_task_event__doc[] = PyDoc_STR("perf task (fork/exit) event object.");
 
 static PyMemberDef pyrf_task_event__members[] = {
 	sample_members
@@ -119,7 +119,7 @@ static PyMemberDef pyrf_task_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_task_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_task_event__repr(const struct pyrf_event *pevent)
 {
 	return PyUnicode_FromFormat("{ type: %s, pid: %u, ppid: %u, tid: %u, "
 				   "ptid: %u, time: %" PRI_lu64 "}",
@@ -141,7 +141,7 @@ static PyTypeObject pyrf_task_event__type = {
 	.tp_repr	= (reprfunc)pyrf_task_event__repr,
 };
 
-static char pyrf_comm_event__doc[] = PyDoc_STR("perf comm event object.");
+static const char pyrf_comm_event__doc[] = PyDoc_STR("perf comm event object.");
 
 static PyMemberDef pyrf_comm_event__members[] = {
 	sample_members
@@ -152,7 +152,7 @@ static PyMemberDef pyrf_comm_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_comm_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_comm_event__repr(const struct pyrf_event *pevent)
 {
 	return PyUnicode_FromFormat("{ type: comm, pid: %u, tid: %u, comm: %s }",
 				   pevent->event.comm.pid,
@@ -170,7 +170,7 @@ static PyTypeObject pyrf_comm_event__type = {
 	.tp_repr	= (reprfunc)pyrf_comm_event__repr,
 };
 
-static char pyrf_throttle_event__doc[] = PyDoc_STR("perf throttle event object.");
+static const char pyrf_throttle_event__doc[] = PyDoc_STR("perf throttle event object.");
 
 static PyMemberDef pyrf_throttle_event__members[] = {
 	sample_members
@@ -181,9 +181,10 @@ static PyMemberDef pyrf_throttle_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_throttle_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_throttle_event__repr(const struct pyrf_event *pevent)
 {
-	struct perf_record_throttle *te = (struct perf_record_throttle *)(&pevent->event.header + 1);
+	const struct perf_record_throttle *te = (const struct perf_record_throttle *)
+		(&pevent->event.header + 1);
 
 	return PyUnicode_FromFormat("{ type: %sthrottle, time: %" PRI_lu64 ", id: %" PRI_lu64
 				   ", stream_id: %" PRI_lu64 " }",
@@ -201,7 +202,7 @@ static PyTypeObject pyrf_throttle_event__type = {
 	.tp_repr	= (reprfunc)pyrf_throttle_event__repr,
 };
 
-static char pyrf_lost_event__doc[] = PyDoc_STR("perf lost event object.");
+static const char pyrf_lost_event__doc[] = PyDoc_STR("perf lost event object.");
 
 static PyMemberDef pyrf_lost_event__members[] = {
 	sample_members
@@ -210,7 +211,7 @@ static PyMemberDef pyrf_lost_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_lost_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_lost_event__repr(const struct pyrf_event *pevent)
 {
 	PyObject *ret;
 	char *s;
@@ -236,7 +237,7 @@ static PyTypeObject pyrf_lost_event__type = {
 	.tp_repr	= (reprfunc)pyrf_lost_event__repr,
 };
 
-static char pyrf_read_event__doc[] = PyDoc_STR("perf read event object.");
+static const char pyrf_read_event__doc[] = PyDoc_STR("perf read event object.");
 
 static PyMemberDef pyrf_read_event__members[] = {
 	sample_members
@@ -245,7 +246,7 @@ static PyMemberDef pyrf_read_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_read_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_read_event__repr(const struct pyrf_event *pevent)
 {
 	return PyUnicode_FromFormat("{ type: read, pid: %u, tid: %u }",
 				   pevent->event.read.pid,
@@ -266,7 +267,7 @@ static PyTypeObject pyrf_read_event__type = {
 	.tp_repr	= (reprfunc)pyrf_read_event__repr,
 };
 
-static char pyrf_sample_event__doc[] = PyDoc_STR("perf sample event object.");
+static const char pyrf_sample_event__doc[] = PyDoc_STR("perf sample event object.");
 
 static PyMemberDef pyrf_sample_event__members[] = {
 	sample_members
@@ -274,7 +275,7 @@ static PyMemberDef pyrf_sample_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_sample_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_sample_event__repr(const struct pyrf_event *pevent)
 {
 	PyObject *ret;
 	char *s;
@@ -289,13 +290,13 @@ static PyObject *pyrf_sample_event__repr(struct pyrf_event *pevent)
 }
 
 #ifdef HAVE_LIBTRACEEVENT
-static bool is_tracepoint(struct pyrf_event *pevent)
+static bool is_tracepoint(const struct pyrf_event *pevent)
 {
 	return pevent->evsel->core.attr.type == PERF_TYPE_TRACEPOINT;
 }
 
 static PyObject*
-tracepoint_field(struct pyrf_event *pe, struct tep_format_field *field)
+tracepoint_field(const struct pyrf_event *pe, struct tep_format_field *field)
 {
 	struct tep_handle *pevent = field->event->tep;
 	void *data = pe->sample.raw_data;
@@ -384,7 +385,7 @@ static PyTypeObject pyrf_sample_event__type = {
 	.tp_getattro	= (getattrofunc) pyrf_sample_event__getattro,
 };
 
-static char pyrf_context_switch_event__doc[] = PyDoc_STR("perf context_switch event object.");
+static const char pyrf_context_switch_event__doc[] = PyDoc_STR("perf context_switch event object.");
 
 static PyMemberDef pyrf_context_switch_event__members[] = {
 	sample_members
@@ -394,7 +395,7 @@ static PyMemberDef pyrf_context_switch_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_context_switch_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_context_switch_event__repr(const struct pyrf_event *pevent)
 {
 	PyObject *ret;
 	char *s;
@@ -474,7 +475,7 @@ static PyTypeObject *pyrf_event__type[] = {
 	[PERF_RECORD_SWITCH_CPU_WIDE]  = &pyrf_context_switch_event__type,
 };
 
-static PyObject *pyrf_event__new(union perf_event *event)
+static PyObject *pyrf_event__new(const union perf_event *event)
 {
 	struct pyrf_event *pevent;
 	PyTypeObject *ptype;
@@ -542,7 +543,7 @@ static PySequenceMethods pyrf_cpu_map__sequence_methods = {
 	.sq_item   = pyrf_cpu_map__item,
 };
 
-static char pyrf_cpu_map__doc[] = PyDoc_STR("cpu map object.");
+static const char pyrf_cpu_map__doc[] = PyDoc_STR("cpu map object.");
 
 static PyTypeObject pyrf_cpu_map__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
@@ -611,7 +612,7 @@ static PySequenceMethods pyrf_thread_map__sequence_methods = {
 	.sq_item   = pyrf_thread_map__item,
 };
 
-static char pyrf_thread_map__doc[] = PyDoc_STR("thread map object.");
+static const char pyrf_thread_map__doc[] = PyDoc_STR("thread map object.");
 
 static PyTypeObject pyrf_thread_map__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
@@ -795,7 +796,7 @@ static PyMethodDef pyrf_evsel__methods[] = {
 	{ .ml_name = NULL, }
 };
 
-static char pyrf_evsel__doc[] = PyDoc_STR("perf event selector list object.");
+static const char pyrf_evsel__doc[] = PyDoc_STR("perf event selector list object.");
 
 static PyTypeObject pyrf_evsel__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
@@ -1078,7 +1079,7 @@ static PySequenceMethods pyrf_evlist__sequence_methods = {
 	.sq_item   = pyrf_evlist__item,
 };
 
-static char pyrf_evlist__doc[] = PyDoc_STR("perf event selector list object.");
+static const char pyrf_evlist__doc[] = PyDoc_STR("perf event selector list object.");
 
 static PyTypeObject pyrf_evlist__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
@@ -1100,10 +1101,12 @@ static int pyrf_evlist__setup_types(void)
 
 #define PERF_CONST(name) { #name, PERF_##name }
 
-static struct {
+struct perf_constant {
 	const char *name;
 	int	    value;
-} perf__constants[] = {
+};
+
+static const struct perf_constant perf__constants[] = {
 	PERF_CONST(TYPE_HARDWARE),
 	PERF_CONST(TYPE_SOFTWARE),
 	PERF_CONST(TYPE_TRACEPOINT),
-- 
2.47.0.rc1.288.g06298d1525-goog

