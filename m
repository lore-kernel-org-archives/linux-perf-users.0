Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5160BEE021D
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Sep 2023 05:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjIOFYj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Sep 2023 01:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjIOFYi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Sep 2023 01:24:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051BF2700
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Sep 2023 22:24:32 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F5MRBw023085;
        Fri, 15 Sep 2023 05:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=cfBPA848T/IY3A/noQsnkhS8n+0MNu1HCdw0fmFqSbA=;
 b=LG57fO6jlcN7GT+rMiwvfvEJbmrV2LIKBGsST41g6qf+42abmoZr/9gbJax/0DGkQxYs
 PvRzpQP1bjW+tpv0q8TGhR8UIiNoBwLVjBJXYc2DQ7hlDsB7MKk1UXi/0MEiAmY+SoQ+
 /alAxVoYTx4R3n2pLmwRh8Z6+0ACZR+Z6JOAxLL2BqVG2cWR/oaSSkqAfeAQzSc3Sn4J
 PCPLm3xSspslbJxe0MIpCda8131RmEpOUY/JbKvK+dvJPJhea8qVUi50H4DzSY4Vrf/H
 wqBg8QxkOTWzR3/mlidadT61nuh7f2eXGESZ8sWpuGymy0jYPLlbHkoFLhlaIuFZNVaV 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4h2m01ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 05:24:25 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38F5O0gl027554;
        Fri, 15 Sep 2023 05:24:25 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4h2m01ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 05:24:25 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38F4UjF8024080;
        Fri, 15 Sep 2023 05:24:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t131trw73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 05:24:24 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38F5OLDd18416340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 05:24:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97F0420049;
        Fri, 15 Sep 2023 05:24:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4425520040;
        Fri, 15 Sep 2023 05:24:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.67.213])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 15 Sep 2023 05:24:19 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH V3 2/2] tools/perf/tests: Fix object code reading to skip address that falls out of text section
Date:   Fri, 15 Sep 2023 10:54:12 +0530
Message-Id: <20230915052412.2643-2-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230915052412.2643-1-atrajeev@linux.vnet.ibm.com>
References: <20230915052412.2643-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d4QBI_vr_J4hKVNmhc9vmy6-PYjmlhJq
X-Proofpoint-ORIG-GUID: LeZcuz2H8-rGGstyn9bGuLS0oErQ3mHp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_04,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150044
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The testcase "Object code reading" fails in somecases
for "fs_something" sub test as below:

    Reading object code for memory address: 0xc008000007f0142c
    File is: /lib/modules/6.5.0-rc3+/kernel/fs/xfs/xfs.ko
    On file address is: 0x1114cc
    Objdump command is: objdump -z -d --start-address=0x11142c --stop-address=0x1114ac /lib/modules/6.5.0-rc3+/kernel/fs/xfs/xfs.ko
    objdump read too few bytes: 128
    test child finished with -1

This can alo be reproduced when running perf record with
workload that exercises fs_something() code. In the test
setup, this is exercising xfs code since root is xfs.

    # perf record ./a.out
    # perf report -v |grep "xfs.ko"
      0.76% a.out /lib/modules/6.5.0-rc3+/kernel/fs/xfs/xfs.ko  0xc008000007de5efc B [k] xlog_cil_commit
      0.74% a.out  /lib/modules/6.5.0-rc3+/kernel/fs/xfs/xfs.ko  0xc008000007d5ae18 B [k] xfs_btree_key_offset
      0.74% a.out  /lib/modules/6.5.0-rc3+/kernel/fs/xfs/xfs.ko  0xc008000007e11fd4 B [k] 0x0000000000112074

Here addr "0xc008000007e11fd4" is not resolved. since this is a
kernel module, its offset is from the DSO. Xfs module is loaded
at 0xc008000007d00000

   # cat /proc/modules | grep xfs
    xfs 2228224 3 - Live 0xc008000007d00000

And size is 0x220000. So its loaded between  0xc008000007d00000
and 0xc008000007f20000. From objdump, text section is:
    text 0010f7bc  0000000000000000 0000000000000000 000000a0 2**4

Hence perf captured ip maps to 0x112074 which is:
( ip - start of module ) + a0

This offset 0x112074 falls out .text section which is up to 0x10f7bc
In this case for module, the address 0xc008000007e11fd4 is pointing
to stub instructions. This address range represents the module stubs
which is allocated on module load and hence is not part of DSO offset.

To address this issue in "object code reading", skip the sample if
address falls out of text section and is within the module end.
Use the "text_end" member of "struct dso" to do this check.

To address this issue in "perf report", exploring an option of
having stubs range as part of the /proc/kallsyms, so that perf
report can resolve addresses in stubs range

However this patch uses text_end to skip the stub range for
Object code reading testcase.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Tested-by: Disha Goel<disgoel@linux.ibm.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
Changelog:
 v2 -> v3:
 Used strtailcmp in comparison for module check and added Reviewed-by
 from Adrian, Tested-by from Disha.

 v1 -> v2:
 Updated comment to add description on which arch has stub and
 reason for skipping as suggested by Adrian

 tools/perf/tests/code-reading.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index ed3815163d1b..45334d26058e 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -269,6 +269,16 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 	if (addr + len > map__end(al.map))
 		len = map__end(al.map) - addr;
 
+	/*
+	 * Some architectures (ex: powerpc) have stubs (trampolines) in kernel
+	 * modules to manage long jumps. Check if the ip offset falls in stubs
+	 * sections for kernel modules. And skip module address after text end
+	 */
+	if (!strtailcmp(dso->long_name, ".ko") && al.addr > dso->text_end) {
+			pr_debug("skipping the module address %#"PRIx64" after text end\n", al.addr);
+			goto out;
+	}
+
 	/* Read the object code using perf */
 	ret_len = dso__data_read_offset(dso, maps__machine(thread__maps(thread)),
 					al.addr, buf1, len);
-- 
2.31.1

