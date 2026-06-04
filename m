Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A723E2AC8;
	Thu,  4 Jun 2026 21:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780607706; cv=none; b=ddvJHh9NRS6742rlhBZVbqdWH6KTGsuQnhWiuH8K8LSoV2a30OmcPdjuru9SQ9BQVNilnCy+qr/DSX5kmW+JtY5Xj2LaeZLRejeJlsDjC31ANhCtoBh7BIo571hQ7/htqGkDch5iOzCI5nUF5/Zb/8Nhymk9x4opf4bDEl36U6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780607706; c=relaxed/simple;
	bh=WEPhgeZ5v7o05IhmsPQA+0VY2O4s/DcLdIM2+sKoqJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbyT663N7CA8ESE/U8Hy/H13Ra6Y0eSXk08oWo9CexqqLemrk9AoSJy87LsCw9+aKmVSlhjMcr74mUQbRETMvLG2k3bCFHfm2wgOIL1KZ+eaR/kSptg97xDQD7sRwV9aRVIafGWebFebE0GcFnemy1hDixFJbkis8EB28gzC7g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0uHVBN+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0uHVBN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA391F00893;
	Thu,  4 Jun 2026 21:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780607705;
	bh=Ny/KVvtry5ETYhSHZ762wNa07hCQUVPHNbtvrPR+Llg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j0uHVBN+P/r70HDMp3PXhJYqX1XMpNpMQdBRd+9gfnS/o9bJFtQxrfCM1y/0KO0dq
	 T7fyn0iTTRa3kX2jIfrhjfz7WnR6Up0dImWmaXGJdshggL6l2ZW0DgTS+BhmFXa9Pr
	 BFWtqLc3m4L4pte1sf5pVZWysawN3Ye2YsoGKnXiNyqAiJWLBaXbczUmBYrmiVW8Mu
	 jUy+NS5J9mnYrv0/xaWR33XPIm8dx3Rg6UllkOVwZOTw8sdYbxzqoBow9x6KL5X3f7
	 lTk2UcQQ5Mw756UmSag/qBCnxmULMVaLtnOU7/5WnbbO0Dpre4Ra+QTW4VNXOMvVFT
	 k+2pmK1ZOj6Bw==
Date: Thu, 4 Jun 2026 18:15:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/4] perf tools: Guard test_bit from out-of-bounds sample
 CPU
Message-ID: <aiHq1ftD8tIVK_6q@x1>
References: <20260604204921.1707333-2-acme@kernel.org>
 <20260604210904.468941F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604210904.468941F00893@smtp.kernel.org>

On Thu, Jun 04, 2026 at 09:09:03PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The patch adds `MAX_NR_CPUS` bounds checks to several call sites of `test_bit()` to prevent out-of-bounds reads from corrupted `sample->cpu` values, but misses an identical vulnerability in `tools/perf/util/auxtrace.c`.
> --
> 
> commit 086b55e55838d35a34eaf71d763ccfabb74ba9a3
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> perf tools: Guard test_bit from out-of-bounds sample CPU
> 
> This commit adds guards against MAX_NR_CPUS before test_bit() calls across
> several built-in tools to prevent out-of-bounds reads on corrupted
> sample->cpu values.
> 
> > diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> > index b918f9eed5fd2..8a0eb30eac24f 100644
> > --- a/tools/perf/builtin-annotate.c
> > +++ b/tools/perf/builtin-annotate.c
> > @@ -295,7 +295,8 @@ static int process_sample_event(const struct perf_tool *tool,
> >  		goto out_put;
> >  	}
> >  
> > -	if (ann->cpu_list && !test_bit(sample->cpu, ann->cpu_bitmap))
> > +	if (ann->cpu_list && (sample->cpu >= MAX_NR_CPUS ||
> > +			     !test_bit(sample->cpu, ann->cpu_bitmap)))
> >  		goto out_put;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does a similar out-of-bounds
> read of cpu_bitmap exist in tools/perf/util/auxtrace.c?
> 
> Looking at filter_cpu() in tools/perf/util/auxtrace.c:
> 
>         return cpu_bitmap && cpu.cpu != -1 && !test_bit(cpu.cpu, cpu_bitmap);
> 
> Since auxtrace events can bypass the upstream clamping logic in
> perf_session__deliver_event(), could a corrupted cpu value from a
> perf.data file exceed the bitmap size?
> 
> Should filter_cpu() also verify cpu.cpu < MAX_NR_CPUS before calling
> test_bit() to prevent reading past the allocation?

We're addressing this in a followup series,

- Arnaldo
