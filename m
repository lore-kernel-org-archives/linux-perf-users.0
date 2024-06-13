Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874E3399
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Jun 2024 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718283699; cv=none; b=DnCIv3UVbIH7LQC3FXiV0WG62NuCADPlaU/v87ZbPQavL8E/d7aGypEPuNNjeWAL4tUx7tl4+HiKMR7kHtZ9uhPZH5KoWooDo/jPoLFSj33TgTY/Q9h3RL8fpf5eer4FmI4mny6P/pjm/NEE8S7M2r0WETBhQMQpwRxO0HA5Du4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718283699; c=relaxed/simple;
	bh=ZgXEpbP4o/Fd3ITXxa+QSJA3C7/RVGJcSwXpSFLLxx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RN3AnLBrH9YBM8PppqBqsyVoVE+Zhe5FaGXag3IrSIVKVB63wZ7Uhb8nqeBuF6MThDoj89Vauq47R2y+DOz5oz4g3TEfVfxpsJ56sNdMVlzzT/7VMY9Y0rwJTaLgOJ6q7Pj9fZuN8v9NOOgl/GsyRUlIgg0Lg5vP4YQkHitEZ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtOLs2LH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtOLs2LH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE86C2BBFC;
	Thu, 13 Jun 2024 13:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718283699;
	bh=ZgXEpbP4o/Fd3ITXxa+QSJA3C7/RVGJcSwXpSFLLxx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rtOLs2LHkV6X3Fao6DFEEVQmufJgG9IaJh3HH5lm2fJJsC4TQmVujywEEhHi7j8VV
	 kUEm4vHpXUaK37zW40gov2NqHSbLH0scHu5ovmP9mbPsGWoH2b5esKh3W3rDjOLXTi
	 JRwxvfj7J5PgXfpUA999VYCVQunewMCHQyEJS1b+KX3Q4M/aYwErzCjWDPvRvs/ZPd
	 3n9jedVTUJ04rYoL4+iGXuUHXXKDAR0U0UgoV4YwbLyc1zz/De04AQU0zFzgxWOUzL
	 ka6DwU4UY8wJp56BXx+ts7s4DNWwJ1HJQtbOSCJysI7rsdZNUTFkuVfNiP9CYdZWFC
	 0bDNMHhZ6wElQ==
Date: Thu, 13 Jun 2024 10:01:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	Leo Yan <leo.yan@arm.com>
Subject: Re: Perf Wiki Appears Broken
Message-ID: <Zmrtr5Mw_V8a01pD@x1>
References: <87365604-bfa5-4153-b41a-84bf87fb4cfd@arm.com>
 <a68343ee-b450-4ae1-a5dc-da6e1c865dcb@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a68343ee-b450-4ae1-a5dc-da6e1c865dcb@arm.com>

On Thu, Jun 13, 2024 at 01:55:08PM +0100, James Clark wrote:
> On 10/06/2024 10:19, James Clark wrote:
> > Hi Arnaldo,
> > 
> > I'm not sure if you're still the admin of the Perf wiki, but I'm getting
> > a login error:
> > 
> >  Wiki uses cookies to log in users. You have cookies disabled. Please
> >  enable them and try again.
> > 
> > From a quick Google I think this might be a disk space or configuration
> > issue.
> > 
> > I was planning to add a dockerfile for cross compiling an Arm Perf on
> > x86. I suppose we can also discuss here if anyone thinks that's useful
> > or the right place for it.
> > 
> > Thanks
> > James
> > 
> 
> I'm able to log in now. If you poked it, thanks!

Great! Probably was something transient and the admins fixed it.

I tried poking a friend that was the admin in the past but he told me he
wasn't doing it anymore.

- Arnaldo
