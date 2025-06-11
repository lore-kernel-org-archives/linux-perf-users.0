Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD782C1794;
	Wed, 11 Jun 2025 23:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749685386; cv=none; b=FZjCwiuh8rHF2oWF2ejdLM6sFj4PdDrv28riYOCW3suAdDN2JoLXynAr1H81HyKgk5uF5oSJ3eI7TwwK5GFkeu7m4Irz8bYk+NiLiRRYhAu9XpA/iHLaxM4s7waV/U6Nu7CTdEpdrRN3soIhpb2GlYlJDx+FAVnDQYYMfo02tsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749685386; c=relaxed/simple;
	bh=rzlIdkQY8WNYV6UEoBGGsvl7jgrSdBvD5LIZYne+4pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkyunUTl27R8p1JB8XgpNBOlxqhPtiD7cJo5dmkPRr3eLN+CIsqtpKaDe9rdxmQFTopc/OHgPjOSTtl76Ue4/NedWNNr5jtBaG1RzQhlGPjSnmUJy7BOwVRl26f8ejHeM+iKwtNaz+zkcskPY9oTtKTT5BenYemTUIi6RSre/+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgPUj2DX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgPUj2DX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AE8C4CEE3;
	Wed, 11 Jun 2025 23:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749685386;
	bh=rzlIdkQY8WNYV6UEoBGGsvl7jgrSdBvD5LIZYne+4pQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BgPUj2DXnznuD/EoWPtVFvIGaxdQ74zP4IYKtqcAdJ0T3QBCGBQuNu2rkSLcaMayD
	 FYimIhe2wpW2u+TbbDolNLiLncepxYOMZ52JA6eMqdSlYfXDkPbMsRAP6VKeBdiqc/
	 WO3tXK7hI4pHt3vOByKPGeDx+9vZGLdIxzDmDGev0jPnOYO2wYCVQb+7LreEXeV82T
	 lpchtpe1heatkw4WJqbPXPkxPDnV1NSw+8RBKjhD/8gUPBrR0eCrtTkOLU5kFwKmHm
	 5LeJKCYbW3nUwEc0WmZ+nvn1+pT2/JvoW7TfHXjsW8lWHtcCDpzyAx2D9SZCXebXBp
	 Dtoif7kCZ3iFA==
Date: Wed, 11 Jun 2025 16:43:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] perf stat: Fix uncore aggregation number
Message-ID: <aEoUiCz0neodnQmu@google.com>
References: <20250611233239.3098064-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250611233239.3098064-1-ctshao@google.com>

Hello,

On Wed, Jun 11, 2025 at 04:32:16PM -0700, Chun-Tse Shao wrote:
> Follow up:
> lore.kernel.org/CAP-5=fVDF4-qYL1Lm7efgiHk7X=_nw_nEFMBZFMcsnOOJgX4Kg@mail.gmail.com/
> 
> The patch adds unit aggregation during evsel merge the aggregated uncore
> counters.
> 
> Tested on a 2-socket machine with SNC3, uncore_imc_[0-11] and
> cpumask="0,120"
> Before:
>   perf stat -e clockticks -I 1000 --per-socket
>   #           time socket cpus             counts unit events
>        1.001085024 S0        1         9615386315      clockticks
>        1.001085024 S1        1         9614287448      clockticks
>   perf stat -e clockticks -I 1000 --per-node
>   #           time node   cpus             counts unit events
>        1.001029867 N0        1         3205726984      clockticks
>        1.001029867 N1        1         3205444421      clockticks
>        1.001029867 N2        1         3205234018      clockticks
>        1.001029867 N3        1         3205224660      clockticks
>        1.001029867 N4        1         3205207213      clockticks
>        1.001029867 N5        1         3205528246      clockticks
> After:
>   perf stat -e clockticks -I 1000 --per-socket
>   #           time socket cpus             counts unit events
>        1.001022937 S0       12         9621463177      clockticks
>        1.001022937 S1       12         9619804949      clockticks
>   perf stat -e clockticks -I 1000 --per-node
>   #           time node   cpus             counts unit events
>        1.001029867 N0        4         3206782080      clockticks
>        1.001029867 N1        4         3207025354      clockticks
>        1.001029867 N2        4         3207067946      clockticks
>        1.001029867 N3        4         3206871733      clockticks
>        1.001029867 N4        4         3206199005      clockticks
>        1.001029867 N5        4         3205525058      clockticks
> 
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

> ---
>  tools/perf/util/stat.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 355a7d5c8ab8..52266d773353 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -527,6 +527,7 @@ static int evsel__merge_aggr_counters(struct evsel *evsel, struct evsel *alias)
>  		struct perf_counts_values *aggr_counts_b = &ps_b->aggr[i].counts;
>  
>  		/* NB: don't increase aggr.nr for aliases */

Probably we need to delete this comment.

Thanks,
namhyung


> +		ps_a->aggr[i].nr += ps_b->aggr[i].nr;
>  
>  		aggr_counts_a->val += aggr_counts_b->val;
>  		aggr_counts_a->ena += aggr_counts_b->ena;
> -- 
> 2.50.0.rc1.591.g9c95f17f64-goog
> 
