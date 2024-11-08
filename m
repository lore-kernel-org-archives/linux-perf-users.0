Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928D91803A;
	Fri,  8 Nov 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731077440; cv=none; b=KpJRs7yOa35KGhCYIfZAndbchizCX7Ri9Ros/73Wf7HVb15fnT3SgftqKDDoFVJu+i0URXiFRR0RGzlDwek2HzZV41cM/RkxXxIrIwJ7ZGBcR+kDLXzmXhBpeCZil1rJJJnFDGpJ3s7FNlhqCJszYfjnxUvn2TZWA34sKR8luZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731077440; c=relaxed/simple;
	bh=cYlLrsUY4iGPCIaUcUzJv6AHT/fNJRwXt8JMF3mqwj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzjMtlYX9KWFoRYy3Gb03qSM3u0WAEnI/2XpEc0UeOnlLOj327KaLlPOkGdDbk/0CEAsN/UvJOOmH/nCZxYN0BWui1MjeQsriAtahXFK5uEOiyN9/HMbzgnIXzRQTil+MT29c7bSSoNVv/rmxYcNILit24apfIinopIx8AoMyG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8853497;
	Fri,  8 Nov 2024 06:51:07 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95DCB3F528;
	Fri,  8 Nov 2024 06:50:37 -0800 (PST)
Date: Fri, 8 Nov 2024 14:50:35 +0000
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
Subject: Re: [PATCH v4 1/2] perf arm-spe: Prepare for adding data source
 packet implementations for other cores
Message-ID: <20241108145035.GE47850@e132581.arm.com>
References: <20241108010911.58412-1-ilkka@os.amperecomputing.com>
 <20241108010911.58412-2-ilkka@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241108010911.58412-2-ilkka@os.amperecomputing.com>

Hi Ilkka,

On Fri, Nov 08, 2024 at 01:09:10AM +0000, Ilkka Koskinen wrote:
> 
> Split Data Source Packet handling to prepare adding support for
> other implementations.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>  tools/perf/util/arm-spe.c | 42 ++++++++++++++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index dbf13f47879c..dfb0c07cb7fe 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -103,6 +103,18 @@ struct arm_spe_queue {
>         u32                             flags;
>  };
> 
> +struct data_source_handle {
> +       const struct midr_range *midr_ranges;
> +       void (*ds_synth)(const struct arm_spe_record *record,
> +                        union perf_mem_data_src *data_src);
> +};
> +
> +#define DS(range, func)                                        \
> +       {                                               \
> +               .midr_ranges = range,                   \
> +               .ds_synth = arm_spe__synth_##func,      \
> +       }
> +
>  static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
>                          unsigned char *buf, size_t len)
>  {
> @@ -443,6 +455,10 @@ static const struct midr_range common_ds_encoding_cpus[] = {
>         {},
>  };
> 
> +static const struct data_source_handle data_source_handles[] = {
> +       DS(common_ds_encoding_cpus, data_source_common),
> +};
> +

Move this structure under arm_spe__synth_data_source_common(),
otherwise, the building will fail:

  CC      util/arm-spe.o
util/arm-spe.c:115:15: error: ‘arm_spe__synth_data_source_common’ undeclared here (not in a function)
  115 |   .ds_synth = arm_spe__synth_##func, \
      |               ^~~~~~~~~~~~~~~
util/arm-spe.c:464:2: note: in expansion of macro ‘DS’
  464 |  DS(common_ds_encoding_cpus, data_source_common),
      |  ^~

The rest looks good to me.

Thanks,
Leo

>  static void arm_spe__sample_flags(struct arm_spe_queue *speq)
>  {
>         const struct arm_spe_record *record = &speq->decoder->record;
> @@ -555,12 +571,14 @@ static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
>                 data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
>  }
> 
> -static bool arm_spe__is_common_ds_encoding(struct arm_spe_queue *speq)
> +static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
> +                             const struct arm_spe_record *record,
> +                             union perf_mem_data_src *data_src)
>  {
>         struct arm_spe *spe = speq->spe;
> -       bool is_in_cpu_list;
>         u64 *metadata = NULL;
> -       u64 midr = 0;
> +       u64 midr;
> +       unsigned int i;
> 
>         /* Metadata version 1 assumes all CPUs are the same (old behavior) */
>         if (spe->metadata_ver == 1) {
> @@ -592,18 +610,20 @@ static bool arm_spe__is_common_ds_encoding(struct arm_spe_queue *speq)
>                 midr = metadata[ARM_SPE_CPU_MIDR];
>         }
> 
> -       is_in_cpu_list = is_midr_in_range_list(midr, common_ds_encoding_cpus);
> -       if (is_in_cpu_list)
> -               return true;
> -       else
> -               return false;
> +       for (i = 0; i < ARRAY_SIZE(data_source_handles); i++) {
> +               if (is_midr_in_range_list(midr, data_source_handles[i].midr_ranges)) {
> +                       data_source_handles[i].ds_synth(record, data_src);
> +                       return true;
> +               }
> +       }
> +
> +       return false;
>  }
> 
>  static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
>                                       const struct arm_spe_record *record)
>  {
>         union perf_mem_data_src data_src = { .mem_op = PERF_MEM_OP_NA };
> -       bool is_common = arm_spe__is_common_ds_encoding(speq);
> 
>         if (record->op & ARM_SPE_OP_LD)
>                 data_src.mem_op = PERF_MEM_OP_LOAD;
> @@ -612,9 +632,7 @@ static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
>         else
>                 return 0;
> 
> -       if (is_common)
> -               arm_spe__synth_data_source_common(record, &data_src);
> -       else
> +       if (!arm_spe__synth_ds(speq, record, &data_src))
>                 arm_spe__synth_memory_level(record, &data_src);
> 
>         if (record->type & (ARM_SPE_TLB_ACCESS | ARM_SPE_TLB_MISS)) {
> --
> 2.47.0
> 
> 
