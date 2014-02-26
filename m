From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Event not supported
Date: Wed, 26 Feb 2014 16:38:21 -0500 (EST)
Message-ID: <alpine.DEB.2.10.1402261634260.1178@vincent-weaver-1.um.maine.edu>
References: <CAOanW0NszteQapi6MzaUhkPpYA6yAe+bTc8Vkz033MDA3ynd_w@mail.gmail.com> <5303A4CF.3060200@gmail.com> <CAOanW0OsZXZU7Os=VrxA=s7SwRo+gK0qtpNjbX7E84fgL0swxg@mail.gmail.com> <5303B986.2070801@gmail.com> <CAOanW0OiK8QTgLxajx=pEaW4XWD94hnNUOf=-e=Y1ch2LA9j3A@mail.gmail.com>
 <alpine.DEB.2.10.1402190754540.21724@vincent-weaver-1.um.maine.edu> <CAOanW0OzQnpt+cr6m8VFYj1CGPQoyecEQidt_5wZzxG4CAj_Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:38558 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbaBZVgN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 26 Feb 2014 16:36:13 -0500
Received: by mail-qa0-f53.google.com with SMTP id cm18so3129276qab.12
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2014 13:36:12 -0800 (PST)
In-Reply-To: <CAOanW0OzQnpt+cr6m8VFYj1CGPQoyecEQidt_5wZzxG4CAj_Gw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Martin Ichilevici de Oliveira <martin.i.oliveira@gmail.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>, Manuel Selva <selva.manuel@gmail.com>, linux-perf-users@vger.kernel.org

On Wed, 26 Feb 2014, Martin Ichilevici de Oliveira wrote:

> as I could understand, any tool that I use to profile AMD fam15h
> northbridge events will depend on Linux 3.9 or newer, am I right? If
> that's the case, would you say that currently Linux 3.9 is the
> best/easiest way to go?

It depends where your kernel comes from.

If you're using a stock Linux kernel compiled yourself, then yes you 
probably need at least 3.9 for it to work.

Sometimes if you're using a vendor supplied kernel they backport support 
for features, so it is not always clear what support there is in a kernel.

Linux 3.9 and Linux 3.10 have very different amd15h northbridge support.  
If you're looking for long-term usability of your project/tool/research 
you probably want to jump straight to 3.10 so you don't have to make 
everything work on 3.9 and then change it all again when you move to newer 
kernels.

Vince
