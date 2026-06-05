Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A52643E4BA
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686954; cv=none; b=pZ3xYqF36JFZMpXvOToa40Z6vIQycEe1z8A8ubADGB4tCNZdwghpxmFcjjMxqdK+A4RQv8EEjM4UgYZdB51MLzJluT7fzk62o1BkqlUpu88YUiBZM4PS1E570F64XoxC7ri+VyAUvXwXEREFGjrCqUd2O0RgGmdCtzfpcQoKwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686954; c=relaxed/simple;
	bh=U7spDKLZ/CrAjXi/ONRntH2QqOQ1Quu+3IaH5HruPS8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KMCkokC3vtdDI4yUZTOhwdfu1qXvOYWUg1XP//nx2Fe113EZIJ59ZWM7KN0XTu9hOYFTTv0IYOP38wCaQ/1nS1jWt9XjE65/Ola7AKbuHV/MAt46Q4G1zE3aO47MQcYO4XMrFxbISQr7uLgSt0nY4Coxafbx+95wxIP71bP+hJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VmcMJEnp; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VmcMJEnp"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137e49e896aso2118944c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 12:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780686941; x=1781291741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GeoFUPBCkgb9fOH4gILRdoMyWxPWNRHxpgPNdda6x2I=;
        b=VmcMJEnp7e5ivIR4/gEdkbBjp21Z16d46zL8DCQzo8qkO8iMkZ1D1f7UuJx2tmWCIA
         RmgzBOdtUgzbmaND6ek+SG7I6NGnZeg4bu4FMhedhBAjkQbSjsls9zkiXRi0IcCIO0Nm
         KYqQtItwKUOZyPilA059Y0aAz/90RQXz9vefh/l3/vdYPFRZhH+zOoW2E4ZtCNabYtap
         VNcgh0VwIY8GgPQb92xHwuPqOeFshh7EdDr7y26u2et0IMUmheNGlLQ8Yy0WJ7bjNphx
         g1fM7WAp0ZVIycht22eQbSF7xRUPrTqQ/1a2Novt/GvVjSSsI3Of6A22yGy0ujrH1wxy
         WeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780686941; x=1781291741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GeoFUPBCkgb9fOH4gILRdoMyWxPWNRHxpgPNdda6x2I=;
        b=OwWjGahoKgIvLiLlF/FLeISgEnblpm0YLN1tS8D3GC8sG0ukfJP6Nk92ZzHhm9iMhv
         lJmGDYCtmgGkyrbAa4j5YaDFe7RDvoQwJWnCtMGXtGKXE1LbBJFjTJ1zHey/oK5hLeHI
         KGKl69PeNC+apb2a5eMf/4We3z8xsQx55LxKZU3XjBHUYBxVasUh6/msAU+/Kh/db0eX
         Tk69sQGu6g8WmCsFmdYp9nb+O2FdMalFnF/rx2NO1wxPmAtz6HJIS31mjiqU2JyYJuGU
         7xbiTAwUqrJspBt39OPPjc7GuvZ1HNW4jew+/79IAvR8TqGmuO9/6YDEQp3+gZvJQlPD
         h3mw==
X-Forwarded-Encrypted: i=1; AFNElJ/NTstGY6tyr818dWiN/CMMZy1Ixr6JbgpgoOesr6uqO0QMl546XvbtTjnVOqvpFyRZT1FgwytwoAAR9/m5D+zl@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeuz39Vh5RIjqo0/Nbryjf8N580lluVKMkjB5O45mtaK9++a6a
	HiBfy1rl2mv1P69JrxD3/4zSKnJwRU81cPCCyvZajJhp4NpMSYPyzi5dNZFcXjr76jMAj9QG0wY
	dtVsZVgmS7A==
X-Received: from dlkk22.prod.google.com ([2002:a05:7022:6096:b0:138:738:f96c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4b:b0:12d:c3d8:1f95
 with SMTP id a92af1059eb24-13807d13a37mr1436568c88.4.1780686940849; Fri, 05
 Jun 2026 12:15:40 -0700 (PDT)
Date: Fri,  5 Jun 2026 12:14:53 -0700
In-Reply-To: <20260605191500.2477026-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605074003.1730715-1-irogers@google.com> <20260605191500.2477026-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605191500.2477026-13-irogers@google.com>
Subject: [PATCH v11 12/19] perf python: Add mmap2 event
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

If mmap is handled so should mmap2 events. Add support as a distinct
python event type.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 162 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 161 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index acd280794f66..074dc1d9f225 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -133,7 +133,7 @@ static const char pyrf_mmap_event__doc[] = PyDoc_STR("perf mmap event object.");
 static PyMemberDef pyrf_mmap_event__members[] = {
 	sample_members
 	member_def(perf_event_header, type, T_UINT, "event type"),
-	member_def(perf_event_header, misc, T_UINT, "event misc"),
+	member_def(perf_event_header, misc, T_USHORT, "event misc"),
 	member_def(perf_record_mmap, pid, T_UINT, "event pid"),
 	member_def(perf_record_mmap, tid, T_UINT, "event tid"),
 	member_def(perf_record_mmap, start, T_ULONGLONG, "start of the map"),
@@ -174,6 +174,149 @@ static PyTypeObject pyrf_mmap_event__type = {
 	.tp_repr	= (reprfunc)pyrf_mmap_event__repr,
 };
 
+static const char pyrf_mmap2_event__doc[] = PyDoc_STR("perf mmap2 event object.");
+
+static PyObject *pyrf_mmap2_event__get_maj(PyObject *self, void *closure __maybe_unused)
+{
+	struct pyrf_event *pevent = (void *)self;
+
+	if (pevent->event.header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)
+		Py_RETURN_NONE;
+
+	return PyLong_FromUnsignedLong(pevent->event.mmap2.maj);
+}
+
+static PyObject *pyrf_mmap2_event__get_min(PyObject *self, void *closure __maybe_unused)
+{
+	struct pyrf_event *pevent = (void *)self;
+
+	if (pevent->event.header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)
+		Py_RETURN_NONE;
+
+	return PyLong_FromUnsignedLong(pevent->event.mmap2.min);
+}
+
+static PyObject *pyrf_mmap2_event__get_ino(PyObject *self, void *closure __maybe_unused)
+{
+	struct pyrf_event *pevent = (void *)self;
+
+	if (pevent->event.header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)
+		Py_RETURN_NONE;
+
+	return PyLong_FromUnsignedLongLong(pevent->event.mmap2.ino);
+}
+
+static PyObject *pyrf_mmap2_event__get_ino_generation(PyObject *self, void *closure __maybe_unused)
+{
+	struct pyrf_event *pevent = (void *)self;
+
+	if (pevent->event.header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)
+		Py_RETURN_NONE;
+
+	return PyLong_FromUnsignedLongLong(pevent->event.mmap2.ino_generation);
+}
+
+static PyObject *pyrf_mmap2_event__get_build_id(PyObject *self, void *closure __maybe_unused)
+{
+	struct pyrf_event *pevent = (void *)self;
+
+	if (!(pevent->event.header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID))
+		Py_RETURN_NONE;
+
+	int size = pevent->event.mmap2.build_id_size;
+
+	if (size > 20)
+		size = 20;
+
+	return PyBytes_FromStringAndSize((const char *)pevent->event.mmap2.build_id, size);
+}
+
+static PyGetSetDef pyrf_mmap2_event__getset[] = {
+	{
+		.name = "evsel",
+		.get = pyrf_event__get_evsel,
+		.set = NULL,
+		.doc = "tracking event.",
+	},
+	{
+		.name = "maj",
+		.get = pyrf_mmap2_event__get_maj,
+		.set = NULL,
+		.doc = "major number.",
+	},
+	{
+		.name = "min",
+		.get = pyrf_mmap2_event__get_min,
+		.set = NULL,
+		.doc = "minor number.",
+	},
+	{
+		.name = "ino",
+		.get = pyrf_mmap2_event__get_ino,
+		.set = NULL,
+		.doc = "inode number.",
+	},
+	{
+		.name = "ino_generation",
+		.get = pyrf_mmap2_event__get_ino_generation,
+		.set = NULL,
+		.doc = "inode generation.",
+	},
+	{
+		.name = "build_id",
+		.get = pyrf_mmap2_event__get_build_id,
+		.set = NULL,
+		.doc = "binary build ID.",
+	},
+	{ .name = NULL, },
+};
+
+static PyMemberDef pyrf_mmap2_event__members[] = {
+	sample_members
+	member_def(perf_event_header, type, T_UINT, "event type"),
+	member_def(perf_event_header, misc, T_USHORT, "event misc"),
+	member_def(perf_record_mmap2, pid, T_UINT, "event pid"),
+	member_def(perf_record_mmap2, tid, T_UINT, "event tid"),
+	member_def(perf_record_mmap2, start, T_ULONGLONG, "start of the map"),
+	member_def(perf_record_mmap2, len, T_ULONGLONG, "map length"),
+	member_def(perf_record_mmap2, pgoff, T_ULONGLONG, "page offset"),
+	member_def(perf_record_mmap2, prot, T_UINT, "protection"),
+	member_def(perf_record_mmap2, flags, T_UINT, "flags"),
+	member_def(perf_record_mmap2, filename, T_STRING_INPLACE, "backing store"),
+	{ .name = NULL, },
+};
+
+static PyObject *pyrf_mmap2_event__repr(const struct pyrf_event *pevent)
+{
+	PyObject *ret;
+	char *s;
+
+	if (asprintf(&s, "{ type: mmap2, pid: %u, tid: %u, start: %#" PRI_lx64 ", "
+			 "length: %#" PRI_lx64 ", offset: %#" PRI_lx64 ", "
+			 "flags: %#x, prot: %#x, filename: %s }",
+		     pevent->event.mmap2.pid, pevent->event.mmap2.tid,
+		     pevent->event.mmap2.start, pevent->event.mmap2.len,
+		     pevent->event.mmap2.pgoff, pevent->event.mmap2.flags,
+		     pevent->event.mmap2.prot, pevent->event.mmap2.filename) < 0)
+		return PyErr_NoMemory();
+
+	ret = PyUnicode_FromString(s);
+	free(s);
+	return ret;
+}
+
+static PyTypeObject pyrf_mmap2_event__type = {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name	= "perf.mmap2_event",
+	.tp_basicsize	= sizeof(struct pyrf_event),
+	.tp_dealloc	= (destructor)pyrf_event__delete,
+	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
+	.tp_doc		= pyrf_mmap2_event__doc,
+	.tp_members	= pyrf_mmap2_event__members,
+	.tp_getset	= pyrf_mmap2_event__getset,
+	.tp_repr	= (reprfunc)pyrf_mmap2_event__repr,
+};
+
 static const char pyrf_task_event__doc[] = PyDoc_STR("perf task (fork/exit) event object.");
 
 static PyMemberDef pyrf_task_event__members[] = {
@@ -799,6 +942,9 @@ static int pyrf_event__setup_types(void)
 	int err;
 
 	err = PyType_Ready(&pyrf_mmap_event__type);
+	if (err < 0)
+		goto out;
+	err = PyType_Ready(&pyrf_mmap2_event__type);
 	if (err < 0)
 		goto out;
 	err = PyType_Ready(&pyrf_lost_event__type);
@@ -828,6 +974,7 @@ static int pyrf_event__setup_types(void)
 
 static PyTypeObject *pyrf_event__type[] = {
 	[PERF_RECORD_MMAP]	 = &pyrf_mmap_event__type,
+	[PERF_RECORD_MMAP2]	 = &pyrf_mmap2_event__type,
 	[PERF_RECORD_LOST]	 = &pyrf_lost_event__type,
 	[PERF_RECORD_COMM]	 = &pyrf_comm_event__type,
 	[PERF_RECORD_EXIT]	 = &pyrf_task_event__type,
@@ -875,6 +1022,16 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 				 offsetof(struct perf_record_mmap, filename);
 
 		pevent->event.mmap.filename[max_len - 1] = '\0';
+	} else if (event->header.type == PERF_RECORD_MMAP2) {
+		/* Ensure '\0' string termination. */
+		size_t max_len = pevent->event.header.size - offsetof(struct perf_record_mmap2, filename);
+
+		pevent->event.mmap2.filename[max_len - 1] = '\0';
+	} else if (event->header.type == PERF_RECORD_COMM) {
+		/* Ensure '\0' string termination. */
+		size_t max_len = pevent->event.header.size - offsetof(struct perf_record_comm, comm);
+
+		pevent->event.comm.comm[max_len - 1] = '\0';
 	}
 
 	perf_sample__init(&pevent->sample, /*all=*/true);
@@ -3304,6 +3461,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_mmap_event__type);
 	PyModule_AddObject(module, "mmap_event", (PyObject *)&pyrf_mmap_event__type);
 
+	Py_INCREF(&pyrf_mmap2_event__type);
+	PyModule_AddObject(module, "mmap2_event", (PyObject *)&pyrf_mmap2_event__type);
+
 	Py_INCREF(&pyrf_lost_event__type);
 	PyModule_AddObject(module, "lost_event", (PyObject *)&pyrf_lost_event__type);
 
-- 
2.54.0.1032.g2f8565e1d1-goog

