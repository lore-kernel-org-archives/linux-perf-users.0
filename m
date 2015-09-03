From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Understanding timestamps in perf.data
Date: Thu, 3 Sep 2015 11:17:08 -0400 (EDT)
Message-ID: <alpine.DEB.2.20.1509031112440.3911@vincent-weaver-1.umelst.maine.edu>
References: <55E6C120.3030504@kit.edu> <55E6FCF9.60403@gmail.com> <55E71351.8010507@kit.edu> <55E72762.6030209@gmail.com> <alpine.DEB.2.20.1509021256550.575@vincent-weaver-1.umelst.maine.edu> <55E7F47C.2000403@kit.edu> <alpine.DEB.2.20.1509030849190.3450@vincent-weaver-1.umelst.maine.edu>
 <55E85D5E.90400@kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:33411 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755226AbbICPJk (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 3 Sep 2015 11:09:40 -0400
Received: by igbkq10 with SMTP id kq10so16760931igb.0
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Sep 2015 08:09:39 -0700 (PDT)
In-Reply-To: <55E85D5E.90400@kit.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Dennis Gnad <dennis.gnad@kit.edu>
Cc: David Ahern <dsahern@gmail.com>, linux-perf-users@vger.kernel.org

On Thu, 3 Sep 2015, Dennis Gnad wrote:

> In the meantime I got some information for the x86 architecture. There, the
> performance counters can be read directly in userspace by the interface over
> MSR's similar to readmsr/msrtool, where a reliable interval of <10ms can be
> achieved. [1]

this is probably getting a bit off topic for linux-perf-users, but yes, I 
was doing similar work recently.  I was trying to validate the RAPL 
values (which are only estimates, not actual sensor results, on most 
CPUs).  This involved trying to read the RAPL and perf counters at a high 
rate of speed.

And yes, it seems that reading the MSRs directly from userspace has a lot 
less overhead than trying to use the perf_event sampling interface.  I had 
hoped that having an in-kernel ring buffer would be faster than just 
manually dumping the results to disk continually from userspace, but maybe 
NMI overhead is just too high.

Vince
