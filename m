Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7E8368D73;
	Thu, 10 Sep 2026 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049334; cv=none; b=nvwpKcC9MQcZQgqf068/WOuC4GSwz9PjZOgXxkU/C2vgADgKCAIzUgrOKl4C9rH9TbitZkyWeYO5qwKohyaqptjF36rkeoo8bUf+8faVxEA+4JvPg8v4xKe5TVT5Dpdd9f+YtMyJZbfWAq7zDsnUZxhnUz/O7Vm8dyklYC7WcN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049334; c=relaxed/simple;
	bh=U/sFd/xPT8dpY4hpqtlUd/2PB3YNk6p6UeOJMmOXOXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwSj1OV238uCDMG0oqKCu3YHrcMwG/joEirStb7nfCJMAuJLZZjY6s3lursPmYIVD32HibDl4+I2Y5MEmpbXA4wIITvAirPqQZmb0sZZ3kMKKMmI+wk64ierdKAxGAcOqpCwsNGB/tjcrJT8As0BTRMk+pkOCWydi6NLsMdRJ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKUdDqx9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKUdDqx9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6C41F00898;
	Thu, 10 Sep 2026 14:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049332;
	bh=aHaaTzJjw23qcGiG8YLh1SW/x/zyacdI+gAS5WhzTig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FKUdDqx9+Q77juEeOT2RbE2LEcoSLIpMC+z7OYeW4UY+G+asrzHzPy5W1Ba6Im5YV
	 zQAEcjTPk+rXYVnzrWaqTJwPglZVTpr5T99DxJSqbiH4lKYKoP3IKtkfGLqSU5LzbA
	 TZ5DPC/mTmCJi4XTzx8qI2aor7dwGFSVSVml84rptRjp+5mZKArHWfb23CJu0F/2+l
	 dgECc/Lcrn3z5RkMnrsfajYc/9NZpl9F+x9UgTAejOY4ByAA/Y+Qq5W6anMkeYcFOw
	 6pB1Inu5mQjBRswQKm/PcAc19a5p6YPpBfjtJcHBwugzgDycLu5QsUXDcdZ2I1TquF
	 yxnaIb0EjI/YQ==
Date: Thu, 10 Sep 2026 11:08:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test x86: Fix missing __msan_unpoison
Message-ID: <aqK58d5LbZAZ28Wd@x2>
References: <20260909222048.2138387-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909222048.2138387-1-irogers@google.com>

On Wed, Sep 09, 2026 at 03:20:48PM -0700, Ian Rogers wrote:
> __msan_unpoison may need the sanitizer header including for its
> definition.

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/tests/dwarf-unwind.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
> index 99d2b7ed016f..3c66dadcab75 100644
> --- a/tools/perf/arch/x86/tests/dwarf-unwind.c
> +++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
> @@ -8,6 +8,10 @@
>  #include "debug.h"
>  #include "tests/tests.h"
>  
> +#if defined(MEMORY_SANITIZER) && !defined(__msan_unpoison)
> +# include <sanitizer/msan_interface.h>
> +#endif
> +
>  #define STACK_SIZE 8192
>  
>  static int sample_ustack(struct perf_sample *sample,
> -- 
> 2.55.0.1003.g10538fe699-goog
