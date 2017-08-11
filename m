From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: perf test BPF subtest bpf-prologue test fails on s390x
Date: Fri, 11 Aug 2017 13:13:08 +0200
Message-ID: <baf74c0b-56a8-c67b-6376-e8bdebf30636@linux.vnet.ibm.com>
References: <20170810181319.GD3900@kernel.org>
 <53348602-8cff-e218-cdeb-b5504fd211e2@huawei.com>
 <968ebda5-abe4-8830-8d69-49f62529d151@linux.vnet.ibm.com>
 <4cd18c9a-7481-5bca-2d61-49e617ba2f96@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751891AbdHKLNP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Aug 2017 07:13:15 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v7BB9sb0136092
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Aug 2017 07:13:15 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2c95k7fur0-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Aug 2017 07:13:14 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Fri, 11 Aug 2017 12:13:12 +0100
In-Reply-To: <4cd18c9a-7481-5bca-2d61-49e617ba2f96@huawei.com>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Wangnan (F)" <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Zefan Li <lizefan@huawei.com>, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 08/11/2017 11:57 AM, Wangnan (F) wrote:
> 
> 
> On 2017/8/11 17:17, Thomas-Mich Richter wrote:
>> On 08/11/2017 07:19 AM, Wangnan (F) wrote:


[....]

> Your analysis is correct.
> 
>>
>> Maybe the solution is to add an endianness convertion into the gen_read_mem()
>> function.
> 
> That means alert the prologue. We can utilize the size field in BPF_LDX_MEM.
> 
> Could you please try this patch:
> 
> diff --git a/tools/perf/util/bpf-prologue.c b/tools/perf/util/bpf-prologue.c
> index 6cdbee1..aadbda4 100644
> --- a/tools/perf/util/bpf-prologue.c
> +++ b/tools/perf/util/bpf-prologue.c
> @@ -258,7 +258,7 @@ gen_prologue_slowpath(struct bpf_insn_pos *pos,
> 
>         /* Final pass: read to registers */
>         for (i = 0; i < nargs; i++)
> -               ins(BPF_LDX_MEM(BPF_DW, BPF_PROLOGUE_START_ARG_REG + i,
> +               ins(BPF_LDX_MEM(BPF_W, BPF_PROLOGUE_START_ARG_REG + i,
>                                 BPF_REG_FP, -BPF_REG_SIZE * (i + 1)), pos);
> 
>         ins(BPF_JMP_IMM(BPF_JA, BPF_REG_0, 0, JMP_TO_SUCCESS_CODE), pos);
> 
> 
> On your platform and check if the value of f_mode is correct?
> 
> NOTE: 64 bit load becomes incorrect after applying this patch. I want to make sure
> the behavior of 32 bit BPF load instruction works correct on big endian machine.
> 
> Thank you.
> 

This patch solves the issue with the first parameter. Now I see the correct
value of f_mode member of struct-file.
As you said the other loads are wrong. Here is the output of the 
trace:

           perf-13438 [000] d..2  2102.392312: : f_mode 6001f offset:0 orig:0
            perf-13438 [000] d..2  2102.392414: : f_mode 2001d offset:0 orig:0
            perf-13438 [000] d..2  2102.392440: : f_mode 2001d offset:0 orig:0
            perf-13438 [000] d..2  2102.392453: : f_mode 6001f offset:0 orig:0

PS: When I ran this test I undid the changes to tests/bpf-test-script-prologue.c.
It was in its original state when this test was executed.


-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
