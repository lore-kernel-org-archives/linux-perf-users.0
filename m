Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3243E3DB4
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049309; cv=none; b=uGEcEXjPt0w+Fdho45iSA3O1w22EGi6W0NisIwODm2BtgeGgiHpXKKduRYcQULUyNHt/CclITQe0nyEIcBvz7F2Mny4/17H8tT0TdRUo+j7lrmhFhSKO/1Ycs7aUQJ1g6yWUnXeucSIDXvvIq5h6RAq+GAUqjCWEJQ2NBqM7XKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049309; c=relaxed/simple;
	bh=+8Rg0ldiv+8DuLeJFYUeRUo+S1jKd5Hj1YGiDNZGy+U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JrxPvbKoiopMLT6aIVzA2fFWev7Hm0EeoEuzqHRZrYuHO2MteA2siJx04PodjvF2R6uKoDzxsSYiiWY+gmu6c4yxCCA6zabBt6dUo3PZhgwDT85Y/0AEa51wHcKeVkof//nTsEThKPcEhpqk/Z0OKTysdGVVA62Ku0daCqIdhaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cGDhP5ci; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGDhP5ci"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2e91add2aso71947665ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049307; x=1777654107; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cG/0Aa00VOrcCbwfgsMLDLxzG3YoyfXWRPuqDAM4Krs=;
        b=cGDhP5ciz3g4tFkDZkOoBS89vIwDEBOoKn28BFzo5i1hEnLu/lZmFOX4zckyCkQaMG
         lxvb6AbPennzKx3A7a6ervs7TZzISgSdZXiw3bt0rjVJZejKe+CLhG5z3mb7el317sOh
         tJdZjiMxHVkppd1wUwZ4xqj1qfsipXm7razAR9NRrRYkZ/mXXos0qqMwXlUrODzepYfv
         vFqt5IFX4UyoMwqp4MkQSq90m0tHwJ+wZT78gQBloTL20Gmy/ePVvkRcP/V0fCgpbmhs
         Vrl2YHJRIFV8ZSZ8x044OQN42c5vNZBW7YEH+I+R9uIwKgQM4IKno0P8cwFY35Rorfw8
         khvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049307; x=1777654107;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cG/0Aa00VOrcCbwfgsMLDLxzG3YoyfXWRPuqDAM4Krs=;
        b=jVloS5rKGW6r1DuQ6X4s9pduWElIreKWqYo0h5mF9iglJDd6Rmky/c63Y9fSMV80+6
         ePLODa7HGObYK/oEYsYHE+7E99d132HMK1s7X/HST3mG0418dbuUJiwZ+R0g5i8hSmMZ
         2cJmbYyBNRinNgBfLbVuz5R2drtWcB/eOF5Rxu9W3uusKTPe/m2qot92ejBuTAWWGdgu
         upxY2qwYf3YqYmo5gaKvunQEcTPWBIrb5tnzZNRohJBcSwypzvAmNKD+4BodT2sQJYGS
         L/0XXmgEjDfKotWTMd/A934sJMF6Phkhn/DI7nDlgnTicRaLKXE3qVDqyrRMuB5q7YLN
         ZCgg==
X-Forwarded-Encrypted: i=1; AFNElJ8AiZyB+LD0Vlh5rJ1MsICFbgNTeEA4l7MF4sIaxf8Kdfbz8Rb8Y+U4CETRKL3UolYqpIux/mxo6VSLRze3JVFA@vger.kernel.org
X-Gm-Message-State: AOJu0YzbLkW3PD/41t//k5GVqUZjyRuZRWBr+ZNeQkjsZMKw3dOlXYQp
	OEvy/oBOeT8Fytt8lZE3VpZPPEZg32j2zfgy8HSnjutst7wBm2aMKAHMprXo8YtQZZK2Hvo5gFq
	Yk6v0DCYLcQ==
X-Received: from pldd13.prod.google.com ([2002:a17:902:c18d:b0:2b4:5c5f:b38f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:11ce:b0:2b4:5ff5:e51f
 with SMTP id d9443c01a7336-2b5f9f51dfemr339838925ad.36.1777049306859; Fri, 24
 Apr 2026 09:48:26 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:46:41 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-20-irogers@google.com>
Subject: [PATCH v5 19/58] perf python: Add config file access
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
index 28961ad47010..dc10d8a42d92 100644
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
@@ -3230,7 +3231,26 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args)
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

