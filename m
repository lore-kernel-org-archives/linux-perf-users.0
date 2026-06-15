Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71C225B0A7
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 00:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781483325; cv=none; b=dZd5USc2H4hLBMGd1xb4X+mSXrmCdfbxouKizDW8sX6RsWq2dcbRD5i1qMCEGQNBBKistNoIS5c8UNgZ5CV7eEwQ+4yNoBzc9OdJ72s8J0ldOmbsCyyQSsYk0O8JVNiZxDcugYkE+iqk4dJ/p936O9ZcY/c8JQZQWoYCLmkwysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781483325; c=relaxed/simple;
	bh=xd3s0Fr6JsKF5IAaaedDZZ4uUomiDGK975gcEzKk9yA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DEgWI9E0McZxhepQdqcfugjaLWPWbj1B4oxkYPmu6k5V4mQeBLoAttOd64a/g2SIFYsF41zGxJAxgYhlpXtm9OdAWdj/FBBfrX6nWP6VKz/lQp2vhhn3f/1mdya7+cc4MHpyuv+eldR8wl7i1dDdK6TwZY7tjNo04+Cw4PGLOIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oheeQpop; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oheeQpop"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-139553dd8acso343462c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Jun 2026 17:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781483322; x=1782088122; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KGOCHSRDllGkAAg1ff5sd/9pouPANlZDRrKX7YkSyak=;
        b=oheeQpopQqf2IOVz82vqmm/Sed6Fgx5pNT1JiBJQ/l9SdEAHVDK1TnxKhdGK4Py9jm
         ePjBPxdnWyPahU6k4NI5dqWiTs2HEMoAAigntY88GduRRtB4Kq4axjV6n4RtobKksq2+
         teZ/p61ejC9X3xjrBY2JFlm97Kjl7jV9msQyhHqZRcxTAc7UtD19ODtGOQihxwFwWanq
         N/SLTdVz6ny+lmd2ScNAJ/cyYajzOZRjgY9MKpaZNyHF1GUcTwzdxrNDc0IjGVNO8U+m
         p+xdRmC9SR4hDM62kzVCqboLN/QNiBLvyRBL0VTDbnt6w5yul3bHF/tDfa7rluibx36z
         aOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781483322; x=1782088122;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGOCHSRDllGkAAg1ff5sd/9pouPANlZDRrKX7YkSyak=;
        b=tOQLsDDVQQe6koUX+Z1yKAo3LiQI8VTo+zuqZoLwj6EhK4QqGanVeWHvxyi40DUZxx
         /rKFLkTlFlgMpRF32exbopvZ00ZS3y41J8xziY7f3nCKCKNwRgFNaRWhAJDpBzc07TCH
         MbctPpIKonV71nNYcdaLSEOhaRVYgm+9CjzbD2Yv4yzu/APKctSetcjOsIPLnw0jAihO
         zvh1bPc2mMfvHxOvNAvkB9NGlyaGU9IMzLmUYG34loAIJYsAtIWO6/0emUS/PfBjaaR9
         h6xfVZ/wLll0WpwT5Ap/LMkkKhaiBppw6bvohAAE1w3ihRcH4WEqKCCcdBYKewpIBV/4
         5SUw==
X-Forwarded-Encrypted: i=1; AFNElJ8IjPPKSVMtHT7z9dYaMopct2SG3nI1XLm+byr9h8o55cnBh1aBxpo1rs9pDIbFQOm4Bor/30mFuSkxCBLx0Tvs@vger.kernel.org
X-Gm-Message-State: AOJu0YxXTlkLg/hejni6gUfyLVkk0ww1hxVovCkvMwW5gpuYO+n/K+7J
	EepKceFViKpns4/zE1TyG0m24ddHG2IHBSGRirEnQphTfD/MinNsJc+IbHZg5DtjahQJlAmeWOP
	RVKSuAGNH6Q==
X-Received: from dlbut12.prod.google.com ([2002:a05:7022:7e0c:b0:139:7a51:1031])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fd08:b0:138:35da:3cc3
 with SMTP id a92af1059eb24-1384bb80315mr5812296c88.30.1781483321526; Sun, 14
 Jun 2026 17:28:41 -0700 (PDT)
Date: Sun, 14 Jun 2026 17:28:04 -0700
In-Reply-To: <20260615002812.2234795-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613071100.1508192-1-irogers@google.com> <20260615002812.2234795-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615002812.2234795-13-irogers@google.com>
Subject: [PATCH v18 12/20] perf python: Add mmap2 event
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
index 6a84cfcc34ea..5f1d6fd9b082 100644
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
@@ -874,6 +1021,9 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 	if (copy_size < sizeof(pevent->event))
 		memset((char *)&pevent->event + copy_size, 0, sizeof(pevent->event) - copy_size);
 
+	if (event->header.type == PERF_RECORD_MMAP2)
+		pevent->event.mmap2.filename[sizeof(pevent->event.mmap2.filename) - 1] = '\0';
+
 	perf_sample__init(&pevent->sample, /*all=*/true);
 	pevent->al_resolved = false;
 	addr_location__init(&pevent->al);
@@ -3319,6 +3469,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_mmap_event__type);
 	PyModule_AddObject(module, "mmap_event", (PyObject *)&pyrf_mmap_event__type);
 
+	Py_INCREF(&pyrf_mmap2_event__type);
+	PyModule_AddObject(module, "mmap2_event", (PyObject *)&pyrf_mmap2_event__type);
+
 	Py_INCREF(&pyrf_lost_event__type);
 	PyModule_AddObject(module, "lost_event", (PyObject *)&pyrf_lost_event__type);
 
-- 
2.54.0.1136.gdb2ca164c4-goog

