From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Loop block overhead
Date: Wed, 30 Apr 2014 13:10:57 -0700
Message-ID: <87r44elgry.fsf@tassilo.jf.intel.com>
References: <CAPZR5J0vJU4X4H+f3gs3CK4duw6TaQuXS1q+xWkS0EgJ_DKiBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56577 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933727AbaD3UL0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 30 Apr 2014 16:11:26 -0400
In-Reply-To: <CAPZR5J0vJU4X4H+f3gs3CK4duw6TaQuXS1q+xWkS0EgJ_DKiBw@mail.gmail.com>
	(lhmaster's message of "Wed, 30 Apr 2014 11:26:11 -0300")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "lhmaster2 ." <lhmaster2@gmail.com>
Cc: linux-perf-users@vger.kernel.org

"lhmaster2 ." <lhmaster2@gmail.com> writes:

> Dear all,
>
> Is there any way to make perf report retrieve the total overhead due
> to loop blocks, like what is done with total function overhead?

perf has no idea what a loop is unfortunately.

You can use srcline as a sort key to account per line.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
