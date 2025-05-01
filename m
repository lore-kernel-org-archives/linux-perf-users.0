Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E996A22CBD5;
	Thu,  1 May 2025 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746092248; cv=none; b=V+2o3LmBoKthQhG0zSEkyZK3rmRtu8KXceV0v9Qvn7IfOWadNRG/basxvSoxNxZKKaMi3W5gdvI0jNDYR2X3+1giXGWPrPGgqkxbWwUUhqkm5Er8B/9wGrAmXSTqTuqk2rjQsoUxC/j+rC6E+RZV2l/he4ybt/eUp5yPd7n6M0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746092248; c=relaxed/simple;
	bh=oFt16kgUKdcj33X/bx1wFeNI8gWedSulniZ0udiW7pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CEN9Z7zsztgU1L/pV7/PuEe1ocENItNE7I+tmkLEffniz0qd22ho+8sB/IvrOJ8lKESw1D/V4/leUZhRog++oBMA7qiePZ8NRFUKig9m6onZcPAc9Ln4wsJ5TshZkvx/iFGhmqtAl686tCyupW34FmTOmt2rPuKB5mVKlVrC9Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eZn7dODM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eZn7dODM"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5414PmKH012575;
	Thu, 1 May 2025 09:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IQ5UwL7a/qlNX/AYu
	nSCEk7/ZRMUEI71r/DO7zPY7Fw=; b=eZn7dODM4+j0qf7f9tL01uHPuveugiAj5
	oVm6QX+D/37r55QcmwKmhgJhu2Kgdo39JsaUZ4Mbw8c3Rirs4gMx/z2cJOy3xHxq
	APmD1ogrbUXBxpyDUexot1suVcXnPklXmfZN1JzVFR2RGcTzuibpUZ21vz4RBdsC
	p5+7tKjuxm31YS68Q5UhDoYGSqha+mbisbxXnFthZaUPXbxgsWZmsGwzCqzmlZ2J
	EdhWctxljWtXMDuyOb2c3C69nNf7HnvSOo7w79K9QBye+AHnasj91pUZS4nDnnQ3
	Qtnj35aIgUQ+1Lwjy6vggBTSs4micdH7z1mlYnA13n8GCPitjFe1A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46bjas592m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 09:37:16 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5419bFLq001185;
	Thu, 1 May 2025 09:37:15 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46bjas592h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 09:37:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5418aUGg016584;
	Thu, 1 May 2025 09:37:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469a70mbre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 09:37:14 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5419bBN041091572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 May 2025 09:37:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AF2820043;
	Thu,  1 May 2025 09:37:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA08A20040;
	Thu,  1 May 2025 09:37:07 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com.com (unknown [9.124.221.47])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 May 2025 09:37:07 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, maddy@linux.ibm.com
Subject: [PATCH 3/4] perf python: Add evlist close and next methods
Date: Thu,  1 May 2025 15:06:29 +0530
Message-ID: <20250501093633.578010-4-gautam@linux.ibm.com>
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
X-Proofpoint-GUID: yyBUwlojeB4xEITTnv8pARp8CkFrYMXf
X-Proofpoint-ORIG-GUID: mTS9J_dvBiI8nrm5vqITQ2Qlb91nc3ds
X-Authority-Analysis: v=2.4 cv=LKNmQIW9 c=1 sm=1 tr=0 ts=681340cc cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=Mu-R3_ysuym7pKtYsCYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDA3MiBTYWx0ZWRfXwt7Ohp+kVF3k BQL4hf4trUWiAl4VTyzblWJiLP5p6DcbKhr+2orDlhu3XdFrCfxI7+QIavyS/yCb0+4X/+KNPZ+ JibQF14OG5WLLJrRKwTf1nKhYYAmYCGLva52A2ndYRxHKg4aVapHXYsbrPCC33NuTNGzm8UP+g0
 93CrNU60CLBgmzbK2sWD8CMBC+y5n7Z2CtzTF87wypWC3N70W9/u0Sysz/iksNevVuizjbMQRfE dP1mNsOOArRofAeZVpA7sRWLX1UWFh9pxopvG4/+rE+Tv32Ttig4V1lgjo+R06NL0f/WrDb2sWq 8ipiX4nsSQBpR1ezE71oJaFggfo43HtnOcb9Z3ScEFkTjBEGzgQXhpXM0OrsFX997gZtXEGiGrd
 uXFCHKR+ENs2NTwjaarQ/rHlyOAH4Q4Pfbp8qn/qoCJ92CaLrpcv/YLvZ8wy4xE1CiQKMWaZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=950 clxscore=1015
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505010072

Add support for the evlist close and next methods. The next method
enables iterating over the evsels in an evlist.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 tools/perf/util/python.c | 47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 5a4d2c9aaabd..599cb37600f1 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1163,6 +1163,16 @@ static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
 	return Py_None;
 }
 
+static PyObject *pyrf_evlist__close(struct pyrf_evlist *pevlist)
+{
+	struct evlist *evlist = &pevlist->evlist;
+
+	evlist__close(evlist);
+
+	Py_INCREF(Py_None);
+	return Py_None;
+}
+
 static PyObject *pyrf_evlist__config(struct pyrf_evlist *pevlist)
 {
 	struct record_opts opts = {
@@ -1202,6 +1212,31 @@ static PyObject *pyrf_evlist__enable(struct pyrf_evlist *pevlist)
 	return Py_None;
 }
 
+static PyObject *pyrf_evlist__next(struct pyrf_evlist *pevlist,
+				   PyObject *args, PyObject *kwargs)
+{
+	struct evlist *evlist = &pevlist->evlist;
+	PyObject *py_evsel;
+	struct perf_evsel *pevsel;
+	struct evsel *evsel;
+	struct pyrf_evsel *next_evsel = PyObject_New(struct pyrf_evsel, &pyrf_evsel__type);
+	static char *kwlist[] = { "evsel", NULL };
+
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O", kwlist,
+					 &py_evsel))
+		return NULL;
+
+	pevsel = (py_evsel == Py_None) ? NULL : &(((struct pyrf_evsel *)py_evsel)->evsel.core);
+	pevsel = perf_evlist__next(&(evlist->core), pevsel);
+	if (pevsel != NULL) {
+		evsel = container_of(pevsel, struct evsel, core);
+		next_evsel = container_of(evsel, struct pyrf_evsel, evsel);
+		return (PyObject *) next_evsel;
+	}
+
+	return Py_None;
+}
+
 static PyMethodDef pyrf_evlist__methods[] = {
 	{
 		.ml_name  = "all_cpus",
@@ -1221,6 +1256,12 @@ static PyMethodDef pyrf_evlist__methods[] = {
 		.ml_flags = METH_VARARGS | METH_KEYWORDS,
 		.ml_doc	  = PyDoc_STR("open the file descriptors.")
 	},
+	{
+		.ml_name  = "close",
+		.ml_meth  = (PyCFunction)pyrf_evlist__close,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR("close the file descriptors.")
+	},
 	{
 		.ml_name  = "poll",
 		.ml_meth  = (PyCFunction)pyrf_evlist__poll,
@@ -1263,6 +1304,12 @@ static PyMethodDef pyrf_evlist__methods[] = {
 		.ml_flags = METH_NOARGS,
 		.ml_doc	  = PyDoc_STR("Enable the evsels in the evlist.")
 	},
+	{
+		.ml_name  = "next",
+		.ml_meth  = (PyCFunction)pyrf_evlist__next,
+		.ml_flags = METH_VARARGS | METH_KEYWORDS,
+		.ml_doc	  = PyDoc_STR("Return next evsel")
+	},
 	{ .ml_name = NULL, }
 };
 
-- 
2.49.0

