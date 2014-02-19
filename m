From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Event not supported
Date: Wed, 19 Feb 2014 07:59:04 -0500 (EST)
Message-ID: <alpine.DEB.2.10.1402190754540.21724@vincent-weaver-1.um.maine.edu>
References: <CAOanW0NszteQapi6MzaUhkPpYA6yAe+bTc8Vkz033MDA3ynd_w@mail.gmail.com> <5303A4CF.3060200@gmail.com> <CAOanW0OsZXZU7Os=VrxA=s7SwRo+gK0qtpNjbX7E84fgL0swxg@mail.gmail.com> <5303B986.2070801@gmail.com>
 <CAOanW0OiK8QTgLxajx=pEaW4XWD94hnNUOf=-e=Y1ch2LA9j3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:43152 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbaBSM5K (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 19 Feb 2014 07:57:10 -0500
Received: by mail-qa0-f54.google.com with SMTP id i13so310599qae.13
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2014 04:57:09 -0800 (PST)
In-Reply-To: <CAOanW0OiK8QTgLxajx=pEaW4XWD94hnNUOf=-e=Y1ch2LA9j3A@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Martin Ichilevici de Oliveira <martin.i.oliveira@gmail.com>
Cc: Manuel Selva <selva.manuel@gmail.com>, linux-perf-users@vger.kernel.org

On Wed, 19 Feb 2014, Martin Ichilevici de Oliveira wrote:

> Manu,
> 
> Thank you very much for the reference and code. I checked my cpu and
> the Northbridge performance counter flag is set. So my processor does
> support profiling NB events. The question now is why it's saying it's
> not.
> 
> I realized that perf support for NB events was in fact only added on
> linux 3.9 [1], so I upgraded both my kernel and perf to 3.11. So
> that's out.

The support for AMD fam15h northbridge events was introduced in 3.9, but
the perf interface for it was changed in an incompatible way in 3.10.

To access the counters starting in 3.10 they are in a separate PMU.
You need to be root and you need to set the type field to the proper PMU.

You might be better off using something like libpfm4 to find out what aw 
values to use, trying to set them by hand is a hassle.

Vince
