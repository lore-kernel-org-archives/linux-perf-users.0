Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5634DC433DB
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Mar 2021 11:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16AB965268
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Mar 2021 11:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhCILFt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Mar 2021 06:05:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36204 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229875AbhCILFk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Mar 2021 06:05:40 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 129B2ues063096;
        Tue, 9 Mar 2021 06:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=AW61LqGjnRgXZHHqyRhjGGxS+iHj6ivwsqhDbjECUaI=;
 b=e93mwpjhV2o+UK1k6MHChkC9tctjDm+cXyNi8rWZiB5W9jMY7bdTqs5YxrfBtL/3xBE/
 EVOhmh4tQe7EJtztvF/ueruVY7iN0e/iQ3gTsp0K4HVHTOZgtrcA0DViolraE2kbgMAg
 FWlVF3J4QG7BqOpGUK+bbXpsufE/4a6s6bNHpnV55S/F7akzQLd8uLrfyED1rzEUNiwC
 E+rCEt9hsTLAkRiTQ+KH8DFdsT0qq9QFSVVQDIVksMFqpomyXiICnh8Xj5ONdoVjqN6B
 n67Rl+2LVa4nqrBmhMV2UTkuKix2+J48uRqZ/ND+XY9MXUSlFR6tLE6zYjHi/Hpdak+y kg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 375wfspu3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 06:05:38 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 129Ax1WE004220;
        Tue, 9 Mar 2021 11:05:36 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3741c89dd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 11:05:36 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 129B5Xj048890204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Mar 2021 11:05:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93F814C046;
        Tue,  9 Mar 2021 11:05:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49F224C04A;
        Tue,  9 Mar 2021 11:05:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Mar 2021 11:05:33 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] tool/perf: Perf build fails on 5.12.0rc2 on s390
Date:   Tue,  9 Mar 2021 12:04:47 +0100
Message-Id: <20210309110447.834292-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-09_09:2021-03-08,2021-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103090053
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf build fails on 5.12.0rc2 on s390 with this error message:

util/synthetic-events.c: In function
				‘__event__synthesize_thread.part.0.isra’:
util/synthetic-events.c:787:19: error: ‘kernel_thread’ may be
    used uninitialized in this function [-Werror=maybe-uninitialized]
    787 |   if (_pid == pid && !kernel_thread) {
        |       ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~

The build succeeds using command 'make DEBUG=y'.

The variable kernel_thread is set by this function sequence:

__event__synthesize_thread()
|    defines bool kernel_thread; as local variable and calls
+--> perf_event__prepare_comm(..., &kernel_thread)
     +--> perf_event__get_comm_ids(..., bool *kernel);
          On return of this function variable kernel is always
          set to true of false.

To prevent this compile error, assign variable kernel_thread
a value when it is defined.

Output after:
[root@m35lp76 perf]# make  util/synthetic-events.o
....
 CC       util/synthetic-events.o
[root@m35lp76 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/synthetic-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index b698046ec2db..5dd451695f33 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -758,7 +758,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 	for (i = 0; i < n; i++) {
 		char *end;
 		pid_t _pid;
-		bool kernel_thread;
+		bool kernel_thread = false;
 
 		_pid = strtol(dirent[i]->d_name, &end, 10);
 		if (*end)
-- 
2.29.2

