Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D521314B76;
	Mon, 24 Nov 2025 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764000713; cv=none; b=P0GUy9TUtvVGR7qBgkWl6RXy2KLFVAID9E4L2VYvghPJBNK2sYqq10DnIMsub8ZmmiD1mi+8DZSu89fz54Agk26AwVNxqB5FovbSYWfpUbHTPZslBjO/eK4fztULFir5D3vnRlHTxQtmhiCbMrLqaRDmzj9nRVs0UgKUUKrfN/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764000713; c=relaxed/simple;
	bh=GynIxB5SdvojmQh0bSIvnMjrM6AMO9/Kdtc2TBwGNgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVN+DB3u2z1B0kroBr8rW8juPlIHIodfBMt73FMGaqN1SBPI81FGX2y4Q9o7cN8/GdNlFJ1rRz7buM3W/m6v2A28Q+g8BSR4Y2Jut8Q/VH1KvecaFYRXR83m7USENH/lq9opB1ZcnBlTTrjnbpRSZ2R4S7EUed9eOxe6ERMhSOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMfQjJPD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMfQjJPD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE7DC4CEF1;
	Mon, 24 Nov 2025 16:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764000713;
	bh=GynIxB5SdvojmQh0bSIvnMjrM6AMO9/Kdtc2TBwGNgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZMfQjJPDUkiF/X8PrTSt0qVYlqYTimfC4O9SRbtvfpXKJCMCAgdFZvdQGYkpAitGN
	 JsXZNGEVGMZ7ApnvhyvOf7nyIhSuVND/jyjm3dUfph1ELfH03P3KYbkMLQGJWrcj8s
	 nLVgirQailZNhC/TcHKYUjaa/F41QDyFxwM6ZtBYIYGQGsh68/up3rpKqcC8DBxr/R
	 jO1FDT8nLrBm8xqBEDyK1BDgT7IaHsZQGsMOGRI1+6ekEhZOfY2g2gz2XeYeqgrW20
	 j6Jtc5+GoYwtPWdRwrhyL+UMikGY08Rko5iys5+LC6528BhRKuHE/X3jfMlR40EF00
	 nBJ/At9UsEDxQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vNZAP-000000004Lx-0Mql;
	Mon, 24 Nov 2025 17:11:53 +0100
Date: Mon, 24 Nov 2025 17:11:53 +0100
From: Johan Hovold <johan@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Besar Wicaksono <bwicaksono@nvidia.com>
Subject: Re: [PATCH] perf/arm_cspmu: fix device leaks on module unload
Message-ID: <aSSDyam4lxcSWvA7@hovoldconsulting.com>
References: <20251121115213.8481-1-johan@kernel.org>
 <aSSB0foqqbOl3fC3@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSSB0foqqbOl3fC3@willie-the-truck>

On Mon, Nov 24, 2025 at 04:03:29PM +0000, Will Deacon wrote:
> On Fri, Nov 21, 2025 at 12:52:13PM +0100, Johan Hovold wrote:
> > Make sure to drop the references taken when looking up the backend
> > devices during vendor module unload.
> > 
> > Fixes: bfc653aa89cb ("perf: arm_cspmu: Separate Arm and vendor module")
> > Cc: stable@vger.kernel.org	# 6.7
> > Cc: Besar Wicaksono <bwicaksono@nvidia.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/perf/arm_cspmu/arm_cspmu.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> > index efa9b229e701..e0d4293f06f9 100644
> > --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> > +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> > @@ -1365,8 +1365,10 @@ void arm_cspmu_impl_unregister(const struct arm_cspmu_impl_match *impl_match)
> >  
> >  	/* Unbind the driver from all matching backend devices. */
> >  	while ((dev = driver_find_device(&arm_cspmu_driver.driver, NULL,
> > -			match, arm_cspmu_match_device)))
> > +			match, arm_cspmu_match_device))) {
> >  		device_release_driver(dev);
> > +		put_device(dev);
> > +	}
> 
> There's already a fix queued for this; please take a look:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=for-next/perf&id=970e1e41805f0bd49dc234330a9390f4708d097d

Ah, forgot to check linux-next here, sorry.

The diff of that commit is identical even if the commit summary is a bit
misleading as this is not an error path.

Johan
