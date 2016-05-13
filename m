From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: [Perfapi-devel] Lack of aarch64 checks for perf events
 schedulability
Date: Fri, 13 May 2016 15:02:58 -0400 (EDT)
Message-ID: <alpine.DEB.2.20.1605131501210.19648@macbook-air>
References: <5ce079ab-2a31-36f1-713a-8b355888e73d@redhat.com> <alpine.DEB.2.20.1605131345560.19648@macbook-air> <8a3259e1-e78f-cb50-8bc7-963f924cda70@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f193.google.com ([209.85.213.193]:34952 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977AbcEMTDC (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 13 May 2016 15:03:02 -0400
Received: by mail-ig0-f193.google.com with SMTP id jn6so2234154igb.2
        for <linux-perf-users@vger.kernel.org>; Fri, 13 May 2016 12:03:01 -0700 (PDT)
In-Reply-To: <8a3259e1-e78f-cb50-8bc7-963f924cda70@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>, linux-perf-users@vger.kernel.org, PAPI Developers <perfapi-devel@cs.utk.edu>, Michael Petlan <mpetlan@redhat.com>

On Fri, 13 May 2016, William Cohen wrote:

> It still is worth it to check whether that silent failure behavior of 
> perf_event_open was expected.
> 
> According to the cortex a53 manual there are six general purpose 
> counters and one cycle counter.  Depending on how the event selection is 
> done it might not be able to use that cycle counter.  It might also be 
> taking a counter for a watchdog timer.  The Xgene machine I am using 
> state in the /var/log/messages:
> 
> hw perfevents: enabled with armv8_pmuv3 PMU driver, 5 counters available
> 
> How many counters does the dragonboard kernel claim the machine has?

My dragonboard reports:

hw perfevents: enabled with arm/armv8-pmuv3 PMU driver, 7 counters available

and my jetson-tx1 reports:

hw perfevents: enabled with arm/armv8-pmuv3 PMU driver, 7 counters available


Neither seems to have the NMI watchdog enabled, or at least it's not set 
in /proc/sys/kernel/nmi_watchdog

Vince
