From: David Ahern <dsahern@gmail.com>
Subject: Re: Getting started with perf; a couple of questions
Date: Fri, 07 Jun 2013 09:05:41 -0600
Message-ID: <51B1F6C5.3060302@gmail.com>
References: <CAJLXCZTs4i0P3wA78u25aCt-rfcsBNQ8t0QSsbWazQyoV-XdLA@mail.gmail.com> <51A83824.1090907@gmail.com> <CAJLXCZTzRdLYmcRVTO_AeRawmZ55AtdABcKpu5T5A-Z89iHnbA@mail.gmail.com> <CAJLXCZTN1xLXk79kh5i8WbJBB+4sh0Qs1v+PndhLKSrPPvZ2wQ@mail.gmail.com> <51B09633.2040204@gmail.com> <CAJLXCZSE=LWW8PxTAs4yPAQsmwQjVF=ehGCTKbUWF3rCDF-+7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:61959 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298Ab3FGPF5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 7 Jun 2013 11:05:57 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa11so2622850pad.33
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Jun 2013 08:05:57 -0700 (PDT)
In-Reply-To: <CAJLXCZSE=LWW8PxTAs4yPAQsmwQjVF=ehGCTKbUWF3rCDF-+7w@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andrew Davidoff <davidoff@qedmf.net>
Cc: linux-perf-users@vger.kernel.org

On 6/6/13 12:26 PM, Andrew Davidoff wrote:
> On Thu, Jun 6, 2013 at 8:01 AM, David Ahern <dsahern@gmail.com> wrote:
>>
>> It's a VM and not running on KVM so there is no PMU which means the -e
>> cycles is most likely falling back to -e cpu-clock. You should see this in a
>> message with the -v flag on record. perf-script should dump out the events
>> and show cpu-clock versus cycles.
>>
>> Based on that I suggest trying -e cpu-clock on your original host. If that
>> works then something is messed up with the pmu config on the host.
>
> Thanks. It wasn't clear to me if a VM had the same access to the PMU
> that a non-virtualized host would. But I guess that might explain why
> a bunch of events I'd expect samples for didn't have any (ex:
> iTLB-load-misses), even on the VM that did record some samples?
>

The hypervisor needs to expose a PMU to the guest. AFAIK KVM is the only 
one that does that. Without the PMU you do not get H/W based events.

> I re-ran the record on the VM with -v and did see the message about
> falling back to cpu-clock-ticks, but only after I added the cycles
> even to my events list. Which actually leads into a question regarding
> event sampling.

So perf record -v does not show the fallback? The default event has been 
'cycles' from the beginning I believe. Only if cycles is not supported 
does it fallback to cpu-clock. You should not have to add '-e cycles'. 
Well, at least that is the way it is for the code in Linus' tree.

>
> The documentation I have found mentions a "default sampling event"
> (cycles) but doesn't explain the concept of a sampling event in
> detail. Does each event listed with -e have its own sample period/rate
> that can be adjusted? Or do -c or -F apply to all events sampled? Even
> I don't sample cycles, is the default sampling rate still 1000Hz for
> all events sampled in the absence of -c or -F?

Unless it crept it with some changes Jiri made (I have not been using 
the fancy -e declarations) I believe there is a single -c/-F argument 
and it applies to all events. ie., all events have the same sampling 
interval.

The default is 1000 Hz (equivalent to -F 1000). -c specifies the period 
-- which is the similar to specifying -F.

     OPT_U64('c', "count", &record.opts.user_interval, "event period to 
sample"),
...
     OPT_UINTEGER('F', "freq", &record.opts.user_freq, "profile at this 
frequency"),


And then configuring the attributes for the event only 1 of the 2 is 
used with frequency taking precedent:

    if (!attr->sample_period || (opts->user_freq != UINT_MAX &&
                      opts->user_interval != ULLONG_MAX)) {
         if (opts->freq) {
             perf_evsel__set_sample_bit(evsel, PERIOD);
             attr->freq      = 1;
             attr->sample_freq   = opts->freq;
         } else {
             attr->sample_period = opts->default_interval;
         }
     }

>
> Regarding using -e cpu-clock on the original host, that doesn't appear
> to have changed the perf record behavior. Neither does using -e
> cycles. And even with -v on record, I didn't see any additional
> messaging (like fall back to cpu-clock). But I do still get sample
> data if I run with -a. *shrug*.

What command lines are you running? I seem to recall this is a 2.6.32 
kernel and basic perf record commands should work fine -- perf record -a 
or perf record -p <pid>. Perhaps something snuck in recently that broke 
compat with 2.6.32. You can determine that by running the perf command 
that comes with that version of Ubuntu and then newer ones -- 3.0, 3.4, 
3.8 would be a good distribution of versions to start with if you want 
to get to the bottom of it.

David
