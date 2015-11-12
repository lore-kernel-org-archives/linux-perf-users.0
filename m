From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: restricting counted/sampled events
Date: Thu, 12 Nov 2015 20:08:07 -0300
Message-ID: <20151112230807.GF7160@kernel.org>
References: <5644D7DA.7050200@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54027 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753239AbbKLXIM (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 Nov 2015 18:08:12 -0500
Content-Disposition: inline
In-Reply-To: <5644D7DA.7050200@suse.de>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Tony Jones <tonyj@suse.de>
Cc: linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>

Em Thu, Nov 12, 2015 at 10:18:02AM -0800, Tony Jones escreveu:

> I don't believe there is current support to do this,  but maybe I'm
> overlooking something?
 
> I'd like to be able to restrict the pmu (or filter results) to report
> counting/sampling between two arbitrary code points,  such as a
> tracepoint or kprobe.
 
> I believe it will require core perf changes and was curious on peoples
> thoughts?

Something like this:

https://lkml.org/lkml/2013/9/25/227

Jiri?

- Arnaldo
