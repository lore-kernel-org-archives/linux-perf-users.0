Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252AF2550B0;
	Mon, 12 May 2025 06:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747031163; cv=none; b=AosziWWlBxIi7Ffnx5NbYT42WaednGYiYprfhk3L0Cye37OE2hAsiDpOirNjijSs564gw4nkCDLqnZeW9BN+RYj3z9Ex9FzKf//RGicNCl6yTflhmwsPqbwvnnRplBLiFvfDluCxRbs4KO7kYuQ9qbq4QbyutAvDPc/wszrbXLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747031163; c=relaxed/simple;
	bh=LsHWjL3dhLS8P7Kp2RQe6VT/RbytAXbMkV8qltSsWl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9lcv5nHFL+Ix0VyQSecX+LJu6Tdnuq6wAQ2zZO6414oJ5BokGBns6lsYMmsu0SUWqgPEMXwUKbFco1v0dx8XBu55HcQB9xuLbA+HVA3KygshE+Zp+CEypvB2x/4RGLwxeduAsHc8/lLtldTmWcsyCArQiG9cBYNMQ9P2ItjgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X6j/SIaa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X6j/SIaa"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C6IO5q024022;
	Mon, 12 May 2025 06:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rBFxPBHNN9y0PykhA
	/DyCxQtW3JUngmmlhWQS9WGBTs=; b=X6j/SIaa5vzCqP8iV+ShpNr9aI2mcR4FG
	LZYt2ZjfA0fTdMboj08hAvYFV11WjY/5E6V59PS4QosX8ntON5L4MyoMJ7KmhW7T
	4Qjzg0PV4Vq0d5cQczpl7Nj50kC5709Df8I83kDcrsmh9mCRIUkXyP+r4+XIEfJb
	EiOcXoA1FHiniGPHXv3nHxmt+gKXDgKlD9jtG6RfvFrWb10pPqH9H1/lvopUVSxR
	jJX6NTZivCfWWK4GzOgCWyFHzKaR7Z0nOdV7EO+T18j3quLSRnm6W/gmHuixPDsM
	Weu+APH87GzEUHJIrWSnKNPzTfiXCfeXVAwWYBOXqt/TtcNlqvqeA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kbksr0qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 06:25:50 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54C6LEsG028874;
	Mon, 12 May 2025 06:25:50 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kbksr0q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 06:25:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54C53rhs025907;
	Mon, 12 May 2025 06:25:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46jj4nmmwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 06:25:48 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54C6Pic124576636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 06:25:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAD9A200E4;
	Mon, 12 May 2025 05:58:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1FD5200E1;
	Mon, 12 May 2025 05:58:07 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com.com (unknown [9.39.26.83])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 May 2025 05:58:07 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, maddy@linux.ibm.com
Subject: [PATCH v2 2/4] perf python: Add evsel read method
Date: Mon, 12 May 2025 11:27:43 +0530
Message-ID: <20250512055748.479786-3-gautam@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=DrhW+H/+ c=1 sm=1 tr=0 ts=6821946e cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=mz77sXPBJAlW4eiyuogA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA1OCBTYWx0ZWRfX6p8e814XSwUi t7zp7Iuw5QMAk8EhadSi1vRUufAILgk2uKvJAEoZ8o+bJuRtgyeaKtYAOTiSzDF+tbIono72xVr 3nY95pQVziV6ncQR9s6W+1IvzE6jcHDsH+LMk127bcw3KhWUbds8A3z6DvIEJudlvJksxha1Dr6
 O5kz18hK0X6cHUAEIc2lPyafxUVif/ApBLVTOfFFAGMVGlellV6NNyQ64rXv38IP1D3wEGdFVnT 4R0w4zX0/xuWi37KAQRHGILuTemsb3oJ2Wozczuh32YUKX30gFSXlISu2VXLc7Ya9xpcoZJBevE UfsqfT171hp+C+yH7c9vGnc6YruIgnG41fZNcsqE2NEdyRIjOE0l04ze5hI9EXwt8Gh5YanaA84
 9ZgQhNFzdF43XUsV2Y+elrUPkKFq7coadITy5BqD4DwBLQJVsqhl5bklF9GbIRU3bCtq1II3
X-Proofpoint-GUID: 5rFZEyDEEVJRJo-TUqeifVqpMYGbdKpx
X-Proofpoint-ORIG-GUID: 2-HgqgO-fFsB4DV7URKYUauuhJ7g-raQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_02,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120058

Add the evsel read method to enable python to read counter data for the
given evsel.

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

