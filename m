Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F379739B96F
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157455; cv=none; b=Fz+04zPE+dQA8surtFbkTQ4ETh9KjMrWTry5ukqbk/rrhDEWU4RWXOBPLPtEs9UT1EoWwzmyAcelfCo22upin551gbpmGCpFLBf2rmXe0W6tfirfEBGEXUlETqZ+5v0tm4GvedoMAJpWgXS4xwGqnGpbg2JftlvaiOQdLKTSEHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157455; c=relaxed/simple;
	bh=PiF/VN47oVtkaq0UVg1dETvbcKU6+L/0hmPAremZV2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DFkBem3Z3v90eC5UcOOaTFsqzyxn0qmMK9Bgd54U0kOfjoqeMYxJ4ApyKStQrrfrofpRHtWCuCbMvqwfRF+E6mcfU7YLFYsR9xdflwqnntIoeBRyup9h3gViyOHupgBhLz6Nd+eGYKmW6QwI+D6JDEZAEO028z68AzYZawPPBYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WOrDsRxn; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WOrDsRxn"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2eaf70f3b5fso734344eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157453; x=1777762253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qNJyUA9ryt9seTGqwkY6UAT2Vxtn3jg366bqqeB58s=;
        b=WOrDsRxnc4jna2Hn+XCzrmGDemPTwi3kxJACJrfswIn8mZspvcfEtS7cRSgl9IxtMG
         TiiFPmVT8e1Lk56sczVV5d2sEZQultodkm1UYcpp8STiaX4ef+wVGUP+ZXN9Qyt4Cvbp
         LXBglp+rZH+IErTJzlgmxoZRMTmoJyAeQBlq1BCsMKlNLQx/bHdnyKFZhI2tAad5luCG
         5UCjYuq8Y51/UEYNEA4gSjEhFOsVJPTgjQbcrMbTd3JtLmwjtQmlDJnO4mWEKYV+Lt04
         Ig26lvtMb9baoujSZZxFFqCaj6iWoH90SHRSpHH+l8OLPJqvQacbcjvT6HHpa7e3gRdV
         0Dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157453; x=1777762253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5qNJyUA9ryt9seTGqwkY6UAT2Vxtn3jg366bqqeB58s=;
        b=b+6BVDmCFMKxLxKzvOmqcJobkEKd/0tA3ClJLdB0m+sqFC3EwDSF1mxod4ULRPqTST
         to+d43ggRmKQ9/LtE1rs7z2FuvAiQQRDzQkCj9a3pSb+pzeMPt9uW5VG/qhDZjkzN/z4
         L0LowO4U0mJ2h+GPwaV/mZ48fsm3QRPw5CTXt3ybNPV9Pa5KQCfcD7mHk+a+p97qbg8T
         t0hBAz6ZlKH9C2HVO4K+UPjtSoExXrY6MZd3ZZwlWCixeaEOFZAPnhDZNhD9LlCdR6Gy
         pBLlIgCC59hoK5L5MSXmCEsrToyOX7CItR0nKqwwTnek9UHJswIbV4+XRokQT91rDxyD
         8T6A==
X-Forwarded-Encrypted: i=1; AFNElJ95xnf/W50NlsyOGAkEJH1G0yawd1EsJxHD+KgBRKkzk7Lc5YDsPg4kMVkiUd6TBMF2wA+EgOirnpJgUs4PiYZO@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfk0kYuIEqtj/NcY4Obh/8ky7BQKzgLAsNhMAeqJnf2dnEUrqG
	GOUhjUPgYPwWaSKqb6Kz6Cnff/WTjxIIt38Gmip1z/gOR+OoZb3EhKP2PsHR+/7NWAH7ME7gVFs
	Qyt9+EKJ1vg==
X-Received: from dybaz36.prod.google.com ([2002:a05:7300:6c24:b0:2da:2525:9f3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:f90:b0:2ea:7901:8d72
 with SMTP id 5a478bee46e88-2ea79019c06mr8624190eec.17.1777157452753; Sat, 25
 Apr 2026 15:50:52 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:11 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-20-irogers@google.com>
Subject: [PATCH v7 19/59] perf python: Add config file access
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
index 2953c4c8e142..5478561ca62c 100644
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
@@ -3296,7 +3297,26 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwar
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

