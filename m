Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C43C433DB
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Mar 2021 15:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8997F64F33
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Mar 2021 15:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhCJPUs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Mar 2021 10:20:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233188AbhCJPUZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Mar 2021 10:20:25 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12AF7QK5140905;
        Wed, 10 Mar 2021 10:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : cc : from : subject
 : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=7PLLG7wkEJSL5gDT/Zi2hWogyGpgohBrWzV7LNTz6GU=;
 b=sQfLf6yo6KDMHaHi0fATnuA94J0i5g4jw7p35U20C4V5jS6JYxoT0B1Zr4INossr0Gwf
 9PYMlcFW8FDercl+9ly3U+nguPHjPp33rnwDfG3k7Q/2A8VNNHguhG+HVK5iLiG/uqts
 m+0BETxr8WVCLpiaokXdVlw5/kfgRH1QswS66tV9ibQKqCaIqZ3U7nkcB/h9fYtKULhH
 OTtp6VHMQSbZbvZiQN7Avo8gmuBQzFU1f8oNvmpWrcEtpYZJ/b6Swiyd74ZvYUCXbl8h
 fQxn2Em4Ir3uapUzn/fw4cuuRb2DX3py6Sz6zQHXC4p5/3t0pFQnAZOQEd6WQX84efK/ aQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 376tes3jfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 10:20:00 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12AFC9Ws005580;
        Wed, 10 Mar 2021 15:19:57 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 376mb0rjdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 15:19:57 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12AFJtBr42795432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 15:19:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 749204C050;
        Wed, 10 Mar 2021 15:19:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4766E4C06E;
        Wed, 10 Mar 2021 15:19:55 +0000 (GMT)
Received: from li-e35baacc-2106-11b2-a85c-8f97eb669a6e.ibm.com (unknown [9.145.75.163])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Mar 2021 15:19:55 +0000 (GMT)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>, wangnan0@huawei.com
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        daniel@iogearbox.net, iii@linux.ibm.com
From:   Thomas Richter <tmricht@linux.ibm.com>
Subject: Perf test 42.2 (BPF relocation checker) failure
Organization: IBM
Message-ID: <34a79d0b-43ae-fbf8-9510-41930abc1770@linux.ibm.com>
Date:   Wed, 10 Mar 2021 16:19:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_09:2021-03-10,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=999 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100076
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi all


I observe that the perf test 42.4 (BPF relocation checker)
fails for quite some time now on s390 and on x86.
I have not tested other architectures.

I investigated this and Ilya found a commit in the kernel, released with
version 5.10:

commit d859900c4c56 ("bpf, libbpf: support global data/bss/rodata sections")

Bpf code relocation with global variables is now supported.

The test 42.4 returns FAILED, because it assumes in function __test_bpf()
that the function call to prepare_bpf() returns NULL. But with above
kernel commit it returns a valid object pointer.

My question is:
Should we keep this test? It looks like this test is now obsolete, since
the kernel bpf code now accepts global variables.

Should we make the test work? Then we have to change the bpf code.
I am no BPF export but Ilya explained it to me:

The BPF-verifier in the kernel rejects the BPF byte code.
A wrong map pointer is passed to bpf_map_update_elem. Maps should be
loaded by file descriptors (there is a special opcode for that).
In this case they just take a global var address as a map.

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
7: (18) r1 = 0x3800066e000
9: (b7) r4 = 0
10: (85) call bpf_map_update_elem#2
R1 type=map_value expected=map_ptr  <<<-----------BPF verifier error reason
processed 10 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

libbpf: -- END LOG --
libbpf: failed to load program 'bpf_func__ksys_write' --> I changed this to get it to work to that point
libbpf: failed to load object '[bpf_relocation_test]'
bpf: load objects failed: err=-4007: (Kernel verifier blocks program loading)
Failed to add events selected by BPF


So what direction should we proceed? Remove the test or make it work somehow?

Thanks a lot.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
