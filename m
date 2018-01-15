From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] perf trace: Fix missing handling of --call-graph dwarf
Date: Mon, 15 Jan 2018 15:45:46 +0100
Message-ID: <20180115144546.GA4691@linux.vnet.ibm.com>
References: <20180112100355.6456-1-tmricht@linux.vnet.ibm.com>
 <20180112142032.GB9655@kernel.org>
 <20180112150142.GC9655@kernel.org>
 <20180112164706.GE9655@kernel.org>
 <20180112200229.GI9655@kernel.org>
 <8d20a732-25af-968c-f3a9-1a1336854851@linux.vnet.ibm.com>
 <20180115135752.GC3542@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933392AbeAOOpx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Jan 2018 09:45:53 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0FEic9g128081
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jan 2018 09:45:52 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fgt9rug5n-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jan 2018 09:45:52 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <brueckner@linux.vnet.ibm.com>;
        Mon, 15 Jan 2018 14:45:50 -0000
Content-Disposition: inline
In-Reply-To: <20180115135752.GC3542@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com

On Mon, Jan 15, 2018 at 10:57:52AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jan 15, 2018 at 01:31:00PM +0100, Thomas-Mich Richter escreveu:
> > On 01/12/2018 09:02 PM, Arnaldo Carvalho de Melo wrote:
> > > Em Fri, Jan 12, 2018 at 01:47:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> > >
> [root@jouet ~]# perf trace --no-syscalls --call-graph fp --max-stack 3 -e probe_libc:inet_pton ping -6 -c 1 ::1
> perf trace --no-syscalls --call-graph dwarf --max-stack 3 -e probe_libc:inet_pton ping -6 -c 1 ::1
> PING ::1(::1) 56 data bytes
> 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.080 ms
> 
> --- ::1 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 0.080/0.080/0.080/0.000 ms
>      0.000 probe_libc:inet_pton:(7f33e9647350))
>                                        __inet_pton (inlined)
>                                        gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
>                                        __GI_getaddrinfo (inlined)
> [root@jouet ~]# 
> 
> And here we see a difference in the fp and DWARF unwinders, have to dig
> deeper into this one, perhaps using the DWARF one we have more info and
> then can end up with inlines instead of what it calls.

DWARF includes information about which functions are inlined.  The ORC
unwinder data is based on the analysis of the generated instructions
(created with the objtool).  Hence, it does no (and no longer) know whether
a bunch of instructions are originally part of a function or inlined.

Thanks and kind regards,
  Hendrik
