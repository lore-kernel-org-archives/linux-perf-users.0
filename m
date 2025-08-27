Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B275521FF55;
	Wed, 27 Aug 2025 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315694; cv=none; b=is3CilPsb1IJNIGx75InV3WF8RGsqQ3kCOf5B5BQFfqr+pLwiAl2L3/Rt8Yu6EFzTZIlOTjqgEV9t1anaQWcmUwhV+geVt/CCWVFRplpuN5NOY0rUWrwIwrpjX2nta96BzmSfMW2VClnyjoLriL36queHktVW5Vj/x5yl6vmrys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315694; c=relaxed/simple;
	bh=Y+WRbM0Av3TYxIZ0+HcIYsryUVDHh/DopvC0d2C5448=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8Suv9a1YxF8yVe+sOgTpIZjdS2+OESdl5kYcBCF0uOEn9P8VSpVh7R3W+uxoBs5R09CzCNN4HCUozHtBQRG8OnAOi1SOqd2D63keZUSTL0LA2mI8FFCrZUUQyJmBc0TjUI+rmb3TIncE6+PwY2fxw4Cl90osC2R56bSRQIiwoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lG1FAEOT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lG1FAEOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9907C4CEEB;
	Wed, 27 Aug 2025 17:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756315694;
	bh=Y+WRbM0Av3TYxIZ0+HcIYsryUVDHh/DopvC0d2C5448=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lG1FAEOTYoYLojqKFHHz395F+UUmtL5cHE5X8Z4OFzNR26pWRILL8Gk7oMudvwEqm
	 WDLDZuHgnrUosXlmhS8Wo+f/d5OtYeGwYlgHLPc6ssMNM4fojaNKuRgz1ZZKlf4VA2
	 r8gvFsczsDNUVe6IThHZXqnMzsf9wcLnfjZb+Oo0KtQLxIZHixXJKSORANrq6semJL
	 Qus9X2Dw3ieJ25im3k/YejPs/hSGHs/8134DAFw5zq+2/qW0uPJs1o4yrz5rEncKpL
	 1M3dMdb85zggOkrS76RvvMyTh+3kOIgIMQkyfPR05acDEHYMyyadMKptw1IeNsgNk5
	 jlk5ZR4hy2rjg==
Date: Wed, 27 Aug 2025 10:28:12 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/11] tools headers: Sync arm64 headers with the kernel
 source
Message-ID: <aK9ALIkD95ignpzq@google.com>
References: <20250825215904.2594216-1-namhyung@kernel.org>
 <20250825215904.2594216-6-namhyung@kernel.org>
 <20250827081252.GD745921@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827081252.GD745921@e132581.arm.com>

Hi Leo,

On Wed, Aug 27, 2025 at 09:12:52AM +0100, Leo Yan wrote:
> On Mon, Aug 25, 2025 at 02:58:57PM -0700, Namhyung Kim wrote:
> 
> [...]
> 
> > But the following two changes cannot be applied since they introduced
> > new build errors in util/arm-spe.c.  So it still has the warning after
> > this change.
> > 
> >   c8c2647e69bedf80 arm64: Make  _midr_in_range_list() an exported function
> >   e3121298c7fcaf48 arm64: Modify _midr_range() functions to read MIDR/REVIDR internally
> 
> Hi Namhyung,
> 
> Thanks for working on this. It is on our todo list for automatic
> generating MIDR. Sorry for any troubling during the syncing.

No worries, and thanks for your review.  I'm glad you noticed the issue
and have it in you TODO list. :)

> 
> Just a minor comment below.
> 
> [...]
> 
> > +struct target_impl_cpu {
> > +	u64 midr;
> > +	u64 revidr;
> > +	u64 aidr;
> > +};
> > +
> > +bool cpu_errata_set_target_impl(u64 num, void *impl_cpus);
> > +
> 
> Currently, no one uses this API. It seems to me that we don't need to
> sync this code chunk.

Ok, but it'd be easier for me just to have the change anyway.

> 
> Otherwise, other changes LGTM.

Thanks,
Namhyung

