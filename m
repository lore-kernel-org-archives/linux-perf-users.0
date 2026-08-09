Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A9D3AB292
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786259722; cv=none; b=Dms6dF8e5PehTFa9A0S4N8Lo8dkHPQn7NG2Yb3Q25ZWubW6vsEC6VI03Ta0EC8L7S3xc7lXxDy55Riud/puZt0v6SelnnqgfRQkwTOQArXIBav901YBEbV+un0YY/4gB+VI1YWfB25uD3bQ3x/taNEpzTVtZdb4jAeqhvzBNY3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786259722; c=relaxed/simple;
	bh=/S/53oJkDp5iKRz8rYm+z/UcbxOvb+U5L/9rZurOV5Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H2WbwrM5Xe4+IZAlOogSqQIJ7jmdIuUkq7ApbQGrpZ1LNlfepT5X8Ixq0S0TfIVMUxpAJmkUFljzLDy+wzImPyfokosGtn4LdGBtnIQWVlHTdeQcwnLHkDIvABGLW6T3mktcVOXHwLkktZsSGWJyQ1tSoesHjgQ2mf8fs6ssOD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mw6Xwg1C; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mw6Xwg1C"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8485b7e18b4so1793541b3a.1
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Aug 2026 00:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786259717; x=1786864517; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZnAKzRhK/xXX0RZtcxB/zK8LsdPI/TmfxzA+YrwKiiY=;
        b=Mw6Xwg1ChlUpLn4L+YkM13lTrtnSV9Z1y7SpHN2uEPqtnkqfc+Qetz0ALlnbvN/HBR
         HVR2kGTmcrhQtmocE8Tq+TcSdS36J2RBLkkPnjdBXCdILjPlMAN165zdIVpFEj6rvz8S
         QAfez7zFhvL2kN19eS2dxm3YJAbKqshJRanHXXEhWQpuISA/XO/1nF6bzZQJKHc3YVkz
         kQN2l/PQOArF2lRDSSZBdYaBffVIm7+nlNzoi09vjapurI10PnT8yozPI0WfFJAJ1Qa/
         oWZzfuHbnCzb8OoGHhmvvOEbR6VJFZZKJ0HWGs9xr5Dv0sn+H1zTzTegdtU0Pwhgoqk7
         UK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786259717; x=1786864517;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZnAKzRhK/xXX0RZtcxB/zK8LsdPI/TmfxzA+YrwKiiY=;
        b=j/W+T9SFEFiyAF5laf1us6T8cQ6KiBG4KBMG0OgwzCBCjn+QUntXyNrZG/6kuqRjvq
         R0LoZc9RnZX+jllATzIKvXHGnR29JaSq4JQcec9baYWB8dKMifGzqw4PDiRH+HjJQmJE
         7PFtyL6MA28pMUToTm4sBZgx+NELwnHL1d9oAD+3TR0HffYZXgmjlRJxZ/vwQ7Kx2to9
         65VO3AQEsvl2eTr8//dNXSuQzCUsYIC0yRzLQmAQMHXB+6HOIuByctN4QflZxALieAO3
         3YjTGUJBbS3QtvDzO2Z+KZFJEj9XTYM9uJ10cSWuO/L5NmS3lkyS3bBNm9/U3iPKCjq5
         MIzw==
X-Forwarded-Encrypted: i=1; AHgh+RqcK3eIjRmtoYTjoQWKtkejcxWS59QIuqVd2pV42u9sBHS/UmVbi2H5CKSbDAL5sfvbTJ5H6DQ6jGlCqN59WNKU@vger.kernel.org
X-Gm-Message-State: AOJu0YwQRryqnu19UqVZnvdhN8/ic8s5GyB7ou1eK+N4o1U37xlH19OB
	aFBBBaq3RxIjU/h3HrYLDHF1aIx7pdX2oOyDZTZ10TethrjWShQPdhS9cLq94LpB3qtJXz0/moG
	ykAczOaiMNQ==
X-Received: from dli20-n1.prod.google.com ([2002:a05:7022:294:10b0:13b:97f1:acba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d52f:b0:3c3:9070:96b3
 with SMTP id adf61e73a8af0-3cbce6caba0mr14267702637.3.1786259716640; Sun, 09
 Aug 2026 00:15:16 -0700 (PDT)
Date: Sun,  9 Aug 2026 00:14:46 -0700
In-Reply-To: <20260809071455.1221514-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260624051535.3584977-1-irogers@google.com> <20260809071455.1221514-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260809071455.1221514-8-irogers@google.com>
Subject: [PATCH v3 07/15] perf python: Check counts_values size in set_values
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The set_values function incorrectly assumed the list contained exactly
5 elements. Add a check to prevent out-of-bounds access.

Fixes: 877108e42b1b ("perf tools: Initial python binding")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index c7ae1f85aec6..f64d662bd3ee 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1881,11 +1881,11 @@ static void pyrf_counts_values__delete(struct pyrf_counts_values *pcounts_values
 	  0, help }
 
 static PyMemberDef pyrf_counts_values_members[] = {
-	counts_values_member_def(val, T_ULONG, "Value of event"),
-	counts_values_member_def(ena, T_ULONG, "Time for which enabled"),
-	counts_values_member_def(run, T_ULONG, "Time for which running"),
-	counts_values_member_def(id, T_ULONG, "Unique ID for an event"),
-	counts_values_member_def(lost, T_ULONG, "Num of lost samples"),
+	counts_values_member_def(val, T_ULONGLONG, "Value of event"),
+	counts_values_member_def(ena, T_ULONGLONG, "Time for which enabled"),
+	counts_values_member_def(run, T_ULONGLONG, "Time for which running"),
+	counts_values_member_def(id, T_ULONGLONG, "Unique ID for an event"),
+	counts_values_member_def(lost, T_ULONGLONG, "Num of lost samples"),
 	{ .name = NULL, },
 };
 
@@ -1895,8 +1895,15 @@ static PyObject *pyrf_counts_values_get_values(struct pyrf_counts_values *self,
 
 	if (!vals)
 		return NULL;
-	for (int i = 0; i < 5; i++)
-		PyList_SetItem(vals, i, PyLong_FromLong(self->values.values[i]));
+	for (int i = 0; i < 5; i++) {
+		PyObject *val = PyLong_FromUnsignedLongLong(self->values.values[i]);
+
+		if (!val) {
+			Py_DECREF(vals);
+			return NULL;
+		}
+		PyList_SetItem(vals, i, val);
+	}
 
 	return vals;
 }
@@ -1907,19 +1914,34 @@ static int pyrf_counts_values_set_values(struct pyrf_counts_values *self, PyObje
 	Py_ssize_t size;
 	PyObject *item = NULL;
 
+	if (list == NULL) {
+		PyErr_SetString(PyExc_TypeError, "cannot delete attribute");
+		return -1;
+	}
+
 	if (!PyList_Check(list)) {
 		PyErr_SetString(PyExc_TypeError, "Value assigned must be a list");
 		return -1;
 	}
 
 	size = PyList_Size(list);
+	if (size != 5) {
+		PyErr_SetString(PyExc_ValueError, "List must have exactly 5 entries");
+		return -1;
+	}
+
 	for (Py_ssize_t i = 0; i < size; i++) {
+		unsigned long long val;
+
 		item = PyList_GetItem(list, i);
 		if (!PyLong_Check(item)) {
 			PyErr_SetString(PyExc_TypeError, "List members should be numbers");
 			return -1;
 		}
-		self->values.values[i] = PyLong_AsLong(item);
+		val = PyLong_AsUnsignedLongLong(item);
+		if (val == (unsigned long long)-1 && PyErr_Occurred())
+			return -1;
+		self->values.values[i] = val;
 	}
 
 	return 0;
-- 
2.55.0.679.g6767b8d81c-goog

