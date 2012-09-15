From: Andi Kleen <andi@firstfloor.org>
Subject: Re: measuring offcore events on snb
Date: Sat, 15 Sep 2012 15:51:55 -0700
Message-ID: <m2txuyyk50.fsf@firstfloor.org>
References: <loom.20120915T194641-95@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28313 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601Ab2IOWwA (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 15 Sep 2012 18:52:00 -0400
In-Reply-To: <loom.20120915T194641-95@post.gmane.org> (Yuanfang Chen's message
	of "Sat, 15 Sep 2012 17:50:23 +0000 (UTC)")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Yuanfang Chen <tabloid.adroit@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Yuanfang Chen <tabloid.adroit@gmail.com> writes:

> Hi,
>
> I'm trying to measure offcore events on snb. (kernel 3.6.0-rc3).  For example 
> OFFCORE_RESPONSE.ALL_CODE_RD.LLC_HIT_N   is  0x10003C0244  according to 
> intel manual. so I tried
>
> perf stat -e r1b710003C0244 -- sleep 10
> perf stat -e r10003C02441b7 -- sleep 10
>
> both gives me 0, I did something wrong?

OFFCORE requires setting an external MSR. perf currently supports this
for its integrated events, as the support for setting the MSR directly
was not accepted. It works though to write the MSR manually through
/dev/cpu/*/msr, as long as you exclude conflicts manually. 
For details see the Intel SDM.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
