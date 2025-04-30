Received: from hudzen10.theunixzoo.co.uk (hudzen10.theunixzoo.co.uk [176.126.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E762AE7F
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.126.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745998040; cv=none; b=VuJiX6NOt4FWzXwpap0s+K/GWclemDJCJkwj0b7rUqTRE/n90/ROO1lvbxUvm/UnF7OSlrGNsKGD6ahvlO5TszDa+eEQgHVaiSWV1JmEh3LhISv7i5h1lUn19S/rV++dYA1J0ZTsJqMmXofZQkJ3JiY+3jeSeT8b//xQeJEJyV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745998040; c=relaxed/simple;
	bh=DOn6CE6P7MwOFvf2kFX4i9IPq3MYZ6FVyjrAAOmWXxc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sk2dXkMlg4I9zL53/yFkdXdiDvWpY5u1X1yFbCBRB7b78XYoAuowvZELuBsE8uJ9d6CalCRkmV040N+kyWQbJDOl5+D5ntFn5j04CAGrIBrdkQByFFATdOkbu11c9Pau9/bt6Wkg8FTmUuqiZug2rq/0hdYhVG2O/Il+M+J7LbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theunixzoo.co.uk; spf=pass smtp.mailfrom=theunixzoo.co.uk; dkim=pass (2048-bit key) header.d=theunixzoo.co.uk header.i=@theunixzoo.co.uk header.b=RmcfeoRD; arc=none smtp.client-ip=176.126.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theunixzoo.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theunixzoo.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theunixzoo.co.uk header.i=@theunixzoo.co.uk header.b="RmcfeoRD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=hudzen10; bh=DOn6CE6P7Mw
	OFvf2kFX4i9IPq3MYZ6FVyjrAAOmWXxc=; h=in-reply-to:references:subject:
	to:from:date; d=theunixzoo.co.uk; b=RmcfeoRDUkqLfF9mQ7tugQWAgNFgwz/sqi
	+SNpPxaOjKSsaK2y/3LU/fRg1OT64HNYab7VzeGpLnnAwWysc6FYKZZO+YtfVEZ90wulrV
	VKeiw5VixTGOZUQOK40wxSDmFurfkQViaY/9l1Z9BhJlRCDNjxf4RScLLouVdFX4vRG4MD
	vCdcKVjHZbA5HR9gdRA3ciAQgk6Fhk1GnRqbhvADMsSYVNSFK0GHuuvjgG8d9Odq/yEvxf
	12Cjhm4VK0gPN/5HBLSWvrP04CRJO9yp7+7HAzj2iqNlIuW62ASu9z/fGDcbv3SH6dl5kG
	I3KzF4OWBoUG6KB8gjztJeGVSKHg==
Received: from localhost (host-92-18-208-96.as13285.net [92.18.208.96])
	by hudzen10.theunixzoo.co.uk (OpenSMTPD) with ESMTPSA id 2ab9fc02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO) auth=yes user=edd
	for <linux-perf-users@vger.kernel.org>;
	Wed, 30 Apr 2025 08:27:10 +0100 (BST)
Date: Wed, 30 Apr 2025 08:27:09 +0100
From: Edd Barrett <edd@theunixzoo.co.uk>
To: linux-perf-users@vger.kernel.org
Subject: Re: perf filters don't work correctly inside containers
Message-ID: <aBHQzU8hhyWykGwl@arrakis.home>
References: <aBCwoq7w8ohBRQCh@fremen.lan>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBCwoq7w8ohBRQCh@fremen.lan>

On Tue, Apr 29, 2025 at 11:57:38AM +0100, Edd Barrett wrote:
> I was then able to reproduce the problem using the standard userspace perf
> tools. I *think* (but I'm not sure) that this might be highlighting a bug in
> perf when used in containers.

Forgot to mention: perf seems to work fine inside the docker container
*without* an ftrace filter, so it's not that the container cannot trace with PT
at all. The problem seems filter-related.

-- 
Best Regards
Edd Barrett

https://www.theunixzoo.co.uk
