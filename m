Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE46036683B;
	Tue,  7 Apr 2026 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575814; cv=none; b=V2LfWLTIm+ItQnuczj6LVHTL3W3MOFm8yDzvlbS4PDuXS2S5Rp4z1180mPeWVaiU4kNeaUZgrx1xUgXhphgez71gZ6p2jhBtgragFC744X2QNGltbRtm3tDr1dGn9TToDvwJECzebzxX/aRH20nbieLwzC/wW3gW8BbTRXEhkK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575814; c=relaxed/simple;
	bh=llsE4IbiFMmBlTdmurpE6AzK69uhgqzLVniQo/ehG6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wvn/Mvf73/xx5jr0sfg2jeG/PZ6ulcFh74Zg4z21ge/ng/+seNtlUxUnqXrXFJ7n2qN+SRd4cDYYhtCVpIJSLIr3+9MJMxYb3xSou0lCftq8aDp0cj941aONLwNfYBOqS8h/Ibntfxd3PIWeo3jGNNwxZKiuOdG+Tf/cu/Xy3vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jvAKs0sj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jvAKs0sj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D4B31BB2;
	Tue,  7 Apr 2026 08:29:57 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B34703F7D8;
	Tue,  7 Apr 2026 08:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775575803; bh=llsE4IbiFMmBlTdmurpE6AzK69uhgqzLVniQo/ehG6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvAKs0sjx33rw9GsjeF3tZl/J0axWZqCY0NiNEGV10fwcOBdwG9qCQdWnT/HNw/lR
	 wPeMIqTlifnG03XLtPKotuEaqwbyds3KKBfp8iAAkajdICvM7V1MMEJjkW9ByjaUp3
	 TTRhKZNJjmNirXkynXOWULgQNci7mBCJOYWzYe+c=
Date: Tue, 7 Apr 2026 16:30:00 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] perf arm_spe: Handle missing CPU IDs
Message-ID: <20260407153000.GN356832@e132581.arm.com>
References: <20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org>
 <20260407-james-spe-impdef-decode-v2-2-55d3ef997c48@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-james-spe-impdef-decode-v2-2-55d3ef997c48@linaro.org>

On Tue, Apr 07, 2026 at 03:05:16PM +0100, James Clark wrote:
> Don't call strtol() with a null pointer to avoid undefined behavior.
> 
> I'm not sure of the exact scenario for missing CPU IDs but I don't think
> it happens in practice. SPE decoding can continue without them with
> reduced functionality, but print an error message anyway.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>  tools/perf/util/arm-spe.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 7447b000f9cd..fc11f32e4911 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -968,16 +968,23 @@ static int arm_spe__get_midr(struct arm_spe *spe, int cpu, u64 *midr)
>  
>  		pr_warning_once("Old SPE metadata, re-record to improve decode accuracy\n");
>  		cpuid = perf_env__cpuid(perf_session__env(spe->session));
> +		if (!cpuid)
> +			goto err;
> +
>  		*midr = strtol(cpuid, NULL, 16);
>  		return 0;
>  	}
>  
>  	metadata = arm_spe__get_metadata_by_cpu(spe, cpu);
>  	if (!metadata)
> -		return -EINVAL;
> +		goto err;
>  
>  	*midr = metadata[ARM_SPE_CPU_MIDR];
>  	return 0;
> +
> +err:
> +	pr_err("Failed to get MIDR for CPU %d\n", cpu);
> +	return -EINVAL;
>  }
>  
>  static void arm_spe__synth_ds(struct arm_spe_queue *speq,
> 
> -- 
> 2.34.1
> 
> 
