From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: Is it possible to trace events and its call stack?
Date: Thu, 12 Jan 2017 15:46:58 +0530
Message-ID: <20170112101658.GA3470@naverao1-tp.localdomain>
References: <b5c14c32-b348-4783-1232-23894080dc5e@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750856AbdALKRR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 12 Jan 2017 05:17:17 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id v0CAFAXe051314
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Jan 2017 05:17:16 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
        by mx0a-001b2d01.pphosted.com with ESMTP id 27x57s61h3-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Jan 2017 05:17:16 -0500
Received: from localhost
        by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Thu, 12 Jan 2017 15:47:13 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
        by d28dlp03.in.ibm.com (Postfix) with ESMTP id 68CE11258061
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Jan 2017 15:48:43 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
        by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v0CAH9Un41746556
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Jan 2017 15:47:09 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
        by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v0CAH7Vm001118
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Jan 2017 15:47:09 +0530
Content-Disposition: inline
In-Reply-To: <b5c14c32-b348-4783-1232-23894080dc5e@cn.fujitsu.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: linux-perf-users@vger.kernel.org

On 2017/01/12 03:49PM, Qu Wenruo wrote:
> Hi,
> 
> Is it possible to use perf/ftrace to trace events and its call stack?
> 
> [Background]
> It's one structure in btrfs, btrfs_bio, I'm tracing for.
> That structure is allocated and free somewhat frequently, and its size is
> not fixed, so no SLAB/SLUB cache is used.
> 
> I added trace events(or trace points, anyway, just in
> include/trace/events/btrfs.h) to trace the allocation and freeing.
> Which will output the pointer address of that structure, so I can pair them,
> alone with other info.
> 
> Things went well until, I found some structures are allocated but not freed.
> (no corresponding trace point is triggered for given address).
> 
> It's possible that btrfs just forget to free it, or btrfs is just holding it
> for some purpose.
> So kernel memleak detector won't catch the later one.
> 
> That's to say along with the tracepoint data, I still need the call stack of
> each calling, to determine the code who leak or hold the pointer.
> 
> Is it possible to do it using perf or ftrace?

Yes, use -g option with 'perf record'. In fact, I don't think you even 
need to add a new tracepoint - you should be able to use kprobes (perf 
probe) at structure allocation/free points.

A more efficient way would probably use a eBPF program with stackmaps to 
track the stack traces.

- Naveen
