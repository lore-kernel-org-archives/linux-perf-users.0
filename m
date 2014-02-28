From: Martin Ichilevici de Oliveira <martin.i.oliveira@gmail.com>
Subject: Re: Event not supported
Date: Fri, 28 Feb 2014 06:35:35 -0300
Message-ID: <CAOanW0NSAPa1opj-e=qQx=XNbTE-PERqUzyXtytCyNpyLMOECg@mail.gmail.com>
References: <CAOanW0NszteQapi6MzaUhkPpYA6yAe+bTc8Vkz033MDA3ynd_w@mail.gmail.com>
 <5303A4CF.3060200@gmail.com> <CAOanW0OsZXZU7Os=VrxA=s7SwRo+gK0qtpNjbX7E84fgL0swxg@mail.gmail.com>
 <5303B986.2070801@gmail.com> <CAOanW0OiK8QTgLxajx=pEaW4XWD94hnNUOf=-e=Y1ch2LA9j3A@mail.gmail.com>
 <alpine.DEB.2.10.1402190754540.21724@vincent-weaver-1.um.maine.edu>
 <CAOanW0OzQnpt+cr6m8VFYj1CGPQoyecEQidt_5wZzxG4CAj_Gw@mail.gmail.com> <alpine.DEB.2.10.1402261634260.1178@vincent-weaver-1.um.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:42646 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbaB1JgP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 28 Feb 2014 04:36:15 -0500
Received: by mail-ie0-f176.google.com with SMTP id rd18so1250141iec.7
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2014 01:36:15 -0800 (PST)
In-Reply-To: <alpine.DEB.2.10.1402261634260.1178@vincent-weaver-1.um.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-perf-users@vger.kernel.org

On Wed, Feb 26, 2014 at 6:38 PM, Vince Weaver <vincent.weaver@maine.edu> wrote:
> On Wed, 26 Feb 2014, Martin Ichilevici de Oliveira wrote:
>
>> as I could understand, any tool that I use to profile AMD fam15h
>> northbridge events will depend on Linux 3.9 or newer, am I right? If
>> that's the case, would you say that currently Linux 3.9 is the
>> best/easiest way to go?
>
> It depends where your kernel comes from.

I got it from the Ubuntu kernel ppa.

> If you're using a stock Linux kernel compiled yourself, then yes you
> probably need at least 3.9 for it to work.
>
> Sometimes if you're using a vendor supplied kernel they backport support
> for features, so it is not always clear what support there is in a kernel.
>
> Linux 3.9 and Linux 3.10 have very different amd15h northbridge support.
> If you're looking for long-term usability of your project/tool/research
> you probably want to jump straight to 3.10 so you don't have to make
> everything work on 3.9 and then change it all again when you move to newer
> kernels.
>
> Vince

I installed Linux 3.10 but it's still not clear to me how to profile
amd15h northbridge events, as I keep getting unsupported event
messages. Also, I tried using papi_component_avail and it says that
perf_events_uncore is disabled (no uncore PMUs or or events found).

In a previous message you mentioned

> To access the counters starting in 3.10 they are in a separate PMU.
> You need to be root and you need to set the type field to the proper PMU.

I tried with root but I wasn't sure how to set the type field to the
proper PMU. Could you please clarify? This has been a lot of trial and
(mostly) error. In the meantime, I went on to try your other
suggestion:

> You might be better off using something like libpfm4 to find out what aw
> values to use, trying to set them by hand is a hassle.

I tried using pfm_get_event_os_event_encoding() from libpfm4, but with
no success. The manpage for this function is from 2011 and most likely
lots has changed since. I've been reading the source to try to figure
something out, but I couldn't figure it out.

Any help is appreciated.

Thank you,
-Martin
