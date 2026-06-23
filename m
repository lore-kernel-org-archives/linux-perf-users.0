Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10873ACA6A
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 05:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192954; cv=none; b=kCbE8hLLt13yAMW5ghRDwIThZaATT1g2tqSCj2Q8sIyNC5FB7ZCo+BxymF20xkxNzyZc4Sl1wMekAyQpWfqFx6l2bRkd79HNcy/G0Ej9WEkh8pK2/8WV7UAgsIL53D4cDs9W/TCzPa0fyNYKqOjkc2FiFNCahYLPEisEcHi4yfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192954; c=relaxed/simple;
	bh=NWaNqjC3kduwsd7ZuLuL9K/04AwN84ag6EWEZXNasDs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RS4hAK0EBwzWcGygLxi+mRn8uGpcgZiOErpJZl2iHSfIkvNnqurZZ//NABdYS5EWBWeunDX6STk67H8LCPQeq2xQJe/5PM1dCOvF2if/QnDDUeavGoiwjvHkJK3dT3cQGF/CAsHyCqqpf4FsFhGHSDzjkijQGh92puJRfjo3azk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UAisBuJ1; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UAisBuJ1"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30c1f6c5559so6517890eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 22:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782192952; x=1782797752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PR7HVJT1Kdr4VQ7t0EW41YJeV0TXC5LGaW8+CPUJNbI=;
        b=UAisBuJ1jYBiXnkWvpG51+5PTtodBkYY7pQALmBv2/pBmDTep/C+dN2KluL8Brp+sf
         z+/m9gONlY6n8vw4RzMUgkW1HSrECsQhiFlnGvcJIMp+l2ZIaXbSiOha1YhSOKtgrtKu
         WBrCJmtz7jrp+x8cTQBwM6I9rxUu+Uovol3lhTnQL1U0wnFpBuf2FyQp9248na23uK1H
         4a/mDijc30famZ2WhJw6W9HwuPjLomTHzKaD8FGVEKTnbIXMvUdY27onNvuOhXGICVBw
         VW0laeUt8yI7z88ZYp08yZvF7lgereIrkkdvM2V4gBiSRVJE7jIXZpIp1OCYHzWW4ZeU
         BXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192952; x=1782797752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PR7HVJT1Kdr4VQ7t0EW41YJeV0TXC5LGaW8+CPUJNbI=;
        b=AIFgqgoVbztPWa0Hr2ngyfk82llMG2gw8fsCm+8imnMJ4BN/h70gbDP3cmgCCq1Xjo
         stFt98+ioY+yYuvJi6iIVpGHSVBueECN6VI922IvaaTYM1ZNMh5NVyWAH52nJSMjSPG8
         qK8DgvxF6rCwsnFGKP4ZmS7ALLRuRqimf4oVI8a/CNpwUEQ/t0dEE9VluKJpcgcLb9dT
         YPMgoKLVrrE3Q2bjey9FEWZ+S5Hj3z6CrA5dRyFgSkj/ywhP/AQWP+tLOCaQwsR5DSSb
         4fwhZc8SkmsXEQtQWNcVT7ebOGcmb+pNQ57TsiNbfnfdlMh+Cquwy3H//HSOe31WgT6I
         z/XQ==
X-Forwarded-Encrypted: i=1; AFNElJ9f54MT17RQCMeRczlc81Mo/RRmLpTIfd4GKInyzKZOMBqU9/IGPHanidNI28WZMSl3g3RMfdEVMDQ+YfZCkcZe@vger.kernel.org
X-Gm-Message-State: AOJu0YwpXMFVWqC9yjncZcewXbVVOInMuYOLN297rONiRxr07qgk0z1T
	bQlZIkYkD0SCgNKqEQQro5h63gm5YgKMkCcXt3iF5bbeZbK8GbaOMg0zd0mZqUahMXPYnPcteUO
	9m1EdxjxjBA==
X-Received: from dykb40.prod.google.com ([2002:a05:7300:8428:b0:30b:f5a1:fe8e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4a6:b0:139:ba7d:84a2
 with SMTP id a92af1059eb24-139c6f439ddmr650888c88.21.1782192951545; Mon, 22
 Jun 2026 22:35:51 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:35:12 -0700
In-Reply-To: <20260623053515.2677888-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623053515.2677888-11-irogers@google.com>
Subject: [PATCH v1 10/13] perf python: Validate attribute setters in pyrf_evsel
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com, 
	Ian Rogers <irogers@google.com>
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
index 62f404c40d8d..e277c89b8347 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2284,6 +2284,11 @@ static int pyrf_evsel__set_tracking(PyObject *self, PyObject *val, void *closure
 
 	CHECK_INITIALIZED_INT(pevsel->evsel, "evsel");
 
+	if (val == NULL) {
+		PyErr_SetString(PyExc_TypeError, "cannot delete attribute");
+		return -1;
+	}
+
 	is_true = PyObject_IsTrue(val);
 	if (is_true < 0)
 		return -1;
@@ -2295,11 +2300,21 @@ static int pyrf_evsel__set_tracking(PyObject *self, PyObject *val, void *closure
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
@@ -2314,11 +2329,21 @@ static PyObject *pyrf_evsel__get_attr_config(PyObject *self, void *closure __may
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
@@ -2333,11 +2358,21 @@ static PyObject *pyrf_evsel__get_attr_read_format(PyObject *self, void *closure
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
@@ -2352,11 +2387,21 @@ static PyObject *pyrf_evsel__get_attr_sample_period(PyObject *self, void *closur
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
@@ -2380,11 +2425,21 @@ static PyObject *pyrf_evsel__get_attr_size(PyObject *self, void *closure __maybe
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
@@ -2399,11 +2454,21 @@ static PyObject *pyrf_evsel__get_attr_type(PyObject *self, void *closure __maybe
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
2.55.0.rc0.786.g65d90a0328-goog

