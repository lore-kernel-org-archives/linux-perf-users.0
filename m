Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0B4C43334
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Jun 2022 14:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349301AbiFJOAY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Jun 2022 10:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349139AbiFJOAW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Jun 2022 10:00:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7015B273937
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jun 2022 07:00:00 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ADIiNb023542;
        Fri, 10 Jun 2022 13:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=f4aq0u3gKzc7phMU3PgLH4gEl81nO1j9Vq1ikMfl1qU=;
 b=BWTCjmjCR/A3NJxxKqkGyU2w90TQni48BHKCiujxYEdE/vg8imgNpml5pyKKkkrMbkO9
 k5PB/YkLjgN+KxW4+tCU2B84ChgXJrAmP15Bcmf+Yl7kUeMwn0lCLg4U5KOdizlThLbi
 +yBhmwDMvaitIA3Chfq48FkO0/2vmsbWFB/BLJdbQU6Ytkk2zBL6awCGfgDi40uoKMi8
 zMPg570hX2RZA6GxihTvq5R1Q68a8Jz3Mz1tmMKgaCvOtkwESVzpXjh4ltumNRU9u93/
 phOSEFDZ+4gFlmszYBtJkYc8kcn13T//KE6E9HE+eRIWfO+K+x5Bx7pEe0V1s3C/0njq Tg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gm6qurujs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:59:53 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25ADa8bc007047;
        Fri, 10 Jun 2022 13:59:51 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3gfy196hmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:59:50 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25ADxlBG19530122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jun 2022 13:59:47 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B09752050;
        Fri, 10 Jun 2022 13:59:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.163.7.130])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B205852052;
        Fri, 10 Jun 2022 13:59:41 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, disgoel@linux.vnet.ibm.com
Cc:     mpe@ellerman.id.au, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com, tmricht@linux.ibm.com
Subject: [PATCH] tools/perf/tests: Fix session topology test comparison check
Date:   Fri, 10 Jun 2022 19:29:39 +0530
Message-Id: <20220610135939.63361-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Tswhf1-I05yyeEShKuVhJnXsWYvfubQg
X-Proofpoint-ORIG-GUID: Tswhf1-I05yyeEShKuVhJnXsWYvfubQg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_06,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206100056
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

commit cfd7092c31ae ("perf test session topology: Fix test to
skip the test in guest environment") added check to skip the
testcase if the socket_id can't be fetched from topology info.
But the condition check uses strncmp which should be changed to
!strncmp and to correctly match platform. Patch fixes this
condition check.

Fixes: cfd7092c31ae ("perf test session topology: Fix test to skip the test in guest environment")
Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/tests/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index d23a9e322ff5..0b4f61b6cc6b 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -115,7 +115,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	 * physical_package_id will be set to -1. Hence skip this
 	 * test if physical_package_id returns -1 for cpu from perf_cpu_map.
 	 */
-	if (strncmp(session->header.env.arch, "powerpc", 7)) {
+	if (!strncmp(session->header.env.arch, "ppc64le", 7)) {
 		if (cpu__get_socket_id(perf_cpu_map__cpu(map, 0)) == -1)
 			return TEST_SKIP;
 	}
-- 
2.35.1

