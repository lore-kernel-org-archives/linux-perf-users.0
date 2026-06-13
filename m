Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DFB3D47DC
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781334706; cv=none; b=MNwOh4bxeOlN6QXc4zzFLePBhpSXCU9OyKGQbaHKFcarfHoBoHbkKbwPwl5jaJ7yW6qA9fenRmTZhUaJ8mAQ/yUVfGfghhbCJ1h0TH/5tZrz/PCDNq8j5X/A4H4iFARGl2JRVXDKXwQwfHrhbJ6HQ6uwomFhPCbzHxQRMxM1Rxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781334706; c=relaxed/simple;
	bh=npwL/O+BA0NvQZzsM+xp/KcU2GkuUA7zmO7lDwezw04=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iN9SORADb+r10nx/CTRbW+y7LDDr6A38nMoE97kgInxoIqMBrPGhmF7O//Er3e+fJfZrcKUhTrivos3X8M9Kgcwfzv2A48wC4sAH0u9wzO5H/KIsootZP15dhtADkpyD/HScue0Vu+yLjJbLWDMHkyk7R7ISPvw1gL9494/GPuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=skDWw79g; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="skDWw79g"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304ed777a96so1246153eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 00:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781334699; x=1781939499; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0QfaA44UPiuUyHzODLhFu9IHeOi8gx5uD9ClltiPQ98=;
        b=skDWw79gJv8KMYkWCGN+XIQM0fKqcpXk6bar5hAaF2lzoQSejvfVQmqXn3+e/vI9Nn
         1/A0bPNAObf0dh7fk6ZF7pjAsTbDbpAAsweinBsybA4aw7N12xFCmNPbVDTQZcUUkrHM
         elP//r1hslV8gLRu2N4Wtn/gdYoWjS5wEVy76yezxjyhNlVmM8Ti3qJXlC/y+jOY/pR5
         qrFwmno540eaB0A6k3LduTiTPBUErQBIRIvgmI5cyZnZ54bt2M8jtFKFl25JVN2qfFDK
         LE5KFo+CmUdX4V/P/b/xnb7B6Kt7jPnV9TsSthLpFKO7OfVBKEDhpAcC00XbWoqJBj93
         3fiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781334699; x=1781939499;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QfaA44UPiuUyHzODLhFu9IHeOi8gx5uD9ClltiPQ98=;
        b=jvB6knAnD+xDK/J0iz+WYFubJQVriTDoRx2L2l8Hi/xQbMf44tltcPkgiUk3wC+JoR
         PQpibkjPImgoYX72qDPg8SB4boO+gd3t9Vd3vNzo7zt5Ubbqm1pZfQ4/5fpoS1XSGMkl
         XNBTb1xPFtK1uMY81QepuiZHrVdDInCdZXSb6Iz3O5LXCwsF3AQuNhxfHcbYLgLZsUU2
         N0EfULTUufIGlpHGdsNmrnNbWJWy26v8cOx31v/Pz913r4guTVyfIw520Hq5H4Kxuo6I
         bSV9dpUKmRWd4LVE7BpdiGA+5aIClBMLoSnUaG61Qg55F1Wb7/fRNvEIhCxKWsZq06l8
         Y3zQ==
X-Forwarded-Encrypted: i=1; AFNElJ9PS5RNCMbqNyd4RKyd680seYeCTc9cMdbE1AZdQEN4H/nUk8P+EpOch69UYrQ1zgvZc2x7xUYWdl4xYCo79L/k@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7m0F2DYRD/mju+ItJyVQdSR879U9oz8hTOEXlvqRm45+7DPjr
	WZlxnFB8toSJ/dKBZna35s3eUUjDNxImSPpOSH0ZwECeN2O/hyVZzJ8g2HS/hdsRBZCq6tkoB6c
	h2exzC9hKxA==
X-Received: from dybci3.prod.google.com ([2002:a05:7300:a483:b0:303:3f37:eaf5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4b18:b0:304:6822:2cb2
 with SMTP id 5a478bee46e88-30820cc3819mr2669066eec.11.1781334698329; Sat, 13
 Jun 2026 00:11:38 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:10:57 -0700
In-Reply-To: <20260613071100.1508192-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613052722.1424093-1-irogers@google.com> <20260613071100.1508192-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613071100.1508192-18-irogers@google.com>
Subject: [PATCH v17 17/20] perf python: Add config file access
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
index 8b708d29b1cc..ee88b3af98e3 100644
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
@@ -3980,7 +3981,26 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwar
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

