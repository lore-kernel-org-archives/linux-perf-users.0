From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Weird instruction profiling
Date: Thu, 19 Feb 2015 00:38:36 +0100
Message-ID: <20150218233836.GB823@two.firstfloor.org>
References: <CAE40pddnqg-H-YqvyHodw1ME6W9_7et151+=O9y=S7sHB0an7w@mail.gmail.com>
 <87zj8bvzqn.fsf@tassilo.jf.intel.com>
 <54E5214B.5060408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:47145 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbbBRXii (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 18 Feb 2015 18:38:38 -0500
Content-Disposition: inline
In-Reply-To: <54E5214B.5060408@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, Brendan Gregg <brendan.d.gregg@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Wed, Feb 18, 2015 at 04:33:31PM -0700, David Ahern wrote:
> On 2/18/15 11:30 AM, Andi Kleen wrote:
> 
> >>I think Andi mentioned this to me last year -- that instruction
> >>profiling was no longer reliable.
> >
> >It never was.
> 
> Why is that? What about profiling with other hardware counters?

Practically all profiling has skid of some form.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
