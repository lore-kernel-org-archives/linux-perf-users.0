From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf probe an addr without debuginfo
Date: Mon, 29 Jun 2015 12:00:38 -0300
Message-ID: <20150629150038.GA1225@kernel.org>
References: <CAE40pdemFG8f7EB6SerUEGeK0G2qeztqzeLCnLigB3TdgY6G1Q@mail.gmail.com>
 <20150628154651.GA3953@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53545 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752514AbbF2PAm (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 29 Jun 2015 11:00:42 -0400
Content-Disposition: inline
In-Reply-To: <20150628154651.GA3953@localhost>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Benjamin King <benjaminking@web.de>, Brendan Gregg <brendan.d.gregg@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

Em Sun, Jun 28, 2015 at 05:46:51PM +0200, Benjamin King escreveu:
> Hi Brendan
> 
> >Is there a trick to getting perf to probe a user-level address without
> >debuginfo? Eg (on Linux 4.0):
> >[...]
> >I can do this using ftrace ok, eg, "p:tick_0x583 /root/tick:0x583"
> >works. Thanks,
> 
> Not quite what you have asked for, but you can add the probe via ftrace and
> then use it from perf. Probes from /sys/kernel/debug/tracing/uprobe_events
> will show up in 'perf list' as well.

Masami,

	Is this already possible?

- Arnaldo

P.S.: If you're not subscribed to this list, please consider it :-)
