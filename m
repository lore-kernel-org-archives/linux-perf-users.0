Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050D4C433DB
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Mar 2021 08:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D57AD619F6
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Mar 2021 08:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhCXIiN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 Mar 2021 04:38:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9426 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230259AbhCXIho (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Mar 2021 04:37:44 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12O8XMhQ092196;
        Wed, 24 Mar 2021 04:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=1OZ/fA+EBHos3tuU4pNUhXs8bbZ7Kgb6qCis80GYINI=;
 b=W/Q+0KFeyVJY1b0kuceGFIZHoqPI9tPQyX7vaDYhHq7J9rvR36mB83vAaKTAsYbgz1nJ
 3ZInvsba3J6xe4WyDhV2/4ECQ5Nhi7I9qh0Hh7FVszdbMtIUFjZkdsqu3NgARZdJr1Sa
 FoXRk+JbUoeRu/MCG8OYu5UrPDbmLCeO2/Epui5Ee6LOpW0j+GRv9l1VhVGvgZ5PuBnW
 9fYq3q4iF+cPFu4lG/9t78Q3UZfBS+C8XSJnzrtlaQl3QUBedQlQievvNnLW3ie86WEV
 OwejsoJ2X4lrJJk9JuUi+mobibS2WStSDIu4r0auWRuY1e4qrWqlaHxbi+QNE+EREM0F Qw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37g1k6rtjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 04:37:43 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12O8bFbU014695;
        Wed, 24 Mar 2021 08:37:41 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 37d99rc4ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 08:37:41 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12O8bcT740042778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 08:37:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CE0B4C04A;
        Wed, 24 Mar 2021 08:37:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E262A4C046;
        Wed, 24 Mar 2021 08:37:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Mar 2021 08:37:37 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Remove perf sub test 42.4 BPF relocation checker
Date:   Wed, 24 Mar 2021 09:37:34 +0100
Message-Id: <20210324083734.1953123-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-24_05:2021-03-24,2021-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240062
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

For some time now the perf test 42: BPF filter returns an error
on bpf relocation subtest, at least on x86 and s390. This is caused by

commit d859900c4c56 ("bpf, libbpf: support global data/bss/rodata sections")

which introduces support for global variables in eBPF programs.

Perf test 42.4 checks that the eBPF relocation fails when the eBPF program
contains a global variable. It returns OK when the eBPF program
could not be loaded and FAILED otherwise.

With above commit the test logic for the eBPF relocation is obsolete.
The loading of the eBPF now succeeds and the test always shows FAILED.

This patch removes the sub test completely.
Also a lot of eBPF program testing is done in the eBPF test suite,
it also contains tests for global variables.

Output before:
 42: BPF filter                          :
 42.1: Basic BPF filtering               : Ok
 42.2: BPF pinning                       : Ok
 42.3: BPF prologue generation           : Ok
 42.4: BPF relocation checker            : Failed
 #

Output after:
 # ./perf test -F 42
 42: BPF filter                          :
 42.1: Basic BPF filtering               : Ok
 42.2: BPF pinning                       : Ok
 42.3: BPF prologue generation           : Ok
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/bpf.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index f57e075b0ed2..c72adbd67386 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -86,7 +86,7 @@ static struct {
 		.msg_load_fail	  = "check your vmlinux setting?",
 		.target_func	  = &epoll_pwait_loop,
 		.expect_result	  = (NR_ITERS + 1) / 2,
-		.pin 		  = true,
+		.pin		  = true,
 	},
 #ifdef HAVE_BPF_PROLOGUE
 	{
@@ -99,13 +99,6 @@ static struct {
 		.expect_result	  = (NR_ITERS + 1) / 4,
 	},
 #endif
-	{
-		.prog_id	  = LLVM_TESTCASE_BPF_RELOCATION,
-		.desc		  = "BPF relocation checker",
-		.name		  = "[bpf_relocation_test]",
-		.msg_compile_fail = "fix 'perf test LLVM' first",
-		.msg_load_fail	  = "libbpf error when dealing with relocation",
-	},
 };
 
 static int do_test(struct bpf_object *obj, int (*func)(void),
-- 
2.30.2

