Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E37C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 08:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA1E61A02
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 08:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhKQI3S (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Nov 2021 03:29:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49230 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229944AbhKQI3R (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Nov 2021 03:29:17 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AH5gWq9005972;
        Wed, 17 Nov 2021 08:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : references : to : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MYrAnugj5IIkIbGnWyB40B4Gzvju9U7lJ9d8SbyMPPI=;
 b=KlNOL2tPci8Aq6D4+lnm+gm0gtxWR8Ga0BRsRFYNKnjKnazP8kDTOJB4ZpKZLyAgTjL7
 xjMvNtCYc2g5HP679tlZgNuAnSpzeHoKS8YW3xjFt7VoGByi1xVBIUC1cMGEnFAHPUW2
 41hs33WCcxWOHrM0gPaaPLf/8NloDrmoReY65WvfOuMJBU3LMDXbTcDmQG+y/r3aPAoh
 hTSFZQELaal0Rj+wz2TCluw+oMTWGLRb84bujKB46z7EtKtevcVcty8Kiy+gMYGEMtCI
 AUSzuYAvX4rG5LedJ3sUwHV2uwNyqPHvWbqsK5G11+RenHrLHyo7xMgWbgADbyU/2D6O +Q== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ccuttb7me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 08:26:17 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AH8PS2T019252;
        Wed, 17 Nov 2021 08:26:15 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3ca50b7dmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 08:26:15 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AH8QATx28508598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 08:26:10 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBB69A4053;
        Wed, 17 Nov 2021 08:26:09 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6862A4055;
        Wed, 17 Nov 2021 08:26:09 +0000 (GMT)
Received: from [9.145.67.37] (unknown [9.145.67.37])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Nov 2021 08:26:09 +0000 (GMT)
Message-ID: <54077e81-503e-3405-6cb0-6541eb5532cc@linux.ibm.com>
Date:   Wed, 17 Nov 2021 09:26:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: PING [PATCH] perf/test: Test case 27 broken on s390 in linux-next
References: <20211103155215.2941895-1-tmricht@linux.ibm.com>
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>, maddy@linux.ibm.com,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20211103155215.2941895-1-tmricht@linux.ibm.com>
X-Forwarded-Message-Id: <20211103155215.2941895-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oEt43jJRnSMEecknz31uTVbQ8b4Rueg5
X-Proofpoint-GUID: oEt43jJRnSMEecknz31uTVbQ8b4Rueg5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_03,2021-11-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170037
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo, 

since I have not received any ACK from Maddy and the issue still shows up on s390 in
our daily test suite, can you go ahead and pick this patch.

Thanks 

Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294



-------- Forwarded Message --------
Subject: [PATCH] perf/test: Test case 27 broken on s390 in linux-next
Date: Wed,  3 Nov 2021 16:52:15 +0100
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, sumanthk@linux.ibm.com, maddy@linux.ibm.com, jolsa@redhat.com
CC: svens@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>

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


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
