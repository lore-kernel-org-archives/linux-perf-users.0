Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C97C26F45A
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Aug 2025 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567627; cv=none; b=S4cTne/1++w+cjXAsfVpOWcXgCjHW28BbmsTlJcUVQHu0IL3zwZTc2SYo3DhHMr4rTXjV1PjEol5VzW+5pzsny1+o23gVBZ7Gpu3x+wNsAGmAjq2D40p+tX49+94QbecaGMzxIAq9JbdFRpXiz94R9BnNec/kiMlJQ52OY5Vq9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567627; c=relaxed/simple;
	bh=Ot2Dr6PSv8pxCvtkjTQlrv6XbJN1DrZt3H88fFEKjgE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HWaGtA8iyRWeJ/xEbqMCaqZUS+c+Oj1COUmDLN+c5lNet7RJ/q8WY4PRQ7MxeAJc1c2Df+lvl8Z9GFsDVNDTLEYZijMToyvGcXWpg8IO6wm+C0lVMj/6+pdNXxft9eHVEcXv/9UDQyVu7306rCDo/kJJ7jR18ldqBKEFFP2qzec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ktgQDEaJ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ktgQDEaJ"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2e614889so4684752b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 18:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755567625; x=1756172425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oj1fRnWH+PUgQsyGSCdXclzhy5JmUhLP1R7WLpzdAGU=;
        b=ktgQDEaJxP6mfMe96z6l7jP7DAUBjTuZwiixGuInPGCbsOfnckmN9KYWrjx5epLHCu
         fuwjcahWrx+0y1syLb8Iuf3N+RDDs0qbYgs+uX4gPBxZpMOcq4U5wKb3Ck/QF/FhwaaY
         oqzZsRhrug/09PmAF3SGVcQ8gpJS6ItqVABGLiHCu6krVpRkvdep+MpOI9RuiNJrJpBc
         nGOFqbZkt4nAhQe2c0y7eCm9mvfYF1CmQA80SoKP2hOicEcluQ9kDUEfGcdbKnb9L29V
         IINMgmeCG1USEV+mgzX7plBdEIhfpHqM6U05pUkN0FzEiAyoTZdauMPaLJdtyCFMvOTM
         5bsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755567625; x=1756172425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oj1fRnWH+PUgQsyGSCdXclzhy5JmUhLP1R7WLpzdAGU=;
        b=ZzrTQCaalC5BU5U3+w5fIm9rJF6+bfu9+p6togxBqAQNiiwXTGmdimKqPjaaKFk05+
         3+yEQ0CNwtMA25MNsRZdgsFuNB8kd+A+qcmT+G5OSWcrW5lWd2S3ejaAJ+9QVV6TKYj4
         t5/ngolo0Xeb55RZVAGxKGw9N/vkgdoYkeXZmwAemONCFPK+YLStSX0kchjQCD2xPCqQ
         wvtRBUGlxX4TMKUvdP9ONs2opLyG501KDfihYRqlXQccS89C9NUHauaMcP9nfqV90uPh
         hvfUUiNzPK39imMK6NfRAn+sk4Ql5lZlJPLZ2bG4ocXXUH4wWwJ5ie3JiQ7IUpzUdtBo
         gXwg==
X-Forwarded-Encrypted: i=1; AJvYcCXU9Smr8yBhJMtErwr9EZtP8ok4czu3HCwe8J6eVqqhv55LX8LCrLABHqG5FFZBJ01EMKZRaRGZeP4aXIFx8F0U@vger.kernel.org
X-Gm-Message-State: AOJu0YzXYDrHrFrhIqCIXRUFpaTPKtwjx4f2V1FVoDM+480vWoyEg4AZ
	09fgLmoW7QyjZiHiK2WroSkVNUzaihuJIu8r1UUbUEMTzgL71kXVmeb9HcTSCYc6/PdujsljfUz
	eZXC8PId6Tw==
X-Google-Smtp-Source: AGHT+IGBB/9CxgsoUv0P1HhdY5gqY248ujpEmyp6WGrPPHvd4bT5y/9JA+erEo1R9vmuvSbJZrYYKgFYk3q6
X-Received: from pjtd1.prod.google.com ([2002:a17:90b:41:b0:31c:2fe4:33b6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a11a:b0:240:1e63:2dfd
 with SMTP id adf61e73a8af0-2430d42ccb1mr1040643637.29.1755567624752; Mon, 18
 Aug 2025 18:40:24 -0700 (PDT)
Date: Mon, 18 Aug 2025 18:39:34 -0700
In-Reply-To: <20250819013941.209033-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819013941.209033-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819013941.209033-5-irogers@google.com>
Subject: [PATCH v10 04/11] perf python: Add function returning dictionary of
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
Reviewed-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/python.c | 71 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 6f9728d365ae..cf1128435022 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -670,6 +670,71 @@ static PyObject *pyrf_pmu__name(PyObject *self)
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
@@ -680,6 +745,12 @@ static PyObject *pyrf_pmu__repr(PyObject *self)
 static const char pyrf_pmu__doc[] = PyDoc_STR("perf Performance Monitoring Unit (PMU) object.");
 
 static PyMethodDef pyrf_pmu__methods[] = {
+	{
+		.ml_name  = "events",
+		.ml_meth  = (PyCFunction)pyrf_pmu__events,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR("Returns a sequence of events encoded as a dictionaries.")
+	},
 	{
 		.ml_name  = "name",
 		.ml_meth  = (PyCFunction)pyrf_pmu__name,
-- 
2.51.0.rc1.167.g924127e9c0-goog

