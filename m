Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B29FC433B4
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Apr 2021 08:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 230D9611AE
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Apr 2021 08:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhDIIJn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:09:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229621AbhDIIJm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Apr 2021 04:09:42 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 139834f7048406;
        Fri, 9 Apr 2021 04:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=oMQnkpNydPuwHeLwOwD6pr0oIYbZT0IE6tD5wSdcxaQ=;
 b=S9K/fQ+s+mwT3phk7AQUQJ6EHTUBZ62L/o+KBgazilF/BcNUDky2aXHRi9y8fzgjO2Ry
 fl/A+AIvXpeGrAaPsM28QqSvBbNtZ/XN17y+jiNCyT6adcEBB2UeJ8x663oR+d0PhOhU
 mGyTlFC4kvav+TcdyjD5pEhlxoBBg7CJzh65bEVHKzUm8hR1QIg/OPDT6TEj2HFG83WW
 DWlAqp7qsGW+TrYcNPUtNj0ZFeFhg6tr9Vksjr3bmbQs4b8zn9kQWQHAlrngiy6OS/22
 DAG6H+eYVuFDP/aCq5JRUFOiKLuwP2RWfqMbfbaB+lkSlk1VIB9ni+aM7dumKyhKMBkm Vg== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvpw5j1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 04:09:29 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13983Ce6017354;
        Fri, 9 Apr 2021 08:09:27 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 37rvmq97bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 08:09:26 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13989NC848628088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Apr 2021 08:09:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB3D742041;
        Fri,  9 Apr 2021 08:09:23 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D65B4203F;
        Fri,  9 Apr 2021 08:09:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Apr 2021 08:09:23 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf ftrace: Command fails on s390
Date:   Fri,  9 Apr 2021 10:09:12 +0200
Message-Id: <20210409080912.2960595-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sTKAVn5_S4EkFvKp8EGEFBoeb9Zes4bc
X-Proofpoint-GUID: sTKAVn5_S4EkFvKp8EGEFBoeb9Zes4bc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_04:2021-04-08,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090059
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

