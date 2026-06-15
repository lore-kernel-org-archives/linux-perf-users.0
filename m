Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B20E2DEA93
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 00:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781483333; cv=none; b=r4/MGpIckZX3YaZGgbl1pOuyDKDdaOmmwmR8lx1M1p3S/P/jSU+743xluIbHIe1Nz7q2bMiewDplBdKtIxtpuJ5CI/hQKN/41FAjGfWT+4wP9T7xrveiPT8fcQDFJvygK6fKcjpfqSKQgobvaMtDBTCTGlUpOwafjk8mAJPLY70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781483333; c=relaxed/simple;
	bh=fCVlpXL2uGazK6hnP6cc3BWrJaUKO5XLFx3mFaWWVvc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kAtnxz0r8F99Pe4Gc6zxKT8LVWr4uqALw+C5ez1eszSRvTUKXlT7SaYMbB+8pz3Fj337DMpN1gSIsTUqh3ug/B1xupYdFpDiAZ/P5oSF6n+gT7U9LZuwbrr6admCD9no3rNGPXCLQXwXwF5UAvuX1xsOMk3DzrG46L6+R6VvpE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RclbfHz1; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RclbfHz1"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-3074d4102a9so8325583eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Jun 2026 17:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781483331; x=1782088131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4xNHmqv7zFUKlku4dHqHUa2aWG7dWgjw71nbHE+d6w=;
        b=RclbfHz12t/L41yBCz955aTso8s4b59RKGRkA4Uifl366apShUiU+ViBcJD0FNy2jH
         LhgryYYdxqvXngIo1uOd9rpsdcL1gdF8A2WzRSMS8zkWHBZ9uYaGohtRu5Rmij/JQBEd
         RFHf9zPhE4A0oeuZhTjAWEvO1TKjjSOrSkXnFGbIYl+L5bTpZGPb9NaiNtBJmcnOr/Qp
         NZyNqUm2OFcrmNSVT+DSWVlVcbhtkwD6Qz/Tm61uuTFlohVBRPcFXVIld3P6aqjPJbob
         ic/3TaZK0h7SWsTllkfT4+8SlKIxz+RIUMwrefgO81WxIQwRLksEC0pTpZSePhC0jBjX
         VLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781483331; x=1782088131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4xNHmqv7zFUKlku4dHqHUa2aWG7dWgjw71nbHE+d6w=;
        b=rjVpSLd5WrqM3/Umsv+j2xCWLPnS+K7qtpzYrcLeSyq12JpxZsHpK9uKG5+QIHYW3i
         1I8tcVfAUCtztMU64Hz8STNtyKQmk8Yornf8w8tt0XN+43e4oG3laVo2LiV0BBUZeYVl
         uK9y8sFxCvic+VOzUC7j6an+ZSAbIyePhpBVUr0r5v66dHBRmfrLm4iklDiQQQ409AjZ
         jE0zJRKo1b9WWKjh4OXoYkGPq1RubcFhO2bdY6At4JGqzmRYmCzSQkEhTlqh8VHSxQGC
         BQJJFcTMiJME9Sm/nJmXVtBDuEBwblcJgitiRf8FaCYlS8sqcpVtzuhmw7X2H0XhLKuu
         L+xA==
X-Forwarded-Encrypted: i=1; AFNElJ9rMub+2udBaEdIDJivma0avI/PaJocT/+HRkQ9/dSjAX9tg3/1BqGoZSk9xhGMXkHJDjnhTzjBZsbiwNa17oaO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4IBStl7uH56Yp+S7wADhoax3Sx8wkNwsqGbNaF9+bA4SAeuWs
	SDKD8rkDrO934BmOIuYYM9nvh5AGG+qBSM07h1i4+RDyjmBioTeD7jkLIPzUrk6gehiU88ukvSD
	nEHHd9yEKYg==
X-Received: from dycsb5.prod.google.com ([2002:a05:693c:3005:b0:304:dfee:3633])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5412:b0:302:e560:afb5
 with SMTP id 5a478bee46e88-3082009d0a3mr7082856eec.18.1781483331194; Sun, 14
 Jun 2026 17:28:51 -0700 (PDT)
Date: Sun, 14 Jun 2026 17:28:09 -0700
In-Reply-To: <20260615002812.2234795-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613071100.1508192-1-irogers@google.com> <20260615002812.2234795-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615002812.2234795-18-irogers@google.com>
Subject: [PATCH v18 17/20] perf python: Add config file access
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
index 83ff8e8002f1..a5045e40a621 100644
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
@@ -3985,7 +3986,26 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwar
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
2.54.0.1136.gdb2ca164c4-goog

