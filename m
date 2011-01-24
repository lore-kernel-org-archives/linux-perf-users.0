From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: Perf ABI versioning
Date: Mon, 24 Jan 2011 18:26:55 +0100
Message-ID: <AANLkTinKfCxE1MYb6Am2kh98mS5K430egGqPTu1fwErD@mail.gmail.com>
References: <201101241704.01021.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62918 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318Ab1AXR04 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 24 Jan 2011 12:26:56 -0500
In-Reply-To: <201101241704.01021.trenn@suse.de>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Renninger <trenn@suse.de>
Cc: jean.pihet@newoldbits.com, acme@ghostprotocols.net, fweisbec@gmail.com, linux-perf-users@vger.kernel.org, mathieu.desnoyers@efficios.com, linux-trace-users@vger.kernel.org

On Mon, Jan 24, 2011 at 5:04 PM, Thomas Renninger <trenn@suse.de> wrote:
> Hi,
>
> as I recently cleaned up the power events with
> some format/abi adjustings...
>
> I realized that it was rather easy to adjust
> the stuff in drivers/tools/perf, because there
> are some nice facilities to query which events
> are available.
>
> I looked at pytimechart, there it's not that nice
> and convenient would be some kind of version number.

pytimechart does pattern matching to be able to work with different
version of the ftrace formats.
For a same trace type, it will try different trace format, until it
finds a match.
e.g.:
    ('irq_handler_entry', 'irq=%d handler=%s','irq','name'),
    ('irq_handler_entry', 'irq=%d name=%s','irq','name'),

The problem of this approach is obviously that you have to modify
pytimechart each time there is a new format, it cannot just look at
the trace format and just ignore new fields that it dont care of.

Please also note, that pytimechart also have a perf-python backend
that may not have such issues in dealing with new events fields, but
is actually sensible to event fields renaming.

> Would it make sense to introduce a trace
> ABI version number?
So as soon as pytimechart is the only user of this versionning, I'm
not sure it is really needed.

Regards,
Pierre
