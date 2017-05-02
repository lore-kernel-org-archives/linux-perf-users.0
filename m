From: Andi Kleen <andi@firstfloor.org>
Subject: Re: perf events (node-loads, node-load-misses, ...)
Date: Mon, 01 May 2017 20:25:02 -0700
Message-ID: <87inlkgctt.fsf@firstfloor.org>
References: <CAC8SZUvZKWkniGBZE_afeNPJT2_9OnKBOudHWHJ_aHNmCbs1Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:29940 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750825AbdEBDZE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 1 May 2017 23:25:04 -0400
In-Reply-To: <CAC8SZUvZKWkniGBZE_afeNPJT2_9OnKBOudHWHJ_aHNmCbs1Uw@mail.gmail.com>
        (Hyojong Kim's message of "Mon, 1 May 2017 13:03:41 -0400")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Hyojong Kim <hkim606@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Hyojong Kim <hkim606@gmail.com> writes:

> Hello,
>
> My processor has several hardware cache events, of which I am
> interested in node-loads, node-load-misses, node-stores,
> node-store-misses. I think it is kind of obvious that node-loads and
> node-stores represent references to local memory (memory physically
> attached to a processor package). However, I have no clue as to what
> the rest represents. I have some theory that "node-load-misses"
> represent the number of misses in local memory, or the number of
> accesses to disk. Based on the profiled results I have
> (page-faults:16M << node-load-misses+node-store-misses:748M), however,
> this cannot be the raw number of disk accesses. Maybe some kind of
> piggybacking mechanism (by some MSHR kind of structure in memory?)
> could be the reason behind this discrepancy, but no clue. If anyone
> has some idea on this, please share it with me.

node-loads is the number of memory reads served by the local NUMA node.
node-loads-misses is the number of reads served by a remote NUMA node.
Similar for stores.

It has nothing to do with the disk.

-Andi
