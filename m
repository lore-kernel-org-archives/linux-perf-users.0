From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] perf record: wrong size in perf_record_mmap for last
 kernel module
Date: Mon, 7 Aug 2017 09:26:14 +0200
Message-ID: <d0db66fd-32ae-f644-b3e1-bb12776a793e@linux.vnet.ibm.com>
References: <20170724143514.55574-1-tmricht@linux.vnet.ibm.com>
 <20170724143514.55574-2-tmricht@linux.vnet.ibm.com>
 <20170724182007.GY4134@kernel.org> <20170802185047.GL12201@kernel.org>
 <7e74f3d2-204d-0067-4914-1dbba3f02db2@linux.vnet.ibm.com>
 <20170804170614.GP12201@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752122AbdHGH0V (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Aug 2017 03:26:21 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v777OKDp138020
        for <linux-perf-users@vger.kernel.org>; Mon, 7 Aug 2017 03:26:21 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2c6k7y9g59-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Aug 2017 03:26:20 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Mon, 7 Aug 2017 08:26:18 +0100
In-Reply-To: <20170804170614.GP12201@kernel.org>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: brueckner@linux.vnet.ibm.com, zvonko.kosic@de.ibm.com, linux-perf-users@vger.kernel.org

On 08/04/2017 07:06 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Aug 03, 2017 at 11:41:02AM +0200, Thomas-Mich Richter escreveu:
>> On 08/02/2017 08:50 PM, Arnaldo Carvalho de Melo wrote:
>>> Em Mon, Jul 24, 2017 at 03:20:07PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>> Em Mon, Jul 24, 2017 at 04:35:14PM +0200, Thomas Richter escreveu:
>>>>> +++ b/tools/perf/util/machine.c
>>>>> @@ -20,6 +20,7 @@
>>>>> +#include <sys/user.h>
>>>
>>> no need for this header, see below.
>>>
>>>>> -static int machine__create_module(void *arg, const char *name, u64 start)
>>>>> +static int machine__create_module(void *arg, const char *name, u64 start, u64 size)
>>>>>  {
>>>>> @@ -1148,6 +1149,7 @@ static int machine__create_module(void *arg, const char *name, u64 start)
>>>>>  	map = machine__findnew_module_map(machine, start, name);
>>>>>  	if (map == NULL)
>>>>>  		return -1;
>>>>> +	map->end = roundup(start + size, PAGE_SIZE);
>>>
>>> We have the page_size variable, that gets its value at:
>>>
>>> tools/perf/perf.c:	page_size = sysconf(_SC_PAGE_SIZE);
>>>
>>> always available, determined at run time.
>>>
>>> Also, what is the reason for the roundup?
>>>
>>
>> Ok I missed that page_size and will use it.
>> The idea for the roundup to page size is the assumption that the kernel
>> allocates full pages for memory to load modules. The size filed in the /proc/modules
>> output refers to the module size in bytes.
>>
>> If this is wrong we can omit the roundup.
> 
> Its not wrong, just looks unnecessary, a distraction, I'll remove it, ok?
> 
> - Arnaldo
> 

Sure go ahead.


-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
