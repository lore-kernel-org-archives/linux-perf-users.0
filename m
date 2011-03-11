From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH] Add inverted call graph report support to perf tool
Date: Fri, 11 Mar 2011 13:07:25 +0100
Message-ID: <20110311120723.GC1826@nowhere>
References: <AANLkTi=vxgHe=dqz+xEPcZ9oBexM1jBxFz3sXA2DJEZA@mail.gmail.com>
 <20110307180619.GG1873@nowhere>
 <AANLkTi=rabeXE6m0wRo029jgqHLBaUGQcXYJriLewZeJ@mail.gmail.com>
 <20110310024355.GG2533@nowhere>
 <AANLkTikZxDyL-SW7FFbEd4skMNTVWeh7mGDTXfWkvEMR@mail.gmail.com>
 <20110311115657.GB1826@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:47570 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab1CKMH3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 11 Mar 2011 07:07:29 -0500
Content-Disposition: inline
In-Reply-To: <20110311115657.GB1826@nowhere>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Sam Liao <phyomh@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>

On Fri, Mar 11, 2011 at 12:57:01PM +0100, Frederic Weisbecker wrote:
> On Thu, Mar 10, 2011 at 10:32:43PM +0800, Sam Liao wrote:
> >  the sysprof that Ingo mentioned.
> 
> sysprof does something like that?
> 
> Note, another reason to avoid abusing the event.ip to group
> per caller, is that we could be able to:
> 
> perf report -s caller,sym -g caller
> 
> If we limit callchains to start from a given foo.so, this may
> sort hists per caller and then per endpoint.
> 
> If your library offers function func1, func2, etc... It will sort
> them per usage (func1 has been first used, then func2, etc...)

I meant func1 has been the most used, then came func2, etc...

> then per endpoint overhead (func1 most often sticks in strcpy(),
> then on read(), etc....).
> 
> Right?
> 
> That may or may not be useful. I don't know. In fact I don't
> want to take the responsibility to judge whether it's useful
> or not. Thus I prefer caller and ip to be two different
> properties of hist entries and not having one absusing the
> other, so that we don't prevent this feature to exist (or many
> other sort combinations I haven't imagined).
