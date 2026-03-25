Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD40303A37;
	Wed, 25 Mar 2026 07:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422336; cv=none; b=R6iSW3BLek+O9gY+W2vDjaFUhenC9qHx799MeYIrjxBtYrlcC7oEsWDH0TQNtuDb20ckf9N4dxS52VeK8ovhYyLsoCU9HfYHDFqiAoOKKnM3MMjUd5vA2HlfutE19ia40JrcbubX5ukTuyxBIPq5yeOovn+J1LYrgwv3JCNvcCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422336; c=relaxed/simple;
	bh=nfzKAfq3kDPK+xIZJ8PWoT/eBAI85WjtsNC/nZAEayA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGG5YAt8GlK3gCU/vHBXMg3ufNikAOnsjNYb1nC6iXMWGixMxZt6DRdeb3o7TY6fO7VZRneD5MPSidcHC8NZPcatwHW/8shciYEnYv2zDbHRdmu7LUy2tWyfc0zUegs/e8HgT7Q0cm/GiF3fTaIQe7bUDhAdenIz+gmYkq/6/Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxxbB5Bl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxxbB5Bl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C2DC4CEF7;
	Wed, 25 Mar 2026 07:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774422335;
	bh=nfzKAfq3kDPK+xIZJ8PWoT/eBAI85WjtsNC/nZAEayA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hxxbB5Bl8trWBJ1q/0xb4797xjYsfcSbMW3UmpwQNhO97/uVn2auM8WAwErnG/Q4i
	 qDo/CF1CEVMyM4VTzB/kXUqeHlknA7mdOMFrbgmiOdEavBrAgWC6Qv+rsuVFH35OL2
	 Oe427MnX0d3DIYz9Zeiu0PGirzGoD76IVV713oxmN4BT07nSI3zJk5ZcsOTttmmE91
	 rC8E8+Fny9J6j8en/fssMUjwqoKbgo30CCNuiM/boo6x4DhPIHofXhJVdKS845AAVm
	 hFHtC6tet5f1V6D1K04ZAszp/M4TLB+gOASopWYCdDyUADles4VfGhZ/BzvWNUjAJ0
	 15M7T+r3CBmJQ==
Date: Wed, 25 Mar 2026 00:05:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Honglei Wang <jameshongleiwang@126.com>, acme@kernel.org,
	Thomas Richter <tmricht@linux.ibm.com>, mingo@redhat.com,
	peterz@infradead.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, james.clark@linaro.org, ojeda@kernel.org,
	gary@garyguo.net, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf symbols: Add 'intel_idle_irq' to the list of idle
 symbols
Message-ID: <acOJPVxR7MRLE4NW@google.com>
References: <20260323085255.98173-1-jameshongleiwang@126.com>
 <CAP-5=fVdxJxSAYyAoS_UVxQqOtS1GrhHphEag=Ksb2Oc+NuCGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVdxJxSAYyAoS_UVxQqOtS1GrhHphEag=Ksb2Oc+NuCGQ@mail.gmail.com>

On Mon, Mar 23, 2026 at 11:35:05AM -0700, Ian Rogers wrote:
> On Mon, Mar 23, 2026 at 1:53 AM Honglei Wang <jameshongleiwang@126.com> wrote:
> >
> > Commit 32d4fd5751ea ("cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE")
> > introduced intel_idle_irq as entry of those with
> > CPUIDLE_FLAG_IRQ_ENABLE, say, skx and icx so far. Let's add a new
> > one to the list of idle symbols to avoid noise.
> >
> > Signed-off-by: Honglei Wang <jameshongleiwang@126.com>
> > ---
> >  tools/perf/util/symbol.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 8662001e1e25..7cff66e7ce06 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -730,6 +730,7 @@ static bool symbol__is_idle(const char *name)
> >                 "cpu_startup_entry",
> >                 "idle_cpu",
> >                 "intel_idle",
> > +               "intel_idle_irq",
> 
> It would be nice to make this an Intel specific idle symbol. I sent
> out a patch set to do this:
> https://lore.kernel.org/lkml/20260302234343.564937-1-irogers@google.com/
> but there are no reviews. Perhaps we can follow up that patch by
> adding this symbol. Arnaldo, Namhyung, wdyt? I believe Arnaldo was
> supportive in:
> https://lore.kernel.org/lkml/aahC-zp56irr5e2k@x1/

Yeah, I'm ok in general.  I've left a comment there.

Thanks,
Namhyung
