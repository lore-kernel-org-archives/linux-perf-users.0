From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFC] Add --show-total-period for perf annotate
Date: Mon, 25 May 2015 17:14:50 +0200
Message-ID: <20150525151450.GK19417@two.firstfloor.org>
References: <555F3F8A.6000204@suse.cz>
 <87mw0wc4vt.fsf@tassilo.jf.intel.com>
 <5562D33F.70706@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:48673 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbbEYPOw (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 25 May 2015 11:14:52 -0400
Content-Disposition: inline
In-Reply-To: <5562D33F.70706@suse.cz>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>

> >perf diff does not handle this? Especially with the differential
> >profiling options it should.
> 
> It does not work if you, in my case, compare ICC and GCC, where ICC uses a different mangling
> scheme for fortran modules. Moreover, situation can be more complicated if a compiler performs
> a bit different inlining decisions.

I suppose it could be enhanced with an input file that describes
equivalent functions. But yes wouldn't work for inlining.

> Good point. Can you please help me how to compute a function percentage usage in perf annotate ;) ?

I wouldn't use time at all. Just sum up periods and then compute the
percentage. The period sum computation already happens in the main view, and
is displayed there. So you only need to save that value somewhere and
then use it in the annotate display for another column.

# Samples: 24  of event 'cycles'
# Event count (approx.): 8856637

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
