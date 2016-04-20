From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Ideas to measure kernel function execution time using perf
Date: Tue, 19 Apr 2016 23:02:34 -0300
Message-ID: <20160420020234.GG3677@kernel.org>
References: <57158D19.7070307@cn.fujitsu.com>
 <20160420083757.cba5cdd3038c7d82391b3b4c@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54099 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936AbcDTCCl (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 19 Apr 2016 22:02:41 -0400
Content-Disposition: inline
In-Reply-To: <20160420083757.cba5cdd3038c7d82391b3b4c@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Qu Wenruo <quwenruo@cn.fujitsu.com>, linux-perf-users@vger.kernel.org

Em Wed, Apr 20, 2016 at 08:37:57AM +0900, Masami Hiramatsu escreveu:
> On Tue, 19 Apr 2016 09:42:49 +0800
> Qu Wenruo <quwenruo@cn.fujitsu.com> wrote:
> > Is there any method to measure kernel function execution time for 
> > specific functions using perf?
> > 
> > Current ftrace events can only record the timestamp when hitting the 
> > trace point (along with some other info).
> > 
> > I'm OK adding new ftrace events into kernel, but even after adding such 
> > ftrace events, is it possible to use perf to calculate the function 
> > execution time?
 
> Would you mean "perf probe"? :)
 
> Actually, kprobes on the function entry point (on x86) automatically
> use ftrace and also you can get function parameters, e.g.
 
> # perf probe -a 'YOUR_TARGET_FUNCTION $params'
 
> And with using ftrace, you can get function duration and parameters,
> for example,
 
> # perf probe -a 'vfs_read $params'
> Added new event:
>   probe:vfs_read       (on vfs_read with $params)
 
> You can now use it in all perf tools, such as:
 
> 	perf record -e probe:vfs_read -aR sleep 1

Humm, so this will automagically make function_graph hook in the
function exit, so that it can take the second timestamp to do the
measurement?

I.e. sortof this:

[root@jouet ~]# perf probe -a 'vfs_read_entry=vfs_read $params' 'vfs_read_exit=vfs_read%return'
Added new events:
  probe:vfs_read_entry (on vfs_read with $params)
  probe:vfs_read_exit  (on vfs_read%return)

You can now use it in all perf tools, such as:

	perf record -e probe:vfs_read_exit -aR sleep 1

[root@jouet ~]# perf trace -e read --ev probe:vfs_read* cat /etc/passwd > /dev/null
     0.005 ( 0.005 ms): cat/1167 read(fd: 3, buf: 0x7ffe9d8b63c0, count: 832                           ) ...
     0.005 (         ): probe:vfs_read_entry:(ffffffff8123c450) file=0xffff880161f79600 buf=0x7ffe9d8b63c0 count=0x340 pos=0xffff880109047ef0)
     0.008 (         ): probe:vfs_read_exit:(ffffffff8123c450 <- ffffffff8123d9c5))
     0.009 ( 0.009 ms): cat/1167  ... [continued]: read()) = 832
     0.348 ( 0.003 ms): cat/1167 read(fd: 3, buf: 0x7f33d6d08000, count: 131072                        ) ...
     0.348 (         ): probe:vfs_read_entry:(ffffffff8123c450) file=0xffff8802053ac400 buf=0x7f33d6d08000 count=0x20000 pos=0xffff880109047ef0)
     0.355 (         ): probe:vfs_read_exit:(ffffffff8123c450 <- ffffffff8123d9c5))
     0.356 ( 0.011 ms): cat/1167  ... [continued]: read()) = 2729
     0.361 ( 0.002 ms): cat/1167 read(fd: 3, buf: 0x7f33d6d08000, count: 131072                        ) ...
     0.361 (         ): probe:vfs_read_entry:(ffffffff8123c450) file=0xffff8802053ac400 buf=0x7f33d6d08000 count=0x20000 pos=0xffff880109047ef0)
     0.362 (         ): probe:vfs_read_exit:(ffffffff8123c450 <- ffffffff8123d9c5))
     0.364 ( 0.004 ms): cat/1167  ... [continued]: read()) = 0
[root@jouet ~]# 

But doing the combination of the pairs of vfs_read_{entry,exit} like is done in
'perf trace' for syscalls, i.e. for sys_{enter,exit}_SYSCALL_NAME?

- Arnaldo
 
> # cd /sys/kernel/debug/tracing/
> # echo vfs_read > set_ftrace_filter
> # echo 1 > events/probe/vfs_read/enable
> # echo function_graph > current_tracer
> # echo 0 > trace
> # less trace
> # tracer: function_graph
> #
> # CPU  DURATION                  FUNCTION CALLS
> # |     |   |                     |   |   |   |
>  2)               |  /* vfs_read: (vfs_read+0x0/0x130) file=0xffff88036a959200 buf=0x7ffe460abb70 count=0x10 pos=0xffff880052d1bf20 */
>  3)               |  /* vfs_read: (vfs_read+0x0/0x130) file=0xffff88024524b900 buf=0x7ffcdee7ec57 count=0x1 pos=0xffff88023942ff20 */
>  2)   0.538 us    |  vfs_read();
>  3)               |  vfs_read() {
>  2)               |  /* vfs_read: (vfs_read+0x0/0x130) file=0xffff8803c24ba400 buf=0xd8efdc count=0x1ff0 pos=0xffff880052d1bf20 */
>  2)   0.979 us    |  vfs_read();
> ...
> 
> Thanks,
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
