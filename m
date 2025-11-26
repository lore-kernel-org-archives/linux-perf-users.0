Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BEE158538;
	Wed, 26 Nov 2025 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764183626; cv=none; b=IFOe4lcRpfNesPaMx8K8irH6imzkZz9qYWgsl/rLypqj4+Xl9UdKj6+JWUrVcMJHhnC17jOb+A2ZNULEoGZ/87QaJw1OGlIi+Y15LBB2Rw6DKsJtjnCui0yzDL98aLcl60yc4TxMLgeibYzoShlrawJNuIqFu6lPHDMz7qM9/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764183626; c=relaxed/simple;
	bh=nIv3Siez8Xf9o235kbfOjSxJX+DKYpDTaovNj1ta27A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7jOA1iXRW7Pw53oWcfoAXR7T0XrO/7rpxDkHXFdATHmLjE6m/bOUnoWjkgMh7GNghAdx94QoSU/RtYe3b/UHIsSESk5uG3ZMjwFvyqsfZwkZ+IBFgokdG7MhcMpBBr0U0FHsrJIZ0JUp/ZizhmLt2KGxLNfJSnLnaUwFnT25UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0JkL9lB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0JkL9lB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96580C116C6;
	Wed, 26 Nov 2025 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764183625;
	bh=nIv3Siez8Xf9o235kbfOjSxJX+DKYpDTaovNj1ta27A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J0JkL9lBEj+bJEpZsIMnlGLtbUGzsEhtTpEMsGQJTOCOUYy06bSt7zPsjyWsAXFwb
	 MHklrZv1rxUK32wVEHuxVecXHnFC28Zf+syXCbZxl4o+2ZCqwEzZ0OmfIqL/pC/s4U
	 D0W2bFI+4YI7Dwz1f1ZFdoeAum8+cXFjS9SZQpV633decb5028zHizIuiQm+6syd5k
	 6AlJNxhH3kG2oCJsRStWtRLkYPZbQvgBwwVz/+heraTuhG02bALRVn0FtM2KZR19So
	 Mxzm/BMgyGiWNMW13L++5pAkOrxnzmepI7S8VEx3EvmkJ6hrQJ6WZ8N6goezeULx89
	 ubAIo3cyjp1Gg==
Date: Wed, 26 Nov 2025 11:00:21 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Xianying Wang <wangxianying546@gmail.com>,
	akpm@linux-foundation.org, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [BUG] WARNING in __alloc_frozen_pages_noprof
Message-ID: <aSdORdgxGSOERQZr@google.com>
References: <CAOU40uAHO9-59HB2VmCBfC5OiNg3BZBd-32jphtRd-nkvhD6Dg@mail.gmail.com>
 <4cb9f727-734b-43fa-92d2-80559df76c84@suse.cz>
 <20251126111921.GU4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251126111921.GU4067720@noisy.programming.kicks-ass.net>

Hello,

On Wed, Nov 26, 2025 at 12:19:21PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 26, 2025 at 10:46:38AM +0100, Vlastimil Babka wrote:
> > +CC perf people as AFAIU the problem originates there. Should the limit
> > be lowered, or the allocations e.g. switched to kvmalloc, to avoid
> > requesting impossibly high order allocations?
> > 
> >         /*
> >          * There are several places where we assume that the order value is sane
> >          * so bail out early if the request is out of bound.
> >          */
> >         if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
> >                 return NULL;
> > 
> > 
> > 
> > On 11/19/25 10:07 AM, Xianying Wang wrote:
> > > Hi,
> > > 
> > > I hit the following warning in the page allocator when opening a perf
> > > event with callchain sampling after increasing
> > > kernel.perf_event_max_stack.This warning can be triggered by first
> > > writing a large value into kernel.perf_event_max_stack and then
> > > opening a perf event with callchain sampling enabled.
> > > 
> > > The reproducer does two things:
> > > 
> > > 1) It writes a large (but still accepted) value to the sysctl:
> > > 
> > > echo 0x40132 > /proc/sys/kernel/perf_event_max_stack
> > > 
> 
> Yeah, that is far too large. I suppose the actual max is somewhere near
> 8k, which would give 64k data for just the callchain -- given that a
> single perf buffer entry is limited to 64k (IIRC) and all that.

Right, we have u16 size in struct perf_event_header.

Thanks,
Namhyung

