Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6562822ACD6
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 03:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749613586; cv=none; b=tI43rKu1ArND9bKt1oNXapK1v8PoF2iKZdk/ziWzdvYL6pwC11vcKYFY9f2Di2aU+gsYFk3Ej1sv5Q6p2WHsX9OYtQaKPct6597FG33nB2PAPbfzWMZGaLrrp58rbWmGlLnkSfKKBvA+AzIp/aiAljIBFs2/hWrWISzE2zS4lOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749613586; c=relaxed/simple;
	bh=7yn1cJh+rjuuX3SqnuzbrQ54eqVxAnel/00kJcXeY/0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mJYCQVhdaORaazLzh9Sq32NBCg5vOnILbYg0xSbtBppnJiu9GoP0uc3YGemDkbv2zNK8VNQDJy1GhXsQutuUXYhbeRTCulJu3fRwb+9Atnm3+HNi5QZxjQsou+czh2YpnURnf560mtNDRdkoadTfGXoJ7YFT4k0KGfYR7bXAPkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XeL9pvPT; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XeL9pvPT"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-747fa83d81dso5238380b3a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Jun 2025 20:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749613585; x=1750218385; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PGa6PzMTD/s+DbuNSHl9f5eQ82Zq4UEJ4qGkP0/iy98=;
        b=XeL9pvPTBi8AIT5O+MjlTGZibnsEXNe0jzZBfNWME0YOswATZXXb0cN4I9kGfTBBN2
         hLX82HVqInOwZyLUeT1fSWpct1TGCkZ4HIQWchnJjmCcu+YCpF3h6BiMEmi+GABCXL4v
         hUKluqRKVoF+PU1SjCL/60BngHs6bobqIUJf5SwbklAUob/62dVQBZD7aDi4/y6rV67N
         Re0Cx1P1V28IrnJM5CsxBJxFsjwe++IEkNEEVg3okRoj+2p9vpVGTSwHuWoLzeb924Hh
         DGJqJ6Vz/c+WwwV9dj4Lak6tpErS78sX4Cuo2Yhq9pLmYPxTTx4imXpXuAmEMyeDGpRP
         3hCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749613585; x=1750218385;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGa6PzMTD/s+DbuNSHl9f5eQ82Zq4UEJ4qGkP0/iy98=;
        b=kzeZvwBIzz7Y+2CbyypY2N+G6Ph/L6ov5NE3VrpYK+Ih4UiSsvP22yqpqkzJV0UKTE
         R9oPBxjC28eO+mEkyXy028Qmh/262wXXpRj4JW9DejxSHu3BCGbHomQ4CmgKelWdSBRy
         flH/p6v2rJaw8U6wFRqqycltA6/czEr5XvSrftCHvrkwrnSbtD/5fhmfejN3jo7lOuz5
         wv2Fxi9+a/QZUSoH5ad2qEVOxwjsS94ik1yl7km4L0hfB3Bfvmt6eILdtCdZO9HsJV1a
         Sr5Ijw6eXTMOzALWrjBJqRe3kHLWbibOwTozGWsi/067c+J2sO2s+W76Pf/OacPXhFtr
         cK/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxVwck5duyE7B/U4lZT7vunyt2K1kqwqvpJ3PgfW4GFwPNUsMZVwkYSqbS0TYB+G/zosSyvTF8hIRAzWuEIsk2@vger.kernel.org
X-Gm-Message-State: AOJu0YyaGW7NwTfnU0InOOOgHTDwOc6lj8H1019VjeWZmkFdHccl0LEA
	2WGQ10QnGBSRnIAFukVA7gGL63oZgcrJTVtCom5LsWPxi/5Rr2eBfgI2QHS+JVliz/qaQ+mXiR1
	c7UozK67hew==
X-Google-Smtp-Source: AGHT+IFZJviseCWiStw2if3ggLSIKk/0L38ASH3h5Rp/Bkc0PQu2790SIC+c8pJEKnEBMhP+zWf9O397IjgB
X-Received: from pghf16.prod.google.com ([2002:a63:e310:0:b0:b2e:c15e:3eb7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e608:b0:21f:545e:84f0
 with SMTP id adf61e73a8af0-21f89145850mr1864923637.40.1749613584690; Tue, 10
 Jun 2025 20:46:24 -0700 (PDT)
Date: Tue, 10 Jun 2025 20:45:21 -0700
In-Reply-To: <20250611034529.508842-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611034529.508842-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611034529.508842-8-irogers@google.com>
Subject: [PATCH v1 07/15] perf python: Add function returning dictionary of
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

