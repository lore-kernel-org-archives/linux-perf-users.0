Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE699EB64D0
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 17:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbjFMRFa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 13:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbjFMRF3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 13:05:29 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5313184
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 10:05:27 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DGkWoP007778;
        Tue, 13 Jun 2023 17:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=q95apqpCykT3S3VSpUwj1Z4v2lnCwIweYTjECZVB5/Y=;
 b=DpFRfzgdbOoK0C9dNwWO+N6miDKqb0N9LsWeeXPjqwvuul4GAS4BLIiPBo2fU0SeIW0u
 cgewr8jTD4hywReb68fAaRHw+C5ZH9ciJQSKrcgSOYqTPUrNYleDu2DiTSjws1irfmKP
 xS8NZYhNECqdG2IyNFIFIthq5TVQB21TmTstzjVe6xQLBq3fqevCRZSp2IeyV/1f1BvA
 tE+PoBGFlVEnrdwjTQg5hYosTkSHa40eXJiJBEJDBeHhYGc5P3JAr8Y1K7W37FC5phMO
 e074yxWp7wnQaQtGx91a6zWRQoFhD0dnS74C+lYP/cE0luQgDvMVT6WquBLVUPmRDZsc vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r6uvn0q6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:04:47 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35DGn0QK015279;
        Tue, 13 Jun 2023 17:04:47 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r6uvn0pyu-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:04:47 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35D1QJP9008529;
        Tue, 13 Jun 2023 16:43:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3r4gee2a8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 16:43:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35DGgvgM63111442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 16:42:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1B292004B;
        Tue, 13 Jun 2023 16:42:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6CCA20040;
        Tue, 13 Jun 2023 16:42:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.111.115])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 13 Jun 2023 16:42:54 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        namhyung@kernel.org, ravi.bangoria@amd.com, john.g.garry@oracle.com
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        Spoorthy S <spoorts2@in.ibm.com>
Subject: [PATCH 14/17] tools/perf/tests: Fix all POSIX sh warnings in stat+shadow_stat.sh
Date:   Tue, 13 Jun 2023 22:11:42 +0530
Message-Id: <20230613164145.50488-15-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com>
References: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CTxCdyT59syWfGLwGZtdHu1FimX2F2JJ
X-Proofpoint-GUID: dSFh7uodaIjDWQgL5lvSW5IdGzBL1nUu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_19,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306130151
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Spoorthy S <spoorts2@in.ibm.com>

Running shellcheck -S on stat+shadow_stat.sh testcase, generates
SC2046 and SC2034 warnings,

$ shellcheck -S warning tests/shell/stat+shadow_stat.sh
	res=`printf "%.2f" $(echo "scale=6; $num / $cyc" | bc -q)`
			   : Quote this to prevent word splitting

To address the POSIX shell warnings used quotes in the printf
expressions, to prevent word splitting.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Signed-off-by: Spoorthy S <spoorts2@in.ibm.com>
---
 tools/perf/tests/shell/stat+shadow_stat.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/stat+shadow_stat.sh b/tools/perf/tests/shell/stat+shadow_stat.sh
index e6e35fc6c882..0e9cba84e757 100755
--- a/tools/perf/tests/shell/stat+shadow_stat.sh
+++ b/tools/perf/tests/shell/stat+shadow_stat.sh
@@ -33,7 +33,7 @@ test_global_aggr()
 		fi
 
 		# use printf for rounding and a leading zero
-		res=`printf "%.2f" $(echo "scale=6; $num / $cyc" | bc -q)`
+		res=`printf "%.2f" "$(echo "scale=6; $num / $cyc" | bc -q)"`
 		if [ "$ipc" != "$res" ]; then
 			echo "IPC is different: $res != $ipc  ($num / $cyc)"
 			exit 1
@@ -67,7 +67,7 @@ test_no_aggr()
 		fi
 
 		# use printf for rounding and a leading zero
-		res=`printf "%.2f" $(echo "scale=6; $num / $cyc" | bc -q)`
+		res=`printf "%.2f" "$(echo "scale=6; $num / $cyc" | bc -q)"`
 		if [ "$ipc" != "$res" ]; then
 			echo "IPC is different for $cpu: $res != $ipc  ($num / $cyc)"
 			exit 1
-- 
2.39.1

