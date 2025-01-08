Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187131F8F17;
	Wed,  8 Jan 2025 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348015; cv=none; b=XHdzN7iv+bWpSfwJAykKZddwgl0VYonlVHxfXrm9KsOvqOXrGqahO+lMHuqhddnInvV/RidwpnWyVrmBrUdhckTp0Z2bchQ8zPxQO6qBOL/Xc6LikPwUbqs/Q3BkGWE2qXLDWis+Xmmxct2tC2JyfvHS+qbc37lqSxj2W2XJPdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348015; c=relaxed/simple;
	bh=Wc5NJJgSLmBbDtDATC3/rAfSv7csY6/S8IjZjpkVFY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNqe3jaTN3gXP1qiMNrGU1HGI6L+reSRelho8eO0oanaf7tAZAtZFNRiNQo0XWgDAP3f1VIS9WSyg3S+ZbFAaemWs8tz+wTuAGo1QnB6bcVet1pcGYTCPoRhs7pyNfZ9K5HIA49Q3kJdgdcRw9wZn692XWQIfOWpTatO9MrvksY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6iG+uf4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6iG+uf4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131F0C4CEDD;
	Wed,  8 Jan 2025 14:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736348014;
	bh=Wc5NJJgSLmBbDtDATC3/rAfSv7csY6/S8IjZjpkVFY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d6iG+uf4HD0hHIn8yoaeCaAg58A2M84CQ202sAQJx4yyinOEEgMMIh420h+t5BZCp
	 ZpDSQeRM9e5RYXIVjWoZ4CTh8IqoY2EqIjsKPD4BHwwYuxiI0nU9RsmlB3qCCF2O8I
	 M/xPGQmJtJ+KbDcSZApuNjDHdu0nKzMSCcREJP4qQfY8f7wSkzFqtlp4p78+GtKfx/
	 RyZxm+wE7c7S2lqNwivcFQuRbrNwXL1MKqXG7E7Ni+NhB61Ojw/ruf+0kVwjeEbf7k
	 BpZrZviQHaVEeMHYgxsRQsA3zBWbjGnQCIHC7+nMv+1qvfkIrDVr9c9r6FzEfhWquC
	 CpgGCQJO5KFXQ==
Date: Wed, 8 Jan 2025 11:53:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v2] perf: Fix display of kernel symbols
Message-ID: <Z36Ra23US_zC3n2v@x1>
References: <2ea4501209d5363bac71a6757fe91c0747558a42.1736329923.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ea4501209d5363bac71a6757fe91c0747558a42.1736329923.git.christophe.leroy@csgroup.eu>

On Wed, Jan 08, 2025 at 10:54:20AM +0100, Christophe Leroy wrote:
> Since commit 659ad3492b91 ("perf maps: Switch from rbtree to lazily
> sorted array for addresses"), perf doesn't display anymore kernel
> symbols on powerpc, allthough it still detects them as kernel addresses.
> 
> 	# Overhead  Command     Shared Object  Symbol
> 	# ........  ..........  ............. ......................................
> 	#
> 	    80.49%  Coeur main  [unknown]      [k] 0xc005f0f8
> 	     3.91%  Coeur main  gau            [.] engine_loop.constprop.0.isra.0
> 	     1.72%  Coeur main  [unknown]      [k] 0xc005f11c
> 	     1.09%  Coeur main  [unknown]      [k] 0xc01f82c8
> 	     0.44%  Coeur main  libc.so.6      [.] epoll_wait
> 	     0.38%  Coeur main  [unknown]      [k] 0xc0011718
> 	     0.36%  Coeur main  [unknown]      [k] 0xc01f45c0
> 
> This is because function maps__find_next_entry() now returns current
> entry instead of next entry, leading to kernel map end address
> getting mis-configured with its own start address instead of the
> start address of the following map.
> 
> Fix it by really taking the next entry, also make sure that entry
> follows current one by making sure entries are sorted.
> 
> Fixes: 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for addresses")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
> v2: Make sure the entries are sorted, if not sort them.

Since you have changed what I reviewed I'll have to re-review :-) Will
try to do it after some calls.

- Arnaldo

> ---
>  tools/perf/util/maps.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 432399cbe5dd..09c9cc326c08 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -1136,8 +1136,13 @@ struct map *maps__find_next_entry(struct maps *maps, struct map *map)
>  	struct map *result = NULL;
>  
>  	down_read(maps__lock(maps));
> +	while (!maps__maps_by_address_sorted(maps)) {
> +		up_read(maps__lock(maps));
> +		maps__sort_by_address(maps);
> +		down_read(maps__lock(maps));
> +	}
>  	i = maps__by_address_index(maps, map);
> -	if (i < maps__nr_maps(maps))
> +	if (++i < maps__nr_maps(maps))
>  		result = map__get(maps__maps_by_address(maps)[i]);
>  
>  	up_read(maps__lock(maps));
> -- 
> 2.47.0
