Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EE674E09;
	Sun, 20 Oct 2024 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729411762; cv=none; b=IUwJICDFYrVh+sF7MZH2TKb/eZUewmcyGuM8+/eso05sWMZYONCPNPVthoAdaqnEwflykNfjyIh0uNxzQuB3/92RcIbval5St5TU8wlMtgFofjkxCyC1SkmXsAWU/pGKyYNnxFY1Lekv0XKmFoxEaetaeJ4C2E8FpdR3bvHJSy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729411762; c=relaxed/simple;
	bh=Py80XVglq1WbNOTFGcMrtwmae8Aqs77dotNfxGrgoJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaQzHhcjpUx3BgZu1hAnj7ZzhdOT4SzM0crb9rcyG4Y1T06gyqmlemRFODukV93k0rVxdQPFBfBbmtmcpUuES0F1ADx5KE+vI8weJZoMaFXZ4mkctaxy/t0MPYY0EfEKSaVY/qft5VTCoJsCweMPcv0OAXHjDpeLHRLoeHDwoHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9vcpbYx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9vcpbYx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2005C4CEC6;
	Sun, 20 Oct 2024 08:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729411761;
	bh=Py80XVglq1WbNOTFGcMrtwmae8Aqs77dotNfxGrgoJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V9vcpbYxh7WIXInVLSSqiGPCMFkSpoT9Gk5YE6iHX351DoBXr6ecWMVOUFaXcrBD8
	 AoRJWBfEjQOZ4GjlY3dSUVzN+9JU+RLWezBY/ZvZb/dD4ZSTZDdVGB4VuhepaOULvo
	 LEeN+SD7mwlWKDrlvHFMKWzhFH/PvZq6jYVhEslbp2tbhothBFtqobjp1chkELcKgE
	 2JL/ujUDCRHb+0ueOTS2vIakqRRkaSV1dl9gQyarDX0pVijS22k0B6INK0ePKpL9ER
	 jsQVdqyxi4Uuz3nGSNWYeKM+9AIHDriizf5LUjUOSWlB6nHeA/eJnQF11Y+57gpVA9
	 GNUX0UokPIQtw==
Date: Sun, 20 Oct 2024 01:09:19 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>
Subject: Re: [PATCH v2 02/11] unwind/x86: Add HAVE_USER_UNWIND
Message-ID: <20241020080919.v4zfqwgpjxhluxaq@treble>
References: <cover.1726268190.git.jpoimboe@kernel.org>
 <82ef19a767cb75e76a985ecc0d47a39400b4fdf5.1726268190.git.jpoimboe@kernel.org>
 <20240916114605.GA4723@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240916114605.GA4723@noisy.programming.kicks-ass.net>

On Mon, Sep 16, 2024 at 01:46:05PM +0200, Peter Zijlstra wrote:
> > +#define ARCH_INIT_USER_FP_FRAME							\
> > +	.ra_off		= (s32)sizeof(long) * -1,				\
> > +	.cfa_off	= (s32)sizeof(long) * 2,				\
> > +	.fp_off		= (s32)sizeof(long) * -2,				\
> > +	.use_fp		= true,
> 
> What about compat crap?

Sframe doesn't support x86 compat so I guess we don't need to worry
about that at least for now.

-- 
Josh
