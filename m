From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] perf record: wrong size in perf_record_mmap for last
 kernel module
Date: Thu, 3 Aug 2017 11:41:02 +0200
Message-ID: <7e74f3d2-204d-0067-4914-1dbba3f02db2@linux.vnet.ibm.com>
References: <20170724143514.55574-1-tmricht@linux.vnet.ibm.com>
 <20170724143514.55574-2-tmricht@linux.vnet.ibm.com>
 <20170724182007.GY4134@kernel.org> <20170802185047.GL12201@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751870AbdHCJlK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Aug 2017 05:41:10 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v739dAMM019921
        for <linux-perf-users@vger.kernel.org>; Thu, 3 Aug 2017 05:41:10 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2c3sntfcgc-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Aug 2017 05:41:09 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Thu, 3 Aug 2017 10:41:07 +0100
In-Reply-To: <20170802185047.GL12201@kernel.org>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: brueckner@linux.vnet.ibm.com, zvonko.kosic@de.ibm.com, linux-perf-users@vger.kernel.org

On 08/02/2017 08:50 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jul 24, 2017 at 03:20:07PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Mon, Jul 24, 2017 at 04:35:14PM +0200, Thomas Richter escreveu:
>>> +++ b/tools/perf/util/machine.c
>>> @@ -20,6 +20,7 @@
>>> +#include <sys/user.h>
> 
> no need for this header, see below.
> 
>>> -static int machine__create_module(void *arg, const char *name, u64 start)
>>> +static int machine__create_module(void *arg, const char *name, u64 start, u64 size)
>>>  {
>>> @@ -1148,6 +1149,7 @@ static int machine__create_module(void *arg, const char *name, u64 start)
>>>  	map = machine__findnew_module_map(machine, start, name);
>>>  	if (map == NULL)
>>>  		return -1;
>>> +	map->end = roundup(start + size, PAGE_SIZE);
> 
> We have the page_size variable, that gets its value at:
> 
> tools/perf/perf.c:	page_size = sysconf(_SC_PAGE_SIZE);
> 
> always available, determined at run time.
> 
> Also, what is the reason for the roundup?
> 

Ok I missed that page_size and will use it.
The idea for the roundup to page size is the assumption that the kernel
allocates full pages for memory to load modules. The size filed in the /proc/modules
output refers to the module size in bytes.

If this is wrong we can omit the roundup.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
