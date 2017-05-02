From: Hyojong Kim <hkim606@gmail.com>
Subject: Re: perf events (node-loads, node-load-misses, ...)
Date: Tue, 2 May 2017 11:56:23 -0400
Message-ID: <CAC8SZUu5+DoQpLXh7jyXaLpfR61wJX1=QhxNKvXSueO9ZRfehA@mail.gmail.com>
References: <CAC8SZUvZKWkniGBZE_afeNPJT2_9OnKBOudHWHJ_aHNmCbs1Uw@mail.gmail.com>
 <87inlkgctt.fsf@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33822 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbdEBP5E (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 May 2017 11:57:04 -0400
Received: by mail-pg0-f49.google.com with SMTP id v1so63419906pgv.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 May 2017 08:57:04 -0700 (PDT)
In-Reply-To: <87inlkgctt.fsf@firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

Hi Andi,

Thank you for clearing up the confusion. It makes more sense to
interpret node-loads-misses that way than attribute it to disk
accesses.

Sincerely,
- Hyojong


On Mon, May 1, 2017 at 11:25 PM, Andi Kleen <andi@firstfloor.org> wrote:
> Hyojong Kim <hkim606@gmail.com> writes:
>
>> Hello,
>>
>> My processor has several hardware cache events, of which I am
>> interested in node-loads, node-load-misses, node-stores,
>> node-store-misses. I think it is kind of obvious that node-loads and
>> node-stores represent references to local memory (memory physically
>> attached to a processor package). However, I have no clue as to what
>> the rest represents. I have some theory that "node-load-misses"
>> represent the number of misses in local memory, or the number of
>> accesses to disk. Based on the profiled results I have
>> (page-faults:16M << node-load-misses+node-store-misses:748M), however,
>> this cannot be the raw number of disk accesses. Maybe some kind of
>> piggybacking mechanism (by some MSHR kind of structure in memory?)
>> could be the reason behind this discrepancy, but no clue. If anyone
>> has some idea on this, please share it with me.
>
> node-loads is the number of memory reads served by the local NUMA node.
> node-loads-misses is the number of reads served by a remote NUMA node.
> Similar for stores.
>
> It has nothing to do with the disk.
>
> -Andi
