Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CEC1803A;
	Fri,  8 Nov 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731077504; cv=none; b=uN8g0GuXwrDZjUnwCHmJD4iyMU3oY78IUTd2KEe81mE8OKJRoagH1xY7TW+IVgNrYdyhLyYL9Mp5oL5YJhl7vPX2yiP3cDW8+pnzZ06Q4QWODbEpbwvuhKcASOsXdKIftCDWai/YwbekH9g/Pt7fSH4IkcYHFhLjLZmnP65cWdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731077504; c=relaxed/simple;
	bh=OKzkZ7t4EcNizG50WiVv/NL13zQwqody8ageGD9SQ3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxL7S4662j6J3dIw8Ty8QHm4WNmlcQbq2CNtLm/YmN9R07DlapO2885VzXcW86tXXfI+e7RcaJitwvAqgyDq4mdk24sxgCXJTwJa5xJD/vhUMP8hPSbF7g4Cm3XFkoF90T/vU5snqKhqTovBTk1aAvf+vP0wifei6db+YZL9gK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 969FD339;
	Fri,  8 Nov 2024 06:52:10 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61A143F66E;
	Fri,  8 Nov 2024 06:51:40 -0800 (PST)
Date: Fri, 8 Nov 2024 14:51:38 +0000
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
Subject: Re: [PATCH v4 2/2] perf arm-spe: Add support for SPE Data Source
 packet on AmpereOne
Message-ID: <20241108145138.GF47850@e132581.arm.com>
References: <20241108010911.58412-1-ilkka@os.amperecomputing.com>
 <20241108010911.58412-3-ilkka@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108010911.58412-3-ilkka@os.amperecomputing.com>

On Fri, Nov 08, 2024 at 01:09:11AM +0000, Ilkka Koskinen wrote:
> 
> Decode SPE Data Source packets on AmpereOne. The field is IMPDEF.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>  .../util/arm-spe-decoder/arm-spe-decoder.h    |  9 ++++
>  tools/perf/util/arm-spe.c                     | 44 +++++++++++++++++++
>  2 files changed, 53 insertions(+)
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
> index dfb0c07cb7fe..df84933b673d 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -455,8 +455,14 @@ static const struct midr_range common_ds_encoding_cpus[] = {
>         {},
>  };
> 
> +static const struct midr_range ampereone_ds_encoding_cpus[] = {
> +       MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
> +       {},
> +};
> +
>  static const struct data_source_handle data_source_handles[] = {
>         DS(common_ds_encoding_cpus, data_source_common),
> +       DS(ampereone_ds_encoding_cpus, data_source_ampereone),
>  };
> 
>  static void arm_spe__sample_flags(struct arm_spe_queue *speq)
> @@ -548,6 +554,44 @@ static void arm_spe__synth_data_source_common(const struct arm_spe_record *recor
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
> +               pr_warning_once("AmpereOne: Unknown data source (0x%x)\n",
> +                               record->source);
> +               return;
> +       }
> +
> +       common_record.op = record->op;
> +       arm_spe__synth_data_source_common(&common_record, data_src);
> +}
> +
>  static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
>                                         union perf_mem_data_src *data_src)
>  {
> --
> 2.47.0
> 
> 
