From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: LBR unwinding for user defined dynamic trace point
Date: Wed, 16 Sep 2015 11:55:22 +0200
Message-ID: <3862406.HVDrYIDCMl@milian-kdab2>
References: <2495974.rH49Pff4SO@milian-kdab2> <874mivkcg2.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:43150 "EHLO mail.kdab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753811AbbIPJzZ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 16 Sep 2015 05:55:25 -0400
In-Reply-To: <874mivkcg2.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: 5A@linux.intel.com, linux-perf-users@vger.kernel.org

On Tuesday, September 15, 2015 7:02:37 AM CEST Andi Kleen wrote:
> Milian Wolff <milian.wolff@kdab.com> writes:
> > When I do the same with the Dwarf unwinder, it works just fine. Using the
> > LBR unwinder with a performance counter like instructions also works
> > fine. Does anyone know what the issue is here?
> 
> LBR is only supported for PMU sampling at this point.

OK, thanks. Can you give me some more information on why that is? Is it 
fundamentally not possible, or simply not yet implemented?

Thanks
-- 
Milian Wolff | milian.wolff@kdab.com | Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
