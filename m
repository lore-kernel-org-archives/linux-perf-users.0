From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] perf record: wrong size in perf_record_mmap for last
 kernel module
Date: Tue, 8 Aug 2017 09:16:42 +0200
Message-ID: <d3eacb65-01ce-92b6-eff9-9c2ce54019ad@linux.vnet.ibm.com>
References: <20170724143514.55574-1-tmricht@linux.vnet.ibm.com>
 <20170724143514.55574-2-tmricht@linux.vnet.ibm.com>
 <20170724182007.GY4134@kernel.org> <20170802185047.GL12201@kernel.org>
 <7e74f3d2-204d-0067-4914-1dbba3f02db2@linux.vnet.ibm.com>
 <20170804170614.GP12201@kernel.org>
 <d0db66fd-32ae-f644-b3e1-bb12776a793e@linux.vnet.ibm.com>
 <20170807160549.GT12201@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55983 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751978AbdHHHQt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Aug 2017 03:16:49 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v787Dnw3040447
        for <linux-perf-users@vger.kernel.org>; Tue, 8 Aug 2017 03:16:49 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2c71kq18dh-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Aug 2017 03:16:49 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Tue, 8 Aug 2017 08:16:46 +0100
In-Reply-To: <20170807160549.GT12201@kernel.org>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: brueckner@linux.vnet.ibm.com, zvonko.kosic@de.ibm.com, linux-perf-users@vger.kernel.org

On 08/07/2017 06:05 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Aug 07, 2017 at 09:26:14AM +0200, Thomas-Mich Richter escreveu:
>> On 08/04/2017 07:06 PM, Arnaldo Carvalho de Melo wrote:
>>> Em Thu, Aug 03, 2017 at 11:41:02AM +0200, Thomas-Mich Richter escreveu:
>>>> The idea for the roundup to page size is the assumption that the kernel
>>>> allocates full pages for memory to load modules. The size filed in the /proc/modules
>>>> output refers to the module size in bytes.
> 
>>>> If this is wrong we can omit the roundup.
> 
>>> Its not wrong, just looks unnecessary, a distraction, I'll remove it, ok?
> 
>> Sure go ahead.
> 
> Thanks, applied.
> 
> - Arnaldo

Thanks for picking this one. Out of curiosity, why didn't you pick the first
part of the patch set:

[PATCH 1/2] perf report fix module symbol adjustment for s390x

Anything wrong with it? Should I repost it?
Thanks

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
