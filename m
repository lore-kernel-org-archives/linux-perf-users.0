Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC85C41E6AB;
	Thu, 16 Jul 2026 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220455; cv=none; b=i/tWIfAdwCyuuNApmyvHYeXHfjgZ3pyih7G/oFn9h2fSvQm5VCYJC4qIFJ0N/aaAShgRBwIHwkIY1TntEDUfgH+N6IkKtgixHzfU8knZ+/TW78EoQKTIg5R3lhPo7W5pC+7QgfFzqwkUR0tKOJVY27hXxGaDFq17pO2W+ufwbj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220455; c=relaxed/simple;
	bh=eC7UHXCDZRdRdR9bX45UMaJkvrh6kv8aY6kHz23Ht6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdhRk4g/lHM9YjLtdAU3zv3FTPqmIIMOvEFg/aA3jSoAKaMMV/+K9lTMbecvGDljC9j6vLaYf16Lu/Oay9awSkLcjLEuUPM94xZa3b26PPOpbEaRnbP+SQ80kU6oakuajEcXUxw17WIg7boyCDHo5SEjeX+IAcFUgCJpuIv2sQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEdZQSah; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEdZQSah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60121F000E9;
	Thu, 16 Jul 2026 16:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784220447;
	bh=SonFFCQQCU+16F4q1L+P9Dhv2gx44DSe7tEqDUwGX5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GEdZQSahMVbc9o0oQjqk3riugCG4AxB09TsBqH6I2amk3mv9CiukBrXq94mpWrhRD
	 5W0Hl3w7WjI3g7BKXO53De61cp8xIOdyCF8RJbBK2fhcTRof9/aTMCUEb+FPo/euEq
	 GbxLfuURIVlhMkJS+6UbLS7DF72uzTWDO1pydXDG6IgMJA/MFRJmI0+87nDKO9UmcV
	 pLuTDJ1BPGI1XKqFU/VSng4yXsSN4+92ZMvSr3W78/2ARVPSu21KEZC0JwrkEaZSyn
	 bLnRHloWlUMy87XM5hRDks9LpUIx7gt1d9/QjlNw/buvEcDHaz5F7G6910/06pGmtZ
	 e6DqfjZF7NWIA==
Date: Thu, 16 Jul 2026 17:47:21 +0100
From: Will Deacon <will@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, jic23@kernel.org,
	mark.rutland@arm.com, harshal.t@samsung.com, icheng@nvidia.com,
	linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 0/3] perf/cxlpmu: Misc updates
Message-ID: <alkLGe4PfVK12lbQ@willie-the-truck>
References: <20260715191454.459673-1-dave@stgolabs.net>
 <ecd7aea3-88c0-4f1c-8130-c3c9ef9e6869@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecd7aea3-88c0-4f1c-8130-c3c9ef9e6869@intel.com>

On Thu, Jul 16, 2026 at 09:46:05AM -0700, Dave Jiang wrote:
> 
> 
> On 7/15/26 12:14 PM, Davidlohr Bueso wrote:
> > Hello,
> > 
> > Changes from v3 (https://lore.kernel.org/all/20260713061112.105419-1-dave@stgolabs.net/):
> >  - Validate the event vendor ID for CRB filtering, the Table 13-5
> >    event groups are scoped by the CXL VID in patch 3 (Richard).
> >  - Add Richard's Reviewed-by tag to patch 1.
> > 
> > Three patches for the CXL PMU driver.
> > 
> > Patch 1 is a standalone fix.
> > 
> > Patch 2 adds the CXL 4.0 events that hardware exposes but the
> > driver did not. It now precedes the filter work as the latter
> > refers to the new event group IDs.
> > 
> > Patch 3 implements Channel/Rank/Bank (CRB) filtering, now permitted
> > for all event groups that CXL 4.0 Table 13-5 allows Filter ID 1 on.
> > 
> > v2 was tested on real hardware. The v4 changes have been exercised
> > under qemu CPMU emulation (jic23 tree) + changes for the new events/Filter=1:
> > 
> >     https://lore.kernel.org/all/20260715190050.458288-1-dave@stgolabs.net/
> > 
> > Thanks!
> > 
> > Davidlohr Bueso (1):
> >   perf/cxlpmu: Fix 64-bit write to 32-bit HDM filter register
> > 
> > Harshal Thakkar (2):
> >   perf/cxlpmu: Add missing CXL 4.0 events
> >   perf/cxlpmu: Support Channel/Rank/Bank filter
> > 
> >  drivers/perf/cxl_pmu.c | 119 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 116 insertions(+), 3 deletions(-)
> > 
> > 
> > base-commit: d60ec36cab338dfe2ae40d73e9c8d6c4af70d2b8
> 
> For the series
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> 
> This is being picked up by the perf maintainer right?

Yeah, I'll grab it eventually. Just a bit swamped atm.

Will
