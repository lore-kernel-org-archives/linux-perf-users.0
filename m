Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4A331690E;
	Wed, 20 May 2026 23:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779318402; cv=none; b=NKwsuYxaxKN038cJkeqvTlY+ef6WoBqx+8e6HGwiGIriYkD9c65FniTv4avGtFuNk6K/sRF4vP7bvlzYXzejldqF6ohpHXlInAONHrkLav8GRSadOuEp8/lLZvFuHiUDxFiTqVX5yRmYgtz1EiNnwPxp5CFEHXr0jt/BP+FcHdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779318402; c=relaxed/simple;
	bh=V8npBN7LV0RpqPsvQUxlaeLra7vu34l79Yd2KRESp0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0Y6fbzZpNGddOX/7S33tzPh66NfgtxicblMOdDXP/CErY8cqRRnu3wVVAr7naGhxCjNfQM5Q/q0tUShEMQnjDFDvvXhLuiaeCxp0BAEXbQ+NlKkcxpNqZVgBeO5vUtphjxcPkvKeuKDW5bR4tk9uFJuxAMM8VaSsiAjQOSKE78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDJZBVUw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDJZBVUw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CF61F000E9;
	Wed, 20 May 2026 23:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779318401;
	bh=/5yGs/8QbClf1BwOYqoe7q+EnPGvcx77N8f7tNsA7AE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XDJZBVUwG0e09QOXOlfdt7L1HqAVYeAavzCk59onv5jme3R0q7o/nE/vLg64DUS/g
	 lXGyGqPFnoL/rnnzWF4blUS7yL0dzv/x2XvlO0IHwoXTLx8CXPPfp+qFcbO3WUk+9X
	 C1lzYSvzpnh49a4KWzKxSNpdv/w6T6qZGbXBas/9A8Q8+LWON0we1SOW2BIqrSYsHO
	 eEoh0QIcMkhu0K9Xu/G9XnFduzCzqDiLUNFEjA//zl5jTWxEdDCnVj2TejUt9++4Ux
	 IEAa9h7P1wt0HlN3kIrE5brqbutX/U2ZLbrt7vkm/+wPWo9NQehS62y6PDBbsYoA8p
	 js9McHL/nMnBg==
Date: Wed, 20 May 2026 16:06:39 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	nigro.fra@gmail.com, peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v4 1/2] perf tool_pmu: Make tool PMU events respect
 enable/disable
Message-ID: <ag4-f39wo4OKgYew@google.com>
References: <20260518223733.3034897-1-irogers@google.com>
 <20260519014106.3089452-1-irogers@google.com>
 <20260519014106.3089452-2-irogers@google.com>
 <agwGdqBaeEEXnAtp@z2>
 <CAP-5=fVsCXqC2-0-huGq5qdkdqY1KuKO=mdv7ZorTjdgyWF+Ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVsCXqC2-0-huGq5qdkdqY1KuKO=mdv7ZorTjdgyWF+Ag@mail.gmail.com>

On Tue, May 19, 2026 at 01:13:35AM -0700, Ian Rogers wrote:
> On Mon, May 18, 2026 at 11:43 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, May 18, 2026 at 06:41:05PM -0700, Ian Rogers wrote:
> > > Tool PMU events (duration_time, user_time, system_time) currently
> > > count from when the event is opened to when it is read. This causes
> > > issues with features like the delay option (-D) or control fd, where
> > > events are opened but should not start counting immediately.
> > >
> > > Make these events behave more like regular counters by implementing
> > > proper enable and disable support. Add accumulated_time to struct
> > > evsel to track time while enabled, and implement enable/disable CPU
> > > callbacks to start/stop counting.
> > >
> > > Also generalize userspace PMU mixed group handling. Userspace synthetic
> > > PMUs (type > PERF_PMU_TYPE_PE_END) do not have kernel implementations and
> > > cannot be grouped in the kernel (opened with group_fd = -1), and are
> > > skipped by kernel enable/disable calls. Iterate over group members in
> > > userspace and manually enable/disable any members if the leader or the
> > > member is a non-perf-event open PMU, and synchronize their disabled flags.
> >
> > Can we divide the commit into smaller pieces?  I think we can have
> >
> >  * preparation for accumulated_time
> >  * implement enable/disable for tool PMU
> >  * wire them to evsel__{enable,disable}[_cpu]
> >  * support group members properly
> >
> > What do you think?
> 
> That sounds needlessly painful, involving many irrelevant intermediate
> states with dead functions and variables. Most of the patch is
> confined to tool_pmu, we could make the evsel patch smaller by
> removing comments. The changes in evsel are pretty minimal and the
> patch is largely confined to tool_pmu.

I didn't think it'd add many temporary code especially for group
handling.  But I'm fine with the single patch if breaking it up would
cause a lot of pains to you.

Thanks,
Namhyung

