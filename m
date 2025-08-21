Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656FF235BE2;
	Thu, 21 Aug 2025 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776310; cv=none; b=nIiArXxbs0JMhSwxJUIlPWJ4aZTq6CgCrNz/iSWsQNSyl8C1u2Y1pu7ouZ/PClwa8wF17tskKdBzD3bQvzKZr3VXSa6h5t3KVKO978QRemFMEwU8dul+hKm9Tj6tMX0TLafI0MOZAkIJ1l1JBwGy9fOf1vb2rdrctrlepO/iLvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776310; c=relaxed/simple;
	bh=dwfFFTxnT3+RxXaGP5LcRR7WXqd3mZLyP67DYAXnMWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+mS39G2f1SzEGTz7el0T2rPezkcd+8elyZTUxbrYjliNbVNQ/ZafM+f4b59+r7P6KP1/3jvVzkOEAbn+xPeThjxWapPIrSKx+MMGE0qUW8BYX3UUeZks9oH9k6nhfJ/rggxN/xmrX5fAYvkH3BXa1tpqRv9+7aidIDl5CKE4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26002152B;
	Thu, 21 Aug 2025 04:38:19 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF6043F58B;
	Thu, 21 Aug 2025 04:38:26 -0700 (PDT)
Date: Thu, 21 Aug 2025 12:38:25 +0100
From: Leo Yan <leo.yan@arm.com>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm64: Sync ESR_ELx_EC_* macros in
 arm64_exception_types.h with esr.h
Message-ID: <20250821113825.GA745271@e132581.arm.com>
References: <20250814151452.618765-2-ysk@kzalloc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814151452.618765-2-ysk@kzalloc.com>

Hi,

On Thu, Aug 14, 2025 at 03:14:53PM +0000, Yunseong Kim wrote:
> Update perf util arm64_exception_types.h to match the exception class
> macros defined in tools/arch/arm64/include/asm/esr.h. This ensures
> consistency between perf tooling and the kernel header definitions for
> ESR_ELx_EC_* values.
> 
> Signed-off-by: Yunseong Kim <ysk@kzalloc.com>

Thanks for working on this.

This patch still misses couple macros, please see below.

> ---
>  tools/perf/arch/arm64/util/arm64_exception_types.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/util/arm64_exception_types.h b/tools/perf/arch/arm64/util/arm64_exception_types.h
> index 27c981ebe401..29931bf19062 100644
> --- a/tools/perf/arch/arm64/util/arm64_exception_types.h
> +++ b/tools/perf/arch/arm64/util/arm64_exception_types.h
> @@ -33,7 +33,7 @@
>  #define ESR_ELx_EC_PAC		(0x09)	/* EL2 and above */
>  /* Unallocated EC: 0x0A - 0x0B */

#define ESR_ELx_EC_OTHER	(0x0A)

>  #define ESR_ELx_EC_CP14_64	(0x0C)
> -/* Unallocated EC: 0x0d */
> +#define ESR_ELx_EC_BTI		(0x0D)
>  #define ESR_ELx_EC_ILL		(0x0E)
>  /* Unallocated EC: 0x0F - 0x10 */
>  #define ESR_ELx_EC_SVC32	(0x11)
> @@ -46,7 +46,10 @@
>  #define ESR_ELx_EC_SYS64	(0x18)
>  #define ESR_ELx_EC_SVE		(0x19)
>  #define ESR_ELx_EC_ERET		(0x1a)	/* EL2 only */
> -/* Unallocated EC: 0x1b - 0x1E */
> +/* Unallocated EC: 0x1B */
> +#define ESR_ELx_EC_FPAC		(0x1C)	/* EL1 and above */
> +#define ESR_ELx_EC_SME		(0x1D)
> +/* Unallocated EC: 0x1E */
>  #define ESR_ELx_EC_IMP_DEF	(0x1f)	/* EL3 only */
>  #define ESR_ELx_EC_IABT_LOW	(0x20)
>  #define ESR_ELx_EC_IABT_CUR	(0x21)
> @@ -55,7 +58,7 @@
>  #define ESR_ELx_EC_DABT_LOW	(0x24)
>  #define ESR_ELx_EC_DABT_CUR	(0x25)
>  #define ESR_ELx_EC_SP_ALIGN	(0x26)
> -/* Unallocated EC: 0x27 */
> +#define ESR_ELx_EC_MOPS		(0x27)
>  #define ESR_ELx_EC_FP_EXC32	(0x28)
>  /* Unallocated EC: 0x29 - 0x2B */
>  #define ESR_ELx_EC_FP_EXC64	(0x2C)

#define ESR_ELx_EC_GCS		(0x2D)

Thanks,
Leo

> -- 
> 2.50.0
> 
