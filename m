Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4E820F3F7
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 22:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241917; cv=none; b=bWo0JEvZbjHrg7Mln0dQfWpfV5es2vSzS/wW35dmwloPLrRBouQcZJ+kcGewUEQEZUx08jetP6NYV9qu5WLuyqUYOcg4YKQNj2IePBRjgNuXfCox0VSfISV/0DC23CBKHiwNRPVynkZFrj0vwXRZQfHTy+k5k4HfZ/UAaJTIXig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241917; c=relaxed/simple;
	bh=wFg8rXKhwSk+/WnE2Ybco7HPsV496JVgIBfe+G5oj+I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jd5zmDMgTCz1f6RzxqcsARoGT0Pz2qiU5/RNVcOw7gKA+jfopxSnzR850A2eB2kiqKS74A/mCaPbAu4iHnqkx/PYQ8xycOtmNl8OEB1zLFYd/rBA9EOgK7lDv7bJpoJaM1ylCLICUL8Ke+nXfGZpTxiDRi0TXgfi96MgofagMGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lVk1HH/G; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lVk1HH/G"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3d6713619so92707917b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 15:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730241914; x=1730846714; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ACBWh/O4/X4qiB3oXOqHhx7Z60zaZQtrFXt6UTS1Yas=;
        b=lVk1HH/G04RNpalDAb5ZxZPb0029+qThAA8htVxpr8ZWj79Er0aDAv0VSGp2GMVQp0
         5wkjSLri36LlYrx1ZOU6OXkIKPenrU9a3nali3ZRxTRLV6bLFx9R9NoTAbN/RfxTcDCT
         Y2aS2qn4GsNbEMfuIjP4rEUpg6KYA0as4sqyW+kkOQHv3iSUCWn2H8q7FgKblPbQe7Vr
         afrLRNdnFyy9kFNqIu9r9hTes0wNv+QmV3++UBdLo/j5kMxcgNOk4mzZdvrYWbc8Bpg7
         zD4ff//8SBUpoXVprtFPT2tg+9dlwHDRBeI9zIX2ezAEQVNGILrgJvzEX0XoBnwV9xm2
         fIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730241914; x=1730846714;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACBWh/O4/X4qiB3oXOqHhx7Z60zaZQtrFXt6UTS1Yas=;
        b=ajotZoE/4Exr8sHL1bI5ScytGW2KrOLv8MnU15QH8tKhTIvzzph1P2qV0p7FkMP3iF
         ofQKyYI8cBTq22U++/9gFSESqez+9cgoviPtmgrbCWNMDWL1EMC1Qyhs9nBxlu+HmG37
         iQ3AQ6vdvNzcAXrR/qz5GjxgE3whq4NMRQd1Yvt0zK3HHE2kyPN9UvXNf2Vk2rDY84YD
         sti8P0CU7DHP35D4KfKIlIWzC4UQCqOpv9h8wvl6TRcIoGDMhSLwGC1U22B7hscHaEdn
         zrpvTLj13kqkBhNkclp8jjgAxjcJA1Dvk/BPA7mDsHQC5GwLFlscZ+jaPnVCGqvVVZnN
         iv0g==
X-Forwarded-Encrypted: i=1; AJvYcCVYNloQseAbwJJ8bhDnk9Cu8SmKrDtPodxNJiP2mlb6eSzyMVsjYN3AFNCrJmKSZPUflArYEK/QEw4GE5iEcqCx@vger.kernel.org
X-Gm-Message-State: AOJu0Yybj3YmuOz081YpWjSx5wPG2zWvtXTjpHfADmIJS0AWGhPQhi9K
	fCHd03Q+jGanSXR91FqxfJed5hY91rhHgNT0NatSvkns2qnSLxkps1LWdDKGd7wa59kXdgcI7HU
	KU/V2PQ==
X-Google-Smtp-Source: AGHT+IHMWAy13SQ+8+uIKYT+wWyqA6f4LfReuZMtkZDb3SMdJ6/mM831/a5FCW0qA1CcmYiBgEyIDuXzCQXZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8991:d3fd:38a7:c282])
 (user=irogers job=sendgmr) by 2002:a81:be02:0:b0:6a9:3d52:79e9 with SMTP id
 00721157ae682-6ea3b94f7famr436597b3.4.1730241914417; Tue, 29 Oct 2024
 15:45:14 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:28 -0700
In-Reply-To: <20241029224431.167623-1-irogers@google.com>
Message-Id: <20241029224431.167623-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029224431.167623-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 16/19] perf python: Add parse_events function
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add basic parse_events function that takes a string and returns an
evlist. As the python evlist is embedded in a pyrf_evlist, and the
evsels are embedded in pyrf_evsels, copy the parsed data into those
structs and update evsel__clone to enable this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cgroup.c |  2 +-
 tools/perf/util/evsel.c  | 19 ++++++++-----
 tools/perf/util/evsel.h  |  2 +-
 tools/perf/util/python.c | 61 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 0f759dd96db7..fbcc0626f9ce 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -473,7 +473,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
 
 		leader = NULL;
 		evlist__for_each_entry(orig_list, pos) {
-			evsel = evsel__clone(pos);
+			evsel = evsel__clone(/*dest=*/NULL, pos);
 			if (evsel == NULL)
 				goto out_err;
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f780e30aa259..4213ffacdc3c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -453,7 +453,7 @@ static int evsel__copy_config_terms(struct evsel *dst, struct evsel *src)
  * The assumption is that @orig is not configured nor opened yet.
  * So we only care about the attributes that can be set while it's parsed.
  */
-struct evsel *evsel__clone(struct evsel *orig)
+struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
 {
 	struct evsel *evsel;
 
@@ -466,7 +466,11 @@ struct evsel *evsel__clone(struct evsel *orig)
 	if (orig->bpf_obj)
 		return NULL;
 
-	evsel = evsel__new(&orig->core.attr);
+	if (dest)
+		evsel = dest;
+	else
+		evsel = evsel__new(&orig->core.attr);
+
 	if (evsel == NULL)
 		return NULL;
 
@@ -511,11 +515,12 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->core.leader = orig->core.leader;
 
 	evsel->max_events = orig->max_events;
-	free((char *)evsel->unit);
-	evsel->unit = strdup(orig->unit);
-	if (evsel->unit == NULL)
-		goto out_err;
-
+	zfree(&evsel->unit);
+	if (orig->unit) {
+		evsel->unit = strdup(orig->unit);
+		if (evsel->unit == NULL)
+			goto out_err;
+	}
 	evsel->scale = orig->scale;
 	evsel->snapshot = orig->snapshot;
 	evsel->per_pkg = orig->per_pkg;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 04934a7af174..7f41d6f8cf6f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -241,7 +241,7 @@ static inline struct evsel *evsel__new(struct perf_event_attr *attr)
 	return evsel__new_idx(attr, 0);
 }
 
-struct evsel *evsel__clone(struct evsel *orig);
+struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig);
 
 int copy_config_terms(struct list_head *dst, struct list_head *src);
 void free_config_terms(struct list_head *config_terms);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 6e2ff0076daa..1a53a97c513d 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -13,6 +13,7 @@
 #include "evsel.h"
 #include "event.h"
 #include "print_binary.h"
+#include "strbuf.h"
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
@@ -1201,6 +1202,60 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
 #endif // HAVE_LIBTRACEEVENT
 }
 
+static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel)
+{
+	struct pyrf_evsel *pevsel = PyObject_New(struct pyrf_evsel, &pyrf_evsel__type);
+
+	if (!pevsel)
+		return NULL;
+
+	memset(&pevsel->evsel, 0, sizeof(pevsel->evsel));
+	evsel__init(&pevsel->evsel, &evsel->core.attr, evsel->core.idx);
+
+	evsel__clone(&pevsel->evsel, evsel);
+	return (PyObject *)pevsel;
+}
+
+static PyObject *pyrf_evlist__from_evlist(struct evlist *evlist)
+{
+	struct pyrf_evlist *pevlist = PyObject_New(struct pyrf_evlist, &pyrf_evlist__type);
+	struct evsel *pos;
+
+	if (!pevlist)
+		return NULL;
+
+	memset(&pevlist->evlist, 0, sizeof(pevlist->evlist));
+	evlist__init(&pevlist->evlist, evlist->core.all_cpus, evlist->core.threads);
+	evlist__for_each_entry(evlist, pos) {
+		struct pyrf_evsel *pevsel = (void *)pyrf_evsel__from_evsel(pos);
+
+		evlist__add(&pevlist->evlist, &pevsel->evsel);
+	}
+	return (PyObject *)pevlist;
+}
+
+static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
+{
+	const char *input;
+	struct evlist evlist = {};
+	struct parse_events_error err;
+	PyObject *result;
+
+	if (!PyArg_ParseTuple(args, "s", &input))
+		return NULL;
+
+	parse_events_error__init(&err);
+	evlist__init(&evlist, NULL, NULL);
+	if (parse_events(&evlist, input, &err)) {
+		parse_events_error__print(&err, input);
+		PyErr_SetFromErrno(PyExc_OSError);
+		return NULL;
+	}
+	result = pyrf_evlist__from_evlist(&evlist);
+	evlist__exit(&evlist);
+	return result;
+}
+
 static PyMethodDef perf__methods[] = {
 	{
 		.ml_name  = "tracepoint",
@@ -1208,6 +1263,12 @@ static PyMethodDef perf__methods[] = {
 		.ml_flags = METH_VARARGS | METH_KEYWORDS,
 		.ml_doc	  = PyDoc_STR("Get tracepoint config.")
 	},
+	{
+		.ml_name  = "parse_events",
+		.ml_meth  = (PyCFunction) pyrf__parse_events,
+		.ml_flags = METH_VARARGS,
+		.ml_doc	  = PyDoc_STR("Parse a string of events and return an evlist.")
+	},
 	{ .ml_name = NULL, }
 };
 
-- 
2.47.0.163.g1226f6d8fa-goog

