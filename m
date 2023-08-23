Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E92EE4993
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Aug 2023 07:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjHWHvj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 03:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjHWHvi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2023 03:51:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6166CD0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 00:51:36 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37N7cX0b031834;
        Wed, 23 Aug 2023 07:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Vm0P1V2ZHd5PYlcAB1DuCqKWNGQiok//SrP73naa8Sg=;
 b=UtE/5vKbjtvS6V5ly605ZL3YwFeDbvS2BaTqXk3wZ17P2a5lAn1HrOBIk+iQvK6VnUHw
 fLB9MLiR8Zia6Y8XcQhgUL8tENVC9kb88L8thfEDXmk+Xp+xU32gUAQZT7314fjZFt7p
 hzbRMH+IelLJGeTlwQxIlT5LhgR2EBnZTy/8qFLmLgFG3sskJsf5JWT+USODu+AHjNlk
 3vz+9So/jfXA4//6JK/m/STfh7Q5F0tgQbmsDwI4ddnfpcb8W5Ncl9snv+ZMm8kd96fn
 /a0l0WHD3WCcAMkdEGQ41+BTBWw+4Dvqdj0PQe6ieb9tk1JOeGZD8y1+AJf8JY4F84cY tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3snce1t655-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 07:51:30 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37N7g85V012618;
        Wed, 23 Aug 2023 07:51:30 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3snce1t64j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 07:51:29 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37N7GMAS016416;
        Wed, 23 Aug 2023 07:51:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sn227mkdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 07:51:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37N7pPJF38273436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 07:51:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7432720040;
        Wed, 23 Aug 2023 07:51:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A78DB20043;
        Wed, 23 Aug 2023 07:51:19 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.40.46])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 23 Aug 2023 07:51:19 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        disgoel@linux.ibm.com, kjain@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, namhyung@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com,
        Disha Goel <disgoel@linux.vnet.ibm.com>
Subject: [PATCH] perf test: Skip perf bench breakpoint run if no breakpoints available
Date:   Wed, 23 Aug 2023 13:21:03 +0530
Message-Id: <20230823075103.190565-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dGu7xXNTcOMd0jff7b-GtGrsLZm73FCx
X-Proofpoint-ORIG-GUID: HVIYWSxpSwBisELiFp-Hg8tKhsIRux59
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_05,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308230068
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Based on commit 7d54a4acd8c1 ("perf test: Skip watchpoint
tests if no watchpoints available"), hardware breakpoints
are not available for power9 platform and because of that
perf bench breakpoint run fails on power9 platform.
Add code to check for the return value of perf_event_open()
in breakpoint run and skip the perf bench breakpoint run,
if hardware breakpoints are not available.

Result on power9 system before patch changes:
[command]# perf bench breakpoint thread
perf_event_open: No such device

Result on power9 system after patch changes:
[command]# ./perf bench breakpoint thread
Skipping perf bench breakpoint thread: No hardware support

Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/bench/breakpoint.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/perf/bench/breakpoint.c b/tools/perf/bench/breakpoint.c
index 41385f89ffc7..dfd18f5db97d 100644
--- a/tools/perf/bench/breakpoint.c
+++ b/tools/perf/bench/breakpoint.c
@@ -47,6 +47,7 @@ struct breakpoint {
 static int breakpoint_setup(void *addr)
 {
 	struct perf_event_attr attr = { .size = 0, };
+	int fd;
 
 	attr.type = PERF_TYPE_BREAKPOINT;
 	attr.size = sizeof(attr);
@@ -56,7 +57,12 @@ static int breakpoint_setup(void *addr)
 	attr.bp_addr = (unsigned long)addr;
 	attr.bp_type = HW_BREAKPOINT_RW;
 	attr.bp_len = HW_BREAKPOINT_LEN_1;
-	return syscall(SYS_perf_event_open, &attr, 0, -1, -1, 0);
+	fd = syscall(SYS_perf_event_open, &attr, 0, -1, -1, 0);
+
+	if (fd < 0)
+		fd = -errno;
+
+	return fd;
 }
 
 static void *passive_thread(void *arg)
@@ -122,8 +128,14 @@ int bench_breakpoint_thread(int argc, const char **argv)
 
 	for (i = 0; i < thread_params.nbreakpoints; i++) {
 		breakpoints[i].fd = breakpoint_setup(&breakpoints[i].watched);
-		if (breakpoints[i].fd == -1)
+
+		if (breakpoints[i].fd < 0) {
+			if (breakpoints[i].fd == -ENODEV) {
+				printf("Skipping perf bench breakpoint thread: No hardware support\n");
+				return 0;
+			}
 			exit((perror("perf_event_open"), EXIT_FAILURE));
+		}
 	}
 	gettimeofday(&start, NULL);
 	for (i = 0; i < thread_params.nparallel; i++) {
@@ -196,8 +208,14 @@ int bench_breakpoint_enable(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 	fd = breakpoint_setup(&watched);
-	if (fd == -1)
+
+	if (fd < 0) {
+		if (fd == -ENODEV) {
+			printf("Skipping perf bench breakpoint enable: No hardware support\n");
+			return 0;
+		}
 		exit((perror("perf_event_open"), EXIT_FAILURE));
+	}
 	nthreads = enable_params.npassive + enable_params.nactive;
 	threads = calloc(nthreads, sizeof(threads[0]));
 	if (!threads)
-- 
2.39.3

