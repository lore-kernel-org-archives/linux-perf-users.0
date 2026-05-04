Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4693732E692;
	Mon,  4 May 2026 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777937462; cv=none; b=meB8fSJ4KtNqDY4ElL512cobE/+7XLWraBrQkzhNjFYQ59Z0d8wASXqAeXwpac/pkzDx32dzreK71hWfcDtVcGSlQ230rK/SmoCH2WAm0oZntvEsQ2D6XQ8QWhRAw6L9emy8H1qUSbK7XhT96/pp/oookTMcxLmzzhzehX5xFpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777937462; c=relaxed/simple;
	bh=Z5wfnZWhOyKOpMCNFKwDJKTeMfCEgackwehE3ieS3ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dD+lPU+i7pywXaBzrYFJ1T9V5pslPQfaVgcIhGPC3whUpIdAWopVMgfjRC7fNMdCziNMODtTQ0jJD0sqLPO8FvcXOibfiotA2M0xcRS7+UE/ulRiiR+rCyxQPfj4VC19RSAbMsNFU/k3O60Ff/ggYHgamdjNs53qJifXIMCWzz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCMiZ3qR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCMiZ3qR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDDDC2BCB8;
	Mon,  4 May 2026 23:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777937462;
	bh=Z5wfnZWhOyKOpMCNFKwDJKTeMfCEgackwehE3ieS3ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PCMiZ3qRRCnhjVHlOB4x7N5+eHDmFkwLVo+qtdFTyyBq3T8/AR1LfV8bFmrcQDGRT
	 +irxyY49Lciyk5DT7X2Ldn9xc4I9psW4/wosOaX3isA7ZDRZ/5Fixt4wJa0Xz8ZYrP
	 IMFGM9E+C6sTH/iaBdILAdCXPycPnD95wHBJ4BWXOQ/9ILiU1aK0xbltTIOIKjBRNJ
	 6c5BxCViFZO81vgtvnsCCjOtTQqhmLkxUkxCRm5mq8M16Hw1l/9EkOq+nS/jJPB5Ue
	 KNr1HwrXszdqLZxTrZajZblQVToOmLlIBFKTC3y8C3FdMeEStMH3ZmJHPC//7ydicy
	 x1x91gpBzi8+A==
Date: Mon, 4 May 2026 16:30:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf lock contention: Allow 'mmap_lock' in
 -L/--lock-filter
Message-ID: <afksMvncKxnSA2Nj@google.com>
References: <20260504060859.84987-1-namhyung@kernel.org>
 <20260504062743.CCE73C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260504062743.CCE73C2BCB8@smtp.kernel.org>

On Mon, May 04, 2026 at 06:27:43AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Combining `mmap_lock` with other lock names in the `-L/--lock-filter` option drops all events.
> - [High] Specifying only an unknown lock symbol in `-L/--lock-filter` silently traces all locks in the system instead of aborting.
> --
> 
> commit ba21190eae512a9060154fb29ca23ce62c636cc2
> Author: Namhyung Kim <namhyung@kernel.org>
> Subject: perf lock contention: Allow 'mmap_lock' in -L/--lock-filter
> 
> This commit adds support for filtering lock contention events specifically for
> the 'mmap_lock' using the -L/--lock-filter option. It introduces a special
> flag to bypass the usual address-based filtering for mmap_lock.
> 
> > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> > index cbd7435579fe..cd7ee5d1d1dd 100644
> > --- a/tools/perf/util/bpf_lock_contention.c
> > +++ b/tools/perf/util/bpf_lock_contention.c
> 
> [ ... ]
> 
> > @@ -264,7 +270,10 @@ int lock_contention_prepare(struct lock_contention *con)
> >  			con->filters->addrs = addrs;
> >  		}
> >  		naddrs = con->filters->nr_addrs;
> > -		skel->rodata->has_addr = 1;
> > +		if (naddrs > 0)
> > +			skel->rodata->has_addr = 1;
> > +		else
> > +			naddrs = 1;
> >  	}
> 
> Prior to this patch, providing an unknown symbol (e.g., -L non_existent)
> resulted in naddrs = 0 and has_addr = 1, which correctly caused libbpf to
> fail creating the map with 0 entries, gracefully aborting the process.
> 
> With this change, if naddrs is 0, has_addr remains 0 but naddrs is
> artificially set to 1. The BPF map creation succeeds, but since has_addr
> and has_mmap_lock are both 0, the BPF program skips the address filter
> entirely.
> 
> Does this unintentionally trace all locks in the system instead of gracefully
> aborting when an unknown lock name is provided?

Ok, I think this is a valid concern.  Will update in v2.

> 
> > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > index 96e7d853b9ed..45ec2fb73984 100644
> > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> 
> [ ... ]
> 
> > @@ -295,6 +298,14 @@ static inline int can_record(u64 *ctx)
> >  			return 0;
> >  	}
> >  
> > +	if (has_mmap_lock) {
> > +		__u64 lock = ctx[0];
> > +		__u32 flag = ctx[1];
> > +
> > +		if (check_lock_type(lock, flag) != LCD_F_MMAP_LOCK)
> > +			return 0;
> > +	}
> > +
> >  	return 1;
> >  }
> 
> The -L option allows filtering by multiple lock names, but can_record()
> evaluates active filters sequentially. If a user specifies
> -L mmap_lock,other_lock, both has_mmap_lock = 1 and has_addr = 1 will be
> set in the BPF rodata.
> 
> In this scenario:
> 
> 1. An other_lock event passes the has_addr check but then reaches the
> has_mmap_lock check. Since its type is not LCD_F_MMAP_LOCK, the function
> returns 0.
> 
> 2. An mmap_lock event is evaluated against the has_addr check first.
> Because its dynamic address isn't in addr_filter, the lookup fails, and the
> function returns 0 before even reaching the has_mmap_lock check.
> 
> Will this cause all valid events to be silently dropped when combining
> mmap_lock with other lock names?

Good point, I'll handle the case mmap_lock and another lock are used
together.

Thanks,
Namhyung
