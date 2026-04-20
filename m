Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84663377EDA;
	Mon, 20 Apr 2026 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776672316; cv=none; b=oKyQrrE16QRPtO2r+L9CYp6lxSVnrmTqb2P+C0IaRueMTY4ULUwXfE1fZxJ5eVhU0VSaxP7J3D/onQaPq5A+2CVPtWc/I/dAfznE+CpOhZ6/EpFNmYUPBR4hs4zlzx+lHo+u1Rg9FRBgV4bFDjuVlJmpiZTK2VkUMUL7j/BwHj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776672316; c=relaxed/simple;
	bh=MMupEMtX6NN4l5jTf+bz3F5R6Vo4CjtgyIq7YTbFxHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNweI98x8cdqzZd65DTwP0Bs+6EPQ5k6kHqS3U7FpkXttF/vKLh24UjTAjES8sxzizKPwK4mhIN6Xs5afSj5Tkw4vatcShFigmEq3RMZsoTsxMmcMF+fSi7bjv+0ofDJvOqpAGjVLF4yYc8CpqF1P50rTGKA2TG/7M4agrDYQTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LykavP4p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LykavP4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA67C19425;
	Mon, 20 Apr 2026 08:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776672316;
	bh=MMupEMtX6NN4l5jTf+bz3F5R6Vo4CjtgyIq7YTbFxHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LykavP4pX3GCYTqTdeEIBtIbX2DFZs8B3m6RCglX/J79jIEazMhTA/jfI/Sz6kS0t
	 EA81PvZXntRDBoIBhWQM68Sk1Inud9l6WkYI/yut6CarTLOqKJAe94IELYel9aIbRM
	 Hc5HKHnCor3a4biY021qGQM2JgimR27cRrxQmTaw=
Date: Mon, 20 Apr 2026 10:05:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm_pmu: acpi: fix reference leak on failed device
 registration
Message-ID: <2026042058-charm-storable-4ad8@gregkh>
References: <20260415174159.3625777-1-lgs201920130244@gmail.com>
 <ad_WmuauLJ3xDKqh@J2N7QTR9R3>
 <2026041603-guts-crested-ef76@gregkh>
 <aeCOdWLaVpH-5w8s@hovoldconsulting.com>
 <aeCsLy-45QyeCwGA@J2N7QTR9R3>
 <aeXVr5enpjb3rfq7@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeXVr5enpjb3rfq7@hovoldconsulting.com>

On Mon, Apr 20, 2026 at 09:28:47AM +0200, Johan Hovold wrote:
> On Thu, Apr 16, 2026 at 10:30:23AM +0100, Mark Rutland wrote:
> > On Thu, Apr 16, 2026 at 09:23:33AM +0200, Johan Hovold wrote:
> 
> > > It's not just the platform code as this directly reflects the behaviour
> > > of device_register() as Mark pointed out.
> > > 
> > > It is indeed an unfortunate quirk of the driver model, but one can argue
> > > that having a registration function that frees its argument on errors
> > > would be even worse. And even more so when many (or most) users get this
> > > right.
> > 
> > Ah, sorry; I had missed that the _put() step would actually free the
> > object (and as you explain below, how that won't work for many callers).
> > 
> > > So if we want to change this, I think we would need to deprecate
> > > device_register() in favour of explicit device_initialize() and
> > > device_add().
> > 
> > Is is possible to have {platfom_,}device_uninitialize() functions that
> > does everything except the ->release() call? If we had that, then we'd
> > be able to have a flow along the lines of:
> > 
> > 	int some_init_function(void)
> > 	{
> > 		int err;
> > 	
> > 		platform_device_init(&static_pdev);
> > 	
> > 		err = platform_device_add(&static_pdev))
> > 		if (err)
> > 			goto out_uninit;
> > 	
> > 		return 0;
> > 	
> > 	out_uninit:
> > 		platform_device_uninit(&static_pdev);
> > 		return err;
> > 	}
> > 
> > ... which I think would align with what people generally expect to have
> > to do.
> 
> The issue here is that platform_device_add() allocates a device name and
> such resources are not released until the last reference is dropped.
> 
> It's been this way since 2008, but some of the static platform devices
> predates that and they both lack a release callback (explicitly required
> since 2003) and are not cleaned up on registration failure.
> 
> Since registration would essentially only fail during development (e.g.
> due to name collision or fault injection), this is hardly something to
> worry about, but we could consider moving towards dynamic objects to
> address both issues.

Agreed, this whole thing, including the error handling, is all just
theoretical as no real user ever hits this, which is why it has been
_way_ down my priority list.

> We have a few functions for allocating *and* registering platform
> devices that could be used in many of these cases (and they already
> clean up after themselves on errors):
> 
> 	platform_device_register_simple()
> 	platform_device_register_data()
> 	platform_device_register_resndata()
> 	platform_device_register_full()
> 
> and where those do not fit (and cannot be extended) we have the
> underlying:
> 
> 	platform_device_alloc()
> 	platform_device_add_resources()
> 	platform_device_add_data()
> 	plaform_device_add()
> 
> But there are some 800 static platform devices left, mostly in legacy
> platform code and board files that I assume few people care about.

Yes, I agree that we do have all of the needed apis here already, we
should just work at converting existing drivers to the new apis OR just
not caring at all as again, no one will ever hit these code paths :)

thanks,

greg k-h
