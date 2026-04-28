Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86653DA5AF
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360802; cv=none; b=POVzBLE4N9WK0nqDB3X/skhj9yJfIOeCeuoWM8Fzje2BtnyIVXOKlsV9wdQFmDPG0wjeHsxEoZITXywG1lfk7N0WKvhwqaIxIpx5TBv0b6J5wFVNB3U8puIux3aRH+SWYWOBiuDC8ZKJnBL1j3+2Xf2ZznWvg4aOmcQKmmreNyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360802; c=relaxed/simple;
	bh=7hNKXvHeSTkW6elDsgSk5uHSRgNblDmhwvwySV92TJ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uu6nWgkb6ajBFg2wvdpvxxvrJFo3EiKHucIvtkMA16rOgXMSFjBpJXM2bjnpRqPaYWpw0ayjRtpZ/9yX5Iqeats/aBVknV18ZQjvl2hUHe2bc+fh6kiVmlz2aSHMNgIi3TLdhq0PXVOORE8OhbroIwx52kWu4lrEETTKofNze2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P3zsUEsJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P3zsUEsJ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35d99c2908cso10798860a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360800; x=1777965600; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gVX9vTJ6DzeN8b9iChBp6ZbHODR3lqJPETUzipsrmEo=;
        b=P3zsUEsJX4Xh0KOrKBe40OVmmT9JCxCXOcBCIIxlgCVZ1QxuMp30qfML4+u/z5VHLM
         ntvtmJ2LPG86qZyKohVXHq1WVs+SlyeKQXeODBg+X5VJfHiL34dsQN6Rb1R5MKrYYlgo
         LfxCJpvRHtnz3wjEvqVeQ4VntccoSAlP/4ECtyRDhOmhoyTcGb/Bw5y/s3ubg0U2xyTz
         4zjNISq78OK6PbjG0V2E/2BLT0awOTVrNJsY+oJZUlTfn6C1Vl6hHm0YvTF+WlR2G4Zm
         /TXlb24OFg8HK3Qv1nXxic0C+BN/hUkd4rTkpuO46z89vtYI/yEF4+/gcQu0hHZ9f5t0
         Tc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360800; x=1777965600;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVX9vTJ6DzeN8b9iChBp6ZbHODR3lqJPETUzipsrmEo=;
        b=IrzkDJX/9qFQBZIcuT8HjeuRNlIM1LCMJ1X3RkCvtCqUO4iXhqvk50tpDA91HNEZpJ
         S9a/BstzPgdQkzy56q6hAIAELdjrlARMREqOarVs37cHHt9AjsjwkR6aCBLuJ2XTjYLr
         awLOVYNMfNrneSDxLqYfjfcwfVOEnC/BX7lxy453oMJcvv1gNCD5YznyKhjhOEkgK+/E
         EGfQx4MhxNUJLTLnHvi6DEegEBM/jIv4lhotAss2TaTw50i8++44KsJP7ahIdvAHDg+3
         3RWaPgQJvuiPPvdlVtxyneyEACN827IsITdzrELSLZ4amUeGdjpuUd/KjWYbhpbOv/Oj
         3TOA==
X-Forwarded-Encrypted: i=1; AFNElJ+oM12/gFGZ9ZU8oT51ExZk6YeZOh/4abNXUDUSEpNHMSM4bWwQNUJZpQ28KNn9hjtjDL6VTBJWcgd44fDXQ9cm@vger.kernel.org
X-Gm-Message-State: AOJu0YwXLweb0AHNhHrK5s61ZiRV13f0uloioliBd5R1xdMs7qv9mYDT
	UVtlW225+4kDOuziJUwqPML/kW4iaJOJLgMvte6co5AsFhFQ4Ek+ltEeZ+5xEfuAM6ISYraj2sa
	vlEAKWMJSkg==
X-Received: from plrt5.prod.google.com ([2002:a17:902:b205:b0:2a3:1bf9:d25])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c92:b0:359:f2e1:5906
 with SMTP id 98e67ed59e1d1-36491f6c206mr1956484a91.4.1777360799930; Tue, 28
 Apr 2026 00:19:59 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:26 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-22-irogers@google.com>
Subject: [PATCH v8 21/58] perf python: Add config file access
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add perf.config_get(name) to expose the perf configuration system.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 69d443c504d3..0e7f2a0bb532 100644
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
@@ -3821,7 +3822,26 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwar
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

