From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Understanding timestamps in perf.data
Date: Thu, 3 Sep 2015 08:52:44 -0400 (EDT)
Message-ID: <alpine.DEB.2.20.1509030849190.3450@vincent-weaver-1.umelst.maine.edu>
References: <55E6C120.3030504@kit.edu> <55E6FCF9.60403@gmail.com> <55E71351.8010507@kit.edu> <55E72762.6030209@gmail.com> <alpine.DEB.2.20.1509021256550.575@vincent-weaver-1.umelst.maine.edu> <55E7F47C.2000403@kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:35527 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203AbbICMpU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 3 Sep 2015 08:45:20 -0400
Received: by ioiz6 with SMTP id z6so56049543ioi.2
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Sep 2015 05:45:19 -0700 (PDT)
In-Reply-To: <55E7F47C.2000403@kit.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Dennis Gnad <dennis.gnad@kit.edu>
Cc: David Ahern <dsahern@gmail.com>, linux-perf-users@vger.kernel.org

On Thu, 3 Sep 2015, Dennis Gnad wrote:
> 
> > as far as I can tell you can't really do this with perf (the -I option
> > only lets you get down to 100ms).
> 
> Which -I option do you mean? At least it's not available for my perf record
> (kernel 3.16).

The -I option is for "perf stat".  It lets you print the counters at a 
regular time interval.

Something like
	perf_3.16 stat -e cycles,instructions -I 100 sleep 1

> 
> > I ended up trying to write a custom program to do this, but it turns out
> > the perf sampling interface has really high overhead when doing this, and
> > the interrupt throttle kicks in which makes it useless.
> 
> Are you talking about the kernel interface or some interface of the perf tool?
> I think I need a minimum of 100Hz or 1000Hz, but it wouldn't be a problem if
> this is just collected in some kernel shared memory and in the end copied to
> userspace, or at a lower frequency.

The kernel itself has trouble going to 100Hz without causing a lot of 
overhead and at 1kHz the NMI overhead gets high enough that the kernel 
throttles things down.  I haven't investigated why that is, it might be a 
problem with how my tool is coded.  For now I just gave up and am making 
masurements at 10Hz.

Vince
