Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610FE2F2F;
	Mon, 12 May 2025 06:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747031162; cv=none; b=mDy2KqomkIqi9ICadkUIs+2TlTxnNcyHUsJEIcc0T9rG8kmVPvrIBf+zVbywytDolhYZw01qWocJAp5B1+QnRVeecsupk2zGoeSaXchlOB5nNSD6ihdqBEDhmkUEj6yzC/ooYtDq290MUZ9V7S1xcGZmCkvVVGEWotNMOhFCafI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747031162; c=relaxed/simple;
	bh=eEy0DyOijfkBlZtvhUrSR3+1j97AsNz0adZvsul3wzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jo+k3jRbaaUlJx9UFpGMXMKmbocHFVnsjguY9aXQHw4OHAESZKwYDVpKRih89ud9VvApec7ufoxtdz/b81UMGgICZAYFlfAoPJywM7SoiVCJy6W0MvF3Ss2/08O/6NlSOm2Z69q5y+QHis0LuAiZ0kluGUSPcBV8vUd1AxLcjWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nVhPc9Hq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nVhPc9Hq"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BIoXY9017202;
	Mon, 12 May 2025 06:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Fo9x9GIYwNtfy8bv4
	SH/aH2Q7qUDW74lxxra06E1C5o=; b=nVhPc9HqiGjMS+gnrxS5ZZkKTHpxv8p/F
	FC7J6GynaT4TqCxJV1FXYpqo57eFsAetk8ZOZUpJZsunJwjWLdWR5Lqf2v752XTE
	F9mgIOeE7fBisrnNDcVDRWGPaAXPbDeLuGjCgsPIhIXN7yJYmamZ+Wzmye6wdGJQ
	m56P1ZAHomIlQX7xnF3+qllkc6TZTOwE+UmJaCltId33ae1IVjN6663qncedmmi6
	D5p5P0M4oyrkDQZwnVR21uEmZigjg503fiuwCEJ5kSW/n+Y+v//5JlHZrtPhL223
	fhTgZEZDTcWNOZKzCIY6u4p2lcYMcCFaMBVFQNkTf37kYadVkq5Zg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46k1h89q60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 06:25:50 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54C6Pn7W028789;
	Mon, 12 May 2025 06:25:49 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46k1h89q5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 06:25:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54C1YHfh011558;
	Mon, 12 May 2025 06:25:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46jku24b6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 06:25:48 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54C6Pj9E18809158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 06:25:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A6BF200E6;
	Mon, 12 May 2025 05:58:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6FF6200E5;
	Mon, 12 May 2025 05:58:14 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com.com (unknown [9.39.26.83])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 May 2025 05:58:14 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, maddy@linux.ibm.com
Subject: [PATCH v2 3/4] perf python: Add evlist close support
Date: Mon, 12 May 2025 11:27:44 +0530
Message-ID: <20250512055748.479786-4-gautam@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=fq3cZE4f c=1 sm=1 tr=0 ts=6821946e cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=1CJVNnU1sNpl53wobBcA:9
X-Proofpoint-GUID: j_o3YpM6a6Be1f6yQYOIMWhF6Nk9N2ax
X-Proofpoint-ORIG-GUID: OPG7qsXSdOwPGr29uMKjayEIHq7cZ1_p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA2MyBTYWx0ZWRfX8DlSFnLAfSvj SCChPyEGwiygUD16lC/z/XxtfylU4JAD7a8kRKgLBxfMtirkoBq36y9Vu5U1ZCWA46QoChqqwcY mjeQIw1hb+YfdjdTGkYtROfuZr/g8kRwah0Tz1dF1osY8He3ogR2OLsnMaRsICJrpIit3u19/zR
 8lzbumGpXjc8JPyXC2FBAQ+K2g515ncALGmxJsT45CjnfK909fSf3Y/ljHqy/vzWLHLDye6vjLT y3tpIwqjdJfspU7yH+rEmI6w943/NVZNKZNcLThZjEva4VY6JpUMH5DkWCi7BDIzBD5wKj4G7pK Zl5nWsvCvR/vERWvhsRRE7fa8/UsMxAEdsSv10SD42FPyM9XwWDEIV9ztBD5EwPvBK5YjISBjkD
 fSSgS6ImPyYI0vdkFtld4WYY5n2VmSMkwP9cn6jsRwdineYZZ2ersD50krcIZQ/jcgFl/+3y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_02,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120063

Add support for the evlist close function.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v1 -> v2:
1. Drop the support for next function

 tools/perf/util/python.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 5a4d2c9aaabd..245ad4a4257a 100644
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
@@ -1221,6 +1231,12 @@ static PyMethodDef pyrf_evlist__methods[] = {
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
-- 
2.49.0

