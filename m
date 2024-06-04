Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377FF1428F5;
	Tue,  4 Jun 2024 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492290; cv=none; b=Ck1EhbCXiHgbB/S2zIOKVIGWyplghPOGQLsi4ejMpdrSku6483NGgVWOkuctTv/r6riCTG6jLtaw9LHMeH1me+oXwed2wTIYT6tU9UblqCd8dSL7B7fFBdzTOiLYpY4qJ1u9U8AaTRbJNCpNzx2aClFDA0Z1TgAIIIsCL8Hjrk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492290; c=relaxed/simple;
	bh=zPO+/aKjmZiAU7rnr7JcIcsudeId+P/k7gqQdD755KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQAjgeC5kzmzDylotS2/cTduAQa2b6fFid5MVkSi9ap554zytp4o5PXFR4ae0N9NYHvHT03JbWZQGQZpXkFmnBcwKo7dhR1f0NwGhH7aCqt9pKNtAmMYHJKHaRpBCSoE9L1QWta3w3HPkBufOsmx0ky69ytXYoKeAReQoBCg42Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE33B1042;
	Tue,  4 Jun 2024 02:11:51 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83D9B3F762;
	Tue,  4 Jun 2024 02:11:25 -0700 (PDT)
Date: Tue, 4 Jun 2024 10:11:22 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Besar Wicaksono <bwicaksono@nvidia.com>, Will Deacon <will@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC/PATCH 1/1] tools headers arm64: Sync arm64's cputype.h with
 the kernel sources
Message-ID: <Zl7aOk2h4_73JmUu@J2N7QTR9R3>
References: <Zl4MYzhP0NB-Z1DW@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl4MYzhP0NB-Z1DW@x1>

Hi Arnaldo,

On Mon, Jun 03, 2024 at 03:33:07PM -0300, Arnaldo Carvalho de Melo wrote:
> To get the changes in:
> 
>   0ce85db6c2141b7f ("arm64: cputype: Add Neoverse-V3 definitions")
>   02a0a04676fa7796 ("arm64: cputype: Add Cortex-X4 definitions")
>   f4d9d9dcc70b96b5 ("arm64: Add Neoverse-V2 part")

As a heads-up, there are likely to be a couple more updates here
shortly:

  https://lore.kernel.org/linux-arm-kernel/20240603111812.1514101-1-mark.rutland@arm.com/

> That makes this perf source code to be rebuilt:
> 
>   CC      /tmp/build/perf-tools/util/arm-spe.o
> 
> The changes in the above patch add MIDR_NEOVERSE_V[23] and
> MIDR_NEOVERSE_V1 is used in arm-spe.c, so probably we need to add those
> and perhaps MIDR_CORTEX_X4 to that array? Or maybe we need to leave this
> for later when this is all tested on those machines?

Hmm... looking at where that was added this is somewhat misnamed, this
is really saying that these cores use the same IMPLEMENTATION DEFINED
encoding of the source field. That's not really a property of Neoverse
specifically, and I'm not sure what Arm's policy is here going forwards.

We should probably rename that to something like
common_data_source_encoding, with a big comment about exactly what it
implies.

I would not touch this for now -- someone would have to go audit the
TRMs to check that those other cores have the same encoding, and I think
it'd be better to do that as a follow-up.

The relevant commit was:

  4e6430cbb1a9f1dc ("perf arm-spe: Use SPE data source for neoverse cores")

Mark.

>   static const struct midr_range neoverse_spe[] = {
>           MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
>           MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
>           MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
>           {},
>   };
> 
> That addresses this perf build warning:
> 
>   Warning: Kernel ABI header differences:
>     diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Besar Wicaksono <bwicaksono@nvidia.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/arch/arm64/include/asm/cputype.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
> index 52f076afeb96006c..7b32b99023a21d3a 100644
> --- a/tools/arch/arm64/include/asm/cputype.h
> +++ b/tools/arch/arm64/include/asm/cputype.h
> @@ -86,6 +86,9 @@
>  #define ARM_CPU_PART_CORTEX_X2		0xD48
>  #define ARM_CPU_PART_NEOVERSE_N2	0xD49
>  #define ARM_CPU_PART_CORTEX_A78C	0xD4B
> +#define ARM_CPU_PART_NEOVERSE_V2	0xD4F
> +#define ARM_CPU_PART_CORTEX_X4		0xD82
> +#define ARM_CPU_PART_NEOVERSE_V3	0xD84
>  
>  #define APM_CPU_PART_XGENE		0x000
>  #define APM_CPU_VAR_POTENZA		0x00
> @@ -159,6 +162,9 @@
>  #define MIDR_CORTEX_X2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X2)
>  #define MIDR_NEOVERSE_N2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N2)
>  #define MIDR_CORTEX_A78C	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78C)
> +#define MIDR_NEOVERSE_V2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V2)
> +#define MIDR_CORTEX_X4 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X4)
> +#define MIDR_NEOVERSE_V3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3)
>  #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
>  #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
>  #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
> -- 
> 2.44.0
> 
