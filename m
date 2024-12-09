Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B82F1798F;
	Mon,  9 Dec 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756523; cv=none; b=YM0KMX7GkO+gZU7FCB2w272SaTNTUdTNU7lr1WjKuCTYYA5QWsTs4hht930GihDvhj49HUtBXxjZtAPewUl8EoMyNYChG1jfePPV2v34S13B7b5N8SNHu8jLoaarGsZieoRgG3wyA8W9vfc3ptzZmluRYdNqRgaKy098YFbQbP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756523; c=relaxed/simple;
	bh=uA1oiVUe5MMOIJf/R3qjXVJkzY8ICqjBrUSqH/G2Fpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dxh9rHlNNHejMNMJ3vGw00u5UO2WJ5GmgCWGGP/clgJqGsRa+e835ykncTOGZjsj9D/YHU3RRc6LoVp19bYrTo9Tq+CUnfyOO9IVr9fD9QfuOctGAaZxVEIcQcBY9bzPha93ORNMjLLqE3oK4O2R0zl3APPv7GhqaB0+rekNCzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEnX4Hpx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEnX4Hpx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5C6C4CEE0;
	Mon,  9 Dec 2024 15:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733756522;
	bh=uA1oiVUe5MMOIJf/R3qjXVJkzY8ICqjBrUSqH/G2Fpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SEnX4HpxYM1HzmBiKr6dXeYvxWULGKS7AbAVna12qeddo/ERcaiut4pZY5ynlwD0n
	 aOCqYjl64B7feahvuWpZxwi2GVQUWTfJx+BiiTKnzh9Bytm/Q/lUhi5WtC15Zqeejr
	 fjY+zRSe5ZX6XTP3IPYFis7sNkdZhH1MMXXIHAY/9RWrzJc95lmglvGZwZFj2/Lwpi
	 LG7b4gWMjPOAtfXa2WdZA1r9JKN2BJtO4Ksfk3e9v97mtfU2psD5kbR0T49hQrnnD0
	 PoUTIUFq5UWbGiCXIEHSpLAkBpT9COACk/BlORt0YRqhtpfHenoQxCeiqrVFqdkbgE
	 mDPWADQRr6V3Q==
Date: Mon, 9 Dec 2024 12:02:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Leo Yan <leo.yan@arm.com>, Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] perf cpumap: Add checking for reference counter
Message-ID: <Z1cGaEbmDLUDpy1S@x1>
References: <20241107125308.41226-1-leo.yan@arm.com>
 <20241107125308.41226-4-leo.yan@arm.com>
 <a584b2da-7463-41c4-885c-1ff13e69b08a@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a584b2da-7463-41c4-885c-1ff13e69b08a@intel.com>

On Fri, Nov 15, 2024 at 10:49:01AM +0200, Adrian Hunter wrote:
> On 7/11/24 14:53, Leo Yan wrote:
> > For the CPU map merging test, add an extra check for the reference
> > counter before releasing the last CPU map.
> > 
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied the series.

- Arnaldo
 
> > ---
> >  tools/perf/tests/cpumap.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
> > index f8187a801b8e..5ed7ff072ea3 100644
> > --- a/tools/perf/tests/cpumap.c
> > +++ b/tools/perf/tests/cpumap.c
> > @@ -167,6 +167,15 @@ static int __test__cpu_map_merge(const char *lhs, const char *rhs, int nr, const
> >  	cpu_map__snprint(a, buf, sizeof(buf));
> >  	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, expected));
> >  	perf_cpu_map__put(b);
> > +
> > +	/*
> > +	 * If 'b' is a superset of 'a', 'a' points to the same map with the
> > +	 * map 'b'. In this case, the owner 'b' has released the resource above
> > +	 * but 'a' still keeps the ownership, the reference counter should be 1.
> > +	 */
> > +	TEST_ASSERT_VAL("unexpected refcnt: bad result",
> > +			refcount_read(perf_cpu_map__refcnt(a)) == 1);
> > +
> >  	perf_cpu_map__put(a);
> >  	return 0;
> >  }
