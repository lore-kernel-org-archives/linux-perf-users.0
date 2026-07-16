Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AFA37D126;
	Thu, 16 Jul 2026 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224264; cv=none; b=eYkFBaPrlb9vkWjXTiKGYanXeXOOP+Y+/+Uwfmj28ZO5e8aaERRhdBPRB3/QPGiV1rjFPCrNsCEhE45OLxdKxR9ip1TEfe/a1HsBhn99w7M66BSqb7Ff6Wuc9UdriNuCMzdCQMOGFneHj+d0B3jKnphcw2FUJPqleznjHgyKoOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224264; c=relaxed/simple;
	bh=iuUPekhpWBaFUZOmhD29WAgOEjhYFzj2YNHWp9ytApk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpK3eKai1BOlO9kxmkM9HRN1j1vFDXZrcmCn1d4u/y1Miy5hMCFKE/v3Igpe5FrfFd5HTTXWpqpVzdOBCG9NqlXxE1mSfJCGmTWk5m8wpCh5k7haNOpZZzojGFsrA5TvYJTRBF6BTPBR1DNPxWLt4fL5oMcygzgAexljbTqcxTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNGkpGzu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNGkpGzu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5151F000E9;
	Thu, 16 Jul 2026 17:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784224263;
	bh=QcK/JYry3m35VGCmdDebre4dR9p7gR0RjysYC5Wev1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hNGkpGzukKisoYf1fG0xcfij/ctSdoKY2CRFtRkG7u+0RiERuRUdvwYVc/KBrLhe9
	 hbOPs013ZMWpCsoQgGmgI+yOblNMG69ehBd7c0gXMIIBWrSOVtzphC5fbV70IBbx5c
	 ch/io2iJ0Z85XuLeLLLRm4HYIogN1K/2OdB6W9h6WMNVZ9j/DdFQtJN4BE9a+lSggQ
	 TnLZrlPQzJErrhikCZ0I4aDis08CVB68kTlz5AEiwQHUbkSBdD9HzUzHkIcfqqoQMD
	 UQi7WMjXkHUa6Jn3MxyukzF+GVF8tfAngeKCX6NhISjK3fKyDAg/BDHic1YxQ1KBRT
	 Ol9z2ZusfacEg==
Date: Thu, 16 Jul 2026 10:51:01 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Jiebin Sun <jiebin.sun@intel.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 01/14] perf c2c: extract shared data structures into c2c.h
Message-ID: <alkaBTSMVXPWMJW6@google.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
 <20260626070355.1556721-2-jiebin.sun@intel.com>
 <20260626071353.3931C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626071353.3931C1F000E9@smtp.kernel.org>

Hello,

On Fri, Jun 26, 2026 at 07:13:52AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] Missing feature fallback inline stubs for SLANG-dependent functions in header.
> - [Medium] Asymmetric memory management API leading to potential resource leaks.
> - [Medium] Global namespace pollution with generic function names.
> --
> 
> commit e451cf21befaafcbe2925718151023dd5ccba2cc
> Author: Jiebin Sun <jiebin.sun@intel.com>
> 
> perf c2c: extract shared data structures into c2c.h
> 
> This patch moves c2c_hists, compute_stats, c2c_hist_entry, and perf_c2c
> structure definitions from builtin-c2c.c into a new shared header c2c.h.
> This allows the upcoming function view browser to reuse these types.
> 
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index c9584dbedf77a..33271554e354b 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> [ ... ]
> > @@ -141,9 +76,9 @@ static const struct option c2c_options[] = {
> >  	OPT_END()
> >  };
> >  
> > -static struct perf_c2c c2c;
> > +struct perf_c2c c2c;
> >  
> > -static void *c2c_he_zalloc(size_t size)
> > +void *c2c_he_zalloc(size_t size)
> >  {
> >  	struct c2c_hist_entry *c2c_he;
> 
> [Severity: Medium]
> By exporting c2c_he_zalloc(), is there a risk of memory leaks since a
> corresponding free function is not exported?
> 
> Looking at the rest of c2c_he_zalloc() in builtin-c2c.c, it allocates several
> sub-structures:
> 
>     c2c_he->cpuset = bitmap_zalloc(c2c.cpus_cnt);
>     ...
>     c2c_he->nodeset = bitmap_zalloc(c2c.nodes_cnt);
>     ...
>     c2c_he->node_stats = calloc(c2c.nodes_cnt, sizeof(*c2c_he->node_stats));
> 
> Any external module (like the new function view) that uses this allocator
> won't have an encapsulated way to clean these up, forcing manual duplication
> of the teardown logic to avoid leaks.
> 
> [ ... ]
> > @@ -1928,7 +1816,7 @@ static struct c2c_dimension *dimensions[] = {
> >  	NULL,
> >  };
> >  
> > -static void fmt_free(struct perf_hpp_fmt *fmt)
> > +void fmt_free(struct perf_hpp_fmt *fmt)
> >  {
> >  	struct c2c_fmt *c2c_fmt;
> >  
> > @@ -1936,7 +1824,7 @@ static void fmt_free(struct perf_hpp_fmt *fmt)
> >  	free(c2c_fmt);
> >  }
> >  
> > -static bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
> > +bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
> 
> [Severity: Medium]
> Could the removal of the static keyword here lead to symbol collisions?
> 
> Since fmt_free() and fmt_equal() lack a subsystem prefix (like c2c_ or
> perf_c2c_), exporting these generic names to the global namespace increases
> the risk of collisions during static linking or Link-Time Optimization with
> other perf tool objects.

I think this is a meaningful.  Even without collisions, it'd be better
to have a prefix for global functions.

Thanks,
Namhyung

> 
> > diff --git a/tools/perf/c2c.h b/tools/perf/c2c.h
> > new file mode 100644
> > index 0000000000000..3e974dd1d7ee6
> > --- /dev/null
> > +++ b/tools/perf/c2c.h
> [ ... ]
> > +#ifdef HAVE_SLANG_SUPPORT
> > +int perf_c2c__browse_cacheline(struct hist_entry *he);
> > +#endif
> 
> [Severity: Medium]
> Should this header provide a fallback stub for perf_c2c__browse_cacheline()
> when HAVE_SLANG_SUPPORT is not defined?
> 
> The perf subsystem build guidelines require header files to provide
> compatible dummy inline stubs (e.g., returning -ENOTSUPP) when feature
> defines are absent. Omitting the #else block here might lead to missing
> functionality or build breakages on systems lacking SLANG.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260626070355.1556721-1-jiebin.sun@intel.com?part=1
