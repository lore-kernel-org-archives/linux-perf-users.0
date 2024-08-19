Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B8249620;
	Mon, 19 Aug 2024 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089485; cv=none; b=qtUQFTwjoKwyTd0zTDdyu/lPrVQctvpveh/UnST+18tzkrxwpoRBjYhNJxPyspjGR2sPp1juWMMyibK6ZMMhFVu95a4UK8SiUbrFAbfEkThJ4AUKitHLYhNYv97Bo3YQWnS+rmDBswqe1FpNVNc6sj2RURmUJOQnzlOBjxuqw4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089485; c=relaxed/simple;
	bh=wLz/Sv1y9wkxu7Yvu+meUK41WhTaxmYen17K3EEOzxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/xDjJeWWiv01XWHsd0FkTqkDT6zHG+aJmWWhtKcYlUVuXVoxByADJzwujoRPpG79DmIGi86tqTguARQXS2G6GWNKGE5dxv/RfF0QtkEAXFaf+4M1wdw3l7ZjxgRYtJBSn8/ZdULZgagsYB8EGZAw8EfFWNqkooOkyl8yIS9bmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/j4/S76; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/j4/S76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D14EC32782;
	Mon, 19 Aug 2024 17:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724089484;
	bh=wLz/Sv1y9wkxu7Yvu+meUK41WhTaxmYen17K3EEOzxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n/j4/S76VQZWS+8jI50CqeQCTTy+aJLlLfk3tavc+e7LM1ZxvRFWz8kEy+BqBevPx
	 4+9KueDrFFmaQFcUpIoQM7dwseGxPlbIDqVLYdeZG4Ay1I28GKf4nQ3emUVeM70+c1
	 6a1NSRQqHGRoK9BF/Nv1nofXGbtgmBVE9XDg3wVbKIeeNwysIGnvqlzhWY7EKxPd+m
	 mklT40HlRglSGGe+FqX9OsY9QDYKxDOuZfmbtq4LwBgsfKGzbWQyru8spqRsqrl3q/
	 dfwRI+TyV+qvGV1KeUalsGWgBSvN47cUbqaz8zWB0Qy/y8mwIZiqXmlUfBt1oueOxs
	 0DO7clqcuORUA==
Date: Mon, 19 Aug 2024 14:44:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2] perf python: include "util/sample.h"
Message-ID: <ZsOEifE05otnUtdV@x1>
References: <20240819023403.201324-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240819023403.201324-1-xu.yang_2@nxp.com>

On Mon, Aug 19, 2024 at 10:34:03AM +0800, Xu Yang wrote:
> The 32-bit arm build system will complain:
> 
> tools/perf/util/python.c:75:28: error: field ‘sample’ has incomplete type
>    75 |         struct perf_sample sample;
> 
> However, arm64 build system doesn't complain this.
> 
> The root cause is arm64 define "HAVE_KVM_STAT_SUPPORT := 1" in
> tools/perf/arch/arm64/Makefile, but arm arch doesn't define this.
> This will lead to kvm-stat.h include other header files on arm64 build
> system, especially "util/sample.h" for util/python.c.
> 
> This will try to directly include "util/sample.h" for "util/python.c" to
> avoid such build issue on arm platform.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v2:
>  - include "util/sample.h" in "util/python.c"

Thanks, applied to perf-tools-next,

- Arnaldo
> ---
>  tools/perf/util/python.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 3be882b2e845..31a223eaf8e6 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -20,6 +20,7 @@
>  #include "util/env.h"
>  #include "util/kvm-stat.h"
>  #include "util/kwork.h"
> +#include "util/sample.h"
>  #include "util/lock-contention.h"
>  #include <internal/lib.h>
>  #include "../builtin.h"
> -- 
> 2.34.1
