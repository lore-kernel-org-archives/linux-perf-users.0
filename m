Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023261EF39E;
	Fri,  5 Jun 2026 23:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780701621; cv=none; b=o6kBoriXHyWONq05bJ5pNzb21B9Zlr3luqRE2oB6Z3ASKBjtpB88xgYEVKAbZCZVs9+sF60fRHbDvxPTGDicfiVEy1aL8Jp6ZdMPuqoNDSXtBPELAWo6qbVGWQ0bOb9NPy0czn4waptxWoyFPxlFuudcxYVZfGd+jSCWfY17qGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780701621; c=relaxed/simple;
	bh=rep01GjTiS7mmfeNLXcOFqiYNyKLR2HyP0OqTB8m/RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ho8G+8LQfRqqEVv4Grgcpce0wFvDiXUpkkVSFVPLbbRpOSQWZb3ok4hh/NS60HFn8me77Kgm9g957kDPQ0MLWPSJ36cj33DG3AxEH+9Hn4z/cy6r1xMXyHQkruSkJNoKM3DCNjKjaODXi83conBDY60lquufa7MnAHKrJO4RsfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpDOA4WP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpDOA4WP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC021F00893;
	Fri,  5 Jun 2026 23:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780701620;
	bh=wsSymKiv+bqvg+yxwnnhJFDTdDNrgIvX42eImmsX88E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KpDOA4WPx/eAdlN6CbLo25G8if4E0k99e05/ew4t/zNXLBFkcB/CebBLY5fofRISl
	 gD7RFWeJUOXHOhkDQZtTp8zrLycH8WoVSm9VLXwLlAnRIoQo3ZqzwNUDHy9/HFKYSH
	 yS3ijlrxbEdvYHvdXx0brPfQg0lwqoc+F/Z3Q/LNIv6v1fuFAh+DOuKUF0+HWHK1oQ
	 FtJrNbw6EpNPSkQGv+l/dRN6hgB68SoigVJX6fdxoWGr/uKHm7AohEnkVZrGAATDOd
	 MM7wvmKS+R/AaGpxC57bZBWkQtLS5tH953AJX7NolvXZ3aqzadz5ZoEHJsYv4zK3jz
	 cypkMu9h7LN5g==
Date: Fri, 5 Jun 2026 16:20:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/4] perf timechart: Fix memory leaks in draw_wakeups()
Message-ID: <aiNZs9iy4uhIRsh3@google.com>
References: <20260605231155.2415760-4-namhyung@kernel.org>
 <20260605231734.1241B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260605231734.1241B1F00893@smtp.kernel.org>

On Fri, Jun 05, 2026 at 11:17:33PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The modified fallback loop condition `while (c && !from && !to)` prematurely aborts the search for task coordinates if either `from` or `to` has already been found.
> --
> 
> commit 757fad46c9b9ecd50deaba0cc7cc1ec56200ab8e
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf timechart: Fix memory leaks in draw_wakeups()
> 
> This commit modifies the fallback coordinate search in draw_wakeups()
> to only run when it doesn't have from and to tasks, and ensures c->Y is
> set before copying the comm string to fix memory leaks.
> 
> > diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
> > index fded4be93de0d..9ac4662ef16e9 100644
> > --- a/tools/perf/builtin-timechart.c
> > +++ b/tools/perf/builtin-timechart.c
> 
> [ ... ]
> 
> > @@ -1071,12 +1071,12 @@ static void draw_wakeups(struct timechart *tchart)
> >  					c = c->next;
> >  				}
> >  				c = p->all;
> > -				while (c) {
> > -					if (p->pid == we->waker && !from) {
> > +				while (c && !from && !to) {
> 
> [Severity: Medium]
> Will this condition prematurely abort the search for the second task's
> coordinates?
> 
> Because the waker and wakee are typically two different PIDs, they are
> processed in different iterations of the outer per_pid loop. When the first
> one is found, either from or to becomes non-zero.
> 
> When the outer loop reaches the second PID, the condition !from && !to
> evaluates to false immediately, which skips the fallback coordinate search
> entirely for that second task.
> 
> Should this condition instead be !from || !to so the loop continues as long
> as either coordinate is still missing?

Oops, right.  I meant it.  Will send v2 soon.

Thanks,
Namhyung

