Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB55E41877
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 20:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3ZLEOI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D950C433C7;
	Wed,  6 Dec 2023 20:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701895131;
	bh=cQz7nqAhJZLeNLfbhuwDJLQndqN6EGPd06sE/qHTxl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a3ZLEOI6PlyPKjcBOzbvg/uWztpxbKN5SsnZQQ0mKemEGbPgXokQ796Pi+GsuTCs4
	 K1XZeQgGkhlSUs0ryripNmigxDsf5W2ZLO82+jbRHd8dmyUL5WLYaAir2w9hB6h8un
	 ViRMa7bySqAP2uONoVEX22zWsUrOvdB1NOrqA05rmJs5RBadH8V6DA/RMc5sJz3746
	 /+pcGNJEnzBl9jezENsKgt4p/xtynH/P0qiKYxmWthtAARxRgRwpoDqP6qqYJsDWxb
	 uJ5YYV+0bG/Y3Ul4lXZkzQOnx9cjHCor6KyZTctKAmGquJAqfLe5h8NgC2GXraZ0e2
	 WifWGUersqUDw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 2A44B403EF; Wed,  6 Dec 2023 17:38:48 -0300 (-03)
Date: Wed, 6 Dec 2023 17:38:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: kan.liang@linux.intel.com
Cc: irogers@google.com, peterz@infradead.org, mingo@redhat.com,
	namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	john.g.garry@oracle.com, will@kernel.org, james.clark@arm.com,
	mike.leach@linaro.org, leo.yan@linaro.org,
	yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	tmricht@linux.ibm.com, ravi.bangoria@amd.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] perf mem: Remove useless header files for X86
Message-ID: <ZXDb2Gs1ECjejSbn@kernel.org>
References: <20231206201324.184059-1-kan.liang@linux.intel.com>
 <20231206201324.184059-7-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206201324.184059-7-kan.liang@linux.intel.com>
X-Url: http://acmel.wordpress.com

Em Wed, Dec 06, 2023 at 12:13:24PM -0800, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The X86 mem-events.c only has perf_mem_events array now. Remove useless
> header files.

It would be great that those were removed while you made the cleanups,
i.e. removed the need for one of them, remove it together with the
refactorings, etc.

But I don't think this is a requirement, just would make it cleaner.

Will wait for reviews now.

- Arnaldo
 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/mem-events.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
> index 71ffe16de751..62df03e91c7e 100644
> --- a/tools/perf/arch/x86/util/mem-events.c
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -1,11 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include "util/pmu.h"
> -#include "util/pmus.h"
> -#include "util/env.h"
> -#include "map_symbol.h"
> -#include "mem-events.h"
>  #include "linux/string.h"
> -#include "env.h"
> +#include "util/map_symbol.h"
> +#include "util/mem-events.h"
> +#include "mem-events.h"
> +
>  
>  #define MEM_LOADS_AUX		0x8203
>  
> -- 
> 2.35.1
> 

-- 

- Arnaldo
