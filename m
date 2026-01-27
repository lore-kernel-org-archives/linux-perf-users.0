Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F6B346E7D;
	Tue, 27 Jan 2026 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769517481; cv=none; b=tazL9OFqh4vagjr/G9F6C8v4W6uVU9TF2TOoW3+HvQh7wiaNza45g1/szHCaNehnCTC5PLVD0VYqG38w9nsjV+a+Wk8wCEqyV8+dVahUgVd+BkwZgUZscxzXiKmUkpLeQMhhVcTGdmBX/9v6AUIACCfxiyiXBLAynYr3l5Kn/sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769517481; c=relaxed/simple;
	bh=klfkji3dA/BcUEdcu+FxnfdCOIEKdGDNWQxxFEl3RVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeDcNoNRVi8LXgtMptWPgZG5+w3jGAjSQeXJs6WB8Ne/Uh6KUR+Q2kZIWsoD0GReLaec/H3CQi3JZxZHElznF+/Wp+7DpVcEmsyjJexRlATpKQoPAo22HvCFqNcIrQIH3aaOXk9scysy2rsf1TPPqXF0jCOA6SlaCe/8wwP40lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOqlorJa; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOqlorJa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769517480; x=1801053480;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=klfkji3dA/BcUEdcu+FxnfdCOIEKdGDNWQxxFEl3RVo=;
  b=YOqlorJayQI0YpOX5GuAk3afTYJmdYTtCx+NZ8Lu0KMM5LvK1dJNgO6p
   TBVHJfPe5/RK+CioOTI2XJAZDkIYEFCdfSqtNaFfGghIYNfrkZxpTWajc
   k9nMmkMBqvjpW9vgHtNioIAeVfjMRNP4yxwBG0eMTbO5OSVfesYzkpkhQ
   9dW3ubz99WoTzYCrnQNB+wRFAa4TyneIqTMoTtTKcQpjQmGGxibByvvx0
   mU++A50jLoORoMQWymNBGWBIuxz9R0hYJdtX5ts0hFq26RxdWfNBYlqhL
   KBhCAJrafDYcr3jXyDUNkXWxMf8m4vY4HJEOqDehVRm6oI3gQgOx5h2eI
   A==;
X-CSE-ConnectionGUID: 0WsWxFc6SS2P8Nvi5QWC/Q==
X-CSE-MsgGUID: YEswKibAT4+ODRdRIMI5hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70800473"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="70800473"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 04:37:59 -0800
X-CSE-ConnectionGUID: XD0hjFQVSYCELvfSH4zETw==
X-CSE-MsgGUID: i7897sFcR2+Dl89FbwtX+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="207863450"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 04:37:52 -0800
Message-ID: <a97ff1d6-7712-4315-95ff-4079ffc752f7@linux.intel.com>
Date: Tue, 27 Jan 2026 20:37:48 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/3] perf arch: Update arch headers to use relative
 UAPI paths
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>,
 Guo Ren <guoren@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260127070259.2720468-1-dapeng1.mi@linux.intel.com>
 <20260127070259.2720468-2-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260127070259.2720468-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/27/2026 3:02 PM, Dapeng Mi wrote:
> The architectural specific headers perf_regs.h currently rely on the
> host architecture's 'asm/perf_regs.h'. This can lead to compilation
> inconsistencies or failures when including and building perf for a
> target architecture that differs from the host's architecture.
>
> Explicitly point to the UAPI headers within the tools source tree using
> relative paths. This ensures that perf is always built against the
> intended architecture.
>
> No functional changes are intended.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/arch/arm/include/perf_regs.h       | 2 +-
>  tools/perf/arch/arm64/include/perf_regs.h     | 2 +-
>  tools/perf/arch/csky/include/perf_regs.h      | 1 +
>  tools/perf/arch/loongarch/include/perf_regs.h | 2 +-
>  tools/perf/arch/mips/include/perf_regs.h      | 2 +-
>  tools/perf/arch/powerpc/include/perf_regs.h   | 2 +-
>  tools/perf/arch/riscv/include/perf_regs.h     | 2 +-
>  tools/perf/arch/s390/include/perf_regs.h      | 2 +-
>  tools/perf/arch/x86/include/perf_regs.h       | 2 +-
>  9 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/arch/arm/include/perf_regs.h b/tools/perf/arch/arm/include/perf_regs.h
> index 75ce1c370114..20c54766e3a0 100644
> --- a/tools/perf/arch/arm/include/perf_regs.h
> +++ b/tools/perf/arch/arm/include/perf_regs.h
> @@ -4,7 +4,7 @@
>  
>  #include <stdlib.h>
>  #include <linux/types.h>
> -#include <asm/perf_regs.h>
> +#include "../../../../arch/arm/include/uapi/asm/perf_regs.h"
>  
>  void perf_regs_load(u64 *regs);
>  
> diff --git a/tools/perf/arch/arm64/include/perf_regs.h b/tools/perf/arch/arm64/include/perf_regs.h
> index 58639ee9f7ea..372f2565a9dd 100644
> --- a/tools/perf/arch/arm64/include/perf_regs.h
> +++ b/tools/perf/arch/arm64/include/perf_regs.h
> @@ -5,7 +5,7 @@
>  #include <stdlib.h>
>  #include <linux/types.h>
>  #define perf_event_arm_regs perf_event_arm64_regs
> -#include <asm/perf_regs.h>
> +#include "../../../../arch/arm64/include/uapi/asm/perf_regs.h"
>  #undef perf_event_arm_regs
>  
>  void perf_regs_load(u64 *regs);
> diff --git a/tools/perf/arch/csky/include/perf_regs.h b/tools/perf/arch/csky/include/perf_regs.h
> index 076c7746c8a2..9520e6aa319e 100644
> --- a/tools/perf/arch/csky/include/perf_regs.h
> +++ b/tools/perf/arch/csky/include/perf_regs.h
> @@ -7,6 +7,7 @@
>  #include <stdlib.h>
>  #include <linux/types.h>
>  #include <asm/perf_regs.h>

Oops, the above line was not removed. Would remove it in next version.


> +#include "../../../../arch/csky/include/uapi/asm/perf_regs.h"
>  
>  #define PERF_REGS_MASK	((1ULL << PERF_REG_CSKY_MAX) - 1)
>  #define PERF_REGS_MAX	PERF_REG_CSKY_MAX
> diff --git a/tools/perf/arch/loongarch/include/perf_regs.h b/tools/perf/arch/loongarch/include/perf_regs.h
> index 45c799fa5330..b86078a55e90 100644
> --- a/tools/perf/arch/loongarch/include/perf_regs.h
> +++ b/tools/perf/arch/loongarch/include/perf_regs.h
> @@ -4,7 +4,7 @@
>  
>  #include <stdlib.h>
>  #include <linux/types.h>
> -#include <asm/perf_regs.h>
> +#include "../../../../arch/loongarch/include/uapi/asm/perf_regs.h"
>  
>  #define PERF_REGS_MAX PERF_REG_LOONGARCH_MAX
>  
> diff --git a/tools/perf/arch/mips/include/perf_regs.h b/tools/perf/arch/mips/include/perf_regs.h
> index 7082e91e0ed1..66655f0c4fea 100644
> --- a/tools/perf/arch/mips/include/perf_regs.h
> +++ b/tools/perf/arch/mips/include/perf_regs.h
> @@ -4,7 +4,7 @@
>  
>  #include <stdlib.h>
>  #include <linux/types.h>
> -#include <asm/perf_regs.h>
> +#include "../../../../arch/mips/include/uapi/asm/perf_regs.h"
>  
>  #define PERF_REGS_MAX PERF_REG_MIPS_MAX
>  
> diff --git a/tools/perf/arch/powerpc/include/perf_regs.h b/tools/perf/arch/powerpc/include/perf_regs.h
> index 1c66f6ba6773..22b492a3dd58 100644
> --- a/tools/perf/arch/powerpc/include/perf_regs.h
> +++ b/tools/perf/arch/powerpc/include/perf_regs.h
> @@ -4,7 +4,7 @@
>  
>  #include <stdlib.h>
>  #include <linux/types.h>
> -#include <asm/perf_regs.h>
> +#include "../../../../arch/powerpc/include/uapi/asm/perf_regs.h"
>  
>  void perf_regs_load(u64 *regs);
>  
> diff --git a/tools/perf/arch/riscv/include/perf_regs.h b/tools/perf/arch/riscv/include/perf_regs.h
> index d482edb413e5..89d5bbb8d2b8 100644
> --- a/tools/perf/arch/riscv/include/perf_regs.h
> +++ b/tools/perf/arch/riscv/include/perf_regs.h
> @@ -6,7 +6,7 @@
>  
>  #include <stdlib.h>
>  #include <linux/types.h>
> -#include <asm/perf_regs.h>
> +#include "../../../../arch/riscv/include/uapi/asm/perf_regs.h"
>  
>  #define PERF_REGS_MASK	((1ULL << PERF_REG_RISCV_MAX) - 1)
>  #define PERF_REGS_MAX	PERF_REG_RISCV_MAX
> diff --git a/tools/perf/arch/s390/include/perf_regs.h b/tools/perf/arch/s390/include/perf_regs.h
> index 130dfad2b96a..9c95589965fe 100644
> --- a/tools/perf/arch/s390/include/perf_regs.h
> +++ b/tools/perf/arch/s390/include/perf_regs.h
> @@ -3,7 +3,7 @@
>  
>  #include <stdlib.h>
>  #include <linux/types.h>
> -#include <asm/perf_regs.h>
> +#include "../../../../arch/s390/include/uapi/asm/perf_regs.h"
>  
>  void perf_regs_load(u64 *regs);
>  
> diff --git a/tools/perf/arch/x86/include/perf_regs.h b/tools/perf/arch/x86/include/perf_regs.h
> index f209ce2c1dd9..5495e5ca7cdc 100644
> --- a/tools/perf/arch/x86/include/perf_regs.h
> +++ b/tools/perf/arch/x86/include/perf_regs.h
> @@ -4,7 +4,7 @@
>  
>  #include <stdlib.h>
>  #include <linux/types.h>
> -#include <asm/perf_regs.h>
> +#include "../../../../arch/x86/include/uapi/asm/perf_regs.h"
>  
>  void perf_regs_load(u64 *regs);
>  
