From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Bogus PMCs on Linux 3.13
Date: Sat, 12 Mar 2016 06:12:46 -0800
Message-ID: <87lh5nbx9d.fsf@tassilo.jf.intel.com>
References: <CAE40pdezFG8caviy4NMNjKkucoU2tp2cbjAPY-V66RJfUwe66g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:21217 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752565AbcCLOMs (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 12 Mar 2016 09:12:48 -0500
In-Reply-To: <CAE40pdezFG8caviy4NMNjKkucoU2tp2cbjAPY-V66RJfUwe66g@mail.gmail.com>
	(Brendan Gregg's message of "Wed, 9 Mar 2016 12:48:06 -0800")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

Brendan Gregg <brendan.d.gregg@gmail.com> writes:
>
>  Performance counter stats for 'dd if=/dev/zero of=/dev/null bs=1024k
> count=10k':
>
>      1,784,251,390 cycles                    [33.80%]
>    388,784,218,053 instructions              #   217.90  insns per
> cycle         [34.25%]

The obvious problem is that you're multiplexing. Multiplexing can cause
large measuring errors. Try to stop whoever else uses perf.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
