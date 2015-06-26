From: Andi Kleen <andi@firstfloor.org>
Subject: Re: perf stat -T now giving "not counted" when it used to work (failed PMU event multiplexing?)
Date: Fri, 26 Jun 2015 15:35:28 -0700
Message-ID: <878ub6ayj3.fsf@tassilo.jf.intel.com>
References: <ECC506C0-01C8-4527-82CE-968D852D46B8@cs.hmc.edu>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35956 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752124AbbFZWfa (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 26 Jun 2015 18:35:30 -0400
In-Reply-To: <ECC506C0-01C8-4527-82CE-968D852D46B8@cs.hmc.edu>
	(M. E. O'Neill's message of "Sun, 21 Jun 2015 13:31:02 -0700")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "M.E. O'Neill" <oneill@cs.hmc.edu>
Cc: linux-perf-users@vger.kernel.org

"M.E. O'Neill" <oneill@cs.hmc.edu> writes:

> Back in February, I could gather performance data and get results like this with perf stat -T:

Two common reasons are:

- you got updated to a microcode version that disabled TSX on pre E7 Haswell
systems (check "grep rtm /proc/cpuinfo"). If yes downgrading again
should make it work again.

- You have the nmi watchdog enabled:
(as root) echo 0 > /proc/sys/kernel/nmi_watchdog

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
