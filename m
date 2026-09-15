Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701EC28E0F;
	Tue, 15 Sep 2026 00:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430752; cv=none; b=qVf+nIocmNCZMjgKkuMjptXydx11ax08q1iidxN3jaJsrQceKJwhsj1G01jyYZrKpDNGYRDqjkPn77JHh4kJuTyHrgvEr6ST27Z8f4qlZs/4aNSC1edXcW8Hwv4O5dtwyOA4Q4hKab4PfDQZPCm8rRk22s4yuXy1mR3pRpvyclg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430752; c=relaxed/simple;
	bh=oiWqveC45yp2nYyKvPjuIqaMNeNFeY+YZpQZLCeyKvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afdcsl/kGsrqv/mQcMLhb+LhlVYqHgN5Wa2VHPvXTbgiNnMtDKSyfvM1Hnm5wj/Q9fEr90DIMm1Vk6+2RtFE3dKAzZvWQII6MC/oveAEwwxPZ9Mvi10WXND05HDF9Fyx4o2AmZ+gaeiJ6GT6330f3uNM9/oLZrJLytQobn5ZYek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GF30TWmd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GF30TWmd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCE21F000FF;
	Tue, 15 Sep 2026 00:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789430751;
	bh=lXHdEMdxwk5IQbZQNX/BY5GhUv7W4IKJWjZmCZQoR6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GF30TWmdlHLuHiBZl+S70ci/btPskE8NLbceAUjqh3iWEMy5VSo7hOSqaKwfqqh4U
	 Q6/O54r5vpGF46hh0a3P7WMoAXxv4rUk9WuYKeF/O2XpIM+nTiJb4wN43qNvdl0KiU
	 67d0JybZFiRv2oj/W4M6hZh0CHliTGk/RLb+CIJptCExg5zLcKXpHmKdhSbDJbdafm
	 EBVe/IeYkTMriRwE19hsCEhIsgJrM+39JAoH05mWdMGZHrQnWsU3Txf0GKrzrWPzd9
	 8TbAT0UOvl38t9ns8/bSqgnjOSqvvVD+YI7R0hne+zehaDxr1utTF2SGP+fI+KGq+x
	 InGDqLbMGMh5w==
Date: Mon, 14 Sep 2026 21:05:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [Patch v11 07/10] perf regs: Enable dumping of SIMD registers
Message-ID: <aqiL2gZFtobti3fv@x2>
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
 <20260914014049.2061519-8-dapeng1.mi@linux.intel.com>
 <20260914020418.97E881F000FF@smtp.kernel.org>
 <1870044f-ab4c-4906-8f8b-c3216fb28211@linux.intel.com>
 <aqg9DV05lxzLKu0t@x2>
 <aqhK3K_yfdtB51Ax@x2>
 <5335ab48-bea0-4f2d-9520-c8b8efbc62b6@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5335ab48-bea0-4f2d-9520-c8b8efbc62b6@linux.intel.com>

On Tue, Sep 15, 2026 at 07:56:36AM +0800, Mi, Dapeng wrote:
> On 9/15/2026 3:28 AM, Arnaldo Carvalho de Melo wrote:
> > On Mon, Sep 14, 2026 at 03:29:33PM -0300, Arnaldo Carvalho de Melo wrote:
> >> On Mon, Sep 14, 2026 at 01:17:00PM +0800, Mi, Dapeng wrote:
> >>> On 9/14/2026 10:04 AM, sashiko-bot@kernel.org wrote:
> >>>> [Severity: Low]
> >>>> Does this file need an explicit inclusion of <stdio.h>?
> >>>> The perf tool can be compiled with musl libc, which enforces strict POSIX
> >>>> namespace separation and does not implicitly include headers. Relying on
> >>>> implicit header inclusion for printf() can cause build failures under musl.
> >>> Ok, this can be fixed in a separate patch later.
> >> Ok, merging it now, later you send fixes for these minor issues.
> > It is now in tmp.perf-tools-next, will do the usual set of containerized
> > build tests and push,
 
> Thanks Arnaldo.  I would post the fixing patches later once this patch
> series is queued. :)

It is already queued:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=perf-tools-next&id=01ee8c14354f1fb90ed7ac81998b863a9d42e285

- Arnaldo
