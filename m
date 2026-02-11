Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B706D2DCBE3;
	Wed, 11 Feb 2026 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770812763; cv=none; b=SdiKgNon6vEl84uKF6pOIedOHnySl5DBXo/O40v39IefpPpmHBhnJfUNruPCsJtxck8mHQfvt3FaAQj87YU+McTlsknb5x+3RojmHHApaQLhrSoZXFvykyfzFp2ySuYaICRKRROHndCpxpGWCVuiotjXnIN+58fe7CNlOuof/mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770812763; c=relaxed/simple;
	bh=NvjKY1VCBLxpZ8/zT5bik3O1jlOBqlflzAF0MPkTscE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIg7cxBb3smZzDqGMpwK8dIQyb3A/JzrH1RxwZK8OJwokFnjFMHxNFJRwNwJ0fvRdZIiHwbdQ8R4iij3uPHST7CTnnZ6snEv2b/gD8kx4wFUmN0UjcjjuQz+NeqB0+6eKUpKDTV7NW746j458ZRxrnX/bzcm8EQbWTR7TFnJqus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACaP5toO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACaP5toO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0148C4CEF7;
	Wed, 11 Feb 2026 12:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770812763;
	bh=NvjKY1VCBLxpZ8/zT5bik3O1jlOBqlflzAF0MPkTscE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ACaP5toOTDXFkKeHDl9JTf/VEzjdS4aRf9MHgPUZoSDZ+tD/pgX5c3dUyBmCksFHd
	 mrVsCw1DKr1Ls56+BzZmL6qwabaPnAbvf2tK79EoFZrRqa8Kt9KLuxTzt86cJRqV4M
	 E3Nh6uY62A+gWaBnyzhC3dO4zg6Veue18e5DFDDPmHispwSZ365EEEqXqWiJTPRgRW
	 3rx1Z46XM7pjp10JO7uuNoZO32IDxod7z0SyosqLnkYZDYtoJbgmUmjJ9/71U0Y3an
	 3DX+DgEuIxisimTTfLjYOJt6NbgxTzxKvOwUMCwg+aN6OGcJGo1M8fQXTg3NlC6J/k
	 fu62iZ/IYkjrQ==
Date: Wed, 11 Feb 2026 09:25:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Dmitrii Dolgov <9erthalion6@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf test code_with_type.sh: Skip test if rust
 wasn't available at build time
Message-ID: <aYx1V443vpL8o7Pv@x1>
References: <aYor-0BmwjNvKs1N@x1>
 <aYqIs-eJeyItVUOm@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYqIs-eJeyItVUOm@google.com>

On Mon, Feb 09, 2026 at 05:24:03PM -0800, Namhyung Kim wrote:
> On Mon, Feb 09, 2026 at 03:48:27PM -0300, Arnaldo Carvalho de Melo wrote:
> >   $ perf test 'perf data type profiling tests'
> >    83: perf data type profiling tests                         : Skip
> >   $ perf test -vv 'perf data type profiling tests'
> >    83: perf data type profiling tests:
> >   --- start ---
> >   test child forked, pid 977213
> >   Skip: code_with_type workload not built in 'perf test'
> >   ---- end(-2) ----
> >    83: perf data type profiling tests                         : Skip
> >   $
> > 
> > Cc: Dmitrii Dolgov <9erthalion6@gmail.com>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/tests/shell/data_type_profiling.sh | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/tools/perf/tests/shell/data_type_profiling.sh b/tools/perf/tests/shell/data_type_profiling.sh
> > index a230f5d4c42c3e6a..3ef72a10850d0734 100755
> > --- a/tools/perf/tests/shell/data_type_profiling.sh
> > +++ b/tools/perf/tests/shell/data_type_profiling.sh
> > @@ -4,6 +4,11 @@
> >  
> >  set -e
> >  
> > +if ! perf test --list-workloads | grep -qw code_with_type ; then
> 
> It could be 'perf check feature -q rust'.

Right, better, more compact and using something that was designed for
that...
 
> But IIUC this test also covers C code.  We may want to skip Rust parts
> only.

I'll cook up a patch implementing your suggestions.

- Arnaldo

> Thanks,
> Namhyung
> 
> 
> > +	echo "Skip: code_with_type workload not built in 'perf test'"
> > +	exit 2
> > +fi
> > +
> >  # The logic below follows the same line as the annotate test, but looks for a
> >  # data type profiling manifestation
> >  
> > -- 
> > 2.53.0
> > 
