Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D8C21A424
	for <linux-perf-users@vger.kernel.org>; Mon, 19 May 2025 19:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747684347; cv=none; b=eDpZn7v/QIQrlvfS9NwiaZT2zb3Y3yXyTjVWI9XzErbJcI8G7QFFso0sNpys3WNfDSQt6khjNgZi8hvzo/qubrFZRTd+edzjKLXKkn28dgd1KYbIwIuGgNm39o7NdC4iRiOBcrYyZpu9fxZiX8FHVqd7LW4MM5SUnp71iYvdR6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747684347; c=relaxed/simple;
	bh=iAgV7BW4u5uUh4ychZ6qiJayY9OaxSfuMeeVJ8Gi8f0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=detQ+W9j0J78yWIfYXgQvC5ZK4bt3LYRQWr3GmwZlgz8lP5hOrTLyhim3oZA1y7g4F5JBfnreEuWzia1R76Z4FTVo1f38Oer3BHMP3MpK+2/31GnkqZ9rZBYjzDWbTNmQzP9wy4OfQ8bnMVz0GFYtuLyL5W8lCXdgmqhI3q7PJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k/iqsnmi; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k/iqsnmi"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742b6705a52so3749665b3a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 19 May 2025 12:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747684345; x=1748289145; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=saq9JYuyHAErN9FVTy/nLE9pQHk/DpTR8gysANVHMSg=;
        b=k/iqsnmicgDdBAMgP0ogB2mqTTymZ2pZrAWdxGauYy3kSCG9V5EurEl30a/NAFe0wE
         JpDFtPME2y3/kPWkE1PCgaKTMhvre6hWwVHgfeKnOhZTwzimUeU1nFf43S+Awqn7VnUP
         42Eb5WCAim9R+p/nGREbkmwkf7Ft9g+cG8j/yhZ1iBHzaffoVpLsAkZCNrEEeWcO+XuA
         7qGbJv4u+sc5dZSUT/JtrQaDBUSVzm9gwg9/gTPZjH0wEExI0KwpBv1etu13bHYtLNkm
         OkiYCTTqfQ+If2eNA/1G5yG/vW8uWCebAJkDzfj6PC5hGZ5X5YThAZZeeoBCuEAnnPWg
         XzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747684345; x=1748289145;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=saq9JYuyHAErN9FVTy/nLE9pQHk/DpTR8gysANVHMSg=;
        b=pCFuBROzlchZ7R2dGoLQdJJ7wxKlSQSiR9mJGsnZiBmVjFkFw8m7CwAlBs8qoOT4Md
         8Bg2C522hC4z55UGCZn1iNd9lHT5npwLGcZm2H9czNf+AKErQ/D3eqCBWRovF+FN+YYf
         /k7oLurb+RymBv3mggk0dh9rdLidBgA/9aBIMRqv1YT8VH/UXE0Y5FCXy++sx4cyvoGi
         tZOsbH2/Ybdx6fp7Mb1lH2jLuxh73/kmGS9B9lf0d66HS6Rd5aIbMITWO9X6yYcNj33a
         gX7fu9qkJ4e1oYeshoK4ZDvMhTlTWJxvBiAudTcwmmHf2tz2A1pc52BFEKTaZhhs6J2w
         mS1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZIAYPHOM4/9fBj1NTYbL/2eI9XFYozvFL8OI+zJTU6WaswaXZuLbwhCWIjibI5Q3AQHk3VgTTDGWWRFDO3uLH@vger.kernel.org
X-Gm-Message-State: AOJu0YwW5GgherPdOvXlYXUG6/8xnjDtmnKx5Gha81u35tLxE/I87w2g
	ELRm40Z+rob4v2Sikjt1iYznythQbi9XwIZl/mXbAaAFXHd1zqpGHE2cti+9EZP2DnmThDfdI19
	wsGaOtccang==
X-Google-Smtp-Source: AGHT+IH36TdO2shN7wIqHx2QpBMAhu0p2bXa7g0NsDHgwATqb4rk9Hb7IpGSGe9mgzdyZ4suzeocUIL+Xp/R
X-Received: from pfbjt23.prod.google.com ([2002:a05:6a00:91d7:b0:736:38af:afeb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:391a:b0:740:a879:4f7b
 with SMTP id d2e1a72fcca58-742acd5115amr17650760b3a.18.1747684344784; Mon, 19
 May 2025 12:52:24 -0700 (PDT)
Date: Mon, 19 May 2025 12:51:42 -0700
In-Reply-To: <20250519195148.1708988-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250519195148.1708988-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519195148.1708988-6-irogers@google.com>
Subject: [PATCH v3 5/7] perf python: Add evsel read method
From: Ian Rogers <irogers@google.com>
To: Gautam Menghani <gautam@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

From: Gautam Menghani <gautam@linux.ibm.com>

Add the evsel read method to enable python to read counter data for the
given evsel.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
Ian modified from v2 to make the API take a CPU and thread then
compute from these the appropriate indices. This was discussed as the
preferred API with Arnaldo:
https://lore.kernel.org/linux-perf-users/20250512055748.479786-1-gautam@linux.ibm.com/
---
 tools/perf/util/python.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 1cbddfe77c7c..281e706e102d 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -888,6 +888,37 @@ static PyObject *pyrf_evsel__threads(struct pyrf_evsel *pevsel)
 	return (PyObject *)pthread_map;
 }
 
+static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
+				  PyObject *args, PyObject *kwargs)
+{
+	struct evsel *evsel = &pevsel->evsel;
+	int cpu = 0, cpu_idx, thread = 0, thread_idx;
+	struct perf_counts_values counts;
+	struct pyrf_counts_values *count_values = PyObject_New(struct pyrf_counts_values,
+							       &pyrf_counts_values__type);
+
+	if (!count_values)
+		return NULL;
+
+	if (!PyArg_ParseTuple(args, "ii", &cpu, &thread))
+		return NULL;
+
+	cpu_idx = perf_cpu_map__idx(evsel->core.cpus, (struct perf_cpu){.cpu = cpu});
+	if (cpu_idx < 0) {
+		PyErr_Format(PyExc_TypeError, "CPU %d is not part of evsel's CPUs", cpu);
+		return NULL;
+	}
+	thread_idx = perf_thread_map__idx(evsel->core.threads, thread);
+	if (cpu_idx < 0) {
+		PyErr_Format(PyExc_TypeError, "Thread %d is not part of evsel's threads",
+			     thread);
+		return NULL;
+	}
+	perf_evsel__read(&(evsel->core), cpu_idx, thread_idx, &counts);
+	count_values->values = counts;
+	return (PyObject *)count_values;
+}
+
 static PyObject *pyrf_evsel__str(PyObject *self)
 {
 	struct pyrf_evsel *pevsel = (void *)self;
@@ -918,6 +949,12 @@ static PyMethodDef pyrf_evsel__methods[] = {
 		.ml_flags = METH_NOARGS,
 		.ml_doc	  = PyDoc_STR("threads the event is to be used with.")
 	},
+	{
+		.ml_name  = "read",
+		.ml_meth  = (PyCFunction)pyrf_evsel__read,
+		.ml_flags = METH_VARARGS | METH_KEYWORDS,
+		.ml_doc	  = PyDoc_STR("read counters")
+	},
 	{ .ml_name = NULL, }
 };
 
-- 
2.49.0.1101.gccaa498523-goog

