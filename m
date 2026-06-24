Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D84330AD0B
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278168; cv=none; b=KSvFPmT3XhnDUYY3a0dxw66ErfwVvQTpQCI/iR0J9W/6COZoVmrQAA50U7N2JzwF0aHh6WO5PjU5SQLLvgaLUQmnF2oyh9KwEDX6Dqavn6JeSmW+sIlQmB/L8pnSZFUB4Ig2j77u3JM5YPjTNdYziukhHh0FdQXe0DbRoc0l9s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278168; c=relaxed/simple;
	bh=U41WycCXJkj4twqrVFPf6ahvLkQuMOIOUkjLVn9c6ZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EvJ7wC1rfQ/TgNTSTk8Vk8VT8MCC0AIGqVxlymFnNPKFKnWAJlAPWa4mhCeMslU8mvkRokQzrV44R8U6ej+boLbozU/PrFnMvsRiXeUSHhtXjQbxykNEwFVk8BXp1vS5bwSROLurOaGkhRg3m4Gp3NCyu7qyk/OqptWMaE0s4Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SF12lLbV; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SF12lLbV"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30c1f6c5559so681317eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782278166; x=1782882966; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LNRhUfPfnFHw5PlWbwx2PQPSrRiKBvtXr39D6eDjMi4=;
        b=SF12lLbVtllrZ+V9X4xd8BOtrRvgC5VpP+wO4WBadWrx1XAumueKKCGZ3huBrMZjGd
         tNTKiuD/WSgMcqt2ff9fQ99uA3rCNwstTeA9R3eMHvJcPZITPbpLUGy2s12/fGvvH+Ut
         MuQRy8PM6NgQrfYr6xJk3IMlYvnsR2ZL8l42KjC9T7XbFaMbTuCs8GyOk2TsdsgLUK72
         G/ZPjnujjQWX7CZjzlAQDmWg91Q53VRuH1i7ndisH8IRjuiQVmq4tiMzAV3Z7Yipp3mb
         2Ato7uwy56RJELuu38Rhl2zpWgGQ+WF8gT+PNTmLX/bVTrVBqIdECiRroVdGRTNRun5s
         GTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782278166; x=1782882966;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LNRhUfPfnFHw5PlWbwx2PQPSrRiKBvtXr39D6eDjMi4=;
        b=M3KT+PKUhTDjB0zs64qFZLAx/eTj9QmO6+hrdDkB9qV5tU12M6YpJXLIIbKP/ITwjF
         rQnEtN44qYZuT3/Bn857/DELwag9bplhfU0PvQ4dMITSCa0n6KcoNMhiUDfgB1VbmPU9
         BbSAsRtcT4sbeGsniKdoSV25TGVcpfeNbfr8Rc1qP6nEO2tq67i81ZKXzxVH/dMcl4DP
         mZTu9PhDAAYz2Uo3EggTkfO7wTehI/BMgtI2tFicdydFiugkAuCV7qhzGTeHC3qO301A
         ul7ui3JBjxDVFaCyJEMZS1swXFZ6cxdUphkOFcJiM6RR+nNIjFBj2+3J6tD2zFfqUKED
         7mXw==
X-Forwarded-Encrypted: i=1; AFNElJ/VnEP3td3l6hZ6A1/22atOIkfjdRy87+elqm5Xf+gQ6RZUABKy7cxZXcIXYN5x4+K/O+ZSY+bbpWYIFOHceB5H@vger.kernel.org
X-Gm-Message-State: AOJu0YwJz0Wogk0AeDBC1gMBdnnAOnG94HeqfRdeH39ygjRXmQ888OVB
	xx6HhP9045XAFVU4mG6UiI/foL9ak8abYzq9q8eMB5wmS2L6DQoafE4XnvdbY5xEH+yARDaKN+e
	FtVstk5OyVA==
X-Received: from dlbqd19.prod.google.com ([2002:a05:7023:b13:b0:138:9f7:2b4a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2220:b0:138:3613:db8
 with SMTP id a92af1059eb24-139d0bf3371mr1608517c88.3.1782278165106; Tue, 23
 Jun 2026 22:16:05 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:15:28 -0700
In-Reply-To: <20260624051535.3584977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com> <20260624051535.3584977-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624051535.3584977-12-irogers@google.com>
Subject: [PATCH v2 10/16] perf python: Validate attribute setters in pyrf_evsel
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
index 4bf37e2afb18..657b054f5e51 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2296,6 +2296,11 @@ static int pyrf_evsel__set_tracking(PyObject *self, PyObject *val, void *closure
 
 	CHECK_INITIALIZED_INT(pevsel->evsel, "evsel");
 
+	if (val == NULL) {
+		PyErr_SetString(PyExc_TypeError, "cannot delete attribute");
+		return -1;
+	}
+
 	is_true = PyObject_IsTrue(val);
 	if (is_true < 0)
 		return -1;
@@ -2307,11 +2312,21 @@ static int pyrf_evsel__set_tracking(PyObject *self, PyObject *val, void *closure
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
@@ -2326,11 +2341,21 @@ static PyObject *pyrf_evsel__get_attr_config(PyObject *self, void *closure __may
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
@@ -2345,11 +2370,21 @@ static PyObject *pyrf_evsel__get_attr_read_format(PyObject *self, void *closure
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
@@ -2364,11 +2399,21 @@ static PyObject *pyrf_evsel__get_attr_sample_period(PyObject *self, void *closur
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
@@ -2392,11 +2437,21 @@ static PyObject *pyrf_evsel__get_attr_size(PyObject *self, void *closure __maybe
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
@@ -2411,11 +2466,21 @@ static PyObject *pyrf_evsel__get_attr_type(PyObject *self, void *closure __maybe
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
2.55.0.rc0.799.gd6f94ed593-goog

