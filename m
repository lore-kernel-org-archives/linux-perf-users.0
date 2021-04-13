Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47247C433ED
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Apr 2021 15:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A04B61353
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Apr 2021 15:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhDMPl2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Apr 2021 11:41:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230322AbhDMPl1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Apr 2021 11:41:27 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DFYEGN058669
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Apr 2021 11:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=T9NxUcQeX9cWyi14gRbLH6yWrW8jk9WYoVE4Yo7CR3s=;
 b=qq2ij34e8cbBsVmnOKdEcjAJXY2D1gt+0QYii4Jxq/jMqLxdjWvlX/VFrLQ9O2MBZ5oT
 Yjf5XBi+PxM6bSlMUNHvAw9GgpIY+oJPbm7/b81fA8oRKZBUx8enZj3KQhqbzMatASES
 5vdlBtJ1hxX9lMSYTfKkLz/clLsEcqMX/tUIdpGYPJcCQk2eiGgdXCDBoPT6nF1J50te
 4FO8pdZ7F/Nn0cmgjFtiuBERld49Bl1Y/OmuIOwCRzuJxVxjBulpXGpW5EWfyrWkNyC/
 kh1fatdxv+3SJXq1WOdI/wwZ34Bt//iOSQNHxk2p/arQhK8LfpZOKyICHQQ5No39+l0n FQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37wdws0f9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Apr 2021 11:41:07 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13DFT9Ej023164
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Apr 2021 15:41:04 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 37u3n8tsm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Apr 2021 15:41:04 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13DFexAA38011194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 15:40:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25B7AAE055;
        Tue, 13 Apr 2021 15:40:59 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0DAAAE056;
        Tue, 13 Apr 2021 15:40:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 13 Apr 2021 15:40:58 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Alexander Schmidt <alexschm@de.ibm.com>
Subject: [PATCH] perf ftrace: Command fails on s390
Date:   Tue, 13 Apr 2021 17:40:52 +0200
Message-Id: <20210413154052.84457-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0rI_HVd1NE74hoxDKD6vgXp6W47jnH85
X-Proofpoint-GUID: 0rI_HVd1NE74hoxDKD6vgXp6W47jnH85
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_09:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130108
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

