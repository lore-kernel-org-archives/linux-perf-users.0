From: Arun Sharma <asharma@fb.com>
Subject: Re: perf_event validation tests
Date: Fri, 27 May 2011 15:45:44 -0700
Message-ID: <20110527224544.GA847@dev1756.snc6.facebook.com>
References: <alpine.DEB.2.00.1105271752090.5485@cl320.eecs.utk.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from outmail015.snc4.facebook.com ([66.220.144.147]:49983 "EHLO
	mx-out.facebook.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757132Ab1E0Wpp (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 May 2011 18:45:45 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1105271752090.5485@cl320.eecs.utk.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vweaver1@eecs.utk.edu>
Cc: linux-perf-users@vger.kernel.org

On Fri, May 27, 2011 at 05:53:41PM -0400, Vince Weaver wrote:
> Hello
> 
> a while back it was mentioned it would be nice to have some perf_event 
> validation tests.
> 
> I've posted some here:
>    http://web.eecs.utk.edu/~vweaver1/projects/perf-events/validation.html
> 

cache-references.c:

  pe.config=PERF_COUNT_HW_CACHE_REFERENCES;
  ...
      for(i=0; i<ARRAYSIZE; i++) {
        array[i]=(double)i;
      }
  ...
  if (!quiet) printf("\tL1 D accesseses: %lld %lf\n",count,aSumm);

PERF_COUNT_HW_CACHE_REFERENCES is counting LLC references on many
platforms. Did you mean to use PERF_COUNT_HW_CACHE_L1D here?

 -Arun
