Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3833425F984;
	Tue, 26 May 2026 00:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779755717; cv=none; b=WXyTtSAw3DpDHSTjbKPpRtopi5tJXJB9Yk4db1YNH0lKR0GCKtNEeUKiBiEckBfPPrbKI2xNgJ4oQrAjR6AwhlJzrEy8BqSqwljv6/2hvlVL7fzgFJBIAkJHqaavLmD+RVhS2TtCZnc+7ZWIPEZqEHxHN/QKQblLnlfF456C2RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779755717; c=relaxed/simple;
	bh=NyaySlMq4fPWbuHlv/eTAYBexZwVfwuhDJn5BmNNvxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2ORdUhuePmHeXAlLHCTZLPhI5avcb3dZDzt0unJiZY4vXxK7McEVD2PalrKSGK9OJCfoM5qMURrzVfy6iZyaFUQcYZdGn4oeH1rbgwvFYuQxbju9uexNw0zb8Fpzb5fRfbxBtrSSCPok4UAb2TXTDcz5+NxImGHA0PKX9oJ1iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAkP6SUz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAkP6SUz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97A71F000E9;
	Tue, 26 May 2026 00:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779755715;
	bh=LsxWkMmDM5b7XJHZjFJBYku1/ogQ/3//LWB7vEI+twI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZAkP6SUzZFl8T/BBdwDVGvpefVXJFa4oDSLVSU1+lJNQLZnBYq4Ob4dYEHWynFtAg
	 pcU3vNbCSXGmu2p0x4YT2hxelyblrcAh7ub9Srw7sOfwLBC5/nvgp+wQgmE7+3VPtM
	 Oq8b8IXXQFuQsITYmkW2RV2PduzWCJwsEbCOOTkPCn8BcNidNgreiw6JQe6r1XLUwV
	 CDTiwYYRBQTteqKc1TCUlV72LbmhYw/RUZIr7NiS70wOQHvOISU/nIfX7EA545Af0Y
	 kZ966788JTKt6W+Fz48TeMEJsyJiaz3Gm/8GdzQh65EHe4/WaAbSH0JpSYMLn8R3Q3
	 ujHTP3F6onPYw==
Date: Mon, 25 May 2026 19:35:12 -0500
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com,
	dapeng1.mi@linux.intel.com, james.clark@linaro.org,
	leo.yan@linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v9 03/23] perf tests: Sort includes and add missed
 explicit dependencies
Message-ID: <ahTqwPZJ2Q9vCPzZ@google.com>
References: <20260428071903.1886173-1-irogers@google.com>
 <20260522220435.2378363-1-irogers@google.com>
 <20260522220435.2378363-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260522220435.2378363-4-irogers@google.com>

On Fri, May 22, 2026 at 03:04:14PM -0700, Ian Rogers wrote:
> Fix missing #includes found while cleaning the evsel/evlist header
> files. Sort the remaining header files for consistency with the rest
> of the code.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/tests/hwmon_pmu.c  | 14 +++++++++-----
>  tools/perf/tests/mmap-basic.c | 18 +++++++++++-------
>  2 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
> index 4aa4aac94f09..ada6e445c4c4 100644
> --- a/tools/perf/tests/hwmon_pmu.c
> +++ b/tools/perf/tests/hwmon_pmu.c
> @@ -1,15 +1,19 @@
>  // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> -#include "debug.h"
> -#include "evlist.h"
>  #include "hwmon_pmu.h"
> -#include "parse-events.h"
> -#include "tests.h"
> +
>  #include <errno.h>
> +
>  #include <fcntl.h>
> -#include <sys/stat.h>
>  #include <linux/compiler.h>
>  #include <linux/kernel.h>
>  #include <linux/string.h>
> +#include <sys/stat.h>
> +
> +#include "debug.h"
> +#include "evlist.h"
> +#include "parse-events.h"
> +#include "pmus.h"
> +#include "tests.h"
>  
>  static const struct test_event {
>  	const char *name;
> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> index a18d84d858aa..a69cd1046e9a 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -1,25 +1,29 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <errno.h>
> -#include <fcntl.h>
>  #include <inttypes.h>
>  #include <stdlib.h>
> +
> +#include <fcntl.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +
>  #include <perf/cpumap.h>
> +#include <perf/evlist.h>
> +#include <perf/mmap.h>
>  
>  #include "cpumap.h"
>  #include "debug.h"
>  #include "event.h"
>  #include "evlist.h"
>  #include "evsel.h"
> -#include "thread_map.h"
> +#include "pmu.h"
> +#include "pmus.h"
>  #include "tests.h"
> +#include "thread_map.h"
>  #include "util/affinity.h"
>  #include "util/mmap.h"
>  #include "util/sample.h"
> -#include <linux/err.h>
> -#include <linux/kernel.h>
> -#include <linux/string.h>
> -#include <perf/evlist.h>
> -#include <perf/mmap.h>
>  
>  /*
>   * This test will generate random numbers of calls to some getpid syscalls,
> -- 
> 2.54.0.794.g4f17f83d09-goog
> 
