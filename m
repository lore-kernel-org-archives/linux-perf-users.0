From: Andi Kleen <andi@firstfloor.org>
Subject: Re: LBR unwinding for user defined dynamic trace point
Date: Wed, 16 Sep 2015 20:56:14 +0200
Message-ID: <20150916185614.GF1747@two.firstfloor.org>
References: <2495974.rH49Pff4SO@milian-kdab2>
 <874mivkcg2.fsf@tassilo.jf.intel.com>
 <3862406.HVDrYIDCMl@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:59366 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbbIPS4R (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 16 Sep 2015 14:56:17 -0400
Content-Disposition: inline
In-Reply-To: <3862406.HVDrYIDCMl@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Andi Kleen <andi@firstfloor.org>, 5A@linux.intel.com, linux-perf-users@vger.kernel.org

On Wed, Sep 16, 2015 at 11:55:22AM +0200, Milian Wolff wrote:
> On Tuesday, September 15, 2015 7:02:37 AM CEST Andi Kleen wrote:
> > Milian Wolff <milian.wolff@kdab.com> writes:
> > > When I do the same with the Dwarf unwinder, it works just fine. Using the
> > > LBR unwinder with a performance counter like instructions also works
> > > fine. Does anyone know what the issue is here?
> > 
> > LBR is only supported for PMU sampling at this point.
> 
> OK, thanks. Can you give me some more information on why that is? Is it 
> fundamentally not possible, or simply not yet implemented?

For LBR callgraph it could be implemented. For some other LBR usages
there would be limitations, as there is no LBR freezing for software
trace points.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
