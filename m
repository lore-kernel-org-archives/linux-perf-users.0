Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046993C1992;
	Fri, 10 Jul 2026 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783720274; cv=none; b=qXb1BRmhULm20+7OhbPVwg35+WwfepTU9qXWfmy9tssqyTMcUC4krjc0AtWSTNtfdIK/5tRD+lXemHNGlQkKuLjcFZj1mHw746P0nsLdbLyTjrYAxV+0eow49upNnXP1p0BHkvqZwFJG3zGCoGFS8Nwqfwa2y9kGH3VJHknqJg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783720274; c=relaxed/simple;
	bh=qaSg0AcdrVfin2VTQYj8En9FMp/D1W4qkhzxD2RZYfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddPrMZBdFgZQfQdpTKBVbuISFzWPu4dw2d0GHgqDYTPOgP88C7B51vnoAVlWQZO/03aTVqd/nvvc0FWfLswjZ8z+tcUyMDQtBzorF4ppX1SLPN4KbC8ARoWMrVg11X6TJ1dYe78cTnrf9Z/0oELBRlE1ERU/6CUDY+E2XK4y/SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9zGu/47; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9zGu/47"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860791F00A3E;
	Fri, 10 Jul 2026 21:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783720272;
	bh=unrAKW3KktwtxmHC0X0GH8biwBItg8oMt9srSf1ShXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n9zGu/47DmtzmWC+UQnj42ShnSpJDMhdgGRPQMTz6JnF6tfJ7iD1G4e+V8G6P5xSV
	 VZcLBLaJeFQ3dvuFMDrRoOcb+Q2lPJsc7Su5Rmpumc+PUv/4yZQfoWh4ybKLPCRq3l
	 8wXYGWp3ERIiPkvSbKTud5Ig+VKdhTt5XQq0XuOgkmivvQ/IbZAF9jLVOzjEKwupVF
	 lnRfWmH1BefFC2t1NZKRxp5TYcKkW2djwo/eoYFJjKmFf8r18PdTB6a4Tgh3nmb6Rt
	 z8YJOCiC4FEdkbuSXURLSvbpZ0Sp+bHxfh6Dr/jfefdaxHBsU1ZYTWzYjulyWu+ogC
	 ZTU4C3lh8nJSQ==
Date: Fri, 10 Jul 2026 14:51:11 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] tools/lib/api: Check nonfilterable in fdarray__filter()
Message-ID: <alFpTwZSuYR6eh0u@google.com>
References: <20260710194222.1788638-1-namhyung@kernel.org>
 <20260710200150.11FE71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710200150.11FE71F00A3A@smtp.kernel.org>

On Fri, Jul 10, 2026 at 08:01:49PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] If `realloc` for `fda->priv` fails in `fdarray__grow()`, a dangling pointer is left in `fda->entries`, leading to a double-free during error cleanup.
> --
> 
> --- Patch [1]: [PATCH] tools/lib/api: Check nonfilterable in fdarray__filter() ---
> commit f87f1b3c291ca03e96598f96697566a328711de3
> Author: Namhyung Kim <namhyung@kernel.org>
> 
>     tools/lib/api: Check nonfilterable in fdarray__filter()
>     
>     IIUC fdarray__filter() should check filterable events only and leave
>     non-filterable events to be handled outside.  The recent change to set
>     fd to -1 made perf record test stuck forever.  Adding the check the flag
>     fixes the problem for me.
> 
> > diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> > index ffe8272af59b2..b4570e4981492 100644
> > --- a/tools/lib/api/fd/array.c
> > +++ b/tools/lib/api/fd/array.c
> > @@ -117,6 +117,8 @@ int fdarray__filter(struct fdarray *fda, short revents,
> >  	for (fd = 0; fd < fda->nr; ++fd) {
> >  		if (!fda->entries[fd].events)
> >  			continue;
> > +		if (fda->priv[fd].flags & fdarray_flag__nonfilterable)
> > +			continue;
> 
> [Severity: High]
> This is a pre-existing issue, but while looking at this file I noticed a
> potential double-free in fdarray__grow() during error handling.

I'll handle this in a separate patch.

Thanks,
Namhyung

> 
> If the realloc for fda->entries succeeds but the realloc for fda->priv
> fails, the error path frees the newly allocated entries:
> 
> tools/lib/api/fd/array.c:fdarray__grow() {
>     ...
> 	struct pollfd *entries = realloc(fda->entries, size);
> 
> 	if (entries == NULL)
> 		return -ENOMEM;
> 
> 	priv = realloc(fda->priv, psize);
> 	if (priv == NULL) {
> 		free(entries);
> 		return -ENOMEM;
> 	}
>     ...
> }
> 
> However, fda->entries is neither updated to point to the new entries block
> nor cleared to NULL. If realloc moved the allocation to a new block, the
> old fda->entries pointer is now freed memory.
> 
> When fdarray__exit() is later called to clean up, it executes
> free(fda->entries), which would trigger a double-free on that old pointer.
> 
> Would it be better to clear fda->entries to NULL here, or avoid modifying
> the struct state until both allocations succeed?
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260710194222.1788638-1-namhyung@kernel.org?part=1
