From: Jason Teplitz <jason@tensyr.com>
Subject: Re: Prevent Kernel from resetting cycle counter
Date: Tue, 12 Sep 2017 11:57:48 -0700
Message-ID: <CALk3wS0Wjo3dyYB09bFf+FrPZmWGAcCbv+Kh0i1V6KxnMYqHPw@mail.gmail.com>
References: <CALk3wS2cEFTnMXoyhrzyC1R_np159B4evzDRBMNK7MsAsc8UFA@mail.gmail.com>
 <20170908190736.de99a221c13be31c10103643@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:45606 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbdILS5u (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Sep 2017 14:57:50 -0400
Received: by mail-wm0-f49.google.com with SMTP id f199so2001742wme.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Sep 2017 11:57:49 -0700 (PDT)
In-Reply-To: <20170908190736.de99a221c13be31c10103643@arm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Kim Phillips <kim.phillips@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Kim,

Thanks for your response.
I talked a bit with Mark Rutland from Arm about this. He told me that
perf can reset or modify the cycle counter from kernelspace as it
pleases even if the user is not using perf. Reading the cycle counter
directly from userspace is not supported. The only supported way to
read the cycle counter is to go through the VDSO.

On Fri, Sep 8, 2017 at 5:07 PM, Kim Phillips <kim.phillips@arm.com> wrote:
> On Wed, 6 Sep 2017 17:36:36 -0700
> Jason Teplitz <jason@tensyr.com> wrote:
>
> [adding linux-arm-kernel]
>
>> I'm reading the armv8 PMU cycle counter from userspace and noticing
>> that it gets periodically reset by something. Does anything inside the
>> kernel reset these counters? I am not using perf, so I'm not sure why
>> anything else would be touching them.
>
> PMCCNTR only shows up in kernel perf/PMU and KVM code, so yes, no
> reason for it to be reset, esp. if no arm-pmu interrupts are triggered.
>
> Is the period constant, as if to suggest a wraparound?  Can you use
> CNTVCT instead?
>
> Thanks,
>
> Kim
