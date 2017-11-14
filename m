From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf test: fix test case probe libc's inet_pton on s390x
Date: Tue, 14 Nov 2017 14:55:48 +0100
Message-ID: <b44439ef-9852-c132-ea8a-d16e7b6b6ab8@linux.vnet.ibm.com>
References: <20171114071847.2381-1-tmricht@linux.vnet.ibm.com>
 <20171114071847.2381-2-tmricht@linux.vnet.ibm.com>
 <20171114132625.GM8836@kernel.org> <20171114133409.GN8836@kernel.org>
 <20171114134724.GP8836@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754606AbdKNNzy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Nov 2017 08:55:54 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAEDtOc9076029
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Nov 2017 08:55:54 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e800wx1fw-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Nov 2017 08:55:53 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Tue, 14 Nov 2017 13:55:51 -0000
In-Reply-To: <20171114134724.GP8836@kernel.org>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 11/14/2017 02:47 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Nov 14, 2017 at 10:34:09AM -0300, Arnaldo Carvalho de Melo escreveu:
>>> Different name, same contents, need to look at the inode... ;-\
>>
>> Nah, lets ask the kernel how is it that it sees libc, please test the
>> following, works for me:

works for me too.

> 
> BTW, this is what I sticked on that cset:
> 
>     Committer changes:
>     
>     We can't really use ldd for libc, as in some systems, such as x86_64, it
>     has hardlinks and then ldd sees one and the kernel the other, so grep
>     for libc in /proc/self/maps to get the one we'll receive from
>     PERF_RECORD_MMAP.
> 
> - Arnaldo
> 

Yes I am fine with this changes.
Go ahead.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
