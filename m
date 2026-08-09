Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E28C2BE63F
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786259722; cv=none; b=W+uWVDBrhd/oGQV2S//jYkmRGq9Os8Vj/Tf6PjDbgibHG19Bfppi8LZKgfj9d/KxcUkHTAFK8py9PRW74xaqKRUvuYMGzb2DXrnAs3sH3+nrn9DgUJZ/V/9a/IN2ooyxkm6sFzhYpPAXc2GV+12l7DPLWvGCOggdlDeXIZxyNpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786259722; c=relaxed/simple;
	bh=RLnINDbMcL4E/Rax6DD7gPBreL6YMJqxWiTxmhgOXcE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DPf0Asr+LWYPM77sg4tm4tIuRItT3X3O/hodT3405Nd5+eTGcpnof2SHOBt6WlGu00h8JhjflhIXuObCdm1l3WVIh3alJYNdk+WBXUuIE0Qed2oqs4srsePdzBNaxzckoeYyvnJDoufSqaLwoNqx8whSk7nzGqcFC8TfVgYS2fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KbkFR5Bh; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KbkFR5Bh"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb4bd11ddf8so1135504a12.3
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Aug 2026 00:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786259720; x=1786864520; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MQdI4gSEXiuWLEFvDKKxr4r15Yrm3sxZocQ22AwZ7TY=;
        b=KbkFR5BhEX7d/j1duf4zmmvICp816yKNXApDJ/7LhhEz5C7MikwWEgJE+YrTgfSc1r
         OrKAmWR6DYRn4dLX3Pc9LVqdy+EV8XnF0nXXFjAg1PagrLG81gTqW4a8dQLHUuYd6oH2
         E47JFY8P6K0UlJUsaBdFkh0rU+0zevZN1IHOoEURnsUnZrcXODf1KWuMKzZNEjnFf5P/
         PalG/XSRXrcsY0QJ1ML4aY0njRlmSxc9MRd4LAgqI0gQ2LhVsDeBxnEhLJE/a4els6nM
         VkBFNiVfUItusNv/bKvo/NIwbClNAbp4hPwhScGBeJe1ySvpf0n0Zd+bcCkgCzn6YnfA
         +23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786259720; x=1786864520;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MQdI4gSEXiuWLEFvDKKxr4r15Yrm3sxZocQ22AwZ7TY=;
        b=PHeI0pr4kzf4I+h4Lh+pXWE7zmJ0IxK3nOg5ufwgDxMXlY0ntgU6D4awtfPBoNqI7T
         ryqJkPiqhZakyzzbskPfc/fChP0GimShQRL8p+npwdRTOYVOvxYl7c+X8VoPv14AXkOx
         4fxTcCOUHtw61fADbYxXmtwpoY3p7aHzkh69d0pml9Dh8fCZqPlEhqO2xSrKgJCaJyey
         PHAclgswJPMNJe8D3L7UE+VJugztTIhrziBHwAl6Q5roKrCjZMk8uyq+iaPTKgtgYL41
         gEKykbCHtHRtVWnKer7Rm/xWzB4dpsqm7eH81taWSnD0GBycwCV/sK9zRcQaMOzslGEX
         w8iQ==
X-Forwarded-Encrypted: i=1; AHgh+RrhmKiq2zLWqRdq/mrXz3kfqNYjBVZP5fCJr1hSlNf3l/XJ0LRwx1LWkYOrrRXiBKDzZ7ssVy9C8Nt/4or5Kox3@vger.kernel.org
X-Gm-Message-State: AOJu0Yybws2JUQZ02RYlWXBRh2ksC13enwQvYg9Vm6SXRcDwcDFQBYGV
	VUBw6cOYl/kAMzMrim3CwfbIpE+9HJEs3+uaOMEaRmE56TuzBmpTYEsDcq3wBmjoPcNXLpRdxWp
	elLgpOSTLLQ==
X-Received: from dly27-n1.prod.google.com ([2002:a05:701b:205b:10b0:139:c655:b2de])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:138e:b0:3bf:5539:f93
 with SMTP id adf61e73a8af0-3cbcea37675mr13468273637.38.1786259720285; Sun, 09
 Aug 2026 00:15:20 -0700 (PDT)
Date: Sun,  9 Aug 2026 00:14:48 -0700
In-Reply-To: <20260809071455.1221514-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260624051535.3584977-1-irogers@google.com> <20260809071455.1221514-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260809071455.1221514-10-irogers@google.com>
Subject: [PATCH v3 09/15] perf python: Validate attribute setters in pyrf_evsel
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

If val is NULL when setting an attribute, PyErr_SetString should be
called as deleting the attribute isn't supported. In addition, ensure
PyErr_Occurred is checked before setting the attribute to avoid setting
a garbage value.

Fixes: 877108e42b1b ("perf tools: Initial python binding")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 89 ++++++++++++++++++++++++++++++++++------
 1 file changed, 77 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index a1334400874c..848912401c4f 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2301,6 +2301,11 @@ static int pyrf_evsel__set_tracking(PyObject *self, PyObject *val, void *closure
 
 	CHECK_INITIALIZED_INT(pevsel->evsel, "evsel");
 
+	if (val == NULL) {
+		PyErr_SetString(PyExc_TypeError, "cannot delete attribute");
+		return -1;
+	}
+
 	is_true = PyObject_IsTrue(val);
 	if (is_true < 0)
 		return -1;
@@ -2312,11 +2317,21 @@ static int pyrf_evsel__set_tracking(PyObject *self, PyObject *val, void *closure
 static int pyrf_evsel__set_attr_config(PyObject *self, PyObject *val, void *closure __maybe_unused)
 {
 	struct pyrf_evsel *pevsel = (void *)self;
+	unsigned long long new_val;
 
 	CHECK_INITIALIZED_INT(pevsel->evsel, "evsel");
 
-	pevsel->evsel->core.attr.config = PyLong_AsUnsignedLongLong(val);
-	return PyErr_Occurred() ? -1 : 0;
+	if (val == NULL) {
+		PyErr_SetString(PyExc_TypeError, "cannot delete attribute");
+		return -1;
+	}
+
+	new_val = PyLong_AsUnsignedLongLong(val);
+	if (PyErr_Occurred())
+		return -1;
+
+	pevsel->evsel->core.attr.config = new_val;
+	return 0;
 }
 
 static PyObject *pyrf_evsel__get_attr_config(PyObject *self, void *closure __maybe_unused)
@@ -2331,11 +2346,21 @@ static PyObject *pyrf_evsel__get_attr_config(PyObject *self, void *closure __may
 static int pyrf_evsel__set_attr_read_format(PyObject *self, PyObject *val, void *closure __maybe_unused)
 {
 	struct pyrf_evsel *pevsel = (void *)self;
+	unsigned long long new_val;
 
 	CHECK_INITIALIZED_INT(pevsel->evsel, "evsel");
 
-	pevsel->evsel->core.attr.read_format = PyLong_AsUnsignedLongLong(val);
-	return PyErr_Occurred() ? -1 : 0;
+	if (val == NULL) {
+		PyErr_SetString(PyExc_TypeError, "cannot delete attribute");
+		return -1;
+	}
+
+	new_val = PyLong_AsUnsignedLongLong(val);
+	if (PyErr_Occurred())
+		return -1;
+
+	pevsel->evsel->core.attr.read_format = new_val;
+	return 0;
 }
 
 static PyObject *pyrf_evsel__get_attr_read_format(PyObject *self, void *closure __maybe_unused)
@@ -2350,11 +2375,21 @@ static PyObject *pyrf_evsel__get_attr_read_format(PyObject *self, void *closure
 static int pyrf_evsel__set_attr_sample_period(PyObject *self, PyObject *val, void *closure __maybe_unused)
 {
 	struct pyrf_evsel *pevsel = (void *)self;
+	unsigned long long new_val;
 
 	CHECK_INITIALIZED_INT(pevsel->evsel, "evsel");
 
-	pevsel->evsel->core.attr.sample_period = PyLong_AsUnsignedLongLong(val);
-	return PyErr_Occurred() ? -1 : 0;
+	if (val == NULL) {
+		PyErr_SetString(PyExc_TypeError, "cannot delete attribute");
+		return -1;
+	}
+
+	new_val = PyLong_AsUnsignedLongLong(val);
+	if (PyErr_Occurred())
+		return -1;
+
+	pevsel->evsel->core.attr.sample_period = new_val;
+	return 0;
 }
 
 static PyObject *pyrf_evsel__get_attr_sample_period(PyObject *self, void *closure __maybe_unused)
@@ -2369,11 +2404,21 @@ static PyObject *pyrf_evsel__get_attr_sample_period(PyObject *self, void *closur
 static int pyrf_evsel__set_attr_sample_type(PyObject *self, PyObject *val, void *closure __maybe_unused)
 {
 	struct pyrf_evsel *pevsel = (void *)self;
+	unsigned long long new_val;
 
 	CHECK_INITIALIZED_INT(pevsel->evsel, "evsel");
 
-	pevsel->evsel->core.attr.sample_type = PyLong_AsUnsignedLongLong(val);
-	return PyErr_Occurred() ? -1 : 0;
+	if (val == NULL) {
+		PyErr_SetString(PyExc_TypeError, "cannot delete attribute");
+		return -1;
+	}
+
+	new_val = PyLong_AsUnsignedLongLong(val);
+	if (PyErr_Occurred())
+		return -1;
+
+	pevsel->evsel->core.attr.sample_type = new_val;
+	return 0;
 }
 
 static PyObject *pyrf_evsel__get_attr_sample_type(PyObject *self, void *closure __maybe_unused)
@@ -2397,11 +2442,21 @@ static PyObject *pyrf_evsel__get_attr_size(PyObject *self, void *closure __maybe
 static int pyrf_evsel__set_attr_type(PyObject *self, PyObject *val, void *closure __maybe_unused)
 {
 	struct pyrf_evsel *pevsel = (void *)self;
+	unsigned long new_val;
 
 	CHECK_INITIALIZED_INT(pevsel->evsel, "evsel");
 
-	pevsel->evsel->core.attr.type = PyLong_AsUnsignedLong(val);
-	return PyErr_Occurred() ? -1 : 0;
+	if (val == NULL) {
+		PyErr_SetString(PyExc_TypeError, "cannot delete attribute");
+		return -1;
+	}
+
+	new_val = PyLong_AsUnsignedLong(val);
+	if (PyErr_Occurred())
+		return -1;
+
+	pevsel->evsel->core.attr.type = new_val;
+	return 0;
 }
 
 static PyObject *pyrf_evsel__get_attr_type(PyObject *self, void *closure __maybe_unused)
@@ -2416,11 +2471,21 @@ static PyObject *pyrf_evsel__get_attr_type(PyObject *self, void *closure __maybe
 static int pyrf_evsel__set_attr_wakeup_events(PyObject *self, PyObject *val, void *closure __maybe_unused)
 {
 	struct pyrf_evsel *pevsel = (void *)self;
+	unsigned long new_val;
 
 	CHECK_INITIALIZED_INT(pevsel->evsel, "evsel");
 
-	pevsel->evsel->core.attr.wakeup_events = PyLong_AsUnsignedLong(val);
-	return PyErr_Occurred() ? -1 : 0;
+	if (val == NULL) {
+		PyErr_SetString(PyExc_TypeError, "cannot delete attribute");
+		return -1;
+	}
+
+	new_val = PyLong_AsUnsignedLong(val);
+	if (PyErr_Occurred())
+		return -1;
+
+	pevsel->evsel->core.attr.wakeup_events = new_val;
+	return 0;
 }
 
 static PyObject *pyrf_evsel__get_attr_wakeup_events(PyObject *self, void *closure __maybe_unused)
-- 
2.55.0.679.g6767b8d81c-goog

