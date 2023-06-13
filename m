Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F82EB64DA
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 17:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbjFMRF1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 13:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbjFMRFW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 13:05:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846821BDD
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 10:05:16 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DGq8Q1028063;
        Tue, 13 Jun 2023 17:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8fsokhmJVAntcwloZZ8RlnFy/mloVh1qQQ6ISkG6Amw=;
 b=DxiG0qxboJr3JwxMgX7z8ywWtBVb7H4toBnaTuQnAPJ4pKG5FPyOLxyvCbBmQKo0Ekp5
 Gi8ttFGRC+pQiwzre+j3qd5LlMI7F6f7vPjn4PfCZj6SPJ+Jbh+t23NnxyXSlOFaCsm8
 rjiCJfsoMQ9op8w5JfytYvqV6aO/Jz/le2ZgRHWFEzYadyCdtsYOS6HPO8mbbqeXZzsB
 Qt/sCvoUeWcsleR6rmWEqLEdTEd11ES+fdse8B2VWSgH1xRaSNlDDIDZ7FpcAhc/FMbp
 Bvo0RRgE/gpOTV9YWXqdiAnsxtcWYWoVnCuLdzSkLVQaRUJlHm6LRs2lEXpiMU6QqWrO KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r6v5ts0hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:05:03 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35DGddMr022917;
        Tue, 13 Jun 2023 17:05:02 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r6v5ts03r-21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:05:02 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35D7LAbo009109;
        Tue, 13 Jun 2023 16:42:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3r4gt52abg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 16:42:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35DGgiX145089040
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 16:42:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E28F02004B;
        Tue, 13 Jun 2023 16:42:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 339A420040;
        Tue, 13 Jun 2023 16:42:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.111.115])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 13 Jun 2023 16:42:39 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        namhyung@kernel.org, ravi.bangoria@amd.com, john.g.garry@oracle.com
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>,
        Ojaswin Mujoo <ojaswin.mujoo@ibm.com>,
        Piyush Sachdeva <Piyush.Sachdeva@ibm.com>,
        Mukesh Chaurasiya <mukesh.chaurasiya@ibm.com>
Subject: [PATCH 10/17] tools/perf/tests: fix test_arm_spe.sh signal case issues
Date:   Tue, 13 Jun 2023 22:11:38 +0530
Message-Id: <20230613164145.50488-11-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com>
References: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hVbEPKspxgjs_T6JE-BEqMtofA8AbRZ0
X-Proofpoint-ORIG-GUID: Enm6Gv4s16-9XZh7kPcjX0CnlxGrmEGK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_19,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130151
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>

Running shellcheck -S on test_arm_spe.sh throws below warnings:

 #shellcheck -S warning tests/shell/test_arm_spe.sh
In tests/shell/test_arm_spe.sh line 30:
trap cleanup_files exit term int
                   ^--^ SC3049 (warning): In POSIX sh, using lower/mixed case for signal names is undefined.
                        ^--^ SC3049 (warning): In POSIX sh, using lower/mixed case for signal names is undefined.
                             ^-^ SC3049 (warning): In POSIX sh, using lower/mixed case for signal names is undefined.

Fixed this issue by using uppercase for "EXIT", "TERM" and
"INIT" signals to avoid using lower/mixed case for signal
names as input.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Signed-off-by: Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin.mujoo@ibm.com>
Signed-off-by: Piyush Sachdeva <Piyush.Sachdeva@ibm.com>
Signed-off-by: Mukesh Chaurasiya <mukesh.chaurasiya@ibm.com>
---
 tools/perf/tests/shell/test_arm_spe.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_arm_spe.sh b/tools/perf/tests/shell/test_arm_spe.sh
index aa094d71f5b4..03d5c7d12ee5 100755
--- a/tools/perf/tests/shell/test_arm_spe.sh
+++ b/tools/perf/tests/shell/test_arm_spe.sh
@@ -27,7 +27,7 @@ cleanup_files()
 	exit $glb_err
 }
 
-trap cleanup_files exit term int
+trap cleanup_files EXIT TERM INT
 
 arm_spe_report() {
 	if [ $2 = 0 ]; then
-- 
2.39.1

