From: William Cohen <wcohen@redhat.com>
Subject: Re: [Perfapi-devel] Lack of aarch64 checks for perf events
 schedulability
Date: Fri, 13 May 2016 14:28:57 -0400
Message-ID: <8a3259e1-e78f-cb50-8bc7-963f924cda70@redhat.com>
References: <5ce079ab-2a31-36f1-713a-8b355888e73d@redhat.com>
 <alpine.DEB.2.20.1605131345560.19648@macbook-air>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47712 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172AbcEMS27 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 13 May 2016 14:28:59 -0400
In-Reply-To: <alpine.DEB.2.20.1605131345560.19648@macbook-air>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-perf-users@vger.kernel.org, PAPI Developers <perfapi-devel@cs.utk.edu>, Michael Petlan <mpetlan@redhat.com>

On 05/13/2016 01:58 PM, Vince Weaver wrote:
> On Fri, 13 May 2016, William Cohen wrote:
> 
>> When running the PAPI testsuite on RHEL for aarch64 Michael Petlan
>> found that the test overflow_allcounters was failing.  I investigated
>> and it looks like the the RHEL for aarch64 linux kernel perf support
>> suffers from a problem similar to MIPS kernels where perf_event_open
>> doesn't properly check that events can be scheduled together; then a
>> later read of the counters will fail.  This has been observed on the
>> RHEL for aarch64 4.5.0 based kernel. I have not tried this on the
>> latest kernel, so I don't know if this is still a problem with newer
>> kernels.
> 
> Let me see, yes I can reproduce this on my arm64 dragonboard running Linux 
> 3.16.

Hi Vince,

Thanks for trying it out on the dragonboard.  I have a dragonboard 410c at home also and will give that a try too.

> 
> Your fix does fix things in that the test runs but it fails for other 
> reasons at the validation stage.

I saw at times that the test fail the validation because there were a the number of samples wasn't exactly the count expected.

> 
> Only 6 out of 7 counters are used, but it's picking a weird set of 
> counters to use for the test.  I forget what overflow_allcounters actually
> does.
> 
> I doubt it's worth the trouble of trying to get this fixed at the Linux 
> level but it would be interesting to see why the 7th counter can't be 
> scheduled.
> 
> Vince
> 

It still is worth it to check whether that silent failure behavior of perf_event_open was expected.

According to the cortex a53 manual there are six general purpose counters and one cycle counter.  Depending on how the event selection is done it might not be able to use that cycle counter.  It might also be taking a counter for a watchdog timer.  The Xgene machine I am using state in the /var/log/messages:

hw perfevents: enabled with armv8_pmuv3 PMU driver, 5 counters available

How many counters does the dragonboard kernel claim the machine has?

-Will
