From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Perf support for interpreted and Just-In-Time translated
 olanguages
Date: Wed, 10 Dec 2014 19:05:29 +0100
Message-ID: <20141210180529.GB6759@two.firstfloor.org>
References: <1417810736.5098.11.camel@oc0276584878.ibm.com>
 <CAE40pdcXt_gaCXD7n3UED4Y2_gdpH+A3S627TS-72xkbGDoNsA@mail.gmail.com>
 <20141209203419.GI4189@kernel.org>
 <87ppbs4h5k.fsf@tassilo.jf.intel.com>
 <20141209222203.GD8788@kernel.org>
 <20141210173228.GA6759@two.firstfloor.org>
 <54888569.30409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:40849 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932424AbaLJSFa (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 10 Dec 2014 13:05:30 -0500
Content-Disposition: inline
In-Reply-To: <54888569.30409@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Brendan Gregg <brendan.d.gregg@gmail.com>, Carl Love <cel@us.ibm.com>, Pekka Enberg <penberg@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Wed, Dec 10, 2014 at 10:39:53AM -0700, David Ahern wrote:
> On 12/10/14 10:32 AM, Andi Kleen wrote:
> >> From what I understood, how would it insert that event into the
> >>perf.data event stream? Only if it necessarily involved a new mmap, via
> >>the kernel, etc.
> >
> >That's the new interface to be defined.
> >
> >Just write a perf.data?
> 
> Pawel Moll's new ioctl -- assumming it gets committed.

We can't push large volume data -- like line numbers and executable code -
through a ioctl.

-Andi
