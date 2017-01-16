From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: Is it possible to trace events and its call stack?
Date: Mon, 16 Jan 2017 11:55:25 +0900
Message-ID: <20170116115525.21e12d967e0acf8159c29165@kernel.org>
References: <b5c14c32-b348-4783-1232-23894080dc5e@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751627AbdAPCzk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 15 Jan 2017 21:55:40 -0500
In-Reply-To: <b5c14c32-b348-4783-1232-23894080dc5e@cn.fujitsu.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: linux-perf-users@vger.kernel.org

On Thu, 12 Jan 2017 15:49:08 +0800
Qu Wenruo <quwenruo@cn.fujitsu.com> wrote:

> Hi,
> 
> Is it possible to use perf/ftrace to trace events and its call stack?
> 
> [Background]
> It's one structure in btrfs, btrfs_bio, I'm tracing for.
> That structure is allocated and free somewhat frequently, and its size 
> is not fixed, so no SLAB/SLUB cache is used.
> 
> I added trace events(or trace points, anyway, just in 
> include/trace/events/btrfs.h) to trace the allocation and freeing.
> Which will output the pointer address of that structure, so I can pair 
> them, alone with other info.
> 
> Things went well until, I found some structures are allocated but not 
> freed. (no corresponding trace point is triggered for given address).
> 
> It's possible that btrfs just forget to free it, or btrfs is just 
> holding it for some purpose.
> So kernel memleak detector won't catch the later one.
> 
> That's to say along with the tracepoint data, I still need the call 
> stack of each calling, to determine the code who leak or hold the pointer.
> 
> Is it possible to do it using perf or ftrace?

If you are using ftrace, yes, you can enable stacktrace for each
events by setting stacktrace event trigger as below;

echo stacktrace > events/btrfs/<your event>/trigger

Then ftrace will show the stacktrace data.
See /sys/kernel/debug/tracing/README for more details. :)

Thank you,

> 
> Thanks,
> Qu
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Masami Hiramatsu <mhiramat@kernel.org>
