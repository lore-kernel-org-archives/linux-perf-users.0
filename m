Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA93363094
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790965610; cv=none; b=RObNlLFRHuDUKhiw3K03DjmWxL8AlOmM11RCKQHLjIgb5ZBMsbM92ZbifY2aKHUINyPiPpHPG4HlXEPfKuMOUdGevzqJuHfVTzKJWU8g+hwAeMzn14n2ZQ3r6DftTDkx0TNuLWqIB9P/ScbA7MIwuk0lfb+zO9z1H84bwQlcYh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790965610; c=relaxed/simple;
	bh=6VyL3P6oawcHolUv/bCUppbAoma+vXE0Ww9McnHKj3U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=BcR3iOpigN0FYTarwwADdsgfy+Qw1dgZ40haItmlObqaBirIE2xSIvX1iBC/25r/WJxb8HS2P2RYcvLqqXyF1qmNkqXv/Sq/9yHdsu7nwI5vHOArT/oz05RbOds+ycudrKF8Swq3IYcMZRVartbY2QAtR43Ky8qNGRqKTDQ9p94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kb0tRqiU; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kb0tRqiU"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-34d80ca2184so3528750eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790965606; x=1791570406; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BvCStIG4Lgsc1X/bncracurI2T4Mqd3lE85Q3/r6xUc=;
        b=kb0tRqiUbBu7xEEcHvM6NLqv6mGdATd83C4mCI662yw0KemV7gGzgj3VKQrNWUyNqr
         ILIMK0L0in7MvTUeOpjYIg3Rba3nB6lp4IscTYtTYO2/06IlpiSJslL37BVsptJQULKs
         Uw8yope/PGimw1+O5AcqOoHOELJ8kTXK+0ftpaqMmfVHIicLuDQkfUhZ39daZSMqRxU4
         0tv9DaTg0pWhBEOBz9vVYOiuinuQ/hHE4SQXUgZOG7BowpBMmdL+8WBuipQCjlXHMEw9
         UK8OLN9xWZa/SgNlJKTlrO8xQEwUNQYLbVCO5iEPeoDzFQvJY5ZeEXD8dYGebFvSkh9K
         Ww2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790965606; x=1791570406;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BvCStIG4Lgsc1X/bncracurI2T4Mqd3lE85Q3/r6xUc=;
        b=G4nNI4b1saWEw4mjROV+hSvmDJ3RrKfdkSDlSaf0bszJR4SI5jQgh2+x2BaXn04jdb
         4NV+9wu2ql1wkAhg4Rg+2UqXjHwsUKuRL2mEZZSrJhB+C/E2X9gKorBOK75khkXxhcjU
         vYAjUa9fOnJlEPf6UIQkaag9TgmbDuVwf9hdWfTGpzmaVIbpKtwUv2/4IDfo911gnJEJ
         rAbrnYSZgzV29+h6sHXJajgU1TAOA5cqGO1pMsu0ZIvA6pvli39oLvwPSeO3paSVpY8N
         IQJKjOHSGVigkwPn0PoLo2v51URQ20wJPnujLC1oucab6J341micNjz3t8Ac0RBj9wNM
         ecDA==
X-Forwarded-Encrypted: i=1; AKwUvBzAVChbTwKWLSJ47gKGcjvGuL+lrde/FvgUl/YDPqt3egQ2cKzD0LZoZT66a1tkditTNvotWyjZHBUimVku0SkT@vger.kernel.org
X-Gm-Message-State: AFuF++moLcGA9xs2AZkGI5m17G042rVHtulEb2/vatWimYf1qEV6LB51
	cE+7kOZonHDGJTey8Fkf+nq9UU7FWyYapzErsV1hY0tSVDuUCohrNQgTHp6hkIlaAKl60FB+EBl
	pUCeEMgvYHw==
X-Received: from dyuw10.prod.google.com ([2002:a05:693c:880a:b0:34d:87f7:bf73])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d519:b0:340:e422:fd40
 with SMTP id 5a478bee46e88-3511141b58amr644309eec.16.1790965605761; Fri, 02
 Oct 2026 11:26:45 -0700 (PDT)
Date: Fri,  2 Oct 2026 11:26:12 -0700
In-Reply-To: <20261002182624.3259797-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261002182624.3259797-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002182624.3259797-4-irogers@google.com>
Subject: [PATCH v1 03/13] perf python: Lazily copy events and samples from process_events
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

When perf.session.process_events() delivers an event to a Python
callback, pyrf_event__new() previously copied the raw perf_event into a
4,160-byte union perf_event embedded in struct pyrf_event and called
evsel__parse_sample() a second time to re-parse the sample against the
copied buffer.

In the common case, the Python callback inspects the event and returns
without storing a reference to it. Avoid the event memcpy, the duplicate
evsel__parse_sample() call, and the large PyObject allocation by:
1. Storing pointers to the underlying union perf_event and
   struct perf_sample in struct pyrf_event (using PyGetSetDef descriptors
   backed by PyMember_GetOne() to read fields through those pointers),
   shrinking struct pyrf_event so it fits in CPython's small-object
   allocator pool.
2. Borrowing the event and pre-parsed sample pointers from
   process_events() for the duration of the Python callback.
3. Checking Py_REFCNT(pyevent) > 1 after the callback returns and only
   allocating event_copy and re-parsing into sample_storage when the
   Python callback retained a reference to the event object (or immediately
   in pyrf_evlist__read_on_cpu() where no pre-parsed sample is passed).

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 664 ++++++++++++++++++++++-----------------
 1 file changed, 384 insertions(+), 280 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 5b4963d5784d..a40e89c1b329 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -70,16 +70,6 @@ PyMODINIT_FUNC PyInit_perf(void);
 
 static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel);
 
-#define member_def(type, member, ptype, help) \
-	{ #member, ptype, \
-	  offsetof(struct pyrf_event, event) + offsetof(struct type, member), \
-	  0, help }
-
-#define sample_member_def(name, member, ptype, help) \
-	{ #name, ptype, \
-	  offsetof(struct pyrf_event, sample) + offsetof(struct perf_sample, member), \
-	  0, help }
-
 #define CHECK_INITIALIZED(ptr, msg) \
 	do { \
 		if (!(ptr)) { \
@@ -98,8 +88,12 @@ static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel);
 
 struct pyrf_event {
 	PyObject_HEAD
-	/** @sample: The parsed sample from the event. */
-	struct perf_sample sample;
+	/** @sample: The parsed sample, pointing to @sample_storage or a borrowed sample. */
+	struct perf_sample *sample;
+	/** @sample_storage: Storage for @sample when owned by this object. */
+	struct perf_sample sample_storage;
+	/** @evsel: The evsel associated with the event. */
+	struct evsel *evsel;
 	/** @machine: The machine associated with the sample/event. */
 	struct machine *machine;
 	/** @al: The address location from machine__resolve, lazily computed. */
@@ -110,11 +104,85 @@ struct pyrf_event {
 	PyObject *callchain;
 	/** @brstack: Resolved branch stack, eagerly computed if requested. */
 	PyObject *brstack;
-	/** @event: The underlying perf_event that may be in a file or ring buffer. */
-	union perf_event event;
+	/** @event: The underlying perf_event, pointing to @event_copy or a borrowed event. */
+	const union perf_event *event;
+	/** @event_copy: Copy of @event when owned by this object. */
+	union perf_event *event_copy;
+};
+
+static const union perf_event zero_event;
+
+static PyObject *pyrf_event__get_member(PyObject *self, void *closure)
+{
+	struct pyrf_event *pevent = (void *)self;
+	const union perf_event *event = pevent->event ?: &zero_event;
+
+	return PyMember_GetOne((const char *)event, closure);
+}
+
+static PyObject *pyrf_event__get_sample_member(PyObject *self, void *closure)
+{
+	struct pyrf_event *pevent = (void *)self;
+	const struct perf_sample *sample = pevent->sample ?: &pevent->sample_storage;
+
+	return PyMember_GetOne((const char *)sample, closure);
+}
+
+#define named_member_def(field, type, member, ptype, help) \
+	{ .name = #field, .get = pyrf_event__get_member, .doc = help, \
+	  .closure = &(struct PyMemberDef){ #field, ptype, \
+					    offsetof(struct type, member), READONLY, help } }
+
+#define member_def(type, member, ptype, help) \
+	named_member_def(member, type, member, ptype, help)
+
+struct pyrf_string_member {
+	size_t offset;
+	size_t maxlen;
 };
 
+static size_t pyrf_event__str_len(const struct pyrf_event *pevent, size_t offset, size_t maxlen)
+{
+	const char *base = (const char *)(pevent->event ?: &zero_event);
+	size_t event_size = pevent->event ? pevent->event->header.size : 0;
+
+	if (event_size <= offset)
+		return 0;
+	return strnlen(base + offset, min(event_size - offset, maxlen));
+}
+
+static PyObject *pyrf_event__get_string_member(PyObject *self, void *closure)
+{
+	struct pyrf_event *pevent = (void *)self;
+	const struct pyrf_string_member *sm = closure;
+	const char *base = (const char *)(pevent->event ?: &zero_event);
+
+	return PyUnicode_FromStringAndSize(base + sm->offset,
+					   pyrf_event__str_len(pevent, sm->offset, sm->maxlen));
+}
+
+#define string_member_def(type, member, help) \
+	{ .name = #member, .get = pyrf_event__get_string_member, .doc = help, \
+	  .closure = &(struct pyrf_string_member){ offsetof(struct type, member), \
+						   sizeof(((struct type *)0)->member) } }
+
+#define sample_member_def(field, member, ptype, help) \
+	{ .name = #field, .get = pyrf_event__get_sample_member, .doc = help, \
+	  .closure = &(struct PyMemberDef){ #field, ptype, \
+					    offsetof(struct perf_sample, member), READONLY, help } }
+
+static PyObject *pyrf_event__get_evsel(PyObject *self, void *closure __maybe_unused)
+{
+	struct pyrf_event *pevent = (void *)self;
+
+	if (!pevent->sample || !pevent->sample->evsel)
+		Py_RETURN_NONE;
+
+	return pyrf_evsel__from_evsel(pevent->sample->evsel);
+}
+
 #define sample_members \
+	{ .name = "evsel", .get = pyrf_event__get_evsel, .doc = "tracking event." },	 \
 	sample_member_def(sample_pid, pid, T_INT, "event pid"),			 \
 	sample_member_def(sample_tid, tid, T_INT, "event tid"),			 \
 	sample_member_def(sample_time, time, T_ULONGLONG, "event timestamp"),		 \
@@ -125,39 +193,21 @@ struct pyrf_event {
 	sample_member_def(sample_period, period, T_ULONGLONG, "event period"),		 \
 	sample_member_def(sample_cpu, cpu, T_UINT, "event cpu"),
 
-static PyObject *pyrf_event__get_evsel(PyObject *self, void *closure __maybe_unused)
-{
-	struct pyrf_event *pevent = (void *)self;
-
-	if (!pevent->sample.evsel)
-		Py_RETURN_NONE;
-
-	return pyrf_evsel__from_evsel(pevent->sample.evsel);
-}
-
-static PyGetSetDef pyrf_event__getset[] = {
-	{
-		.name = "evsel",
-		.get = pyrf_event__get_evsel,
-		.set = NULL,
-		.doc = "tracking event.",
-	},
-	{ .name = NULL, },
-};
-
 static void pyrf_event__delete(struct pyrf_event *pevent)
 {
 	if (pevent->al_resolved)
 		addr_location__exit(&pevent->al);
 	Py_XDECREF(pevent->callchain);
 	Py_XDECREF(pevent->brstack);
-	perf_sample__exit(&pevent->sample);
+	perf_sample__exit(&pevent->sample_storage);
+	evsel__put(pevent->evsel);
+	free(pevent->event_copy);
 	Py_TYPE(pevent)->tp_free((PyObject *)pevent);
 }
 
 static const char pyrf_mmap_event__doc[] = PyDoc_STR("perf mmap event object.");
 
-static PyMemberDef pyrf_mmap_event__members[] = {
+static PyGetSetDef pyrf_mmap_event__getset[] = {
 	sample_members
 	member_def(perf_event_header, type, T_UINT, "event type"),
 	member_def(perf_event_header, misc, T_USHORT, "event misc"),
@@ -166,7 +216,7 @@ static PyMemberDef pyrf_mmap_event__members[] = {
 	member_def(perf_record_mmap, start, T_ULONGLONG, "start of the map"),
 	member_def(perf_record_mmap, len, T_ULONGLONG, "map length"),
 	member_def(perf_record_mmap, pgoff, T_ULONGLONG, "page offset"),
-	member_def(perf_record_mmap, filename, T_STRING_INPLACE, "backing store"),
+	string_member_def(perf_record_mmap, filename, "backing store"),
 	{ .name = NULL, },
 };
 
@@ -174,13 +224,15 @@ static PyObject *pyrf_mmap_event__repr(const struct pyrf_event *pevent)
 {
 	PyObject *ret;
 	char *s;
+	int fn_len = pyrf_event__str_len(pevent, offsetof(struct perf_record_mmap, filename),
+					 sizeof(pevent->event->mmap.filename));
 
 	if (asprintf(&s, "{ type: mmap, pid: %u, tid: %u, start: %#" PRI_lx64 ", "
 			 "length: %#" PRI_lx64 ", offset: %#" PRI_lx64 ", "
-			 "filename: %s }",
-		     pevent->event.mmap.pid, pevent->event.mmap.tid,
-		     pevent->event.mmap.start, pevent->event.mmap.len,
-		     pevent->event.mmap.pgoff, pevent->event.mmap.filename) < 0) {
+			 "filename: %.*s }",
+		     pevent->event->mmap.pid, pevent->event->mmap.tid,
+		     pevent->event->mmap.start, pevent->event->mmap.len,
+		     pevent->event->mmap.pgoff, fn_len, pevent->event->mmap.filename) < 0) {
 		ret = PyErr_NoMemory();
 	} else {
 		ret = PyUnicode_FromString(s);
@@ -196,8 +248,7 @@ static PyTypeObject pyrf_mmap_event__type = {
 	.tp_dealloc	= (destructor)pyrf_event__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_mmap_event__doc,
-	.tp_members	= pyrf_mmap_event__members,
-	.tp_getset	= pyrf_event__getset,
+	.tp_getset	= pyrf_mmap_event__getset,
 	.tp_repr	= (reprfunc)pyrf_mmap_event__repr,
 };
 
@@ -207,64 +258,69 @@ static PyObject *pyrf_mmap2_event__get_maj(PyObject *self, void *closure __maybe
 {
 	struct pyrf_event *pevent = (void *)self;
 
-	if (pevent->event.header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)
+	if (pevent->event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)
 		Py_RETURN_NONE;
 
-	return PyLong_FromUnsignedLong(pevent->event.mmap2.maj);
+	return PyLong_FromUnsignedLong(pevent->event->mmap2.maj);
 }
 
 static PyObject *pyrf_mmap2_event__get_min(PyObject *self, void *closure __maybe_unused)
 {
 	struct pyrf_event *pevent = (void *)self;
 
-	if (pevent->event.header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)
+	if (pevent->event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)
 		Py_RETURN_NONE;
 
-	return PyLong_FromUnsignedLong(pevent->event.mmap2.min);
+	return PyLong_FromUnsignedLong(pevent->event->mmap2.min);
 }
 
 static PyObject *pyrf_mmap2_event__get_ino(PyObject *self, void *closure __maybe_unused)
 {
 	struct pyrf_event *pevent = (void *)self;
 
-	if (pevent->event.header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)
+	if (pevent->event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)
 		Py_RETURN_NONE;
 
-	return PyLong_FromUnsignedLongLong(pevent->event.mmap2.ino);
+	return PyLong_FromUnsignedLongLong(pevent->event->mmap2.ino);
 }
 
 static PyObject *pyrf_mmap2_event__get_ino_generation(PyObject *self, void *closure __maybe_unused)
 {
 	struct pyrf_event *pevent = (void *)self;
 
-	if (pevent->event.header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)
+	if (pevent->event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)
 		Py_RETURN_NONE;
 
-	return PyLong_FromUnsignedLongLong(pevent->event.mmap2.ino_generation);
+	return PyLong_FromUnsignedLongLong(pevent->event->mmap2.ino_generation);
 }
 
 static PyObject *pyrf_mmap2_event__get_build_id(PyObject *self, void *closure __maybe_unused)
 {
 	struct pyrf_event *pevent = (void *)self;
 
-	if (!(pevent->event.header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID))
+	if (!(pevent->event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID))
 		Py_RETURN_NONE;
 
-	int size = pevent->event.mmap2.build_id_size;
+	int size = pevent->event->mmap2.build_id_size;
 
 	if (size > 20)
 		size = 20;
 
-	return PyBytes_FromStringAndSize((const char *)pevent->event.mmap2.build_id, size);
+	return PyBytes_FromStringAndSize((const char *)pevent->event->mmap2.build_id, size);
 }
 
 static PyGetSetDef pyrf_mmap2_event__getset[] = {
-	{
-		.name = "evsel",
-		.get = pyrf_event__get_evsel,
-		.set = NULL,
-		.doc = "tracking event.",
-	},
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
+	string_member_def(perf_record_mmap2, filename, "backing store"),
 	{
 		.name = "maj",
 		.get = pyrf_mmap2_event__get_maj,
@@ -298,31 +354,18 @@ static PyGetSetDef pyrf_mmap2_event__getset[] = {
 	{ .name = NULL, },
 };
 
-static PyMemberDef pyrf_mmap2_event__members[] = {
-	sample_members
-	member_def(perf_event_header, type, T_UINT, "event type"),
-	member_def(perf_event_header, misc, T_USHORT, "event misc"),
-	member_def(perf_record_mmap2, pid, T_UINT, "event pid"),
-	member_def(perf_record_mmap2, tid, T_UINT, "event tid"),
-	member_def(perf_record_mmap2, start, T_ULONGLONG, "start of the map"),
-	member_def(perf_record_mmap2, len, T_ULONGLONG, "map length"),
-	member_def(perf_record_mmap2, pgoff, T_ULONGLONG, "page offset"),
-	member_def(perf_record_mmap2, prot, T_UINT, "protection"),
-	member_def(perf_record_mmap2, flags, T_UINT, "flags"),
-	member_def(perf_record_mmap2, filename, T_STRING_INPLACE, "backing store"),
-	{ .name = NULL, },
-};
-
 static PyObject *pyrf_mmap2_event__repr(const struct pyrf_event *pevent)
 {
 	PyObject *ret;
 	char *s;
-
-	if (asprintf(&s, "{ type: mmap2, pid: %u, tid: %u, start: %#" PRI_lx64 ", length: %#" PRI_lx64 ", offset: %#" PRI_lx64 ", flags: %#x, prot: %#x, filename: %s }",
-		     pevent->event.mmap2.pid, pevent->event.mmap2.tid,
-		     pevent->event.mmap2.start, pevent->event.mmap2.len,
-		     pevent->event.mmap2.pgoff, pevent->event.mmap2.flags,
-		     pevent->event.mmap2.prot, pevent->event.mmap2.filename) < 0)
+	int fn_len = pyrf_event__str_len(pevent, offsetof(struct perf_record_mmap2, filename),
+					 sizeof(pevent->event->mmap2.filename));
+
+	if (asprintf(&s, "{ type: mmap2, pid: %u, tid: %u, start: %#" PRI_lx64 ", length: %#" PRI_lx64 ", offset: %#" PRI_lx64 ", flags: %#x, prot: %#x, filename: %.*s }",
+		     pevent->event->mmap2.pid, pevent->event->mmap2.tid,
+		     pevent->event->mmap2.start, pevent->event->mmap2.len,
+		     pevent->event->mmap2.pgoff, pevent->event->mmap2.flags,
+		     pevent->event->mmap2.prot, fn_len, pevent->event->mmap2.filename) < 0)
 		return PyErr_NoMemory();
 
 	ret = PyUnicode_FromString(s);
@@ -337,14 +380,13 @@ static PyTypeObject pyrf_mmap2_event__type = {
 	.tp_dealloc	= (destructor)pyrf_event__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_mmap2_event__doc,
-	.tp_members	= pyrf_mmap2_event__members,
 	.tp_getset	= pyrf_mmap2_event__getset,
 	.tp_repr	= (reprfunc)pyrf_mmap2_event__repr,
 };
 
 static const char pyrf_task_event__doc[] = PyDoc_STR("perf task (fork/exit) event object.");
 
-static PyMemberDef pyrf_task_event__members[] = {
+static PyGetSetDef pyrf_task_event__getset[] = {
 	sample_members
 	member_def(perf_event_header, type, T_UINT, "event type"),
 	member_def(perf_record_fork, pid, T_UINT, "event pid"),
@@ -359,12 +401,12 @@ static PyObject *pyrf_task_event__repr(const struct pyrf_event *pevent)
 {
 	return PyUnicode_FromFormat("{ type: %s, pid: %u, ppid: %u, tid: %u, "
 				   "ptid: %u, time: %" PRI_lu64 "}",
-				   pevent->event.header.type == PERF_RECORD_FORK ? "fork" : "exit",
-				   pevent->event.fork.pid,
-				   pevent->event.fork.ppid,
-				   pevent->event.fork.tid,
-				   pevent->event.fork.ptid,
-				   pevent->event.fork.time);
+				   pevent->event->header.type == PERF_RECORD_FORK ? "fork" : "exit",
+				   pevent->event->fork.pid,
+				   pevent->event->fork.ppid,
+				   pevent->event->fork.tid,
+				   pevent->event->fork.ptid,
+				   pevent->event->fork.time);
 }
 
 static PyTypeObject pyrf_task_event__type = {
@@ -374,28 +416,36 @@ static PyTypeObject pyrf_task_event__type = {
 	.tp_dealloc	= (destructor)pyrf_event__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_task_event__doc,
-	.tp_members	= pyrf_task_event__members,
-	.tp_getset	= pyrf_event__getset,
+	.tp_getset	= pyrf_task_event__getset,
 	.tp_repr	= (reprfunc)pyrf_task_event__repr,
 };
 
 static const char pyrf_comm_event__doc[] = PyDoc_STR("perf comm event object.");
 
-static PyMemberDef pyrf_comm_event__members[] = {
+static PyGetSetDef pyrf_comm_event__getset[] = {
 	sample_members
 	member_def(perf_event_header, type, T_UINT, "event type"),
 	member_def(perf_record_comm, pid, T_UINT, "event pid"),
 	member_def(perf_record_comm, tid, T_UINT, "event tid"),
-	member_def(perf_record_comm, comm, T_STRING_INPLACE, "process name"),
+	string_member_def(perf_record_comm, comm, "process name"),
 	{ .name = NULL, },
 };
 
 static PyObject *pyrf_comm_event__repr(const struct pyrf_event *pevent)
 {
-	return PyUnicode_FromFormat("{ type: comm, pid: %u, tid: %u, comm: %s }",
-				   pevent->event.comm.pid,
-				   pevent->event.comm.tid,
-				   pevent->event.comm.comm);
+	PyObject *ret;
+	char *s;
+	int comm_len = pyrf_event__str_len(pevent, offsetof(struct perf_record_comm, comm),
+					   sizeof(pevent->event->comm.comm));
+
+	if (asprintf(&s, "{ type: comm, pid: %u, tid: %u, comm: %.*s }",
+		     pevent->event->comm.pid, pevent->event->comm.tid,
+		     comm_len, pevent->event->comm.comm) < 0)
+		return PyErr_NoMemory();
+
+	ret = PyUnicode_FromString(s);
+	free(s);
+	return ret;
 }
 
 static PyTypeObject pyrf_comm_event__type = {
@@ -405,14 +455,13 @@ static PyTypeObject pyrf_comm_event__type = {
 	.tp_dealloc	= (destructor)pyrf_event__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_comm_event__doc,
-	.tp_members	= pyrf_comm_event__members,
-	.tp_getset	= pyrf_event__getset,
+	.tp_getset	= pyrf_comm_event__getset,
 	.tp_repr	= (reprfunc)pyrf_comm_event__repr,
 };
 
 static const char pyrf_throttle_event__doc[] = PyDoc_STR("perf throttle event object.");
 
-static PyMemberDef pyrf_throttle_event__members[] = {
+static PyGetSetDef pyrf_throttle_event__getset[] = {
 	sample_members
 	member_def(perf_event_header, type, T_UINT, "event type"),
 	member_def(perf_record_throttle, time, T_ULONGLONG, "timestamp"),
@@ -424,11 +473,11 @@ static PyMemberDef pyrf_throttle_event__members[] = {
 static PyObject *pyrf_throttle_event__repr(const struct pyrf_event *pevent)
 {
 	const struct perf_record_throttle *te = (const struct perf_record_throttle *)
-		(&pevent->event.header + 1);
+		(&pevent->event->header + 1);
 
 	return PyUnicode_FromFormat("{ type: %sthrottle, time: %" PRI_lu64 ", id: %" PRI_lu64
 				   ", stream_id: %" PRI_lu64 " }",
-				   pevent->event.header.type == PERF_RECORD_THROTTLE ? "" : "un",
+				   pevent->event->header.type == PERF_RECORD_THROTTLE ? "" : "un",
 				   te->time, te->id, te->stream_id);
 }
 
@@ -439,14 +488,13 @@ static PyTypeObject pyrf_throttle_event__type = {
 	.tp_dealloc	= (destructor)pyrf_event__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_throttle_event__doc,
-	.tp_members	= pyrf_throttle_event__members,
-	.tp_getset	= pyrf_event__getset,
+	.tp_getset	= pyrf_throttle_event__getset,
 	.tp_repr	= (reprfunc)pyrf_throttle_event__repr,
 };
 
 static const char pyrf_lost_event__doc[] = PyDoc_STR("perf lost event object.");
 
-static PyMemberDef pyrf_lost_event__members[] = {
+static PyGetSetDef pyrf_lost_event__getset[] = {
 	sample_members
 	member_def(perf_event_header, type, T_UINT, "event type"),
 	member_def(perf_record_lost, id, T_ULONGLONG, "event id"),
@@ -461,7 +509,7 @@ static PyObject *pyrf_lost_event__repr(const struct pyrf_event *pevent)
 
 	if (asprintf(&s, "{ type: lost, id: %#" PRI_lx64 ", "
 			 "lost: %#" PRI_lx64 " }",
-		     pevent->event.lost.id, pevent->event.lost.lost) < 0) {
+		     pevent->event->lost.id, pevent->event->lost.lost) < 0) {
 		ret = PyErr_NoMemory();
 	} else {
 		ret = PyUnicode_FromString(s);
@@ -477,14 +525,13 @@ static PyTypeObject pyrf_lost_event__type = {
 	.tp_dealloc	= (destructor)pyrf_event__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_lost_event__doc,
-	.tp_members	= pyrf_lost_event__members,
-	.tp_getset	= pyrf_event__getset,
+	.tp_getset	= pyrf_lost_event__getset,
 	.tp_repr	= (reprfunc)pyrf_lost_event__repr,
 };
 
 static const char pyrf_stat_event__doc[] = PyDoc_STR("perf stat event object.");
 
-static PyMemberDef pyrf_stat_event__members[] = {
+static PyGetSetDef pyrf_stat_event__getset[] = {
 	sample_members
 	member_def(perf_event_header, type, T_UINT, "event type"),
 	member_def(perf_record_stat, id, T_ULONGLONG, "event id"),
@@ -498,14 +545,16 @@ static PyMemberDef pyrf_stat_event__members[] = {
 
 static PyObject *pyrf_stat_event__repr(const struct pyrf_event *pevent)
 {
+	const union perf_event *event = pevent->event ?: &zero_event;
+
 	return PyUnicode_FromFormat(
 		"{ type: stat, id: %llu, cpu: %u, thread: %u, val: %llu, ena: %llu, run: %llu }",
-		pevent->event.stat.id,
-		pevent->event.stat.cpu,
-		pevent->event.stat.thread,
-		pevent->event.stat.val,
-		pevent->event.stat.ena,
-		pevent->event.stat.run);
+		event->stat.id,
+		event->stat.cpu,
+		event->stat.thread,
+		event->stat.val,
+		event->stat.ena,
+		event->stat.run);
 }
 
 static PyTypeObject pyrf_stat_event__type = {
@@ -516,28 +565,27 @@ static PyTypeObject pyrf_stat_event__type = {
 	.tp_dealloc	= (destructor)pyrf_event__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_stat_event__doc,
-	.tp_members	= pyrf_stat_event__members,
-	.tp_getset	= pyrf_event__getset,
+	.tp_getset	= pyrf_stat_event__getset,
 	.tp_repr	= (reprfunc)pyrf_stat_event__repr,
 };
 
 static const char pyrf_stat_round_event__doc[] = PyDoc_STR("perf stat round event object.");
 
-static PyMemberDef pyrf_stat_round_event__members[] = {
+static PyGetSetDef pyrf_stat_round_event__getset[] = {
 	sample_members
 	member_def(perf_event_header, type, T_UINT, "event type"),
-	{ .name = "stat_round_type", .type = T_ULONGLONG,
-	  .offset = offsetof(struct pyrf_event, event) + offsetof(struct perf_record_stat_round, type),
-	  .doc = "round type" },
+	named_member_def(stat_round_type, perf_record_stat_round, type, T_ULONGLONG, "round type"),
 	member_def(perf_record_stat_round, time, T_ULONGLONG, "round time"),
 	{ .name = NULL, },
 };
 
 static PyObject *pyrf_stat_round_event__repr(const struct pyrf_event *pevent)
 {
+	const union perf_event *event = pevent->event ?: &zero_event;
+
 	return PyUnicode_FromFormat("{ type: stat_round, type: %llu, time: %llu }",
-				   pevent->event.stat_round.type,
-				   pevent->event.stat_round.time);
+				   event->stat_round.type,
+				   event->stat_round.time);
 }
 
 static PyTypeObject pyrf_stat_round_event__type = {
@@ -548,14 +596,13 @@ static PyTypeObject pyrf_stat_round_event__type = {
 	.tp_dealloc	= (destructor)pyrf_event__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_stat_round_event__doc,
-	.tp_members	= pyrf_stat_round_event__members,
-	.tp_getset	= pyrf_event__getset,
+	.tp_getset	= pyrf_stat_round_event__getset,
 	.tp_repr	= (reprfunc)pyrf_stat_round_event__repr,
 };
 
 static const char pyrf_read_event__doc[] = PyDoc_STR("perf read event object.");
 
-static PyMemberDef pyrf_read_event__members[] = {
+static PyGetSetDef pyrf_read_event__getset[] = {
 	sample_members
 	member_def(perf_event_header, type, T_UINT, "event type"),
 	member_def(perf_record_read, pid, T_UINT, "event pid"),
@@ -566,8 +613,8 @@ static PyMemberDef pyrf_read_event__members[] = {
 static PyObject *pyrf_read_event__repr(const struct pyrf_event *pevent)
 {
 	return PyUnicode_FromFormat("{ type: read, pid: %u, tid: %u }",
-				   pevent->event.read.pid,
-				   pevent->event.read.tid);
+				   pevent->event->read.pid,
+				   pevent->event->read.tid);
 	/*
  	 * FIXME: return the array of read values,
  	 * making this method useful ;-)
@@ -581,27 +628,12 @@ static PyTypeObject pyrf_read_event__type = {
 	.tp_dealloc	= (destructor)pyrf_event__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_read_event__doc,
-	.tp_members	= pyrf_read_event__members,
-	.tp_getset	= pyrf_event__getset,
+	.tp_getset	= pyrf_read_event__getset,
 	.tp_repr	= (reprfunc)pyrf_read_event__repr,
 };
 
 static const char pyrf_sample_event__doc[] = PyDoc_STR("perf sample event object.");
 
-static PyMemberDef pyrf_sample_event__members[] = {
-	sample_members
-	sample_member_def(sample_ip, ip, T_ULONGLONG, "event ip"),
-	sample_member_def(sample_addr, addr, T_ULONGLONG, "event addr"),
-	sample_member_def(sample_phys_addr, phys_addr, T_ULONGLONG, "event physical addr"),
-	sample_member_def(sample_weight, weight, T_ULONGLONG, "event weight"),
-	sample_member_def(sample_data_src, data_src, T_ULONGLONG, "event data source"),
-	sample_member_def(sample_insn_count, insn_cnt, T_ULONGLONG, "event instruction count"),
-	sample_member_def(sample_cyc_count, cyc_cnt, T_ULONGLONG, "event cycle count"),
-	sample_member_def(flags, flags, T_UINT, "event flags"),
-	member_def(perf_event_header, type, T_UINT, "event type"),
-	{ .name = NULL, },
-};
-
 static PyObject *pyrf_sample_event__repr(const struct pyrf_event *pevent)
 {
 	PyObject *ret;
@@ -619,16 +651,18 @@ static PyObject *pyrf_sample_event__repr(const struct pyrf_event *pevent)
 #ifdef HAVE_LIBTRACEEVENT
 static bool is_tracepoint(const struct pyrf_event *pevent)
 {
-	if (!pevent->sample.evsel)
+	struct evsel *evsel = pevent->sample->evsel ?: pevent->evsel;
+
+	if (!evsel)
 		return false;
-	return pevent->sample.evsel->core.attr.type == PERF_TYPE_TRACEPOINT;
+	return evsel->core.attr.type == PERF_TYPE_TRACEPOINT;
 }
 
 static PyObject*
 tracepoint_field(const struct pyrf_event *pe, struct tep_format_field *field)
 {
 	struct tep_handle *pevent = field->event->tep;
-	void *data = pe->sample.raw_data;
+	void *data = pe->sample->raw_data;
 	PyObject *ret = NULL;
 	unsigned long long val;
 	unsigned int offset, len;
@@ -668,7 +702,7 @@ tracepoint_field(const struct pyrf_event *pe, struct tep_format_field *field)
 static PyObject*
 get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
 {
-	struct evsel *evsel = pevent->sample.evsel;
+	struct evsel *evsel = pevent->sample->evsel ?: pevent->evsel;
 	struct tep_event *tp_format = evsel__tp_format(evsel);
 	struct tep_format_field *field;
 
@@ -693,7 +727,7 @@ get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
 
 static int pyrf_sample_event__resolve_al(struct pyrf_event *pevent)
 {
-	struct evsel *evsel = pevent->sample.evsel;
+	struct evsel *evsel = pevent->sample->evsel ?: pevent->evsel;
 	struct evlist *evlist = evsel ? evsel->evlist : NULL;
 	struct perf_session *session = evlist ? evlist__session(evlist) : NULL;
 	struct machine *machine;
@@ -714,7 +748,7 @@ static int pyrf_sample_event__resolve_al(struct pyrf_event *pevent)
 	machine = pevent->machine ? pevent->machine : &session->machines.host;
 
 	addr_location__init(&pevent->al);
-	if (machine__resolve(machine, &pevent->al, &pevent->sample) < 0) {
+	if (machine__resolve(machine, &pevent->al, pevent->sample) < 0) {
 		addr_location__exit(&pevent->al);
 		return -1;
 	}
@@ -819,17 +853,17 @@ static PyObject *pyrf_sample_event__get_sym_end(struct pyrf_event *pevent,
 static PyObject *pyrf_sample_event__get_raw_buf(struct pyrf_event *pevent,
 						void *closure __maybe_unused)
 {
-	if (pevent->event.header.type != PERF_RECORD_SAMPLE)
+	if (pevent->event->header.type != PERF_RECORD_SAMPLE)
 		Py_RETURN_NONE;
 
-	return PyBytes_FromStringAndSize((const char *)pevent->sample.raw_data,
-					 pevent->sample.raw_size);
+	return PyBytes_FromStringAndSize((const char *)pevent->sample->raw_data,
+					 pevent->sample->raw_size);
 }
 
 static PyObject *pyrf_sample_event__srccode(PyObject *self, PyObject *args)
 {
 	struct pyrf_event *pevent = (void *)self;
-	u64 addr = pevent->sample.ip;
+	u64 addr = pevent->sample->ip;
 	char *srcfile = NULL;
 	char *srccode = NULL;
 	unsigned int line = 0;
@@ -838,8 +872,8 @@ static PyObject *pyrf_sample_event__srccode(PyObject *self, PyObject *args)
 	struct addr_location al;
 
 	/*
-	 * addr defaults to pevent->sample.ip when omitted, and when
-	 * addr != pevent->sample.ip a local addr_location is resolved so
+	 * addr defaults to pevent->sample->ip when omitted, and when
+	 * addr != pevent->sample->ip a local addr_location is resolved so
 	 * callers can inspect callchain/branch addresses without mutating
 	 * the sample's cached pevent->al.
 	 */
@@ -849,9 +883,9 @@ static PyObject *pyrf_sample_event__srccode(PyObject *self, PyObject *args)
 	if (pyrf_sample_event__resolve_al(pevent) < 0)
 		Py_RETURN_NONE;
 
-	if (addr != pevent->sample.ip) {
+	if (addr != pevent->sample->ip) {
 		addr_location__init(&al);
-		thread__find_symbol_fb(pevent->al.thread, pevent->sample.cpumode, addr, &al);
+		thread__find_symbol_fb(pevent->al.thread, pevent->sample->cpumode, addr, &al);
 	} else {
 		addr_location__init(&al);
 		al.thread = thread__get(pevent->al.thread);
@@ -905,14 +939,14 @@ static PyObject *pyrf_sample_event__insn(PyObject *self, PyObject *args __maybe_
 	if (!machine)
 		Py_RETURN_NONE;
 
-	if (pevent->sample.ip && !pevent->sample.insn_len)
-		perf_sample__fetch_insn(&pevent->sample, thread, machine);
+	if (pevent->sample->ip && !pevent->sample->insn_len)
+		perf_sample__fetch_insn(pevent->sample, thread, machine);
 
-	if (!pevent->sample.insn_len)
+	if (!pevent->sample->insn_len)
 		Py_RETURN_NONE;
 
-	return PyBytes_FromStringAndSize((const char *)pevent->sample.insn,
-					 pevent->sample.insn_len);
+	return PyBytes_FromStringAndSize((const char *)pevent->sample->insn,
+					 pevent->sample->insn_len);
 }
 
 struct pyrf_callchain_node {
@@ -1242,8 +1276,8 @@ static int pyrf_sample_event__resolve_addr_al(struct pyrf_event *pevent,
 	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.thread)
 		return -1;
 
-	thread__find_symbol_fb(pevent->al.thread, pevent->sample.cpumode,
-			       pevent->sample.addr, addr_al);
+	thread__find_symbol_fb(pevent->al.thread, pevent->sample->cpumode,
+			       pevent->sample->addr, addr_al);
 	return 0;
 }
 
@@ -1295,23 +1329,32 @@ static PyObject *pyrf_sample_event__get_addr_sym_offset(struct pyrf_event *peven
 static PyObject *pyrf_sample_event__get_branch_type(struct pyrf_event *pevent,
 						    void *closure __maybe_unused)
 {
-	return PyLong_FromUnsignedLong(pevent->sample.flags & PERF_BRANCH_MASK);
+	return PyLong_FromUnsignedLong(pevent->sample->flags & PERF_BRANCH_MASK);
 }
 
 static PyObject *pyrf_sample_event__get_in_tx(struct pyrf_event *pevent,
 					      void *closure __maybe_unused)
 {
-	return PyLong_FromUnsignedLong(!!(pevent->sample.flags & PERF_IP_FLAG_IN_TX));
+	return PyLong_FromUnsignedLong(!!(pevent->sample->flags & PERF_IP_FLAG_IN_TX));
 }
 
 static PyObject *pyrf_sample_event__get_transaction(struct pyrf_event *pevent,
 						    void *closure __maybe_unused)
 {
-	return PyLong_FromUnsignedLongLong(pevent->sample.transaction);
+	return PyLong_FromUnsignedLongLong(pevent->sample->transaction);
 }
 
 static PyGetSetDef pyrf_sample_event__getset[] = {
-
+	sample_members
+	sample_member_def(sample_ip, ip, T_ULONGLONG, "event ip"),
+	sample_member_def(sample_addr, addr, T_ULONGLONG, "event addr"),
+	sample_member_def(sample_phys_addr, phys_addr, T_ULONGLONG, "event physical addr"),
+	sample_member_def(sample_weight, weight, T_ULONGLONG, "event weight"),
+	sample_member_def(sample_data_src, data_src, T_ULONGLONG, "event data source"),
+	sample_member_def(sample_insn_count, insn_cnt, T_ULONGLONG, "event instruction count"),
+	sample_member_def(sample_cyc_count, cyc_cnt, T_ULONGLONG, "event cycle count"),
+	sample_member_def(flags, flags, T_UINT, "event flags"),
+	member_def(perf_event_header, type, T_UINT, "event type"),
 	{
 		.name = "addr_dso",
 		.get = (getter)pyrf_sample_event__get_addr_dso,
@@ -1361,12 +1404,6 @@ static PyGetSetDef pyrf_sample_event__getset[] = {
 		.set = NULL,
 		.doc = "event raw buffer.",
 	},
-	{
-		.name = "evsel",
-		.get = pyrf_event__get_evsel,
-		.set = NULL,
-		.doc = "tracking event.",
-	},
 	{
 		.name = "dso",
 		.get = (getter)pyrf_sample_event__get_dso,
@@ -1453,7 +1490,6 @@ static PyTypeObject pyrf_sample_event__type = {
 	.tp_dealloc	= (destructor)pyrf_event__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_sample_event__doc,
-	.tp_members	= pyrf_sample_event__members,
 	.tp_getset	= pyrf_sample_event__getset,
 	.tp_methods	= pyrf_sample_event__methods,
 	.tp_repr	= (reprfunc)pyrf_sample_event__repr,
@@ -1462,36 +1498,26 @@ static PyTypeObject pyrf_sample_event__type = {
 
 static const char pyrf_context_switch_event__doc[] = PyDoc_STR("perf context_switch event object.");
 
-static PyMemberDef pyrf_context_switch_event__members[] = {
-	sample_members
-	member_def(perf_event_header, type, T_UINT, "event type"),
-	member_def(perf_event_header, misc, T_USHORT, "event misc"),
-	{ .name = NULL, },
-};
-
 static PyObject *pyrf_context_switch_event__get_next_prev_pid(const struct pyrf_event *pevent,
 							      void *closure __maybe_unused)
 {
-	if (pevent->event.header.type == PERF_RECORD_SWITCH_CPU_WIDE)
-		return PyLong_FromUnsignedLong(pevent->event.context_switch.next_prev_pid);
+	if (pevent->event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
+		return PyLong_FromUnsignedLong(pevent->event->context_switch.next_prev_pid);
 	Py_RETURN_NONE;
 }
 
 static PyObject *pyrf_context_switch_event__get_next_prev_tid(const struct pyrf_event *pevent,
 							      void *closure __maybe_unused)
 {
-	if (pevent->event.header.type == PERF_RECORD_SWITCH_CPU_WIDE)
-		return PyLong_FromUnsignedLong(pevent->event.context_switch.next_prev_tid);
+	if (pevent->event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
+		return PyLong_FromUnsignedLong(pevent->event->context_switch.next_prev_tid);
 	Py_RETURN_NONE;
 }
 
 static PyGetSetDef pyrf_context_switch_event__getset[] = {
-	{
-		.name = "evsel",
-		.get = pyrf_event__get_evsel,
-		.set = NULL,
-		.doc = "tracking event.",
-	},
+	sample_members
+	member_def(perf_event_header, type, T_UINT, "event type"),
+	member_def(perf_event_header, misc, T_USHORT, "event misc"),
 	{
 		.name = "next_prev_pid",
 		.get = (getter)pyrf_context_switch_event__get_next_prev_pid,
@@ -1513,15 +1539,15 @@ static PyObject *pyrf_context_switch_event__repr(const struct pyrf_event *pevent
 	char *s;
 	int res;
 
-	if (pevent->event.header.type == PERF_RECORD_SWITCH_CPU_WIDE) {
+	if (pevent->event->header.type == PERF_RECORD_SWITCH_CPU_WIDE) {
 		res = asprintf(&s,
 			"{ type: context_switch, next_prev_pid: %u, next_prev_tid: %u, switch_out: %u }",
-			pevent->event.context_switch.next_prev_pid,
-			pevent->event.context_switch.next_prev_tid,
-			!!(pevent->event.header.misc & PERF_RECORD_MISC_SWITCH_OUT));
+			pevent->event->context_switch.next_prev_pid,
+			pevent->event->context_switch.next_prev_tid,
+			!!(pevent->event->header.misc & PERF_RECORD_MISC_SWITCH_OUT));
 	} else {
 		res = asprintf(&s, "{ type: context_switch, switch_out: %u }",
-			       !!(pevent->event.header.misc & PERF_RECORD_MISC_SWITCH_OUT));
+			       !!(pevent->event->header.misc & PERF_RECORD_MISC_SWITCH_OUT));
 	}
 	if (res < 0) {
 		ret = PyErr_NoMemory();
@@ -1539,7 +1565,6 @@ static PyTypeObject pyrf_context_switch_event__type = {
 	.tp_dealloc	= (destructor)pyrf_event__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_context_switch_event__doc,
-	.tp_members	= pyrf_context_switch_event__members,
 	.tp_getset	= pyrf_context_switch_event__getset,
 	.tp_repr	= (reprfunc)pyrf_context_switch_event__repr,
 };
@@ -1614,15 +1639,102 @@ static PyTypeObject *pyrf_event__type[] = {
 	[PERF_RECORD_STAT_ROUND] = &pyrf_stat_round_event__type,
 };
 
+static int pyrf_event__copy(struct pyrf_event *pevent)
+{
+	const union perf_event *orig_event = pevent->event;
+	const struct perf_sample *orig_sample = pevent->sample;
+	size_t copy_size = orig_event->header.size;
+	int err = -EINVAL;
+
+	if (pevent->event_copy)
+		return 0;
+
+	/*
+	 * Clear borrowed pointers immediately so that even if copying fails,
+	 * pevent does not retain dangling pointers to the caller's stack or
+	 * ring buffer.
+	 */
+	pevent->event = &zero_event;
+	pevent->sample = &pevent->sample_storage;
+
+	/*
+	 * Allocate an extra zero byte so string fields such as mmap/mmap2
+	 * filenames or comm strings are always NUL-terminated.
+	 */
+	pevent->event_copy = calloc(1, copy_size + 1);
+	if (!pevent->event_copy) {
+		PyErr_NoMemory();
+		return -ENOMEM;
+	}
+
+	memcpy(pevent->event_copy, orig_event, copy_size);
+	pevent->event = pevent->event_copy;
+
+	if (pevent->evsel) {
+		bool needs_swap = pevent->evsel->needs_swap;
+
+		pevent->evsel->needs_swap = false;
+		err = evsel__parse_sample(pevent->evsel, pevent->event_copy,
+					  &pevent->sample_storage);
+		pevent->evsel->needs_swap = needs_swap;
+	}
+
+	if (err == 0) {
+		if (orig_sample != &pevent->sample_storage) {
+			if (orig_sample->id)
+				pevent->sample_storage.id = orig_sample->id;
+			if (orig_sample->period)
+				pevent->sample_storage.period = orig_sample->period;
+			if (orig_sample->machine_pid)
+				pevent->sample_storage.machine_pid =
+					orig_sample->machine_pid;
+			if (orig_sample->vcpu != (u32)-1)
+				pevent->sample_storage.vcpu = orig_sample->vcpu;
+			if (orig_sample->insn_len && !pevent->sample_storage.insn_len) {
+				memcpy(pevent->sample_storage.insn, orig_sample->insn,
+				       sizeof(pevent->sample_storage.insn));
+				pevent->sample_storage.insn_len = orig_sample->insn_len;
+			}
+		}
+		pevent->sample = &pevent->sample_storage;
+	} else if (orig_sample != &pevent->sample_storage) {
+		/*
+		 * Synthesized events (e.g. Intel PT itrace) or events without
+		 * an evsel may not have raw sample buffers for
+		 * evsel__parse_sample(); copy the scalar fields from the
+		 * borrowed sample.
+		 */
+		perf_sample__exit(&pevent->sample_storage);
+		pevent->sample_storage = *orig_sample;
+		if (pevent->sample_storage.evsel)
+			pevent->sample_storage.evsel =
+				evsel__get(pevent->sample_storage.evsel);
+		pevent->sample_storage.callchain = NULL;
+		pevent->sample_storage.merged_callchain = false;
+		pevent->sample_storage.raw_data = NULL;
+		pevent->sample_storage.raw_size = 0;
+		pevent->sample_storage.branch_stack = NULL;
+		pevent->sample_storage.user_regs = NULL;
+		pevent->sample_storage.intr_regs = NULL;
+		pevent->sample_storage.user_stack.size = 0;
+		pevent->sample_storage.user_stack.data = NULL;
+		pevent->sample_storage.aux_sample.size = 0;
+		pevent->sample_storage.aux_sample.data = NULL;
+		pevent->sample = &pevent->sample_storage;
+	} else if (pevent->evsel) {
+		PyErr_Format(PyExc_OSError, "perf: can't parse sample, err=%d", err);
+		return err;
+	}
+	return 0;
+}
+
 static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *evsel,
 				 struct perf_session *session, struct machine *machine,
 				 struct perf_sample *sample_arg)
 {
 	struct pyrf_event *pevent;
 	struct perf_sample *sample;
-	int err;
 	u32 min_size;
-	bool needs_swap;
 
 	if (event->header.type >= ARRAY_SIZE(pyrf_event__type) ||
 	    pyrf_event__type[event->header.type] == NULL) {
@@ -1635,31 +1747,35 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 				    event->header.size, event->header.type);
 	}
 
-	size_t copy_size = event->header.size;
-
-	if (copy_size > sizeof(pevent->event)) {
-		return PyErr_Format(PyExc_TypeError, "Unexpected event size: %zd < %zu",
-				    sizeof(pevent->event), copy_size);
+	if (event->header.size > sizeof(union perf_event)) {
+		return PyErr_Format(PyExc_TypeError, "Unexpected event size: %zu < %u",
+				    sizeof(union perf_event), event->header.size);
 	}
 
 	pevent = PyObject_New(struct pyrf_event, pyrf_event__type[event->header.type]);
 	if (pevent == NULL)
 		return PyErr_NoMemory();
 
-	/* Copy the event for memory safety and initialize variables. */
-	memcpy(&pevent->event, event, copy_size);
-	if (copy_size < sizeof(pevent->event))
-		memset((char *)&pevent->event + copy_size, 0, sizeof(pevent->event) - copy_size);
-
-	if (event->header.type == PERF_RECORD_MMAP2)
-		pevent->event.mmap2.filename[sizeof(pevent->event.mmap2.filename) - 1] = '\0';
-
-	perf_sample__init(&pevent->sample, /*all=*/true);
+	perf_sample__init(&pevent->sample_storage, /*all=*/true);
+	pevent->sample = sample_arg ?: &pevent->sample_storage;
+	pevent->evsel = evsel ? evsel__get(evsel) : NULL;
 	pevent->machine = machine;
 	pevent->callchain = NULL;
 	pevent->brstack = NULL;
 	pevent->al_resolved = false;
 	addr_location__init(&pevent->al);
+	pevent->event = event;
+	pevent->event_copy = NULL;
+
+	/*
+	 * When called outside a session callback (e.g. pyrf_evlist__read_on_cpu)
+	 * or without a pre-parsed sample for an evsel, copy the event and parse
+	 * its sample into sample_storage immediately.
+	 */
+	if ((!session || (evsel && !sample_arg)) && pyrf_event__copy(pevent) < 0) {
+		Py_DECREF(pevent);
+		return NULL;
+	}
 
 	if (!evsel) {
 		if (!pevent->machine && session)
@@ -1667,53 +1783,25 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 		return (PyObject *)pevent;
 	}
 
-	/* Parse the sample again so that pointers are within the copied event. */
-	needs_swap = evsel->needs_swap;
-
-	evsel->needs_swap = false;
-	err = evsel__parse_sample(evsel, &pevent->event, &pevent->sample);
-	evsel->needs_swap = needs_swap;
-	if (err < 0) {
-		/*
-		 * Synthesized events (e.g. Intel PT itrace) may not have raw sample
-		 * buffers for evsel__parse_sample(); use the pre-parsed sample_arg.
-		 */
-		if (sample_arg) {
-			perf_sample__exit(&pevent->sample);
-			pevent->sample = *sample_arg;
-			if (pevent->sample.evsel)
-				pevent->sample.evsel = evsel__get(pevent->sample.evsel);
-			pevent->sample.merged_callchain = false;
-
-			pevent->sample.user_regs = NULL;
-			pevent->sample.intr_regs = NULL;
-			pevent->sample.raw_data = NULL;
-			pevent->sample.raw_size = 0;
-		} else {
-			Py_DECREF(pevent);
-			return PyErr_Format(PyExc_OSError,
-					    "perf: can't parse sample, err=%d", err);
-		}
-	}
-	if (session && session->evlist && perf_guest && pevent->sample.id) {
-		struct perf_sample_id *sid = evlist__id2sid(session->evlist, pevent->sample.id);
+	sample = pevent->sample;
+	if (session && session->evlist && perf_guest && sample->id) {
+		struct perf_sample_id *sid = evlist__id2sid(session->evlist, sample->id);
 
 		if (sid) {
-			pevent->sample.machine_pid = sid->machine_pid;
-			pevent->sample.vcpu = sid->vcpu.cpu;
+			sample->machine_pid = sid->machine_pid;
+			sample->vcpu = sid->vcpu.cpu;
 		}
 	}
 	if (!machine && session) {
-		machine = pevent->sample.machine_pid ?
-			machines__find(&session->machines, pevent->sample.machine_pid) :
+		machine = sample->machine_pid ?
+			machines__find(&session->machines, sample->machine_pid) :
 			&session->machines.host;
 		if (!machine)
 			machine = &session->machines.host;
 	}
 	pevent->machine = machine;
-	if (machine && machine->pid > 0 && !pevent->sample.machine_pid)
-		pevent->sample.machine_pid = machine->pid;
-	sample = &pevent->sample;
+	if (machine && machine->pid > 0 && !sample->machine_pid)
+		sample->machine_pid = machine->pid;
 	if (machine && sample->callchain) {
 		struct addr_location al;
 		struct callchain_cursor *cursor;
@@ -4524,6 +4612,41 @@ static int pyrf_session__call_return_process(struct call_return *cr,
 	return 0;
 }
 
+static int pyrf_session__call_event(struct pyrf_session *psession, PyObject *callback,
+				    PyObject *pyevent, const char *extra_arg, bool has_extra_arg)
+{
+	PyObject *ret;
+	int err = 0;
+
+	if (has_extra_arg)
+		ret = PyObject_CallFunction(callback, "Oz", pyevent, extra_arg);
+	else
+		ret = PyObject_CallFunctionObjArgs(callback, pyevent, NULL);
+
+	Py_XDECREF(ret);
+	if (Py_REFCNT(pyevent) > 1) {
+		PyObject *exc_type = NULL, *exc_value = NULL, *exc_tb = NULL;
+
+		/*
+		 * The Python callback retained a reference to the event
+		 * beyond the callback's return (or in an exception frame);
+		 * copy the underlying event and sample before process_events
+		 * reuses or unmaps its buffer.
+		 */
+		if (!ret)
+			PyErr_Fetch(&exc_type, &exc_value, &exc_tb);
+		err = pyrf_event__copy((struct pyrf_event *)pyevent);
+		if (!ret) {
+			PyErr_Clear();
+			PyErr_Restore(exc_type, exc_value, exc_tb);
+		}
+	}
+	Py_DECREF(pyevent);
+	if (!ret || err < 0)
+		return pyrf_session__callback_raised(psession);
+	return 0;
+}
+
 static int pyrf_session_tool__sample(const struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample,
@@ -4575,16 +4698,12 @@ static int pyrf_session_tool__sample(const struct perf_tool *tool,
 		PyObject *pyevent = pyrf_event__new(event, sample->evsel,
 						    psession->session,
 						    machine, sample);
-		PyObject *ret;
 
 		if (pyevent == NULL)
 			return -ENOMEM;
 
-		ret = PyObject_CallFunction(psession->sample, "O", pyevent);
-		Py_DECREF(pyevent);
-		if (!ret)
-			return pyrf_session__callback_raised(psession);
-		Py_DECREF(ret);
+		return pyrf_session__call_event(psession, psession->sample, pyevent,
+						/*extra_arg=*/NULL, /*has_extra_arg=*/false);
 	}
 	return 0;
 }
@@ -4596,7 +4715,6 @@ static int pyrf_session_tool__context_switch(const struct perf_tool *tool,
 {
 	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
 	PyObject *pyevent;
-	PyObject *ret;
 
 	if (pyrf_session__exception_pending()) {
 		/*
@@ -4607,7 +4725,7 @@ static int pyrf_session_tool__context_switch(const struct perf_tool *tool,
 		return perf_event__process_switch(tool, event, sample, machine);
 	}
 
-	pyevent = pyrf_event__new(event, sample->evsel, psession->session, machine, NULL);
+	pyevent = pyrf_event__new(event, sample->evsel, psession->session, machine, sample);
 	if (perf_event__process_switch(tool, event, sample, machine) < 0) {
 		Py_XDECREF(pyevent);
 		return -1;
@@ -4616,12 +4734,8 @@ static int pyrf_session_tool__context_switch(const struct perf_tool *tool,
 	if (pyevent == NULL)
 		return -ENOMEM;
 
-	ret = PyObject_CallFunction(psession->context_switch, "O", pyevent);
-	Py_DECREF(pyevent);
-	if (!ret)
-		return pyrf_session__callback_raised(psession);
-	Py_DECREF(ret);
-	return 0;
+	return pyrf_session__call_event(psession, psession->context_switch, pyevent,
+					/*extra_arg=*/NULL, /*has_extra_arg=*/false);
 }
 
 static int pyrf_session_tool__stat(const struct perf_tool *tool,
@@ -4632,7 +4746,6 @@ static int pyrf_session_tool__stat(const struct perf_tool *tool,
 	struct evsel *evsel = evlist__id2evsel(session->evlist, event->stat.id);
 	const char *name = evsel ? evsel__name(evsel) : "unknown";
 	PyObject *pyevent;
-	PyObject *ret;
 
 	if (pyrf_session__exception_pending())
 		return 0;
@@ -4642,12 +4755,8 @@ static int pyrf_session_tool__stat(const struct perf_tool *tool,
 	if (pyevent == NULL)
 		return -ENOMEM;
 
-	ret = PyObject_CallFunction(psession->stat, "Oz", pyevent, name);
-	Py_DECREF(pyevent);
-	if (!ret)
-		return pyrf_session__callback_raised(psession);
-	Py_DECREF(ret);
-	return 0;
+	return pyrf_session__call_event(psession, psession->stat, pyevent,
+					name, /*has_extra_arg=*/true);
 }
 
 static int pyrf_session_tool__stat_round(const struct perf_tool *tool,
@@ -4656,7 +4765,6 @@ static int pyrf_session_tool__stat_round(const struct perf_tool *tool,
 {
 	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
 	PyObject *pyevent;
-	PyObject *ret;
 
 	if (pyrf_session__exception_pending())
 		return 0;
@@ -4666,12 +4774,8 @@ static int pyrf_session_tool__stat_round(const struct perf_tool *tool,
 	if (pyevent == NULL)
 		return -ENOMEM;
 
-	ret = PyObject_CallFunction(psession->stat, "Oz", pyevent, NULL);
-	Py_DECREF(pyevent);
-	if (!ret)
-		return pyrf_session__callback_raised(psession);
-	Py_DECREF(ret);
-	return 0;
+	return pyrf_session__call_event(psession, psession->stat, pyevent,
+					/*extra_arg=*/NULL, /*has_extra_arg=*/true);
 }
 
 static PyObject *pyrf_session__find_thread(struct pyrf_session *psession, PyObject *args)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

