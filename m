Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F303C943A
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 05:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781328477; cv=none; b=hFmKcbk/XUNiHO48jWZJ0Pszzvyjj5SFtxQAMUMS9EAH0WmgdNzXWt0dVi2lMue86XW3NU4qwRDbuMLLKwjNwpSZlQYKXgLMuzeQmmdMZEr2tmurNWna8IAewjqStlz6D8j1aTT1b403Xlbq0qO2fnMSwzcZkepGbeOuxepkJ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781328477; c=relaxed/simple;
	bh=W14IQBD1Fw5uiaU+SdAUjBSVDEnbaoC23ccEMqma3Co=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rx75C3b9gagQugFdrlnLvv5GZOOnekx/fv1QpjETq1zS5JvuiVbaZN9IJFerGK7tsVi7LuPk2XkOqt5qoLEgc01GkZPcVuWJCa0ZT6MHrcidha+1RGm0zhwXzP5V97uVV/i2Eao850S0aueVase6qmY2G1fCaT0+QL+1+WZvRU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BRlcesI+; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BRlcesI+"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-307625ee07fso3069951eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781328472; x=1781933272; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bBx9+uCNEQFJQwE2tadOy4OG5EMm4+qbqOG9vi99E4E=;
        b=BRlcesI+iv1Quap5IHYEqPYdqgLJp0nljifvJimJSRGFEXWhNXwD6XXQM+YpfDkEiE
         BUKupQVpjB3sLSTvpIBRQL+kO6KdOcxrlUeB+j5qbGEzxK8FabKYc97uhcJA43OQZDXU
         FEGr9c6hVApvTtqF6V4u2BONsdcVnlpfY73u/tj87wPaTlerNL8mZ2iyq8UypLlMufLI
         zKU4QuJwqc88bh4jXQHqUZe4qBeVdqGgsbm1mB9OQEjIpDylXRh+z45InZd+/eAoMVAt
         5B2A6lZw0Ur6MbdSgxtVcbFIQbXBhNgFbg+HpgXrThJFqdSaXyqxizNssbu/qq/JRElg
         RDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781328472; x=1781933272;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBx9+uCNEQFJQwE2tadOy4OG5EMm4+qbqOG9vi99E4E=;
        b=og7OoNT07QfrpaPEb6uInWUj5K21jdvm/7yS0AnGjrUUmymihM+U8yVQ1OM5TXEVaO
         sj4+UM6Ml1jTsDCQfd4YWoHK/ncjRHEe+cY5EnrgF6nCAiyNKSFmRbCXtj5DSRXusgGn
         mfPrCLOUtbQSEmc9jWoKrT3t45OOZUCcIw5bLpfmO0mI54ffoeqCQGDO6HQkDhtUDsVs
         gcvlu6WeCI+3UUK1Pc/JWhoRp20uLYFM0GHZvjnB0s2ANIkrCIdNbmqemPA6yUEB6X1e
         s7ZAxLG9ptXY9JdP+0WWM1EDcnRzNYHCUANPNvH4FyEE2F8GVQ1EAhAVz2M9cdla3PZ7
         YarQ==
X-Forwarded-Encrypted: i=1; AFNElJ9UitMl9ipslwR1TjrRWN4mou1odCOijmW6903bZi6E0djY+P21OL08Lu6TU4g2U6P2udbCsviQ62rpLbzH1hK/@vger.kernel.org
X-Gm-Message-State: AOJu0YwfMxSLG+dgdv8ZpUV4FyrcCmXSK+1IXAwqCkZ5Otr9hc3Aub2d
	xmeZrYkLg5UeH9pNH+/YT6mbYbZQPKOZr2pcdIhfMtGOWhPTvYhs86OU0uW5De/wMKzqjcSAMFC
	1uU89yp/JGg==
X-Received: from dybnq20.prod.google.com ([2002:a05:7300:e514:b0:2f9:af7:5043])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5341:b0:2fc:9ae6:e5a8
 with SMTP id 5a478bee46e88-3082009c394mr3889642eec.20.1781328471518; Fri, 12
 Jun 2026 22:27:51 -0700 (PDT)
Date: Fri, 12 Jun 2026 22:27:13 -0700
In-Reply-To: <20260613052722.1424093-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612221211.1221305-1-irogers@google.com> <20260613052722.1424093-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613052722.1424093-13-irogers@google.com>
Subject: [PATCH v16 12/20] perf python: Add mmap2 event
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
v12:
 - Used `copy_size` to bound `max_len` for NUL termination of mmap2 and comm events to fix an out-of-bounds write.
---
 tools/perf/util/python.c | 155 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index e4731c94deba..b3dca4b63844 100644
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
@@ -873,6 +1020,9 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 	if (copy_size < sizeof(pevent->event))
 		memset((char *)&pevent->event + copy_size, 0, sizeof(pevent->event) - copy_size);
 
+	if (event->header.type == PERF_RECORD_MMAP2)
+		pevent->event.mmap2.filename[sizeof(pevent->event.mmap2.filename) - 1] = '\0';
+
 	perf_sample__init(&pevent->sample, /*all=*/true);
 	pevent->al_resolved = false;
 	addr_location__init(&pevent->al);
@@ -3315,6 +3465,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_mmap_event__type);
 	PyModule_AddObject(module, "mmap_event", (PyObject *)&pyrf_mmap_event__type);
 
+	Py_INCREF(&pyrf_mmap2_event__type);
+	PyModule_AddObject(module, "mmap2_event", (PyObject *)&pyrf_mmap2_event__type);
+
 	Py_INCREF(&pyrf_lost_event__type);
 	PyModule_AddObject(module, "lost_event", (PyObject *)&pyrf_lost_event__type);
 
-- 
2.54.0.1136.gdb2ca164c4-goog

