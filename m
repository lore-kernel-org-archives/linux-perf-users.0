Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C361C45FFDE;
	Thu, 30 Jul 2026 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437730; cv=none; b=IaLuHRLZHoZbTksmElxhrDvYZrPbz+z4ZRYLPONbXlysBp7Hl9lsuNq4sojxgABwPm+v0jIjgPmAMUpPwQFu/UZ8F6y2VauHrLTitlVt70geQIN+fGop9h1csl8uV4IrPCVt5lCSoFrbsnW0Qn67vZEBMcLgCs5Z3r5LReQTaAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437730; c=relaxed/simple;
	bh=loIZAK97XRsiUP1CQKjpD1ApD78ONwVL+m9DVB39Dwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rFcG6gfSzZABkSOcs5KFbyn8ixtRx1QnO5ENavpv2hIhFZDcvHP9PojGon4kcOHg7mbk6Y/rqP2VtMCq2a7lJVlLTs/60XyDNQh1b2ozTlci6e0dXFmJXj9DlQK2QseD0j1uev/h3kChihlEo83RSiY+AwRI+ssr9LwjrNTT8zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU17bELw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU17bELw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799311F000E9;
	Thu, 30 Jul 2026 18:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785437728;
	bh=KOfQr6vuAx3pCbgbpF8blvGnVB/C8aNcay486WNbzaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BU17bELwtO6MVYHEfcvPgvlnLWkFbbvLKZBkcVb9nHPdNoP1jRusyUN0gGnWx0PJu
	 0OXwxOV4d1NMPHKYIA75X2rSVNL2h6DnXcaEqFvbMXMczG6RT0VhxaC7fBeFEAOjWv
	 TovZJG+BAhEfPEMyw8ZN6MJ5Cmif/Wym1PzGwOaDHdOWcjIUHy8GTQ0ZtoK6ovXfRH
	 zQOPgHz613drquhiC6qSf7RLBazd8sJo0jWg/Gei/ajqOpKhD0V7vfVVwUXK+9PRVl
	 9BxzUdaqCJsBojAOYZe9dgW7sVdjQhxxcNnoOxPVaDQ49whXaxhROLGLk5pbDMJkcw
	 4aVJKbZ3PvEMA==
Date: Thu, 30 Jul 2026 19:55:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-perf-users@vger.kernel.org, will@kernel.org, mark.rutland@arm.com,
 dave@stgolabs.net, sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/9] perf/cxl: Keep the overflow interrupt pinned to
 the managed CPU
Message-ID: <20260730195523.6cf9dd2b@jic23-huawei>
In-Reply-To: <778b651c-ab2e-41d6-a0d6-5da144989df7@arm.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
	<20260729145555.3919550-6-dave.jiang@intel.com>
	<778b651c-ab2e-41d6-a0d6-5da144989df7@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 12:46:24 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 29/07/2026 3:55 pm, Dave Jiang wrote:
> > The PMU pins its overflow interrupt to info->on_cpu in the hotplug
> > online/offline callbacks, but requests it with only IRQF_SHARED |
> > IRQF_NO_THREAD. Without IRQF_NOBALANCING, irqbalance or a userspace
> > smp_affinity write can move the interrupt to another CPU. cxl_pmu_irq()
> > then runs cxl_pmu_read() there, doing local64_cmpxchg()/local64_add() on
> > hwc->prev_count and event->count concurrently with the managing CPU;
> > local64_t is only atomic against same-CPU access, so counts get
> > corrupted.
> > 
> > Add IRQF_NOBALANCING so the pinning done in the hotplug callbacks holds,
> > matching other uncore-style PMU drivers.
> > 
> > Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> > Reported-by: sashiko-bot@kernel.org
> > Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> >   drivers/perf/cxl_pmu.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> > index d1e810601e36..8b89db8f4d68 100644
> > --- a/drivers/perf/cxl_pmu.c
> > +++ b/drivers/perf/cxl_pmu.c
> > @@ -888,7 +888,8 @@ static int cxl_pmu_probe(struct device *dev)
> >   	if (!irq_name)
> >   		return -ENOMEM;
> >   
> > -	rc = devm_request_irq(dev, irq, cxl_pmu_irq, IRQF_SHARED | IRQF_NO_THREAD,
> > +	rc = devm_request_irq(dev, irq, cxl_pmu_irq,
> > +			      IRQF_SHARED | IRQF_NO_THREAD | IRQF_NOBALANCING,  
> 
> Bah, sorry, now I see I misspoke just now on the other patch - PMUs 
> really _shouldn't_ permit shared IRQs, but this one does :(
> 
> Thus it's all well and good to prevent userspace changing affinity, but 
> it doesn't help _all_ that much if other drivers can still legitimately 
> change it behind our backs...

We do in theory know what drivers might do that (and today I don't think
any but this one do).  In practice though I think two instances of this
on same device could foul things up.

As per other suggestion, Dave would you mind just dropping shared support
for now?  Can revisit if anyone built that insane hardware.

J
> 
> Thanks,
> Robin.
> 
> >   			      irq_name, info);
> >   	if (rc)
> >   		return rc;  
> 

