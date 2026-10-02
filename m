Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDAE46AA62
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790965614; cv=none; b=sgfAQ4zD+Rm6oQL/irNo9Tpg8dIQz7y89t567vdgif/MB+UrLhSunlHd3GZRqcUiQzMrsTVxhMot/f4ePZW2aYB96OOpB1JACnqyrnM2R90jtrHWrj4XsR2BA8+DHdmMNxTNy5t6mzqFIHffZmIDMkkJTeWhOlWkOCVT5Jqcf7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790965614; c=relaxed/simple;
	bh=kHlekYeOhVVzfUZY+53a/Yrg3B/ku2pzzEUdMTLQyrc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YT3o184Xgn2h3S0BcWozRSu92dbcj2pp6J/bU2DePJbVcD7trf+jP8GUgS3MH/px/Sdlzkl80FmDcLPh6XQb1Xk53YoL6NVeIFEtFYCiagsBpYP0dSsRC9h7tVYexMFcogfI+jpi66uNNNxP/6YUtJDsnNI+mWY7H8Z4pB3ikRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dwO7M/mE; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dwO7M/mE"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-34ef0362d95so2048816eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 11:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790965612; x=1791570412; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SoUVWKLvyKwZ/WoEswPXuvtdtAxHklaKFQftAKlcNvk=;
        b=dwO7M/mEbzKyRm1Rn23ACEPe2B+2S2/9m+Faf0iofNAq0yOzpdOELto9n2fyTTHNOJ
         U2lKS/6kAgohQcWYAjETXiy59Fgki00f4f2/tgqsx3U5ifUAUi019yXJ5MogL8UATCRN
         rvEuK4gdxWLJhqeoGhbOn4VsdXofaZG9+O62kNU1dBQ2DcFI04zGqRiBWEUU2JPkTviZ
         CUyN1APo1l/HaCWlklwyI14Xmv9KAB5u1/7ECnFf/B/zBV/g+v2Wb9Q6DcGiemS8JCki
         D6T2qKo+rTGmwiW4sraoG34ZjKKhUqgMt+6xKs8c/qQWudernjozZN9bbEr/pWIDvwWQ
         k7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790965612; x=1791570412;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SoUVWKLvyKwZ/WoEswPXuvtdtAxHklaKFQftAKlcNvk=;
        b=MRb8fxLZPUq8YJsh7aX08HFGH/cPEYaQr+4QrAMIPLAYGCvUrY9mh7Z5KJZnJISDub
         Nqi7yE140gmcR6/VAzbZPP7OUaAwqd+N2HqSIw23oME94lQv1taI0Ayeq8SBWaufzVxh
         AnEA9QAUNBVj55Rdp5At/8cr9PFFlOI9pnZXR5pA/qf8ZtsrIt60w3XQyq6P0aKGRZCc
         u0FA7uyEPNDi+Xk3R1z1ryePDgZmPUXeFm2/yjDKtqApUqwbDOpCUuhkcdb0gjc1jbdp
         3cTh4nwxrvrzEZyndZg4f/ch3gP0a9Almopv/PmnpWa1r/ZeiKUOawGpLmPHTOHrb2Vw
         vxsA==
X-Forwarded-Encrypted: i=1; AKwUvByoT6D2sA8Swo4tIsOqT5uNE6VPz1bXLxPrGk9RQo463H2r8N+YHpBsT8IDio97Tz5IUzEeVtfjhpQrgujONGeX@vger.kernel.org
X-Gm-Message-State: AFq9FYJPdMAz7mwR5J8ibtfj+iU38uDy0L7nWzsKXDJ1z83R7SkKoIrH
	YceVodB7Pxwhb5izd/Yb8ppv001KaoxpRCTTOb+oBQShG8H4GWpD/foRPIN0TRWt1p/VftFkTF3
	Aq5ZPK1aO9A==
X-Received: from dybb17.prod.google.com ([2002:a05:693c:6091:b0:33e:ce80:c3e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8801:20b0:34b:6d45:de57
 with SMTP id 5a478bee46e88-351113b59d8mr417086eec.9.1790965610857; Fri, 02
 Oct 2026 11:26:50 -0700 (PDT)
Date: Fri,  2 Oct 2026 11:26:14 -0700
In-Reply-To: <20261002182624.3259797-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261002182624.3259797-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002182624.3259797-6-irogers@google.com>
Subject: [PATCH v1 05/13] perf python: Release the GIL while processing
 session events
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

When a python session reads from a pipe, perf_session__new() and
perf_session__process_events() block waiting for data with the GIL held,
freezing any other python threads such as a TUI thread. Release the GIL
around both calls and acquire it with PyGILState_Ensure() in the tool and
call-return callbacks that invoke python.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 258 ++++++++++++++++++++++++++++++++-------
 1 file changed, 215 insertions(+), 43 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 251b7d517ad5..4eb17bdc5fd1 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -52,6 +52,7 @@
 #include "srccode.h"
 #include "srcline.h"
 #include "strbuf.h"
+#include "strlist.h"
 #include "symbol.h"
 #include "stat.h"
 #include "header.h"
@@ -4104,16 +4105,38 @@ static void pyrf_thread__delete(struct pyrf_thread *pthread)
 static PyObject *pyrf_thread__comm(PyObject *obj)
 {
 	struct pyrf_thread *pthread = (void *)obj;
-	const char *str;
+	struct thread *thread = pthread->thread;
+	bool has_comm = false;
+	char *str = NULL;
+	PyObject *ret;
 
-	CHECK_INITIALIZED(pthread->thread, "perf.thread");
+	CHECK_INITIALIZED(thread, "perf.thread");
 
-	str = thread__comm_str(pthread->thread);
+	/*
+	 * Copy the comm string under comm_lock so a concurrent PERF_RECORD_COMM
+	 * in perf_session__process_events() (which runs with the GIL released)
+	 * cannot free the old comm_str via comm__override() while it is being
+	 * read, and drop comm_lock before calling into the Python allocator.
+	 */
+	down_read(thread__comm_lock(thread));
+	if (!list_empty(thread__comm_list(thread))) {
+		const struct comm *comm;
+
+		comm = list_first_entry(thread__comm_list(thread), struct comm, list);
+		if (comm && comm__str(comm)) {
+			has_comm = true;
+			str = strdup(comm__str(comm));
+		}
+	}
+	up_read(thread__comm_lock(thread));
 
-	if (!str)
+	if (!has_comm)
 		Py_RETURN_NONE;
-
-	return PyUnicode_FromString(str);
+	if (!str)
+		return PyErr_NoMemory();
+	ret = PyUnicode_FromString(str);
+	free(str);
+	return ret;
 }
 
 static PyMethodDef pyrf_thread__methods[] = {
@@ -4211,6 +4234,8 @@ struct pyrf_session {
 	 * that event processing stops, see pyrf_session__callback_raised().
 	 */
 	bool callback_raised;
+	unsigned int callback_depth;
+	unsigned long callback_thread;
 	char *vmlinux_name;
 	char *kallsyms_name;
 	char *symfs;
@@ -4579,11 +4604,10 @@ static bool pyrf_session__exception_pending(void)
 	return PyErr_Occurred() != NULL;
 }
 
-static int pyrf_session__call_return_process(struct call_return *cr,
-					     u64 *parent_db_id,
-					     void *data)
+static int __pyrf_session__call_return_process(struct call_return *cr,
+					       u64 *parent_db_id,
+					       struct pyrf_session *psession)
 {
-	struct pyrf_session *psession = data;
 	PyObject *pyevent, *ret;
 
 	if (!psession->call_return || pyrf_session__exception_pending())
@@ -4610,6 +4634,38 @@ static int pyrf_session__call_return_process(struct call_return *cr,
 	return 0;
 }
 
+static PyGILState_STATE pyrf_session__callback_enter(struct pyrf_session *psession)
+{
+	PyGILState_STATE gstate = PyGILState_Ensure();
+
+	psession->callback_thread = PyThread_get_thread_ident();
+	psession->callback_depth++;
+	return gstate;
+}
+
+static void pyrf_session__callback_leave(struct pyrf_session *psession,
+					 PyGILState_STATE gstate)
+{
+	psession->callback_depth--;
+	PyGILState_Release(gstate);
+}
+
+/*
+ * Call returns may be processed during a sample callback, or when thread
+ * stacks are flushed, so acquire the GIL, see pyrf_session_tool__sample().
+ */
+static int pyrf_session__call_return_process(struct call_return *cr,
+					     u64 *parent_db_id,
+					     void *data)
+{
+	struct pyrf_session *psession = data;
+	PyGILState_STATE gstate = pyrf_session__callback_enter(psession);
+	int ret = __pyrf_session__call_return_process(cr, parent_db_id, psession);
+
+	pyrf_session__callback_leave(psession, gstate);
+	return ret;
+}
+
 static int pyrf_session__call_event(struct pyrf_session *psession, PyObject *callback,
 				    PyObject *pyevent, const char *extra_arg, bool has_extra_arg)
 {
@@ -4645,10 +4701,10 @@ static int pyrf_session__call_event(struct pyrf_session *psession, PyObject *cal
 	return 0;
 }
 
-static int pyrf_session_tool__sample(const struct perf_tool *tool,
-				     union perf_event *event,
-				     struct perf_sample *sample,
-				     struct machine *machine)
+static int __pyrf_session_tool__sample(const struct perf_tool *tool,
+				       union perf_event *event,
+				       struct perf_sample *sample,
+				       struct machine *machine)
 {
 	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
 	u64 sample_db_id = ++psession->sample_last_db_id;
@@ -4706,10 +4762,10 @@ static int pyrf_session_tool__sample(const struct perf_tool *tool,
 	return 0;
 }
 
-static int pyrf_session_tool__context_switch(const struct perf_tool *tool,
-					     union perf_event *event,
-					     struct perf_sample *sample,
-					     struct machine *machine)
+static int __pyrf_session_tool__context_switch(const struct perf_tool *tool,
+					       union perf_event *event,
+					       struct perf_sample *sample,
+					       struct machine *machine)
 {
 	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
 	PyObject *pyevent;
@@ -4736,9 +4792,9 @@ static int pyrf_session_tool__context_switch(const struct perf_tool *tool,
 					/*extra_arg=*/NULL, /*has_extra_arg=*/false);
 }
 
-static int pyrf_session_tool__stat(const struct perf_tool *tool,
-				   struct perf_session *session,
-				   union perf_event *event)
+static int __pyrf_session_tool__stat(const struct perf_tool *tool,
+				     struct perf_session *session,
+				     union perf_event *event)
 {
 	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
 	struct evsel *evsel = evlist__id2evsel(session->evlist, event->stat.id);
@@ -4757,9 +4813,9 @@ static int pyrf_session_tool__stat(const struct perf_tool *tool,
 					name, /*has_extra_arg=*/true);
 }
 
-static int pyrf_session_tool__stat_round(const struct perf_tool *tool,
-					 struct perf_session *session __maybe_unused,
-					 union perf_event *event)
+static int __pyrf_session_tool__stat_round(const struct perf_tool *tool,
+					   struct perf_session *session __maybe_unused,
+					   union perf_event *event)
 {
 	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
 	PyObject *pyevent;
@@ -4776,6 +4832,84 @@ static int pyrf_session_tool__stat_round(const struct perf_tool *tool,
 					/*extra_arg=*/NULL, /*has_extra_arg=*/true);
 }
 
+/*
+ * The session currently inside perf_session__new() or
+ * perf_session__process_events() with the GIL released. Because symbol_conf
+ * and session_done are process-globals and perf_session is not thread-safe,
+ * only one session may be active at a time. Modified with the GIL held.
+ */
+static struct pyrf_session *pyrf_session__active;
+
+static bool pyrf_session__check_not_busy(struct pyrf_session *psession)
+{
+	if (pyrf_session__active == psession &&
+	    (!psession->callback_depth ||
+	     psession->callback_thread != PyThread_get_thread_ident())) {
+		PyErr_SetString(PyExc_RuntimeError,
+				"perf.session is busy processing events in another thread");
+		return false;
+	}
+	return true;
+}
+
+/*
+ * The GIL is released while events are processed, see
+ * pyrf_session__find_thread_events(), so that other python threads can run,
+ * such as a UI thread while a session reads from a pipe that may block. The
+ * tool callbacks that use python acquire the GIL, PyGILState_Ensure() is
+ * reentrant so nested callbacks, like call returns during a sample, work.
+ */
+
+static int pyrf_session_tool__sample(const struct perf_tool *tool,
+				     union perf_event *event,
+				     struct perf_sample *sample,
+				     struct machine *machine)
+{
+	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
+	PyGILState_STATE gstate = pyrf_session__callback_enter(psession);
+	int ret = __pyrf_session_tool__sample(tool, event, sample, machine);
+
+	pyrf_session__callback_leave(psession, gstate);
+	return ret;
+}
+
+static int pyrf_session_tool__context_switch(const struct perf_tool *tool,
+					     union perf_event *event,
+					     struct perf_sample *sample,
+					     struct machine *machine)
+{
+	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
+	PyGILState_STATE gstate = pyrf_session__callback_enter(psession);
+	int ret = __pyrf_session_tool__context_switch(tool, event, sample, machine);
+
+	pyrf_session__callback_leave(psession, gstate);
+	return ret;
+}
+
+static int pyrf_session_tool__stat(const struct perf_tool *tool,
+				   struct perf_session *session,
+				   union perf_event *event)
+{
+	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
+	PyGILState_STATE gstate = pyrf_session__callback_enter(psession);
+	int ret = __pyrf_session_tool__stat(tool, session, event);
+
+	pyrf_session__callback_leave(psession, gstate);
+	return ret;
+}
+
+static int pyrf_session_tool__stat_round(const struct perf_tool *tool,
+					 struct perf_session *session,
+					 union perf_event *event)
+{
+	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
+	PyGILState_STATE gstate = pyrf_session__callback_enter(psession);
+	int ret = __pyrf_session_tool__stat_round(tool, session, event);
+
+	pyrf_session__callback_leave(psession, gstate);
+	return ret;
+}
+
 static PyObject *pyrf_session__find_thread(struct pyrf_session *psession, PyObject *args)
 {
 	struct machine *machine;
@@ -4784,6 +4918,8 @@ static PyObject *pyrf_session__find_thread(struct pyrf_session *psession, PyObje
 	int pid, tid = -1;
 
 	CHECK_INITIALIZED(psession->session, "session");
+	if (!pyrf_session__check_not_busy(psession))
+		return NULL;
 
 	if (!PyArg_ParseTuple(args, "i|i", &pid, &tid))
 		return NULL;
@@ -4854,6 +4990,8 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 	psession->call_return_last_db_id = 0;
 	psession->sample_last_db_id = 0;
 	psession->callback_raised = false;
+	psession->callback_depth = 0;
+	psession->callback_thread = 0;
 	psession->vmlinux_name = NULL;
 	psession->kallsyms_name = NULL;
 	psession->symfs = NULL;
@@ -4936,7 +5074,6 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 			PyErr_NoMemory();
 			goto err_out;
 		}
-		symbol_conf.vmlinux_name = psession->vmlinux_name;
 	}
 
 	if (!kallsyms_str)
@@ -4947,7 +5084,6 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 			PyErr_NoMemory();
 			goto err_out;
 		}
-		symbol_conf.kallsyms_name = psession->kallsyms_name;
 	}
 
 	if (!symfs_str)
@@ -4958,16 +5094,7 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 			PyErr_NoMemory();
 			goto err_out;
 		}
-		symbol_conf.symfs = psession->symfs;
-	}
-
-	session = perf_session__new(&pdata->data, &psession->tool);
-	if (IS_ERR(session)) {
-		PyErr_Format(PyExc_IOError, "failed to create session: %ld", PTR_ERR(session));
-		goto err_out;
 	}
-	psession->session = session;
-	psession->session->itrace_synth_opts = &psession->itrace_opts;
 
 	if (!itrace_str)
 		itrace_str = getenv("PERF_ITRACE");
@@ -4975,18 +5102,43 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 		memset(&psession->itrace_opts, 0, sizeof(psession->itrace_opts));
 		if (itrace_do_parse_synth_opts(&psession->itrace_opts, itrace_str, 0) < 0) {
 			PyErr_SetString(PyExc_ValueError, "Failed to parse itrace options");
-			Py_DECREF(psession);
-			return NULL;
+			goto err_out;
 		}
 	}
 
+	if (pyrf_session__active) {
+		PyErr_SetString(PyExc_RuntimeError,
+				"Another perf.session is currently active");
+		goto err_out;
+	}
+
+	symbol_conf.vmlinux_name = psession->vmlinux_name;
+	symbol_conf.kallsyms_name = psession->kallsyms_name;
+	symbol_conf.symfs = psession->symfs ?: "";
 	symbol_conf.use_callchain = true;
 	symbol_conf.show_kernel_path = true;
 	symbol_conf.inline_name = false;
+
+	/* Reading the header of a pipe may block, let other python threads run. */
+	pyrf_session__active = psession;
+	Py_BEGIN_ALLOW_THREADS
+	session = perf_session__new(&pdata->data, &psession->tool);
+	Py_END_ALLOW_THREADS
+	pyrf_session__active = NULL;
+	if (!psession->kallsyms_name && symbol_conf.kallsyms_name)
+		psession->kallsyms_name = (char *)symbol_conf.kallsyms_name;
+	if (IS_ERR(session)) {
+		PyErr_Format(PyExc_IOError, "failed to create session: %ld", PTR_ERR(session));
+		goto err_out;
+	}
+	psession->session = session;
+	psession->session->itrace_synth_opts = &psession->itrace_opts;
 	if (symbol__init(perf_session__env(session)) < 0) {
 		PyErr_SetString(PyExc_OSError, "perf: symbol__init failed");
 		goto err_out;
 	}
+	if (psession->symfs && !symbol_conf.symfs[0])
+		zfree(&psession->symfs);
 
 	return (PyObject *)psession;
 err_out:
@@ -4997,14 +5149,16 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 static void pyrf_session__delete(struct pyrf_session *psession)
 {
 	perf_session__delete(psession->session);
-	if (symbol_conf.vmlinux_name == psession->vmlinux_name)
-		symbol_conf.vmlinux_name = NULL;
+	if (!pyrf_session__active) {
+		if (symbol_conf.vmlinux_name == psession->vmlinux_name)
+			symbol_conf.vmlinux_name = NULL;
+		if (symbol_conf.kallsyms_name == psession->kallsyms_name)
+			symbol_conf.kallsyms_name = NULL;
+		if (symbol_conf.symfs == psession->symfs)
+			symbol_conf.symfs = "";
+	}
 	free(psession->vmlinux_name);
-	if (symbol_conf.kallsyms_name == psession->kallsyms_name)
-		symbol_conf.kallsyms_name = NULL;
 	free(psession->kallsyms_name);
-	if (symbol_conf.symfs == psession->symfs)
-		symbol_conf.symfs = "";
 	free(psession->symfs);
 	free(psession->itrace_opts.vm_tm_corr_args);
 	free(psession->itrace_opts.cpu_bitmap);
@@ -5025,9 +5179,23 @@ static PyObject *pyrf_session__find_thread_events(struct pyrf_session *psession)
 	int err;
 
 	CHECK_INITIALIZED(psession->session, "session");
+	if (pyrf_session__active) {
+		PyErr_SetString(PyExc_RuntimeError,
+				"Another perf.session is currently active");
+		return NULL;
+	}
+
+	symbol_conf.vmlinux_name = psession->vmlinux_name;
+	symbol_conf.kallsyms_name = psession->kallsyms_name;
+	symbol_conf.symfs = psession->symfs ?: "";
 
 	psession->callback_raised = false;
+	/* Callbacks that use python acquire the GIL, see pyrf_session_tool__sample(). */
+	pyrf_session__active = psession;
+	Py_BEGIN_ALLOW_THREADS
 	err = perf_session__process_events(psession->session);
+	Py_END_ALLOW_THREADS
+	pyrf_session__active = NULL;
 	if (psession->callback_raised) {
 		/*
 		 * Clear the early stop requested by this session's callback, in
@@ -5089,6 +5257,8 @@ static PyObject *pyrf_session__getattro(struct pyrf_session *psession, PyObject
 		PyErr_SetString(PyExc_ValueError, "session not initialized");
 		return NULL;
 	}
+	if (!pyrf_session__check_not_busy(psession))
+		return NULL;
 	if (!strcmp(name_str, "e_machine"))
 		return PyLong_FromLong(perf_session__e_machine(psession->session,
 							       /*e_flags=*/NULL));
@@ -5139,6 +5309,8 @@ static int pyrf_session__setattro(struct pyrf_session *psession, PyObject *attr_
 		PyErr_SetString(PyExc_ValueError, "session not initialized");
 		return -1;
 	}
+	if (!pyrf_session__check_not_busy(psession))
+		return -1;
 	return PyObject_GenericSetAttr((PyObject *) psession, attr_name, value);
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

