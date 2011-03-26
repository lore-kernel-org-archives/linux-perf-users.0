From: David Ahern <dsahern@gmail.com>
Subject: Re: Fwd: perf trace cannot work with software events ?
Date: Sat, 26 Mar 2011 07:13:57 -0600
Message-ID: <4D8DE695.3000606@gmail.com>
References: <AANLkTi=pRKpdupEcXS0FmOA-PiAiXHWPYwWxN4F27fFC@mail.gmail.com>	<AANLkTikXKDiyf7Q=mY_ez2P3OSw23VaRMdKcF_M-KCc0@mail.gmail.com>	<AANLkTi=VrazJpV+dpzX2hWJ8dYDgbdo_5FAOMRYRo0GD@mail.gmail.com> <AANLkTi=A5hkUE0xna5zmuXGt=LvMS_C41whzwM0-nUNs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65388 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab1CZNN7 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 26 Mar 2011 09:13:59 -0400
Received: by iyb14 with SMTP id 14so1441538iyb.19
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Mar 2011 06:13:58 -0700 (PDT)
In-Reply-To: <AANLkTi=A5hkUE0xna5zmuXGt=LvMS_C41whzwM0-nUNs@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: zhao bao <baozhao@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 03/26/11 06:31, zhao bao wrote:
>> It's used to trace kernel space page faults, not for userspace code.
>>
>> Lin Ming
>>
> 
> From the ouput of "perf report" command, I think  perf can record the
> page faults from userspace code.
> 
> [root@localhost lab]# perf record -R -c 1  -d  -e  faults ./hello
> hello,world

'-e faults' is a software event. perf-trace does not handle S/W events.
perf-trace has been renamed to perf-script, and perf-script recently
gained the ability to dump S/W events:

https://lkml.org/lkml/2011/3/10/3

David

> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.010 MB perf.data (~420 samples) ]
> [root@localhost lab]# perf report
> # Events: 92  cycles
> #
> # Overhead  Command      Shared Object  Symbol
> # ........  .......  .................  ......
> #
>    10.87%    hello  ld-2.12.90.so      [.] .L198
>     6.52%    hello  ld-2.12.90.so      [.] _dl_load_cache_lookup
>     6.52%    hello  ld-2.12.90.so      [.] _dl_lookup_symbol_x
>     4.35%    hello  ld-2.12.90.so      [.] dl_main
>     3.26%    hello  ld-2.12.90.so      [.] _dl_start
>     3.26%    hello  ld-2.12.90.so      [.] _dl_cache_libcmp
>     3.26%    hello  ld-2.12.90.so      [.] do_lookup_x
>     2.17%    hello  libc-2.12.90.so    [.] _init
>     2.17%    hello  libc-2.12.90.so    [.] _IO_file_overflow_internal
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
