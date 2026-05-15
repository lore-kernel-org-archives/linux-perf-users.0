Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C13938D3E4;
	Fri, 15 May 2026 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872986; cv=none; b=IaT1mEChHAmuCPzENoqXDT359IuTVZ+KJv7f33J6KNKBTzh71KcJR0MxcFECJ6kbdGKx8qClXeZUIFzzY6kTlhMPtNCKarkpdDPWGNEoxzq7JBY/+fyjkuQSDenQ9p4VzQ8+YSFCFnvF5XRe+CdRPFmck/Nns1rUlTA5pBMVsCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872986; c=relaxed/simple;
	bh=rXrB5o+6rkXZT2JMvoo5wjhRNclAQqhZfhQ8nzbLo+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjqp+MY+PO2FYZiGBhCMLxWGTPyr+M5SvLK2nIm0Bv3R7pCFFnA2FExTh344GAapib//Vy2AfrfZ3vmjg0OUYv1BkFSjfftdhZZg4LRRNjS+qtQEo+hHWCF0vaZznwS8L048hKJK2lagC7+twF6C0GLs2qbtjrGhEb+5IufOqxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/WA/N4r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/WA/N4r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307ADC2BCB0;
	Fri, 15 May 2026 19:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778872985;
	bh=rXrB5o+6rkXZT2JMvoo5wjhRNclAQqhZfhQ8nzbLo+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/WA/N4r5rSx+OuM+K9jt7MzFmS/gWxdrwn7IeTlyv3ItM4HJchKbCCMDnJsClmiC
	 O6chCr5oLBFovafc3glQjjdi8s537VNJWH+1GXK2TIMC2AwXxi8kyvY6C2zDwGGMKx
	 oc3/OCOKwpy3dQUumtfwfor7x1XCQKMvCMYHs/3zc2Tprp4C95oym5YMDRX7OV2qq6
	 P0gy8tPydRF5Acnp1NJ3+dxVry0WQIphXmqZCWJDkxZZkFp4wIrkzec9Pjm3u/p+m9
	 ZPh0qZfvJCttFifgZTWakzsrl4eflaUXR6XOZ62hJ813bVrHj0NlQlwEIgHSJ4/+nJ
	 uHVi19JmuoaiA==
Date: Fri, 15 May 2026 16:23:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com,
	james.clark@linaro.org, namhyung@kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Li Guan <guanli.oerv@isrc.iscas.ac.cn>, 9erthalion6@gmail.com,
	alex@ghiti.fr, alexander.shishkin@linux.intel.com,
	andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu,
	atrajeev@linux.ibm.com, howardchu95@gmail.com,
	john.g.garry@oracle.com, jolsa@kernel.org, leo.yan@linux.dev,
	libunwind-devel@nongnu.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org, mingo@redhat.com,
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
	shimin.guo@skydio.com, tglozar@redhat.com, tmricht@linux.ibm.com,
	will@kernel.org
Subject: Re: [PATCH v5 4/7] perf unwind-libunwind: Make libunwind register
 reading cross platform
Message-ID: <agdyluuau3wPQOtX@x1>
References: <20260413024805.1316480-1-irogers@google.com>
 <20260513233151.572332-1-irogers@google.com>
 <20260513233151.572332-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513233151.572332-5-irogers@google.com>

On Wed, May 13, 2026 at 04:31:48PM -0700, Ian Rogers wrote:
> --- /dev/null
> +++ b/tools/perf/util/libunwind-arch/libunwind-ppc32.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include "libunwind-arch.h"
> +#include "../debug.h"
> +#include "../../../arch/powerpc/include/uapi/asm/perf_regs.h"
> +#include <linux/compiler.h>
> +#include <errno.h>
> +
> +#ifdef HAVE_LIBUNWIND_PPC32_SUPPORT
> +#include <libunwind-ppc32.h>
> +#endif
> +
> +int __get_perf_regnum_for_unw_regnum_ppc32(int unw_regnum __maybe_unused)
> +{
> +#ifndef HAVE_LIBUNWIND_PPC32_SUPPORT
> +	return -EINVAL;
> +#else
> +	switch (unw_regnum) {
> +	case UNW_PPC32_R0 ... UNW_PPC32_R31:
> +		return unw_regnum - UNW_PPC32_R0 + PERF_REG_POWERPC_R0;
> +	case UNW_PPC32_LR:
> +		return PERF_REG_POWERPC_LINK;
> +	case UNW_PPC32_CTR:
> +		return PERF_REG_POWERPC_CTR;
> +	case UNW_PPC32_XER:
> +		return PERF_REG_POWERPC_XER;
> +	default:
> +		pr_err("unwind: invalid reg id %d\n", unw_regnum);
> +		return -EINVAL;
> +	}
> +#endif // HAVE_LIBUNWIND_PPC32_SUPPORT

To address this local sashiko comment:

------------------------------------------------------------
Is the instruction pointer (NIP) intentionally omitted from this switch
statement?

When libunwind attempts to read the instruction pointer, will access_reg()
hit the default case here and return -EINVAL, causing stack unwinding
to fail on 32-bit PowerPC architectures?
For comparison, the 64-bit implementation in libunwind-ppc64.c correctly
maps UNW_PPC64_NIP to PERF_REG_POWERPC_NIP.
------------------------------------------------------------

I ammended this patch with:

⬢ [acme@toolbx perf-tools-next]$ vim tools/perf/util/libunwind-arch/libunwind-ppc32.c
⬢ [acme@toolbx perf-tools-next]$ git diff
diff --git a/tools/perf/util/libunwind-arch/libunwind-ppc32.c b/tools/perf/util/libunwind-arch/libunwind-ppc32.c
index bcdeed34d0a81b8d..976a160304073582 100644
--- a/tools/perf/util/libunwind-arch/libunwind-ppc32.c
+++ b/tools/perf/util/libunwind-arch/libunwind-ppc32.c
@@ -23,6 +23,8 @@ int __get_perf_regnum_for_unw_regnum_ppc32(int unw_regnum __maybe_unused)
                return PERF_REG_POWERPC_CTR;
        case UNW_PPC32_XER:
                return PERF_REG_POWERPC_XER;
+       case UNW_PPC32_NIP:
+               return PERF_REG_POWERPC_NIP;
        default:
                pr_err("unwind: invalid reg id %d\n", unw_regnum);
                return -EINVAL;
⬢ [acme@toolbx perf-tools-next]$

Ok? It was the only issue found in this patch.

- Arnaldo
