Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pxVXimMb"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D95194
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Nov 2023 13:34:55 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGLWEeJ015407;
	Thu, 16 Nov 2023 21:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vYfrgHdqckJ+sqkMR4/7p6r/dTHWv3jJcE6lggQXnIU=;
 b=pxVXimMb9gg9FOYQ6BPMnptT9rsgS59XBIPblkT9AXFErzfIMM2I10ca+w5LsMtXX6eO
 rszSluIii7iLqimR/zBTBW36Lrw9AyI3X8z3UQinjyZe0XiCwMmhPO0jYyRp2QZywY50
 ZQVrlA/xgInRJ20KkwuRHfhNFvL1a6mvk1lzkvljwoRwk2jOBV+UkKUJxX67qkewjDmr
 ax/VFeME303Hmo4tuNhz1/oaiFJz3HAG7YF/KBVQF4CXQrJvug3xb1GkSjWfv42DjsZu
 rKd/IwycL4V3GoJ78br03NUfIBRrF0hBq+fFWn02iK07Sb23zH5c+SEdfNhBNjTVDtu7 Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udu3403h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 21:34:53 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AGLWL9Y015590;
	Thu, 16 Nov 2023 21:34:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udu3403g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 21:34:53 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGKjBNl030062;
	Thu, 16 Nov 2023 21:34:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uanem1cp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 21:34:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AGLYmKw16581286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 21:34:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7705720049;
	Thu, 16 Nov 2023 21:34:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2121420040;
	Thu, 16 Nov 2023 21:34:46 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.179.27.153])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Nov 2023 21:34:45 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v7 3/4] perf tests task_analyzer: use perf check for libtraceevent support
Date: Fri, 17 Nov 2023 03:04:34 +0530
Message-ID: <20231116213435.382484-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116213435.382484-1-adityag@linux.ibm.com>
References: <20231116213435.382484-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RCc5tqp1rhlrG4UQMBoeKdPVdhbbd-9-
X-Proofpoint-GUID: 4RMkKQZoD9Jm6tae5G5BbhFehbgl3Xeu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_23,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160168

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

