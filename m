From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: perf bpf: Reworked fix endianness problem when loading parameters
 in prologue
Date: Mon, 14 Aug 2017 12:58:06 +0200
Message-ID: <4448984d-8133-c342-45b4-4cc24dc4f610@linux.vnet.ibm.com>
References: <20170814094740.62459-1-tmricht@linux.vnet.ibm.com>
 <e0061fb8-69c1-5719-9df4-f8affd16d192@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55109 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752893AbdHNK6O (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Aug 2017 06:58:14 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v7EAvrpc142597
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Aug 2017 06:58:13 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2cb1d5dwf3-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Aug 2017 06:58:13 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Mon, 14 Aug 2017 11:58:11 +0100
In-Reply-To: <e0061fb8-69c1-5719-9df4-f8affd16d192@huawei.com>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Wangnan (F)" <wangnan0@huawei.com>, acme@kernel.org, linux-perf-users@vger.kernel.org
Cc: brueckner@linux.vnet.ibm.com, zvonko.kosic@de.ibm.com, Alexei Starovoitov <alexei.starovoitov@gmail.com>, Li Zefan <lizefan@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 08/14/2017 12:30 PM, Wangnan (F) wrote:
> Hi Thomas,
> 
> Your patch looks good to me. I've tested in my environment and it works.
> Please resend it to lkml and let Arnaldo to collect it.
> 
> Thank you.
> 

Will do, I take this as an Acked-by and Tested-by, ok?

Thanks
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
