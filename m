Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2531E255E27;
	Mon, 12 May 2025 06:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747031164; cv=none; b=PE7IBM5oQer/0axJVBFboQsExXqvqoYVzmjsCJGV+dIjLIZHXxK4Qp0ZFDQegA/DmqiS0VVLKKcW+K0Vmpv75E+8/ok4ldTQ4re93+Qn0rwhEg8gA8dFS9MeIf702AtTkhWJpQBBoujYRYlzbh2g4Ei8hjhVVpX2fBHIux89I1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747031164; c=relaxed/simple;
	bh=nlRYXIexSil3us+olEQ3l6qGg05Uil0ykxfctWceppM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdYmCd5VGEQQP3uUntq0rYkqBKeMkPwYGmh+p4gnUbyfmXBku3KFi5/Cq4l55Y5ku6yoN9tpThQQt2hx1eJSX6WFOS75RGH11DNfrpcAQ9UZg8Uq9C/EOsm5upRnwYmO8mjfYE6enjX3dNRfTZjHaNf6ongDkKxSFWp1PCfoTiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H3nbeFz9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H3nbeFz9"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C5Yck2020732;
	Mon, 12 May 2025 06:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QaB/di9rrLscjRxGn
	wPR1rtyS/LNU0MvgHfPxjHAv8k=; b=H3nbeFz9zSNATPqezN4w4F1VdenMGJITf
	SmfVuY54QqArT1ADKouKdl/kzBkYgVeiVrN9MQ2Oy1+ojaEadTnSqVDbNiJRsNHb
	zI+KgAs4C6MejODxo0ho5M200vHBQH23sV2W+bC60sLPVhrhTNQvTGeK9pzbPB0c
	sNEDe7RzHuHgAGyTAH3xFR43m1hWAmTvMZN2y3HtMZF7jVOt5n/awo+vKfSlVWZA
	2ywhH7Wuy5VfqsIw25uvdV+jC+VgmS2rhg4yK8iqMj03A+9RpqEE87H3hrN9wvuZ
	Vh/sNyNhgsjFQmP7iupnfnbzi9FwM0+vINr6cCiNArF4kB1ru2unQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46jrrg2x70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 06:25:50 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54C6E3HK020500;
	Mon, 12 May 2025 06:25:50 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46jrrg2x6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 06:25:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54C5Qa8d024452;
	Mon, 12 May 2025 06:25:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46jjmkvhmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 06:25:48 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54C6PiMA18481426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 06:25:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A01A9200E0;
	Mon, 12 May 2025 05:58:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6868200DB;
	Mon, 12 May 2025 05:58:00 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com.com (unknown [9.39.26.83])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 May 2025 05:58:00 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, maddy@linux.ibm.com
Subject: [PATCH v2 1/4] perf python: Add support for perf_counts_values to return counter data
Date: Mon, 12 May 2025 11:27:42 +0530
Message-ID: <20250512055748.479786-2-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512055748.479786-1-gautam@linux.ibm.com>
References: <20250512055748.479786-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OdvryHYZxMvEJvvOqMQRrmMZSZixWgrZ
X-Proofpoint-GUID: qyzWuJFvalwHTBIqls_s8k5CP8rhA0jP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA2MyBTYWx0ZWRfX31N19L8sXwEy EDEbddAgM5/TbC3xdSLZGr0T9xiY2uamD2Z0G3nybGnxjVeuAPi0OT28TUuKHLtxpeK8cymkmZn 6fOki1JdkUfKF3i10TkgUSIhjJqECepdBhkGiEK47loTW6vMEjPmGw7nkl7xDAjKYam7YLCgTUW
 sgWqmQVcfK/7eHHb2Xl8hu8luN8PtSux5XViZce+Evb+d8XmA9C4zdiRQSCpkcuCZMllkTrOabc I8vCUfrT86EDibzOtyZ2mShlYzqHAAQXBfJn7/DPWCgTP+vPslrrGdx3f2UkKap0q9HDZRfpwnV Mru72YoKrcjIpSqpbLunzjE3P+Wd8XgXW/CaPZFdWIisSw2HY9F/4zaDDWNH5Fa6+5YHrm/l/2v
 ZeMf0/eKLxY73iIr3nG7v4iv/poDBimN4YUklwwbixuZxqz+6aeXmFQHlV9fzkam+PYbDNdZ
X-Authority-Analysis: v=2.4 cv=KPFaDEFo c=1 sm=1 tr=0 ts=6821946e cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=8VWMH8aeIS0OOwB8Z8wA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_02,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120063

Add support for perf_counts_values struct to enable the python
bindings to read and return the counter data.

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

