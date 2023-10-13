Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04822D535
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Oct 2023 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q8SKLx3/"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC09CA
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Oct 2023 00:31:04 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D7KRpL006108;
	Fri, 13 Oct 2023 07:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=piRyvg3rVnT9i0qMazdeEbqlgVJgTqu8Hnb611PSnVo=;
 b=Q8SKLx3/3uVTq3bnSUdY5hXapdnSdsq2ILhu06z3ffPjadO2/T2hNIOd0oRyZ+KWIsRQ
 PkqLDFCv2NM7z5+/nkLCQy8w7Br38+mgghFwCb2m0pbbRGpSuYF//3Leo5Yj44JwuRRP
 YmkC9oERwnTbE4QGXMqJl1sYGvSLq/2AdFlHW9CCnE7/p/AmIgMtaueQuRKPOZ+h9uXz
 I3u7WqXX00DkQTqRYdEF62TdTV07npeGxg0yqAj3/+r6Ui799ScRw8GsFOO8ufzZwsRw
 c8VGUCSKJ/Gf/vNoM+VuuMAEx8nI60p/+toKaexeyeQdXrpUqrMg9H8YAi7EbcZHoNMO zw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tq1dr09xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Oct 2023 07:30:37 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39D7LMW9010098;
	Fri, 13 Oct 2023 07:30:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tq1dr09wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Oct 2023 07:30:37 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39D5KtFg009030;
	Fri, 13 Oct 2023 07:30:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tpt57jb6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Oct 2023 07:30:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39D7UXut38863160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Oct 2023 07:30:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 958A32005A;
	Fri, 13 Oct 2023 07:30:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7FA320040;
	Fri, 13 Oct 2023 07:30:31 +0000 (GMT)
Received: from athiras-mbp.in.ibm.com (unknown [9.109.214.47])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Oct 2023 07:30:31 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V2 3/3] tools/perf/tests/shell: Fix shellcheck warning SC2112 with stat_all_metricgroups
Date: Fri, 13 Oct 2023 13:00:21 +0530
Message-Id: <20231013073021.99794-4-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231013073021.99794-1-atrajeev@linux.vnet.ibm.com>
References: <20231013073021.99794-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fePokvPYqHTrb64kDhEYQpC-AtWSCl6p
X-Proofpoint-GUID: lRvbcj7EYduS1Jmm-im8XlB1vQxMJ5eO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=846 phishscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130061
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Running shellcheck on stat_all_metricgroups.sh reports
below warning:

 In ./tests/shell/stat_all_metricgroups.sh line 7:
 function ParanoidAndNotRoot()
 ^-- SC2112: 'function' keyword is non-standard. Delete it.

As per the format, "function" is a non-standard keyword that
can be used to declare functions. Fix this by removing the
"function" keyword from ParanoidAndNotRoot function

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
Changelog:
 This is a new patch added in V2

 tools/perf/tests/shell/stat_all_metricgroups.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
index f3e305649e2c..55ef9c9ded2d 100755
--- a/tools/perf/tests/shell/stat_all_metricgroups.sh
+++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
@@ -4,7 +4,7 @@
 
 set -e
 
-function ParanoidAndNotRoot()
+ParanoidAndNotRoot()
 {
   [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
 }
-- 
2.31.1

