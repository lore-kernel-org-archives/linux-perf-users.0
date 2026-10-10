Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9CB363C43;
	Sat, 10 Oct 2026 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791658965; cv=none; b=QFU1dMxIyrTs1wz2DAze/scLnoCh4AX2ZKTHDfP091L4Cy6dgizt6ODuF9DEGzGwEaBui6fZ0R82MNpjEC+vlS2eZTYY2Hwv0A4qlGn+HIZtOogrcjxWDV5CXcEgWTWDMa8ymrmb4lV6PDwy9HR+M3/LB1bE0JiOXI94+Gmxnnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791658965; c=relaxed/simple;
	bh=/VMte0ffuAZ1bosOQRduKeracz6dH8KUEQKvDmnfsDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmQwGCOKmHLwqUMtxn8Ca+4iVrx/tnqC7f48vsrbtKxe1corkfZqxJdQXmHYJXSMxwnBP3FUgSRmmxYV/DgvdaQMAnTF7yrjlNe1syVdJJxgLnWJWC7hLhFPVlqqZwgc8rVTIEoz36EIF0e4Z7WJEjrJFtqVU/Yx5Nb8U2CN/5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGAf1a1O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGAf1a1O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FF91F000FF;
	Sat, 10 Oct 2026 19:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791658964;
	bh=ZBD94Bjwda+F367RH96wAT8/ImLjLZBk225gVxmnTPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hGAf1a1OViU/NTMk1uWwjJpCfe7JWVgvsC7BcZ4nOK81r5MaCPeGcJJiiNO6uQe9p
	 LLffCn3PHnb61Qx14lgDoH2c88eB+ZdwTeklT5UwRaMhM4WWiv/rEUMOQ8a9o9yfT9
	 1jtIID7cnrc/IRp0wGMMxyORVhFA/2KmXPsk0f97sxAVfzUXZ7GVwL+SFrablFvk3k
	 tqvkcIFA6Cr7pAx/s10WBaXcLTf3O+Bskeu+bVWczj0WmGXvjNxRqVBTUZqwHmjAhf
	 TAhL1nVDbtfvxDgbyYJwHDpA2WTvIvMjoZgGiCkjWTru6DYwpjVAct+126FK7R520h
	 6OxSQbzOJAOEg==
Date: Sat, 10 Oct 2026 12:02:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 3/3] perf symbol: Set dso symtab type for libbfd
Message-ID: <asqL0l19OLRbQ6VG@z2>
References: <20261010182439.9732-1-namhyung@kernel.org>
 <20261010182439.9732-3-namhyung@kernel.org>
 <sashiko-outbox-166825@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-166825@kernel.org>

On Sat, Oct 10, 2026 at 06:34:40PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] perf: double-free and state confusion in libbfd fallback path
> --
> 
> commit 8791c82124897f35132a0fe029d993b2dcd4a6bc
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf symbol: Set dso symtab type for libbfd
> 
> It missed to set the dso symtab type when the symbols are loaded by
> libbfd.  When it happens both syms_ss and runtime_ss may not be set
> and won't call dso__load_sym().
> 
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 5e63c3477570c..debd0a66f9669 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -1929,6 +1929,7 @@ int dso__load(struct dso *dso, struct map *map)
> >  				symsrc__destroy(syms_ss);
> >  				syms_ss = NULL;
> >  			}
> > +			dso__set_symtab_type(dso, symtab_type);
> >  			ret = 1;
> >  			break;
> >  		}
> 
> [Severity: High]
> When dso__load_bfd_symbols() succeeds and sets ret = 1, this explicit
> destruction of syms_ss does not remove the struct from the ss_ array because
> ss_pos remains unmodified.
> 
> Does this lead to a double-free later in the cleanup loop?
> 
> tools/perf/util/symbol.c:dso__load() {
>     ...
> 	for (; ss_pos > 0; ss_pos--)
> 		symsrc__destroy(&ss_[ss_pos - 1]);
>     ...
> }
> 
> Additionally, since runtime_ss is not cleared here, can execution incorrectly
> fall through to dso__load_sym() and overwrite the successful ret = 1 value
> from libbfd?

I don't expect it sets runtime_ss, but I'll make sure it's cleared.

Thanks,
Namhyung

> 
> tools/perf/util/symbol.c:dso__load() {
>     ...
> 	if (runtime_ss && !syms_ss) {
> 		syms_ss = runtime_ss;
> 	}
> 
> 	/* We'll have to hope for the best */
> 	if (!runtime_ss && syms_ss)
> 		runtime_ss = syms_ss;
> 
> 	if (syms_ss)
> 		ret = dso__load_sym(dso, map, syms_ss, runtime_ss, kmod);
>     ...
> }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261010182439.9732-1-namhyung@kernel.org?part=3
