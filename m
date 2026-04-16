Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFC537BE8F;
	Thu, 16 Apr 2026 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353195; cv=none; b=XMaYjemw7ETiXbmRTftA5qoVYgsnP4By83Cj5Jmhc6A+XXTD5Rc/mnsJVHk+ADfe3OXaDXycNZC0liqOgSqO7syES+jdDqjZtpmavSXsTq+2g2sEUvELT1Jmh4LKez80Jx1VaQndeoF2unnjxVjeaJi/3JHzKfLUdl2LOa4Wjqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353195; c=relaxed/simple;
	bh=F0+Yhx8r47WTbUpmSIX9JGHqykxC7gGlPolhy0ZbDdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XO8UInz1mk9acWdUPHYyCqvNsCAG2dj3ASOIn76SyV6wksIwmxArh5RgAJB9vyORc/T+eOSl7Hk9pq0EWCG8X7gRK4Z5rzqAiwPvyqq3nBWV5mHywumsqAL2FXqYvFfcm0V9mk7F2GfYPVaF/zMNYFTGAXj07OBIVbsEC0m4HDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4zX728r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4zX728r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AD9C2BCAF;
	Thu, 16 Apr 2026 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776353195;
	bh=F0+Yhx8r47WTbUpmSIX9JGHqykxC7gGlPolhy0ZbDdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L4zX728rBW0f81bfgarw+xFlxj1elSTwt5B1ebPdYLs9S8r0snefYgRgHAPLh4GrZ
	 aZFWvFRHamyfnF8zyAToOVJrAJ6Or1SRR4VOJaTtjLGrl4Yc4BTq9KkxZKK+kF86Bu
	 kvZz7plL6tVb2TH3hza4wBp9SqWqFcttLZIfy6ZS4wLEeFmBrbkD6eIQHLf/pXexpG
	 Qvpbr4Y42rchpDAOxio0uFwtrE2N1jndZ41EXN4GJxNjPCd2mSkWksIjYWE7QTCKuZ
	 Ttkd4qT1U1silqjU53aGCk6G830DyumRF9ih6qLgbeEIVDhuXgzIVvWvuEv6zxUXCI
	 Bq57yBmZo/ewA==
Date: Thu, 16 Apr 2026 12:26:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 4/5] perf header: Validate bitmap size before allocating
 in do_read_bitmap()
Message-ID: <aeD_p9iGYlNNSSNZ@x1>
References: <20260416001424.362797-5-acme@kernel.org>
 <20260416022540.287E3C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416022540.287E3C19424@smtp.kernel.org>

On Thu, Apr 16, 2026 at 02:25:38AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [High] Integer overflow in process_mem_topology() leading to heap buffer overflow
> --
> 
> commit cc7a509cea916b4f4ae9c056c5eb0517bac22dfa
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> perf header: Validate bitmap size before allocating in do_read_bitmap()
> 
> This patch updates do_read_bitmap() to validate the u64 bit count read
> from the file before allocating memory. It rejects sizes that exceed
> INT_MAX or exceed the remaining section bounds, preventing potential
> large allocations or truncation issues with bitmap_zalloc().
> 
> Link: https://lore.kernel.org/linux-perf-users/20260414224622.2AE69C19425@smtp.kernel.org/
> 
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index 696f19739074e..89697aec914c9 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -290,6 +290,11 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
> >  	if (ret)
> >  		return ret;
> >  
> > +	/* bitmap_zalloc() takes an int; reject u64 values that truncate. */
> > +	if (size > INT_MAX ||
> > +	    BITS_TO_U64(size) > (ff->size - ff->offset) / sizeof(u64))
> > +		return -1;
> > +
> >  	set = bitmap_zalloc(size);
> >  	if (!set)
> >  		return -ENOMEM;
> 
> This isn't a bug introduced by this patch, but since the commit message notes
> that do_read_bitmap() is used by process_mem_topology(), does the same missing
> validation exist when allocating the nodes array in process_mem_topology()?
> 
> tools/perf/util/header.c:process_mem_topology() {
>     ...
> 	if (do_read_u64(ff, &nr))
> 		return -1;
> 
> 	nodes = zalloc(sizeof(*nodes) * nr);

This code now already has a bounds check and is using calloc:

        if (do_read_u64(ff, &nr))
                return -1;

        if (nr > MAX_NUMA_NODES) {
                pr_err("Invalid HEADER_MEM_TOPOLOGY: nr_nodes (%llu) > %u\n",
                       (unsigned long long)nr, MAX_NUMA_NODES);
                return -1;
        }

        if (ff->size < 3 * sizeof(u64) + nr * 2 * sizeof(u64)) {
                pr_err("Invalid HEADER_MEM_TOPOLOGY: section too small (%zu) for %llu nodes\n",
                       ff->size, (unsigned long long)nr);
                return -1;
        }

        nodes = calloc(nr, sizeof(*nodes));
        if (!nodes)
                return -1;

Probably you're working with upstream and the fixes are in
perf-tools-next/perf-tools-next.

> 	if (!nodes)
> 		return -1;
> 
> 	for (i = 0; i < nr; i++) {
> 		struct memory_node n;
>     ...
> 		nodes[i] = n;
> 	}
>     ...
> }
> 
> Because nr is an unvalidated 64-bit integer read from perf.data, could a
> crafted value like 0x2000000000000000 cause the 64-bit multiplication
> (24 * nr) to wrap around to 0 during the zalloc() call?
> 
> If zalloc(0) succeeds and allocates a minimum-sized heap chunk, the loop
> could iterate and write beyond the allocated bounds when assigning
> nodes[i] = n on subsequent iterations.
> 
> Could this overflow the nodes[] buffer?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260416001424.362797-1-acme@kernel.org?part=4
