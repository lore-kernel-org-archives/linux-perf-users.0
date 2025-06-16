Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64871E501C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Jun 2025 05:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750050942; cv=none; b=ZvMhpIxmOiVoXJmyUDV/pJhT0NTsd6TvsNB0sN6SwiQwzrylh9LmK2n6Ojb9E5Vm609Z++9KdsluXlr5YLrwUNJixoMAlzb64Tf6f+r1mF0iZXHEozhS/h7ycoHv2MbCPoDMa4LgBmuRxfoE8dVhy7iONJZQ4yMV6kahA/qimh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750050942; c=relaxed/simple;
	bh=zZY5QdAaatWoVBW7I7LQ11kD76DX+GBxtTOi8p7XfOs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iXoEhtIXyLPSXPnypwD/q0y0ExcMUESHzvBD2M0OZviWDyumjIKeY6h7BLnV8p60VZmoI6lUGR2xM4IedBHc0wCnIPFDRbojjMkfrPeBm1Z4vja7ODK+DrG7LhH9Kbmepyo0meu+bQQIuKEL4w5zB0/cWuXSFHGRZUAImGZPh4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WGJMyN2k; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WGJMyN2k"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c36951518so5103833a12.2
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Jun 2025 22:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750050940; x=1750655740; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TPESPEzAQJj2q7drTkMDX/Th9kHricV7LFea55YSIjA=;
        b=WGJMyN2kAFztVPM0q8EEUB+VNz6M5wFwR65nz9skEk0KvUKFtDZtpLL2doUShTfkac
         cGELlrg7MwJslCX2kU16P8YkqGzWy3TJUNCISIY4J/oZy8sST+7+B76nDhKiMsKtDKFE
         eMY3qMM/BZhMkI45cIiwWVXcdTMhPYQ3dz4joCm1JChY7qkmGg3vjRVEEJmcJQn7XG1N
         DdzEZQF66uN1XEXcvCcA4wbBDGBIi8TE1M/5Nxk94WrEKzoJFzjdmJtf41fO51DTZpbD
         /TINIdPTuYMbfBtCQtpgJZhL64bHTwGOlR1vuoS6Xm8dkXZfL3nlqOYggVvzcQfAO9nS
         PgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750050940; x=1750655740;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPESPEzAQJj2q7drTkMDX/Th9kHricV7LFea55YSIjA=;
        b=PZuuyuEGJUwhxJBRurnOOaJKzrkqZ3HZMMpVdqVqnouqx3UjBEBG45UHi8YedaX57N
         +Owtqox4KxejpecRLjNDPTGbkwdd4HA39DjrkXj+ssU+W84460sQac5aU0EC5jkKTVsK
         m9PqxTWfgiOwUI8KIR6wZB/wen7jL3Lm3S0fCfNgf9zQ2xHF83AKnaUESeZlzex+6gBL
         JugGhRHjBKRi1w+ydRN9nH3sz03dR88Pwv/lW3zPDmFoLfEF9I/ok9md4Hts3+o2TiIB
         mS3Ey1yCSbUoyiflQbbpUcnkjhJANTQOuNo54tw9ips2BdA4AozlTexIaZguFGqfA7oV
         7Whg==
X-Forwarded-Encrypted: i=1; AJvYcCWIG59HJOuXJOGma6Ke/dexOfMppZ7KbHH8DMbxlPW67Ayxn/G4u/NkbkDJ8Bp6dCme3Q2sgoPSRs9+Gn5sLCjG@vger.kernel.org
X-Gm-Message-State: AOJu0YwzxpMH4wLmWISZJrtMeuLyGRGMjNOxjpmaLm98HV2vRETlto82
	dct7/36MvrQzoyV5jTquvMGaNq8csb2WJ3kHB8ztREa7Cg7M4MXVF8oNKkLbV5F75HXBrZAuLLB
	4OcOdmtbmkg==
X-Google-Smtp-Source: AGHT+IEqUCk6kDNnznwLR7QswDVgEKNTjE47vrZVlVegCSdLW0pjKFX8we9erSxwtSxzpV8I2/gJIE8scUhO
X-Received: from pgbfe2.prod.google.com ([2002:a05:6a02:2882:b0:b2c:3c0e:f01c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7a90:b0:1f5:70d8:6a98
 with SMTP id adf61e73a8af0-21fbd295a7fmr11528932637.0.1750050940348; Sun, 15
 Jun 2025 22:15:40 -0700 (PDT)
Date: Sun, 15 Jun 2025 22:14:52 -0700
In-Reply-To: <20250616051500.1047173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250616051500.1047173-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc2.696.g1fc2a0284f-goog
Message-ID: <20250616051500.1047173-8-irogers@google.com>
Subject: [PATCH v3 07/15] perf python: Add function returning dictionary of
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
2.50.0.rc2.696.g1fc2a0284f-goog

