Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kxNBGHV1"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AE8D4C
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 01:40:17 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B49MZEa025617;
	Mon, 4 Dec 2023 09:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=L9h0/SRHWMizGKKq5wevWWTl4UztoVloWB6I1JZP2tE=;
 b=kxNBGHV1Z4k/QQvxT+XH58HjXgpG/ffYbyA8aaXSGlQ80r3oGtlt+HXSrc5apaZLlSIq
 ezsu5IqIKrYksfHtf73khOFQTa+Ifr6CYbi5Xj6+JWNevEuS/b9Gnv4CbrHMirqdLm4A
 XH1U3eVw+Sc7AaKajGunI7eZ4xHNVJEi9QHkUK15xFZuMq5OZmU4Wm8WTgLYXhwjO43P
 inKPaYs6Pc/P5b+GCq5QF9FA07GmGeDrLDA/yN5tF56v0JLwpcCbSbEzip0mBf1WpYvk
 1vHsoedVCbo0qeW44qZWGls4r9w7zr2wEPbkNa6dsyVLX1Skkq+LXZnL/dLSqccuPGPM XA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usc2urkna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 09:40:15 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B49MncN026067;
	Mon, 4 Dec 2023 09:40:15 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usc2urkmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 09:40:15 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B474UNL030384;
	Mon, 4 Dec 2023 09:40:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3urv8dm3ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 09:40:13 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B49eAu325625258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Dec 2023 09:40:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4B202004E;
	Mon,  4 Dec 2023 09:40:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 858E920043;
	Mon,  4 Dec 2023 09:40:08 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.171.12.32])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Dec 2023 09:40:08 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v8 3/4] perf tests task_analyzer: use perf check for libtraceevent support
Date: Mon,  4 Dec 2023 15:09:53 +0530
Message-ID: <20231204093954.304030-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204093954.304030-1-adityag@linux.ibm.com>
References: <20231204093954.304030-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dGHuiL_H3uwif40v4MudltD3cqmznsbV
X-Proofpoint-GUID: azxwJUWu5Vmun3joosQnZv5CjEgUJAtv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_06,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040072

Currently we use output of 'perf version --build-options', to check
whether perf was built with libtraceevent support.

Instead, use 'perf check --feature libtraceevent' to check for
libtraceevent support.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
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
2.42.0

