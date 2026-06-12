Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB533F929E
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781302391; cv=none; b=kp2HPxNv9F0G8zG7UHJMyO4cNeZFoO8bywzGC281jFycvNzyHay7i6h023gI8r7BNbP1EnfLu1Sy/WrKytShO8sH0GT+HPSXlxJJb3rVRAtcigAcJZJGS5tsL3tvrY49BsckTeAy/2psNYxJCEuy6KEbsfrbWzcnxxsWcVDfGFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781302391; c=relaxed/simple;
	bh=mpzQ8f5oVqGZZG+IuRtrBchA27nExmYu7EqSh6/JRPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=seFJxLssdoaesuKY6QM5jEtU7TkswuZ47DtSXvAa1U0YNisQfBDUkDvUI6zPsR4d41la+KVk6MVsGc41Lj4n0DVGNV5G0C2b47R5AzGsxu2ZXDxDxSkVJJZvt3VC1c5qGJwLmVfbE+uZsM8n5oShrbI8BJKrQIjztcp5rQKMhiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bFsTOmiU; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFsTOmiU"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304df51ff3eso3159724eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 15:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781302389; x=1781907189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pRMEwmh6f+KZ0VDSdIOWnsZ8bN+t3OAhBwecQVSCEK8=;
        b=bFsTOmiUoEORCoP2rxiT8CiTQ+5AjTYjsYlBMhIP+Qv+1RdwJXqq2sEsHXt49wmRuJ
         LITgbhFIbKlE2UVxOqkEGPrLOLsekx2ZzrmQWGcTTl3WO2EHUn3rzeaSat2Mtn6Ap0MW
         PN9G1OG1qNgmOGKg/F8xw/4arI+jL/Z297yAkojpLdZMNgzLNW/mSy39wRXItvJV68HN
         2K52LoqUYS86w8f+jhuoMPj/t0NJ9DG3MRIP5s8UuqADAfKIIjANsFmk9wQSshBZwP2T
         J1IrbfBjSBwyJmLE2iZmnl6RtoOuozqNYxbK0dDPilIt7d6vMexQ2r839JMOCEndbupV
         +Ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781302389; x=1781907189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pRMEwmh6f+KZ0VDSdIOWnsZ8bN+t3OAhBwecQVSCEK8=;
        b=gsrtOI65+GV5A3aOYO1E5Az+Yjp+hrf3VzciFyUw2/zhBolGzYq+jMiKCtu9FPAMZs
         ncCwtwKHsmwN8puQvidmpeyDldnGYtM7eDDpWn4hPFh8awIGfQWEQm9Cg6FKK2gcjbla
         sQx00LlCZq8agRzNYOSf7MPdlPPKhrsTOqn+gpyy0qf8ORR0pDoEelg/47bcwKhD5Ww0
         r2QJCnLtelgiCWVnekgHCiJX54em8pm24CJpsR8nLI2PynkRBC3LPMGPeISDc9itykq5
         PiUmSB4oBYMpD/B+snZwt2XSkqTlvG53AC7vFSzp9GT1z6noEvP1B5yLl8dj8sN4LY3y
         KhKA==
X-Forwarded-Encrypted: i=1; AFNElJ842PpUQraMhmQrUchNDFCCV0gjH5Hk/tRlGsSrhQfe9Q8gRwzCXZiN7t6Y9ENtdYKeOD0I8244CTFh7Mx+o/em@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc+VEo1UvuQGdkRATTnHyKYyO6FDXIKpOH4ScvH6P3hoIryNh3
	CxDKtv9AqMgPEH7IMsznQijIyvuNDP5sRVn4piFTh7Gx/FzJQP9dP5kAh+j9EnnuDxB49RQWbQu
	Vx34q3RPTXA==
X-Received: from dybpi5.prod.google.com ([2002:a05:7301:4205:b0:304:ebf6:da3b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:1344:b0:304:e7c9:b528
 with SMTP id 5a478bee46e88-308200d33aemr2507722eec.30.1781302388898; Fri, 12
 Jun 2026 15:13:08 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:12:09 -0700
In-Reply-To: <20260612221211.1221305-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612180956.1105352-1-irogers@google.com> <20260612221211.1221305-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612221211.1221305-18-irogers@google.com>
Subject: [PATCH v15 17/19] perf python: Add config file access
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
index bedd2175065d..71af65b23eb9 100644
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
@@ -3974,7 +3975,26 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwar
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

