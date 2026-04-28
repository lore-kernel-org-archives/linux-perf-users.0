Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652063D75C9
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360794; cv=none; b=T5FPHSG3GTwDmMzfOwCMiZbdN2QP6Usyj/cKUCMsXkguNRAV3mDmlM46cnacBmREG+lm2SS8bbQHIpRbv9wjuocjTnnd2a1V/OaoU88/PyGK7YINQtQPDEytimPsl90r7sZEEYZ75vGVMuYQsK2nxxYjJv0PQ7dIg8PNMOl8/34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360794; c=relaxed/simple;
	bh=Y03vtRttWB6MUdCpQ0RauPt1dtQAcFDAOZ2ITIcgvjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bhcgRNfRtYi/TbnFhsiJuzBx3BBkKwNgMpSfl/t2/akEvxCIBYkq20DIiFRe793KQWzQfNTT542ihJIIQdAR45jhifnePYcEIBUxlXduKb+im2P8frj0d6io5ZcPsWXRLO8fVklcSNqo9dwzh6fZCbrUDemo1I62M70IDxqXy0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B6uM7r7k; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B6uM7r7k"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c35f2c09dso14239564c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360790; x=1777965590; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tJuqBIsBHp8I+zU9u4yHTVu56TpbRMNDcYeLbhz4OBY=;
        b=B6uM7r7kcXFpsYG9A8rYKfXpkCH5E3935baQbKwwG1RhHvBzr3J+gnD1lfBhcaDruv
         PL2wevij1rd3gGjORu3NG2rFSg1+FeZW47oO8O5Ue7j00IEVGE1vEMFsROYTVuj2Bzza
         aOgp9skgYaa5LbptHVQrODj2IXKTyUZ65SwGiK5pf9VHwhOEH+BvcBhmfwL0YVQ9z5ka
         njKDO069mLjQ8zJSUg70u0tiCryxkKJhQrTKwT+TC3chI/YJDtkpbYkVZm6gT2KeWYkj
         gKuYrKAeYkUEwgRo1pu4xsDIebbVPSygHGSjXjrnT/JC9xCStTiVWHjKQkbwyU7KDyA9
         KGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360790; x=1777965590;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJuqBIsBHp8I+zU9u4yHTVu56TpbRMNDcYeLbhz4OBY=;
        b=ZxdW/4+IA+kKKNDLCnKJq4BTx4mddag49gnFitWVquBqYmz/HoZtI+BqhcbwYDVl63
         24m7Yio4Gi+KHsO+7ny9pTj8ElW1jGT9ebA9ayMKlqKeGOvWwU601rZRjzK3nfKlFC5y
         dmQTYgYCyWBQ/3jH4eq0wN6z5tDaeElXA4jhdlPtseKQ+EL2ehQJ+L1YWRnJuchc3c+q
         6aOquhTdp0VpLpu9QlW32XqiQjoWqyLLy4dsLwUfI3V/wDioL+Zt63WWb6ILBZdiewsH
         /+qizyul7gN2/g+9VMboK5NDQ59e72FKYTmNMJkkvI26ATMOH28WU189jTgnEt7GFcFg
         bMyw==
X-Forwarded-Encrypted: i=1; AFNElJ/KSMtxrPnW2rt9ZcDmVIsTl+qlg+M+FgrqFCHwAa9DOo0OlaKGfUf1pZNOKs2N/PbrAL+HmQ2OqOPHBqF82V85@vger.kernel.org
X-Gm-Message-State: AOJu0YxWtJ4JEHtx5xkTRY5QqdjaeliIOxZEfGqt7mL44BcB3zC8nH9q
	aNvQwVwUkyFr4UlfDnXX9nDBLrPgJ2PA8rq3I+VrWdJJ+NzOr1QPyv4ahNMzdy/fiVWI4k23/CR
	3oM9owVwz9A==
X-Received: from dlbrl15.prod.google.com ([2002:a05:7022:f50f:b0:12c:177a:ac1d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:11f:b0:128:bf8d:44d2
 with SMTP id a92af1059eb24-12ddd944310mr790909c88.2.1777360790350; Tue, 28
 Apr 2026 00:19:50 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:21 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-17-irogers@google.com>
Subject: [PATCH v8 16/58] perf python: Add mmap2 event
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

If mmap is handled so should mmap2 events. Add support as a distinct
python event type.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 60 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 1ca296000351..ae009bc9a0d7 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -151,6 +151,54 @@ static PyTypeObject pyrf_mmap_event__type = {
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
@@ -776,6 +824,9 @@ static int pyrf_event__setup_types(void)
 	int err;
 
 	err = PyType_Ready(&pyrf_mmap_event__type);
+	if (err < 0)
+		goto out;
+	err = PyType_Ready(&pyrf_mmap2_event__type);
 	if (err < 0)
 		goto out;
 	err = PyType_Ready(&pyrf_lost_event__type);
@@ -805,6 +856,7 @@ static int pyrf_event__setup_types(void)
 
 static PyTypeObject *pyrf_event__type[] = {
 	[PERF_RECORD_MMAP]	 = &pyrf_mmap_event__type,
+	[PERF_RECORD_MMAP2]	 = &pyrf_mmap2_event__type,
 	[PERF_RECORD_LOST]	 = &pyrf_lost_event__type,
 	[PERF_RECORD_COMM]	 = &pyrf_comm_event__type,
 	[PERF_RECORD_EXIT]	 = &pyrf_task_event__type,
@@ -971,6 +1023,11 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 		size_t max_len = pevent->event.header.size - offsetof(struct perf_record_mmap, filename);
 
 		pevent->event.mmap.filename[max_len - 1] = '\0';
+	} else if (event->header.type == PERF_RECORD_MMAP2) {
+		/* Ensure '\0' string termination. */
+		size_t max_len = pevent->event.header.size - offsetof(struct perf_record_mmap2, filename);
+
+		pevent->event.mmap2.filename[max_len - 1] = '\0';
 	}
 
 	perf_sample__init(&pevent->sample, /*all=*/true);
@@ -3234,6 +3291,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_mmap_event__type);
 	PyModule_AddObject(module, "mmap_event", (PyObject *)&pyrf_mmap_event__type);
 
+	Py_INCREF(&pyrf_mmap2_event__type);
+	PyModule_AddObject(module, "mmap2_event", (PyObject *)&pyrf_mmap2_event__type);
+
 	Py_INCREF(&pyrf_lost_event__type);
 	PyModule_AddObject(module, "lost_event", (PyObject *)&pyrf_lost_event__type);
 
-- 
2.54.0.545.g6539524ca2-goog

