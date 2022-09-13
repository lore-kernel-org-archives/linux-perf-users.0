Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440C3C54EE9
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Sep 2022 11:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiIML4O (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Sep 2022 07:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiIML4L (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Sep 2022 07:56:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F7D5EDE2
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Sep 2022 04:56:10 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DAaTeB006434;
        Tue, 13 Sep 2022 11:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jALjmdVdCyWim8p9YyRCd++gxYP0J3m2GmFskOX9oHo=;
 b=IUAyyJLkqm0VAHxJDZPIvu+uau5i0LXpvOfBXghyg+OPcoRL0At/ZV9oy6y8Qeuo68pG
 NsBD/mXzN6A5zZodP8iYTUmFyS5iKlvf9uYyTeWTPEQS7gXiZfVMsdiggqrZZzRH6DaR
 HbWo6ArfiuNC0j31CAO+G7IdW+rnVWKcJfgIbfdiUQSb8ynYIHbipctn2iFtBHI6z7LW
 aaiIXAAfbvTg4b+BaBj10/JBQp4OULJ6nH+c+vLgKHdpv//4wngKFfZczCcCT5qnyJOY
 Ds028b60K6fkXY5q0AbGULfJqcRMprWiNGKGF2GKhcALR19kkMTcMZQcQR6n5s8TP26S dg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jjr8t2jkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 11:56:01 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28DBoSdu010024;
        Tue, 13 Sep 2022 11:55:59 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3jgj79ur3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 11:55:58 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28DBttAe37552414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 11:55:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA9AAA404D;
        Tue, 13 Sep 2022 11:55:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D45A2A4040;
        Tue, 13 Sep 2022 11:55:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.78.239])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 13 Sep 2022 11:55:51 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, mpe@ellerman.id.au
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH 2/3] tools/perf/tests: Fix branch stack sampling test to include sanity check for branch filter
Date:   Tue, 13 Sep 2022 17:25:45 +0530
Message-Id: <20220913115546.36179-2-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220913115546.36179-1-atrajeev@linux.vnet.ibm.com>
References: <20220913115546.36179-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bqQcZF3SzH8z9dXq24Vvq_p-i4Xmxe6r
X-Proofpoint-GUID: bqQcZF3SzH8z9dXq24Vvq_p-i4Xmxe6r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_05,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130052
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

commit b55878c90ab9 ("perf test: Add test for branch stack sampling")
added test for branch stack sampling. There is a sanity check in the
beginning to skip the test if the hardware doesn't support branch stack
sampling.

Snippet
<<>>
skip the test if the hardware doesn't support branch stack sampling
perf record -b -o- -B true > /dev/null 2>&1 || exit 2
<<>>

But the testcase also uses branch sample types: save_type, any. if any
platform doesn't support the branch filters used in the test, the testcase
will fail. In powerpc, currently mutliple branch filters are not supported
and hence this test fails in powerpc. Fix the sanity check to look at
the support for branch filters used in this test before proceeding with
the test.

Fixes: b55878c90ab9 ("perf test: Add test for branch stack sampling")
Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/tests/shell/test_brstack.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index c644f94a6500..ec801cffae6b 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -12,7 +12,8 @@ if ! [ -x "$(command -v cc)" ]; then
 fi
 
 # skip the test if the hardware doesn't support branch stack sampling
-perf record -b -o- -B true > /dev/null 2>&1 || exit 2
+# and if the architecture doesn't support filter types: any,save_type,u
+perf record -b -o- -B --branch-filter any,save_type,u true > /dev/null 2>&1 || exit 2
 
 TMPDIR=$(mktemp -d /tmp/__perf_test.program.XXXXX)
 
-- 
2.31.1

