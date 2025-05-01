Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7011F4199;
	Thu,  1 May 2025 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746092235; cv=none; b=EVdQRyNVCoSjeH5L7nrfc+XggPwWX2oHlDHtChmAA0wjpHh9NDqEEbYHUjsMw+S5ziKR22hdW4S2a7e2MwH8g8Hk08cJTiyn2WCXxsyQEw9M2AxwSbhWEqVmmLS/4voC7cnWK2kYhfpwYm68DK8O6ugdpSEov7gwnUe3EaMFJks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746092235; c=relaxed/simple;
	bh=w+9HjyX3jPytKMeWfq0Zv6KPNKkcA/I3EyFlCmydQcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hy5Cp1wPwijucWLCVx5Bq/JpOSXGKUGARUGcMZeuJdL53NXv+GcMdv4CG68N7S6/5LLwrD2eIk9tmVekmHAOWoY6t2gl0zdZYH/pcghCIXuiO4I5ogVhx1grv8GeEJF0ZIocE3t4XWpKVcd0f3Suszm4ZTkMo5SaYfXzImw5s6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TyuCINKD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TyuCINKD"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ULggQp011435;
	Thu, 1 May 2025 09:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=G0uv3MPU+9SsFN0ap
	vvs3jxDMqDztLFz4hlXpCOMI2o=; b=TyuCINKDSu0CmfmrzlsjTL8JdVYAZs8m2
	2jYE6kbCvfQHet69McEfTSe3JRvvXMSMbXOIO2rdSQRK9b++uKuwvcn7dinXVx5f
	BBJEnFEqU5qD1FlKzFsJMxpeIt9/zk9KuQnWps3KqjPK+93pkKhnj3hlK01bN+yt
	EkV0e7C527BqFjSJv39fxz8m2OmB022/Rz/MiFYGd599TrLrYAD5+CapoxP1zAmT
	/BaB4gBSGMzZBidvK7EzzmzCnxf5h0CpM9q4AgocmOpXPEq6c9Dd492msu+xOjZL
	TElkEcW5xuxxyNDG1GVGgP1RmnJGfWJc56wEK2gGcNF6Q0a5Uhh4w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46bv0vt5mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 09:36:59 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5419awpR024834;
	Thu, 1 May 2025 09:36:59 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46bv0vt5mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 09:36:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5418nqtc031665;
	Thu, 1 May 2025 09:36:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4699tucc4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 09:36:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5419asMU18743792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 May 2025 09:36:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BA842004B;
	Thu,  1 May 2025 09:36:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E080F20040;
	Thu,  1 May 2025 09:36:50 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com.com (unknown [9.124.221.47])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 May 2025 09:36:50 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, maddy@linux.ibm.com
Subject: [PATCH 1/4] perf python: Add support for perf_counts_values to return counter data
Date: Thu,  1 May 2025 15:06:27 +0530
Message-ID: <20250501093633.578010-2-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250501093633.578010-1-gautam@linux.ibm.com>
References: <20250501093633.578010-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LJlmQIW9 c=1 sm=1 tr=0 ts=681340bb cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=8VWMH8aeIS0OOwB8Z8wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDA3MiBTYWx0ZWRfX5PeIBK9KqqB5 IjYoJfuj3RJcj/XY2otskDMMED4YTgVL9evfgodi9pmQq12JcSDAF1peEuaE6ZAEa1vd2aC1v3h P6IY/64N6D4SxU6y55NJGXk3uWqay8WP/laFdT6KYH/ay17I7etnanyuJKCNx2/or/CrjSGESaq
 rVwF5ZYD3WygyFM6PUhouYsGjeyr23314ll5uHOUYcWF0XOlWmFA0af4HZKZK83oQYiupQ95d3q RDtezXD3M3uefDpvRr/dIrgbWRzFg7fEQYE5wdVxO6v69UpOufKMn8c+xn8FYzSi/ETuPIBgwWo jNaMQS+Umq+BX7zO+lcbxwEqlX86HUztWeN1h0KGF2yhLM53SWim58BbdlslupyDwpc4Bc0185V
 FmTcLPoZstIe8wne5g64ZmyKAkLkjzssFC7wbdEkfrIwTowUZKLkUredTkkj2KS1mJwLQKi3
X-Proofpoint-ORIG-GUID: -_FF04ZLKwMEccwEQ0emCbQDJXfXrrcp
X-Proofpoint-GUID: hWvZSAkf00Bp70cZzY-quS6vtMt-yiQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1015 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505010072

Add bindings for perf_counts_values struct to enable the python scripts
to read the counter data for an event.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 tools/perf/util/python.c | 92 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index f3c05da25b4a..011ee2e27797 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -626,6 +626,92 @@ static int pyrf_thread_map__setup_types(void)
 	return PyType_Ready(&pyrf_thread_map__type);
 }
 
+struct pyrf_counts_values {
+	PyObject_HEAD
+
+	struct perf_counts_values values;
+};
+
+static const char pyrf_counts_values__doc[] = PyDoc_STR("perf counts values object.");
+
+static void pyrf_counts_values__delete(struct pyrf_counts_values *pcounts_values)
+{
+	Py_TYPE(pcounts_values)->tp_free((PyObject *)pcounts_values);
+}
+
+#define counts_values_member_def(member, ptype, help) \
+	{ #member, ptype, \
+	  offsetof(struct pyrf_counts_values, values.member), \
+	  0, help }
+
+static PyMemberDef pyrf_counts_values_members[] = {
+	counts_values_member_def(val, Py_T_ULONG, "Value of event"),
+	counts_values_member_def(ena, Py_T_ULONG, "Time for which enabled"),
+	counts_values_member_def(run, Py_T_ULONG, "Time for which running"),
+	counts_values_member_def(id, Py_T_ULONG, "Unique ID for an event"),
+	counts_values_member_def(lost, Py_T_ULONG, "Num of lost samples"),
+	{NULL}
+};
+
+static PyObject *pyrf_counts_values_get_values(struct pyrf_counts_values *self, void *closure)
+{
+	PyObject *vals = PyList_New(5);
+
+	if (!vals)
+		return NULL;
+	for (int i = 0; i < 5; i++)
+		PyList_SetItem(vals, i, PyLong_FromLong(self->values.values[i]));
+
+	return vals;
+}
+
+static int pyrf_counts_values_set_values(struct pyrf_counts_values *self, PyObject *list,
+					 void *closure)
+{
+	Py_ssize_t size;
+	PyObject *item = NULL;
+
+	if (!PyList_Check(list)) {
+		PyErr_SetString(PyExc_TypeError, "Value assigned must be a list");
+		return -1;
+	}
+
+	size = PyList_Size(list);
+	for (Py_ssize_t i = 0; i < size; i++) {
+		item = PyList_GetItem(list, i);
+		if (!PyLong_Check(item)) {
+			PyErr_SetString(PyExc_TypeError, "List members should be numbers");
+			return -1;
+		}
+		self->values.values[i] = PyLong_AsLong(item);
+	}
+
+	return 0;
+}
+
+static PyGetSetDef pyrf_counts_values_getset[] = {
+	{"values", (getter)pyrf_counts_values_get_values, (setter)pyrf_counts_values_set_values,
+		"Name field", NULL},
+	{NULL}
+};
+
+static PyTypeObject pyrf_counts_values__type = {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name	= "perf.counts_values",
+	.tp_basicsize	= sizeof(struct pyrf_counts_values),
+	.tp_dealloc	= (destructor)pyrf_counts_values__delete,
+	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
+	.tp_doc		= pyrf_counts_values__doc,
+	.tp_members	= pyrf_counts_values_members,
+	.tp_getset	= pyrf_counts_values_getset,
+};
+
+static int pyrf_counts_values__setup_types(void)
+{
+	pyrf_counts_values__type.tp_new = PyType_GenericNew;
+	return PyType_Ready(&pyrf_counts_values__type);
+}
+
 struct pyrf_evsel {
 	PyObject_HEAD
 
@@ -1442,7 +1528,8 @@ PyMODINIT_FUNC PyInit_perf(void)
 	    pyrf_evlist__setup_types() < 0 ||
 	    pyrf_evsel__setup_types() < 0 ||
 	    pyrf_thread_map__setup_types() < 0 ||
-	    pyrf_cpu_map__setup_types() < 0)
+	    pyrf_cpu_map__setup_types() < 0 ||
+	    pyrf_counts_values__setup_types() < 0)
 		return module;
 
 	/* The page_size is placed in util object. */
@@ -1487,6 +1574,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_cpu_map__type);
 	PyModule_AddObject(module, "cpu_map", (PyObject*)&pyrf_cpu_map__type);
 
+	Py_INCREF(&pyrf_counts_values__type);
+	PyModule_AddObject(module, "counts_values", (PyObject *)&pyrf_counts_values__type);
+
 	dict = PyModule_GetDict(module);
 	if (dict == NULL)
 		goto error;
-- 
2.49.0

