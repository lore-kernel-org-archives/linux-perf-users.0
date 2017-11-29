From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf annotate: Fix objdump comment parsing for Intel mov
 dissassembly
Date: Wed, 29 Nov 2017 20:52:13 +0530
Message-ID: <9c33e7e2-9101-27fa-d1f4-cbdb4777fcc5@linux.vnet.ibm.com>
References: <20171128075632.72182-1-tmricht@linux.vnet.ibm.com>
 <69859e3b-cb22-a536-79ca-ffc44c3f86a8@linux.vnet.ibm.com>
 <d2e2818d-6d49-c208-68f5-8cd28034bbfc@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52528 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932903AbdK2PVt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Nov 2017 10:21:49 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vATFKd8R099899
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2017 10:21:48 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ehvqrh05v-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2017 10:21:47 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <ravi.bangoria@linux.vnet.ibm.com>;
        Wed, 29 Nov 2017 15:21:45 -0000
In-Reply-To: <d2e2818d-6d49-c208-68f5-8cd28034bbfc@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, acme@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>



On 11/29/2017 08:33 PM, Thomas-Mich Richter wrote:
> On 11/29/2017 02:24 PM, Ravi Bangoria wrote:
>>
>> On 11/28/2017 01:26 PM, Thomas Richter wrote:
>>> The command 'perf annotate' parses the output of objdump and also
>>> investigates the comments produced by objdump. For example the
>>> output of objdump produces (on x86):
>>>
>>> 23eee:  4c 8b 3d 13 01 21 00 mov 0x210113(%rip),%r15
>>>                                 # 234008 <stderr@@GLIBC_2.2.5+0x9a8>
>>>
>>> and the function mov__parse() is called to investigate the complete
>>> line. Mov__parse() breaks this line into several parts and finally
>>> calls function comment__symbol() to parse the data after the comment
>>> character '#'. Comment__symbol() expects a hexadecimal address followed
>>> by a symbol in '<' and '>' brackets.
>>>
>>> However the 2nd parameter given to function comment__symbol()
>>> always points to the comment character '#'. The address parsing
>>> always returns 0 because the character '#' is not a digit and
>>> strtoull() fails without being noticed.
>>>
>>> Fix this by advancing the second parameter to function comment__symbol()
>>> by one byte before invocation and add an error check after strtoull()
>>> has been called.
>> Yeah, looks like it fails to get correct value in 'addrp'.
>>
>> Can you please show the difference in perf annotate output before
>> and after patch.
>>
>> Thanks,
>> Ravi
>>
>
> There is no difference in output of --stdio. The adress value is not
> read and remains 0x0 in ops->source.addr or ops->target.addr.
> That is not visible because in function mov__scnprintf() that wrong
> address is not printed:
>
> static int mov__scnprintf(struct ins *ins, char *bf, size_t size,
>                            struct ins_operands *ops)
> {
>         return scnprintf(bf, size, "%-6.6s %s,%s", ins->name,
>                          ops->source.name ?: ops->source.raw,
>                          ops->target.name ?: ops->target.raw);
> }

Looks good.  Ack-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Thanks,
Ravi
