Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE86E64A8F;
	Mon, 28 Jul 2025 06:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682426; cv=none; b=fLQk3DGTsTt6vJMZRDALSbFvCZCFJTk04BFUtI5AN6q8+Q0TcRBd1uknXXdq3DIktyQGl9/AiD2kpi4tq3qI62lFz9cR4LzRCzuFCCd3B6wTk9aBJxI7pLWduXBDfoaO+Njcfv+SWkgCqSupW+sXgj2bT31zzyLah7jdyaNO+Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682426; c=relaxed/simple;
	bh=vTmlu+c7Zoz2xMIdAcpul6HT5IPGBfnHlNr4WyYp5Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kab7QeH5n1NJg9fgMHBBaGJpnNNT/vtHC5T8g27cMc0XlTznhw1KBSi1EMH8dbHxdzlM86SkcljybZcQ8D+HCqY61zh0gACkCzLWv3wmEi6LNsonq2R5odH+TT9iQSDEmNabmDM+MW0WasuQTExmac7uLq/fxPqbGHkvY/aJkhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n8ioa6GT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n8ioa6GT"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RLGVDp002686;
	Mon, 28 Jul 2025 06:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FOh8XU1nn2zievokx
	Bo2RdnYJ7gCVX88ugqivTVtqLw=; b=n8ioa6GTDZ0rzbwmGAcRjfqGnB4Ha84Ep
	XxynFORuRaiIUbRM2ptJO65LDCxRpNIeAFXmoN9FBLJhkqoPWGNYAde7dnyiuwvv
	u6gFkcWqE+GvzBMkxFg23uwWJYPw9Bma/oklRmM5nWcZO4np88I4Lmyyl5SGcY6Y
	u8PQy0CxYKtfc63K/fWbxZBewLLlp2lOel5xmHcaJYx8hsHwOWYQ0Rhw4IjTOeXF
	w+R61i9dItIlCtwjiEXuw6QEC8+LXo8AMEd8+NCng8MND1ByoWJcmVpa9PqY1XiE
	DTBqwc7Rgc4/19JencnsiCYHUAo6EDTpcaLiD5bR9FY0xmZWA5w8w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qaty8q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 06:00:07 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56S5pt53014355;
	Mon, 28 Jul 2025 06:00:06 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qaty8pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 06:00:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56S5dXg2018312;
	Mon, 28 Jul 2025 06:00:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 485abnve6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 06:00:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56S6013r48365930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 06:00:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 398D620043;
	Mon, 28 Jul 2025 06:00:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EFAE20040;
	Mon, 28 Jul 2025 05:59:57 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com.com (unknown [9.124.209.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Jul 2025 05:59:57 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf python: Add support for record_opts struct
Date: Mon, 28 Jul 2025 11:29:27 +0530
Message-ID: <20250728055937.58531-2-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250728055937.58531-1-gautam@linux.ibm.com>
References: <20250728055937.58531-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Xvz6OUF9 c=1 sm=1 tr=0 ts=688711e7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=xbiQ1PCPNy82S5ANkocA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA0MiBTYWx0ZWRfXwn/i6VS1UF17
 rXHsgnK4Tz1mYT2wR2CaDa+fVhVumjtAWk4q04ZSA+zWDpo2YMqJNMoy4OTKMS5u8zlZBB6ETLs
 S4+ec4n8LF20jRSRX6jhbjK4N/5Xcm0qFtaTMF6OwXt3grIsBmhTtE9KjLReOp91FaQ8dsxNOy2
 jOn8qN+K1VcOGHyy6i1HxlwZS0a43z94iJgBLjljEur1Y+PfI4ZubZ4nUNHQXDJ/5cTammvtMNT
 7D08WoM4uPUCQhwMEOjEABK8Htl6vwlbBHai1rjIMY4QGUw6Jbf3EqoyC6SBRvhnvGcgBtk6e4Z
 pwxqTavIvIY5R8BiQQujUyJUFrZ5ERQwhuGp2fYalMvgsct8sgYH6GrFjsG5+MFKF3ewHvYDl1g
 pjKMu+3zlqDFP+Flts8qmO0mgZ8qGwea9KLYqv6jlXSsQc5qZWXSBKtTg39n2dIQmPICImUf
X-Proofpoint-GUID: Gk5b-BKSbOFE72l_ebJuIvE0VgTmgRRt
X-Proofpoint-ORIG-GUID: WJn9SsajVC8DO_yaIyfOCKBVgvcyIZNC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280042

Add support for record_opts struct to allow python to control the
initialization of the evsels instead of using the current default
options.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 tools/perf/util/python.c | 186 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 183 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 2f28f71325a8..8537edbb3b0b 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1045,6 +1045,169 @@ static int pyrf_evsel__setup_types(void)
 	return PyType_Ready(&pyrf_evsel__type);
 }
 
+struct pyrf_target {
+	PyObject_HEAD
+
+	struct target target;
+};
+
+static int pyrf_target__init(struct pyrf_target *target,
+				PyObject *args, PyObject *kwargs)
+{
+	static char *kwlist[] = { "pid", "tid", "cpu_list", "bpf_str", "system_wide", "uses_mmap",
+				"default_per_cpu", "per_thread", "use_bpf", "inherit",
+				"initial_delay", "attr_map", NULL };
+
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|ssssppppppis",
+					 kwlist, &(target->target.pid), &(target->target.tid),
+					 &(target->target.cpu_list), &(target->target.bpf_str),
+					 &(target->target.system_wide),
+					 &(target->target.uses_mmap),
+					 &(target->target.default_per_cpu),
+					 &(target->target.per_thread), &(target->target.use_bpf),
+					 &(target->target.inherit), &(target->target.initial_delay),
+					 &(target->target.attr_map)))
+		return -1;
+
+	return 0;
+}
+
+static void pyrf_target__delete(struct pyrf_target *target)
+{
+	Py_TYPE(target)->tp_free((PyObject *)target);
+}
+
+static const char pyrf_target__doc[] = PyDoc_STR("target object.");
+
+static PyTypeObject pyrf_target__type = {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name	= "perf.target",
+	.tp_basicsize	= sizeof(struct pyrf_target),
+	.tp_dealloc	= (destructor)pyrf_target__delete,
+	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
+	.tp_doc		= pyrf_target__doc,
+	.tp_init	= (initproc)pyrf_target__init,
+};
+
+static int pyrf_target__setup_types(void)
+{
+	pyrf_target__type.tp_new = PyType_GenericNew;
+	return PyType_Ready(&pyrf_target__type);
+}
+
+struct pyrf_record_opts {
+	PyObject_HEAD
+
+	struct record_opts opts;
+};
+
+static int pyrf_record_opts__init(struct pyrf_record_opts *popts,
+				 PyObject *args, PyObject *kwargs)
+{
+	static char *kwlist[] = { "target", "inherit_stat", "no_buffering", "no_inherit",
+				"no_inherit_set", "no_samples", "raw_samples",
+				"sample_address", "sample_phys_addr", "sample_data_page_size",
+				"sample_code_page_size", "sample_weight", "sample_time",
+				"sample_time_set", "sample_cpu", "sample_identifier",
+				"sample_data_src", "period", "period_set", "running_time",
+				"full_auxtrace", "auxtrace_snapshot_mode",
+				"auxtrace_snapshot_on_exit", "auxtrace_sample_mode",
+				"record_namespaces", "record_cgroup", "record_switch_events",
+				"record_switch_events_set", "all_kernel", "all_user",
+				"kernel_callchains", "user_callchains", "tail_synthesize",
+				"overwrite", "ignore_missing_thread", "strict_freq", "sample_id",
+				"no_bpf_event", "kcore", "text_poke", "build_id", "freq",
+				"mmap_pages", "auxtrace_mmap_pages", "user_freq", "branch_stack",
+				"sample_intr_regs", "sample_user_regs", "default_interval",
+				"user_interval", "auxtrace_snapshot_size", "auxtrace_snapshot_opts",
+				"auxtrace_sample_opts", "sample_transaction", "use_clockid",
+				"clockid", "clockid_res_ns", "nr_cblocks", "affinity", "mmap_flush",
+				"comp_level", "nr_threads_synthesize", "ctl_fd", "ctl_fd_ack",
+				"ctl_fd_close", "synth", "threads_spec", "threads_user_spec",
+				"off_cpu_thresh_ns",  NULL };
+
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs,
+					"|OppppppppppppppppppppppppppppppppppppppppIIIIIIIIIIssppiIiiiIIiipiisI",
+					 kwlist, &(popts->opts.target), &(popts->opts.inherit_stat),
+					 &(popts->opts.no_buffering), &(popts->opts.no_inherit),
+					 &(popts->opts.no_inherit_set), &(popts->opts.no_samples),
+					 &(popts->opts.raw_samples), &(popts->opts.sample_address),
+					 &(popts->opts.sample_phys_addr),
+					 &(popts->opts.sample_data_page_size),
+					 &(popts->opts.sample_code_page_size),
+					 &(popts->opts.sample_weight),
+					 &(popts->opts.sample_time), &(popts->opts.sample_time_set),
+					 &(popts->opts.sample_cpu),
+					 &(popts->opts.sample_identifier),
+					 &(popts->opts.sample_data_src), &(popts->opts.period),
+					 &(popts->opts.period_set), &(popts->opts.running_time),
+					 &(popts->opts.full_auxtrace),
+					 &(popts->opts.auxtrace_snapshot_mode),
+					 &(popts->opts.auxtrace_snapshot_on_exit),
+					 &(popts->opts.auxtrace_sample_mode),
+					 &(popts->opts.record_namespaces),
+					 &(popts->opts.record_cgroup),
+					 &(popts->opts.record_switch_events),
+					 &(popts->opts.record_switch_events_set),
+					 &(popts->opts.all_kernel), &(popts->opts.all_user),
+					 &(popts->opts.kernel_callchains),
+					 &(popts->opts.user_callchains),
+					 &(popts->opts.tail_synthesize),
+					 &(popts->opts.overwrite),
+					 &(popts->opts.ignore_missing_thread),
+					 &(popts->opts.strict_freq), &(popts->opts.sample_id),
+					 &(popts->opts.no_bpf_event), &(popts->opts.kcore),
+					 &(popts->opts.text_poke), &(popts->opts.build_id),
+					 &(popts->opts.freq), &(popts->opts.mmap_pages),
+					 &(popts->opts.auxtrace_mmap_pages),
+					 &(popts->opts.user_freq),
+					 &(popts->opts.branch_stack),
+					 &(popts->opts.sample_intr_regs),
+					 &(popts->opts.sample_user_regs),
+					 &(popts->opts.default_interval),
+					 &(popts->opts.user_interval),
+					 &(popts->opts.auxtrace_snapshot_size),
+					 &(popts->opts.auxtrace_snapshot_opts),
+					 &(popts->opts.auxtrace_sample_opts),
+					 &(popts->opts.sample_transaction),
+					 &(popts->opts.use_clockid),
+					 &(popts->opts.clockid), &(popts->opts.clockid_res_ns),
+					 &(popts->opts.nr_cblocks), &(popts->opts.affinity),
+					 &(popts->opts.mmap_flush), &(popts->opts.comp_level),
+					 &(popts->opts.nr_threads_synthesize),
+					 &(popts->opts.ctl_fd),
+					 &(popts->opts.ctl_fd_ack), &(popts->opts.ctl_fd_close),
+					 &(popts->opts.synth), &(popts->opts.threads_spec),
+					 &(popts->opts.threads_user_spec),
+					 &(popts->opts.off_cpu_thresh_ns)))
+		return -1;
+
+	return 0;
+}
+
+static const char pyrf_record_opts__doc[] = PyDoc_STR("perf record_opts object.");
+
+static void pyrf_record_opts__delete(struct pyrf_record_opts *perf_record_opts)
+{
+	Py_TYPE(perf_record_opts)->tp_free((PyObject *)perf_record_opts);
+}
+
+static PyTypeObject pyrf_record_opts__type = {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name	= "perf.record_opts",
+	.tp_basicsize	= sizeof(struct pyrf_record_opts),
+	.tp_dealloc	= (destructor)pyrf_record_opts__delete,
+	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
+	.tp_doc		= pyrf_record_opts__doc,
+	.tp_init	= (initproc)pyrf_record_opts__init,
+};
+
+static int pyrf_record_opts__setup_types(void)
+{
+	pyrf_record_opts__type.tp_new = PyType_GenericNew;
+	return PyType_Ready(&pyrf_record_opts__type);
+}
+
 struct pyrf_evlist {
 	PyObject_HEAD
 
@@ -1263,7 +1426,7 @@ static PyObject *pyrf_evlist__close(struct pyrf_evlist *pevlist)
 	return Py_None;
 }
 
-static PyObject *pyrf_evlist__config(struct pyrf_evlist *pevlist)
+static PyObject *pyrf_evlist__config(struct pyrf_evlist *pevlist, PyObject *args, PyObject *kwargs)
 {
 	struct record_opts opts = {
 		.sample_time	     = true,
@@ -1281,8 +1444,17 @@ static PyObject *pyrf_evlist__config(struct pyrf_evlist *pevlist)
 		.no_buffering        = true,
 		.no_inherit          = true,
 	};
+	PyObject *popts = NULL;
+	static char *kwlist[] = { "record_opts", NULL };
 	struct evlist *evlist = &pevlist->evlist;
 
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|O", kwlist,
+					 &popts))
+		return NULL;
+
+	if (popts)
+		opts = ((struct pyrf_record_opts *) popts)->opts;
+
 	evlist__config(evlist, &opts, &callchain_param);
 	Py_INCREF(Py_None);
 	return Py_None;
@@ -1354,7 +1526,7 @@ static PyMethodDef pyrf_evlist__methods[] = {
 	{
 		.ml_name  = "config",
 		.ml_meth  = (PyCFunction)pyrf_evlist__config,
-		.ml_flags = METH_NOARGS,
+		.ml_flags = METH_VARARGS | METH_KEYWORDS,
 		.ml_doc	  = PyDoc_STR("Apply default record options to the evlist.")
 	},
 	{
@@ -1718,7 +1890,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	    pyrf_evsel__setup_types() < 0 ||
 	    pyrf_thread_map__setup_types() < 0 ||
 	    pyrf_cpu_map__setup_types() < 0 ||
-	    pyrf_counts_values__setup_types() < 0)
+	    pyrf_counts_values__setup_types() < 0 ||
+	    pyrf_target__setup_types() < 0 ||
+	    pyrf_record_opts__setup_types() < 0)
 		return module;
 
 	/* The page_size is placed in util object. */
@@ -1766,6 +1940,12 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_counts_values__type);
 	PyModule_AddObject(module, "counts_values", (PyObject *)&pyrf_counts_values__type);
 
+	Py_INCREF(&pyrf_target__type);
+	PyModule_AddObject(module, "target", (PyObject *)&pyrf_target__type);
+
+	Py_INCREF(&pyrf_record_opts__type);
+	PyModule_AddObject(module, "record_opts", (PyObject *)&pyrf_record_opts__type);
+
 	dict = PyModule_GetDict(module);
 	if (dict == NULL)
 		goto error;
-- 
2.49.0

