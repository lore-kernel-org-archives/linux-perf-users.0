From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: perf call stacks on 32bit ARM v7
Date: Wed, 28 Sep 2016 09:43:25 +0800
Message-ID: <57EB203D.6000603@huawei.com>
References: <4233607.GXAFRqVoOG@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:14514 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933592AbcI1BrQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Sep 2016 21:47:16 -0400
In-Reply-To: <4233607.GXAFRqVoOG@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>, jean.pihet@newoldbits.com
Cc: perf group <linux-perf-users@vger.kernel.org>, hekuang 00206996 <hekuang@huawei.com>



On 2016/9/28 5:25, Milian Wolff wrote:
> Hello Jean, others.
>
> Can someone please clarify the requirements for getting perf to properly
> unwind the call stack on 32bit ARM v7?
>
> Looking at [1], it seems that I need either (a) frame pointers, or (b) DWARF
> debug information. Because (a) is often not available, and (b) is too large
> for small flash drives on embedded - how do I use perf with split debug
> information files? I.e. I have tries to record on the arm board using DWARF:
>
> arm-v7$ perf record --call-graph dwarf ...
>
> Then transferred the perf.data file over to my host machine. Perf archive said
> that no build-id's could be found, so I'm not using that. Instead, I try to
> ask perf to find the split debug packes using symfs:
>
> x86-64$ perf report --symfs ... -g graph
>
> But that does not work and I'm not seeing any backtraces. Stracing the report,
> I don't see it even trying to access files - how can I debug this and figure
> out what I'm supposed to be using?

Unfortunaetly, currently perf only supports corss decoding dwarf
for x86_64, x86_32 and arm64. ARM32 is not on the list.

Please see:

http://www.spinics.net/lists/kernel/msg2266293.html

and

tools/perf/util/unwind-libunwind.c

I think adding ARM32 support should not be very hard on perf side.
Add He Kuang to the CC list, he is the author of this patch set.

Thank you.
