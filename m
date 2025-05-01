Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172A225A623;
	Thu,  1 May 2025 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746092241; cv=none; b=JSamMCa578K519b1fA9LLPey+Alx6kbdOz6fGAbXmYXN7M2yaHyZ9CX1FHQBaJ7o5NJWDpD4VpPTiSSn4COUzFx/zfj34X2ZiH0YyWWOuSMPMtBIgbWzyNAESZD89aEEXl4GGTeZxHOCWAnEmrtwShnssiHSOzlD/IHbyRtk9oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746092241; c=relaxed/simple;
	bh=bbBhhl4DNZvNM0i/8eTCvJERerffvAeyCojBFgOwd1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0iKQHbyarx0NcAVf7JwsTWm/jP0tnfVvm8DhKWdueRWvu5RXQ6aoG0LkXPANzUkRj8SxWT1AicR6XGmnoYC7APaRkA1lBgL05G+yh8KJpdg7goCv8Y0jhzkOS5Q7bG8zJeloDyVC/H+/fo5QPaPnYS2cArd246B2FnTpsBhHf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GtiEwDTP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GtiEwDTP"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5416RHAr006425;
	Thu, 1 May 2025 09:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/zbH5yG2+qt9ridWK
	zgS1saNGmlvuCWVCOT2OJatMvA=; b=GtiEwDTPD6W0sMXCtmK0T68tLiZ2l1aO6
	IntIOZ1OZwcy2tZiRWKM9TjL8syvzwzLNJgns3IaRxttzfkBxsKF776teQaa+oq4
	WdmXgK1cTLd7L12sJy0dy0gbq30zTud4BCcjcsDUzFJM6fYJhASb19B2WuDiFPMK
	IgrNrcvycnh2M1uC7OJUNo/f+ZxSCyv9tvnFJilpoc73ek4xoNCZQAg6IM4mLvXH
	1eglRBJjgmuIb50puaiXGh3U4u6zTCbi27VA6JVmIISNATChR3iVsvdhkC969rJZ
	G6gxDpRsrORNWfsZrtiOCiAyqQKc81G7ozNbkvW+fwd4Dpx4l0PSw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46bhsjwh2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 09:37:08 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5419b7Z5008331;
	Thu, 1 May 2025 09:37:07 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46bhsjwh2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 09:37:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54161E2v001803;
	Thu, 1 May 2025 09:37:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469bamv4tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 09:37:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5419b27A33161596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 May 2025 09:37:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B5F120043;
	Thu,  1 May 2025 09:37:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 292EB20040;
	Thu,  1 May 2025 09:36:59 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com.com (unknown [9.124.221.47])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 May 2025 09:36:58 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, maddy@linux.ibm.com
Subject: [PATCH 2/4] perf python: Add evsel read method
Date: Thu,  1 May 2025 15:06:28 +0530
Message-ID: <20250501093633.578010-3-gautam@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=dcuA3WXe c=1 sm=1 tr=0 ts=681340c4 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=X_mIwdbuNq69S7QoM7cA:9
X-Proofpoint-GUID: h4ru7CCXZwuzE6Uftp_WzlM9p-KAp_cg
X-Proofpoint-ORIG-GUID: TpC0e04OfMIYWfWtF1xK0WcZ3AB4qi7A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDA3MiBTYWx0ZWRfX5vgj7UUC3geP DMVRSI7Hw6V5xZwH16Hct5UoRRDHsumgnU695E6988wfSjUnz2C5CXfCZobxOyXe9qml+tTOA4Y IvBZ1jh85vMO7J6UykpSIc9g6bzdh8N9lDd8ufnGss2XTu+NKtmJql51+4MDlujCQq3wCndSYFd
 fdTiV5qOOBigOAC7OflBJfzF6eDO45wVsiO+VlKcr7VRGCfz4JGuD1OGqcAg1D2POtQpad14tac Jh7nS0SRV6X4CXL2m1wED8rTSlrwSNmr3sBPdMGD8uwSVoXwUT7anvvYTPpwv1oK5mI6ntfXD3K x1GfEqjTSvvN4Y/jvM3LDc8GFrPJIlyA66e7+PRmwQgbRtNkuSrYR6+Qjwn+SaXSMyYbanf2PEl
 V3TspllsJCfaAfS2kQaHsOxptAKipJVzbdPvobkEfS4IyRNsR1N0Na5TvM4TOVhiG0F5H+wt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505010072

Add the evsel read method to enable reading counter data for the
given evsel from python.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 tools/perf/util/python.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 011ee2e27797..5a4d2c9aaabd 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -867,6 +867,23 @@ static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
 	return Py_None;
 }
 
+static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
+				  PyObject *args, PyObject *kwargs)
+{
+	struct evsel *evsel = &pevsel->evsel;
+	int cpu_map_idx = 0, thread = 0;
+	struct perf_counts_values counts;
+	struct pyrf_counts_values *count_values = PyObject_New(struct pyrf_counts_values,
+							       &pyrf_counts_values__type);
+
+	if (!PyArg_ParseTuple(args, "ii", &cpu_map_idx, &thread))
+		return NULL;
+
+	perf_evsel__read(&(evsel->core), cpu_map_idx, thread, &counts);
+	count_values->values = counts;
+	return (PyObject *)count_values;
+}
+
 static PyObject *pyrf_evsel__str(PyObject *self)
 {
 	struct pyrf_evsel *pevsel = (void *)self;
@@ -885,6 +902,12 @@ static PyMethodDef pyrf_evsel__methods[] = {
 		.ml_flags = METH_VARARGS | METH_KEYWORDS,
 		.ml_doc	  = PyDoc_STR("open the event selector file descriptor table.")
 	},
+	{
+		.ml_name  = "read",
+		.ml_meth  = (PyCFunction)pyrf_evsel__read,
+		.ml_flags = METH_VARARGS | METH_KEYWORDS,
+		.ml_doc	  = PyDoc_STR("read counters")
+	},
 	{ .ml_name = NULL, }
 };
 
-- 
2.49.0

