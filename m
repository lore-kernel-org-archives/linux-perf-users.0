Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B05C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Nov 2021 15:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E7460E9B
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Nov 2021 15:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhKCPzN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Nov 2021 11:55:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229885AbhKCPzM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 Nov 2021 11:55:12 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A3FqUqv007979;
        Wed, 3 Nov 2021 15:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=fm92TBvs3qYC4E7nOymJrhuSFDK74182N2yTteebE6I=;
 b=N1BpCxvLbURxRPJUeFzpongwGcTwB+c4urtyMG0JR8IEqXe1ZnX12RvfttUatM+vv+1U
 KueS6/AD9RGH50bBhB9hWlH1XZ3SwuMToa3kBEGzCpWcu4Y1ps1KChbx9ohLe1V/yjFW
 JJuoZGWuMXqmeQn/V3tJptkbPM07mloves+eHMgWdx9k2ma3rwsxGmr3k9YB60oyEB9G
 tlC9Mwzx/DMR8eeY6G33fGZCI2okn3q4lvxEYDV+MxBUO7omZEqpo03Xwyh0i84cYIlx
 GutCJAPuvHtvWhlQlqQXH8KZIgip1Rc7NtXcM1czkN3rYpKrhx8z7SRlfeANVDDOOPRX dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c3vt9s31d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Nov 2021 15:52:34 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1A3FqUiR007967;
        Wed, 3 Nov 2021 15:52:33 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c3vt9s2yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Nov 2021 15:52:33 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A3FhEED024021;
        Wed, 3 Nov 2021 15:52:31 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3c0wp9wp4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Nov 2021 15:52:31 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A3FqSDk7012872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Nov 2021 15:52:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DB424C044;
        Wed,  3 Nov 2021 15:52:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D4B34C040;
        Wed,  3 Nov 2021 15:52:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Nov 2021 15:52:28 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com, maddy@linux.ibm.com,
        jolsa@redhat.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/test: Test case 27 broken on s390 in linux-next
Date:   Wed,  3 Nov 2021 16:52:15 +0100
Message-Id: <20211103155215.2941895-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zKlrLdJOsV68AglyUc5K14mB3ZJL1LSZ
X-Proofpoint-GUID: HLnGwBEJoksy2vqXj4izKM-Cxg8o_XyH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_05,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1011
 suspectscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111030089
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Commit 10269a2ca2b08c ("perf test sample-parsing: Add endian test for struct branch_flags")
broke the test case 27 (Sample parsing) on s390 on linux-next tree:

  # ./perf test -Fv 27
  27: Sample parsing
  --- start ---
  parsing failed for sample_type 0x800
  ---- end ----
  Sample parsing: FAILED!
  #

The cause of the failure is a wrong #define BS_EXPECTED_BE statement
in above commit.  Correct this define and the test case runs fine.

Output After:
  # ./perf test -Fv 27
  27: Sample parsing                                                  :
  --- start ---
  ---- end ----
  Sample parsing: Ok
  #

Fixes: 10269a2ca2b08c ("perf test sample-parsing: Add endian test for struct branch_flags")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/sample-parsing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index c83a11514129..9c7af55b74db 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -36,7 +36,7 @@
  * These are based on the input value (213) specified
  * in branch_stack variable.
  */
-#define BS_EXPECTED_BE	0xa00d000000000000
+#define BS_EXPECTED_BE	0xa000d00000000000
 #define BS_EXPECTED_LE	0xd5000000
 #define FLAG(s)	s->branch_stack->entries[i].flags
 
-- 
2.25.1

