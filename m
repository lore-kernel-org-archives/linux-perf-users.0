From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: restricting counted/sampled events
Date: Mon, 16 Nov 2015 09:59:52 +0100
Message-ID: <20151116085952.GD5769@krava.brq.redhat.com>
References: <5644D7DA.7050200@suse.de>
 <20151112230807.GF7160@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37449 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245AbbKPI7z (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 16 Nov 2015 03:59:55 -0500
Content-Disposition: inline
In-Reply-To: <20151112230807.GF7160@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Tony Jones <tonyj@suse.de>, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Stephane Eranian <eranian@google.com>, Frederic Weisbecker <fweisbec@gmail.com>

On Thu, Nov 12, 2015 at 08:08:07PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Nov 12, 2015 at 10:18:02AM -0800, Tony Jones escreveu:
> 
> > I don't believe there is current support to do this,  but maybe I'm
> > overlooking something?
>  
> > I'd like to be able to restrict the pmu (or filter results) to report
> > counting/sampling between two arbitrary code points,  such as a
> > tracepoint or kprobe.
>  
> > I believe it will require core perf changes and was curious on peoples
> > thoughts?
> 
> Something like this:
> 
> https://lkml.org/lkml/2013/9/25/227
> 
> Jiri?

yep.. sounds like toggling ;-) this code was put aside ATM

not sure it'll be ressurected soon, but I remember Stephane asked
me about that some time ago (CC-ed), maybe he has more info

jirka
