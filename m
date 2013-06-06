From: Andrew Davidoff <davidoff@qedmf.net>
Subject: Re: Getting started with perf; a couple of questions
Date: Thu, 6 Jun 2013 12:26:46 -0600
Message-ID: <CAJLXCZSE=LWW8PxTAs4yPAQsmwQjVF=ehGCTKbUWF3rCDF-+7w@mail.gmail.com>
References: <CAJLXCZTs4i0P3wA78u25aCt-rfcsBNQ8t0QSsbWazQyoV-XdLA@mail.gmail.com>
	<51A83824.1090907@gmail.com>
	<CAJLXCZTzRdLYmcRVTO_AeRawmZ55AtdABcKpu5T5A-Z89iHnbA@mail.gmail.com>
	<CAJLXCZTN1xLXk79kh5i8WbJBB+4sh0Qs1v+PndhLKSrPPvZ2wQ@mail.gmail.com>
	<51B09633.2040204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:47234 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab3FFS0q (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 6 Jun 2013 14:26:46 -0400
Received: by mail-ie0-f172.google.com with SMTP id 17so8125399iea.31
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Jun 2013 11:26:46 -0700 (PDT)
In-Reply-To: <51B09633.2040204@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Thu, Jun 6, 2013 at 8:01 AM, David Ahern <dsahern@gmail.com> wrote:
>
> It's a VM and not running on KVM so there is no PMU which means the -e
> cycles is most likely falling back to -e cpu-clock. You should see this in a
> message with the -v flag on record. perf-script should dump out the events
> and show cpu-clock versus cycles.
>
> Based on that I suggest trying -e cpu-clock on your original host. If that
> works then something is messed up with the pmu config on the host.

Thanks. It wasn't clear to me if a VM had the same access to the PMU
that a non-virtualized host would. But I guess that might explain why
a bunch of events I'd expect samples for didn't have any (ex:
iTLB-load-misses), even on the VM that did record some samples?

I re-ran the record on the VM with -v and did see the message about
falling back to cpu-clock-ticks, but only after I added the cycles
even to my events list. Which actually leads into a question regarding
event sampling.

The documentation I have found mentions a "default sampling event"
(cycles) but doesn't explain the concept of a sampling event in
detail. Does each event listed with -e have its own sample period/rate
that can be adjusted? Or do -c or -F apply to all events sampled? Even
I don't sample cycles, is the default sampling rate still 1000Hz for
all events sampled in the absence of -c or -F?

Regarding using -e cpu-clock on the original host, that doesn't appear
to have changed the perf record behavior. Neither does using -e
cycles. And even with -v on record, I didn't see any additional
messaging (like fall back to cpu-clock). But I do still get sample
data if I run with -a. *shrug*. Not a big deal at this point - running
perf on this particular host/OS might not be something I need to do,
so for now I can drop it. But if you or anyone else is interested in
continuing to troubleshoot it, I'd be glad to assist.

Andy

>
> David
>
>>
>> So...Ubuntu thing? Or maybe just a 10.04 thing (yeah, I know it's old).
>>
>> Maybe this'll help someone.
>>
>> Thanks all.
>> Andy
>>
>
