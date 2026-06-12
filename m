Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2683A873D
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287843; cv=none; b=jg6ax3INqmvqpkrgD2e1m4f15nR8iB4h1j2VygkFA7RvpjVy1XIDYG8c6ZjLnYR4o/5c7FvwFioD6oJfWzK6xe+0f8JEw9pkvoKL+R8Z+b4rT1iJJAQDTreLcadcJxPFwNLau/woBCVkt3Eqx1Ze1nkmfwCsGHp6vwJZuDUg0ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287843; c=relaxed/simple;
	bh=GvkEXx+WyoSfBCn3vspChNN7CpfBrp92dgQlAi1nwT8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bmfFEviaE3tbPt/BpKc7VQ3EpuQRW34U/n1xknce8xTk3uhQWWbfc3SagAWIejiBL6/1uvDmmYF1AkbvPz26cASVjuDhF8jjNYIYMaT8PeqREGf7oY7YwxfRujRsjVgbbLL4TqkHluMryC3eVzZDVo975e6doJOR7i/HeZl9hmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IrDs3sX6; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IrDs3sX6"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1370417c0bfso978439c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 11:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781287839; x=1781892639; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sd57HX35XTgxJZw6bYHYrXd4/SELuMq6Jv3R/ZZi+hE=;
        b=IrDs3sX6ZOz+OqtYfpNzddxO0KTFASg2w0iYC2awsPE5MEXdS66mftLvOjvepOID85
         jQl1hinJZkVMEbPWY8lYFcB99WMFf6bz3EG0uY37lhaEk+drnLtw0B0eviDEXF4+ROek
         VjGY1Ge1eUfeuVecjH5j92Lw4GGw0NGnW/k37pmuzBLTvihXCmESgv1beN+COuIwyqA+
         OGaIQ2/EiXcOQehJblzbRC+ophUYfGMF3c26YeXba3tfYBUZzuK+ej5+DUlIKG0PIdxk
         2DCv0Dw+sd3aXtk8kQiufzdlVOq1+gJYdEyG1ku0oLhMkW40ZeTa6SDZmbpGIDMMDjuc
         QwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781287839; x=1781892639;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sd57HX35XTgxJZw6bYHYrXd4/SELuMq6Jv3R/ZZi+hE=;
        b=J5R60wA6rnK8+h3RDE2oxn31U9dbwmLLqdeqwL28zkwFW6ySMct4nmg6EQTWNVORt0
         IRCNT5UruoO2IyDB3Qr7E6TKxqbHEogKFG2fMMBDvUFRo02KvLlvFfgEqSftISDwDnky
         PhcVKW4SEp8/sSB9C9RrXP2Oy8FncaD+128hfIoUyD4qbnUIxLlKkM/wn6dtnDgQZsGR
         96IoOPWgW4jWfNwBEtZwT7UgVTvoO3soR953ijyaldlMBOcMehe/8TsxEfJsXLE/sSFt
         c4Df1L8SJGTfTo52He9+nDTCCekdRuOlO3/6biYqR7PsPF2Lpp3e8Axan+nyxoaBxobB
         OIhg==
X-Forwarded-Encrypted: i=1; AFNElJ947PAbn/nTSpg0cU4sbIA1cS6wq40ZEgC1TUrnnY8yZc/Ph5DWqtt52PMv+d7F+U4Wc4U1bw4tNnk+X54r5uPe@vger.kernel.org
X-Gm-Message-State: AOJu0YwYqiSpdn2rS7yrhSJxmDZfgNJmZJqLQ9N7/Odv5sF8mXkJbsP8
	kCHJVq9CPRH/31apZCefOTl8rRiGVS8LfvG5yWaQUSLNfe/JACw/SR85sqy47O27RapCEmhQVDu
	U5DnPsy7l0A==
X-Received: from dlea1-n1.prod.google.com ([2002:a05:701b:4201:10b0:137:dd82:5b65])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6095:b0:138:5049:cb88
 with SMTP id a92af1059eb24-1385049ccc0mr624385c88.8.1781287839009; Fri, 12
 Jun 2026 11:10:39 -0700 (PDT)
Date: Fri, 12 Jun 2026 11:09:54 -0700
In-Reply-To: <20260612180956.1105352-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611224455.201994-1-irogers@google.com> <20260612180956.1105352-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612180956.1105352-18-irogers@google.com>
Subject: [PATCH v14 17/19] perf python: Add config file access
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
index dd84fecc8fff..7a53a3c32083 100644
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
@@ -3992,7 +3993,26 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwar
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

