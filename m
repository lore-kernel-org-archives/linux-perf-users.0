Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C3F14A8B;
	Sat, 30 May 2026 00:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780099884; cv=none; b=U3WYkO3lUQONRk2jWIBvtHEE+9Fih6FEK15TXQk4I2H2tj0jjhy+iM8DyhsKpPSR74T8k585wkmjqYUDih1J+x1apSku+gizWp6I31tiSYbjebtDBxdPp8Mf9z5pqVKvl/B3tPtKV2xMWN+hRfWqrj9uqstam73yk5On7BS2yCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780099884; c=relaxed/simple;
	bh=GUTVSKOlhk9C2eP6XXVlqlllSXLPa2d8051l8+DTSvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUf9ceP8ksFwhRuJwCkNCZQGeFp0mjZLuCr9aD/ter0ez44eW8jxbM0+DeogmkAfyPg3gNBLRZD3BFkS2bowhWOlB2+Z5GWtfmVdfpdVd5dVtg78yT4oBMwtYFe5AQZPRzhl7fTYqT0OjdUD9q4lVpAqmQqgY8HTzh1/DIJ1oaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZehLKdwz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZehLKdwz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C231F00893;
	Sat, 30 May 2026 00:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780099883;
	bh=sz0OuqxkzHKk/jT+NKsyxhWh8y5YN2S5mLcMzSTBaGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZehLKdwz+TENmhl+Ib/KP7SUSvujBRmnUPedtT384ubaDyT5NJ3O4/ztmlXTrPOxa
	 Y4qr6Budao95RoXa6LA6QQ0K58ziFpop+ssVLnIlntfUK0i6NSaSrRbGvEHkEQ3Djx
	 yY3KoNRvk9HjozWX71AHGCyIpXkKHabLPh0jtSnAMDpx7iL6qmvRaC9cvQbaPOIYtx
	 RDdRdUs7XchQymXX6JCaUO4qdTs4nNRGbxgMWm2iWoc6aXFUxrx8kdzjQ9QELrqvHz
	 6gZLETbDQmuB55GQQGodKK+LqpweJrUZm4EvAGLz/rQMMwahFHUpFlo37cEdgkF4lD
	 9izXe1A4ovbIw==
Date: Fri, 29 May 2026 21:11:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sandipan Das <sandipan.das@amd.com>
Cc: Chun-Tse Shao <ctshao@google.com>,
	Perry Taylor <perry.taylor@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf jevents: Add IOMMU metrics for AMD
Message-ID: <ahorKGXDiajCrTMA@x1>
References: <20260528234455.434027-1-ctshao@google.com>
 <20260528234455.434027-2-ctshao@google.com>
 <300855bd-c4fd-4915-8a93-8671377493b3@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <300855bd-c4fd-4915-8a93-8671377493b3@amd.com>

On Fri, May 29, 2026 at 02:56:38PM +0530, Sandipan Das wrote:
> On 29-05-2026 05:14, Chun-Tse Shao wrote:
> > Add IOMMU Translation Lookaside Buffer (TLB) and interrupt cache metrics
> > to perf jevents for AMD platforms. This enhances I/O performance
> > observability, allowing fleet-wide monitoring of IOMMU overhead.
> > 
> > These metrics are supported on Zen 2 and newer processors (Rome, Milan,
> > Genoa, Turin) and are implemented using the standard `amd_iommu` PMU
> > events. The implementation uses the existing `_zen_model` helper to
> > ensure these are only generated for Zen 2+. Note that the pde events on
> > AMD cover both 2M and 1G pages, so 1G pages are implicitly included in
> > the total hits/misses metrics (sum of pte and pde events).
> > 
> > The following metrics are added:
> > - iotlb_total_hit: Total IOTLB hits (4K, 2M, 1G pages).
> > - iotlb_total_miss: Total IOTLB misses.
> > - iotlb_miss_rate: IOTLB miss rate.
> > - iotlb_interrupt_cache_hit: Interrupt cache hits.
> > - iotlb_interrupt_cache_miss: Interrupt cache misses.
> > - iotlb_interrupt_cache_lookup: Interrupt cache lookups.
> > - iotlb_interrupt_cache_miss_rate: Interrupt cache miss rate.
> > 
> > Tested:
> >   # perf stat -M \
> >     iotlb_total_hit,iotlb_total_miss,iotlb_miss_rate \
> >     --per-socket --metric-only -a -j -- sleep 10
> >   {"socket" : "S0", "counters" : 10,
> >    "hits  iotlb_total_hit" : "3579249.0",
> >    "%  iotlb_miss_rate" : "0.0",
> >    "misses  iotlb_total_miss" : "3.0"}
> >   {"socket" : "S1", "counters" : 10,
> >    "hits  iotlb_total_hit" : "0.0",
> >    "%  iotlb_miss_rate" : "0.0",
> >    "misses  iotlb_total_miss" : "0.0"}
> > 
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > Assisted-by: Gemini:gemini-3.1-pro-preview
> > ---
> 
> Reviewed-by: Sandipan Das <sandipan.das@amd.com>

Thanks, applied both patches and collected Ian's reviewed-by, since he
provided it for the combined patch and requested that it was split,
which this v2 does.

- Arnaldo
