From: Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] s390: Add support for z13
Date: Thu, 13 Oct 2016 14:42:01 +0200 (CEST)
Message-ID: <alpine.LRH.2.20.1610131424000.14258@Diego>
References: <m3mvnwu1cy.fsf@oc1027705133.ibm.com> <bb9acd86-0c7c-7291-00c1-1c6ad8576232@redhat.com> <m360p8m87d.fsf@oc1027705133.ibm.com> <d2177055-a1c3-7562-f555-bd239836af3e@redhat.com> <alpine.LRH.2.20.1610042254100.6819@Diego> <m3vax6lkon.fsf@oc1027705133.ibm.com>
 <alpine.LRH.2.20.1610121546540.14258@Diego> <44aa1856-f35d-4077-df94-c588d5b3b1e2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753663AbcJMMmf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Oct 2016 08:42:35 -0400
In-Reply-To: <44aa1856-f35d-4077-df94-c588d5b3b1e2@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>, Andreas Arnez <arnez@linux.vnet.ibm.com>, Andreas Krebbel <krebbel@linux.vnet.ibm.com>, oprofile-list@lists.sf.net, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Wed, 12 Oct 2016, William Cohen wrote:
> On 10/12/2016 10:01 AM, Michael Petlan wrote:
>> On Wed, 5 Oct 2016, Andreas Arnez wrote:
>>>
>>> IIRC, I just performed a quick smoke test before submitting this patch;
>>> and oprofile didn't crash.  Other than that, I don't really know what
>>> works and what doesn't.
>>>
>
> Hi Andreas and Andreas,
>
> Is there support for IBM z13 perf counters in the upstream linux kernel?  I didn't see perf support for IBM z13 in the mainline kernel git repository.
>
> There is a difference between the kernel and oprofile is the s390 identification.  The kernel is using hex numbers such as 0x2817 and 0x2818 for Z196 identification (http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/s390/kernel/perf_cpum_cf_events.c#n303), but oprofile is reading the numbers as decimal for idenfication (https://sourceforge.net/p/oprofile/oprofile/ci/master/tree/libop/op_cpu_type.c).  oprofile should also be using hex numbers like the kernel.

I have looked at this and although it is not ideal, it works OK in OProfile,
since it reads the numbers from string, thus it works with decimals.

I have also checked that zEC12 detection works correctly with 1.1.

Michael

>
> -Will
>>
