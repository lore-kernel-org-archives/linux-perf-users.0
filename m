Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6D6EB64D9
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Jul 2023 05:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjGDFER (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Jul 2023 01:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjGDFEQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Jul 2023 01:04:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4608B1AD
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Jul 2023 22:04:16 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3644lQB9009396;
        Tue, 4 Jul 2023 05:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=/6pvM9vBeSYJK1BhSenMsSpIu4OXtUUJeIh79wu2SrM=;
 b=ijv8xrQd3MMyYYYY6Mo7ZOpR4a96ZqUAEuA9S8g8ntPBSjRSWtTJPmOb6ajEqpDV3VMw
 ALUsypa+gRb5n1OJsm52/HsFg6x5GFpAsF0vHs99Nz2NdRZfBwlNE6c2DUtKUa2ACNHL
 nRkHFezsGmu0tVL+8qrgyxv0YKgGNVv5SOWCA57mUGAUedE9alQAs0QG1UMPpZblJ6gU
 k1yynIRjgXwrmamJvP+cDE/RQxEcT66/qCmjT+FuFxldNn+yRPhzvFOD38TM+z02uQGH
 s/62JTTxJMwDod/QydQ9cY95wjQxsKz8Q946JBtdcfhzq9CF+CiARavUR4YJ1I3Fu14P qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmcpvgb3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 05:04:05 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3644nXhH015064;
        Tue, 4 Jul 2023 05:04:04 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmcpvgb35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 05:04:04 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3643msjm006770;
        Tue, 4 Jul 2023 05:04:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4st80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 05:04:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36453wCf8913494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jul 2023 05:03:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94A802005A;
        Tue,  4 Jul 2023 05:03:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF9BF20040;
        Tue,  4 Jul 2023 05:03:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.47.10])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jul 2023 05:03:55 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, ak@linux.intel.com
Cc:     namhyung@kernel.org, irogers@google.com, james.clark@arm.com,
        mpe@ellerman.id.au, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.ibm.com,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH] tools/perf/tests: Fix objdump in Object code reading test to look for all sections
Date:   Tue,  4 Jul 2023 10:33:53 +0530
Message-Id: <20230704050353.14979-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BgFy6xopOiaTqfDVbEzWgKv6LG9tW1Dt
X-Proofpoint-GUID: RxLrSimjKwzjIgzpSkPJpNXbL_SWs1x6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_02,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040042
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Object code reading test fails intermittently with below logs:

   Reading object code for memory address: 0xc008000001dd34fc
   File is: /lib/modules/6.3.0-rc7+/kernel/fs/xfs/xfs.ko
   On file address is: 0x11359c
   Objdump command is: objdump -z -d --start-address=0x1134fc --stop-address=0x11357c /lib/modules/6.3.0-rc7+/kernel/fs/xfs/xfs.ko
   objdump read too few bytes: 128
   test child finished with -1
   ---- end ----
   Object code reading: FAILED!

This issue happens ramdomly depending on the sample ip
captured during the test run. In some cases, the same ip falls
in the xfs module. The test does an objdump on the xfs.ko file and
compares it with the dump from the dso that perf captures. But
since the range of ip address falls in debug info section, it fails
to find the address range with objdump. Fix the objdump option so
as to disasseble all sections to check the address range.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/tests/code-reading.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index ed3815163d1b..02132478856a 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -184,7 +184,7 @@ static int read_via_objdump(const char *filename, u64 addr, void *buf,
 	FILE *f;
 	int ret;
 
-	fmt = "%s -z -d --start-address=0x%"PRIx64" --stop-address=0x%"PRIx64" %s";
+	fmt = "%s -z -D --start-address=0x%"PRIx64" --stop-address=0x%"PRIx64" %s";
 	ret = snprintf(cmd, sizeof(cmd), fmt, "objdump", addr, addr + len,
 		       filename);
 	if (ret <= 0 || (size_t)ret >= sizeof(cmd))
-- 
2.35.3

