From: William Cohen <wcohen@redhat.com>
Subject: Re: [PATCH] s390: Add support for z13
Date: Thu, 13 Oct 2016 14:23:07 -0400
Message-ID: <d4aeb84d-892d-3077-6f70-15b7536b1ba5@redhat.com>
References: <m3mvnwu1cy.fsf@oc1027705133.ibm.com>
 <bb9acd86-0c7c-7291-00c1-1c6ad8576232@redhat.com>
 <m360p8m87d.fsf@oc1027705133.ibm.com>
 <d2177055-a1c3-7562-f555-bd239836af3e@redhat.com>
 <alpine.LRH.2.20.1610042254100.6819@Diego>
 <m3vax6lkon.fsf@oc1027705133.ibm.com>
 <alpine.LRH.2.20.1610121546540.14258@Diego>
 <44aa1856-f35d-4077-df94-c588d5b3b1e2@redhat.com>
 <m3eg3kcjk4.fsf@oc1027705133.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934923AbcJMSXI (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Oct 2016 14:23:08 -0400
In-Reply-To: <m3eg3kcjk4.fsf@oc1027705133.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andreas Arnez <arnez@linux.vnet.ibm.com>
Cc: Michael Petlan <mpetlan@redhat.com>, Andreas Krebbel <krebbel@linux.vnet.ibm.com>, oprofile-list@lists.sf.net, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On 10/13/2016 12:14 PM, Andreas Arnez wrote:
> On Wed, Oct 12 2016, William Cohen wrote:
> 
>> Is there support for IBM z13 perf counters in the upstream linux
>> kernel?  I didn't see perf support for IBM z13 in the mainline kernel
>> git repository.
> 
> To my understanding, there is currently no support for z13-specific
> counters, but generic counters should still work.  This certainly limits
> the number of available counters on z13 significantly.
> 
> --
> Andreas
> 

Hi Andreas,

In the past on x86_64 machine if the cpu wasn't identified the performance monitoring hardware would be not used at all. The upstream code arch/s390/kernel/perf_cpum_cf_events.c it doesn't identify the z13, but it does look like it falls back to cpumcf_pmu_event_attr array of events.  However, I don't have much experience running things on IBM series machine, so want to verify that things are working on it.

-Will
