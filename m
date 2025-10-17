Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F4730F556;
	Fri, 17 Oct 2025 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695786; cv=none; b=JlA83JG0EpDntPfAqETYZHSG/J/qe8a8VKekagvWpa9d+gdlz4g/HYahPZxBWI9CTU87fdCFRjcAvPrWJvziXoMtj33hOEX9eObEVAYfYsU/MT/wm34V8Jg6TqJn6bwu9OIQn4s2EBvZ2rZqSUDHZ6oGzdNdpaNZ3kt0OckzRAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695786; c=relaxed/simple;
	bh=qcygzYRgi9L7d9OTenk5QBRkLySfTb2S886Ji6vP7Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+yP9AQ9FNoBj0FYw/XTRwJtRyk31Oo9RQ2ckYd+JuIB7QsRbB+5/btFT60eTLNUKVGy5LGwPFWcSB5ftfDz/MH12MFcEBMC+nN6vBK2ca4Gzj9393om7+30d4Z7OIWfMikRp/xNuyzmd1KYZ041DO169/Yspzlhh7Fo2Mg5zRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FAF91595;
	Fri, 17 Oct 2025 03:09:36 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 269A93F59E;
	Fri, 17 Oct 2025 03:09:44 -0700 (PDT)
Date: Fri, 17 Oct 2025 11:09:42 +0100
From: Leo Yan <leo.yan@arm.com>
To: tanze <tanze@kylinos.cn>
Cc: james.clark@linaro.org, leo.yan@linux.dev, irogers@google.com,
	john.g.garry@oracle.com, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	graham.woodward@arm.com, mike.leach@linaro.org
Subject: Re: [PATCH v2] perf arm_spe: Add a macro definition to handle offset
 value
Message-ID: <20251017100942.GB281971@e132581.arm.com>
References: <20251016083019.27935-1-tanze@kylinos.cn>
 <20251017021540.45930-1-tanze@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017021540.45930-1-tanze@kylinos.cn>

On Fri, Oct 17, 2025 at 10:15:40AM +0800, tanze wrote:
> Add a macro definition SPE_SYNTH_ID_OFFSET to handle the offset value
> and improve readability.
> 
> Signed-off-by: tanze <tanze@kylinos.cn>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
> Hi, Leo Yan
> 
> Thank you for your guidance and suggestions. I have made revisions according to your requirements. 
> Do you have any further suggestions?
> ---
> Changes in v2:
> - Migrate the macro definitions to the synthetic-events.h file
> - Add modifications to other source files that use the offset value
> ---
>  tools/perf/util/arm-spe.c          | 2 +-
>  tools/perf/util/cs-etm.c           | 2 +-
>  tools/perf/util/intel-bts.c        | 2 +-
>  tools/perf/util/intel-pt.c         | 2 +-
>  tools/perf/util/powerpc-vpadtl.c   | 3 ++-
>  tools/perf/util/synthetic-events.h | 2 ++
>  6 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 71be979f5077..b082cb1666a6 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -1732,7 +1732,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>  	attr.sample_period = spe->synth_opts.period;
>  
>  	/* create new id val to be a fixed offset from evsel id */
> -	id = evsel->core.id[0] + 1000000000;
> +	id = evsel->core.id[0] + PERF_SYNTH_EVENT_ID_OFFSET;
>  
>  	if (!id)
>  		id = 1;
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 30f4bb3e7fa3..46902f7b69f1 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1726,7 +1726,7 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
>  	attr.read_format = evsel->core.attr.read_format;
>  
>  	/* create new id val to be a fixed offset from evsel id */
> -	id = evsel->core.id[0] + 1000000000;
> +	id = evsel->core.id[0] + PERF_SYNTH_EVENT_ID_OFFSET;
>  
>  	if (!id)
>  		id = 1;
> diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
> index 3625c6224750..98b928eca724 100644
> --- a/tools/perf/util/intel-bts.c
> +++ b/tools/perf/util/intel-bts.c
> @@ -777,7 +777,7 @@ static int intel_bts_synth_events(struct intel_bts *bts,
>  	attr.sample_id_all = evsel->core.attr.sample_id_all;
>  	attr.read_format = evsel->core.attr.read_format;
>  
> -	id = evsel->core.id[0] + 1000000000;
> +	id = evsel->core.id[0] + PERF_SYNTH_EVENT_ID_OFFSET;
>  	if (!id)
>  		id = 1;
>  
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 9b1011fe4826..4fb9600a7369 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -3987,7 +3987,7 @@ static int intel_pt_synth_events(struct intel_pt *pt,
>  	attr.sample_id_all = evsel->core.attr.sample_id_all;
>  	attr.read_format = evsel->core.attr.read_format;
>  
> -	id = evsel->core.id[0] + 1000000000;
> +	id = evsel->core.id[0] + PERF_SYNTH_EVENT_ID_OFFSET;
>  	if (!id)
>  		id = 1;
>  
> diff --git a/tools/perf/util/powerpc-vpadtl.c b/tools/perf/util/powerpc-vpadtl.c
> index 39a3fb3f1330..5ce5d2bf4c6c 100644
> --- a/tools/perf/util/powerpc-vpadtl.c
> +++ b/tools/perf/util/powerpc-vpadtl.c
> @@ -15,6 +15,7 @@
>  #include "powerpc-vpadtl.h"
>  #include "sample.h"
>  #include "tool.h"
> +#include "util/synthetic-events.h"
>  
>  /*
>   * Structure to save the auxtrace queue
> @@ -656,7 +657,7 @@ powerpc_vpadtl_synth_events(struct powerpc_vpadtl *vpa, struct perf_session *ses
>  	attr.config = PERF_SYNTH_POWERPC_VPA_DTL;
>  
>  	/* create new id val to be a fixed offset from evsel id */
> -	id = evsel->core.id[0] + 1000000000;
> +	id = evsel->core.id[0] + PERF_SYNTH_EVENT_ID_OFFSET;
>  	if (!id)
>  		id = 1;
>  
> diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
> index ee29615d68e5..c8a1fe7a3fa4 100644
> --- a/tools/perf/util/synthetic-events.h
> +++ b/tools/perf/util/synthetic-events.h
> @@ -39,6 +39,8 @@ enum perf_record_synth {
>  };
>  #define PERF_SYNTH_ALL  (PERF_SYNTH_MAX - 1)
>  
> +#define PERF_SYNTH_EVENT_ID_OFFSET	(1000000000ULL)
> +
>  int parse_synth_opt(char *str);
>  
>  typedef int (*perf_event__handler_t)(const struct perf_tool *tool, union perf_event *event,
> -- 
> 2.25.1
> 
> 
