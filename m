From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] perf record: wrong size in perf_record_mmap for last
 kernel module
Date: Tue, 25 Jul 2017 10:26:14 +0200
Message-ID: <1410d73a-ad86-2c14-2e4f-5c4e174f5eba@linux.vnet.ibm.com>
References: <20170724143514.55574-1-tmricht@linux.vnet.ibm.com>
 <20170724143514.55574-2-tmricht@linux.vnet.ibm.com>
 <20170725065812.GB28831@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751202AbdGYI0U (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 Jul 2017 04:26:20 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6P8OvmG044052
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jul 2017 04:26:20 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bwvyycwhx-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jul 2017 04:26:20 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Tue, 25 Jul 2017 09:26:18 +0100
In-Reply-To: <20170725065812.GB28831@sejong>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: brueckner@linux.vnet.ibm.com, zvonko.kosic@de.ibm.com, linux-perf-users@vger.kernel.org, acme@kernel.org, kernel-team@lge.com

On 07/25/2017 08:58 AM, Namhyung Kim wrote:
> On Mon, Jul 24, 2017 at 04:35:14PM +0200, Thomas Richter wrote:
>> During work on perf report for s390 I ran into the following issue:


[...]

> 
> Did you hit a real problem with this?  I think it doesn't affect
> symbol resolution anyway.  I saw a related problem before though..

Sure, that is why I startet digging.... Here is the output of perf report
which triggered my investigation last week:


0.79%     0.00%  sshd            [qeth_l2]                   [k] 0xfffffc007fb2dbb2
            |
            ---0x44da
               skb_vlan_push
               iplstart

As said before qeth_l2.ko is the last kernel modules listed in /proc/modules.

>   https://lkml.org/lkml/2017/6/23/63
> 
> In this case a module was unloaded after perf record, and loaded again
> (but on a slightly different address) before perf report.  The record
> data has old address but perf report tried to use current address so
> it could not find symbols from the module.  I need to update the
> patchset..

Ok I have looked at this patch series but still do not understand every
detail of it. I have not seen it before, I do not
follow the linux-kernel mailing list. This amount of traffic kills me...
(or my thunderbird) and I end up deleting the incoming mails all the time.

However I do follow linux-perf-user mailing list. I found this sufficient
because right now I only work on the perf user tool and not the kernel part.

> 
> Anyway I'm ok with this patch.
> 
> Thanks,
> Namhyung
> 

[...]
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
