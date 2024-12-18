Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70131A23A4;
	Wed, 18 Dec 2024 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734547633; cv=none; b=ZMrHnwH50sQUPXXYb0YC9e4dyvWa7hTR5d8/L2Kb4hgpXPAOPQkEz6qZE/eRCLd5kGIFM96N68sApZtvkGboE9+fxzgPXfZmvKPU+q6o/KgsCVorfObM51pEFiD1htJrmauAD8OxgbIVjXSS8FOgYk2KERm3Q8xlDcD9JmJPiRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734547633; c=relaxed/simple;
	bh=HKJJ0PUNZM9mXx3HL+CXt0wXU93Wqogb8PZNcULBxC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlVz+9ukcEwMZVt4ibzGW7Lpwdw4g/0YFf73Ix4zvh/qjnVv8yfU0F4xdop0RhmHMOZIQHJFjb6oPhWlqOt3P6PYu31iQuekxFchleUfB/dufzuWjXb8YSFcHMfukGvIxjJlzU0HZMp+Hu0k0GDnM3dAnN5fQuNWrLXdBE5T78c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsGRbzPb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsGRbzPb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22EAC4CECD;
	Wed, 18 Dec 2024 18:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734547633;
	bh=HKJJ0PUNZM9mXx3HL+CXt0wXU93Wqogb8PZNcULBxC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VsGRbzPb5w6ual3Xm6QYlIAnhb9Dza0ePbLYs0IaEIG9yFHFOAOciVz6GD5yzZKkb
	 THIq2MycZD0beksrsxXGqt5jV0J0x4562GsnewZQsK+GlU0W7FOM9cOq8sluoI4wuH
	 UU7Y6rKUFp/RaUlFNaM5moJczqlbs5L5j+nlHdDXmoQLnH1rB8RVqWKj7T7oVXJA5s
	 WAxxxEl8ln4h4DEQ20uRfoHJpQpCcPrVNoX9FZO2MZxWV0dColAcU8KrO3zdqhH7vd
	 0e7EunsElkgzIK8cNU2sEVkPI3CI/4NzJ2adWUIe2OdVo/qmk5KNfqoYna5PoXXZzR
	 JT2/yDKX2WM5A==
Date: Wed, 18 Dec 2024 15:47:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V15 0/7] perf/core: Add ability for an event to "pause"
 or "resume" AUX area tracing
Message-ID: <Z2MYrvKoezFTTanY@x1>
References: <20241114101711.34987-1-adrian.hunter@intel.com>
 <9bb112f8-0af1-4517-a4b8-bd2edacce07c@intel.com>
 <Z0YChjympWOZeu1e@x1>
 <bb2821b7-4440-4ecc-925e-4d78ba60fef8@intel.com>
 <Z0Yb3r6GjUZck77r@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0Yb3r6GjUZck77r@x1>

On Tue, Nov 26, 2024 at 04:05:02PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Nov 26, 2024 at 07:56:12PM +0200, Adrian Hunter wrote:
> > On 26/11/24 19:16, Arnaldo Carvalho de Melo wrote:
> > > On Tue, Nov 26, 2024 at 02:59:02PM +0200, Adrian Hunter wrote:
> > >> On 14/11/24 12:17, Adrian Hunter wrote:
> > >>> Note for V15:
> > >>> 	Same as V14 but without kernel patches because they have been
> > >>> 	applied, and updated "missing_features" patch for the new way
> > >>> 	of detecting missing features.
> 
> > >> Still apply
>  
> > > So the kernel part is in, I'll go over this after getting a machine with
> > > a kernel with those features so that I can test it all together.
>  
> > To be clear, this is just a software feature, so any machine
> > with Intel PT will do. Kernel can be from mainline tree or tip.
> 
> Thanks for the clarification, the way I wrote it was ambiguous, maybe
> somebody would think I needed some specific machine with some
> special/new hardware feature (some new Intel PT feature, that is), but I
> understood that this is purely a software/kernel feature, needing only a
> machine with "regular" Intel PT.

Thanks, applied to perf-tools-next,

- Arnaldo
