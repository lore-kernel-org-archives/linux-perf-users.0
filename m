From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: Is it possible to trace events and its call stack?
Date: Thu, 12 Jan 2017 15:49:08 +0800
Message-ID: <b5c14c32-b348-4783-1232-23894080dc5e@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:26787 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751010AbdALHtY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 12 Jan 2017 02:49:24 -0500
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 57FA547B0C85
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Jan 2017 15:49:10 +0800 (CST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

Is it possible to use perf/ftrace to trace events and its call stack?

[Background]
It's one structure in btrfs, btrfs_bio, I'm tracing for.
That structure is allocated and free somewhat frequently, and its size 
is not fixed, so no SLAB/SLUB cache is used.

I added trace events(or trace points, anyway, just in 
include/trace/events/btrfs.h) to trace the allocation and freeing.
Which will output the pointer address of that structure, so I can pair 
them, alone with other info.

Things went well until, I found some structures are allocated but not 
freed. (no corresponding trace point is triggered for given address).

It's possible that btrfs just forget to free it, or btrfs is just 
holding it for some purpose.
So kernel memleak detector won't catch the later one.

That's to say along with the tracepoint data, I still need the call 
stack of each calling, to determine the code who leak or hold the pointer.

Is it possible to do it using perf or ftrace?

Thanks,
Qu
