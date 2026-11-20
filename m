Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795152830;
	b=H5ncAR+1aSvEd3qI76Km/aarNM5wIa1p4lC2EJInK1FvAbRAywEyWW/wBAJgPZkQYOqn
	 lsqaDiM+B2xXYBm3a0rlOEHzgEdvaKavthTdaarXeeXWdsT4q75/UfRPT26AfcLhtyz67
	 O/xrYKIcSdJPRSi4ZkuRu+bnl8l5Y8KEnNqV3ENNBekNC/0BdinKtUV86yFQwORv44KoM
	 DDIwbHDUqQ9wpuhy4WKgfOphPNRMpQsBe5nfvibvLlQQ/W+oFvH8YEu5iTp84xtE0KUBr
	 tYb894TRqLxxh/ZRGovVvgmAGcG6hGDVQUCtj0G9pkYUvj5uSUcouHSQybxl5UQMVzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795152830;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NLrjRZFiatRFJw6E5ayxBxyGTvhj7Htf/txtOkoq6d8=;
	b=JoBnT5RZc4Xw5konjSLJPCwbqmx7I4B7QtTeoNqHzfwZyCfeJpMEJsIjvqObuHtnAnGl
	 OvkqpLU1LEk5Spnvrr6atFEoz2/7L1CSAsc/gbH+wFQTLkxfkZKvt0ANB8X7ohU0Ff6qF
	 O4CfLmcNewzrQtzmRrYwGfQSD2ZixsnkuxugWtzKDgfuQm1Uq7Gvz5rp47t4aBzcoV/Ja
	 26saoZ2fkPesnFUqc5oOX7zs73mESBrfr6QDimVUXRsNPSWLc9HMvgIMPZYP04+UaeCiv
	 HHehxmw5j7jJJNwdABXbaxXfo7wAK9liH0CPxI/QSbUD/uAlXx+ILq42ZYOxcptFFXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3U87XZ1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC968606A320;
	Fri, 20 Nov 2026 05:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3U87XZ1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67EA1F000CA;
	Fri, 20 Nov 2026 05:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795152830;
	bh=NLrjRZFiatRFJw6E5ayxBxyGTvhj7Htf/txtOkoq6d8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S3U87XZ1xO4brFPEo+Mj6QDGEzt165nI+u6cSkoQccbZd2SvbwuazUjsS33M/8STJ
	 D1dOX1nfL81c+Fc1eTe2hGysFiN2a+GpAFThI9ESIEGCPSGuya5YTwUngbWGgVtvmI
	 Fy2BfSZG0X+gq0UoeBuFn6vza3rXC8HKcizeTPmNBMIrT+xh8ExqaBpz6BxT2Nl7lk
	 vfjrA95p8xCmVh92MrwlVw67CB9jhSZV8z0xx+hkUERUkq1ttOgWVY3ds60Qd+Mi6a
	 kuXNhISKw5U1Y2M/B+p2LvXp8c83KQaH977xNNlBpmvCmlD3XkwUJcb1FaC0EzbWJ9
	 gD5RBL6toYAhA==
Date: Thu, 19 Nov 2026 21:33:48 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, bvanassche@acm.org,
	elver@google.com, james.clark@linaro.org, jolsa@kernel.org,
	justinstitt@google.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev,
	mingo@redhat.com, morbo@google.com, nathan@kernel.org,
	ndesaulniers@google.com, peterz@infradead.org
Subject: Re: [PATCH v13 19/21] perf maps: Fix lock inversion in
 maps__load_first()
Message-ID: <av_bvJpYwwMWNfDt@google.com>
References: <20261113164152.2095566-1-irogers@google.com>
 <20261113164152.2095566-20-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261113164152.2095566-20-irogers@google.com>

On Fri, Nov 13, 2026 at 08:41:50AM -0800, Ian Rogers wrote:
> In maps__load_first(), take a reference to the first map and drop
> maps__lock(maps) before calling map__load() to avoid a read-to-write
> self-deadlock when loading kernel maps inserts extra trampoline maps.

It seems this function is not used anymore.

Thanks,
Namhyung

> 
> Fixes: e77b0236cd0c ("perf maps: Add maps__load_first()")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/maps.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index f808df2fe77b..7ca33e5218e7 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -1459,10 +1459,15 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
>  
>  void maps__load_first(struct maps *maps)
>  {
> -	down_read(maps__lock(maps));
> +	struct map *first = NULL;
>  
> +	down_read(maps__lock(maps));
>  	if (maps__nr_maps(maps) > 0)
> -		map__load(maps__maps_by_address(maps)[0]);
> -
> +		first = map__get(maps__maps_by_address(maps)[0]);
>  	up_read(maps__lock(maps));
> +
> +	if (first) {
> +		map__load(first);
> +		map__put(first);
> +	}
>  }
> -- 
> 2.56.1.703.gf848ed807c-goog
> 
