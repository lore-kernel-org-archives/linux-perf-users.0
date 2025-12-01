Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBF133507A;
	Mon,  1 Dec 2025 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609263; cv=none; b=ojal6eq3c8drlZ7GdQ+J5ou8RHi2IORrM9kO72iWM2+KktDE0AWG+C+M8PuzSOQ6PkTvizy24wGJsvqk/fvcAPVCr3OLGAJkMu2t6FLGVtyrTkDwqTAh04d1KdHPfzQiASdyOVYrSJkRzKHahIbK9O9gnLUaj3H+4Rp0sgHLV1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609263; c=relaxed/simple;
	bh=xr+scbNuDcdutR3BSvDQTMhN8ZBljtskf3ZPHRiXMbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iv7auoyWmbEVM9SoMHgf9970ER09TjX0B6GieBsalA6SiDE0w0vo5C6/J3wVBII17cVtvJHSINMJNBbSxjfh7Pz8x8Evfljabf8fvdy+ANBruuJvDtda80U3Lfv+eMFQe6o3CMtR/a4gLxWC5HC4PsMzIxJU0DZQX75VmwiRVmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2D6jlKG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2D6jlKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F64DC4CEF1;
	Mon,  1 Dec 2025 17:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764609262;
	bh=xr+scbNuDcdutR3BSvDQTMhN8ZBljtskf3ZPHRiXMbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z2D6jlKGXcwtR84ZoY6sFDMh71wQ+6wHMn4j89tBfTTRXt31ch9NyRh59tCNRT/ZI
	 YvOptZXHjynaG1kLh4onnRlKae9zTawr+TPIfHMVLEhqA2HsxKQ6nA4HJHSC8x6GmY
	 525h3Y9c8zRvsxGxeBb3tJGQkRVsR5RTF3hNN0SZGnJdOMoAacgEQcj+ccSD+0BZ8H
	 j2MwMWZJF9mUSclVBiioZ2cY086ZvWx+hHXyfkdKBHe8GpGYmbdi6prifM8owUCmLK
	 YmacOcSzeARnfRh0RjzZFatZSTwRnwyoo4s/suNkZZ/9fO23VfChDB0fbh6DjYCapw
	 32p2lKcyMpW1A==
Date: Mon, 1 Dec 2025 14:14:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 06/17] perf hist: In init, ensure mem_info is put on
 error paths
Message-ID: <aS3M6_T-_UIr6eiU@x1>
References: <20251122081929.7588-1-irogers@google.com>
 <20251122081929.7588-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122081929.7588-7-irogers@google.com>

On Sat, Nov 22, 2025 at 12:19:18AM -0800, Ian Rogers wrote:
> Rather than exit the internal map_symbols directly, put the mem-info
> that does this and also lowers the reference count on the mem-info
> itself otherwise the mem-info is being leaked.

Shouldn't this have a:

Fixes: 56e144fe98260a0f ("perf mem_info: Add and use map_symbol__exit and addr_map_symbol__exit")

Other than that:

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/hist.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 64ff427040c3..ef4b569f7df4 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -608,10 +608,8 @@ static int hist_entry__init(struct hist_entry *he,
>  		map_symbol__exit(&he->branch_info->to.ms);
>  		zfree(&he->branch_info);
>  	}
> -	if (he->mem_info) {
> -		map_symbol__exit(&mem_info__iaddr(he->mem_info)->ms);
> -		map_symbol__exit(&mem_info__daddr(he->mem_info)->ms);
> -	}
> +	if (he->mem_info)
> +		mem_info__zput(he->mem_info);
>  err:
>  	map_symbol__exit(&he->ms);
>  	zfree(&he->stat_acc);
> -- 
> 2.52.0.rc2.455.g230fcf2819-goog
> 
