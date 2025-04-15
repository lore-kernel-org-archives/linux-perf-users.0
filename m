Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0407E24CEE4;
	Tue, 15 Apr 2025 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744711728; cv=none; b=RoGTXCzkfODFCcXxIt0JaLA48NUREou2fFryyMBWDaCQUcejCE+eACQCb/Cp2GaG274kBJfcMb2zlLgp33VT/VEoNCYCOCo+6h+4oNiu6Y9xNGPdiGo/xCpYZsoxT9L247FIFUqD2PcBtcG4DB9/P4zL9Mmme9wxS2IMXggYACI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744711728; c=relaxed/simple;
	bh=fD8jw6FhS/RswootRnJ/jwp2QuKyC5jp4fRfH2Vc6Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYHx2AIOZPh6PGFG+bPRH/aVI2f/eSEXHEPhVDCNimKZJR6Znf+iuLeqWSEjSjwNPUisGPVNdrdBEjlN8qgFG3eTyb7VTDmkM5eHWq6DfFCQEIPinIQFveFSVFaTLShR7uamHGrdRqUu39H0xCTM+qsQ5t9Zkkm/2ORE5cIYMII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d5v4AeCW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d5v4AeCW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l6TV/N3SlsMY/yP6vaPDeGLJXlgqoD/wbnGOnedxw4o=; b=d5v4AeCW0srTrIDRP0UcQgTmcL
	b+zoXcFXx2F8RmnRwVAY++1qyKyn2NFx/ogggSEw+DfTOIyUSbXupFEWjiqZ7KD1ipxL37jhuEnpm
	n5RTNvn3QFZHQcQ7hT9Be6UggHo6+EcZQ/X1Cef2sxkDlewbE7yXU4rVqd5LBF2VgiAIc4gUgHWav
	RO/vC4Olo4dvzWekkhoUjYMYMpqNWJlXz5XvQscg7zW3kHQwQQeFdPmi/RXjd6xqZzVcYNEfedD3e
	jo+tFIvsgkjnmXsUbwEIYNvKjUTM7EW/jJpgqaoDfB0QvTauhdQPxpNtbs0zJIhxlouX8suhVRL9N
	bKE0Btyw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4dDc-00000008NJ1-41Fz;
	Tue, 15 Apr 2025 10:08:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EF6C8300619; Tue, 15 Apr 2025 12:08:40 +0200 (CEST)
Date: Tue, 15 Apr 2025 12:08:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: James Clark <james.clark@linaro.org>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [tip:perf/core] [perf] da916e96e2:
 BUG:KASAN:null-ptr-deref_in_put_event
Message-ID: <20250415100840.GM5600@noisy.programming.kicks-ass.net>
References: <202504131701.941039cd-lkp@intel.com>
 <20250414190138.GB13096@noisy.programming.kicks-ass.net>
 <Z/3krxHJLaWJTj4R@xsang-OptiPlex-9020>
 <5bc5f54b-ce6a-4834-86d4-5014d44c7217@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bc5f54b-ce6a-4834-86d4-5014d44c7217@linaro.org>

On Tue, Apr 15, 2025 at 10:14:05AM +0100, James Clark wrote:
> On 15/04/2025 5:46 am, Oliver Sang wrote:

> > yes, below patch fixes the issues we observed for da916e96e2. thanks
> > 
> > Tested-by: kernel test robot <oliver.sang@intel.com>
> > 
> 
> Also fixes the same issues we were seeing:
> 
> Tested-by: James Clark <james.clark@linaro.org>

Excellent, thank you both! Now I gotta go write me a Changelog :-)
