From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Sample memory references with at least a given latency?
Date: Wed, 4 Feb 2015 09:33:50 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1502040932020.3342@vincent-weaver-1.umelst.maine.edu>
References: <54D21524.8010305@bsc.es> <CALbiyZyJhUNfMNOYwJ26P-Lq+3E_xM8SpZ9CG+WR70-n_k9x8A@mail.gmail.com> <54D22AB8.4060607@bsc.es>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:60310 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964925AbbBDOcd (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 4 Feb 2015 09:32:33 -0500
Received: by mail-qg0-f54.google.com with SMTP id z60so715632qgd.13
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Feb 2015 06:32:32 -0800 (PST)
In-Reply-To: <54D22AB8.4060607@bsc.es>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Harald Servat <harald.servat@bsc.es>
Cc: Manuel Selva <selva.manuel@gmail.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Wed, 4 Feb 2015, Harald Servat wrote:

>   I'm running Linux 3.11 but I don't see a way to setup the latency threshold
> there. My option flags include:
> 
>        -t, --type=
>        -D, --dump-raw-samples=
>        -x, --field-separator
>        -C, --cpu-list
> 
>   so I guess that this option is not implemented in perf (at least on 3.11).
> So I need to capture all the samples and then discard those that surpass that
> threshold.

No, PEBS support is very lacking with perf.

The soon-to-be-released 3.19 kernel does add support for 
PERF_SAMPLE_REGS_INTR which finally lets you get the PEBS register state 
from the PEBS sample, but I think many of the other advanced PEBS 
features are still missing.

Vince
