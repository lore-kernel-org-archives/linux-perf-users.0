Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD981CAA75;
	Tue, 11 Feb 2025 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739242260; cv=none; b=soo2VwMy3EFTqRp2ICjeLHw0mSUcMjxsyaLMv5pKx6NJUyEFQ6V7xU6Ls95bSmwBnMZcyuvuz8MBdmgh2iwQua8A9QOnMMFeaed0sLOnGl/DowGZvzb+HR8ZRIYLpPfiqN4PvjLflEVE9u5qZ3qzBYBauwnvWeK41qF4xLMqyPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739242260; c=relaxed/simple;
	bh=W2Jnw9t+bdCtAUM79lKQHiCogtFzeFZgQuCi6Zt5dSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eF54l3S9x2YRhraOMW/Uyrg6Acj4cdMxZ7DrpPQzMGECOfFvfnfUDksoN4/aF00JinlwtXfdkHYGw7fJziZqYqT5oFpgcilLtbvNFWd/icHTnDQZnPodg1kvTFEKantt0oRGk0mPmm2XNoBmFG+PaKI0HuKLksKnnMZ+2hATdV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CplYxa37; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CplYxa37"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507C5C4CED1;
	Tue, 11 Feb 2025 02:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739242260;
	bh=W2Jnw9t+bdCtAUM79lKQHiCogtFzeFZgQuCi6Zt5dSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CplYxa37C0+A1Kvn8MffZPOPk2q9uwTL75xoaRHaSsiIaHRr0f8llxJWXLUHWLOhD
	 8FhcQbiITZYfFbjXrSydylcje5v5dorMD+fGJuEJkfHzAmS2+Wwhzj/eWo7CcNigOI
	 lN/nY0uGSZgxq86/7w56lZ8rqalyP0uZ0cELMUtIH2UksDu7599fpncPEp6m/U5u6j
	 zT4cxvoBhd6AWmzck71ZITTrOjgusBOFfPGpw+NnJElOZD7PiZB5AsEIVPPQ+XybRG
	 ngZk/kNseN8IgsvysZvz8Mx0axW1ZeqJj5cIssoB96q7JDOa+fbTR05rcDGEQVWgLq
	 AdZtrk/+R+Qow==
Date: Mon, 10 Feb 2025 18:50:57 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Tavian Barnes <tavianator@tavianator.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andi Kleen <ak@linux.intel.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Michael Petlan <mpetlan@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: Re: [PATCH v1] perf sample: Make user_regs and intr_regs optional
Message-ID: <Z6q7EZxAvskBE4H3@google.com>
References: <20250113194345.1537821-1-irogers@google.com>
 <CAP-5=fVoQRhd-8jyXfjc2dCuwt7_o1sU208aADT1FriwCNa9qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVoQRhd-8jyXfjc2dCuwt7_o1sU208aADT1FriwCNa9qw@mail.gmail.com>

On Mon, Feb 10, 2025 at 10:15:22AM -0800, Ian Rogers wrote:
> On Mon, Jan 13, 2025 at 11:43 AM Ian Rogers <irogers@google.com> wrote:
> >
> > The struct dump_regs contains 512 bytes of cache_regs, meaning the two
> > values in perf_sample contribute 1088 bytes of its total 1384 bytes
> > size. Initializing this much memory has a cost reported by Tavian
> > Barnes <tavianator@tavianator.com> as about 2.5% when running `perf
> > script --itrace=i0`:
> > https://lore.kernel.org/lkml/d841b97b3ad2ca8bcab07e4293375fb7c32dfce7.1736618095.git.tavianator@tavianator.com/
> >
> > Adrian Hunter <adrian.hunter@intel.com> replied that the zero
> > initialization was necessary and couldn't simply be removed.
> >
> > This patch aims to strike a middle ground of still zeroing the
> > perf_sample, but removing 79% of its size by make user_regs and
> > intr_regs optional pointers to zalloc-ed memory. To support the
> > allocation accessors are created for user_regs and intr_regs. To
> > support correct cleanup perf_sample__init and perf_sample__exit
> > functions are created and added throughout the code base.
> 
> Ping. Given the memory savings and performance wins it would be nice
> to see this land. Andi Kleen commented on doing a reimplementation,
> which is fine but out-of-scope of what I'm doing here.

Yeah, I like the core of the change.  Andi's concern is that it touches
too many places.  It'd be nice if we can do that without allocating
memory for regs and eliminating the perf_sample__{init,exit}.  But I'm
not if it's possible.

Thanks,
Namhyung

