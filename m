From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: Majordomo results: Re: Confirmation for subscribe linux-per
Date: Mon, 24 Apr 2017 14:20:43 -0700
Message-ID: <CAE40pddzJD32k2yMmdtKdRqigZk7gcMNOEb4xuwwWaW=AnzW+w@mail.gmail.com>
References: <S977312AbdDXUEL/20170424200411Z+35176@vger.kernel.org>
 <CAOX5HaBep+=CjGrb9H9EKcE=Biz-YqdVWbDmtBWyhChXbsF2tQ@mail.gmail.com>
 <CAOX5HaBVNdzQNRpSmkrxi3UsC03sMkyFLY7kz46w7BPtWVkYuQ@mail.gmail.com> <CAOX5HaCN54f_znzLVoTgxBdM4Scz3jjjBeObE+_6MuMeNGtUzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38445 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S973212AbdDXVVP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Apr 2017 17:21:15 -0400
Received: by mail-wm0-f43.google.com with SMTP id r190so79883445wme.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Apr 2017 14:21:15 -0700 (PDT)
In-Reply-To: <CAOX5HaCN54f_znzLVoTgxBdM4Scz3jjjBeObE+_6MuMeNGtUzg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Justin Thomas <justin.thomas1@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Mon, Apr 24, 2017 at 1:36 PM, Justin Thomas <justin.thomas1@gmail.com> wrote:
>
> Segfault when running perf record with cap_add SYS_ADMIN inside a
> docker container:
>
>  root@903... $ perf record -a -g
> perf: Segmentation fault
> Obtained 10 stack frames.
> /usr/lib/linux-tools/4.10.0-19-generic/perf(+0x1efa44) [0x563c94b74a44]
> /lib/x86_64-linux-gnu/libc.so.6(+0x357f0) [0x7fcefe0e27f0]
> /usr/lib/linux-tools/4.10.0-19-generic/perf(+0x184bb0) [0x563c94b09bb0]
> /usr/lib/linux-tools/4.10.0-19-generic/perf(+0x11b71a) [0x563c94aa071a]
> /usr/lib/linux-tools/4.10.0-19-generic/perf(+0x11c8a1) [0x563c94aa18a1]
> /usr/lib/linux-tools/4.10.0-19-generic/perf(+0x177633) [0x563c94afc633]
> /usr/lib/linux-tools/4.10.0-19-generic/perf(+0x10a71e) [0x563c94a8f71e]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf1) [0x7fcefe0cd3f1]
> /usr/lib/linux-tools/4.10.0-19-generic/perf(+0x10a84a) [0x563c94a8f84a]
> [(nil)]
> Segmentation fault (core dumped)


# gdb ./perf core
(gdb) bt
#0  0x000000000046bd4f in snprintf (__fmt=0x653da9 "%s%s", __n=4096,
__s=0x23d1d38 "") at /usr/include/x86_64-linux-gnu/bits/stdio2.h:64
#1  perf_event__synthesize_kernel_mmap (tool=tool@entry=0x912280
<record>, process=process@entry=0x40eab0 <process_synthesized_event>,
machine=machine@entry=0x23b4088)
    at util/event.c:714
#2  0x000000000040f389 in record__synthesize (tail=tail@entry=false,
rec=0x912280 <record>) at builtin-record.c:792
#3  0x0000000000410453 in __cmd_record (rec=0x912280 <record>,
argv=<optimized out>, argc=2) at builtin-record.c:916
[...]

>
> setting: $ sudo sh -c " echo 0 > /proc/sys/kernel/kptr_restrict" on
> the host causes it to work.


Right, I'm guessing the code isn't dealing with zeros in kallsyms.

Brendan
