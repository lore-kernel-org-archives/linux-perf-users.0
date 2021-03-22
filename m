Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3743C433C1
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Mar 2021 12:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71CAD601FF
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Mar 2021 12:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhCVM4V (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 Mar 2021 08:56:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58058 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232096AbhCVMxw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Mar 2021 08:53:52 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12MCX2Eo059391;
        Mon, 22 Mar 2021 08:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=nhY1OrMRCrigr1lds+SY5qJc7Rk4K0C8GLnbR9JM3JU=;
 b=H4gI/gwLrOIAz/U/3pHSFDwpZNxSO8Cn+A/woYS4PQGMcugAlI7O0X2cyGjSKllgqXCz
 qSoDYCHux8E/r4isEJRh0A6qXqBSnKCfji94MUPdFTikwy8qwEvPoMk5hqSW6Eip7OBW
 DysETDuZiHENiHSqf/uPPtS0PrEeS/2iHf0D3OBZNhL1ZUxzK+xhst2DR7OUII5n3P1v
 Ydv8Q7ZpDcnSKbRFfcMwWNXpj+j8n0ZGqNs79rkf9NV0FvPCgizbtw1TtaC4F//dzjIn
 19yNmSRXXSRSqaxfdJvWA80HEI0QYGKOQccUK3TuFa9Z6kxeUsXqsQItBbbHXFU2adoe Ug== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37ef8b0k7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 08:53:51 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12MCgk9G018210;
        Mon, 22 Mar 2021 12:53:49 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 37d99rabjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 12:53:49 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12MCrkwS17629526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 12:53:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88CC042042;
        Mon, 22 Mar 2021 12:53:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 389254203F;
        Mon, 22 Mar 2021 12:53:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Mar 2021 12:53:46 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Fix perf test 42
Date:   Mon, 22 Mar 2021 13:53:39 +0100
Message-Id: <20210322125339.1384351-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_07:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103220091
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

For some time now the perf test 42: BPF filter returns an error
on bpf relocation subtest, at least on x86 and s390. This is caused by

commit d859900c4c56 ("bpf, libbpf: support global data/bss/rodata sections")

which introduces support for global variables in eBPF programs. At least
for global variables defined static.

Perf test 42 checks that the eBPF relocation fails when the eBPF program
contains a global variable. It returns OK when the eBPF program
could not be loaded and FAILED otherwise.

With above commit the test logic for the eBPF relocation need to change:
1. The function prepare_bpf() now always succeeds, the eBPF program
   compiled without errors and returns a valid object pointer instead of
   NULL.
2. There is no kprobe named sys_write, it now named ksys_write.
3. The function do_test() now returns TEST_FAIL because function
   parse_events_load_bpf_obj() can not execute the eBPF program. The
   eBPF verifier complains on an invalid map pointer:
      libbpf: load bpf program failed: Permission denied
      libbpf: -- BEGIN DUMP LOG ---
      libbpf:
      0: (b7) r1 = 0
      1: (63) *(u32 *)(r10 -4) = r1
      last_idx 1 first_idx 0
      regs=2 stack=0 before 0: (b7) r1 = 0
      2: (63) *(u32 *)(r10 -8) = r1
      3: (bf) r2 = r10
      4: (07) r2 += -4
      5: (bf) r3 = r10
      6: (07) r3 += -8
      7: (18) r1 = 0x380006ce000
      9: (b7) r4 = 0
      10: (85) call bpf_map_update_elem#2
      R1 type=map_value expected=map_ptr

Fix this by added logic to handle the kernel verifier return code:
1. Add function myksys_write() to cope with successful compile.
2. Use kprobe ksys_write
3. Handle eBPF verifier error.

Output after:
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
 42.4: BPF relocation checker            : Ok
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/bpf-script-test-relocation.c |  4 ++--
 tools/perf/tests/bpf.c                        | 11 +++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/bpf-script-test-relocation.c b/tools/perf/tests/bpf-script-test-relocation.c
index 74006e4b2d24..f8f8176ad4d1 100644
--- a/tools/perf/tests/bpf-script-test-relocation.c
+++ b/tools/perf/tests/bpf-script-test-relocation.c
@@ -34,8 +34,8 @@ struct bpf_map_def SEC("maps") my_table = {
 
 int this_is_a_global_val;
 
-SEC("func=sys_write")
-int bpf_func__sys_write(void *ctx)
+SEC("func=ksys_write")
+int bpf_func__ksys_write(void *ctx)
 {
 	int key = 0;
 	int value = 0;
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index f57e075b0ed2..d60ef9472d3d 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -59,6 +59,11 @@ static int llseek_loop(void)
 
 #endif
 
+static int myksys_write(void)
+{
+	return 0;
+}
+
 static struct {
 	enum test_llvm__testcase prog_id;
 	const char *desc;
@@ -105,6 +110,7 @@ static struct {
 		.name		  = "[bpf_relocation_test]",
 		.msg_compile_fail = "fix 'perf test LLVM' first",
 		.msg_load_fail	  = "libbpf error when dealing with relocation",
+		.target_func	  = &myksys_write,
 	},
 };
 
@@ -258,6 +264,11 @@ static int __test__bpf(int idx)
 		ret = do_test(obj,
 			      bpf_testcase_table[idx].target_func,
 			      bpf_testcase_table[idx].expect_result);
+		if (bpf_testcase_table[idx].prog_id == LLVM_TESTCASE_BPF_RELOCATION
+		    && ret == TEST_FAIL) {
+			ret = TEST_OK;
+			goto out;
+		}
 		if (ret != TEST_OK)
 			goto out;
 		if (bpf_testcase_table[idx].pin) {
-- 
2.30.2

