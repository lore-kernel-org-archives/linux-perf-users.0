From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: Re: Is it possible to trace events and its call stack?
Date: Mon, 16 Jan 2017 16:54:47 +0800
Message-ID: <748bd3f1-846b-6014-093f-19b2104e7cf4@cn.fujitsu.com>
References: <20170112204153.GD20003@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:1224 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750849AbdAPIzZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 Jan 2017 03:55:25 -0500
In-Reply-To: <20170112204153.GD20003@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org



At 01/13/2017 04:41 AM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jan 12, 2017 at 03:46:58PM +0530, Naveen N. Rao escreveu:
>> On 2017/01/12 03:49PM, Qu Wenruo wrote:
>>> Hi,
>>>
>>> Is it possible to use perf/ftrace to trace events and its call stack?
>>>
>>> [Background]
>>> It's one structure in btrfs, btrfs_bio, I'm tracing for.
>>> That structure is allocated and free somewhat frequently, and its size is
>>> not fixed, so no SLAB/SLUB cache is used.
>>>
>>> I added trace events(or trace points, anyway, just in
>>> include/trace/events/btrfs.h) to trace the allocation and freeing.
>>> Which will output the pointer address of that structure, so I can pair them,
>>> alone with other info.
>>>
>>> Things went well until, I found some structures are allocated but not freed.
>>> (no corresponding trace point is triggered for given address).
>>>
>>> It's possible that btrfs just forget to free it, or btrfs is just holding it
>>> for some purpose.
>>> So kernel memleak detector won't catch the later one.
>>>
>>> That's to say along with the tracepoint data, I still need the call stack of
>>> each calling, to determine the code who leak or hold the pointer.
>>>
>>> Is it possible to do it using perf or ftrace?
>>
>> Yes, use -g option with 'perf record'. In fact, I don't think you even
>> need to add a new tracepoint - you should be able to use kprobes (perf
>> probe) at structure allocation/free points.

Wow, cool!

In fact I already found perf quite handy than my old script to enable 
trace points.

>
> Yes, with 'perf record -g', as suggested above, or directly with 'perf trace',
> if the volume is not big or if you're ok about using a strace like workflow,
> for example:
>
> [root@jouet ~]# perf probe -m btrfs -F btrfs_bio*
> btrfs_bio_alloc
> btrfs_bio_clone
> btrfs_bio_counter_inc_blocked
> btrfs_bio_counter_inc_noblocked
> btrfs_bio_counter_sub
> btrfs_bio_wq_end_io
> [root@jouet ~]# perf probe -m btrfs btrfs_bio_alloc
> Added new event:
>   probe:btrfs_bio_alloc (on btrfs_bio_alloc in btrfs)
>
> You can now use it in all perf tools, such as:
>
> 	perf record -e probe:btrfs_bio_alloc -aR sleep 1
>
> [root@jouet ~]# #perf trace -e write,read,probe:btrfs*
> [root@jouet ~]# mount | grep btrfs
> /var/lib/machines.raw on /var/lib/machines type btrfs (rw,relatime,seclabel,space_cache,subvolid=5,subvol=/)
> [root@jouet ~]# perf trace --no-syscalls -e probe:btrfs*/max-stack=4/
>      0.000 probe:btrfs_bio_alloc:(ffffffffc0aae110))
>                                        btrfs_bio_alloc ([btrfs])
>                                        write_one_eb ([btrfs])
>                                        btree_write_cache_pages ([btrfs])
>                                        btree_writepages ([btrfs])
>     13.112 probe:btrfs_bio_alloc:(ffffffffc0aae110))
>                                        btrfs_bio_alloc ([btrfs])
>                                        __extent_writepage_io ([btrfs])
>                                        __extent_writepage ([btrfs])
>                                        extent_write_cache_pages.isra.43.constprop.60 ([btrfs])
>     13.285 probe:btrfs_bio_alloc:(ffffffffc0aae110))
>                                        btrfs_bio_alloc ([btrfs])
>                                        __extent_writepage_io ([btrfs])
>                                        __extent_writepage ([btrfs])
>                                        extent_write_cache_pages.isra.43.constprop.60 ([btrfs])
>     13.434 probe:btrfs_bio_alloc:(ffffffffc0aae110))
>                                        btrfs_bio_alloc ([btrfs])
>                                        write_one_eb ([btrfs])
>                                        btree_write_cache_pages ([btrfs])
>                                        btree_writepages ([btrfs])
>     13.454 probe:btrfs_bio_alloc:(ffffffffc0aae110))
>                                        btrfs_bio_alloc ([btrfs])
>                                        write_one_eb ([btrfs])
>                                        btree_write_cache_pages ([btrfs])
>                                        btree_writepages ([btrfs])
> ^C[root@jouet ~]#
> [root@jouet ~]# perf probe -l
>   probe:btrfs_bio_alloc (on __start_delalloc_inodes+624@git/linux/fs/btrfs/inode.c in btrfs)
> [root@jouet ~]#
>
> This was a system wide record, you could do it just for a set of threads, or
> for work taking place in a specific CPU, etc.
>
> I.e. you could try to isolate a set of CPUs, then make sure that the work you
> want to trace takes place there and then trace just those CPUS, etc.
>
> Use 'perf trace -h topic' to see options related to a topic, e.g.:
>
> [root@jouet ~]# perf trace -h cpu
>
>  Usage: perf trace [<options>] [<command>]
>     or: perf trace [<options>] -- <command> [<options>]
>     or: perf trace record [<options>] [<command>]
>     or: perf trace record [<options>] -- <command> [<options>]
>
>     -a, --all-cpus        system-wide collection from all CPUs
>     -C, --cpu <cpu>       list of cpus to monitor


I tried perf record/report and it's already cool enough.

Just didn't find that 'perf trace' can be even more suitable for my case

Great thanks for all of you,
Qu

>
> [root@jouet ~]#
>
> Remote that --no-syscalls to see strace like output for syscalls (enter + exit,
> time it takes, only syscalls with more than N milliseconds.microsecds, etc)
>
>> A more efficient way would probably use a eBPF program with stackmaps to
>> track the stack traces.
>
> If wanting to do aggregation inside the kernel, yes.
>
> - Arnaldo
>
>> - Naveen
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
