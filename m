Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326AA15EAE
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Oct 2023 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="noIphKuS"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490D5106
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Oct 2023 08:05:47 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39LEqWpw030134;
	Sat, 21 Oct 2023 15:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vYfrgHdqckJ+sqkMR4/7p6r/dTHWv3jJcE6lggQXnIU=;
 b=noIphKuSQiqenP14EyyLHEPw6pJfthR+Fc3QF7xb7Zv1TSheeNuMz4tEyd30Xy2R/ryT
 WvJmZe9NeVcFjWMjAGm1edWxOUM/DlZJUmDfaSbpL1Hf/9g9uFCBEILMfYL69uqViuH/
 AdzlLC/IHmxtqJF4zDIm866lT6hv3PfG90YXCD6s6d2lQqHpkTvz/cxYtWeTWg4647yy
 ipE5n9v+7YN2nJ02fMH3vWtMlJiSUvtsEk4gFXQK9y0mypFFFZqYVz6+/E0X3pg+pfxQ
 bnNvevH/MMnVoNOuNZC+4rByEe1pN9s6hz/MujZZ3UO17BKZzGpFM8zERd0nK++CxMXY nA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvgsj87wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Oct 2023 15:05:43 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39LEslSZ002605;
	Sat, 21 Oct 2023 15:05:43 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvgsj87wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Oct 2023 15:05:43 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39LDH0oX019414;
	Sat, 21 Oct 2023 15:05:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tuc45bt7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Oct 2023 15:05:42 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39LF5daw10158670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Oct 2023 15:05:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31A1E20043;
	Sat, 21 Oct 2023 15:05:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F160320040;
	Sat, 21 Oct 2023 15:05:36 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.179.5.156])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Oct 2023 15:05:36 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v6 3/4] perf tests task_analyzer: use perf check for libtraceevent support
Date: Sat, 21 Oct 2023 20:35:25 +0530
Message-ID: <20231021150526.2231803-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231021150526.2231803-1-adityag@linux.ibm.com>
References: <20231021150526.2231803-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Uv4cMyKkr25CJsnRxaRBZM3fdfwSBmrr
X-Proofpoint-GUID: Q1WZaPGqYdlAwhI0M2l0iz_Z2wFhS4CS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-21_07,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310210138

Currently we use output of 'perf version --build-options', to check
whether perf was built with libtraceevent support.

Instead, use 'perf check --feature libtraceevent' to check for
libtraceevent support.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tools/perf/tests/shell/test_task_analyzer.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/tests/shell/test_task_analyzer.sh
index 92d15154ba79..f4db68edb2e3 100755
--- a/tools/perf/tests/shell/test_task_analyzer.sh
+++ b/tools/perf/tests/shell/test_task_analyzer.sh
@@ -52,8 +52,8 @@ find_str_or_fail() {
 
 # check if perf is compiled with libtraceevent support
 skip_no_probe_record_support() {
-	perf version --build-options | grep -q " OFF .* HAVE_LIBTRACEEVENT" && return 2
-	return 0
+	perf check -q --feature libtraceevent && return 0
+	return 2
 }
 
 prepare_perf_data() {
-- 
2.41.0

