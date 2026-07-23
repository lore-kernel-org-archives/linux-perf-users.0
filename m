Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0A03A71A8;
	Thu, 23 Jul 2026 05:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784785255; cv=none; b=S0Jtn9ADD9xIV1obaQblzCJvZjpvxXMEi7xhSx6/2OAX0B2gDu0I1shXfc0BtLem/SLfCljyUs7FPla3zkmGe7GlNcaVxQpQQTPPG0KaWqG9tuYUDI15FBpyCS2MgxOtUUCJBN3p+rfA4ibszv1o0H84aoAQD9EzObbV3myg/mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784785255; c=relaxed/simple;
	bh=LvkF7gFCkTuUNDn5278AcZkGdDJHK9RLAngZp8NLLOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DokbdYzUPyI7ac4cn4kUablutHKBerQhhH57EUTNhNiz8XBKCWNkhPZkqL/d8lZ6XJJY/Dwq7W9cqJCqoefARlsIsry2Lgo+xRWDxc8yaN+8+dTjHOWBBt2VBRcVILLPCOripNv5K1hR0/ovw1gigvQABfx5SLvD8iIRuum1iQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEyCBuhz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEyCBuhz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7672E1F000E9;
	Thu, 23 Jul 2026 05:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784785242;
	bh=MOwReqV3/WtZTWeMMgWyyoHzx2cT68OLr3ZwAzPHZqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KEyCBuhzZk7KKydedsVz8XSOQA0iGEqw7WCFUpKRC92Q4OouSot/Cg3MtBg88zoM5
	 DHOlS2/ra5BdPBKvT+g3ZZFE3wugUkgowJ7UmS4C2tPtoCl/UjU2jZ8GnPYQQY/G4Z
	 8fMq91GqGjknyILhjiRAxiPWqPBAY2tCWJ6GItdDCBE5hCxz+OpFKz2aSfyoobPSS2
	 ITn2ryItGwq7jDHd4OCNb++5RmfaSSP8Kvmjy+K+gYG/GX22nUVntubEEQ3H2CnkMk
	 ncCa/WiXYRrtGzSJs5kPxYXiFoCSR01bcEbASSkUnevVrckHP3sv6tg6e+F9LFSCiW
	 qjGMU7urCSN+w==
Date: Wed, 22 Jul 2026 22:40:37 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, tianyou.li@intel.com,
	wangyang.guo@intel.com, dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/14] perf c2c: add a function view
Message-ID: <amGpVYnDyqe7-xdy@google.com>
References: <alsH9PFMljK5eUEJ@z2>
 <20260720083924.2735509-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260720083924.2735509-1-jiebin.sun@intel.com>

Hello,

On Mon, Jul 20, 2026 at 04:39:24PM +0800, Jiebin Sun wrote:
> Hi Namhyung,
> 
> Thanks a lot for the detailed suggestions -- agreed on both points, and I
> wanted to get your thoughts on the reworked layout before sending the next
> version.
> 
> > I think it's more like "code-address" view rather than "function" view.
> > How about organizing the output something like below?
> >
> >   L1:  function
> >   L2:  cache line
> >   L3:  shared functions
> 
> You're right that keying level 1 on the code address made it read like a
> "code-address view". I plan to rework it so every level that names a
> function aggregates all of that function's code addresses into a single
> entry, together with the per-level indentation you described.
> 
> For the lower levels I first tried the cacheline-then-functions layout you
> suggested:
> 
>   L1: function
>   L2: cache line
>   L3: sharing functions
> 
> but on real data we hit one problem: when the level-1 function touches many
> cache lines, the same contending function shows up under many of those
> level-2 cache lines. To find out which function modifies the line the most
> -- the one most worth fixing -- we then have to aggregate that function's
> writes across all those cache lines ourselves, which is the same manual
> work the cache line view already leaves to us.
> 
> So I am considering putting the contending function at level 2 and the
> cache line at level 3 instead:
> 
>   L1: function            (reads the line and pays the HITM penalty)
>   L2: contending function (writes/modifies the line, causing the HITM)
>   L3: the shared cache lines
> 
> For example, expanding dequeue_pushable_task and its writers:
> 
>   Cycles  Store
>        %  count  Function / Contending function / Cache line
>   ------------------------------------------------------------
>   - 16.54%   419  - [k] dequeue_pushable_task
>              145      - [k] pull_rt_task
>              145            0xff2d0082809da080
>              139      - [k] enqueue_pushable_task
>               70            0xff2d00a2071f9640
>               69            0xff2d0082809da000
>              133      - [k] cpupri_set
>              133            0xff2d0082809da080
> 
> Here enqueue_pushable_task contends over two cache lines, but it stays a
> single level-2 row with its total (139) shown, and the individual cache
> lines are underneath -- so the top writers are ranked directly, with no
> manual summing.
> 
> The key difference from the earlier version is that the code addresses and
> function offsets are no longer shown at level 1 and level 2. Those made the
> view read like a code-address view; instead the main view keeps only the
> concise, at-a-glance information (which function pays, which function it
> contends with, and the cache lines involved), and the detailed code
> addresses / offsets stay in the per-cacheline detail view ('d').
> 
> Once we settle on the layout, I'll send the updated version for review.

Thanks for the explanation and it looks good!

Maybe you can add a shortcut to the cacheline view on the given item in
a follow up work.

Thanks,
Namhyung

