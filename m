Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC7D37165
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Nov 2023 20:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZQFWjvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E26C433C7;
	Wed,  8 Nov 2023 20:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699475227;
	bh=3eK41umP+PNvQkPkGSnSp+1Cb2llqRdlWxwUqKq+Jyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RZQFWjvYlSgub9vGdYvD+XEywVHu23QcYHdiAbVpzCMcdTTFDdPALR5tfWr4ljYqw
	 qY0xeWP9btMbHVzmTgXYZtn8koYpJqPrwsUQcas6woSfC+FqGDgxhv85JL4AdPU6fE
	 JlMQ7d57dyENefLO/05aRGas0J+cahpSRb/ZShpWlM+l9IJsrv2PkA1/U/ND+jCJBg
	 wQcCN6hW6VVpVONuODL0THzbGUddWlO41tVK5CzMHJJeNzxGaypTnaX1AK22ZhyczR
	 ja+OKUqmR4WVVvpzfgEA02Q0CbnrBC9/aP599u9BBBKcEv8IQ0InOlwGIM/THPpFw2
	 hxWfusHNeLpcQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 5C6864035D; Wed,  8 Nov 2023 17:27:05 -0300 (-03)
Date: Wed, 8 Nov 2023 17:27:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCHSET 0/5] perf annotate: Reduce memory footprint (v2)
Message-ID: <ZUvvGSsOesdbQUXY@kernel.org>
References: <20231103191907.54531-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103191907.54531-1-namhyung@kernel.org>
X-Url: http://acmel.wordpress.com

Em Fri, Nov 03, 2023 at 12:19:02PM -0700, Namhyung Kim escreveu:
> Hello,
> 
> This is a part of my work to improve perf annotate.  At first, I'd
> like reduce the size of struct annotation which will be allocated
> together with struct symbol in some cases.  In fact, it doesn't use
> most of them so it needs to slim down and lazy-allocate used part.
> 
> * v2 changes)
>  - fix typo
>  - reorder struct annotated_source
>  - add Ian's Reviewed-by tags
>  
> With this applied, size of the struct goes down from 96 to 48.
> 
> The code is available at perf/annotate-diet-v2 branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 

Applied to perf-tools-next, thanks,

- Arnaldo
 
> Namhyung Kim (5):
>   perf annotate: Split struct cycles_info
>   perf annotate: Split struct annotated_branch
>   perf annotate: Move max_coverage to annotated_branch
>   perf annotate: Move some fields to annotated_source
>   perf annotate: Move offsets to annotated_source
> 
>  tools/perf/builtin-annotate.c     |   7 +-
>  tools/perf/ui/browsers/annotate.c |  18 ++--
>  tools/perf/util/annotate.c        | 162 ++++++++++++++++--------------
>  tools/perf/util/annotate.h        |  49 +++++----
>  tools/perf/util/block-info.c      |   4 +-
>  tools/perf/util/block-range.c     |   7 +-
>  tools/perf/util/sort.c            |  14 +--
>  7 files changed, 147 insertions(+), 114 deletions(-)
> 
> -- 
> 2.42.0.869.gea05f2083d-goog
> 
> 

-- 

- Arnaldo
