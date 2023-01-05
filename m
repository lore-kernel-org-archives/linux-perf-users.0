Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E65FC3DA7A
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 Jan 2023 12:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjAEMFU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 5 Jan 2023 07:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjAEMFJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Jan 2023 07:05:09 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC29A559CA
        for <linux-perf-users@vger.kernel.org>; Thu,  5 Jan 2023 04:05:04 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305BwtUO030458;
        Thu, 5 Jan 2023 12:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=RkeNOhipKMcUPD8Qm3P5AwLCsoQDpwRJLYbcr4SzAZQ=;
 b=QN6kgCCIFkQenaD6iJUVi6ADgldTQLSpGThxbPLWdz25zElYpW7+B08ghYyJGaydZmwd
 VDGLdSXQT374aNCM86KHGqmgk7m4YoyZjVIotyf/vIdzS+1JU649L8iW3WukDcbO3ifC
 wqYRT+18idL4wjDDaC0tW35u2lOjQountc5O44rGEb0MN1LQ+O5KGQP5rApSel5DQMnU
 qvVxVyqPvPBkNY913d8+Tvwo8QjEbhPDTwJbbUmoeH96JW+tyYIDmUNwyGsvLE733rE0
 rItMVWhBAnX/PqZtdmNa0xARL5pf9TeyG3NNdvQ6MysPohqbCiZlAAEjm6HlOQtrYS1e yA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mwx5e85f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 12:04:47 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 305C04Qm034500;
        Thu, 5 Jan 2023 12:04:46 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mwx5e85ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 12:04:46 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3053rFJB001030;
        Thu, 5 Jan 2023 12:04:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3mtcbfeqts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 12:04:44 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 305C4ea337159366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Jan 2023 12:04:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8A752004B;
        Thu,  5 Jan 2023 12:04:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDB3020043;
        Thu,  5 Jan 2023 12:04:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.120.85])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  5 Jan 2023 12:04:37 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org
Cc:     ak@linux.intel.com, namhyung@kernel.org, irogers@google.com,
        james.clark@arm.com, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.ibm.com
Subject: [PATCH] tools/perf: Fix bpf-script-test-prologue test compile issue with clang
Date:   Thu,  5 Jan 2023 17:34:36 +0530
Message-Id: <20230105120436.92051-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7cGmRhIcY4yJog4txKJk0luZ5c_vl4K1
X-Proofpoint-GUID: yl-0TTym-C2lPItHSOUPQIVNwUecPMwK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_04,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050095
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

While running perf test for bpf, observed that "BPF prologue
generation" test case fails to compile with clang. Logs below
from powerpc:

<stdin>:33:2: error: use of undeclared identifier 'fmode_t'
        fmode_t f_mode = (fmode_t)_f_mode;
        ^
<stdin>:37:6: error: use of undeclared identifier 'f_mode'; did you mean '_f_mode'?
        if (f_mode & FMODE_WRITE)
            ^~~~~~
            _f_mode
<stdin>:30:60: note: '_f_mode' declared here
int bpf_func__null_lseek(void *ctx, int err, unsigned long _f_mode,
                                                           ^
2 errors generated.

The test code tests/bpf-script-test-prologue.c uses fmode_t.
And the error above is for "fmode_t" which is defined in
include/linux/types.h as part of kernel build directory:
"/lib/modules/<kernel_version>/build" that comes from
kernel devel [ soft link to /usr/src/<kernel_version> ].
Clang picks this header file from "-working-directory" build
option that specifies this build folder.

But the 'commit 14e4b9f4289a ("perf trace: Raw augmented
syscalls fix libbpf 1.0+ compatibility")', changed the
include directory to use: "/usr/include".  Post this change,
types.h from /usr/include/ is getting picked upwhich doesn’t
contain definition of "fmode_t" and hence fails to compile.

Compilation command before this commit:
/usr/bin/clang -D__KERNEL__ -D__NR_CPUS__=72 -DLINUX_VERSION_CODE=0x50e00 -xc  -I/root/lib/perf/include/bpf -nostdinc -I./arch/powerpc/include -I./arch/powerpc/include/generated  -I./include -I./arch/powerpc/include/uapi -I./arch/powerpc/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h  -Wno-unused-value -Wno-pointer-sign -working-directory /lib/modules/<ver>/build -c - -target bpf  -g -O2 -o -

Compilation command after this commit:
/usr/bin/clang -D__KERNEL__ -D__NR_CPUS__=72 -DLINUX_VERSION_CODE=0x50e00 -xc  -I/usr/include/ -nostdinc -I./arch/powerpc/include -I./arch/powerpc/include/generated  -I./include -I./arch/powerpc/include/uapi -I./arch/powerpc/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h  -Wno-unused-value -Wno-pointer-sign -working-directory /lib/modules/<ver>/build -c - -target bpf  -g -O2 -o -

The difference is addition of -I/usr/include/  in the first line
which is causing the error. Fix this by adding typedef for "fmode_t"
in the testcase to solve the compile issue.

Fixes: 14e4b9f4289a ("perf trace: Raw augmented syscalls fix libbpf 1.0+ compatibility")
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/tests/bpf-script-test-prologue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/bpf-script-test-prologue.c b/tools/perf/tests/bpf-script-test-prologue.c
index bd83d364cf30..91778b5c6125 100644
--- a/tools/perf/tests/bpf-script-test-prologue.c
+++ b/tools/perf/tests/bpf-script-test-prologue.c
@@ -20,6 +20,8 @@
 # undef if
 #endif
 
+typedef unsigned int __bitwise fmode_t;
+
 #define FMODE_READ		0x1
 #define FMODE_WRITE		0x2
 
-- 
2.31.1

