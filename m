Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57D817A301
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Jun 2025 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751069391; cv=none; b=LB+iZBuT3J5M/fZoPe7Isx/kdOqINFloeCSrPY6d2WfoQZwCUEkAo1dyb7/6JkG7idCMHtA2eOwChoOP46aonqsVt8fEPHwVm3WNRgeV313tCXtD2lmsUpCIV9Ff40tkKihkPLe3jv/n6Y6Ybu9M86pXJ+dL9c+mtX3I4d1Zn2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751069391; c=relaxed/simple;
	bh=EHllJCh3FBBjFZEiqeZh0D/LqLJSXYnbMRpNl3cGfvQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rVubwZiL5dajhtpoDclA2Xd44SmbnI/ovJmv15pz1OpJYu8u8vzpbhLH2rRdEH1QrOz8LU6ew9fBood2QBiZRSoonexBY91rnr+FPvScyY7BV6mP77lggAylWk1z8JIawP8t/DmpjEuKgAD9YjN/us7Z89fxtqcmGLlUFojzMak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V+keBXxc; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V+keBXxc"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so206326a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 17:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751069389; x=1751674189; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tL5Y631MOdTPqAWECGEy7VLE1a+4bW8n2hhp8ck1U1s=;
        b=V+keBXxcsipNTx7QFCNZZGayE2VfoYw46G3lAsAIG/2Ph5Kbyb0xTyGsDI4RwnRQHT
         QQtjNnfhgVVSRtzWlY7Uc4jUU/60wHjKVut4RKr2GYkcI+bKVHf5HKLogciq/aNlLdnQ
         6jYVhUO+bZVANj/Y0Fam4dk1NK/kbqqyent1rseHlP0CK5vYZXw/KvSeRiXWz7ZnhJrd
         qwqBdMmlPUmwpIRr1ipZrRde+Y9vImMBo18ml2+KVXQU/XQyhCaCKre1LvPuxPlxuqz9
         /L3T1RBYVuxC5yjlcmqf9p1ea1f/sA3DRHMn4wJJB1SMrJWGNPq8oFiqivayPQquoTiG
         Ii/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751069389; x=1751674189;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tL5Y631MOdTPqAWECGEy7VLE1a+4bW8n2hhp8ck1U1s=;
        b=n69FKeLPUROWFX+5QXKY1+kwdMWmeKiLmockntcfNQ051ynYrDx/Wc4s8zvaRx06P9
         ypm1aEVpFpP8TeUujISQxoCtrPO0VGedW3DH/3i6mYQyzbDhQCCjs79F6uJpldnKu5p8
         XY6RvCk49MJYPD+DcQ4Izf5TeP11nYIV/j04IAnMDmvC4JZ+JhKz0jtacJZ0pzb0eGRa
         XfTUWpgDMo5mSfEuB2X9H/6HkzP+avHT3O11i0TxM3KVRHmjeswn3JOb+6eOcopLS/Wa
         92rDAJEEltAF2zc7xlLK44Y1KlqCsOXaIdVJO1tFA4gBgScN7hZAc0KaD7ouKQqzP0Oo
         9JAA==
X-Forwarded-Encrypted: i=1; AJvYcCWKjpb7rhsDUpyyFCZA+Lr9K6mytL7IHgfm/uGQL1ZZNXTKnDkSpKdV8TMv4AM5UJQKzIm1EAD9KeyXmoyUhQGs@vger.kernel.org
X-Gm-Message-State: AOJu0YxIeulvQ3Q9HguNu4uTkJQtjZJGcJBWC8XmXKyM+gVkTGwQx2ka
	0RTkxjnKsYIeAvDFapTnyOBqVV8/BLxrjkcpMFN/kRrt1udkB78uY5OVbEDAI9IQkrmkN/qkGFm
	jLFZtwyDkgQ==
X-Google-Smtp-Source: AGHT+IFZk1yuKbKwtaqMAJQzeJc3Q7lwZyApGvaGBinyjka+yHZt+6eYIOiRdHb3F8h5NAt0RO3Yv98gMaUP
X-Received: from pjbpl1.prod.google.com ([2002:a17:90b:2681:b0:309:f831:28e0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c4f:b0:314:2a2e:9da9
 with SMTP id 98e67ed59e1d1-318c92e1a98mr7274791a91.25.1751069389082; Fri, 27
 Jun 2025 17:09:49 -0700 (PDT)
Date: Fri, 27 Jun 2025 17:09:21 -0700
In-Reply-To: <20250628000929.230406-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628000929.230406-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628000929.230406-8-irogers@google.com>
Subject: [PATCH v4 07/15] perf python: Add function returning dictionary of
 all events on a PMU
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
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
 tools/perf/util/python.c | 67 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 33b23d56dfb1..f86a82548636 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -648,6 +648,67 @@ static PyObject *pyrf_pmu__name(PyObject *self)
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
+
+	if (!py_list)
+		return NULL;
+
+	if (perf_pmu__for_each_event(ppmu->pmu,
+				     /*skip_duplicate_pmus=*/false,
+				     py_list,
+				     pyrf_pmu__events_cb) != 0) {
+		Py_DECREF(py_list);
+		return NULL;
+	}
+	return py_list;
+}
+
 static PyObject *pyrf_pmu__repr(PyObject *self)
 {
 	struct pyrf_pmu *ppmu = (void *)self;
@@ -658,6 +719,12 @@ static PyObject *pyrf_pmu__repr(PyObject *self)
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

