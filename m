Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79C840F72C
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791151863; cv=none; b=LIw+MCQJm8VfKSEPE+YQJq2gk4WtbUaCPwJmfx0qxmkdaikTHMBOnQYKg2jr6aTcvBEuDL7Ubl/5YvweFtNyz41I5DMUwgcd/AO/736tOB36RJMcSUhZSaTh175IoAChWD0gaQ/9LOB86k5jv4Yn/QPlWE86lxkg8BMRAyl4P6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791151863; c=relaxed/simple;
	bh=yxf6sRAI25us8HY8zeIU+o269YB+YtRliH9Fsn6/5ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=an6JwmMLx9/iAoc5Y129AakEmTnVPrjVeOzdrk7AJ44GIorCkbM4cBfeMIYpgZ4iSqJg0r2b5rwXA2kekesayGpwmu0QXsEbyo5CUoXwngeN8nzXIit44pr5f2iM/UnEtc0KqD7avdIhdb1GeiGq+vxDmLmk486xXackACjEORE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH8fiKGN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH8fiKGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3279B1F000FF;
	Sun,  4 Oct 2026 22:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791151862;
	bh=1DjzRkPglXkLnXbY7wN8PS3ogcu8ALsIIsvswqRjdFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HH8fiKGNTvOUka8cytqfjPz55KfUztVmkOh/aBQdRNW0yL1QMtNWxaacH+9MBB96p
	 RA3qPtQhJ0NHHOzurorpnZ3bBh+j+dLodHipyRX+7Qe2thTIm6VHS1yMwNLrE3GyDO
	 i/jZJOHljB1336OzqAaLUpUZ5sX3JvfPrL1bu7vTmmbi0g2Wx46TsVUrTS28V7onHb
	 4h5G5grnwy/7Haf42cPVCGpEPKxs4HFkVPRMWRTJIEFjQ+1WoL0LmMWehaMmAnTEMn
	 +U40ag21NPWOZXUrw4MLk2XVTBh2rCarZGqvuVLtBCjaK9GBOLzPqXGC8125ax68W4
	 1yPyJtjXpxx1Q==
Date: Sun, 4 Oct 2026 23:10:58 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: mark.rutland@arm.com, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] perf: Add Arm Bus Monitor Unit driver
Message-ID: <asLO8rGQPYo3KhKB@willie-the-truck>
References: <c936505c43275f434bce924b7657e42bfb25579c.1789652832.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c936505c43275f434bce924b7657e42bfb25579c.1789652832.git.robin.murphy@arm.com>

On Thu, Sep 17, 2026 at 02:47:12PM +0100, Robin Murphy wrote:
> Arm's Bus Monitor Unit is a low-level performance analysis tool for
> matching and counting transactions at interconnect interfaces. Each
> BMU consists of a number of "interface monitoring units", with some
> global controls to synchronise them and so permit accurate calculation
> of cross-interface metrics. Each IMU contains, among other things, its
> own PMU largely based on the CoreSight PMU architecture, but with some
> functional incompatibilities due to the nature of how much per-event
> filtering needs to be crammed in to categorise AXI/CHI transactions at
> the protocol level. As such it gets an honorary home in arm_cspmu/ in
> order to share the common register definitions, but for simplicity does
> not try to bend the functional abstraction to fit.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> v3:
>  - Couple of inconsequential tweaks to shut Sashiko up about things
>    that would never actually happen anyway
>  - Drop unneeded DT patches that I can't be bothered to fix right now

Please can you take a look at the Sashiko comments on this one?

Will
