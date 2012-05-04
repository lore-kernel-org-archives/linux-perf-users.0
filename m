From: David Ahern <dsahern@gmail.com>
Subject: Re: [BUG] perf top -G is broken
Date: Fri, 04 May 2012 15:55:34 -0600
Message-ID: <4FA45056.8060208@gmail.com>
References: <87pqanmh2y.fsf@sejong.aot.lge.com> <20120502160250.GB5745@infradead.org> <87bom4a8pc.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51279 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754515Ab2EDVzj (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 May 2012 17:55:39 -0400
Received: by pbbrp8 with SMTP id rp8so4328412pbb.19
        for <linux-perf-users@vger.kernel.org>; Fri, 04 May 2012 14:55:38 -0700 (PDT)
In-Reply-To: <87bom4a8pc.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung.kim@lge.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: linux-perf-users@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>

On 5/3/12 10:09 PM, Namhyung Kim wrote:
> Hi,
>
> On Wed, 2 May 2012 13:02:50 -0300, Arnaldo Carvalho de Melo wrote:
>> Em Wed, May 02, 2012 at 11:50:45AM +0900, Namhyung Kim escreveu:
>>> Some guy reported me that perf top -G is broken with segment fault. I
>>> can reproduce it on my system easily but the time is vary - few seconds
>>> to 30 minutes. I ran it with --stdio to get a core file:
>>
>> Does it help to increase --mmap-pages from its default, 128, to
>> something like 512 or more?
>>
>> Also try running with -r 90.
>>
>> - Arnaldo
>
> Testing both options with current tip/perf/core gives me the same result. :(

Have a few minutes before catching a plane. Running 'hackbench 10 thread 
4000' in a loop in one window and perf top -G within gdb in another 
(tip/perf/core as of today):

(gdb) info thr
   Id   Target Id         Frame
* 2    Thread 0x7ffff0407700 (LWP 1109) "perf" 0x00000000004575c6 in 
callchain_cursor_advance (cursor=<optimized out>)
     at util/callchain.h:141
   1    Thread 0x7ffff7fd7940 (LWP 925) "perf" 0x00007ffff35ff819 in 
calloc () from /lib64/libc.so.6

(gdb) bt
#0  0x00000000004575c6 in callchain_cursor_advance (cursor=<optimized 
out>) at util/callchain.h:141
#1  fill_node (node=0x7fffe8293e80, cursor=0x8e4f58) at util/callchain.c:226
#2  0x0000000000458f80 in add_child (period=2719949, cursor=0x8e4f58, 
parent=0xc8e110) at util/callchain.c:239
#3  append_chain_children (period=2719949, cursor=0x8e4f58, 
root=0xc8e110) at util/callchain.c:308
#4  merge_chain_branch (cursor=0x8e4f58, dst=0xc8e110, src=0x10462f0) at 
util/callchain.c:415
#5  0x0000000000458e9a in merge_chain_branch (cursor=0x8e4f58, 
dst=0xc8e110, src=0xfdabf0) at util/callchain.c:419
#6  0x0000000000473ef8 in hists__collapse_insert_entry (he=0xfdab40, 
root=0x8e4da0, hists=0x8e4d80) at util/hist.c:401
#7  __hists__collapse_resort (hists=0x8e4d80, threaded=<optimized out>) 
at util/hist.c:458
#8  0x0000000000426563 in perf_top__print_sym_table (top=0x7fffffffd530) 
at builtin-top.c:309
#9  display_thread (arg=0x7fffffffd530) at builtin-top.c:623
#10 0x00007ffff7bc6d90 in start_thread () from /lib64/libpthread.so.0
#11 0x00007ffff366cf5d in clone () from /lib64/libc.so.6

(gdb) thr 1
[Switching to thread 1 (Thread 0x7ffff7fd7940 (LWP 925))]
#0  0x00007ffff35ff819 in calloc () from /lib64/libc.so.6

(gdb) bt
#0  0x00007ffff35ff819 in calloc () from /lib64/libc.so.6
#1  0x000000000045758f in zalloc (size=48) at util/util.h:183
#2  fill_node (node=0xf15710, cursor=0x8e4f58) at util/callchain.c:216
#3  0x0000000000459159 in add_child (period=2655425, cursor=0x8e4f58, 
parent=0x104a680) at util/callchain.c:239
#4  append_chain_children (period=2655425, cursor=0x8e4f58, 
root=0x104a680) at util/callchain.c:308
#5  callchain_append (root=0x104a678, cursor=0x8e4f58, period=2655425) 
at util/callchain.c:388
#6  0x00000000004255df in perf_event__process_sample (machine=<optimized 
out>, sample=0x7fffffffd440, evsel=0x8e4cf0,
     event=<optimized out>, tool=0x7fffffffd530) at builtin-top.c:790
#7  perf_top__mmap_read_idx (top=0x7fffffffd530, idx=2) at builtin-top.c:858
#8  0x0000000000427607 in perf_top__mmap_read (top=0x7fffffffd530) at 
builtin-top.c:873
#9  __cmd_top (top=0x7fffffffd530) at builtin-top.c:1054
#10 cmd_top (argc=<optimized out>, argv=<optimized out>, 
prefix=<optimized out>) at builtin-top.c:1333
#11 0x0000000000414403 in run_builtin (p=0x774448, argc=3, 
argv=0x7fffffffe320) at perf.c:273
#12 0x0000000000413c31 in handle_internal_command (argv=0x7fffffffe320, 
argc=3) at perf.c:345
#13 run_argv (argv=0x7fffffffe130, argcp=0x7fffffffe13c) at perf.c:389
#14 main (argc=3, argv=0x7fffffffe320) at perf.c:487

Cross thread corruption. Both threads are operating on the cursor at 
0x8e4f58 in this example.

David
