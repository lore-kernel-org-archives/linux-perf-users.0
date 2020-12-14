Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCDFC4361B
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Dec 2020 16:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A28422286
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Dec 2020 16:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440056AbgLNQbn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Dec 2020 11:31:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732019AbgLNQbd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Dec 2020 11:31:33 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BEG40gx121385
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Dec 2020 11:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : cc : from : subject
 : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=yPdvSFYhobH9KUkaQsUdBORo6RLqfUB8+5QDKeiwzhk=;
 b=GzSu7qawiGJVfCg68w6C8rBRU+ubjXd8Hx/X5AJrRvILxPurvb26CESrz2Oa1ybnBDCF
 ron2J3Z6vU/V0fY7GvVpLm/la4oMOo4hqnDkbLXk7sI3/cg7WOGgCWLScrFr+E1ORLCP
 ajRSuedWyVJPCckQXFXLmzl2u9YXsSl/bzeqd3Y5Tmtzb0GdaOXvY4JwyC8lNKrWeR1d
 fwhgtA5fEOoIbdZuQPtI6igXuPYdsdxW9DLiDFV6EqFAzgOfhApLjSUa1kqu/zpbmtQb
 85pD6OrGiHa8JsrP9Xx0vf3GMRYUIwQut228v2KUMybayHJBIPsu9agYauSFMyGMumpF 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35eag1tuy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Dec 2020 11:30:52 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BEG4GD3123245
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Dec 2020 11:30:52 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35eag1tuxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Dec 2020 11:30:52 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BEGMWjV001624;
        Mon, 14 Dec 2020 16:30:50 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 35cng82bv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Dec 2020 16:30:49 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BEGUkoC23462292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Dec 2020 16:30:46 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B688E52059;
        Mon, 14 Dec 2020 16:30:46 +0000 (GMT)
Received: from li-e35baacc-2106-11b2-a85c-8f97eb669a6e.ibm.com (unknown [9.145.5.84])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8888F52057;
        Mon, 14 Dec 2020 16:30:46 +0000 (GMT)
To:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo de Melo <acme@redhat.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Subject: perf test 42 failure on x86
Organization: IBM
Message-ID: <18a7ad32-1da7-f744-411d-d08ff4dfa91a@linux.ibm.com>
Date:   Mon, 14 Dec 2020 17:30:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-14_06:2020-12-11,2020-12-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012140108
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

I just installed Fedora 33 and its latest kernel on my x86_64 virtual machine and
ran into a perf test issue:

[root@f33 ~]# uname -a
Linux f33 5.9.13-200.fc33.x86_64 #1 SMP Tue Dec 8 15:42:52 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
[root@f33 ~]#[root@f33 ~]# perf test -F 42
42: BPF filter                                            :
42.1: Basic BPF filtering                                 : Ok
42.2: BPF pinning                                         : Ok
42.3: BPF prologue generation                             : Ok
42.4: BPF relocation checker                              : FAILED!
[root@f33 ~]# 

The last test fails due to unexpected success:
[root@f33 ~]# perf test -v -F 42
42: BPF filter                                            :
42.1: Basic BPF filtering                                 :
--- start ---
....
libbpf: skip section(9) .eh_frame
libbpf: section(10) .rel.eh_frame, size 16, link 12, flags 0, type=9
libbpf: skip relo .rel.eh_frame(10) for section(9)
libbpf: section(11) .llvm_addrsig, size 5, link 12, flags 80000000, type=1879002115
libbpf: skip section(11) .llvm_addrsig
libbpf: section(12) .symtab, size 192, link 1, flags 0, type=2
libbpf: looking for externs among 8 symbols...
libbpf: collected 0 externs total
libbpf: maps in [bpf_relocation_test]: 1 maps in 16 bytes
libbpf: map 'my_table' (legacy): at sec_idx 5, offset 0.
libbpf: map 6 is "my_table"
libbpf: map '_bpf_rel.bss' (global data): at sec_idx 6, offset 0, flags 400.
libbpf: map 1 is "_bpf_rel.bss"
libbpf: collecting relocating info for: 'func=sys_write'
libbpf: relo for shdr 6, symb 7, value 0, type 1, bind 1, name 26 ('this_is_a_global_val'), insn 7
libbpf: found data map 1 (_bpf_rel.bss, sec 6, off 0) for insn 7
Success unexpectedly: libbpf error when dealing with relocation
---- end ----
BPF filter subtest 4: FAILED!
[root@f33 ~]#

There is success when failure is expected. Has anybody already started to look into this?
--

Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
