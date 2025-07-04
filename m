Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EAC2BE04F
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Jul 2025 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651276; cv=none; b=n9w6Z0Y3fEHf80o7Ukaefk8RfgRgP5xKo0DHtfdTcIAi3Bl6R+5XCxJKr7205zvUFWhcnQa1oKTvfGGjq2QlaSflkj6Y9qAHNB1ATtnCUTKmFgPCS0h6gcRH4ld3emAZ04Teqkykp5Dl4um5Yh/Zq7/avzQUnSid75Az/7gUEOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651276; c=relaxed/simple;
	bh=YAUeYpwbxF/7wR9pYBDXep/g0jHNYKvIfO0SedYh2vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EB2SYdZd44iioBogaHMHgIjTFVyUXZ5ByN/PKrk8uQOpG2W/qY7TKh5pUAFpLi5AWLtX8RxTwxaUxaH/MKjuIJarmDzbykNhhWrAFk/NZncrA6TWwvFcZCxu3uXz6CYTKvcpGrKmH/MtX2e3EGUK/CxCGRj5MYaUWx4ZBB61asg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ha/v49Zv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ha/v49Zv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CB4C4CEE3;
	Fri,  4 Jul 2025 17:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751651275;
	bh=YAUeYpwbxF/7wR9pYBDXep/g0jHNYKvIfO0SedYh2vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ha/v49Zv1/DefS1tQAJqt1oZ2cgZ4HTenqTpWJBaHAc4nH2lE24Oa82gJScZ9SaVP
	 znWJeDPdxfuBPhLxaWh3PN8cy5JsJRlzGkgUBz6kmum7D3AK9cAqicscL4hw3uqgVI
	 B/TjDsC+jHLIQIWRx+z1vP73SEfNE85TkcRk6wM4twDJwd4KlS+usgC/+4qriitb/H
	 pDDcfdfisxb3mJGlQIhx3a0UP7WXF7j+EUUXr6MAbNOLm/T/XcAJg/yC7ZneQUKHEN
	 zEr1DDLrCHaDtXbIxd8E2BBKUxSeQFeA76asneubv5jHMlU3QXLn3d1IuoFXgUmNFc
	 Mbk7oDFlfQFeg==
Date: Fri, 4 Jul 2025 18:47:50 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, allen.wang@hj-micro.com,
	peter.du@hj-micro.com, andy.xu@hj-micro.com
Subject: Re: [PATCH 3/3] perf/arm-ni: Support sharing IRQs within an NI
 instance
Message-ID: <aGgTxjcl9HA4S2Bg@willie-the-truck>
References: <cover.1747149165.git.robin.murphy@arm.com>
 <c7ac53d0f608d92d96e4e2827e253a9cb2a337bb.1747149165.git.robin.murphy@arm.com>
 <20250519122956.GA16848@willie-the-truck>
 <91c20c05-9607-4f98-ba00-a70b85862e60@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91c20c05-9607-4f98-ba00-a70b85862e60@arm.com>

On Mon, May 19, 2025 at 03:57:31PM +0100, Robin Murphy wrote:
> On 19/05/2025 1:29 pm, Will Deacon wrote:
> > On Tue, May 13, 2025 at 04:39:00PM +0100, Robin Murphy wrote:
> > > From: Shouping Wang <allen.wang@hj-micro.com>
> > > 
> > > NI-700 has a distinct PMU interrupt output for each Clock Domain,
> > > however some integrations may still combine these together externally.
> > > The initial driver didn't attempt to support this, in anticipation of a
> > > more general solution for IRQ sharing between system PMU instances, but
> > > that's still a way off, so let's make this intermediate step for now to
> > > at least allow sharing IRQs within an individual NI instance.
> > > 
> > > Now that CPU affinity and migration are cleaned up, it's fairly
> > > straightforward to adopt similar logic to arm-cmn, to identify CDs with
> > > a common interrupt and loop over them directly in the handler.
> > > 
> > > Signed-off-by: Shouping Wang <allen.wang@hj-micro.com>
> > > [ rm: Rework for affinity handling, cosmetics, new commit message ]
> > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > ---
> > >   drivers/perf/arm-ni.c | 78 ++++++++++++++++++++++++++++---------------
> > >   1 file changed, 51 insertions(+), 27 deletions(-)

[...]

> > > @@ -593,6 +589,30 @@ static void arm_ni_probe_domain(void __iomem *base, struct arm_ni_node *node)
> > >   	node->num_components = readl_relaxed(base + NI_CHILD_NODE_INFO);
> > >   }
> > > +static int arm_ni_init_irqs(struct arm_ni *ni)
> > > +{
> > > +	int err;
> > > +
> > > +	ni_for_each_cd(ni, cd) {
> > > +		for (struct arm_ni_cd *prev = cd; prev-- > ni->cds; ) {
> > > +			if (prev->irq == cd->irq) {
> > > +				prev->irq_friend = cd - prev;
> > 
> > Can't this race with the read of `irq_friend` in the interrupt handler?
> 
> Not in any way that matters. Any IRQ at this point would be a spurious one
> left latched at the interrupt controller after we've already reset all the
> PMUs. The handler can hardly observe a torn partial store of 1 byte, so
> either it'll see a valid irq_friend or none. Either way we'll eventually
> return IRQ_NONE, EOI the phantom IRQ and be done.
> 
> I'm not entertaining the idea of somehow being preempted here for long
> enough for userspace to notice the already-registered PMUs (even though the
> module load hasn't yet finished...), open an event and have it count enough
> to genuinely overflow, because that would be in the order of at least tens
> of seconds if not minutes.

Can't we save ourselves from having to think about that by just having
two loops? That is, set up the friend relationships and enable IRQ
generation in the first pass, then go through and actually request the
interrupts in the second one?

Will
