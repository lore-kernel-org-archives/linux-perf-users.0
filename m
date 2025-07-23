Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA02274FC1
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753313000; cv=none; b=ddFDzoHWeMgZ+gJ4tQafwkup2JC2OEpYht6lromx/ufSpPG8B7s6nXafVUa885GPUnzHg+djyf54Fsm2VYJnRHy2RvZVLu6R2pzL4M1kXelZvJ/G4PH3Ookxq/kQ8/OhXtNDkdz7VGD0+iA9cYFr6PaH+bD+PiTl59TEd2JQXQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753313000; c=relaxed/simple;
	bh=7W2OwNvCKl5AjDEGsRcKdkWux7FNfF8gWFpHCiwbOTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hGSHQX5Ogncd63uJpKzeH8mi3KaVUvLhTJG+DCdHkOV135HQtT5jIq/A4iYcw1TqfY/+EIisgdvRsK0+RGeypKUrEYfJaqIsUNZ/rx6UbAKUgAmtGeoaZsFOhtmK0yO7nBa9g7e+jQC3SAy38pNs/ECahJC+cMWObbCH5GEqmBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ByWB/+m+; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ByWB/+m+"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3928ad6176so351763a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 16:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753312998; x=1753917798; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vQX6HKbYgS42p2L0uks7UqDqcpdHxytIA9YuMYrF0ZQ=;
        b=ByWB/+m+3e0EfRFVLROa9m97JajdscK1t9e7EXArnPMjQnq47QvHKmYMJMgVPolZu6
         8tb0oFfrHt8Rz9TFbwp3cEKqA1OAShxHc0z97OS1NkWZ0PCIJJNhj+vmolLDh6VgZbY/
         upO+Yeuy8WTJlcFNqzO8hMWh/NiW33UVt6GfwdJkxkpetbxzDlNsXZC7YGkun5vKW5Ek
         AY5mcNEfurd1F9vbGdPFlG+b/UPmqFCaicuWUd99/I0vat3zK6HZE9sfFBMQsrb2XHe3
         qVpi0hOiOYdtlheoSBNR76Je8RkYx9NN007BN4C8ygj7TZPh8dQ96pUa4Tx87XXoXgHH
         fAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753312998; x=1753917798;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQX6HKbYgS42p2L0uks7UqDqcpdHxytIA9YuMYrF0ZQ=;
        b=tIomwJDl5kV8h0amixYL3ZS2N8SDYRNc2MOYpMh4j2Yrneqp1evmg5lZHf51wLtdGH
         dTj0jKWnzVFNZnGmuvv3VbmyBdsIL2ZeeD17BXzijGmBXZO9D76G9F21DU48ktRXBmBd
         6RJB7yzHyM1t46TGPGMab5WWeKTNSutGr1wxobNXUtngvXZdQqtdnFRFeILxwkOsQL7h
         XEX12b71RAilUVI/oGbKBWiXZ7yCFekmMi9y+C6DQC+IpfWCiHeoFV9ElvgOK2Fy4h2+
         NcP9ZJ2/9v/Q4jdUS1z9uJlOrRlOqZRF8LdTLHVLUUG/sVs05PBW4mwo4Md6yCNgbzCK
         xxfw==
X-Forwarded-Encrypted: i=1; AJvYcCVxX97n1Cu+0WkXAJrlHDZ8QR1jOQAqZPmnu+BYYxRNw9wQvM/q+0oze5GnzduNECYLc63i22jknPonGGeqQp+j@vger.kernel.org
X-Gm-Message-State: AOJu0YyyPZCoh7ttattcjrAL4jjVETz/ow0t43pTHigxPbmABZKadpYp
	75F4ipkEN78T0ThMgOjvNG2TYUmFBrc/14lC1XQxsfFQQeBqQCeGSLJxUYaimTA2VPL03/kJEAJ
	hFPObIXyYYQ==
X-Google-Smtp-Source: AGHT+IGPQ7QbY0ypIIaymwMZ5McrQ2xp90w71N7CCBFAjq64ioImo5NRcvUbrvOuvM8F7hqeZbUr7vGKhlz0
X-Received: from pga3.prod.google.com ([2002:a05:6a02:4f83:b0:b2d:aac5:e874])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:99a2:b0:238:3f54:78f1
 with SMTP id adf61e73a8af0-23d4916e98dmr7794433637.43.1753312998305; Wed, 23
 Jul 2025 16:23:18 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:22:11 -0700
In-Reply-To: <20250723232217.516179-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723232217.516179-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723232217.516179-11-irogers@google.com>
Subject: [PATCH v8 10/16] perf python: Add function returning dictionary of
 all events on a PMU
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Allow all events on a PMU to be gathered, similar to how perf list
gathers event information.

An example usage:
```
$ python
Python 3.12.9 (main, Feb  5 2025, 01:31:18) [GCC 14.2.0] on linux
>>> import perf
>>> for pmu in perf.pmus():
...   print(pmu.events())
...
[{'name': 'mem_load_retired.l3_hit', 'desc': 'Retired load instructions...
```

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 71 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ddcb5d40ff14..d49b4401ab7e 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -660,6 +660,71 @@ static PyObject *pyrf_pmu__name(PyObject *self)
 	return PyUnicode_FromString(ppmu->pmu->name);
 }
 
+static bool add_to_dict(PyObject *dict, const char *key, const char *value)
+{
+	PyObject *pkey, *pvalue;
+	bool ret;
+
+	if (value == NULL)
+		return true;
+
+	pkey = PyUnicode_FromString(key);
+	pvalue = PyUnicode_FromString(value);
+
+	ret = pkey && pvalue && PyDict_SetItem(dict, pkey, pvalue) == 0;
+	Py_XDECREF(pkey);
+	Py_XDECREF(pvalue);
+	return ret;
+}
+
+static int pyrf_pmu__events_cb(void *state, struct pmu_event_info *info)
+{
+	PyObject *py_list = state;
+	PyObject *dict = PyDict_New();
+
+	if (!dict)
+		return -ENOMEM;
+
+	if (!add_to_dict(dict, "name", info->name) ||
+	    !add_to_dict(dict, "alias", info->alias) ||
+	    !add_to_dict(dict, "scale_unit", info->scale_unit) ||
+	    !add_to_dict(dict, "desc", info->desc) ||
+	    !add_to_dict(dict, "long_desc", info->long_desc) ||
+	    !add_to_dict(dict, "encoding_desc", info->encoding_desc) ||
+	    !add_to_dict(dict, "topic", info->topic) ||
+	    !add_to_dict(dict, "event_type_desc", info->event_type_desc) ||
+	    !add_to_dict(dict, "str", info->str) ||
+	    !add_to_dict(dict, "deprecated", info->deprecated ? "deprecated" : NULL) ||
+	    PyList_Append(py_list, dict) != 0) {
+		Py_DECREF(dict);
+		return -ENOMEM;
+	}
+	Py_DECREF(dict);
+	return 0;
+}
+
+static PyObject *pyrf_pmu__events(PyObject *self)
+{
+	struct pyrf_pmu *ppmu = (void *)self;
+	PyObject *py_list = PyList_New(0);
+	int ret;
+
+	if (!py_list)
+		return NULL;
+
+	ret = perf_pmu__for_each_event(ppmu->pmu,
+				       /*skip_duplicate_pmus=*/false,
+				       py_list,
+				       pyrf_pmu__events_cb);
+	if (ret) {
+		Py_DECREF(py_list);
+		errno = -ret;
+		PyErr_SetFromErrno(PyExc_OSError);
+		return NULL;
+	}
+	return py_list;
+}
+
 static PyObject *pyrf_pmu__repr(PyObject *self)
 {
 	struct pyrf_pmu *ppmu = (void *)self;
@@ -670,6 +735,12 @@ static PyObject *pyrf_pmu__repr(PyObject *self)
 static const char pyrf_pmu__doc[] = PyDoc_STR("perf Performance Monitoring Unit (PMU) object.");
 
 static PyMethodDef pyrf_pmu__methods[] = {
+	{
+		.ml_name  = "events",
+		.ml_meth  = (PyCFunction)pyrf_pmu__events,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR("Name of the PMU including suffixes.")
+	},
 	{
 		.ml_name  = "name",
 		.ml_meth  = (PyCFunction)pyrf_pmu__name,
-- 
2.50.0.727.gbf7dc18ff4-goog

