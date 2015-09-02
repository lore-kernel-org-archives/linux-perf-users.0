From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Understanding timestamps in perf.data
Date: Wed, 2 Sep 2015 13:00:15 -0400 (EDT)
Message-ID: <alpine.DEB.2.20.1509021256550.575@vincent-weaver-1.umelst.maine.edu>
References: <55E6C120.3030504@kit.edu> <55E6FCF9.60403@gmail.com> <55E71351.8010507@kit.edu> <55E72762.6030209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38865 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725AbbIBQwx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 2 Sep 2015 12:52:53 -0400
Received: by igbut12 with SMTP id ut12so18815958igb.1
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Sep 2015 09:52:52 -0700 (PDT)
In-Reply-To: <55E72762.6030209@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Dennis Gnad <dennis.gnad@kit.edu>, linux-perf-users@vger.kernel.org

On Wed, 2 Sep 2015, David Ahern wrote:
> The counter values are not relevant for profiling. They are programmed to
> rollover and generate an NMI which causes the sample to be taken.

They might not be relevant for profiling, but some people use the perf 
counters for other tasks.

For example, when measuring phase plot behavior for a system, it would be 
great if you'd be able to say I want a snapshot sample of the cycle and 
instruction counters every 10ms, and then you can plot the CPI behavior of 
the system.

as far as I can tell you can't really do this with perf (the -I option 
only lets you get down to 100ms).

I ended up trying to write a custom program to do this, but it turns out 
the perf sampling interface has really high overhead when doing this, and 
the interrupt throttle kicks in which makes it useless.

It's a shame, as the old "pfmon" tool that came with perfmon2 could do 
this kind of measurement very easily.

Vince
