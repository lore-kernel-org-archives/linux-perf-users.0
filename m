From: Taeung Song <treeze.taeung@gmail.com>
Subject: Re: perf events (node-loads, node-load-misses, ...)
Date: Tue, 2 May 2017 08:29:37 +0900
Message-ID: <11b191d5-5322-36bb-16e6-d589485a6e5b@gmail.com>
References: <CAC8SZUvZKWkniGBZE_afeNPJT2_9OnKBOudHWHJ_aHNmCbs1Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34232 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750813AbdEAX3l (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 1 May 2017 19:29:41 -0400
Received: by mail-pg0-f52.google.com with SMTP id v1so51413752pgv.1
        for <linux-perf-users@vger.kernel.org>; Mon, 01 May 2017 16:29:40 -0700 (PDT)
In-Reply-To: <CAC8SZUvZKWkniGBZE_afeNPJT2_9OnKBOudHWHJ_aHNmCbs1Uw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Hyojong Kim <hkim606@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Hi Hyojong,

On 05/02/2017 02:03 AM, Hyojong Kim wrote:
> Hello,
>
> My processor has several hardware cache events, of which I am
> interested in node-loads, node-load-misses, node-stores,
> node-store-misses. I think it is kind of obvious that node-loads and
> node-stores represent references to local memory (memory physically
> attached to a processor package). However, I have no clue as to what
> the rest represents. I have some theory that "node-load-misses"
> represent the number of misses in local memory, or the number of
> accesses to disk. Based on the profiled results I have
> (page-faults:16M << node-load-misses+node-store-misses:748M), however,
> this cannot be the raw number of disk accesses. Maybe some kind of
> piggybacking mechanism (by some MSHR kind of structure in memory?)
> could be the reason behind this discrepancy, but no clue. If anyone
> has some idea on this, please share it with me.
>
> I appreciate your help in advance!
>
> Sincerely,
> - Hyojong

Could I detailedly know your test case ?
(e.g options of perf-record, perf.data, test environment, etc)

Of course, you used the perf events (i.e. node-load-misses, etc),
but if you show the correct command and options when using perf-record
and share a link of the perf.data as the profiled results,
it'd be more easy to investigate this situation.


Thanks,
Taeung
