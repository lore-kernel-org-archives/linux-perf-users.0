Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F03DC433ED
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Apr 2021 12:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 055856144C
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Apr 2021 12:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbhDUMGN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Apr 2021 08:06:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8424 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239528AbhDUMGM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Apr 2021 08:06:12 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LC54Ti061129;
        Wed, 21 Apr 2021 08:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=T9NxUcQeX9cWyi14gRbLH6yWrW8jk9WYoVE4Yo7CR3s=;
 b=RZ/SAMUn7rMRLoiaSPwBtCkp2H1OMY7AENejcOLxZzPKGFPCbnKwIJ/06QLXfCVqg/eo
 yGPt7rbhCm0CF2c8nPVJrlsLMawx5b7PP0B1nHro3C0zD7f78sL+D9QYifgeVAElQyqS
 Le9mDJ0Aj8wI5t7lSDI78q3CE4y/COml382EDMzcO7XLXK8rSCq1U+g5egB3T/9LDVtQ
 99v2mSRdmbLe1GnMGa6shXy/GdP10ah6bW4MkQWWR2bZi8ODkJoJ2apnuWcyNXhAwY6s
 OlwitF2qxVCdtgSmcjVNnXu9sr6F4C1t9B0BHTEVG2VlqK30KYAvpCYcLnKaHidNVrV7 UA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 382keg8gsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 08:05:35 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13LC3H9s024382;
        Wed, 21 Apr 2021 12:04:10 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 37yqa8j9w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 12:04:09 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13LC44oa18481636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 12:04:04 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 433F252054;
        Wed, 21 Apr 2021 12:04:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E8FA552065;
        Wed, 21 Apr 2021 12:04:03 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>,
        Alexander Schmidt <alexschm@de.ibm.com>
Subject: [PATCH] [PING] perf ftrace: Command fails on s390
Date:   Wed, 21 Apr 2021 14:04:00 +0200
Message-Id: <20210421120400.2126433-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: atil0Njdz6NRXhbS6aO4yXrgaKzP6Dxr
X-Proofpoint-ORIG-GUID: atil0Njdz6NRXhbS6aO4yXrgaKzP6Dxr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_04:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104210094
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Command 'perf ftrace -v -- ls' fails in s390 (at least 5.12.0rc6).

The root cause is a missing pointer dereference which causes an
array element address to be used as PID.

Fix this by extracting the PID.

Output before:
  # ./perf ftrace -v -- ls
  function_graph tracer is used
  write '-263732416' to tracing/set_ftrace_pid failed: Invalid argument
  failed to set ftrace pid
  #

Output after:
   ./perf ftrace -v -- ls
   function_graph tracer is used
   # tracer: function_graph
   #
   # CPU  DURATION                  FUNCTION CALLS
   # |     |   |                     |   |   |   |
   4)               |  rcu_read_lock_sched_held() {
   4)   0.552 us    |    rcu_lockdep_current_cpu_online();
   4)   6.124 us    |  }

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reported-by: Alexander Schmidt <alexschm@de.ibm.com>
---
 tools/perf/builtin-ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index d49448a1060c..87cb11a7a3ee 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -289,7 +289,7 @@ static int set_tracing_pid(struct perf_ftrace *ftrace)
 
 	for (i = 0; i < perf_thread_map__nr(ftrace->evlist->core.threads); i++) {
 		scnprintf(buf, sizeof(buf), "%d",
-			  ftrace->evlist->core.threads->map[i]);
+			  perf_thread_map__pid(ftrace->evlist->core.threads, i));
 		if (append_tracing_file("set_ftrace_pid", buf) < 0)
 			return -1;
 	}
-- 
2.30.2

