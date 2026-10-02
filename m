Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522CA3B52E4
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790965606; cv=none; b=lHLl6NMqlMgQhHwm/nJqFN6ZKZyPieuuZqGR+Sh2K0rlZtxJkX2+JSV54HH+GUeds8m7aFi8QtJe6rcIjfaqjl1Rcmemm3Ruf432FSQyuWkUwm3edSUHQA5bZIK2Vx2P54SS0RRuzb74DBjBf6Uqo/Tg4rSbheXIvTe0NgMlOOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790965606; c=relaxed/simple;
	bh=THnXJBqCEp76bRi/zt48ou4hhkXWnfuDOAk76GDqaJY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=s6mGESQnaRrlJo9XQ7PkOLbkLBsO+7+Zwv//xw/Re9bW32bo8HV526bDaXL3x0ofjqVd33/Z5RyHSDYOkmIEcUZPLh69N8WARDV5N6FkyiOCh0HA4fecXmsal72u5RWVFvIXfuxjeVHr/Zb3XdpjQ2sgCKwHGCLCU2Otdw/DohY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ShTbp4RA; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ShTbp4RA"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-34ef0362d95so2048631eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 11:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790965603; x=1791570403; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LTqnSjYHzwSjBDIa+/XWyePVjmJ8ZrQHbfovXuP56sk=;
        b=ShTbp4RAiHGZsEXzgBINHfrFOneb65dKKHBnVL8sT1xMDnwbXZi0uB1au0cphZcVRE
         wT2HTIdD33xPOIhbOVxMGa88qG/7ygXMTVua/bM3h5c+tRROHachtte+bu8CcaErN2Bh
         23qkR7WdISjdfCJC5BFfGsz1iA1YwxLRGjSC7NNepk+iXXIEtUlwZLJvxfptzg3MixQm
         gostOm97qXlhlEva4ywIXc1CmeaPdEe6omjFx8GXYszRK2QdH+yPChVPJpNur1A52821
         b4QzPpJklvj1U9xgRjVttbBCVeGDdqE53C5WfcU1NEk8zQEoRy8RwzWa5mAS8JFmt1tK
         UFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790965603; x=1791570403;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LTqnSjYHzwSjBDIa+/XWyePVjmJ8ZrQHbfovXuP56sk=;
        b=SaYFa7cbKKKiA/js6iGXOM1MDdseVnX5tz0xZt0scEgKfX+vvyqtRIQBn9HDGuxi73
         btLpVQ9+0BzyJ4YECIRpzp408rDFiHWMwbA1pIDJEAe28TarRV4/raRh9wEVm26mZWpz
         oKhts9xPz472d1RNPtdIvLZXFg4BeBYAQWCEnFDpPEPTiIQtsreLVWy2SfdllcILiKwV
         OOuBQDDyH2syHqsg4DTx8ilgSYK9pnJS9CMbkdYo5zyAESRkXzIktB4Rs0X7LIJZTfep
         qCWp0tmoH2hppP5cX7cXGcW78JWeW3fa+nN2yUGyEnpcDIYJs/OqaLgN8iJctUxmsREJ
         5ZUg==
X-Forwarded-Encrypted: i=1; AKwUvBzaYU3WbvN9VAxLt/dolQTKhyElst8qQm++yjA1Q7EuKCtvt/PuvNKW/jH6V90BtcftJQLdmCbJTUukA+ntkeLJ@vger.kernel.org
X-Gm-Message-State: AFq9FYLr1yJQADaZb36w5HCkKhYVv7YQmZcErGTG8s8/gu+sNGfM7F7g
	De1JgAxh2xnHvOg6MAgHyQ3zEMXBH8k4LfkkXhphg2uIMgHZnb1g6ejJ3rcjQr1jZdeyEOUzvCb
	aQ92uf6zORQ==
X-Received: from dycac13.prod.google.com ([2002:a05:7301:550d:b0:34d:ccf:1fc9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:50d7:b0:34c:e77c:f930
 with SMTP id 5a478bee46e88-35111525897mr534532eec.36.1790965602869; Fri, 02
 Oct 2026 11:26:42 -0700 (PDT)
Date: Fri,  2 Oct 2026 11:26:11 -0700
In-Reply-To: <20261002182624.3259797-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261002182624.3259797-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002182624.3259797-3-irogers@google.com>
Subject: [PATCH v1 02/13] perf python: Quietly stop processing events when a
 callback raises
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Changbin Du <changbin.du@huawei.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, tanze <tanze@kylinos.cn>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a session callback raises a python exception the callback returned
-1 causing reader__read_event() to print a "processing failed for event
of type: ..." error. This is redundant with the python exception that is
raised from process_events(), and corrupts the display of a TUI that
raises from a callback to deliberately stop processing, such as when
cancelling a background load.

Instead set session_done so that processing stops and return success,
the pending exception is then raised by process_events(). As a single
event may still cause further callbacks, for example multiple
call_return callbacks followed by a sample callback, skip calling python
while an exception is pending.

The session whose callback raised resets session_done after processing
so later sessions process all their events. As session_done is a global,
a session processed concurrently in another thread may be stopped early
too. Count the stop requests so that such a session raises an error
rather than silently dropping events.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 149 ++++++++++++++++++++++++++++++++-------
 1 file changed, 122 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 95140dfaef9c..5b4963d5784d 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -4120,6 +4120,11 @@ struct pyrf_session {
 	 */
 	u64 call_return_last_db_id;
 	u64 sample_last_db_id;
+	/**
+	 * @callback_raised: A python callback raised an exception and requested
+	 * that event processing stops, see pyrf_session__callback_raised().
+	 */
+	bool callback_raised;
 	char *vmlinux_name;
 	char *kallsyms_name;
 	char *symfs;
@@ -4439,6 +4444,55 @@ static PyObject *pyrf_call_return__new(struct call_return *cr)
 	return (PyObject *)pevent;
 }
 
+/*
+ * Number of times a python callback has requested that event processing
+ * stops, see pyrf_session__callback_raised().
+ */
+static unsigned int pyrf_session__stop_requests;
+
+/*
+ * A python callback raised an exception.
+ *
+ * Returning an error to the session code would cause reader__read_event() to
+ * print a "processing failed for event of type: ..." error to stderr. This is
+ * noise, and in the case of a TUI corrupts the display, when a callback raises
+ * to deliberately stop processing (e.g. cancelling a background load) and the
+ * error message is redundant with the python exception that is raised anyway.
+ *
+ * Instead request that event processing stops by setting session_done and
+ * return success. The exception remains pending (PyErr_Occurred()) and
+ * pyrf_session__find_thread_events() returns NULL so python raises it.
+ *
+ * Note, session_done is a process-global rather than per-session. Were
+ * multiple sessions processing events concurrently in different python
+ * threads then an exception in one would stop all of them. Only the session
+ * whose callback raised clears session_done, and the other sessions detect
+ * the stop request, using pyrf_session__stop_requests, and raise an error
+ * rather than silently dropping events.
+ */
+static int pyrf_session__callback_raised(struct pyrf_session *psession)
+{
+	psession->callback_raised = true;
+	pyrf_session__stop_requests++;
+	session_done = 1;
+	return 0;
+}
+
+/*
+ * session_done stops the reader loops, the ordered_events and deferred sample
+ * flushes, and auxtrace__flush_events(), but some callbacks may still happen
+ * after a callback has raised. For example, a single sample may generate
+ * multiple call_return callbacks, and perf_session__flush_thread_stacks()
+ * delivers call returns for the remaining stack entries (skipping it would
+ * only defer those callbacks until the threads are deleted). Calling into
+ * python with an exception pending is an error, and the events would be
+ * discarded anyway, so callbacks check this and skip calling python.
+ */
+static bool pyrf_session__exception_pending(void)
+{
+	return PyErr_Occurred() != NULL;
+}
+
 static int pyrf_session__call_return_process(struct call_return *cr,
 					     u64 *parent_db_id,
 					     void *data)
@@ -4446,7 +4500,7 @@ static int pyrf_session__call_return_process(struct call_return *cr,
 	struct pyrf_session *psession = data;
 	PyObject *pyevent, *ret;
 
-	if (!psession->call_return)
+	if (!psession->call_return || pyrf_session__exception_pending())
 		return 0;
 
 	if (!cr->db_id)
@@ -4463,12 +4517,10 @@ static int pyrf_session__call_return_process(struct call_return *cr,
 		return -1;
 
 	ret = PyObject_CallFunctionObjArgs(psession->call_return, pyevent, NULL);
-	if (!ret) {
-		Py_DECREF(pyevent);
-		return -1;
-	}
-	Py_DECREF(ret);
 	Py_DECREF(pyevent);
+	if (!ret)
+		return pyrf_session__callback_raised(psession);
+	Py_DECREF(ret);
 	return 0;
 }
 
@@ -4480,6 +4532,9 @@ static int pyrf_session_tool__sample(const struct perf_tool *tool,
 	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
 	u64 sample_db_id = ++psession->sample_last_db_id;
 
+	if (pyrf_session__exception_pending())
+		return 0;
+
 	if (psession->crp) {
 		struct addr_location al, addr_al;
 		struct thread *thread = NULL;
@@ -4510,6 +4565,10 @@ static int pyrf_session_tool__sample(const struct perf_tool *tool,
 
 		addr_location__exit(&addr_al);
 		addr_location__exit(&al);
+
+		/* A call_return callback may have raised. */
+		if (pyrf_session__exception_pending())
+			return 0;
 	}
 
 	if (psession->sample) {
@@ -4524,7 +4583,7 @@ static int pyrf_session_tool__sample(const struct perf_tool *tool,
 		ret = PyObject_CallFunction(psession->sample, "O", pyevent);
 		Py_DECREF(pyevent);
 		if (!ret)
-			return -1;
+			return pyrf_session__callback_raised(psession);
 		Py_DECREF(ret);
 	}
 	return 0;
@@ -4536,9 +4595,19 @@ static int pyrf_session_tool__context_switch(const struct perf_tool *tool,
 					     struct machine *machine)
 {
 	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
-	PyObject *pyevent = pyrf_event__new(event, sample->evsel, psession->session, machine, NULL);
+	PyObject *pyevent;
 	PyObject *ret;
 
+	if (pyrf_session__exception_pending()) {
+		/*
+		 * Skip calling python, but keep the machine's thread state
+		 * consistent as perf_event__process_switch() would have been
+		 * called had no python callback been registered.
+		 */
+		return perf_event__process_switch(tool, event, sample, machine);
+	}
+
+	pyevent = pyrf_event__new(event, sample->evsel, psession->session, machine, NULL);
 	if (perf_event__process_switch(tool, event, sample, machine) < 0) {
 		Py_XDECREF(pyevent);
 		return -1;
@@ -4548,12 +4617,10 @@ static int pyrf_session_tool__context_switch(const struct perf_tool *tool,
 		return -ENOMEM;
 
 	ret = PyObject_CallFunction(psession->context_switch, "O", pyevent);
-	if (!ret) {
-		Py_DECREF(pyevent);
-		return -1;
-	}
-	Py_DECREF(ret);
 	Py_DECREF(pyevent);
+	if (!ret)
+		return pyrf_session__callback_raised(psession);
+	Py_DECREF(ret);
 	return 0;
 }
 
@@ -4563,21 +4630,23 @@ static int pyrf_session_tool__stat(const struct perf_tool *tool,
 {
 	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
 	struct evsel *evsel = evlist__id2evsel(session->evlist, event->stat.id);
-	PyObject *pyevent = pyrf_event__new(event, /*evsel=*/NULL, psession->session,
-					    /*machine=*/NULL, NULL);
 	const char *name = evsel ? evsel__name(evsel) : "unknown";
+	PyObject *pyevent;
 	PyObject *ret;
 
+	if (pyrf_session__exception_pending())
+		return 0;
+
+	pyevent = pyrf_event__new(event, /*evsel=*/NULL, psession->session,
+				  /*machine=*/NULL, NULL);
 	if (pyevent == NULL)
 		return -ENOMEM;
 
 	ret = PyObject_CallFunction(psession->stat, "Oz", pyevent, name);
-	if (!ret) {
-		Py_DECREF(pyevent);
-		return -1;
-	}
-	Py_DECREF(ret);
 	Py_DECREF(pyevent);
+	if (!ret)
+		return pyrf_session__callback_raised(psession);
+	Py_DECREF(ret);
 	return 0;
 }
 
@@ -4586,20 +4655,22 @@ static int pyrf_session_tool__stat_round(const struct perf_tool *tool,
 					 union perf_event *event)
 {
 	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
-	PyObject *pyevent = pyrf_event__new(event, /*evsel=*/NULL, psession->session,
-					    /*machine=*/NULL, NULL);
+	PyObject *pyevent;
 	PyObject *ret;
 
+	if (pyrf_session__exception_pending())
+		return 0;
+
+	pyevent = pyrf_event__new(event, /*evsel=*/NULL, psession->session,
+				  /*machine=*/NULL, NULL);
 	if (pyevent == NULL)
 		return -ENOMEM;
 
 	ret = PyObject_CallFunction(psession->stat, "Oz", pyevent, NULL);
-	if (!ret) {
-		Py_DECREF(pyevent);
-		return -1;
-	}
-	Py_DECREF(ret);
 	Py_DECREF(pyevent);
+	if (!ret)
+		return pyrf_session__callback_raised(psession);
+	Py_DECREF(ret);
 	return 0;
 }
 
@@ -4680,6 +4751,7 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 	psession->crp = NULL;
 	psession->call_return_last_db_id = 0;
 	psession->sample_last_db_id = 0;
+	psession->callback_raised = false;
 	psession->vmlinux_name = NULL;
 	psession->kallsyms_name = NULL;
 	psession->symfs = NULL;
@@ -4847,11 +4919,34 @@ static void pyrf_session__delete(struct pyrf_session *psession)
 
 static PyObject *pyrf_session__find_thread_events(struct pyrf_session *psession)
 {
+	unsigned int stop_requests = pyrf_session__stop_requests;
 	int err;
 
 	CHECK_INITIALIZED(psession->session, "session");
 
+	psession->callback_raised = false;
 	err = perf_session__process_events(psession->session);
+	if (psession->callback_raised) {
+		/*
+		 * Clear the early stop requested by this session's callback, in
+		 * pyrf_session__callback_raised(), so that later sessions process
+		 * all their events. That function is the only writer of
+		 * session_done in the python module, so resetting it here after
+		 * processing is sufficient and there is no need to also reset it
+		 * before processing.
+		 */
+		session_done = 0;
+	} else if (stop_requests != pyrf_session__stop_requests && !PyErr_Occurred()) {
+		/*
+		 * A callback of a session being processed concurrently, in
+		 * another thread, raised and set session_done which may have
+		 * stopped processing this session's events early. Raise an error
+		 * rather than silently dropping events.
+		 */
+		PyErr_SetString(PyExc_RuntimeError,
+				"Processing events may have stopped early as a callback of a concurrently processed session raised an exception");
+		return NULL;
+	}
 
 	if (PyErr_Occurred())
 		return NULL;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

