From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: Perf ABI versioning
Date: Mon, 24 Jan 2011 21:05:37 +0100
Message-ID: <20110124200534.GB2318@nowhere>
References: <201101241704.01021.trenn@suse.de>
 <AANLkTinbOkn15TM3CC9pMmceb1V_gxWm8EBMKLxnM50J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53514 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab1AXUHU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 24 Jan 2011 15:07:20 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinbOkn15TM3CC9pMmceb1V_gxWm8EBMKLxnM50J@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Thomas Renninger <trenn@suse.de>, tardyp@gmail.com, acme@ghostprotocols.net, linux-perf-users@vger.kernel.org, mathieu.desnoyers@efficios.com, linux-trace-users@vger.kernel.org

On Mon, Jan 24, 2011 at 06:28:54PM +0100, Jean Pihet wrote:
> Hi Thomas,
> 
> On Mon, Jan 24, 2011 at 5:04 PM, Thomas Renninger <trenn@suse.de> wrote:
> > Hi,
> >
> > as I recently cleaned up the power events with
> > some format/abi adjustings...
> >
> > I realized that it was rather easy to adjust
> > the stuff in drivers/tools/perf, because there
> > are some nice facilities to query which events
> > are available.
> >
> > I looked at pytimechart, there it's not that nice
> > and convenient would be some kind of version number.
> >
> > pytimechart can parse traces which are simply copied
> > away from /sys/kernel/debug/trace and to check for
> > available events and their format, one would have to
> > do a separate, ugly to implement, iteration of parsing.
> >
> > Would it make sense to introduce a trace
> > ABI version number?
> > It would be enough to increase it by one every time
> > any event (don't know about other perf facilities) is
> > added, removed or modified.
> > Ideally the modifications are tracked with a short
> > description in a file like Documentation/trace/format.changes
> >
> > Untested, but the patch at the end should simply add
> > a version number on top of
> > /sys/kernel/debug/trace file
> 
> If needed the ABI versioning should at least contain a major and minor
> number, i.e. 'x.y'.
> 
> The big question IMO is if it is needed or not. Is this a real problem
> in the userland? Are the apps always fitting the kernel ABI in a
> packaged distro?

This may help solving some tracepoint ABI issues that we have.
But let me add more tracing people and LKML in Cc in an answer to the explanation
of the idea, to discuss that more widely.
