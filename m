From: Thomas Renninger <trenn@suse.de>
Subject: Perf ABI versioning
Date: Mon, 24 Jan 2011 17:04:00 +0100
Message-ID: <201101241704.01021.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46188 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752906Ab1AXQED (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 24 Jan 2011 11:04:03 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: tardyp@gmail.com
Cc: jean.pihet@newoldbits.com, acme@ghostprotocols.net, fweisbec@gmail.com, linux-perf-users@vger.kernel.org, mathieu.desnoyers@efficios.com, linux-trace-users@vger.kernel.org

Hi,

as I recently cleaned up the power events with
some format/abi adjustings...

I realized that it was rather easy to adjust
the stuff in drivers/tools/perf, because there
are some nice facilities to query which events
are available.

I looked at pytimechart, there it's not that nice
and convenient would be some kind of version number.

pytimechart can parse traces which are simply copied
away from /sys/kernel/debug/trace and to check for
available events and their format, one would have to
do a separate, ugly to implement, iteration of parsing.

Would it make sense to introduce a trace
ABI version number?
It would be enough to increase it by one every time
any event (don't know about other perf facilities) is
added, removed or modified.
Ideally the modifications are tracked with a short
description in a file like Documentation/trace/format.changes

Untested, but the patch at the end should simply add
a version number on top of
/sys/kernel/debug/trace file

While this should be enough for the kernel, perf record
would need to include it into it's binary perf.data format
as well?

Then userspace apps could easily test whether supported
events would be included at all, whether only a subset of
supported events were made available and which format they have.

Does this make sense?

Thanks,

    Thomas
