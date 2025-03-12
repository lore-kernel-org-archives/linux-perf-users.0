Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C395A23C8AE;
	Wed, 12 Mar 2025 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773421; cv=none; b=FKVGq50QeEJUle//dFIq5EO2xHcFLICkrkN1iPcPpIX/ArYrOrHkwggd4V1R/eYJx4ak3Ud267m518c6B+arn4paAxXZHWH0FqIzU2B5kjKPE97faMJjD5ri9+cVA9Ke7tP16JoDA6kFbiu9mXw+wFM8F7stLxDAx61BReygp28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773421; c=relaxed/simple;
	bh=h/0svnDzFfC36YTDA6ABydJ+DHLGj5Q9Nhr7nuAmPQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgkeM3y4NGqQ2mKUQPuzZcS6ql8uEZvIKDGl2pEc98Ecg6DYjjm8q4pTjZhDSV83xUolxCF0M7onJVsvsQTjMlxI8LyWGChgnlRXsNP9C//2kp473eAGdP9RhoYwnRZbF0AkYg+4KsIr65h//blDbQsFGRTLNU6YmmXvYEaeh+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1957152B;
	Wed, 12 Mar 2025 02:57:09 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B443A3F5A1;
	Wed, 12 Mar 2025 02:56:58 -0700 (PDT)
Date: Wed, 12 Mar 2025 09:56:57 +0000
From: Leo Yan <leo.yan@arm.com>
To: Yujie Liu <yujie.liu@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Graham Woodward <graham.woodward@arm.com>, Paschalis.Mpeis@arm.com
Subject: Re: [PATCH] perf script: Fix typo in branch event mask
Message-ID: <20250312095657.GM9682@e132581.arm.com>
References: <20250312075636.429127-1-yujie.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312075636.429127-1-yujie.liu@intel.com>

On Wed, Mar 12, 2025 at 03:56:36PM +0800, Yujie Liu wrote:
> BRACH -> BRANCH
> 
> Fixes: 88b1473135e4 ("perf script: Separate events from branch types")
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>  tools/perf/util/event.h                 | 2 +-
>  tools/perf/util/trace-event-scripting.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index c7f4b4b841ca..664bf39567ce 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -91,7 +91,7 @@ enum {
>  	PERF_IP_FLAG_VMENTRY		|\
>  	PERF_IP_FLAG_VMEXIT)
>  
> -#define PERF_IP_FLAG_BRACH_EVENT_MASK	\
> +#define PERF_IP_FLAG_BRANCH_EVENT_MASK	\
>  	(PERF_IP_FLAG_BRANCH_MISS |	\
>  	 PERF_IP_FLAG_NOT_TAKEN)
>  
> diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
> index 29cc467be14a..72abb28b7b5a 100644
> --- a/tools/perf/util/trace-event-scripting.c
> +++ b/tools/perf/util/trace-event-scripting.c
> @@ -347,7 +347,7 @@ static int sample_flags_to_name(u32 flags, char *str, size_t size)
>  
>  	flags &= ~(PERF_IP_FLAG_TRACE_BEGIN | PERF_IP_FLAG_TRACE_END);
>  
> -	types = flags & ~PERF_IP_FLAG_BRACH_EVENT_MASK;
> +	types = flags & ~PERF_IP_FLAG_BRANCH_EVENT_MASK;
>  	for (i = 0; sample_flags[i].name; i++) {
>  		if (sample_flags[i].flags != types)
>  			continue;
> @@ -359,7 +359,7 @@ static int sample_flags_to_name(u32 flags, char *str, size_t size)
>  		break;
>  	}
>  
> -	events = flags & PERF_IP_FLAG_BRACH_EVENT_MASK;
> +	events = flags & PERF_IP_FLAG_BRANCH_EVENT_MASK;
>  	for (i = 0; branch_events[i].name; i++) {
>  		if (!(branch_events[i].flags & events))
>  			continue;
> 
> base-commit: b10f74308e1305275e69ddde711ec817cc69e306
> -- 
> 2.34.1
> 
