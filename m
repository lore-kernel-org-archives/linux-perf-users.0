Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5547DFB0
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645258; cv=none; b=Dq4yf0Ep/UM7haL+MXorJZkVgPBNhhhDEt9Nfni3BB8MYIyYdygAEsvbdJZxT0tI4f99eaWx9o2BCdKopUd7N5vAfLDrchC20vKj8fOgrNwrE/lxkwQAiyBclfu/LtMBSWOzDzGnaFrylk+FVZUB3fXtJ01LtdQZc3ftn2ep0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645258; c=relaxed/simple;
	bh=CHhqad4B9v7a7aQRC7Tv2N3+qwQ4ZXs50HwsBDM9uj0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VrUWhM5rrrGa+aTpygzduGT++hs1TsTNatn0wL+YlGF1PxarkMdAjfgzfXk76M8kHeWK2s+B9YYVZBCY722XXxvVzt5jbCmSAT7fRPUz4tv6gleYGf+M3MJ9wCgm9xGJMjBxybxl3d1jkdLgQXKZfv5sqkRBaHNOgMvft01U+VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dtEOZ4+z; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dtEOZ4+z"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8422a0eee68so2261298b3a.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 00:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780645256; x=1781250056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNju1pKgljPHiHJhBv/DpdKMXmlQGvK1hwpjeGArHHQ=;
        b=dtEOZ4+zzBo8NOEQeLkMquYfayuR5wphMf9CElFCWeWomrsVy/Oo5k3Ueuqv0JepqC
         ozfPebvazdYl0tIkTrFf+oCETpbJTbT0Jc4sN4F0VY8yTnRE+y5KzH7rojgY2rFq0VNw
         Pu5ebDxxsxkhYHs3LwM9opWZnVHvZT5So9hwFNcTlXFcPaT/NDNiDKjSnkkcXKPGc2sY
         pJ8V4IfU6ob89kJA7ogVvsWG/fzkpP6VVysLfnxpWFIMrV1ymB7D/3Bq57b0mj6tA3QF
         sAZXgmlce5GRVg5G8hAF8jYBFkKE8AHNW1V9Zl6lN1pPvSHaOb6Fn+Dl35ci+rPZCe8g
         Vepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780645256; x=1781250056;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNju1pKgljPHiHJhBv/DpdKMXmlQGvK1hwpjeGArHHQ=;
        b=qd65Ny8Z/nLQCRPYNxyoKytjLdLN3s22EdiEBoErqNx5xpOOsNCiu9dQdukRSFu37x
         Kgi7XDmCBleg3EzWaZuFmLUwLOeoynUEPFQgnC5M61puDV8hDSWNsi4aW5hRwd+o4F8Z
         LnWjbVXi3aNZgxOD7AOx0gicn6E/YaVvg4g8j7joZKxUppO3AXMe04e9xjbtHZyShMr/
         aUu3mQVJmQokgXzuLq9jE+ZYu2LQUvvqKWNasdfU2vHrgbq6LkG49j1/6JgCjIgNyWwB
         TEtOzx21UhrIg9GPaSFbEaz949W0ibv+si24A5mJF4NylV9YrFmFYkbGYiZF6KiFo9Ms
         Uwig==
X-Forwarded-Encrypted: i=1; AFNElJ+0G8VXPtK1QR4ld1ZMUtJPl7ZNMYv7k74ThKlpbi4+VJ5Pd1IckpqYsXjOTdECZDy5RrzYxYXU8mxeczVA+yYh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx23CsoQhADEdWK6+OXgdzjuqmTcDhHQM8KnlyKa7lzGGEGiTh5
	5zrhw4xfqXReZ5CmxGyAAUv4MoEZVNLqDKA9+ztOCUbn4lFGaO26/nvrGp80oJ4+yhbNq/anF3o
	ARI7xSfruRw==
X-Received: from pfn35.prod.google.com ([2002:a05:6a00:a223:b0:842:b0e7:887d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4f8c:b0:842:3f9e:a72f
 with SMTP id d2e1a72fcca58-842b0c0bc4cmr2388159b3a.3.1780645255460; Fri, 05
 Jun 2026 00:40:55 -0700 (PDT)
Date: Fri,  5 Jun 2026 00:39:56 -0700
In-Reply-To: <20260605074003.1730715-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522220435.2378363-1-irogers@google.com> <20260605074003.1730715-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605074003.1730715-13-irogers@google.com>
Subject: [PATCH v10 12/19] perf python: Add mmap2 event
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
 tools/perf/util/python.c | 156 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 155 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index f7ab6f6faaf7..352331d73c58 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -131,7 +131,7 @@ static const char pyrf_mmap_event__doc[] = PyDoc_STR("perf mmap event object.");
 static PyMemberDef pyrf_mmap_event__members[] = {
 	sample_members
 	member_def(perf_event_header, type, T_UINT, "event type"),
-	member_def(perf_event_header, misc, T_UINT, "event misc"),
+	member_def(perf_event_header, misc, T_USHORT, "event misc"),
 	member_def(perf_record_mmap, pid, T_UINT, "event pid"),
 	member_def(perf_record_mmap, tid, T_UINT, "event tid"),
 	member_def(perf_record_mmap, start, T_ULONGLONG, "start of the map"),
@@ -172,6 +172,148 @@ static PyTypeObject pyrf_mmap_event__type = {
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
@@ -797,6 +939,9 @@ static int pyrf_event__setup_types(void)
 	int err;
 
 	err = PyType_Ready(&pyrf_mmap_event__type);
+	if (err < 0)
+		goto out;
+	err = PyType_Ready(&pyrf_mmap2_event__type);
 	if (err < 0)
 		goto out;
 	err = PyType_Ready(&pyrf_lost_event__type);
@@ -826,6 +971,7 @@ static int pyrf_event__setup_types(void)
 
 static PyTypeObject *pyrf_event__type[] = {
 	[PERF_RECORD_MMAP]	 = &pyrf_mmap_event__type,
+	[PERF_RECORD_MMAP2]	 = &pyrf_mmap2_event__type,
 	[PERF_RECORD_LOST]	 = &pyrf_lost_event__type,
 	[PERF_RECORD_COMM]	 = &pyrf_comm_event__type,
 	[PERF_RECORD_EXIT]	 = &pyrf_task_event__type,
@@ -992,6 +1138,11 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 		size_t max_len = pevent->event.header.size - offsetof(struct perf_record_mmap, filename);
 
 		pevent->event.mmap.filename[max_len - 1] = '\0';
+	} else if (event->header.type == PERF_RECORD_MMAP2) {
+		/* Ensure '\0' string termination. */
+		size_t max_len = pevent->event.header.size - offsetof(struct perf_record_mmap2, filename);
+
+		pevent->event.mmap2.filename[max_len - 1] = '\0';
 	}
 
 	perf_sample__init(&pevent->sample, /*all=*/true);
@@ -3417,6 +3568,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_mmap_event__type);
 	PyModule_AddObject(module, "mmap_event", (PyObject *)&pyrf_mmap_event__type);
 
+	Py_INCREF(&pyrf_mmap2_event__type);
+	PyModule_AddObject(module, "mmap2_event", (PyObject *)&pyrf_mmap2_event__type);
+
 	Py_INCREF(&pyrf_lost_event__type);
 	PyModule_AddObject(module, "lost_event", (PyObject *)&pyrf_lost_event__type);
 
-- 
2.54.0.1032.g2f8565e1d1-goog

