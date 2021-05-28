Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BAAC4708C
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 May 2021 10:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D012613B5
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 May 2021 10:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbhE1Kui (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 May 2021 06:50:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236170AbhE1Kui (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 May 2021 06:50:38 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14SAY5wY080296;
        Fri, 28 May 2021 06:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : from : subject :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=EukoXB/XzCyRGHdO4K0WB6PY7zDobSjZDKpDUxwnaIA=;
 b=le7ik5rAr9PCfCBCxKrBtycmljewK831t+E2VgrQ3qF6d8//dizNpWiq8YL0O307+/tQ
 aQP9DzjZp6Zo8Ak0C7xerSlGtgF2/KIdIU2CQ+FHJX64AQdDp/8M5u1H2Tb2RBvDN3Ey
 Y/ZfZUcQGnHfO/Ygn7DtzDOPAQd6KuDluH1BN4g24Uek0FNBK32ow/M9RNOy6LSQZuQ5
 dgfpLkxI5lPSW+QEw+I45k0myQDJpbJuXNf7vJPl/5Ubf/vfUyUelS+M0ESUuMmHQtYX
 o3c7kgxpvEL/a8DRlpwJLxXwr18LJDa3NS7HmWH4iiDP/JsUDdRcVNSWFJe60lBKK7kM pw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38tsh920qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 06:49:02 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14SAlm9H008728;
        Fri, 28 May 2021 10:49:00 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 38sba2sfnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 10:49:00 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14SAmvH923331106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 10:48:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30FB9AE056;
        Fri, 28 May 2021 10:48:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08846AE04D;
        Fri, 28 May 2021 10:48:57 +0000 (GMT)
Received: from li-e35baacc-2106-11b2-a85c-8f97eb669a6e.ibm.com (unknown [9.145.148.193])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 May 2021 10:48:56 +0000 (GMT)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Subject: perf test 40 Basic BPF llvm compile dumps core (x86 and s390)
Organization: IBM
Message-ID: <f2308775-2a07-ea63-c741-50ab98eafc2c@linux.ibm.com>
Date:   Fri, 28 May 2021 12:48:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bwH9JSfTL-qA-FIXQJlM87ttgguAsTks
X-Proofpoint-GUID: bwH9JSfTL-qA-FIXQJlM87ttgguAsTks
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-28_04:2021-05-27,2021-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105280069
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

I noticed perf test 40.1 dumps core on 5.13.0rc2 and rc3:

[root@f34 perf]# ./perf test -F 40
40: LLVM search and compile                                         :
40.1: Basic BPF llvm compile                                        :
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping relo section(9) .rel.eh_frame for section(8) .eh_frame
Segmentation fault (core dumped)
[root@f34 perf]#

The root cause is a NULL pointer reference in function btf__get_nr_types()
as can be seen with gdb:

Breakpoint 1, 0x000000000065f4b1 in btf__get_nr_types
     (btf=btf@entry=0x0) at btf.c:425
425		return btf->start_id + btf->nr_types - 1;

This is the same function and reason why test case 42.1 Basic BPF filtering
fails and dumps core too.

The call chain is:
(gdb) where
 #0  0x000000000065f4b1 in btf__get_nr_types (btf=btf@entry=0x0) at btf.c:425
 #1  btf__find_by_name_kind (btf=btf@entry=0x0,
		type_name=type_name@entry=0x928ab2 ".ksyms",
		kind=kind@entry=15) at btf.c:696
 #2  0x00000000006527fe in add_dummy_ksym_var (btf=0x0) at libbpf.c:3219
 #3  bpf_object__collect_externs (obj=0xd0ea20) at libbpf.c:3266
 #4  __bpf_object__open (path=<optimized out>, path@entry=0x0,
		obj_buf=obj_buf@entry=0xd12fa0,
		obj_buf_sz=obj_buf_sz@entry=1520,
    		opts=opts@entry=0x7fffffffdb30) at libbpf.c:7372
 #5  0x0000000000655415 in __bpf_object__open (opts=0x7fffffffdb30,
		obj_buf_sz=1520, obj_buf=0xd12fa0, path=0x0) at libbpf.c:7337
 #6  bpf_object__open_mem (opts=0x7fffffffdb30, obj_buf_sz=1520,
		obj_buf=0xd12fa0) at libbpf.c:7454
 #7  bpf_object__open_mem (opts=0x7fffffffdb30, obj_buf_sz=1520,
		obj_buf=0xd12fa0) at libbpf.c:7448
 #8  bpf_object__open_buffer (obj_buf=0xd12fa0, obj_buf_sz=1520,
		name=<optimized out>) at libbpf.c:7471
 #9  0x00000000004c8c6e in test__bpf_parsing (obj_buf=0xd12fa0,
		obj_buf_sz=1520) at tests/llvm.c:16
 #10 0x00000000004c8fe2 in test__llvm (test=0xac7d20 <generic_tests+2496>,
		subtest=0) at tests/llvm.c:142
...

I have no knowledge about BPF and why the core dump happens. Before
I start digging into this has anybody some hints on where to look?

Thanks a lot.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
