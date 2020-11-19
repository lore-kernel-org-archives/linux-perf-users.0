Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF73C64E75
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Nov 2020 15:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F9E24695
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Nov 2020 15:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AFHXbVnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgKSPZX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Nov 2020 10:25:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728587AbgKSPZW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Nov 2020 10:25:22 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJF3o0K178201;
        Thu, 19 Nov 2020 10:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=bZWeach1hpqIl7RkSlIKJPYnf7keLEg/eCDF2QMudGY=;
 b=AFHXbVnlSsJ3MAa+tlSs32PwIEzK89R7S6vrvUsZWnb1Cc6Pph9KCVcs8AWilA55NYRJ
 l+mUU7mMgHmKbNWSJmnuZlY/TLThF4SpaVtjQ2eDzDillBTNlzd1P5KYwJo/Ih3N7Plb
 TKHJCrC/1ZwDQCFMFxpqljFbWlMIn+Iuep4V5yXV2Yc7eYVG0FoiALItR7GGUquVH1qK
 t+USKxYpnGgAznNueXrnLne/DDFzHd7n1WnEeuefjZbZ3PNTttmycFRiHOH7KRigKsOo
 443cgTmfDtMEq15T3rKcQnaadQqhSLKfVBO2FuXpDj50F8T3xRGFA1HdouqITTakUfTd 1w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34wg133jma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 10:25:20 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AJF4A4Y180667;
        Thu, 19 Nov 2020 10:25:19 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34wg133jk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 10:25:19 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AJF7fEV032766;
        Thu, 19 Nov 2020 15:25:16 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 34w4yfh6uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 15:25:16 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AJFPDGX50463172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 15:25:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E2E0A4057;
        Thu, 19 Nov 2020 15:25:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43A6FA404D;
        Thu, 19 Nov 2020 15:25:11 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.99.210])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 19 Nov 2020 15:25:10 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     jolsa@redhat.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, irogers@google.com,
        ravi.bangoria@linux.ibm.com, kjain@linux.ibm.com,
        maddy@linux.ibm.com
Subject: [PATCH] perf test: Fix metric parsing test
Date:   Thu, 19 Nov 2020 20:54:11 +0530
Message-Id: <20201119152411.46041-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_09:2020-11-19,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=1 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190114
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Commit e1c92a7fbbc5 ("perf tests: Add another metric parsing test")
add another test for metric parsing. The test goes through all metrics
compiled for arch within pmu events and try to parse them.

Right now this test is failing in powerpc machine.

Result in power9 platform:

[command]# ./perf test 10
10: PMU events                                                      :
10.1: PMU event table sanity                                        : Ok
10.2: PMU event map aliases                                         : Ok
10.3: Parsing of PMU event table metrics                            : Skip (some metrics failed)
10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!

Issue is we are passing different runtime parameter value in "expr__find_other"
and "expr__parse" function which is called from function `metric_parse_fake`.
And because of this parsing of hv-24x7 metrics is failing.

[command]# ./perf test 10 -vv
.....
hv_24x7/pm_mcs01_128b_rd_disp_port01,chip=1/ not found
expr__parse failed
test child finished with -1
---- end ----
PMU events subtest 4: FAILED!

This patch fix this issue and change runtime parameter value to '0' in
expr__parse function.

Result in power9 platform after this patch:

[command]# ./perf test 10
10: PMU events                                                      :
10.1: PMU event table sanity                                        : Ok
10.2: PMU event map aliases                                         : Ok
10.3: Parsing of PMU event table metrics                            : Skip (some metrics failed)
10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Fixes: e1c92a7fbbc5 ("perf tests: Add another metric parsing test")
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/tests/pmu-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index ad2b21591275..0ca6a5a53523 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -575,7 +575,7 @@ static int metric_parse_fake(const char *str)
 		}
 	}
 
-	if (expr__parse(&result, &ctx, str, 1))
+	if (expr__parse(&result, &ctx, str, 0))
 		pr_err("expr__parse failed\n");
 	else
 		ret = 0;
-- 
2.27.0

