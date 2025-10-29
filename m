Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C962E304BDC
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 05:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716078; cv=none; b=lAaG7x8cI45F4ZEX0rAOsCH7PSDDCBnTgKrlRV0RmxKep4pJy9qzEkuZozD5GwUXVLxventozkIBN6A6egCziteIDfxPU4UrAp7XMm7Nq7L/OSLDVEm8sx6ZOzmKmC3R5qd3vvIBpYxDm1JHAUmlXqHJos7teJjT+fNfPnfbBl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716078; c=relaxed/simple;
	bh=pjgQBus0qG0hjaxrSH0uu3Qq9AJCdOwC0H/in0+OSb8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Z5hfD+KxeGbeZ0bEy0OEknLoq1v5mUrrfDvDkCp6gw+XqPSeW6fEOYRkBvn+Y1rbUgHikLhwL2vTxK0iD0AYOgYOhfRMvnRhZ2Co6Q9cu/dA3vEHz8HR4VBSQbMOpD/TEWPj6zPHL6/ismlcIa94CxoccpirGjE/jn0/FRYw5I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1PsGQEeF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1PsGQEeF"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-290d860acbcso143597545ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Oct 2025 22:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761716076; x=1762320876; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ltgvCiIYngiUZhvcaMFlzhWnCiNVZZ80aMVr+t5YAMI=;
        b=1PsGQEeFBx1BLrwqeQrZSQngy/LO/XTMmKPd+IPO1CvcJQC7ztxw1wZkY4p8hHsgz2
         lf20TxGe3VWwgc/NFPbvl41pwj1PmwCz+IDT16FUpARp4cwUtpJ1TIym2XdVrPvRFHg1
         ymfT2Kv3oKvPg5MsaesHaxrvTiK+wRdRPlqczZ1ViAZQIs4LnBxfOdttxdJjVgPX6u8f
         HhLoAGITyQ+gILWI8Y08frSTl9NlbvPgLQMtkpLdl5DWvU2pARfCTnLRcibEnk6xK/Lp
         rsOCYCOWzXx/OsOSvuzsYDGXrRLHlNXCtkOT80dlWzrgp5jp9KmnqFmhH3CJ4C/hSbX8
         yhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761716076; x=1762320876;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltgvCiIYngiUZhvcaMFlzhWnCiNVZZ80aMVr+t5YAMI=;
        b=HdkzU2MdxtZVrTlRn4pQ3lQ0SQcKubVXrI7PnAx/4vDQqNTdyZB3lxZFQPjZuBymV3
         bdfV5QeEzMToTWsYqdqPFyM5FWwB2ruP3ME4PiThBxetq3XaEGaAVHq9ETpbj4AdOWTu
         0uHJ9A0V1BROVP30QVCsXPv0okK/vyhvoXl/Wamh15E72eYghvdRWXjcjdSQrLZFyYp2
         /fUVTyq/hzFF5jD/jSyCreA4H9dNMJ7809dhRQhLDg3/WWVb7jgCrDfxH1XO2c2p6/6B
         Af6lMR13yEy7XH82lpvds82QOKla1sZoK89Ab53Fvz1+WNx+avcdtUsRA+YWMGOF/e0B
         wfXg==
X-Forwarded-Encrypted: i=1; AJvYcCXnNGdC2XiF4yZ1wtOkyIKtbntYXaEzpn4pVmFw+czJ/JPeyIBV+zn82Ci+EBtwxccczOcvv2txaZoh4ymnJmEh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2p+3nzaxxANUjr9FzGPVNea5+SPOdn3ixq/ZTqa0vO07bAD0Q
	TAarEZRmx3KyghHXf9f3MD8SAqjsWot8FtqwF3lLLe9hvLYtSL1emh8+e0XaK1VEF3rvGLqja7w
	999kk5VWxiQ==
X-Google-Smtp-Source: AGHT+IF+xxZSEDuibZ447qr1lEdxF5eqLdcI/dMQoFhe3SPYlME8LKCSsUdHdyZ3ziTAaX+mA+o9UpTdLIMj
X-Received: from pjca7.prod.google.com ([2002:a17:90b:5b87:b0:31f:b2f:aeed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e54e:b0:258:f033:3ff9
 with SMTP id d9443c01a7336-294deede339mr21502015ad.48.1761716075602; Tue, 28
 Oct 2025 22:34:35 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:34:08 -0700
In-Reply-To: <20251029053413.355154-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029053413.355154-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029053413.355154-11-irogers@google.com>
Subject: [RFC PATCH v1 10/15] perf python: Add wrapper for perf_data file abstraction
From: Ian Rogers <irogers@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Song Liu <song@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Blake Jones <blakejones@google.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

The perf_data struct is needed for session supported.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 62 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 0366142184d8..f96c1f6dca56 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -11,6 +11,7 @@
 #include <perf/mmap.h>
 #include "callchain.h"
 #include "counts.h"
+#include "data.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "event.h"
@@ -2163,6 +2164,61 @@ static PyObject *pyrf__metrics(PyObject *self, PyObject *args)
 	return list;
 }
 
+struct pyrf_data {
+	PyObject_HEAD
+
+	struct perf_data data;
+};
+
+static int pyrf_data__init(struct pyrf_data *pdata, PyObject *args, PyObject *kwargs)
+{
+	static char *kwlist[] = { "path", "fd", NULL };
+	char *path = NULL;
+	int fd = -1;
+
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|si", kwlist, &path, &fd))
+		return -1;
+
+	pdata->data.path = strdup(path);
+	pdata->data.mode = PERF_DATA_MODE_READ;
+	pdata->data.file.fd = fd;
+	return perf_data__open(&pdata->data) < 0 ? -1 : 0;
+}
+
+static void pyrf_data__delete(struct pyrf_data *pdata)
+{
+	perf_data__close(&pdata->data);
+	free((char *)pdata->data.path);
+	Py_TYPE(pdata)->tp_free((PyObject *)pdata);
+}
+
+static PyObject *pyrf_data__str(PyObject *self)
+{
+	const struct pyrf_data *pdata = (const struct pyrf_data *)self;
+
+	return PyUnicode_FromString(pdata->data.path);
+}
+
+static const char pyrf_data__doc[] = PyDoc_STR("perf data file object.");
+
+static PyTypeObject pyrf_data__type = {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name	= "perf.data",
+	.tp_basicsize	= sizeof(struct pyrf_data),
+	.tp_dealloc	= (destructor)pyrf_data__delete,
+	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
+	.tp_doc		= pyrf_data__doc,
+	.tp_init	= (initproc)pyrf_data__init,
+	.tp_repr	= pyrf_data__str,
+	.tp_str		= pyrf_data__str,
+};
+
+static int pyrf_data__setup_types(void)
+{
+	pyrf_data__type.tp_new = PyType_GenericNew;
+	return PyType_Ready(&pyrf_data__type);
+}
+
 static PyMethodDef perf__methods[] = {
 	{
 		.ml_name  = "metrics",
@@ -2225,7 +2281,8 @@ PyMODINIT_FUNC PyInit_perf(void)
 	    pyrf_cpu_map__setup_types() < 0 ||
 	    pyrf_pmu_iterator__setup_types() < 0 ||
 	    pyrf_pmu__setup_types() < 0 ||
-	    pyrf_counts_values__setup_types() < 0)
+	    pyrf_counts_values__setup_types() < 0 ||
+	    pyrf_data__setup_types() < 0)
 		return module;
 
 	/* The page_size is placed in util object. */
@@ -2273,6 +2330,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_counts_values__type);
 	PyModule_AddObject(module, "counts_values", (PyObject *)&pyrf_counts_values__type);
 
+	Py_INCREF(&pyrf_data__type);
+	PyModule_AddObject(module, "data", (PyObject *)&pyrf_data__type);
+
 	dict = PyModule_GetDict(module);
 	if (dict == NULL)
 		goto error;
-- 
2.51.1.851.g4ebd6896fd-goog

