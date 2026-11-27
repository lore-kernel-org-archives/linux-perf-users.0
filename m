Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804938;
	b=gsFLjNEo4GGrlzKQH/E29KvWAMEiaFJYIlZDmEldGY+wimQ+93LwNsw8Lr364Q87t7s9
	 HUS7NBr8ga/IxS5gRss/rFcEvfA0iXA5szknxaQp5WIiXaMur9afeu4m/v+xfawMdd7fe
	 3Ndxx07aAYqY19WRh6e9pcpwx8+FScXTKpuqdQuEsw8REG5o+OZS8UNfWMS0kpyQ/qtEp
	 wuWJC4xpvc5ZddJ0Kv8RF9JTkrvaVqUdzUsjPaki1HP18dJqO5O1d0qA6BCf2hViuA+fF
	 4GBomROqaJbZVV6vnGbebZUUL7ZnXXU2zk0T5cNris6cVrkCOgLoedkJGFe+4EqwNaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804938;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EkobH3yqYFHOtC9f87E5HTqak4ieERed4ic8RVwH7/E=;
	b=CDsQwghoyvcO+PA+MMAuKMFjuTqYT9O46EqLPUEszkwxLSs6r+ZNKnTI4JvqLw2k2Zof
	 vXSeS2IB24l4U89BFFVwLBCGd/C3NoiiBRn/xDkXWnFZpBCuJ/PGlgDp8u19Uj0Xmr1UA
	 F9oh6ZzCC9DL0z31/0eRiGbFZ2p4bjwt0jl9WOe9/HgfTBtliEOJNhim6CYTwFM2Qkt3a
	 jrulJWuYOxviMDgZ76EHVC8ZcWFWu4NTirPvrzyTMLTaW23mfw/kM9cKs4XSYV6PDdZig
	 NbYPVlNj1DlwjFzCIJcnh06dWqgBBf/+MCotvn38E4MaRoVLrJjE9mcKB0KqMuhX8bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDO6NmU+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC06606A321;
	Fri, 27 Nov 2026 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDO6NmU+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74FC1F00899;
	Fri, 27 Nov 2026 18:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795804937;
	bh=EkobH3yqYFHOtC9f87E5HTqak4ieERed4ic8RVwH7/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NDO6NmU+VVjbIqtwzl0mJ0nT5Qf28Sw1bKhRU9UYbBsA1lT3RrEcCdLxnEJx/Al6n
	 BgRnaSuBZ9Dl7d0VmbQH2B1ki3EI1/xcHRai6KZJ4nrt+knM+EGYDcaN+IeDjnXKjd
	 yBMDov1nM8jOZ6ZD0gRVC+oPowtYfuqULP4o6fZQQP+rqiBHuIay0/zA0qBw8g/dh3
	 GRVW6946l/bwVX1hV8DPsYk/qETjLhW5/Oejw6hRjx+ckocl2xmInB625ORq9RD2d9
	 NQQ3iOb3sgxLL1w0Va+JyMc+oRrvrJjfTOJjRy4Rk6I+r2fduDjLZeB5y2vNaRIbVD
	 Huhi2xtfLHJCw==
Date: Fri, 27 Nov 2026 18:42:12 +0000
From: Will Deacon <will@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Leo Yan <leo.yan@arm.com>,
	Suzuki Poulose <Suzuki.Poulose@arm.com>,
	Al Grant <Al.Grant@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf: arm_spe: Factor HW discard mode out of
 arm_spe_perf_aux_output_begin()
Message-ID: <awnPBIbrS6rvrq9S@willie-the-truck>
References: <20260805-james-spe-software-discard-v1-0-0ff0e44c4c92@linaro.org>
 <20260805-james-spe-software-discard-v1-2-0ff0e44c4c92@linaro.org>
 <asNfh-qywjOPxajj@willie-the-truck>
 <9c5e1aa7-4e0f-4576-b322-b4594cdea5b0@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c5e1aa7-4e0f-4576-b322-b4594cdea5b0@linaro.org>

On Mon, Oct 05, 2026 at 10:31:48AM +0100, James Clark wrote:
> 
> 
> On 05/10/2026 09:27, Will Deacon wrote:
> > On Wed, Aug 05, 2026 at 04:01:52PM +0100, James Clark wrote:
> > > Discard mode doesn't call perf_aux_output_begin() or emit aux records,
> > > and enabling it never fails. We'll add a second discard mode in the
> > > next commit so it will be cleaner if there is a separate begin function
> > > just for discard mode.
> > > 
> > > No functional changes intended.
> > 
> > [...]
> > 
> > > +static void arm_spe_pmu_begin_discard(struct perf_output_handle *handle,
> > > +				      struct perf_event *event)
> > > +{
> > > +	u64 limit;
> > > +
> > > +	limit = FIELD_PREP(PMBLIMITR_EL1_FM, PMBLIMITR_EL1_FM_DISCARD);
> > > +	limit |= PMBLIMITR_EL1_E;
> > > +
> > > +	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
> > > +}
> > > +
> > >   static int arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
> > >   					 struct perf_event *event)
> > >   {
> > >   	u64 base, limit;
> > >   	struct arm_spe_pmu_buf *buf;
> > 
> > Is it worth checking that we have a discard event in begin_discard() and
> > similarly that we don't have a discard event in output_begin()? It looks
> > like quite an error-prone interface for the caller, otherwise.
> > 
> 
> Makes sense, I can add that.
> 
> > > @@ -775,6 +785,12 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
> > >   		arm_spe_pmu_disable_and_drain_local();
> > >   		break;
> > >   	case SPE_PMU_BUF_FAULT_ACT_OK:
> > > +		if (arm_spe_discard_mode(event)) {
> > > +			arm_spe_pmu_begin_discard(handle, event);
> > > +			isb();
> > > +			break;
> > > +		}
> > 
> > This looks like new behaviour?
> > 
> > Will
> 
> I just extracted the discard part of arm_spe_perf_aux_output_begin() into
> here and arm_spe_pmu_begin_discard(). The PMBLIMITR_EL1 write and isb()
> should be the same.
> 
> Do you mean that now it does arm_spe_pmu_begin_discard() unconditionally
> before checking PERF_AUX_FLAG_TRUNCATED? Truncated would never be set in HW
> discard mode, so it should be equivalent. And the IRQ would never fire
> anyway so we don't get here until SW discard is added, and even if it did,
> handle->event is NULL so the handler would exit on the first line anyway.

I'm just highlighing that this goes beyond what I would normally expect
when a commit messages says "No functional changes intended." since
you're adding unconditional register writes to the interrupt handler that
weren't there before. If it "should be equivalent" because the truncation
flag isn't set, then put this inside the existing conditional. In fact,
that would make the whole thing more readable anyway.

Will
