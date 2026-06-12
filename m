Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FD03D9674
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781302382; cv=none; b=rj1FsCjrTa1SN5f/r1r0yrrtR82XVEIHholTfrwQ2kRdUOWMtifOmPv0j8ETwsEd9X+9OuZxIUv5cfJRfLDJkK60I8rNBqLGoL8Mz/zmgGtVOfQf6kv5gcVF6Chtorih1qQAGpusQyHXDbncMDPfVJWMnS4kPEHsXLGp/JbkIiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781302382; c=relaxed/simple;
	bh=LuU8dEzIpnlg3mb9UFP8uZWSWVqBy67VwGWGWX0pF5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GxG6RYKSMqHEkGVkQYUViITLFbPLT0Ag3xBLQwEH0GId6od0ultOCHi/57IgoEgBp2f0kCDbnxOl7lExh3XWG84IHe0IGQTXt0lpamK8du6hFoZ4GvAMl3NQCcnoFQFmVe1mPdqHCqbHuo3eJE3zAko7eNJugpOP+tbKcwJbC5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YQ7EOdo+; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YQ7EOdo+"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304b8d0ee63so2460304eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 15:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781302379; x=1781907179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OF8d3TwH0c5fc9lWhGT9XA6g1i7QmJGp7cOC+YcjI98=;
        b=YQ7EOdo+9/KfKkCCsMHZtHY2qns+Cvpn8rO10o3cpTQk1uuJYOpORXqqCvD1OABXLx
         ObnHhx8iTsR9mp1vecjUDgQG/gfIc3faRSBiyoYrwnotrRBbx6q/P9ZHCsJgPJR8OH3I
         oL9mw/Pe9zR6hU+TLyDZd4jc/DgMcH0Sk9RNUbHenl5/i1Zy59XXRRnFKXWN02dHGKBH
         i8YvtvQqKAlshTypLD4zFW64uaAjscm54gRW0RIckO6rakbCHtFstWpaGv+0BSK/CCwe
         UAyug9OOApfmeHZYnjeGjJVLEaCqFddDmC/Nvu+eu9OsWs6424qDier+aipEoxoy0Urs
         zodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781302379; x=1781907179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OF8d3TwH0c5fc9lWhGT9XA6g1i7QmJGp7cOC+YcjI98=;
        b=VvQc4SFeSmMiTeHp3POMF/RAagOuLk/UVmYZT2IpdKR51N/dyHzbXyAcMUrmyu7Iz7
         VmDDhcgOcMxwB6F7pcADjgpAuzrZHJhS6zNAqZJNy2gWXXRHrHGBD7NZO/h43ugpGKcg
         dRnc40pLVHoSrqG/jhBlKpxXL2LE/McPXfQ4RN2T7Nxnp1UjNYZ9KH5N/HUpEAdqpdVd
         7OZf+tucmQMHsYuxgEgFD6heBqHrizsAQ8zBWimww+rVdo2F+VfAJV1Kmaox6Jay/wPF
         TtDPw8zFTVs3lyeCyAHiqk8CWmssPoC3VwicJcdS11I8MJ8/OqA9rOMz6YnxWvMD+zgB
         7/Cg==
X-Forwarded-Encrypted: i=1; AFNElJ+2lvsfWFa7b+qgxblgXSTr2WUUEpWnoOX7H8WzZAFl3bYSSmb/JD0I6Smg+vipVI6j55WJ6CUj8EgIojCEC1ZQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwUwpobt4mT17v3aGl8UxIhoz/ffZ3Tkq8icJnuG35A2R8obx8h
	49sU8PEQyU971wmNl3dZKAvlStz/q8HqNlPP26D0u2ncUsKrLCWbmAhLWx/LKV1qqFr/eHMH5ke
	5/BE9mkFf5g==
X-Received: from dybhp7.prod.google.com ([2002:a05:7300:e207:b0:304:d999:2b0c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:818d:b0:2ee:be86:7b90
 with SMTP id 5a478bee46e88-3093ea534d7mr823946eec.29.1781302379184; Fri, 12
 Jun 2026 15:12:59 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:12:04 -0700
In-Reply-To: <20260612221211.1221305-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612180956.1105352-1-irogers@google.com> <20260612221211.1221305-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612221211.1221305-13-irogers@google.com>
Subject: [PATCH v15 12/19] perf python: Add mmap2 event
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
 tools/perf/util/python.c | 152 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index decdbf9e93af..bc9a3c6643c5 100644
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
@@ -3310,6 +3457,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_mmap_event__type);
 	PyModule_AddObject(module, "mmap_event", (PyObject *)&pyrf_mmap_event__type);
 
+	Py_INCREF(&pyrf_mmap2_event__type);
+	PyModule_AddObject(module, "mmap2_event", (PyObject *)&pyrf_mmap2_event__type);
+
 	Py_INCREF(&pyrf_lost_event__type);
 	PyModule_AddObject(module, "lost_event", (PyObject *)&pyrf_lost_event__type);
 
-- 
2.54.0.1136.gdb2ca164c4-goog

