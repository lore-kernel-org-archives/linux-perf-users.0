From: Kim Phillips <kim.phillips@arm.com>
Subject: Re: Prevent Kernel from resetting cycle counter
Date: Fri, 8 Sep 2017 19:07:36 -0500
Message-ID: <20170908190736.de99a221c13be31c10103643@arm.com>
References: <CALk3wS2cEFTnMXoyhrzyC1R_np159B4evzDRBMNK7MsAsc8UFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757173AbdIIAHi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Sep 2017 20:07:38 -0400
In-Reply-To: <CALk3wS2cEFTnMXoyhrzyC1R_np159B4evzDRBMNK7MsAsc8UFA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jason Teplitz <jason@tensyr.com>
Cc: linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 6 Sep 2017 17:36:36 -0700
Jason Teplitz <jason@tensyr.com> wrote:

[adding linux-arm-kernel]

> I'm reading the armv8 PMU cycle counter from userspace and noticing
> that it gets periodically reset by something. Does anything inside the
> kernel reset these counters? I am not using perf, so I'm not sure why
> anything else would be touching them.

PMCCNTR only shows up in kernel perf/PMU and KVM code, so yes, no
reason for it to be reset, esp. if no arm-pmu interrupts are triggered.

Is the period constant, as if to suggest a wraparound?  Can you use
CNTVCT instead?

Thanks,

Kim
