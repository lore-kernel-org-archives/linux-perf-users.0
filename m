Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB1C267AED
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511474; cv=none; b=b8rdgT8QM9nJHtSMSbxmn0E1Ngzd6mU56VSSdnGSf5sJc9bFuuDb+OEOU/G2+HmQRJl9n3U2IT+YN+RlAlN6tf5NPbqLUHKG+g1c1uCSieSc51d2nTKc/qrUMnQCCfSx35vh0jZyJkK8YMR/f68p1/JXFrvTLmPanKHa9eYli/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511474; c=relaxed/simple;
	bh=6lE7J0CHeDrRnguVoXzOcse+N16m/nBCEQyqUf7fv9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=DMc2JU8mISHzZi9EtnTJSeGK2WiL1jkaBB67WzXWMCFYqWLSgxjEP85iT2SxZZkm2n9N8+n2+odqJ7uoyp877BdcbtY8mEQ7EBc3DDz7FuJi3JYYSMzzubuDlRTYPiHuYp0j+8aFUNaDL2/i18FbfYn1PoI39AA7A/V+iiJ/xnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oY0AWdwc; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oY0AWdwc"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-235dd77d11fso49138915ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 09:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752511472; x=1753116272; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ywDV0MbtvBVNt5LHpQt2YRMH+WSUYLfE4Z1Cz/d/Ys=;
        b=oY0AWdwcZUEVaU+gQgs42n79qjfvSVGx8mtDK+Y/a1iPM0XrQMlXgA2AxmX1e4ttsN
         GogXrMMxALPvAX+cheplGKs++Gm8z+BGDt8bwJC6rhwV4fpSnrbRu+rVp+1KYp1qGR6Q
         Gz6Ecxo9Co+JR6ZBVwR8eGKnffIi6eENIzEFhvZrdqb5tYW8ag45AAkaqI3mG6fBmfxZ
         We7wMOrmZB3zpZyGo/ebKgRAfCdmQN0fnAxOpKfcNyWZNjyvabBEKzzVD7mgbpcqINwT
         JLCM8CkcGtiBIZAl434A+EKnaIlPr1Ehxh7L1fI8XY8t23cfgZbyokJLzFzftY142xID
         YHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511472; x=1753116272;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ywDV0MbtvBVNt5LHpQt2YRMH+WSUYLfE4Z1Cz/d/Ys=;
        b=t4HBmN4SueLrhMpd38tnsD2lnfCuDatwc2DjeUNsPXPgaLcUt7JPI/Iab57eJpZffx
         VNXtTuYmDV+zcJWeXDjZ6FEbbd4r9k7hjc5qeoddEAEPu/q9J8DoOoUEJCLe8XVEpFZa
         uLy0YHN2UUOL49IgxPpwDjlmOAjbJa+CLNgaWDr5G9g1e0jTfPT21KuG71wf6bExGP/0
         UnCV5McJeCgFI3M5ZOVpk//TxsadCITfyiDscIEOeioL1wfvu73SWDIlNQ/R3uM8WSiA
         tp9rc8/9LAxy9TG2Dha8sr5WEgCkhH0PWEud5E34llF4NlwYkDpCsoFu0mlbbjq9QG8s
         KVyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUknuJO96MQ+jQqCmB6S1VbRgw2kQcnB5TaYJkldzsXM1GiTeorJJiEZh/M0vuLAq8TS/c/umajSbI3oxEMFZOw@vger.kernel.org
X-Gm-Message-State: AOJu0YwjuIpqwr5LVmq3Am4TbKu121dOEieQRjw/wyY/Qi0m4Cre1Oos
	RlVNVpIcvfpfe6YC4Vogkcagj08boSlCUjkziyXsmqhy4EE36hZ5693j349T9yCE6wLHQjd+0zA
	ZfQSnbJyQSA==
X-Google-Smtp-Source: AGHT+IER6gGlKSfdu3/9bjpgJYcI3p6MQbLGztW5ihRXI2vLth+raRXa9Gup67Pi04sJC/vfHZHaelA8i3Sp
X-Received: from pjbof13.prod.google.com ([2002:a17:90b:39cd:b0:313:242b:1773])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b0d:b0:234:8f5d:e3a4
 with SMTP id d9443c01a7336-23dede2f256mr213432505ad.2.1752511472580; Mon, 14
 Jul 2025 09:44:32 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:43:58 -0700
In-Reply-To: <20250714164405.111477-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714164405.111477-11-irogers@google.com>
Subject: [PATCH v7 10/16] perf python: Add function returning dictionary of
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
---
 tools/perf/util/python.c | 71 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 860df6436f87..845476411576 100644
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

