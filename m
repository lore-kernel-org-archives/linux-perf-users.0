From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf report does not resolve symbols on s390x
Date: Fri, 7 Jul 2017 09:22:34 -0300
Message-ID: <20170707122234.GO27350@kernel.org>
References: <eb00bf70-936d-e405-5867-015d4067202f@linux.vnet.ibm.com>
 <20170705155007.GH27350@kernel.org>
 <67eb6f70-fc34-95cd-b43c-349bbc24ee5d@linux.vnet.ibm.com>
 <5ead7c5a-5b91-107a-51ca-ea464fe8cfba@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750892AbdGGMWh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 7 Jul 2017 08:22:37 -0400
Content-Disposition: inline
In-Reply-To: <5ead7c5a-5b91-107a-51ca-ea464fe8cfba@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, zvonko.kosic@de.ibm.com

Em Fri, Jul 07, 2017 at 02:17:25PM +0200, Thomas-Mich Richter escreveu:
> It determines the kernel starts at address 1<<63 and loads the kernel address mapping.
> On s390x
> - The kernel starts at 0x0 (value of map->start) and thus all checks in function 
>   thread__find_addr_map() fail and no symbol is found for the specified addresses
>   because the kernel starts at 0x8000000000000000. Which is wrong the kernel start at 0x0.

oops, thanks for drilling down! We've had two other problems wrt s390
using 0 as the kernel start address, I'll dig the csets later, in a
hurry now, this is just another case where we have to consider zero a
valid address, will try and get this fixed.

- Arnaldo
