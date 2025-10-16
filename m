Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0643148A9;
	Thu, 16 Oct 2025 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605803; cv=none; b=t5IrMufV7pGPj/z3/aZvBT86XbVhyUV0WwkXF39AlmHPH4P+7nPzfGgprmL0mYiuGMr2Gkm8w5dj6nfkU6v3PDocnLiyfT4YpH4AtCZwk+06foeitjEXGvdE/Ru5rcV6Ia4KD97FugWJkOuY9aNH3XyAy8KopKdAfZIKAcuTxxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605803; c=relaxed/simple;
	bh=Womg90+i4ELD8jdBQNceUQHjQ3cGGYE/qCn3v5ORcno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUZx/s3IxRNf17u72AewMeM4TYqDPQyDUNNCL+c2jbd2+RlJchl1vyhQWXugWUWFi+BP32ih9GF+q4QMJz9goTJll1QzhAwsxvjVduVDbKQeIQbWBZIpYFhXjJo676OyCbBEPNQefqCmPrHNi9yxNzAbgbAE3MMXAw03lWzZh+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C41C81688;
	Thu, 16 Oct 2025 02:09:52 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D5F03F6A8;
	Thu, 16 Oct 2025 02:10:00 -0700 (PDT)
Date: Thu, 16 Oct 2025 10:09:58 +0100
From: Leo Yan <leo.yan@arm.com>
To: tanze <tanze@kylinos.cn>
Cc: james.clark@linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	graham.woodward@arm.com
Subject: Re: [PATCH v1] perf arm_spe: Add a macro definition to handle offset
 value
Message-ID: <20251016090958.GE109737@e132581.arm.com>
References: <20251016083019.27935-1-tanze@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016083019.27935-1-tanze@kylinos.cn>

On Thu, Oct 16, 2025 at 04:30:19PM +0800, tanze wrote:
> Add a macro definition SPE_SYNTH_ID_OFFSET to handle the offset value
> and improve readability.
> 
> Signed-off-by: tanze <tanze@kylinos.cn>
> ---
>  tools/perf/util/arm-spe.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 71be979f5077..645048ac7708 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -36,6 +36,7 @@
>  
>  #include "../../arch/arm64/include/asm/cputype.h"
>  #define MAX_TIMESTAMP (~0ULL)
> +#define SPE_SYNTH_ID_OFFSET (1000000000ULL)
>  
>  #define is_ldst_op(op)		(!!((op) & ARM_SPE_OP_LDST))
>  
> @@ -1732,7 +1733,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>  	attr.sample_period = spe->synth_opts.period;
>  
>  	/* create new id val to be a fixed offset from evsel id */
> -	id = evsel->core.id[0] + 1000000000;
> +	id = evsel->core.id[0] + SPE_SYNTH_ID_OFFSET;

If really want to improve a bit for this, I'd define a macro in
util/synthetic-events.h:

  #define PERF_SYNTH_EVENT_ID_OFFSET    (1000000000ULL)

Then, apply the new macro in files:

$ git grep "core.id.*1000000000"
util/arm-spe.c: id = evsel->core.id[0] + 1000000000;
util/cs-etm.c:  id = evsel->core.id[0] + 1000000000;
util/intel-bts.c:       id = evsel->core.id[0] + 1000000000;
util/intel-pt.c:        id = evsel->core.id[0] + 1000000000;
util/powerpc-vpadtl.c:  id = evsel->core.id[0] + 1000000000;

Thanks,
Leo
