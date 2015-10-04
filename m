From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf record of multiple events: disable callgraph for some events
Date: Sun, 4 Oct 2015 17:40:59 -0300
Message-ID: <20151004204059.GF20515@kernel.org>
References: <4930261.j7GqdZnq15@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36649 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741AbbJDUk7 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 4 Oct 2015 16:40:59 -0400
Content-Disposition: inline
In-Reply-To: <4930261.j7GqdZnq15@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: perf group <linux-perf-users@vger.kernel.org>

Em Sun, Oct 04, 2015 at 01:48:21PM +0200, Milian Wolff escreveu:
> Hey all,
> 
> would it be possible to add a feature to perf to only grab callgraphs for a 
> certain selection of events? E.g. thinking about a lock contention profile of 
> a Qt application, I'd listen to 
> 
> -e syscalls:sys_enter_futex,syscalls:sys_exit_futex
> 
> Now, with the dwarf unwinder this easily produces huge data files in the order 
> of gigabytes. This cost could easily be reduced by a factor of two, as one 
> only needs the callgraphs for syscalls:sys_enter_futex - the TID should be 
> enough to find the callgraph for the enter event from the exit trace point.
> 
> Could someone guide me in implementing such a feature to make it possible to 
> filter the events which trigger the collection of a callgraph? Or is that 
> already possible somehow?

Can you please check if this suits you, it is already in the tree:

commit e637d17757a10732fa5d573c18f20b3cd4d31245
Author: He Kuang <hekuang@huawei.com>
Date:   Mon Sep 28 03:52:16 2015 +0000

    perf tools: Enable event_config terms to tracepoint events
    
    This patch enables config terms for tracepoint perf events. Valid terms
    for tracepoint events are 'call-graph' and 'stack-size', so we can use
    different callgraph settings for each event and eliminate unnecessary
    overhead.
    
    Here is an example for using different call-graph config for each
    tracepoint.
    
      $ perf record -e syscalls:sys_enter_write/call-graph=fp/
                    -e syscalls:sys_exit_write/call-graph=no/
                    dd if=/dev/zero of=test bs=4k count=10
    
      $ perf report --stdio
    
      #
      # Total Lost Samples: 0
      #
      # Samples: 13  of event 'syscalls:sys_enter_write'
      # Event count (approx.): 13
      #
      # Children      Self  Command  Shared Object       Symbol
      # ........  ........  .......  ..................  ......................
      #
          76.92%    76.92%  dd       libpthread-2.20.so  [.] __write_nocancel
                       |
                       ---__write_nocancel
    
          23.08%    23.08%  dd       libc-2.20.so        [.] write
                       |
                       ---write
                          |
                          |--33.33%-- 0x2031342820736574
                          |
                          |--33.33%-- 0xa6e69207364726f
                          |
                           --33.33%-- 0x34202c7320393039
      ...
    
      # Samples: 13  of event 'syscalls:sys_exit_write'
      # Event count (approx.): 13
      #
      # Children      Self  Command  Shared Object       Symbol
      # ........  ........  .......  ..................  ......................
      #
          76.92%    76.92%  dd       libpthread-2.20.so  [.] __write_nocancel
          23.08%    23.08%  dd       libc-2.20.so        [.] write
           7.69%     0.00%  dd       [unknown]           [.] 0x0a6e69207364726f
           7.69%     0.00%  dd       [unknown]           [.] 0x2031342820736574
           7.69%     0.00%  dd       [unknown]           [.] 0x34202c7320393039
    
    Signed-off-by: He Kuang <hekuang@huawei.com>
    Acked-by: Jiri Olsa <jolsa@kernel.org>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Kan Liang <kan.liang@intel.com>
    Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
    Cc: Wang Nan <wangnan0@huawei.com>
    Cc: pi3orama@163.com
    Link: http://lkml.kernel.org/r/1443412336-120050-4-git-send-email-hekuang@huawei.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
