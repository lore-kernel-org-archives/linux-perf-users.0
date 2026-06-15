Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F9A4218B7
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542250; cv=none; b=i567j+4Ludw7rq93krJu2COMN3hsasESNMHavB/pSGOzjEER380neyIyj/vp9ZtRaXailZEYARP4WgeMZjqETbRsCIhVnAldrOWCeEuEBXGlqqL9T3w/4uJRi48R6+PEnw9CeerEURneXKj7HiR86iM/R9dZyK9mfHpcbAWxmHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542250; c=relaxed/simple;
	bh=+kArYm+PyddyuOuiwzAv+Df/IciTN+QUSyH+40Mm5e8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N3vYh9VCBSrIg9gAZDwTws4+XdI2ed2ot4G/YHdeWHL3wpJGEkCOEbzZ+JJ5P3DIV0PrIYR2KwTTG94nwQoPR/oUTDk38i2Klusj96EXlLtiWKu9a8HW8pgjs4rTENHgdK16doE8HwJ9OWuFk6KxxjG2Ev0dE5ORGBXtKAaEnOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KLLdLEk2; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KLLdLEk2"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304e7fc90b1so4038237eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 09:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781542249; x=1782147049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wFmvWkkGaC/UhMYsb9kvVBBU8wa/WhdEif7SwlvhvB4=;
        b=KLLdLEk2LDNn06VOH09uxk4Vrrnq6xf7sKSUTY0h7fRu+WoRiozxnsp275nt20KZT8
         RK84dgp/ym/ug6d6fqzDB544HpEjTfWkW6QYvsKKDgRTx8G6m40/JYKXdHtGYpamzNHP
         Kwo/iPqyc5ocKysP1Hb5Vw6C1sE0jXzvGtJYPP6ed8kvpGkHaZpQHRsWmoICF9qMpHGA
         iO/gIFFcIT9QIJJlCvhdOBh1KT6etH/F18tpGYd5mS07Zp2dRIcdfFpXDMh06GPLqlOU
         O/8YL1qT7DaijpKcglg89owvbCJ7rjqWHcTtuxbEhyQ2z3Bg6GKWJQXtXJHUarMHVWV4
         Ewkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542249; x=1782147049;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFmvWkkGaC/UhMYsb9kvVBBU8wa/WhdEif7SwlvhvB4=;
        b=CPYLNxAUZ4pFFqcesDTTSOkO/zy0lYiNuCWQ5RxnVeS+dc1CIRZpeEaG+qtRn8581D
         8wOAzALYqMb00i2p9wejHHIO3LQQ/VF/XGgn3d4dSV+jpgCdGh5WkW0gkkKiw8HAQxpv
         nnbPRRvX1PDgiHzndcH0ly7+vtiHkMUr7rTRjDSuCy2AssjnCzwjAkQdEp1nV60H4TJH
         FhkVFYzreFu6dsffy9s47GpUSxYTaZylS4GYPriqryENnfveERAxThzmvQUKpD+0EWoD
         MVRTWHtooSJ0PkE66qoj7TfV9WmvpgST+kx0ji3lR9975bRgW4E0I1odyaXYaAlDJgv0
         EMpQ==
X-Forwarded-Encrypted: i=1; AFNElJ/BAnD9JQtDCQwU3fGC632s5wDZg6f2AGbTN2ZHSkISmTy4uxMUuwFip4MRXTUorrz4Sy4T9IyQ/zn9sLY1r66c@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9jn10SyZ95Spj3O0Xe7Q9nznF2sfViZU06IXSL79sb8CGep44
	0NiQCCJm9hiHujtmTTiUdIBLP67JHclbCApyo5gfuWtKlkDPK79x6IAfGuz2mx5ke2sZGII5Aix
	79DRO5fJRWA==
X-Received: from dyuw24.prod.google.com ([2002:a05:693c:8818:b0:2ee:b6da:180])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fe07:b0:304:2cc9:2ba8
 with SMTP id 5a478bee46e88-3093ef21d25mr5927879eec.30.1781542248558; Mon, 15
 Jun 2026 09:50:48 -0700 (PDT)
Date: Mon, 15 Jun 2026 09:50:07 -0700
In-Reply-To: <20260615165010.2724690-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615061631.2382079-1-irogers@google.com> <20260615165010.2724690-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615165010.2724690-18-irogers@google.com>
Subject: [PATCH v19 17/20] perf python: Add config file access
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
index f1230bd222d7..38a41bd6c9b5 100644
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
@@ -3990,7 +3991,26 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwar
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

