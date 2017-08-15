From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCHv2] perf bpf: Fix endianness problem when loading
 parameters in prologue
Date: Tue, 15 Aug 2017 08:42:08 +0200
Message-ID: <54005fd5-de74-e34e-5ea7-86aab759a63d@linux.vnet.ibm.com>
References: <20170814114644.82526-1-tmricht@linux.vnet.ibm.com>
 <20170814163915.GB4114@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752167AbdHOGmQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Aug 2017 02:42:16 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v7F6d3Hh123984
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Aug 2017 02:42:16 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2cbmww7u1u-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Aug 2017 02:42:15 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Tue, 15 Aug 2017 07:42:13 +0100
In-Reply-To: <20170814163915.GB4114@kernel.org>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: wangnan0@huawei.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, brueckner@linux.vnet.ibm.com

On 08/14/2017 06:39 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Aug 14, 2017 at 01:46:44PM +0200, Thomas Richter escreveu:
>> Perf BPF prologue generator unconditionally fetches 8 bytes for function
>> parameters, which causes problem on big endian machine. Thomas gives a
>> detail analysis for this problem:
>>
>>  http://lkml.kernel.org/r/968ebda5-abe4-8830-8d69-49f62529d151@linux.vnet.ibm.com
>>
>> This patch parses the type of each argument and converts data from
>> memory to expected type.
>>
>> Now the test runs successfully on 4.13.0-rc5:
>> [root@s8360046 perf]# ./perf test  bpf
>> 38: BPF filter                                 :
>> 38.1: Basic BPF filtering                      : Ok
>> 38.2: BPF pinning                              : Ok
>> 38.3: BPF prologue generation                  : Ok
>> 38.4: BPF relocation checker                   : Ok
>> [root@s8360046 perf]#
>>
>> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
>> Signed-off-by: Wang Nan <wangnan0@huawei.com>
>> Acked-by: Wang Nan <wangnan0@huawei.com>
>> Tested-by: Wang Nan <wangnan0@huawei.com>
> 
> 
> That is strange, who is the author of the patch? Also I think Tested-by
> is enough, being an even stronger form of Acked-by?
> 
> But then you also have Signed-off-by: Wang in there...
> 
> From Documentation/process/submitting-patches.rst:
> 
> ---------
> 
> 12) When to use Acked-by: and Cc:
> ---------------------------------
> 
> The Signed-off-by: tag indicates that the signer was involved in the
> development of the patch, or that he/she was in the patch's delivery path.
> 
> If a person was not directly involved in the preparation or handling of a
> patch but wishes to signify and record their approval of it then they can
> ask to have an Acked-by: line added to the patch's changelog.
> 
> Acked-by: is often used by the maintainer of the affected code when that
> maintainer neither contributed to nor forwarded the patch.
> 
> ------------------
> 
> If Wang wrote the original patch and you made it better working together
> with him, probably having both of you in Signed-off-by lines should be
> enough?
> 
> - Arnaldo
> 

Ok, my fault then.
Wang wrote to patch in the first place, I just fixed one line.
Should I resend the patch and delete the Acked-by/Tested-by lines
in the commit message?

Thanks

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
