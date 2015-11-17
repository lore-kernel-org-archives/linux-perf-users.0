From: "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: timing information with perf
Date: Tue, 17 Nov 2015 09:04:04 -0500
Message-ID: <20151117140404.GH25870@redhat.com>
References: <94D0C06D-C3A7-4BD1-9898-124EE0AA923D@netapp.com> <y0my4dxx1f4.fsf@fche.csb> <20151117001233.GC11993@kernel.org> <564AA5AE.1020303@gmail.com> <20151117133111.GF25870@redhat.com> <20151117133959.GN22729@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44253 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301AbbKQOEF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 17 Nov 2015 09:04:05 -0500
Content-Disposition: inline
In-Reply-To: <20151117133959.GN22729@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: David Ahern <dsahern@gmail.com>, "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi -

> > systemtap compiles down to native code, so execution is very fast and
> > CPU consumption is not a problem (better than streaming to userspace &
> > processing there).
> 
> That "better' is also not a simple answer, as there are several factors
> :-)

(I was referring only to CPU consumption in that context.)


> Anyway, those are different methods, applicable to different scenarios
> and sets of constraints, sometimes only one of these tools can be used,
> due to these constraints, sometimes one can try several and see how they
> fare.

That's 100% right.


- FChE
