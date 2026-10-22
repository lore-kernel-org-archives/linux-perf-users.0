Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792633222;
	b=IATYxUfFPSF/vPU6oE/OxZ/kzb4+d9AtkhPvs5kr4dM182Pq127piL1QTk0hur30cCaT
	 IhP6xZ+EAj6iNm4tJDbOrZGevtcssRLtV+I5w8/doatvMUGDcG1Ti/DLRqPTLf4bTVYdC
	 7Qszbbkd/rgJE1VAEq0CZdtyflhfW7EPCMdnGgRYcpfTtOt1oHygwdFk0Dtn0nAvYF5NL
	 KlbfwU2DToRQABy6m/JnUju+ILMWDTEGMDMxRnF1bXv5qKcmMsUNV12govisWWkBfN1is
	 fsTWLXz99Y1yyVMNs7zkN7O3dKq7bChCqVw8Rg6iVFFj4nRXzEiaxDJjXxXq+IBmZyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792633222;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YNGTJfIRAnVRaqsXSD0RrWAO24wZ7eJMSOuVIY6yKoY=;
	b=5fEaOJiqmxqEZaSUxS+IW1P8SpJJPJQNWVXY46iOjIfklh2cC3VoknyscOOTS5jTbNHk
	 ghI4P5Qy4caM4Ejc1zyrqY6vtZePiffRR5k0XG+zFW21bb9KRktvBZ8g0sXELtr316en5
	 icklG2mQZ04m1EDRJnSNBVKkc/YwLfObC3QlwOx4YmnM2A/9cbKmyQG/S4OQkw3QyUHto
	 Bov98Uk+dMNCq71kJxj6pQ2neez7vvVY++T2SFBVYlQIM1pOlDB/mnAv3EWx1NC9yVMFJ
	 Ba5rYSp2kt6JqAklajoYfO9/hQU9peHLhhdewWFDRqKamzgnBFROamh371wRoq18now==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xtyl1WqO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5008606A319;
	Thu, 22 Oct 2026 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xtyl1WqO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77741F000C1;
	Thu, 22 Oct 2026 01:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792633221;
	bh=YNGTJfIRAnVRaqsXSD0RrWAO24wZ7eJMSOuVIY6yKoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xtyl1WqOVrfK7hNOdX7K37foVg2cPFIdeFsegeyte7BJydwjkHwoFzcN4ffTXtIMs
	 IFlZrX7O6o0v8Xi45+b1sIFZLgno5qzY4h8m/8fEaYR88rix+8DBaF/nST3cicRkVM
	 KQs9YK4GYPdMFFGe+C+ayvt2yeWysJSChClQ9OHOoJbWB1+TnpJ4GPwPjFkQJnrgix
	 gMYpzGS0pi8uOpXGmvpfp0xQRlmXGhE8aa2HTv7OFLySS40v2GwLXE7p0i5RE8zwpX
	 E+l5R4/GK6tDAwVXxMg3CWCABmdLs/Ftq+4biYONkhNGwwA5VE2eA5RPnE9z3KKNGo
	 3MuIgb+Ybup1w==
Date: Wed, 21 Oct 2026 22:40:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf build: Add MINIMAL=1 to build without optional
 features
Message-ID: <atlpgvF_WELAFSuD@x2>
References: <20261018135321.3986899-1-sashal@kernel.org>
 <atlICVt3ItifkPZb@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atlICVt3ItifkPZb@google.com>

On Wed, Oct 21, 2026 at 04:17:29PM -0700, Namhyung Kim wrote:
> On Sun, Oct 18, 2026 at 09:53:21AM -0400, Sasha Levin wrote:
> > Turning off every optional feature takes a long list of NO_* variables,
> > and the list has to follow features as they are added and renamed. The
> > one in tests/make for make_minimal has fallen behind: it leaves
> > libtraceevent, jevents, slang, AIO, LZMA, zlib, libLLVM and Rust to be
> > detected, so a make_minimal build still needs libtraceevent and python.
> > 
> > Add MINIMAL=1, which turns off every optional feature, the BPF
> > skeletons, and the shellcheck, mypy and pylint runs. perf then builds,
> > natively or cross, with no library beyond the C library and without
> > python, pkg-config, clang or rustc, and the result does not depend on
> > what is installed on the build machine.
> > 
> > A MINIMAL=1 build also leaves out the notices that post unwind and
> > python support are disabled, which it asked for, and the one about the
> > pkg-config search path for cross builds, as pkg-config is not needed
> > then.
> > 
> > It is handled in Makefile.perf rather than Makefile.config, as
> > Makefile.config is included after the pkg-config, shellcheck, mypy and
> > pylint setup.
> > 
> > Use it for make_minimal in tests/make.
> > 
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Link: https://lore.kernel.org/r/CAP-5=fWFY-tpJz2vcBZvurwdZY5gwd8cuTemE9q1rtZ0Vi0dng@mail.gmail.com
> > Assisted-by: LLM
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Not tested but:

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
