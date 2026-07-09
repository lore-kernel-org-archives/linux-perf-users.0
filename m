Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9873368B2;
	Thu,  9 Jul 2026 05:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783576631; cv=none; b=pKMyHtmd7QjgdU0K9caykh8wS7yPjHICUPCBHRinm5Etj2wHH61mDtEJDS9Ak5IWqmgYNKqPGRj6YVD2MDCRGH3W3BilPmVwGFeNSII7Sza6rW2jUPnLCkIC5s0bHZz2UXJT41pkY5MXq24ZS8EWZ1OmF8r3J+2WRSRSfqkMXeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783576631; c=relaxed/simple;
	bh=nSuU9XcdKWX/5PKKOJEtIYe0/F1UilswMfLSp8zJJJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TagsCThlu8bmOHfVKr3CxqvACo/AWTOcKPh3gBVYEzsetNg96IdV8cZoohXfS57OjkKN9MWbt35ChtcpyJrq1Ievky28O14hp5h1KMqqPq4wCp3VQfdU+YabhRp2Rhash78sWN+X9zQOZmytob9SaGsxpTn8yzNftEzaSDImGL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PD3hOOYM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PD3hOOYM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AC11F000E9;
	Thu,  9 Jul 2026 05:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783576630;
	bh=u9DDICaGPjyDIJ9NWjhw28lDf3TfOxGOVQp/2rn/4cM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PD3hOOYM06H5IUbjISHSwLmIERqDOPSKQvneoyxlhYCoLmTtz5vsJWy9FvhTsaE+l
	 gwPmeEdOP+ZSFrZMUf5E5pIk7uS0Lq/JZf6Plto4SqrCNnWMXDPHKzIxLCd6W7HjrA
	 Pe0CSOtowVsM02ermSBUnTpBN9X8wlrXbGncag9WLR/WM7lIqZ+tGsrrQ4P9cQeCKN
	 Y8Dm45ntIHdptPcv4NFTYUl+Ua9nJD0k/42FkS3mMMuL+hUbjqUgJUoH2liOfZnsdh
	 SWMfUaS2lYxVDzdZYjcueUlDelL1NZH5AHVD5TRGVhtT77uEa77bCbpHDreasIBNm6
	 ynmDg6wbz/mrg==
Date: Wed, 8 Jul 2026 22:57:08 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: james.clark@linaro.org, xueshuai@linux.alibaba.com,
	Li Huafei <lihuafei1@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 01/21] perf capstone: Fix kernel map reference count
 leak
Message-ID: <ak84NFSWQXz3r46x@z2>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-2-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701035355.752944-2-wutengda@huaweicloud.com>

On Wed, Jul 01, 2026 at 03:53:35AM +0000, Tengda Wu wrote:
> In print_capstone_detail(), maps__find() is used to locate the kernel
> map. This function increments the reference count of the found map
> object. However, the current implementation fails to call map__put()
> after the map is no longer needed, leading to a reference count leak.
> 
> Fix this by adding a map__put(map) call to properly release the
> reference after use.
> 
> Fixes: 92dfc59463d5 ("perf annotate: Add symbol name when using capstone")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

I'll pick this up separately.

Thanks,
Namhyung

> ---
>  tools/perf/util/capstone.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> index 5ad537fea436..9bba78ee0c5a 100644
> --- a/tools/perf/util/capstone.c
> +++ b/tools/perf/util/capstone.c
> @@ -302,6 +302,7 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
>  	for (i = 0; i < insn->detail->x86.op_count; i++) {
>  		struct cs_x86_op *op = &insn->detail->x86.operands[i];
>  		u64 orig_addr;
> +		struct map *found_map = NULL;
>  
>  		if (op->type != X86_OP_MEM)
>  			continue;
> @@ -317,19 +318,22 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
>  		if (dso__kernel(map__dso(map))) {
>  			/*
>  			 * The kernel maps can be split into sections, let's
> -			 * find the map first and the search the symbol.
> +			 * find the map first and then search the symbol.
>  			 */
> -			map = maps__find(map__kmaps(map), addr);
> -			if (map == NULL)
> +			found_map = maps__find(map__kmaps(map), addr);
> +			if (found_map == NULL)
>  				continue;
> +			map = found_map;
>  		}
>  
>  		/* convert it to map-relative address for search */
>  		addr = map__map_ip(map, addr);
>  
>  		sym = map__find_symbol(map, addr);
> -		if (sym == NULL)
> +		if (sym == NULL) {
> +			map__put(found_map);
>  			continue;
> +		}
>  
>  		if (addr == sym->start) {
>  			scnprintf(buf, len, "\t# %"PRIx64" <%s>",
> @@ -338,6 +342,7 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
>  			scnprintf(buf, len, "\t# %"PRIx64" <%s+%#"PRIx64">",
>  				  orig_addr, sym->name, addr - sym->start);
>  		}
> +		map__put(found_map);
>  		break;
>  	}
>  }
> -- 
> 2.34.1
> 
