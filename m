Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D847082E;
	Fri, 25 Oct 2024 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867392; cv=none; b=KhlpvbgCvzGNSZjQxl21FU8r7u2nao2903i7Gd6P8IQ7F2+mKtjdlgm0k0VIIDnOINV86CEj8afOgP40RslxYyY4EN5MLo4AA5GmWEkzpt7ajy5bf+WUSn856WjNgvk17DU6nopn4U1iCxCjqGWV1TH3+phy9HYrWw32kCvNhsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867392; c=relaxed/simple;
	bh=k4I9XpnqbARW/+7r12tOJu7JxZJbIIuwlFukKUovLzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XArtcyR3j+TefPdCtCRjxhyXjcJ8gCY5+dY1v8flfJMUoHXPsuyHi1DvUioBTTCfBDo7LSrDUY0RxukV0nsI+aThXjXxi7oqJT0BkhdWpGM+N1IOO26dfVviIKOxkMZ91lv3ix/l34L24j0tqIOUGjZULEnF6+boLjGMZOs2Z+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35D72339;
	Fri, 25 Oct 2024 07:43:39 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1769C3F73B;
	Fri, 25 Oct 2024 07:43:08 -0700 (PDT)
Date: Fri, 25 Oct 2024 15:43:03 +0100
From: Leo Yan <leo.yan@arm.com>
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf arm-spe: Add support for SPE Data Source packet on
 AmpereOne
Message-ID: <20241025144303.GC359792@e132581.arm.com>
References: <20241024233035.7979-1-ilkka@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024233035.7979-1-ilkka@os.amperecomputing.com>

On Thu, Oct 24, 2024 at 11:30:35PM +0000, Ilkka Koskinen wrote:
> 
> Decode SPE Data Source packets on AmpereOne. The field is IMPDEF.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>  .../util/arm-spe-decoder/arm-spe-decoder.h    |  9 +++
>  tools/perf/util/arm-spe.c                     | 61 +++++++++++++++++++
>  2 files changed, 70 insertions(+)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index 1443c28545a9..e4115b1e92b2 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -67,6 +67,15 @@ enum arm_spe_neoverse_data_source {
>         ARM_SPE_NV_DRAM          = 0xe,
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
> index 138ffc71b32d..04bd21ad7ea8 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -515,10 +515,69 @@ static void arm_spe__synth_data_source_generic(const struct arm_spe_record *reco
>                 data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
>  }
> 
> +static const struct midr_range ampereone_source_spe[] = {
> +       MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
> +       {},
> +};
> +
> +static void arm_spe__synth_data_source_ampereone(const struct arm_spe_record *record,
> +                                                union perf_mem_data_src *data_src,
> +                                                u64 midr)
> +{
> +       if (!is_midr_in_range_list(midr, ampereone_source_spe)) {
> +               arm_spe__synth_data_source_generic(record, data_src);
> +               return;
> +       }

With James' suggestion, I don't think here need to check the CPU
variant again.  All generic data source generating should run in the 
arm_spe__synth_data_source() function.

> +
> +       if (record->op & ARM_SPE_OP_ST) {
> +               data_src->mem_lvl = PERF_MEM_LVL_NA;
> +               data_src->mem_lvl_num = PERF_MEM_LVLNUM_NA;
> +               data_src->mem_snoop = PERF_MEM_SNOOP_NA;
> +               return;
> +       }
> +
> +       switch (record->source) {
> +       case ARM_SPE_AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE:
> +               data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
> +               data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
> +               data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> +               break;
> +       case ARM_SPE_AMPEREONE_SLC:
> +               data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
> +               data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> +               data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
> +               break;
> +       case ARM_SPE_AMPEREONE_REMOTE_CHIP_CACHE:
> +               data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1;
> +               data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> +               data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
> +               data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> +               break;
> +       case ARM_SPE_AMPEREONE_DDR:
> +               data_src->mem_lvl = PERF_MEM_LVL_LOC_RAM | PERF_MEM_LVL_HIT;
> +               data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;
> +               data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> +               break;
> +       case ARM_SPE_AMPEREONE_L1D:
> +               data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
> +               data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
> +               data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> +               break;
> +       case ARM_SPE_AMPEREONE_L2D:
> +               data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
> +               data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
> +               data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> +               break;

We have another way to do this.  If convert the SoC specific data source
to common data source values, e.g.

  ARM_SPE_AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE -> ARM_SPE_NV_PEER_CORE
  ARM_SPE_AMPEREONE_SLC -> ARM_SPE_NV_SYS_CACHE
  ARM_SPE_AMPEREONE_REMOTE_CHIP_CACHE -> ARM_SPE_NV_REMOTE
  ARM_SPE_AMPEREONE_DDR -> ARM_SPE_NV_DRAM
  ...

Then we don't need to maintain two functions with almost same setting.

I have no strong opinion for this. A dedicated function for Ampere CPU
might give a bit flexiblity for later tweaking. It is up to you.

Last thing, please work on the the latest perf-tools-next branch:

  https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
  branch: perf-tools-next

Recently we have Arm SPE data source refactoring, please rebase on it.

Thanks,
Leo

> +       default:
> +               break;
> +       }
> +}
> +
>  static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 midr)
>  {
>         union perf_mem_data_src data_src = { .mem_op = PERF_MEM_OP_NA };
>         bool is_neoverse = is_midr_in_range_list(midr, neoverse_spe);
> +       bool is_ampereone = (read_cpuid_implementor() == ARM_CPU_IMP_AMPERE);
> 
>         if (record->op & ARM_SPE_OP_LD)
>                 data_src.mem_op = PERF_MEM_OP_LOAD;
> @@ -529,6 +588,8 @@ static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 m
> 
>         if (is_neoverse)
>                 arm_spe__synth_data_source_neoverse(record, &data_src);
> +       else if (is_ampereone)
> +               arm_spe__synth_data_source_ampereone(record, &data_src, midr);
>         else
>                 arm_spe__synth_data_source_generic(record, &data_src);
> 
> --
> 2.47.0
> 
> 
