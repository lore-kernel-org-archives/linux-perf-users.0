Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32704372EE2;
	Fri,  7 Aug 2026 17:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786125527; cv=none; b=dTaAQARjxbnOXG9CstMq6UG8RqoakRLzwSVl1b1XS/SKUu+4WvFV5tbOFB3dfHZIxgW4FOM5LRYYdtYwja7jKf4LkoZLWys3KglmEkb3qzsENR9rlVGjoDDVSccmMyFmTnm4l4t/U6c2DualXlXEJQsgW4O+V82ujfYQcolkQc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786125527; c=relaxed/simple;
	bh=Jblrqk4SbMIXXD1QYLWBKEdEo/rFBFZCKjsbySvxwFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLKWPWXx9n2lso/wLA2wp705CmT3/1r+VqQzSWQPPmepHSxvgO1/FNFlxBQ6RKeBr80esyIS9pF2pTFCUbubIjkVolzWaEaXkEI+/rIMRslMGMbss26eQ97PnE/GwDfE/uu2nGR5pPhh8PCLAbTy8hvuuJHNnDlg74aawfLcheU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5Jznoqe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5Jznoqe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61C21F000E9;
	Fri,  7 Aug 2026 17:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786125525;
	bh=pG19FR/d26kKDAp/YgwajizjyR1Bgzcijq4o5Vv5+rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l5JznoqeVdk6sPnXdzPQIkxFIJWshZzUjTNVHbDrQ5Iezo133PuLRnfhmFAwKxpjI
	 Umd3W+GXSn/HJTiMSQimsNM+gdyNZrbTp+KY6Mh0gOnPy0pkxo5/RYY/4kb2Wk0Yx8
	 AmMgrkmIAkMV8LpUdJ9WybaxRDJR2wtb9xSHIYhPunRayES6mBy5DpBzX2i10WBGnJ
	 e6fq18jGY1a0RfUA2nVW2z1fOfGzstyk2pFDrt1eD8zQKe5ucK0y2aF7iBR+u4qa+i
	 Fy+g86tBJvGw6bxzSmaUkasE6Ty4MVPyLbim0SAJ97xNt3S1I9e+WUZcFtwVgwoVGm
	 ijEaVOMMe1miw==
Date: Fri, 7 Aug 2026 10:58:43 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Tanushree Shah <tshah@linux.ibm.com>
Subject: Re: Fixes tags need work in the perf tree
Message-ID: <anYc0x--JjRfZ40_@google.com>
References: <anXtnqxN5PN4ULmF@sirena.org.uk>
 <anYKNuAVxu6TyJ4w@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anYKNuAVxu6TyJ4w@google.com>

On Fri, Aug 07, 2026 at 09:39:18AM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Aug 07, 2026 at 03:37:18PM +0100, Mark Brown wrote:
> > In commit
> > 
> >   8782a10c74e85 ("perf trace-event: Fix integer truncation in do_read() and skip()")
> > 
> > Fixes tag
> > 
> >   Fixes: 454c407ec17a ("perf tools: Get rid of read_or_die() in trace-event-read.c")
> > 
> > has these problem(s):
> > 
> >   - Subject does not match target commit subject
> >     Just use
> > 	git log -1 --format='Fixes: %h ("%s")'
> 
> Sorry about this, I should have checked it more carefully.
> I'll fix the tag and force push the branch soon.

Done.

Thanks,
Namhyung

