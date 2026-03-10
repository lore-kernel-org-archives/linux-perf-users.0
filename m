Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE84438DF9;
	Tue, 10 Mar 2026 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773102545; cv=none; b=mXH88nlureTjF8NHb9xQLCwyX40vGkdNVaXzFJslJr88kqvpEvUv3pT7dXIuMGqooirQaXRqoDQzovw5nOx/L5GNIF8m7gX/VLPh311TMAoiGuaSbN8vVm7XwMAjAjYanKDpMRD3H4f/vnkKSvXKcC1mxU8uWTQPWhUkRzRgVho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773102545; c=relaxed/simple;
	bh=5v5aqsRQbuXJkdJ0cS/apSm8NR87a7mqgCSleuHEH70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnzebCa05DKRPJMCu1WRchdmMuGkmKWT8QwIOGF14Y9/4ixfYUvEZDVm+tG8hvocnfeh/C0leclz/AP7WmFrOCBTR2K8uNABBik7M9qxPiEpvWraUEkdcYJ6Jta3E8OLRB8S1zk1uG32r9Dy3yx0VTrLIRpqv5ddKemxGjhd3tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnZ6KDOV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnZ6KDOV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45D6C4CEF7;
	Tue, 10 Mar 2026 00:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773102545;
	bh=5v5aqsRQbuXJkdJ0cS/apSm8NR87a7mqgCSleuHEH70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EnZ6KDOVFYdGlzEVfasoZtYliGygeseY/2ncsX/qChAsYbaoNOr3CrwxQrj4UOajR
	 IbQqYPJMPqoaO5X7Qc4yAElalUb4ZHPBTdIhTVx9L3cBs5cNHDr391T7GzZzv14cI1
	 72fexNMmgfljlOC2z+o1/xC4n3bylMk0B2bmAGit5BaGNCm6qHsTOK5XvxbQ8tWZ6L
	 U+1SvRRTLO7NmZOPfAH/Hpx0HjtQv+Aw8K2eU7VWiq15vEMuZFJomcMLxRuRMZ82V0
	 FAy6HgDfyPZrUOq/XKTjxKEXTXPZ1f6JDW/FwkhS4hFSlIndlSEboDk1Q89mwETSv2
	 CzIzOYwTXDD4A==
Date: Mon, 9 Mar 2026 17:29:03 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: duchangbin <changbin.du@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] perf: Add layout support for --symfs option
Message-ID: <aa9lz9M9zTnXnAku@google.com>
References: <20260301192455.1053900-1-changbin.du@huawei.com>
 <aaknIOp-PrDNCf-L@z2>
 <dd08137f2d2e4d39a37d4c50552f8a86@huawei.com>
 <2f617208b9fd42b682380a3306c2603b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f617208b9fd42b682380a3306c2603b@huawei.com>

On Mon, Mar 09, 2026 at 08:47:59AM +0000, duchangbin wrote:
> On Thu, Mar 05, 2026 at 05:02:17PM +0800, duchangbin wrote:
> > On Wed, Mar 04, 2026 at 10:48:00PM -0800, Namhyung Kim wrote:
> > > Hello,
> > > 
> > > > @@ -2491,16 +2492,36 @@ int symbol__config_symfs(const struct option *opt __maybe_unused,
> > > >  			 const char *dir, int unset __maybe_unused)
> > > >  {
> > > >  	char *bf = NULL;
> > > > +	char *layout_str;
> > > >  	int ret;
> > > >  
> > > > -	symbol_conf.symfs = strdup(dir);
> > > > -	if (symbol_conf.symfs == NULL)
> > > > -		return -ENOMEM;
> > > > +	layout_str = strrchr(dir, ',');
> > > > +	if (layout_str &&
> > > > +	    (!strcmp(layout_str + 1, "flat") || !strcmp(layout_str + 1, "hierarchy"))) {
> > > 
> > > I think it's better to fail with a message if unknown layout is given.
> > >
> > Agreed. The current issue is that if we use ',' as the delimiter (to maintain a
> > consistent style with other options), and the path itself contains a comma, it
> > would result in the following ambiguity:
> >  - /path,flat → symfs=/path, layout=flat
> >  - /path,hierarchy → symfs=/path, layout=hierarchy
> >  - /some,path/ → symfs=/some, layout=path/
> > 
> > Do you have better suggestions? Using a different delimiter (e.g., : or ;)?
> > 
> Finally, I've decided to go with the simplest implementation. The result is: if
> the path contains a comma, the layout must be specified, otherwise an error will
> be raised (the part after the comma would be incorrectly recognized as the
> layout option).
> 
> - /path → symfs=/path, layout=hierarchy
> - /path,flat → symfs=/path, layout=flat
> - /some,path/ → error
> - /some,path/,flat → symfs=/some,path/, layout=flat

LGTM.

Thanks,
Namhyung

