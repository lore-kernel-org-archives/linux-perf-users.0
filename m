Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B59E48B399
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645268; cv=none; b=K3L1gqybspTw7vnAcKsWsZC5djixLiRxO2/Yr3gb83ER16CntPTjSL7cBkmGZeo1Dj0M+HM9AhgNRIlriYUWvOQVrTwUmmyhAQsg39pMJDvsg8ibOpYCTcU+WWkCm3/YpmeFV6b/USAGdOnQergEKzm//MAUl1NsiLSq7k/AKmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645268; c=relaxed/simple;
	bh=tV+debLpAcSPtF4oOnOAWTcWj1DgFb/ORcxn9jP+K0I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dVTfhKscKI9Y5ZUflrgnlnD0cRXE8njb3/LPSHJCu0R2oolpQoQRhARkOdHoyB4Q5Ii8MrTER6+Ev5i8EZKjxIPD8eZuAZT4LKCH8u8Fk4yqPWhK+GZ2jFHSFEyGbfjQaRoEH+bMeRmMFX5iOeshyaVbJLSuyP7eY0sFvPZS95o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uJETXldZ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJETXldZ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30762d67a64so2209368eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 00:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780645266; x=1781250066; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=05hUuKqwJVOkDRKHtHPVWcbk7eKV7afPYSEJE7Rrw5o=;
        b=uJETXldZS1kXBnGuuH8NV6onsXTIpBu1H8tKk5TNGnzv73CQX0UFd0fjSWRf4+12A0
         lY0b1CHQ0lqZSKdd46k91okhE6g9KzUCyBCOic6NoGt56zmCDLaNpJHF+TSsm7fpJGFy
         alcAKvF1GmWRNpWyl2SYsmZmuGW+GhrCfmX8YO4ft7pAk6VsBe0n7//EQJJFNDhf9UAv
         qGGjlLONOHaE79f89n9EZLujMYCwYgZmCO01ucWnxPhfC3QZNL4Wd6x/IXLxqb/1I5mM
         TebdE7FwS9n6KAEKLITuzXudj0n8TvYsiRRko4/ezjuaeu2jynUGp38vryxtBSL2oq4x
         qZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780645266; x=1781250066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05hUuKqwJVOkDRKHtHPVWcbk7eKV7afPYSEJE7Rrw5o=;
        b=ZySas+PiLFXvxEuVj67HSswPwlulL+Xm7ZT9ZsLnAkPq/iFy16SXTeFVa53qAR/Dlb
         j+R1yKcwjrscIjocsfoQ7H3KcTuviiXMYPqT5oRpBCM5suHdPDYauzwcwtW45eKet3mc
         0RswsNPEjU3i3I8/drCBVS0i4JZz+layq2akc7uqdPvDlG7EFVfxxWLqvPzRC79l/q/2
         J3V69CPpEsDBVJZqJZ5ilmQlWh/WGKeKQM+dSj1EhdHKrvW9efKQsvwp5zFAHQomJWyn
         GdTfEhIwx8sQ8m61+4YzKYy8hHzJ9TQdHnPocJuJCrMHronJc7ZFNoL0QJ5/Ra9A48As
         0y7g==
X-Forwarded-Encrypted: i=1; AFNElJ/lB/SJnFG6fnicKOqrMnoRZhwYxLa9Ujw0QSvm0Az3blCVPYNGmJ2K+xg8/QVHwncLh77L9x6Fj8C3xc/Mrcpg@vger.kernel.org
X-Gm-Message-State: AOJu0YwsJOb2XpE83L+sTvyKRPtJtK8VY7CIMFhkbTuhj2d3Id/cMiul
	TQmFpJggroSL8IkVFn9Sgi2xKZX8MidrTNxj6c8tmENOxid5SjcNNC9sHS6yUFuctwJYlcoeDUN
	3DrQBTMfwxA==
X-Received: from dyr22.prod.google.com ([2002:a05:693c:4016:b0:2ed:b77f:b02a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d70d:b0:304:c520:4e14
 with SMTP id 5a478bee46e88-3077b32888bmr1145824eec.11.1780645265411; Fri, 05
 Jun 2026 00:41:05 -0700 (PDT)
Date: Fri,  5 Jun 2026 00:40:01 -0700
In-Reply-To: <20260605074003.1730715-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522220435.2378363-1-irogers@google.com> <20260605074003.1730715-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605074003.1730715-18-irogers@google.com>
Subject: [PATCH v10 17/19] perf python: Add config file access
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
index 12a1379cdbed..ba97b11bf9d7 100644
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
@@ -4077,7 +4078,26 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwar
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

