Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03FA4D8D9C
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198358; cv=none; b=Ta7h+YY+eJ321ZFqamZLadkvxAh5MOXUGxeslHd8g5ZDYLEq8BjFsqyRVDqqXlsOHcwdD7chuIcNC99sHcFExp0+f0HUG6jjpk8hPNgXYRDi5cni7lwgS6twTokCK44+0jpSIB4qmNl0hyYvQ1c9yXEAVy79k3OvtucrTON0b2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198358; c=relaxed/simple;
	bh=Te+Lm4XROBVtifee5bBcJZlhJO3x6xcISlC99QOdMEY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sm2qkOBOgy1nwAY20+EaKX4NZhzZOBbCKIk6Tyw2gYpKOH7dENC7LxofqBbHgtK68fPFfBfA6ZSjn50ya30lh/SR2RTYQGE4bWwVK5EkHAZpO6xovMuWLNgtaPnUFoj/w2S/X4RFRJIFc/g8JhZu/UqOglxqPcE6P3u39OPZPEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CIdmGlzQ; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CIdmGlzQ"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-138155294c4so181500c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 10:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781198351; x=1781803151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/DeqyEXyTXLLR5IZkFcZFEUXnriopqxIxsZ7mPdUC6k=;
        b=CIdmGlzQ3jpqRLHzMyS4RINvTajXT4ToVZ3IfgOFmfCaD32BVelwcgKO5Rgd+ZqASW
         Go43O+jPFw496krSJNPakYQkGFf61uuedRsdwceUvmahjCp24C+zx8qppkVVo7yiIoGX
         h6Azp1yPsbZPU0OwzA8YcFArQn12uB7uwQgavAZswM+NpAAEHQnLNQ6VzvRoI/YJ1bfY
         FYduHNdCoQQQ2dKYeYjEkF/i+3vDRlrtwTgpgaDaIPn65zd52QAPX6zzg6D/I1PdPLqM
         OpWGJFXw6rW+FmLAYtRvAR7UH0F/nBXZt5DJaj9DJpeywuV+7k0qqpKFPczjTQEzNzgl
         QMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198351; x=1781803151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/DeqyEXyTXLLR5IZkFcZFEUXnriopqxIxsZ7mPdUC6k=;
        b=V7Gzcud3lsoZ78gKjp+XObVZuE0xtMM3s7SMg3cDycWvsVCiGrb5SJpQDTxvFEKVRR
         jFEsTaqnoyqL7gDmzHIMPXp8HB/P6ZcmjhzeN2COQv+ygsEnZmwQyxg3oJpFQHsitWT6
         zV58KpR7pJNbAPJJ2s8B1mdpHRaGfOwkUaz2nQ58bRQg3J7YqNLH8msNttZxvzbfgMw/
         Lz9mzrCEySUBOzd7wQmN8gAvuX61dLR877jvHJ/kSdy6aCe2exmih7fynsKyD8cs83qI
         raw+DCkZBgQ7XZCQUGyBzs2ulIHE7SuwyxrmhGdRuTQ0V+4M8fplRZTRVTnzvZZKVr1b
         02lA==
X-Forwarded-Encrypted: i=1; AFNElJ+YkIZoefuvyA/yItuA+RlkGmHTIt5Xw3UWRgPHozK4Y9Is5mHFT3AmECD+NIKt6UgEJK/p9OwPqpvM+D6MP3dK@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4wvta9TBnZmnvXX388RTW1fChxEH3xvT2KqyR2m6RSgU/ACzE
	yWpuLoGnrLgJqBJj5qeF+ERlph1KtD3Bqk2GOo8pKkcYOpOEoB5xu8GvskQow5dnejT6BZwuzgH
	+mDb6mRU+Fw==
X-Received: from dlec6-n2.prod.google.com ([2002:a05:701b:4286:20b0:138:4e1:4728])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:50d:b0:128:d4be:7438
 with SMTP id a92af1059eb24-138423fe628mr2250773c88.30.1781198350466; Thu, 11
 Jun 2026 10:19:10 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:17:54 -0700
In-Reply-To: <20260611171756.4008769-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605191500.2477026-1-irogers@google.com> <20260611171756.4008769-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611171756.4008769-18-irogers@google.com>
Subject: [PATCH v12 17/19] perf python: Add config file access
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add perf.config_get(name) to expose the perf configuration system.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index fe332cb59862..70c60675db00 100644
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
@@ -3987,7 +3988,26 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwar
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

