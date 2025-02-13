Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4702054FD;
	Thu, 13 Feb 2025 04:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419558; cv=none; b=Kj6aw8cgvyLq5K0Gryfn/8WxMgs+Q4TTaj4SNBkMLn3VtId0OL2bbnW0pScsYqvBYhPiAg5Cbl1/B3CcwO+Khupq7eakdjHNhhXFY8k2NWCeiM1s40r4tb3MhgEPhHLoiYaZPCD5KPZoBO7nkXbkdQGtMXT+C9VFyHnRnbLltOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419558; c=relaxed/simple;
	bh=u0CEnCfaVdP25a8GNpqFlUn1aE+Tvo2eIuxsK/SLlkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3HZKKd2RA2tfXAG9bmRyoVpfJN49Q9Y3LNgriZAqiZwnoNr5A2ND92bpnC7dVv5UnisRtdadayzmzWj877l9kfWTitu0KfMHwHI9hy7AqRZ9L8oQDzagzlURvRIWSrtLenkulkZ957uBuSUdrkSlJqZFYu+poXYx9GYmwRqScA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKusks44; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKusks44"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6EEC4CED1;
	Thu, 13 Feb 2025 04:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739419556;
	bh=u0CEnCfaVdP25a8GNpqFlUn1aE+Tvo2eIuxsK/SLlkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GKusks44ebGPBvDKT5blKuv+vNUXh25zFAzyvz2dvr7IGAVLx72bzJknEEkGrJ3C/
	 9rdudCWVHQYDoJpvIvfNxg+it2HbDVR50DZ6b+B85a33SxbXIqK8lcqAWca7b1FXAv
	 MRLZAS8MLBQyVuUSfBM0PskgbriS24jrLpewZK82vb665iW50HaIk7DRttDOdav0CX
	 dm+5Z/bcHLrmVJswW2YpuehBcsLBauX7Er5OsZHyQnEmkXCpxclelToAoBQ4kOQ4d0
	 EsUY3RuqK7fMIjoG8QrbzDsCshxEjFt3MEWwBlckzMD8XdQkyQrbnGzIAmueqmMLbX
	 S9Xi1zr9sN/Nw==
Date: Wed, 12 Feb 2025 20:05:54 -0800
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
Message-ID: <Z61vosIP67VMUJAS@google.com>
References: <20250113194345.1537821-1-irogers@google.com>
 <CAP-5=fVoQRhd-8jyXfjc2dCuwt7_o1sU208aADT1FriwCNa9qw@mail.gmail.com>
 <Z6q7EZxAvskBE4H3@google.com>
 <CAP-5=fUTBJ_15f1WFuHjZzbWDwsAo3d90WX_hobfVWPjSOe3Vw@mail.gmail.com>
 <Z6uM48_IJa-AEzEI@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6uM48_IJa-AEzEI@google.com>

On Tue, Feb 11, 2025 at 09:46:11AM -0800, Namhyung Kim wrote:
> On Mon, Feb 10, 2025 at 08:43:40PM -0800, Ian Rogers wrote:
> > On Mon, Feb 10, 2025 at 6:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > On Mon, Feb 10, 2025 at 10:15:22AM -0800, Ian Rogers wrote:
> > > > On Mon, Jan 13, 2025 at 11:43 AM Ian Rogers <irogers@google.com> wrote:
> > > > >
> > > > > The struct dump_regs contains 512 bytes of cache_regs, meaning the two
> > > > > values in perf_sample contribute 1088 bytes of its total 1384 bytes
> > > > > size. Initializing this much memory has a cost reported by Tavian
> > > > > Barnes <tavianator@tavianator.com> as about 2.5% when running `perf
> > > > > script --itrace=i0`:
> > > > > https://lore.kernel.org/lkml/d841b97b3ad2ca8bcab07e4293375fb7c32dfce7.1736618095.git.tavianator@tavianator.com/
> > > > >
> > > > > Adrian Hunter <adrian.hunter@intel.com> replied that the zero
> > > > > initialization was necessary and couldn't simply be removed.
> > > > >
> > > > > This patch aims to strike a middle ground of still zeroing the
> > > > > perf_sample, but removing 79% of its size by make user_regs and
> > > > > intr_regs optional pointers to zalloc-ed memory. To support the
> > > > > allocation accessors are created for user_regs and intr_regs. To
> > > > > support correct cleanup perf_sample__init and perf_sample__exit
> > > > > functions are created and added throughout the code base.
> > > >
> > > > Ping. Given the memory savings and performance wins it would be nice
> > > > to see this land. Andi Kleen commented on doing a reimplementation,
> > > > which is fine but out-of-scope of what I'm doing here.
> > >
> > > Yeah, I like the core of the change.  Andi's concern is that it touches
> > > too many places.  It'd be nice if we can do that without allocating
> > > memory for regs and eliminating the perf_sample__{init,exit}.  But I'm
> > > not if it's possible.
> > 
> > Moving from no allocations to 2 possible allocations means there has
> > to be corresponding frees. Putting the frees into an __exit function
> > is the norm for this kind of cleanup. I don't see how you can move to
> > the approach presented without adding the frees and not introduce a
> > memory leak. I don't see what's actionable for me to do here.
> 
> Right, I'm inclined to merge this patch.  But I need to think a bit more
> about the Andi's approach before that.

Probably we can use a global (or per-thread) variable, but I think it
could grow to another pain point in the future.  Using __init/exit will
make it easier for potential future changes.

Thanks,
Namhyung

