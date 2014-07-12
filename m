From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Interrupt caused by software events
Date: Sat, 12 Jul 2014 23:15:12 +0200
Message-ID: <20140712211512.GA29028@krava.redhat.com>
References: <20140709135418.GB5767@krava.redhat.com>
 <alpine.DEB.2.10.1407091002490.26636@vincent-weaver-1.umelst.maine.edu>
 <20140711142058.GA27580@gamayun>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15236 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbaGLVPX (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 12 Jul 2014 17:15:23 -0400
Content-Disposition: inline
In-Reply-To: <20140711142058.GA27580@gamayun>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Martin Ichilevici de Oliveira <martin.i.oliveira@gmail.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>, linux-perf-users@vger.kernel.org

On Fri, Jul 11, 2014 at 11:20:58AM -0300, Martin Ichilevici de Oliveira wrote:
> On Wed, Jul 09, 2014 at 10:05:55AM -0400, Vince Weaver wrote:
> > Not really sure by what you mean by "real-time", but you can theoretically 
> > set up the perf_event mmap buffer with a low threshold, and have it 
> > configured to send a signal to your program whenever an event comes in.
> > In theory you can get the PEBS-like info out that way.  It's going to have 
> > fairly high overhead though, especially if you set the sample rate high.

SNIP

> 
> Jiri:
> I'm under the impression I'd have to be in a kernel module (or in kernel
> mode in general) to use perf_event_create_kernel_counter(). Is that
> correct?

yep, thats kernel space only

jirka
