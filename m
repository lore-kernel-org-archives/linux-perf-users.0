From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] perf test attr: fix python error on empty result
Date: Mon, 18 Sep 2017 09:41:11 +0200
Message-ID: <bfc726e6-da65-0a9d-3b2b-f4a9a270a38b@linux.vnet.ibm.com>
References: <20170913081209.39570-1-tmricht@linux.vnet.ibm.com>
 <20170915184503.GA31734@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52892 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750791AbdIRHlR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Sep 2017 03:41:17 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8I7d2fW073872
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Sep 2017 03:41:16 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2d28wsaqsf-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Sep 2017 03:41:16 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Mon, 18 Sep 2017 08:41:14 +0100
In-Reply-To: <20170915184503.GA31734@krava>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com

On 09/15/2017 08:45 PM, Jiri Olsa wrote:
> On Wed, Sep 13, 2017 at 10:12:08AM +0200, Thomas Richter wrote:
>> Commit d78ada4a767 ("perf tests attr: Do not store failed events")
>> does not create an event file in the /tmp directory when the
>> perf_open_event() system call failed.
>> This can lead to a situation where not /tmp/event-xx-yy-zz result
>> file exists at all (for example on a s390x virtual machine environment)
>> where no CPUMF hardware is available.
> 
> those 2 were already sent earlier if I'm not mistaken,
> I think I've already acked them, if not:

I developed the first patch just before my vacation and submitted
it for the first time after my vacation.

The second patch was submitted before but is not part of 4.14.0-rc1
so I guess it got lost.

> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> thanks,
> jirka
>

Thanks
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
