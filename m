Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4164847F4A;
	Thu,  7 Nov 2024 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993151; cv=none; b=i+U3eDV2Oi6JsSZ4mfZE1gd03VUyBi86NL9eeRu042OljSCmAfqa4Bcy7lZF4TD6C68uLWZnAWELEuEPdiPHHQI9hQI067oGltKfxC9nFO3QQ/dfREkSCdzvDbp/8ISqH76brcCc8L/jLWSEqMbLRMxl3VVCZNV2LU+kDB1OIuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993151; c=relaxed/simple;
	bh=vkwe4yCX40nPbehvzGzQzRGAI5lzgQsdlM7UdgGOLRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLqxW9pVp0S9z8OqoEy6KYB9CuLSVsZeuyOXJoZPaUMIRNA8RIBcWfltw7fm5WeGgPCpboJ6tZi0+JGN2XshSj2Lv/vW6+Z2zOw36UojiPZ5V2PFhGuBETpFF50hmmHBd1LzqW4/xLo9uNibLtvrkbzcXEe8VSkwh8CPQv6r/Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63405497;
	Thu,  7 Nov 2024 07:26:17 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 304C53F66E;
	Thu,  7 Nov 2024 07:25:47 -0800 (PST)
Date: Thu, 7 Nov 2024 15:25:42 +0000
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
Subject: Re: [PATCH v3 1/2] perf arm-spe: Prepare for adding data source
 packet implementations for other cores
Message-ID: <20241107152542.GC47850@e132581.arm.com>
References: <20241106193740.6159-1-ilkka@os.amperecomputing.com>
 <20241106193740.6159-2-ilkka@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106193740.6159-2-ilkka@os.amperecomputing.com>

Hi Ilkka,

This is a good refactoring for me.  Just several minor comments.

On Wed, Nov 06, 2024 at 07:37:39PM +0000, Ilkka Koskinen wrote:
> 
> Split Data Source Packet handling to prepare adding support for
> other implementations.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>  tools/perf/util/arm-spe.c | 65 ++++++++++++++++++++++++---------------
>  1 file changed, 40 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index dbf13f47879c..b222557cc27a 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -103,6 +103,18 @@ struct arm_spe_queue {
>         u32                             flags;
>  };
> 
> +struct data_src {
> +       struct midr_range midr_range;
> +       void (*ds_synth)(const struct arm_spe_record *record,
> +                        union perf_mem_data_src *data_src);
> +};

The naming is a bit mess. The data structure and the parameter both
are called "data_src", though this will not cause building issue.

How about rename the structure "data_src" to "data_source_handle" or
"data_source_class"?

For the "midr_range" field, I'd like to change it to a pointer:

  struct midr_range *midr_range;

Please see below comments, which will present the reason for defining
it as a pointer.

> +
> +#define DS(range, func)                        \
> +       {                                               \
> +               .midr_range = range,                    \
> +               .ds_synth = arm_spe__synth_##func,      \
> +       }
> +
>  static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
>                          unsigned char *buf, size_t len)
>  {
> @@ -430,19 +442,6 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
>         return arm_spe_deliver_synth_event(spe, speq, event, &sample);
>  }
> 
> -static const struct midr_range common_ds_encoding_cpus[] = {
> -       MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
> -       MIDR_ALL_VERSIONS(MIDR_CORTEX_A725),
> -       MIDR_ALL_VERSIONS(MIDR_CORTEX_X1C),
> -       MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
> -       MIDR_ALL_VERSIONS(MIDR_CORTEX_X925),
> -       MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
> -       MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
> -       MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
> -       MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
> -       {},
> -};

We can keep this data structure.  For Ampere CPUs, you can add a new
data structure:

  static const struct midr_range ampereone_ds_encoding_cpus[] = {
      MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
      {},
  };

> -
>  static void arm_spe__sample_flags(struct arm_spe_queue *speq)
>  {
>         const struct arm_spe_record *record = &speq->decoder->record;
> @@ -532,6 +531,19 @@ static void arm_spe__synth_data_source_common(const struct arm_spe_record *recor
>         }
>  }
> 
> +static const struct data_src data_sources[] = {
> +       DS(MIDR_ALL_VERSIONS(MIDR_CORTEX_A720), data_source_common),
> +       DS(MIDR_ALL_VERSIONS(MIDR_CORTEX_A725), data_source_common),
> +       DS(MIDR_ALL_VERSIONS(MIDR_CORTEX_X1C), data_source_common),
> +       DS(MIDR_ALL_VERSIONS(MIDR_CORTEX_X3), data_source_common),
> +       DS(MIDR_ALL_VERSIONS(MIDR_CORTEX_X925), data_source_common),
> +       DS(MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1), data_source_common),
> +       DS(MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2), data_source_common),
> +       DS(MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1), data_source_common),
> +       DS(MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2), data_source_common),
> +       {},
> +};
> +

As a result, we can simplify the structure as:

  static const struct data_src data_sources[] = {
         DS(common_ds_encoding_cpus, data_source_common),
         DS(ampereone_ds_encoding_cpus, data_source_ampereone),
  };

>  static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
>                                         union perf_mem_data_src *data_src)
>  {
> @@ -555,12 +567,14 @@ static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
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
> +       const struct data_src *src = data_sources;
>         u64 *metadata = NULL;
> -       u64 midr = 0;
> +       u64 midr;
> 
>         /* Metadata version 1 assumes all CPUs are the same (old behavior) */
>         if (spe->metadata_ver == 1) {
> @@ -592,18 +606,21 @@ static bool arm_spe__is_common_ds_encoding(struct arm_spe_queue *speq)
>                 midr = metadata[ARM_SPE_CPU_MIDR];
>         }
> 
> -       is_in_cpu_list = is_midr_in_range_list(midr, common_ds_encoding_cpus);
> -       if (is_in_cpu_list)
> -               return true;
> -       else
> -               return false;
> +       while (src->midr_range.model) {
> +               if (is_midr_in_range(midr, &src->midr_range)) {
> +                       src->ds_synth(record, data_src);
> +                       return true;
> +               }
> +               src++;
> +       }

Here we can traverse the 'data_sources' array:

          for (i = 0; i < ARRAY_SIZE(data_sources); i++) {
               if (is_midr_in_range(midr, data_sources[i]->midr_range)) {
                   ...
               }
          }

Thanks,
Leo

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
> @@ -612,9 +629,7 @@ static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
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
