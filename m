From: Martin Ichilevici de Oliveira <martin.i.oliveira@gmail.com>
Subject: Re: Event not supported
Date: Wed, 26 Feb 2014 17:44:40 -0300
Message-ID: <CAOanW0OzQnpt+cr6m8VFYj1CGPQoyecEQidt_5wZzxG4CAj_Gw@mail.gmail.com>
References: <CAOanW0NszteQapi6MzaUhkPpYA6yAe+bTc8Vkz033MDA3ynd_w@mail.gmail.com>
 <5303A4CF.3060200@gmail.com> <CAOanW0OsZXZU7Os=VrxA=s7SwRo+gK0qtpNjbX7E84fgL0swxg@mail.gmail.com>
 <5303B986.2070801@gmail.com> <CAOanW0OiK8QTgLxajx=pEaW4XWD94hnNUOf=-e=Y1ch2LA9j3A@mail.gmail.com>
 <alpine.DEB.2.10.1402190754540.21724@vincent-weaver-1.um.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35808 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbaBZUpV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 26 Feb 2014 15:45:21 -0500
Received: by mail-ie0-f178.google.com with SMTP id ar20so1158413iec.23
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2014 12:45:20 -0800 (PST)
In-Reply-To: <alpine.DEB.2.10.1402190754540.21724@vincent-weaver-1.um.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: Manuel Selva <selva.manuel@gmail.com>, linux-perf-users@vger.kernel.org

On Wed, Feb 19, 2014 at 9:59 AM, Vince Weaver <vincent.weaver@maine.edu> wrote:
>
> The support for AMD fam15h northbridge events was introduced in 3.9, but
> the perf interface for it was changed in an incompatible way in 3.10.
>
> To access the counters starting in 3.10 they are in a separate PMU.
> You need to be root and you need to set the type field to the proper PMU.
>
> You might be better off using something like libpfm4 to find out what aw
> values to use, trying to set them by hand is a hassle.
>
> Vince

Vince,

as I could understand, any tool that I use to profile AMD fam15h
northbridge events will depend on Linux 3.9 or newer, am I right? If
that's the case, would you say that currently Linux 3.9 is the
best/easiest way to go?

I've been playing with kernel versions trying to figure this out and a
few times the machine broke. Since that's a remote machine, that's a
hassle, as I have to ask people to fix it for me, so I'd like to
minimize the chances of problems. I'm currently on Linux 3.8.

Thanks,
-Martin
