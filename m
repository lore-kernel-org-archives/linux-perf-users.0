From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: [RFC 2/2] perf/core: change errno for sampling event not supported
 in hardware
Date: Tue, 10 May 2016 23:33:13 -0400 (EDT)
Message-ID: <alpine.DEB.2.20.1605102331420.15322@macbook-air>
References: <1462786660-2900-1-git-send-email-vgupta@synopsys.com> <1462786660-2900-3-git-send-email-vgupta@synopsys.com> <alpine.DEB.2.20.1605090923460.27332@macbook-air> <5730C79F.3060307@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:36064 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbcEKDdP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 10 May 2016 23:33:15 -0400
Received: by mail-io0-f195.google.com with SMTP id k129so4098241iof.3
        for <linux-perf-users@vger.kernel.org>; Tue, 10 May 2016 20:33:15 -0700 (PDT)
In-Reply-To: <5730C79F.3060307@synopsys.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vineet Gupta <vgupta@synopsys.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>, linux-perf-users@vger.kernel.org, peterz@infradead.org, acme@redhat.com, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@kernel.org

On Mon, 9 May 2016, Vineet Gupta wrote:

> On Monday 09 May 2016 07:24 PM, Vince Weaver wrote:
> > On Mon, 9 May 2016, Vineet Gupta wrote:
> > 
> >> This allows userspace to identify this case specifically from the
> >> catch all error msg it prints currently.
> >>
> >> This is an ABI change
> > 
> > An ABI change which will probably break things.
> 
> 
> Right thats what I feared. But hold on, I don't think we need to change the ABI to
> achieve what we want. Gosh why did I even take that path.
> 
> Currently the errno switch case in perf_evsel__open_strerror() in doesn't handle
> ENOTSUPP. So how about we add that - augmented with the same sample_period !0
> check to barf for lack of sampling support.
> 
> Do you see anything wrong with that ?

no, but it would be nice if one of the actual maintainers would chime in 
with an opinion.

In any case if ENOTSUPP is being returned to userspace I should update the 
perf_event manpage to reflect that.

Vince
