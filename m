Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4EC23CF12;
	Wed, 12 Mar 2025 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773381; cv=none; b=lGsZ+SUJGciiLGx8idsXiu61dHgBqtnXYxoXOuu/2OyhhkfQEj/aypzcOvFL6UWNuye9nD8ju0onugmLmOuw9RndhjpaJ9oNphXxxmHMy6eMCz1PPQh4AEhZ+C8nHZjPDyJGdjsWKLz4GpQBIJvKyTzkNn2AIwWwgUBPGkk46zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773381; c=relaxed/simple;
	bh=IOxTtn9oEAUi55rJMUn1mdKE85G/bJiTYZGzSQh0+nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnzjG7KNsU+VhkjirlXMOa7zZIW9iK4s94T7G7TeOItLbn0+140N2lXHKtvXStQjT3QbT8OgV1FlA1Z8Z0pR6O5Sz9ypJi2OFxiPVE4Ht5zEghJy8dqdQMbg5i0nbgk0Ho6i7WuBWLgYqWR6bRyUqPpNUmuL6rvAWG9SWdNa47g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85884152B;
	Wed, 12 Mar 2025 02:56:29 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5666A3F5A1;
	Wed, 12 Mar 2025 02:56:18 -0700 (PDT)
Date: Wed, 12 Mar 2025 09:56:13 +0000
From: Leo Yan <leo.yan@arm.com>
To: Yujie Liu <yujie.liu@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Martin Liska <martin.liska@hey.com>,
	James Clark <james.clark@linaro.org>,
	Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v2] perf script: Update brstack syntax documentation
Message-ID: <20250312095613.GL9682@e132581.arm.com>
References: <20250312072329.419020-1-yujie.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312072329.419020-1-yujie.liu@intel.com>

On Wed, Mar 12, 2025 at 03:23:29PM +0800, Yujie Liu wrote:
> The following commits added new fields/flags to the branch stack field
> list:
> 
> commit 1f48989cdc7d ("perf script: Output branch sample type")
> commit 6ade6c646035 ("perf script: Show branch speculation info")
> commit 1e66dcff7b9b ("perf script: Add not taken event for branch stack")
> 
> Update brstack syntax documentation to be consistent with the latest
> branch stack field list. Improve the descriptions to help users
> interpret the fields accurately.
> 
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
> Changes in v2:
> - Add not taken event (Namhyung, Leo)
> - Change field name from PRED to EVENT for generic use and furture
>   extension (Leo)
> 
> v1: https://lore.kernel.org/all/20250225061736.1698175-1-yujie.liu@intel.com/
> ---
>  tools/perf/Documentation/perf-script.txt | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index b72866ef270b..28bec7e78bc8 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -239,13 +239,22 @@ OPTIONS
>  	i.e., -F "" is not allowed.
>  
>  	The brstack output includes branch related information with raw addresses using the
> -	/v/v/v/v/cycles syntax in the following order:
> -	FROM: branch source instruction
> -	TO  : branch target instruction
> -        M/P/-: M=branch target mispredicted or branch direction was mispredicted, P=target predicted or direction predicted, -=not supported
> -	X/- : X=branch inside a transactional region, -=not in transaction region or not supported
> -	A/- : A=TSX abort entry, -=not aborted region or not supported
> -	cycles
> +	FROM/TO/EVENT/INTX/ABORT/CYCLES/TYPE/SPEC syntax in the following order:
> +	FROM  : branch source instruction
> +	TO    : branch target instruction
> +	EVENT : M=branch target or direction was mispredicted
> +	        P=branch target or direction was predicted
> +	        N=branch not-taken
> +	        -=no event or not supported
> +	INTX  : X=branch inside a transactional region
> +	        -=branch not in transaction region or not supported
> +	ABORT : A=TSX abort entry
> +	        -=not aborted region or not supported
> +	CYCLES: the number of cycles that have elapsed since the last branch was recorded
> +	TYPE  : branch type: COND/UNCOND/IND/CALL/IND_CALL/RET etc.
> +	        -=not supported
> +	SPEC  : branch speculation info: SPEC_WRONG_PATH/NON_SPEC_CORRECT_PATH/SPEC_CORRECT_PATH
> +	        -=not supported
>  
>  	The brstacksym is identical to brstack, except that the FROM and TO addresses are printed in a symbolic form if possible.
>  
> 
> base-commit: b10f74308e1305275e69ddde711ec817cc69e306
> -- 
> 2.34.1
> 
