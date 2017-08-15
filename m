From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: [PATCHv2] perf bpf: Fix endianness problem when loading
 parameters in prologue
Date: Tue, 15 Aug 2017 16:47:26 +0800
Message-ID: <0b2679cb-640f-35ec-be7c-bf13f4225173@huawei.com>
References: <20170814114644.82526-1-tmricht@linux.vnet.ibm.com>
 <20170814163915.GB4114@kernel.org>
 <54005fd5-de74-e34e-5ea7-86aab759a63d@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54005fd5-de74-e34e-5ea7-86aab759a63d@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, brueckner@linux.vnet.ibm.com
List-Id: linux-perf-users.vger.kernel.org



On 2017/8/15 14:42, Thomas-Mich Richter wrote:
> On 08/14/2017 06:39 PM, Arnaldo Carvalho de Melo wrote:
>> Em Mon, Aug 14, 2017 at 01:46:44PM +0200, Thomas Richter escreveu:
>>> Perf BPF prologue generator unconditionally fetches 8 bytes for function
>>> parameters, which causes problem on big endian machine. Thomas gives a
>>> detail analysis for this problem:
>>>
>>>   http://lkml.kernel.org/r/968ebda5-abe4-8830-8d69-49f62529d151@linux.vnet.ibm.com
>>>
>>> This patch parses the type of each argument and converts data from
>>> memory to expected type.
>>>
>>> Now the test runs successfully on 4.13.0-rc5:
>>> [root@s8360046 perf]# ./perf test  bpf
>>> 38: BPF filter                                 :
>>> 38.1: Basic BPF filtering                      : Ok
>>> 38.2: BPF pinning                              : Ok
>>> 38.3: BPF prologue generation                  : Ok
>>> 38.4: BPF relocation checker                   : Ok
>>> [root@s8360046 perf]#
>>>
>>> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
>>> Signed-off-by: Wang Nan <wangnan0@huawei.com>
>>> Acked-by: Wang Nan <wangnan0@huawei.com>
>>> Tested-by: Wang Nan <wangnan0@huawei.com>
>>
>> That is strange, who is the author of the patch? Also I think Tested-by
>> is enough, being an even stronger form of Acked-by?
>>
>> But then you also have Signed-off-by: Wang in there...
>>
>>  From Documentation/process/submitting-patches.rst:
>>
>> ---------
>>
>> 12) When to use Acked-by: and Cc:
>> ---------------------------------
>>
>> The Signed-off-by: tag indicates that the signer was involved in the
>> development of the patch, or that he/she was in the patch's delivery path.
>>
>> If a person was not directly involved in the preparation or handling of a
>> patch but wishes to signify and record their approval of it then they can
>> ask to have an Acked-by: line added to the patch's changelog.
>>
>> Acked-by: is often used by the maintainer of the affected code when that
>> maintainer neither contributed to nor forwarded the patch.
>>
>> ------------------
>>
>> If Wang wrote the original patch and you made it better working together
>> with him, probably having both of you in Signed-off-by lines should be
>> enough?
>>
>> - Arnaldo
>>
> Ok, my fault then.
> Wang wrote to patch in the first place, I just fixed one line.
> Should I resend the patch and delete the Acked-by/Tested-by lines
> in the commit message?

Yes, please resend it.

> Thanks
>
