Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86345EB64DC
	for <linux-perf-users@archiver.kernel.org>; Sun,  9 Jul 2023 18:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjGIS2e (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 9 Jul 2023 14:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjGIS2d (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 9 Jul 2023 14:28:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488C5F9
        for <linux-perf-users@vger.kernel.org>; Sun,  9 Jul 2023 11:28:32 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 369IRnuX021198;
        Sun, 9 Jul 2023 18:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=LKMD4sLwEy4cfcKkfMHsKzaKHxcZnkNg0Z39WCTNPJk=;
 b=OZGTMX/Kud3G9z/RAE6No+ihVQiWCEoxsEqb6xw/AHRfuVKASwuRi4gHtav+uR8GLnFJ
 lOfiXdypQnLtQbVtfJQR3ln1A9QQ5le8TyD+LMrN3dPGa+7uV6V0DwwppLR9OStacEm5
 m4QipItdsHhdKPGPaRgWct+mkBSPgyrrRjL3IBm6i1lj4ixxJR3tD6KLYCK+FVRpTkCn
 8/NAcsgwKo+9ffswZlr4eLE2M9bsiR7xb0j1tb+YicDg5XrPmKADcDmmMeiD+zO6faBo
 pJf52Sl6iq6FRsrDKidpODglli/zNQ3W5bR/Y+V5ugh1xgaXvpSifAahesmlUEEbg5nk YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rr26rr05e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jul 2023 18:28:28 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 369IS7jW023222;
        Sun, 9 Jul 2023 18:28:27 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rr26rr056-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jul 2023 18:28:27 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3697e5rV029458;
        Sun, 9 Jul 2023 18:28:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rpye58v4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jul 2023 18:28:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 369ISMet56099100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 9 Jul 2023 18:28:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3858A2004D;
        Sun,  9 Jul 2023 18:28:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FA5B20043;
        Sun,  9 Jul 2023 18:28:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.24.202])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sun,  9 Jul 2023 18:28:19 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH V2 06/26] tools/perf/tests: fix test_arm_spe_fork.sh signal case issues
Date:   Sun,  9 Jul 2023 23:57:40 +0530
Message-Id: <20230709182800.53002-7-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230709182800.53002-1-atrajeev@linux.vnet.ibm.com>
References: <20230709182800.53002-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 87hIG0EVW3-oUPkVDC_5C7zlG8nJca1q
X-Proofpoint-ORIG-GUID: 9_f1UFrULtrc6i_-XTwpzySQzJVQ2PXF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-09_12,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307090169
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Running shellcheck -S on test_arm_spe_fork.sh throws below warnings:

   In tests/shell/test_arm_spe_fork.sh line 25:
   trap cleanup_files exit term int
                      ^--^ SC3049 (warning): In POSIX sh, using lower/mixed case for signal names is undefined.
                           ^--^ SC3049 (warning): In POSIX sh, using lower/mixed case for signal names is undefined.
                                ^-^ SC3049 (warning): In POSIX sh, using lower/mixed case for signal names is undefined.

Fixed this issue by using uppercase for "EXIT", "TERM" and
"INIT" signals to avoid using lower/mixed case for signal
names as input.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/tests/shell/test_arm_spe_fork.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_arm_spe_fork.sh b/tools/perf/tests/shell/test_arm_spe_fork.sh
index fad361675a1d..1a7e6a82d0e3 100755
--- a/tools/perf/tests/shell/test_arm_spe_fork.sh
+++ b/tools/perf/tests/shell/test_arm_spe_fork.sh
@@ -22,7 +22,7 @@ cleanup_files()
 	rm -f ${PERF_DATA}
 }
 
-trap cleanup_files exit term int
+trap cleanup_files EXIT TERM INT
 
 echo "Recording workload..."
 perf record -o ${PERF_DATA} -e arm_spe/period=65536/ -vvv -- $TEST_PROGRAM > ${PERF_RECORD_LOG} 2>&1 &
-- 
2.39.1

