Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4D42C1586;
	Sat, 10 Oct 2026 05:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791610948; cv=none; b=Rxc7q92e1NXnsXZvD1vVUsrMOaOfCfI5d2PYVQHWwia8IbqqrmPSm/au1LbAtV8XYTOp0uytUpn61pzS0zh1Wr/d9tLVxMibHsGx6cnIsvD9fyXlkPjNP97qxcU0+qLPVQdcvMioiJmcRE5EzbIcUVZKwpdqgv8eLFhj91MTD1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791610948; c=relaxed/simple;
	bh=Q53i7AsSHWDUz8FpXh5denI5g0B/EEdnqWqo3mxAuVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD4RSa2RVSw7SyeGDgABtJXhE66cwzZVnD69rmwRUQV8wwVJer19d8/mKOx+iloQ1h0tg2MiLUpZ5E1Qgfqn23rxPzU76L6Q4SqiobJZCtcJAmzr1Mm0fCEa67WdeCjFfe7Sb/jootAFS7f55AbpmOivmUh7aycP0Up8njbqrZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikHdtjXy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikHdtjXy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97E91F000FF;
	Sat, 10 Oct 2026 05:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791610947;
	bh=UvIQUqIABxfiqjX/ryXuvfyQbuwbwPaXEWeYrdQEte0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ikHdtjXyomwy5CYonTclDCk1QKtAJQX8U/RrCv4meelGChgmtr7+mP9Vi2kPDuTvM
	 aozjvl5WGyvtqPtR8y8c/Vgr7PfY8Tv+zn75Xb99vYTZeG7eNYxV5/xSkNXcgI1JOm
	 BMrD3g+5rwwG1MYvVRpUNQ/fP+PMR3OeZOjn3jZsDLYBBd0KWEfSunKqk50Z2L3CGx
	 NYYDcXd40t6uPAqMVgSgk2M+OOIjYPd+0dtVPHjBbOhtRJrl/y0tQs8xY+0tud2VeV
	 5swokqUQYPk+nfLo18Ad/ZDP+e0YoMVD0WLTQMJ3D030dUrAnyYesmb987jSTH9ooq
	 p+26hzu+9LNTg==
Date: Fri, 9 Oct 2026 22:42:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 04/10] perf symbol: Set binary/symtab type for split
 kallsyms
Message-ID: <asnQQdxAoS2SqvC6@z2>
References: <20261006234315.920817-1-namhyung@kernel.org>
 <20261006234315.920817-5-namhyung@kernel.org>
 <sashiko-outbox-162542@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-162542@kernel.org>

On Tue, Oct 06, 2026 at 11:58:36PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf: Incorrect binary_type copied to split kallsyms DSOs
> --
> 
> commit caef899ba7808ad89c1adfe535b155dac7c2ebd1
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf symbol: Set binary/symtab type for split kallsyms
> 
> When it creates new DSOs for split kallsyms, set the binary and symtab
> type to KALLSYMS properly.
> 
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index cf099cbd29f26..fc6e4dff282bc 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -1099,6 +1099,8 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
> >  				return -1;
> >  
> >  			dso__set_kernel(ndso, dso__kernel(dso));
> > +			dso__set_binary_type(ndso, dso__binary_type(dso));
> > +			dso__set_symtab_type(ndso, dso__symtab_type(dso));
> 
> [Severity: Medium]
> Are we copying an outdated binary_type into the new split DSOs here?
> 
> Looking at the execution flow, maps__split_kallsyms() is called via
> dso__load_kallsyms() from within dso__load_kernel_sym():
> 
> dso__load_kernel_sym() {
> 	...
> do_kallsyms:
> 	err = dso__load_kallsyms(dso, kallsyms_filename, map);
> 	...
> 	if (err > 0 && !dso__is_kcore(dso)) {
> 		...
> 		dso__set_binary_type(dso, DSO_BINARY_TYPE__KALLSYMS);
> 	...
> }
> 
> Because dso__load_kallsyms() executes before dso__load_kernel_sym() updates
> the parent dso's binary_type to DSO_BINARY_TYPE__KALLSYMS, the value returned
> by dso__binary_type(dso) during the split operation may still be the old
> stale value.
> 
> Could this prevent the split kallsyms DSOs from receiving the correct
> binary and symtab types?

Good point, I'll just set it to DSO_BINARY_TYPE__KALLSYMS then.

Thanks,
Namhyung

> 
> >  			dso__set_loaded(ndso);
> >  
> >  			curr_map = map__new2(pos->start, ndso);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261006234315.920817-1-namhyung@kernel.org?part=4
