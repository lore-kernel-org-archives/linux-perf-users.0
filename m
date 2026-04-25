Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11EA36494A
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139381; cv=none; b=mYFNMytvDI0dIr64eSpS+Viw0UzrOAR37gMGcoU2NTsREtC90p0DVhXXOL9CKg2zo/lU21CFXzSmK1jyeDwXMp1UWetx5/4aNZBjBDzkHxPMzD3KWZtwRCy+w65X+Cg1untnYziyDy4XUTCVQcDGT4VtAw3erE9ndWms9Fw8vg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139381; c=relaxed/simple;
	bh=0/grSbmQ0CiTb9xT/yGcjRxw7yEBV9o3vDAV5zrCKcI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qF4SnlKOzLRmPqS+s9/LpAvSWGFIDmB1abl6gNXIusoKV/+n2mHa+4+e9I78/scj2ZumFP0SuMlXtCtZH3g/4PfUd4I/zb+1rGedz9+73cmNZ6BEpG5Qy0qSwBorsbXCWqpKGWihuoevh+YwChbVsiX/jMHSpuWhfwDg2T32a8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vvl0LEDL; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vvl0LEDL"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2eaed3d96d7so727247eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139379; x=1777744179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CkVuk0SY+S7oULlsa6bLwazSaIq+Fl1rUEE6RaS7too=;
        b=Vvl0LEDLRitMiKvr315IhhrTtFGxOaCIm9OfxZo8ofTR5os3sLqbcdWMwHcHJTOpTu
         Vy55PBdrHOP6CYqSTY5VPJ78PgXJ7dtqOqiHnjSXG468RxipM+oNekRE1SlU05R0lPnD
         TUhK2l12V7Xia0h8C8SeuGQXj5+VofCB+hHkDbfd4BdkYPzKfvZPKZpD09GC/4PwGW+Z
         r2U6k8lPN5inQUeHQ62mok9+PbPf4X+lwsUU6O9URU7tLgKCMXapMv3ytOwdNGQmkT/I
         FjFN5E7X8p7oQ6DZlAHGUFKeLuMeik+Ax3SFAne3qTnhXIbhsXEDFa9RHPXAZsCCS9/U
         yjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139379; x=1777744179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CkVuk0SY+S7oULlsa6bLwazSaIq+Fl1rUEE6RaS7too=;
        b=kVyN4wWCsjvyBnNGJRJHtwi3UoPcajQIWWdKZ1dbPfWcdy0hNFCJ21d5j8+le3x57j
         K7VYdq4aCV0NLDji67htI7ihTU2+8TKB06KXd0Xsl3BylpQ2FBcYItPxuIrcxPT/y7mH
         hiL72FYSS6atFXgl1sV4Cf9kBDqyPWTHEgxSfFCbBylRDFxP4AYcdNDx4TWlUFpAhy6c
         9k3UZLP6wLAzFN/2La4mMcyxIglzkgRTcXZSYLwWKMkwd8oEIHriCzfwhJh0Y6Htws7F
         lF4B+Rfv3Y5jEfWY3D8uXPa3OMl5J4fe95q4UgLmN9Bsvss3prGGga9h6vQpPRIf2N14
         RVCA==
X-Forwarded-Encrypted: i=1; AFNElJ/m9DwDMYJSM20EwtfHslkbp3LcUuX7V5hBaBSXUyxAv2kIMxhnSSpPWs3pw0vXWNO8I5QelbpSAg3PGkA+GTSU@vger.kernel.org
X-Gm-Message-State: AOJu0YyKxZuxMnvESDF8pAzUBxJD7P3FTQEIKWrEt9/MLXEMeQoIrfXu
	PyHiKOrQegrkedHVXDGdxPzlu7HF+FxJ5HS9I9DQQMbJbfc0Fj5uMoYMuXr0bL3Inf1W9zww8nb
	r/ijf8lmxaw==
X-Received: from dyblf37.prod.google.com ([2002:a05:7301:a25:b0:2da:4e8f:1752])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:128d:b0:2da:a813:a5fd
 with SMTP id 5a478bee46e88-2e478936929mr21434649eec.22.1777139378769; Sat, 25
 Apr 2026 10:49:38 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:17 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-20-irogers@google.com>
Subject: [PATCH v6 19/59] perf python: Add config file access
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add perf.config_get(name) to expose the perf configuration system.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 70b5ad2b9b6f..b358852b3528 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -12,6 +12,7 @@
 #include "build-id.h"
 #include "callchain.h"
 #include "comm.h"
+#include "config.h"
 #include "counts.h"
 #include "data.h"
 #include "debug.h"
@@ -3229,7 +3230,26 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwar
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
2.54.0.545.g6539524ca2-goog

