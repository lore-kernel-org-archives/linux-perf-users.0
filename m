From: Vince Weaver <vweaver1@eecs.utk.edu>
Subject: Re: perf_event validation tests
Date: Fri, 27 May 2011 22:03:52 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1105272159470.8159@cl320.eecs.utk.edu>
References: <alpine.DEB.2.00.1105271752090.5485@cl320.eecs.utk.edu> <20110527224544.GA847@dev1756.snc6.facebook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from jaguar.mail.utk.edu ([160.36.0.84]:60085 "EHLO
	jaguar.mail.utk.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675Ab1E1CD5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 May 2011 22:03:57 -0400
In-Reply-To: <20110527224544.GA847@dev1756.snc6.facebook.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: linux-perf-users@vger.kernel.org

On Fri, 27 May 2011, Arun Sharma wrote:

> On Fri, May 27, 2011 at 05:53:41PM -0400, Vince Weaver wrote:

> cache-references.c:
> 
>   pe.config=PERF_COUNT_HW_CACHE_REFERENCES;
>   if (!quiet) printf("\tL1 D accesseses: %lld %lf\n",count,aSumm);
> 
> PERF_COUNT_HW_CACHE_REFERENCES is counting LLC references on many
> platforms. Did you mean to use PERF_COUNT_HW_CACHE_L1D here?


probably.  That was a last minute addition.  I have a much more complete 
set of tests writted for PAPI and I'm trying to port over the ones that 
make sense to be perf-event direct.  Properly programming perf_event 
generalized cache events isn't documented very well though.

I've been distracted by the fact that my overflow tests start failing as 
of kernel 2.6.36 :(  I hadn't noticed because I was primarily developing 
the tests on 2.6.32 and 2.6.35 machines.

Vince
