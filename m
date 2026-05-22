Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4AD3955CE
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487530; cv=none; b=S/kR9SknNgudoFQvBZXuniuaeBMipEyinxOMft6TIL09If3LgA5i0VNxRkJ6Su1/eNhx5poAFOzaAmnkZiRvOj7QdZzBoPuLwZr3ESUu4wm0dEps2+DcqFp1m4Bgn9YGVBws+EKCUaLcq22LkQugSoNoOVKFlksckuPc8dM0CfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487530; c=relaxed/simple;
	bh=c1ddBh53K2pNzpDiOqsVnlXKDiZX9MV3/Y0n9MFuxBM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vpnrm5Lwpf/IuoKbtiVOfiLV31l9oX3nvv/iX3Jz/N4o3mjzpnD8MCb1x77fQrybNifMM2G/io6jPWCZcwH8o4CKT56GlCld3eXz8d6X/P49aIMGgD7baESNhFSnmZoYhjkSku8OksVynNz2MBYvsujerHyG3wh4KQac2XHJhrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L3sAN04s; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3sAN04s"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-135f2aa4742so6169236c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779487528; x=1780092328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O/OkUfIECucUs4dgUQxXg6gu1NGDepTpokWupB8NdEw=;
        b=L3sAN04snxvHeago6Fs4lSWFENCtmvTi6dOe/JaiUAQa8GWmN5yPqIb7sSpv39zX/t
         ODBDmmSmBmDo9e0QOggVFOtc8vk3DklbPNftDGHdVx2tVUuvfEvKYT0W9umqRC0w8iqC
         xEiylote/AAMmewwfi8g1zFfq2Qp+vY1zenoM7x0MHMPj6Z6MH0wNu8Cnj2I2v6WoBlf
         JC2ELp6wWTsOgNBqeWn+118flQBb4chPfSjZtaWOH6oi0/6M2oKk0SRRuz3hw10mR3aG
         8Pwhpn0Kp+UdtrrLJev4bGf1J25rN3gsC8WGxTv6wSl5PDkuNvFVdnxKy8PkOo7HDzeo
         tXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487528; x=1780092328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/OkUfIECucUs4dgUQxXg6gu1NGDepTpokWupB8NdEw=;
        b=h1I9/2IWgSY596qcsbzT7b+r2FilLVC7e/uhCbXHtqkvyCj/X3ONBo4xLVzu5fA95D
         8igXZzaHEFabuzpSPtiqY+ofDE/FktFGHHxpd7etSRCl9Iqz3eVutmmlPk0f8C9f600X
         MZtYjiHNo6dX4CEhEH7aqjCilBDWe/3g/zZi52DKX9J/01h1ohz7LzhnkHGaNY/5o6P1
         39QChTp+9sedwjV0XBWCACgtjRAAlc424MSisyg+1FjuAsBl6hswaejt56LuLxo5sOMF
         UFuZ72WJghwRiaUDV5G+gR+Orqgg+N8XnVx7xjiJZCWBYmSFNHA5TcoSNs2wdOCbXKga
         Jcuw==
X-Forwarded-Encrypted: i=1; AFNElJ8Obs9zl1cLvMCxyuMatEHuxH5TRJoh+H7i7BnOQVZcOPyEL8N9HnYY+3grZZ+J21t8E1mzIajmI/XVb4lvYNIw@vger.kernel.org
X-Gm-Message-State: AOJu0YzEGwR4du9kzAxm6UN6Qg9zjek4n3leSVDHhwS3QcMkEKOZZxxo
	E9a3GnnqT+1lJc9jguQW9fEI+aq1MIUzX6Qym/bpSnQtOskiAzC88wiGKgIL0lAbSX4B/l4RkIO
	e0lzlMN8ZCA==
X-Received: from dleb20-n1.prod.google.com ([2002:a05:701b:4254:10b0:12d:bbdf:edcb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:41aa:b0:132:956b:3a3
 with SMTP id a92af1059eb24-1365f70a0bemr1819078c88.10.1779487528034; Fri, 22
 May 2026 15:05:28 -0700 (PDT)
Date: Fri, 22 May 2026 15:04:32 -0700
In-Reply-To: <20260522220435.2378363-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428071903.1886173-1-irogers@google.com> <20260522220435.2378363-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522220435.2378363-22-irogers@google.com>
Subject: [PATCH v9 21/23] perf python: Add config file access
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add perf.config_get(name) to expose the perf configuration system.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 23eb65adb392..458aca9db091 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -14,6 +14,7 @@
 #include "build-id.h"
 #include "callchain.h"
 #include "comm.h"
+#include "config.h"
 #include "counts.h"
 #include "data.h"
 #include "debug.h"
@@ -3828,7 +3829,26 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwar
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
2.54.0.794.g4f17f83d09-goog

