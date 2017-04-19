From: Daniel John FitzGerald <daniel.j.fitzgerald@gmail.com>
Subject: Re: perf_event sampling a multithreaded process - ioctl with
 PERF_EVENT_IOC_SET_OUTPUT fails
Date: Wed, 19 Apr 2017 12:51:25 -0400
Message-ID: <e937e5f3-69c2-d845-8d3f-8a04b37fc177@gmail.com>
References: <d7635c6e-1d12-52d7-6b9f-b7c08d3a451f@gmail.com>
 <877f2go0xc.fsf@firstfloor.org>
 <87d101db-47df-8a4d-eb7b-9952bf0e06b8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34272 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967061AbdDSQvd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Apr 2017 12:51:33 -0400
Received: by mail-qt0-f178.google.com with SMTP id c45so24265301qtb.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Apr 2017 09:51:27 -0700 (PDT)
In-Reply-To: <87d101db-47df-8a4d-eb7b-9952bf0e06b8@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

*Sighs*

I found the problem.  I sent the wrong index counter as the
perf_event_open CPU... they were all being opened on different CPUs.

Thanks for the help :-)

Regards,
Dan FitzGerald

An enlightenment painter would paint a grand house on a lawn;
A romantic painter would paint it on fire.

On 04/19/2017 12:37 PM, Daniel John FitzGerald wrote:
> I'm confused as to why either would be the case; I'm specifying the same PID and same CPU number.  Is there any documentation out there on all of the restrictions to PERF_EVENT_IOC_SET_OUTPUT?
>
> For reference, attached is the source for my function that calls perf_event_open(), mmaps the ring buffer, and tries to do the ioctl.
>
> Regards,
> Dan FitzGerald
>
> An enlightenment painter would paint a grand house on a lawn;
> A romantic painter would paint it on fire.
>
> On 04/19/2017 11:46 AM, Andi Kleen wrote:
>> Daniel John FitzGerald <daniel.j.fitzgerald@gmail.com> writes:
>>> The problem that I am running into is that whenever I attempt to call
>>> ioctl() with PERF_EVENT_IOC_SET_OUTPUT, I get a -1 response with
>>> errno==EINVAL.
>> There are lots of restrictions to PERF_EVENT_IOC_SET_OUTPUT.
>>
>> Likely you're violating that it has to be on the same CPU or same task.
>>
>> -Andi
