Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16D67A13A;
	Thu, 26 Feb 2026 01:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772071011; cv=none; b=Np9yaqxmKcZayUEEhvc46GYd3tDwfTMKQYiqiEharsKAXPTSfmqGXEJ5sukrerhip8BVzE18ONE7hqAnpZA8ATwa/3kjnQFFslVPyhVzGC7tCOlXWV6dH5dosws7m0Fonpq4HKoDHZDnO5JGMT3/nu8uJfpqMdULZLv7nkcffyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772071011; c=relaxed/simple;
	bh=nzJdK8tcr7sxGJXxcQC78ZGCyn4nQDH3Y027oeH32Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MB+mgZiCFXDkw5JZIbteKWfG8RDZIcNFrxlm3qblAzNAI+p8Yzdg6+/dVPo3PPMQV0vBQRhyNOf3Vsi+h5ns6dgOunqluvQfR+PXz0bTaxoZHMBh8I84mlpqs2fkkP0urwl8ke6a2+gQLRO5K+ogLP6BthNQcNhr5cqqnaR8OoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T80Q5xAK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T80Q5xAK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC993C116D0;
	Thu, 26 Feb 2026 01:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772071011;
	bh=nzJdK8tcr7sxGJXxcQC78ZGCyn4nQDH3Y027oeH32Lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T80Q5xAKA6Bft46H6GctxaadW/7SuRMdgZerUvw1C8dW/iE5DRtpxCdgRZZFwd2KI
	 Fnbetrbyu69qKQoiFAR/6el82OGqi7eATojIEahUC172IDeAvoA6XUIn+yGVcbbU/N
	 zes4S/EHe4ErRNNCEQEmhACWsNHg/nHddP3LZpGMfGEL4hnW9TXYlle7LpO6vzz8wr
	 qBSQ0Qdxso0PmSGGqAbhcnObIIxIvIbxfitmOKjwjanyFxDRJjSyQNqMI36iRqPQqV
	 or71AUZAYgLqAg/Qu9tfMJOVgS601c5dL/5WaH5ubVehURJFWWGmGKOXtXdmVpaSII
	 dwP2TSILYMwcA==
Date: Wed, 25 Feb 2026 17:56:49 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf kvm stat: Fix build error
Message-ID: <aZ-oYb-FDLVT5MGq@google.com>
References: <20260206-perf_fix_kvm_stat_error-v1-1-ad40115876be@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260206-perf_fix_kvm_stat_error-v1-1-ad40115876be@arm.com>

Hi Ian,

On Fri, Feb 06, 2026 at 11:00:20AM +0000, Leo Yan wrote:
> Since commit ceea279f9376 ("perf kvm stat: Remove use of the arch
> directory"), a native build on Arm64 machine reports:
> 
>   util/kvm-stat-arch/kvm-stat-x86.c:7:10: fatal error: asm/svm.h: No such file or directory
>     7 | #include <asm/svm.h>
>       |          ^~~~~~~~~~~
>   compilation terminated.
> 
> The build fails to find x86's asm headers when building for Arm64.  Fix
> this by including asm headers with relative path instead.
> 
> Fixes: ceea279f9376 ("perf kvm stat: Remove use of the arch directory")
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Probably not from this patch, but this change seems to introduce this
error on my i386.

  In file included from util/kvm-stat-arch/kvm-stat-x86.c:4:                      
  /linux/tools/include/../../arch/x86/include/uapi/asm/svm.h:137:32: error: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '18446744073709551615' to '4294967295' [-Werror=overflow]
    137 | #define SVM_EXIT_ERR           -1ull                                    
        |                                ^                                        
  util/kvm-stat-arch/kvm-stat-x86.c:13:1: note: in expansion of macro 'define_exit_reasons_table'
     13 | define_exit_reasons_table(svm_exit_reasons, SVM_EXIT_REASONS);          
        | ^~~~~~~~~~~~~~~~~~~~~~~~~                                               
  /linux/tools/include/../../arch/x86/include/uapi/asm/svm.h:249:11: note: in expansion of macro 'SVM_EXIT_ERR'
    249 |         { SVM_EXIT_ERR,         "invalid_guest_state" }                 
        |           ^~~~~~~~~~~~                                                  
  util/kvm-stat-arch/kvm-stat-x86.c:13:45: note: in expansion of macro 'SVM_EXIT_REASONS'
     13 | define_exit_reasons_table(svm_exit_reasons, SVM_EXIT_REASONS);          
        |                                             ^~~~~~~~~~~~~~~~     

Thanks,
Namhyung

> ---
>  tools/perf/util/kvm-stat-arch/kvm-stat-x86.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
> index 1cf541385a4bdee4930b67a054906ccade7301fd..43275d25b6cbccc477ba45a901d69c67422847ae 100644
> --- a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
> +++ b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
> @@ -4,9 +4,9 @@
>  #include "../kvm-stat.h"
>  #include "../evsel.h"
>  #include "../env.h"
> -#include <asm/svm.h>
> -#include <asm/vmx.h>
> -#include <asm/kvm.h>
> +#include "../../arch/x86/include/uapi/asm/svm.h"
> +#include "../../arch/x86/include/uapi/asm/vmx.h"
> +#include "../../arch/x86/include/uapi/asm/kvm.h"
>  #include <subcmd/parse-options.h>
>  
>  define_exit_reasons_table(vmx_exit_reasons, VMX_EXIT_REASONS);
> 
> ---
> base-commit: 84cb36da81413c2dff805150b9f4db1524460269
> change-id: 20260206-perf_fix_kvm_stat_error-a795a1dd67a2
> 
> Best regards,
> -- 
> Leo Yan <leo.yan@arm.com>
> 
