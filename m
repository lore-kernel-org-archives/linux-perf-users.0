Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8778BEB64D7
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jun 2023 08:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjFUIbP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jun 2023 04:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjFUIbO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jun 2023 04:31:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308B51712
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jun 2023 01:31:13 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L8Jsvi006349;
        Wed, 21 Jun 2023 08:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UqAO3PubnZ0hxIJg58NVAAxh7lsx/3vQlxBnmE6xzSE=;
 b=pRko/pZbvbRobRlm39PukMVgyQMd8XZUSWw80P5GCOa4v2FV4/t50WAn5K+0kvmNYKV3
 blifgJyUUzVyRhJvTcuOrz/oTQJH6Mflg9dOuP4aHGwMhE6GdJBFsVSZ738jSYa8EC9m
 SptpKF8haIpx6jLJHkBEKaMjhGER3djlEM9mt0q7y4Up+6cILLNWHVxeinQzW2xDzjuG
 z+3kIQkjkrWYM9ubBgMD1eNwJgsUQuorN+ocbVEoW1tp/jx1fPi+LNiQ/lGlA1ou+aTi
 SM3dfkvCMLRdYvEY10eXj1M7COkMb2yKWyCK4IfnMbPNHf5BbIXp+DGkM6SOsHBktnFJ Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rbwkr06xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 08:31:05 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35L8KwIE008432;
        Wed, 21 Jun 2023 08:31:05 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rbwkr06w5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 08:31:05 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35L4qls8018799;
        Wed, 21 Jun 2023 08:31:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3r94f52mhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 08:31:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35L8UxtK16908800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 08:30:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0613720043;
        Wed, 21 Jun 2023 08:30:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4073C20040;
        Wed, 21 Jun 2023 08:30:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.109.215.188])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 21 Jun 2023 08:30:56 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        namhyung@kernel.org, ravi.bangoria@amd.com, john.g.garry@oracle.com
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH 08/22] tools/perf/tests: fix shellcheck warning for test_perf_data_converter_json.sh testcase
Date:   Wed, 21 Jun 2023 14:00:07 +0530
Message-Id: <20230621083021.71203-9-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230621083021.71203-1-atrajeev@linux.vnet.ibm.com>
References: <20230621083021.71203-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Wrr0be_wK4ffwwrUGwTX-GAFZCSRXu96
X-Proofpoint-GUID: IOKxYboy_Iqy5AcIehKrOdJccYYgwTXH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=997 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210067
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Running shellcheck on test_perf_data_converter_json.sh throws
below warning:

   In tests/shell/test_perf_data_converter_json.sh line 42:
   	if [ $(cat "${result}" | wc -l) -gt "0" ] ; then
                ^------------------------^ SC2046 (warning): Quote this to prevent word splitting.

Fixed the warning by adding quotes to avoid word splitting.

ShellCheck result with patch:
    # shellcheck -S warning test_perf_data_converter_json.sh
    #

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/tests/shell/test_perf_data_converter_json.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_perf_data_converter_json.sh b/tools/perf/tests/shell/test_perf_data_converter_json.sh
index 72ac6c83231c..6ded58f98f55 100755
--- a/tools/perf/tests/shell/test_perf_data_converter_json.sh
+++ b/tools/perf/tests/shell/test_perf_data_converter_json.sh
@@ -39,7 +39,7 @@ test_json_converter_command()
 	echo "Testing Perf Data Convertion Command to JSON"
 	perf record -o "$perfdata" -F 99 -g -- perf test -w noploop > /dev/null 2>&1
 	perf data convert --to-json "$result" --force -i "$perfdata" >/dev/null 2>&1
-	if [ $(cat "${result}" | wc -l) -gt "0" ] ; then
+	if [ "$(cat ${result} | wc -l)" -gt "0" ] ; then
 		echo "Perf Data Converter Command to JSON [SUCCESS]"
 	else
 		echo "Perf Data Converter Command to JSON [FAILED]"
-- 
2.39.1

