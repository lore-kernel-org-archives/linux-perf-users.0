Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB37C63798
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Nov 2020 13:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C395F22264
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Nov 2020 13:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XaGf8kUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgKSNuk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Nov 2020 08:50:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24208 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726485AbgKSNuk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Nov 2020 08:50:40 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJDP8Ku044448;
        Thu, 19 Nov 2020 08:50:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VzZrSNFUEqf4F0cbBbVVL4kW947IWOrtv+Kvjt904g0=;
 b=XaGf8kUBvN1/R3z+H4o5+Snm8ANLugus2H0RG5NP16EuJnwA0B/gdVSPmx0EYsTnxiPX
 fLjuYxHE75J5vVi6rXpclmydPgRuUWeHK0IbSGa1v/z9wqNQp03JLpY3cF+Wen83ByoW
 z/Bv45o7w80InajNbBb4uZzYzP0K5DL4YPwrkiavuO8mlzNbdAm7oIxzGk6vq8EIC1n9
 mR3WzLDni8o6Goic21aTurMg89/kPWuVcAwIoy64sXqNKrVdjuuTSDFfyBHI6N68Y0wB
 lysjtYZgtumnzC98lNYWtWIayiDnvC5vtHGs3iZxfYjf1RlLATITXr6lrJW/j5Y6QAeB TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34wsjv8s84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 08:50:36 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AJDi9D8139871;
        Thu, 19 Nov 2020 08:50:35 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34wsjv8s78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 08:50:35 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AJDm0Z0009719;
        Thu, 19 Nov 2020 13:50:33 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 34v69usbwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 13:50:32 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AJDoTTL56689048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 13:50:30 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF3FF42049;
        Thu, 19 Nov 2020 13:50:29 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB1A942041;
        Thu, 19 Nov 2020 13:50:26 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.99.210])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 19 Nov 2020 13:50:26 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     jolsa@redhat.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        irogers@google.com, ravi.bangoria@linux.ibm.com,
        tmricht@linux.ibm.com, kjain@linux.ibm.com,
        rbernon@codeweavers.com, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com
Subject: [PATCH] perf test: Skip test 68 for Powerpc
Date:   Thu, 19 Nov 2020 19:20:22 +0530
Message-Id: <20201119135022.36340-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201104082954.57338-1-tmricht@linux.ibm.com>
References: <20201104082954.57338-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_08:2020-11-19,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 suspectscore=1 bulkscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011190097
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Commit ed21d6d7c48e6e ("perf tests: Add test for PE binary format support")
adds a WINDOWS EXE file named tests/pe-file.exe, which is
examined by the test case 'PE file support'. As powerpc doesn't support
it, we are skipping this test.

Result in power9 platform before this patach:
[command]# ./perf test -F 68
68: PE file support                               : Failed!

Result in power9 platform after this patch:
[command]# ./perf test -F 68
68: PE file support                               : Skip

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/tests/pe-file-parsing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
index 4e45178c50f6..14f675f5ffb2 100644
--- a/tools/perf/tests/pe-file-parsing.c
+++ b/tools/perf/tests/pe-file-parsing.c
@@ -18,7 +18,7 @@
 
 #include "tests.h"
 
-#if defined(HAVE_LIBBFD_SUPPORT) && !defined(__s390x__)
+#if defined(HAVE_LIBBFD_SUPPORT) && !defined(__s390x__) && !defined(__powerpc__)
 
 static int run_dir(const char *d)
 {
-- 
2.27.0

