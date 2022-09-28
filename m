Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AB1C04A95
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Sep 2022 04:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiI1Ewq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Sep 2022 00:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiI1Ewo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Sep 2022 00:52:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948D710B22D
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Sep 2022 21:52:43 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28S3o4qG027960;
        Wed, 28 Sep 2022 04:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=/eSAQQjswKtse+6k//YKOJY0V/etZQ8IbAI9tPGgfsw=;
 b=H7LzCtppqmPtSfnN+w99ZClCJ8P8hYM7skvTvTEyBMFbg1lqHB8MxyyBabQplmF9nc30
 uTuej39/LcDSaG7473PyUFLenrG13ksojDuZp1GprZvVznD97QG+Q8Z+q3otUh0Y/aB1
 A8ElQl6bgQWTistcL3vlZbBtrcLT+YsPqV1h9yMwQ4q/7XHvQIvbxjfge4DTH5QKJ11F
 58NAgExX+nKD+V3mIsyeL7GFLptlDCihGBCYw15bHd1OQ23HhgA0UmvjMpUXi5rZmpAP
 TGNJAsujziS+6NJVzaarql76sgSRw3j7v4xu3fFgIr1nsvAYtKxZO64dDzqLvzcpqLy/ rg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jveqah38w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 04:52:28 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28S4oJAq003376;
        Wed, 28 Sep 2022 04:52:26 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3jssh8uh7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 04:52:26 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28S4m8kq47186274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Sep 2022 04:48:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0313942041;
        Wed, 28 Sep 2022 04:52:23 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 932F04203F;
        Wed, 28 Sep 2022 04:52:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.45.125])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Sep 2022 04:52:20 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, mpe@ellerman.id.au
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH] tools/perf/tests: Update is_ignored_symbol function in vmlinux-kallsyms test
Date:   Wed, 28 Sep 2022 10:22:18 +0530
Message-Id: <20220928045218.37322-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Qvrz25_99JGpLGwxCDUmMV0AN_v9oWS6
X-Proofpoint-GUID: Qvrz25_99JGpLGwxCDUmMV0AN_v9oWS6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_02,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280027
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The testcase “vmlinux-kallsyms.c” fails in powerpc.

	vmlinux symtab matches kallsyms: FAILED!

This test look at the symbols in the vmlinux DSO
and check if we find all of them in the kallsyms dso.
But from the powerpc logs , observed that the failure
happens for:
	ERR : 0xc0000000000fe9c8: .Lmfspr_table not on kallsyms
	ERR : 0xc0000000001009c8: .Lmtspr_table not on kallsyms

These are labels ( with .L) in the source code and
has to be ignored. Reference code with .Lmtspr_table:
arch/powerpc/xmon/spr_access.S

The testcases invokes is_ignored_symbol() function to
ignore hidden symbols in the dso like local symbols. This
function is adapted from is_ignored_symbol() kernel
function in code: scripts/kallsyms.c . The kernel
function got some updates which is not reflected in
the testcase function and the new updates also handles
ignoring "labels".

Below is the changes that went in the kernel function.

	 /* Symbol names that begin with the following are ignored.*/
	 static const char * const ignored_prefixes[] = {
	 		"$",			/* local symbols for ARM, MIPS, etc. */
	-		".LASANPC",		/* s390 kasan local symbols */
	+		".L",			/* local labels, .LBB,.Ltmpxxx,.L__unnamed_xx,.LASANPC, etc. */
	 		"__crc_",		/* modversions */
	 		"__efistub_",		/* arm64 EFI stub namespace */
	-		"__kvm_nvhe_",		/* arm64 non-VHE KVM namespace */
	+		"__kvm_nvhe_$",		/* arm64 local symbols in non-VHE KVM namespace */
	+		"__kvm_nvhe_.L",	/* arm64 local symbols in non-VHE KVM namespace */
	 		"__AArch64ADRPThunk_",	/* arm64 lld */
	 		"__ARMV5PILongThunk_",	/* arm lld */
	 		"__ARMV7PILongThunk_",

This change is part of below commits and will handle the
symbols with “.L”

commit d4c858643263 ("kallsyms: ignore all local labels prefixed
by '.L'")
commit 6ccf9cb557bd ("KVM: arm64: Symbolize the nVHE HYP addresses")

Update the testcase function to include the new
changes.

Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/tests/vmlinux-kallsyms.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 4fd8d703ff19..8ab035b55875 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -43,10 +43,11 @@ static bool is_ignored_symbol(const char *name, char type)
 	/* Symbol names that begin with the following are ignored.*/
 	static const char * const ignored_prefixes[] = {
 		"$",			/* local symbols for ARM, MIPS, etc. */
-		".LASANPC",		/* s390 kasan local symbols */
+		".L",			/* local labels, .LBB,.Ltmpxxx,.L__unnamed_xx,.LASANPC, etc. */
 		"__crc_",		/* modversions */
 		"__efistub_",		/* arm64 EFI stub namespace */
-		"__kvm_nvhe_",		/* arm64 non-VHE KVM namespace */
+		"__kvm_nvhe_$",		/* arm64 local symbols in non-VHE KVM namespace */
+		"__kvm_nvhe_.L",	/* arm64 local symbols in non-VHE KVM namespace */
 		"__AArch64ADRPThunk_",	/* arm64 lld */
 		"__ARMV5PILongThunk_",	/* arm lld */
 		"__ARMV7PILongThunk_",
-- 
2.31.1

