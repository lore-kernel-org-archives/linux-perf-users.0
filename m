Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFAF192D97;
	Mon, 16 Mar 2026 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658964; cv=none; b=r7vSviPtL1fhvYfk8NU1Es3o6WG5vnEb54lEipan4tBKN/lfoWrYjp9ynoHnRAsTNPT3JWgNDmluF2oFfp0awcWSucmIKHOrZOHDpyiYhxdy7xFKIfwYl+Ll4OvtFyiIlwg28foKgWbY3vN9ZdsasGO7Pqa2BnzeHCQpIueWRfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658964; c=relaxed/simple;
	bh=RJTSTYRNVg76hA91dQ7Nc71iNQHSDgu+fXxMVMy6LNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qc9tdKdt8XLgYdzABgGPXT+0AGK0nihiJDXDruuPelRa9P42bQ/HABkVT9hsBnpnMfNwbqRhiGWBevpFb3wERJg5IJbSGEFETMjgbgdns4vq0U5Gy/7RTQiypsDuo9LvFRMZI4SeT/KaEbYJG1c1Xzg/jIsld4OuA2ZgiisKcZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D75B41477;
	Mon, 16 Mar 2026 04:02:35 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26E543F73B;
	Mon, 16 Mar 2026 04:02:40 -0700 (PDT)
Date: Mon, 16 Mar 2026 11:02:36 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools headers: Skip arm64 cputype.h check
Message-ID: <abfjTHwrHWaUiEY0@J2N7QTR9R3>
References: <20260316-tools_remove_sync_cputype-h-v1-1-9f0dc5931f09@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316-tools_remove_sync_cputype-h-v1-1-9f0dc5931f09@arm.com>

On Mon, Mar 16, 2026 at 10:57:55AM +0000, Leo Yan wrote:
> Some definitions in the arm64 kernel's cputype.h are kernel specific and
> cause perf build failures when the header is synced into tools.
> 
> Stop checking arm64's cputype.h.  In the future, the header in tools
> will be updated manually as needed.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>

I think it might be worth stating explicitly that we only need to update
this header when teaching the perf tool about new CPUs, but with or
without that wording:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  tools/perf/check-headers.sh | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index da3aca87457fdc56c96d4184f2dee88dab026d98..31826621eebdb003d0fd681ae89822225dda966f 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -187,7 +187,6 @@ done
>  check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memcpy_\(erms\|orig\))" -I"^#include <linux/cfi_types.h>"'
>  check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
>  check arch/x86/include/asm/amd/ibs.h  '-I "^#include .*/msr-index.h"'
> -check arch/arm64/include/asm/cputype.h '-I "^#include [<\"]\(asm/\)*sysreg.h"'
>  check include/linux/unaligned.h '-I "^#include <linux/unaligned/packed_struct.h>" -I "^#include <asm/byteorder.h>" -I "^#pragma GCC diagnostic"'
>  check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common\(-tools\)*.h>"'
>  check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
> 
> ---
> base-commit: bb551508e78c886e6d3bcca6c744d3bc3fd8ad59
> change-id: 20260316-tools_remove_sync_cputype-h-2b0de59d5de5
> 
> Best regards,
> -- 
> Leo Yan <leo.yan@arm.com>
> 
