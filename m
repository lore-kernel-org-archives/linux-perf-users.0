Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE53E1E1DE9
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657746; cv=none; b=JKisN9Oowzr7F8kzDtTPy+IS+Sxvghs5hkdRfDvBIdZeZeM/0b/w4aUHHwJFkvuhFxAK/fSmVzhgDe4/dyFT5Bj86QVpEfsUmSQEjV3vEkEkUSB6mJ2nUlpC1htyWzccL0CFVTM76OcOISOqUZzn526piqqqgjNZGrTkV1lEBfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657746; c=relaxed/simple;
	bh=7yn1cJh+rjuuX3SqnuzbrQ54eqVxAnel/00kJcXeY/0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NSAZtcq1K3ojKDe3ECKxGVU99Dbgrd0+Fx9lPNk1OrzGcotfLymlIwzahDUKTUNDhuclUKww+Pb7Tw1wUIScZtOVTBG5ZYKW/LGL5buUVAllDvQlQpqWL0KAu9S1CqT+VCDvJJ+uXhdM/DvOf42JSW+ZNXdEvkArN8Nh9i2daP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GJ2OAPt2; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GJ2OAPt2"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313b0a63c41so64333a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 09:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749657744; x=1750262544; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PGa6PzMTD/s+DbuNSHl9f5eQ82Zq4UEJ4qGkP0/iy98=;
        b=GJ2OAPt2vu/o4WxLn7spvxU8HvEYnRxLY9SJL57sP9Vy8TjeDCbA3lmKPmB9DiGV0e
         XOdUEnNNbfPtCYSycIMpvMrTuAl1FVTuvD3C7WjaAyvSXTl8MFZp1fgokdggFfMNFUcQ
         sPApnolIOpWv4BKLILM9Cxp9e+ZiFrrnZ68zW8qsGyOJYt9XGTRJGDqa59Ss6ZbNpl5x
         7cOMjMdx8gC4FO2vlAU6tWbGligbZwbj0o5Tlzh9xJZfcyTj10AS5jg0cNyC47iMSCYa
         XhvYeUgRb+uopv4uhkbG56gErqcyaTPfkGKLHHHZ8ekDz5EZTl6XDLmIev3lVSkRmQ7y
         XQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657744; x=1750262544;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGa6PzMTD/s+DbuNSHl9f5eQ82Zq4UEJ4qGkP0/iy98=;
        b=CM5MRtOR4m512nFXM2tXO4+vQ+X82/CD751dM5Zv68yabptYKfqZgRF6peSKLbiSXv
         6VbroaPyq6J6G9iFKctm+exkRbwGBqxVEUozFSjgkGzewqLc53k8TgZF1xGvMVzhqlO/
         V1Obj6m8i2jCaDKbV/jJySMY0i5sAu326CNrRnq7GS4jynUb50SYT1Ud+BilWwodXQic
         96JRYY7458jTe4GRqrVfkyTCJRg7E0KYRieWO24Z+hERyb640lT9as3NWM8rPn5v1VQj
         bGmAltHplKaFIM3R4LrFxuNT3ZYW/dhBFNzY6Angkpy5+fHNaLRXBGIIK2/axBENSdY1
         SGqw==
X-Forwarded-Encrypted: i=1; AJvYcCW3gAfm9uzz+qcULphl7+DyeLvmQHQY0nnfzNicfMenEgX7bbWI/ekVPLzlJS4gN05kn5Rwni6mPNGR4sqXjCA3@vger.kernel.org
X-Gm-Message-State: AOJu0YwSvhckaWH2vhTn8OvGBPFDy/+ei4cokCc0z2/zpPgrEbLuSCMr
	ZeG06hyK0RdokAZFfk/tQ0/C+lQ08/1+2yJlrqFzxt7I9kJBP76/zfdx/S3t5P6NYAQhD/wQFxb
	fDC+9eIvSdg==
X-Google-Smtp-Source: AGHT+IHCxTYodAspeTjp0M81Ox5+NEcko2/vD2MXSthYYWb5XCPl3aM43KLbUzhM0l070h+Y35VjcuJRGcEk
X-Received: from pjbqi5.prod.google.com ([2002:a17:90b:2745:b0:30a:31eb:ec8e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c44:b0:312:959:dc3f
 with SMTP id 98e67ed59e1d1-313af0fd27amr4934356a91.3.1749657743947; Wed, 11
 Jun 2025 09:02:23 -0700 (PDT)
Date: Wed, 11 Jun 2025 09:01:58 -0700
In-Reply-To: <20250611160206.552030-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611160206.552030-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611160206.552030-8-irogers@google.com>
Subject: [PATCH v2 07/15] perf python: Add function returning dictionary of
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
2.50.0.rc0.642.g800a2b2222-goog

