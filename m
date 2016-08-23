From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Accessing sample data (like period) for trace events from python scripts
Date: Tue, 23 Aug 2016 11:42:54 +0900
Message-ID: <CAM9d7cjJ0H_7j=Y4nZiTVrEksWv+syY96k4VJqYv8R4p1W+EKQ@mail.gmail.com>
References: <12483222.2TZrqxLJ8H@agathebauer> <20160819013549.GA22968@sejong>
 <20160819015101.GB22968@sejong> <1994747.p0vVkFxHI8@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:36399 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756778AbcHWCnQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Aug 2016 22:43:16 -0400
Received: by mail-it0-f65.google.com with SMTP id j124so6646679ith.3
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Aug 2016 19:43:15 -0700 (PDT)
In-Reply-To: <1994747.p0vVkFxHI8@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

Hello Milian,

On Sun, Aug 21, 2016 at 5:30 AM, Milian Wolff <milian.wolff@kdab.com> wrote:
> On Freitag, 19. August 2016 10:51:01 CEST Namhyung Kim wrote:
>> On Fri, Aug 19, 2016 at 10:35:49AM +0900, Namhyung Kim wrote:
>> > On Wed, Aug 17, 2016 at 10:48:31AM +0200, Milian Wolff wrote:
>> > > On Wednesday, August 17, 2016 12:05:53 PM CEST Namhyung Kim wrote:
>> > > > Hi Milian,
>> > > >
>> > > > On Tue, Aug 16, 2016 at 08:42:01PM +0200, Milian Wolff wrote:
>> > > > > Hey all,
>> > > > >
>> > > > > It doesn't seem to be possible to access the period, tid and various
>> > > > > other
>> > > > > sample fields from a python (and perl?) script using `perf script`.
>> > > > > My
>> > > > > use-
>> > > > > case would be analyzing a perf data file created by perf inject
>> > > > > --sched-stat.
>> > > >
>> > > > I think you can access param_dict["sample"]["period"].
>> > >
>> > > No, that is not possible, but would be a viable solution as well.
>> >
>> > Sorry for late reply.  Oh, you wanted to access period of tracepoint
>> > but I guess it's always 1, no?
>>
>> OK, it seems sched_stat events have periods bigger than 1.  But you
>> can access it using 'runtime' or 'delay' field in the event too.  I
>> think sample data of tracepoint event is mostly meaningless and you
>> should access to the event fields for useful information.  That's why
>> it doesn't provide the info for tracepoint events, I guess.
>>
>> What do you specifically want to know from sample data?
>
> Using `perf inject --sched-stat`, I can get the sched_stat event period to the
> sched_switch event (which has the proper backtrace). That is the data I want
> to access. This is doable when I run:
>
> perf script -F event,period
>
> But it is not accessible from Perl or Python.
>
> Note: the runtime/delay fields are not translated by perf inject, it simply
> sets the period which is then used by the other perf tools.
>
> I really think it should be made possible to access that data from Python/
> Perl.

As I said, what you really want is 'runtime' or 'delay' and they are
already accessible from scripts.  The perf inject uses the period
directly since it knows it's same as the value of the fields but I'm
not sure it's the right way to do.  Anyway, if you want to make the
period accessible from scripts, you can add it in
util/scripting-engines/trace-event-python.c:python_process_tracepoint()
and the perl counterpart.

Thanks,
Namhyung
