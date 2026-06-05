Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB8843E49C
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686968; cv=none; b=M30QZaN6EKzHEXlK6xgBhYbr2rPKI60cjAak4bVrAiIYAHSvh3IzzoB/XjRwjF1YATTdVGC1RcK78h6sG1uV681ViPwdZULsOg2a/gYAN94TJK5BBEJHApNV5QyDksbduFnXizdfg9M5Sa4crmb9tGTIQY/AdtUBbnYYZdaqNmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686968; c=relaxed/simple;
	bh=w1yd/z/XYQTt1hNHEuwcWfzBc4hmAKD5qco5ebYNU1E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N84txVnHogHB5VqU7LMUdwBsGaQPSKbU4IOSVPU6MJefMOQu+P3Lg8EeTmDr/qZhD05fy3e4rDugoN2aOyaO/8YXqlyM1zKzPbtJnVu0d+liOuoAeGLzp2ZLQ4JDXXhRm/CIeTiwJRECskQAc8epUGU3cfRxH3gqFSzv4VK9iak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cB14jhyU; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cB14jhyU"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-3074d4102a9so3403891eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 12:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780686955; x=1781291755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RC28M9mEcLkVFlz0oF4GWnFHeX+me0A8/p355m7Vpm0=;
        b=cB14jhyUP6BmfVkwGm/4Ucq86BoxXQJUyv/sJTnHLDdWUgKQLb8f7bmVZpn1r3DKnk
         RYydI+3wPTeB4jHJqtWTS0Npq6jQKJUhiY3esMTpa152ETiSzvdPQpG41xRoKMQWl+Hy
         7ogtVsmI3/1/QbEZJLoS28UTXIEiatnhopF8ZKIEgsXyURi/saT6vVH+O2NRu7a5WB5t
         OD+NxY1PqSr/GVHLadwOaCo/z3zNQf0AScQqwCFi2cu9aBm+/BZ3UIn0EXh49sf06T/Q
         QveQODMMp0x40wNDdIKYLZSEaIUWaMLM1Ui1zHU7P+2VOUPj6RpdcPEM0yQQq5W0W1wl
         Z3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780686955; x=1781291755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RC28M9mEcLkVFlz0oF4GWnFHeX+me0A8/p355m7Vpm0=;
        b=k9ioxE9sxb8VCYyXQHLEEJTxxT+P1dZgmw8k49Kv0exCDW4bxak3nM6hdJA0pFV/j5
         KRLWUJw5FASlchqdWBU7oWsPm4ifRqMfYF6Yi2sq8obsGdtxhrHySSoGZ+Al9GcPSDoB
         3xSpZNG3BqXyqFgRqwSqRWC+7/EF7//2BF2s4sDexK05Mew6WauoN277u9Wchl5GBYLl
         W/v980xE5oWe2g7Ft5u4P89/OLKUut4dFvQDI67GLoBUi1njgZUXrEYdbVsVf/XKrlDi
         1gMmprSjpF/CTkodxQDb8V4vyCxLrcs+KSGJog8w5EuAv5HJV6ACrormEsne2Ra81Tcd
         c9qA==
X-Forwarded-Encrypted: i=1; AFNElJ+Xe5DTED02og5bqaVbMIijoaxA2Z5+ve0SrUEi1V0V6IblUNJD6vEes/ifR5Id8QguzXHZ9C+0rdI8FwsWwC2B@vger.kernel.org
X-Gm-Message-State: AOJu0YxDHoipcdCm6rBJTDsnJwxZUXafwepeB3j4pTxUtjVbrcyrPz/D
	zDRvl+hFsWD9oE75w9d0Mk2bd0mJaaLU++41BnLYVApFJfPSj3Dnb3gPXunGD9nPbnixQe5bRe0
	WxCNmFb6vIA==
X-Received: from dybhh11.prod.google.com ([2002:a05:7301:290b:b0:2f7:767f:edba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:231a:b0:304:8366:9fb6
 with SMTP id 5a478bee46e88-3077ae70f45mr2827804eec.2.1780686954925; Fri, 05
 Jun 2026 12:15:54 -0700 (PDT)
Date: Fri,  5 Jun 2026 12:14:58 -0700
In-Reply-To: <20260605191500.2477026-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605074003.1730715-1-irogers@google.com> <20260605191500.2477026-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605191500.2477026-18-irogers@google.com>
Subject: [PATCH v11 17/19] perf python: Add config file access
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add perf.config_get(name) to expose the perf configuration system.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index b4baf8cd79fa..8f476ad5c99a 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -17,6 +17,7 @@
 #include "build-id.h"
 #include "callchain.h"
 #include "comm.h"
+#include "config.h"
 #include "counts.h"
 #include "data.h"
 #include "debug.h"
@@ -3974,7 +3975,26 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwar
 	return PyLong_FromLong(id);
 }
 
+static PyObject *pyrf__config_get(PyObject *self, PyObject *args)
+{
+	const char *config_name, *val;
+
+	if (!PyArg_ParseTuple(args, "s", &config_name))
+		return NULL;
+
+	val = perf_config_get(config_name);
+	if (!val)
+		Py_RETURN_NONE;
+	return PyUnicode_FromString(val);
+}
+
 static PyMethodDef perf__methods[] = {
+	{
+		.ml_name  = "config_get",
+		.ml_meth  = (PyCFunction) pyrf__config_get,
+		.ml_flags = METH_VARARGS,
+		.ml_doc	  = PyDoc_STR("Get a perf config value.")
+	},
 	{
 		.ml_name  = "metrics",
 		.ml_meth  = (PyCFunction) pyrf__metrics,
-- 
2.54.0.1032.g2f8565e1d1-goog

