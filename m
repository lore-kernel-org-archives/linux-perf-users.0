Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528D53911C1
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487519; cv=none; b=criqTtcOh/udIAQz7MMWfCmHQ46jLb82c4vcuaskdOrPawsvq6IjWCRclOhFzA0+2x2ftJiS18vv9t7QpOjtouoe1XGsYIJWX65HuWyG79jhZ3NAM5g8vgiSziqHUuJgU5ZRtaZg7UOMsxit/godIimVniMHydIV1fek6rKOkSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487519; c=relaxed/simple;
	bh=xVplDaUq3qZvGrJDQoj5pZuBvUlQ61vPIu3v1gbI0j8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TOBrUtstRA8c51q47OLJRdMJJ3iHg4Q8ItsjDZh3bWNfM62evbJfhK9EHJ14y7g19hYnqYhOPVVaLurM1CfJgneLttraiewYJwATzcrsSGAvUR++7EkJ3SUx1OUo/C/kzyMVP/LlHURJHT0ktfJ0QaH8gtrNhdcSMqeM5vZC5QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U9AP3C0l; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U9AP3C0l"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-135916eefa0so8069346c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779487517; x=1780092317; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kc9+pnx9V5zJCzrrZnoMn6gdgHh5drL1PfGcHBn0LCE=;
        b=U9AP3C0l29lZNXgOfRo27UqggLWM+/DTowyCtbakFDAcfuP3QklSOYDtY2cFob88M3
         Zn5GzSTT+hoOZ7yIx0qCe3hIZD0jZEKqlzJXYJPy0QB/YlyhaES7tY/uNmNcCQDN5By/
         SM17i4Xc0cTaIDyjJkYVFN8H17vdxr17nOWGwr0v4npBTQ1JXhfa3obWFn7361qhgm4d
         ervGEWaKpdPN8/1yLb2E4blahGKgvphq0GAVmps3p3fk5/2z3MiZ2uilnOKz6kaetOwe
         XWQVbKiw7UC/oF8DRQZ9q8tEdcaDL5W2cTQ3vsf/NJ87OG2IPQ74hXo4FvqUhiR1bAhQ
         TyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487517; x=1780092317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kc9+pnx9V5zJCzrrZnoMn6gdgHh5drL1PfGcHBn0LCE=;
        b=syvTZiZlAyB2duyHRwbQ4O3sTsAb6yB99+SvRbokNl1l0gZNhoEEgkyHuJin0an3Bh
         qCFCFZdOXDM3kc6YWMv8o6BiwBue7LS7JMp9rf6obssfk90xti2zfPNgp8t0TBL9Lhst
         8GAem2UIRQgiXQzzs98zMFtuJtFjlRGfnTvEvAz8hpcE8wJ2W5VXQRpz8vzDt70CKYtm
         04gzaFoxm/Se1LqctP3w1xVaQA7ud4iv0xIWp+Uk7NQCrv7EujBy5dY8UKvRLE/j4uTT
         6VI+TYafuG+9vm49hn8AxAYnK25X5plgaVXQm+RaQIXQ9YGQnnnUpDS5TVwqVy5miZr0
         DatA==
X-Forwarded-Encrypted: i=1; AFNElJ96sQbhBlQYMfLNp52SHRAXkPyE+yEsqvKhUlJlAu8dYfTg4OzohjdCx19cx8i0CV0RXT8Gmz5CYmdJkgfb2xej@vger.kernel.org
X-Gm-Message-State: AOJu0YxvItLys1VgOp0YVWSH2pWwnau+DRtbYCQSR08Kggg5kXqcDMT7
	0xlgk+vfwtZPYAUH734YJKb3X6LxrLHsKaPFdvKi1OSxFFyOZREwZVJx5pZ1oAGoaxT5kHRutlK
	jLriG8Gcb/A==
X-Received: from dlbtu11.prod.google.com ([2002:a05:7022:3c0b:b0:134:ea68:2940])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6725:b0:12b:ebb9:1c18
 with SMTP id a92af1059eb24-1365fc79de8mr2447524c88.31.1779487517130; Fri, 22
 May 2026 15:05:17 -0700 (PDT)
Date: Fri, 22 May 2026 15:04:27 -0700
In-Reply-To: <20260522220435.2378363-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428071903.1886173-1-irogers@google.com> <20260522220435.2378363-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522220435.2378363-17-irogers@google.com>
Subject: [PATCH v9 16/23] perf python: Add mmap2 event
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

If mmap is handled so should mmap2 events. Add support as a distinct
python event type.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 60 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 029915b7a1fe..daedd67f12d5 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -153,6 +153,54 @@ static PyTypeObject pyrf_mmap_event__type = {
 	.tp_repr	= (reprfunc)pyrf_mmap_event__repr,
 };
 
+static const char pyrf_mmap2_event__doc[] = PyDoc_STR("perf mmap2 event object.");
+
+static PyMemberDef pyrf_mmap2_event__members[] = {
+	sample_members
+	member_def(perf_event_header, type, T_UINT, "event type"),
+	member_def(perf_event_header, misc, T_UINT, "event misc"),
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
+	.tp_getset	= pyrf_event__getset,
+	.tp_repr	= (reprfunc)pyrf_mmap2_event__repr,
+};
+
 static const char pyrf_task_event__doc[] = PyDoc_STR("perf task (fork/exit) event object.");
 
 static PyMemberDef pyrf_task_event__members[] = {
@@ -778,6 +826,9 @@ static int pyrf_event__setup_types(void)
 	int err;
 
 	err = PyType_Ready(&pyrf_mmap_event__type);
+	if (err < 0)
+		goto out;
+	err = PyType_Ready(&pyrf_mmap2_event__type);
 	if (err < 0)
 		goto out;
 	err = PyType_Ready(&pyrf_lost_event__type);
@@ -807,6 +858,7 @@ static int pyrf_event__setup_types(void)
 
 static PyTypeObject *pyrf_event__type[] = {
 	[PERF_RECORD_MMAP]	 = &pyrf_mmap_event__type,
+	[PERF_RECORD_MMAP2]	 = &pyrf_mmap2_event__type,
 	[PERF_RECORD_LOST]	 = &pyrf_lost_event__type,
 	[PERF_RECORD_COMM]	 = &pyrf_comm_event__type,
 	[PERF_RECORD_EXIT]	 = &pyrf_task_event__type,
@@ -973,6 +1025,11 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 		size_t max_len = pevent->event.header.size - offsetof(struct perf_record_mmap, filename);
 
 		pevent->event.mmap.filename[max_len - 1] = '\0';
+	} else if (event->header.type == PERF_RECORD_MMAP2) {
+		/* Ensure '\0' string termination. */
+		size_t max_len = pevent->event.header.size - offsetof(struct perf_record_mmap2, filename);
+
+		pevent->event.mmap2.filename[max_len - 1] = '\0';
 	}
 
 	perf_sample__init(&pevent->sample, /*all=*/true);
@@ -3238,6 +3295,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_mmap_event__type);
 	PyModule_AddObject(module, "mmap_event", (PyObject *)&pyrf_mmap_event__type);
 
+	Py_INCREF(&pyrf_mmap2_event__type);
+	PyModule_AddObject(module, "mmap2_event", (PyObject *)&pyrf_mmap2_event__type);
+
 	Py_INCREF(&pyrf_lost_event__type);
 	PyModule_AddObject(module, "lost_event", (PyObject *)&pyrf_lost_event__type);
 
-- 
2.54.0.794.g4f17f83d09-goog

