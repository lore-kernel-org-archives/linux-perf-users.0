From: Andi Kleen <andi@firstfloor.org>
Subject: Re: perf report: no output
Date: Wed, 09 Jan 2013 16:09:48 -0800
Message-ID: <m2sj69c303.fsf@firstfloor.org>
References: <E884EC9CD547324B8976A5D37317AC566D1A40D14A@APJ1XCHEVSPIN30.SYMC.SYMANTEC.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31514 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758148Ab3AJAKD (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 9 Jan 2013 19:10:03 -0500
In-Reply-To: <E884EC9CD547324B8976A5D37317AC566D1A40D14A@APJ1XCHEVSPIN30.SYMC.SYMANTEC.COM>
	(Mehul Choube's message of "Wed, 9 Jan 2013 06:24:36 -0800")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mehul Choube <Mehul_Choube@symantec.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Mehul Choube <Mehul_Choube@symantec.com> writes:

> Hi,
>
> I am trying perf on SLES 11 SP1 box (virtual machine).

perf-in-guest needs an emulated PMU, which is only available in the
latest kernels. SLES11 is far too old for it.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
