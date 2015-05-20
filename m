From: Andi Kleen <andi@firstfloor.org>
Subject: Re: event for speculative executed instruction
Date: Wed, 20 May 2015 07:23:08 -0700
Message-ID: <87k2w3ib03.fsf@tassilo.jf.intel.com>
References: <CAP5Bk4hT3sSRprB6JP7NYbuG7fQdsK70NMNqqtPgpJM0TzfaGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61611 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609AbbETOXJ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 20 May 2015 10:23:09 -0400
In-Reply-To: <CAP5Bk4hT3sSRprB6JP7NYbuG7fQdsK70NMNqqtPgpJM0TzfaGQ@mail.gmail.com>
	(Marina Moran's message of "Wed, 20 May 2015 10:45:42 -0300")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Marina Moran <esperandoelmilagro@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Marina Moran <esperandoelmilagro@gmail.com> writes:
>
> The intels are:
> Intel Xeon CPU E5-2630 0 @ 2.30GHz
> Intel Core2 Quad CPU    Q6600  @ 2.40GHz

What you can measure on the E5 is cycles stalled due to recovery
from mis-speculation. That is not quite the same, but somewhat related.
The toplev tool in pmu-tools (http://github.com/andikleen/pmu-tools) can
do this on top of perf for the E5. No support for the Core2.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
