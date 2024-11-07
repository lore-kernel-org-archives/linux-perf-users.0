Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB99CA6F;
	Thu,  7 Nov 2024 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994279; cv=none; b=regG+wk8kXYOcc3ZqoqrXNYmy9XR9xT4Y/wkGtQKmJTLLMwX5dtAdvss0PFa1XozgsbxdOvXHWzc3/ZufdUGjd888Qf4FeaaqemCdG8jghJ2auoGSZ2eLfUqQP42qeYdatOhE6H414WAjgdL0U69P17JYe1AXkrsVZzJCjNePbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994279; c=relaxed/simple;
	bh=EOPW4AVkmGnwlloJwdaCDmemcz+5NZTsCNmZ/ikwm2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLHrzqQMS5Jh8U+8u8PUQuPKGalHXfZ0vvGymQKiijFDkOJd7Q60mn6ZYdBpJDffuVBqqtmooRKK9hJ3BEGvM7t5H6j4gFO6KZHQBPREEdNRAO4UbnpS6OuFT1jacJJFccfF2AVjG5rXBMSDIryPp4EkOVkyLY3PPir/m3xq08s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79F4E1063;
	Thu,  7 Nov 2024 07:45:05 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4639F3F66E;
	Thu,  7 Nov 2024 07:44:35 -0800 (PST)
Date: Thu, 7 Nov 2024 15:44:24 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Graham Woodward <graham.woodward@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] perf arm-spe: Add support for SPE Data Source
 packet on AmpereOne
Message-ID: <20241107154424.GD47850@e132581.arm.com>
References: <20241106193740.6159-1-ilkka@os.amperecomputing.com>
 <20241106193740.6159-3-ilkka@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106193740.6159-3-ilkka@os.amperecomputing.com>

On Wed, Nov 06, 2024 at 07:37:40PM +0000, Ilkka Koskinen wrote:
> Warning: EXTERNAL SENDER, use caution when opening links or attachments.
> 
> 
> Decode SPE Data Source packets on AmpereOne. The field is IMPDEF.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>  .../util/arm-spe-decoder/arm-spe-decoder.h    |  9 +++++
>  tools/perf/util/arm-spe.c                     | 39 +++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index 358c611eeddb..4bcd627e859f 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -67,6 +67,15 @@ enum arm_spe_common_data_source {
>         ARM_SPE_COMMON_DS_DRAM          = 0xe,
>  };
> 
> +enum arm_spe_ampereone_data_source {
> +       ARM_SPE_AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE    = 0x0,
> +       ARM_SPE_AMPEREONE_SLC                           = 0x3,
> +       ARM_SPE_AMPEREONE_REMOTE_CHIP_CACHE             = 0x5,
> +       ARM_SPE_AMPEREONE_DDR                           = 0x7,
> +       ARM_SPE_AMPEREONE_L1D                           = 0x8,
> +       ARM_SPE_AMPEREONE_L2D                           = 0x9,
> +};
> +
>  struct arm_spe_record {
>         enum arm_spe_sample_type type;
>         int err;
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index b222557cc27a..40847a3d18b0 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -531,6 +531,44 @@ static void arm_spe__synth_data_source_common(const struct arm_spe_record *recor
>         }
>  }
> 
> +/*
> + * Source is IMPDEF. Here we convert the source code used on AmpereOne cores
> + * to the common (Neoverse, Cortex) to avoid duplicating the decoding code.
> + */
> +static void arm_spe__synth_data_source_ampereone(const struct arm_spe_record *record,
> +                                                union perf_mem_data_src *data_src)
> +{
> +       struct arm_spe_record common_record;
> +
> +       switch (record->source) {
> +       case ARM_SPE_AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE:
> +               common_record.source = ARM_SPE_COMMON_DS_PEER_CORE;
> +               break;
> +       case ARM_SPE_AMPEREONE_SLC:
> +               common_record.source = ARM_SPE_COMMON_DS_SYS_CACHE;
> +               break;
> +       case ARM_SPE_AMPEREONE_REMOTE_CHIP_CACHE:
> +               common_record.source = ARM_SPE_COMMON_DS_REMOTE;
> +               break;
> +       case ARM_SPE_AMPEREONE_DDR:
> +               common_record.source = ARM_SPE_COMMON_DS_DRAM;
> +               break;
> +       case ARM_SPE_AMPEREONE_L1D:
> +               common_record.source = ARM_SPE_COMMON_DS_L1D;
> +               break;
> +       case ARM_SPE_AMPEREONE_L2D:
> +               common_record.source = ARM_SPE_COMMON_DS_L2;
> +               break;
> +       default:
> +               /* Assign a bogus value that's not used for common coding */
> +               common_record.source = 0xffff;

For unsupported source value, just bail out and no need to calling
arm_spe__synth_data_source_common().

It is good to use pr_warning_once() to print out warning log to remind
users.

Thanks,
Leo

> +               break;
> +       }
> +
> +       common_record.op = record->op;
> +       arm_spe__synth_data_source_common(&common_record, data_src);
> +}
> +
>  static const struct data_src data_sources[] = {
>         DS(MIDR_ALL_VERSIONS(MIDR_CORTEX_A720), data_source_common),
>         DS(MIDR_ALL_VERSIONS(MIDR_CORTEX_A725), data_source_common),
> @@ -541,6 +579,7 @@ static const struct data_src data_sources[] = {
>         DS(MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2), data_source_common),
>         DS(MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1), data_source_common),
>         DS(MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2), data_source_common),
> +       DS(MIDR_ALL_VERSIONS(MIDR_AMPERE1A), data_source_ampereone),
>         {},
>  };
> 
> --
> 2.47.0
> 
> 
