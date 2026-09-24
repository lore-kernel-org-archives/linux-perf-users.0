Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57633DD537;
	Thu, 24 Sep 2026 05:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228701; cv=none; b=c0JGsM3vA4yPH4lbkInCsq94+hvPmzijU7LyKrUAbxT4S/wjh0wxShlXL+WjHHmnEkmmxel+rDYS+IVc6Wm3Xli0j0bkNskmLgtGNErk39aAj7Y4oyVkvH3EySR2kRBex9LvJcLb5j+bZZgFstpI6CyFLJUs3FGY+TnHyJFZ45U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228701; c=relaxed/simple;
	bh=fRQi32n67faLJ6Uq3zm0/V6fZL4OQsawfES3NU31W3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulVvF3SxD0dTuWcEofRN56ssW4SAmTtf6TbXWnKBHTAYnWJVQ1pba5omsiXipZW2yajbDE6QE1oks9cyRsorlzS0M0UgGd0z4XTBHkLc+kfAAZSC63Z9cvX42X0wyRJ0avnjGh+WcBFaHLCcv5xGsXelUdH6JjBxkD3hMAvZ9w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiagoTRd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiagoTRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77601F000FF;
	Thu, 24 Sep 2026 05:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228700;
	bh=hsnElaicdx1h21WvvHJKOBOOJn8qo41VE9TVkFOoJuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TiagoTRdt90rIN3Ff1lo20WqPoqy8SUFhd0Ga0UiXw/+Yyrs9EriQCwVULEivoEze
	 0Qxr90ZEhMg+AWpJbYG+eKR3mai/UtNmJLLJhF0Ufge9ZOurWM1axtNlFvsXKwBl/B
	 vD382puMqjABXCd+VhqM4v7Vo8VlFweid7auDm3MaOrJtdVBqgns40LlAot95/bjlK
	 xHQr7T1s9RocuK/RcPpAXShGEnhL6whdd38WSudMz7MsgC2AyFEKdH1oMoIhxVMz9H
	 wZbC0urNUlLSQxz+/pPfp5HunBk9fuNwQiQ9dlIxkOM4I8RmiV9cFnaqbDYq1xT9ZS
	 4eUfLfkM/xbzA==
Date: Wed, 23 Sep 2026 22:44:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, howardchu95@gmail.com, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v5 03/23] perf trace: Include the headers declaring
 pid_t, strcmp and assert
Message-ID: <arS42kj5cES7OZyn@z2>
References: <cover.1790145937.git.irogers@google.com>
 <4add8796a95e7cabee2a8094d6babdb39290bfe8.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4add8796a95e7cabee2a8094d6babdb39290bfe8.1790145937.git.irogers@google.com>

On Wed, Sep 23, 2026 at 12:13:43AM -0700, Ian Rogers wrote:
> trace_augment.h uses pid_t in the augmented_syscalls__set_filter_pids()
> prototype and in the !HAVE_BPF_SKEL stub. bpf_trace_augment.c calls
> strcmp() in augmented_syscalls__find_by_title() and assert() in
> augmented_syscalls__create_bpf_output(), but neither pulls in the header
> that declares what it uses. Both happen to build today only because
> something else in the include chain drags <sys/types.h>, <string.h> and
> <assert.h> in first, which is not guaranteed and does not hold on libcs
> such as musl that keep the POSIX namespaces strictly separated.
> 
> Include <sys/types.h>, <string.h> and <assert.h> explicitly.
> 
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

I'm not sure why it has Arnaldo's Sign-off..

Thanks,
Namhyung

> ---
>  tools/perf/util/bpf_trace_augment.c | 2 ++
>  tools/perf/util/trace_augment.h     | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/bpf_trace_augment.c b/tools/perf/util/bpf_trace_augment.c
> index a9cf2a77ded1..ebb26225fb04 100644
> --- a/tools/perf/util/bpf_trace_augment.c
> +++ b/tools/perf/util/bpf_trace_augment.c
> @@ -1,5 +1,7 @@
> +#include <assert.h>
>  #include <bpf/libbpf.h>
>  #include <internal/xyarray.h>
> +#include <string.h>
>  
>  #include "bpf_skel/augmented_raw_syscalls.skel.h"
>  #include "debug.h"
> diff --git a/tools/perf/util/trace_augment.h b/tools/perf/util/trace_augment.h
> index 4f729bc67753..a1cd9a5e0213 100644
> --- a/tools/perf/util/trace_augment.h
> +++ b/tools/perf/util/trace_augment.h
> @@ -2,6 +2,7 @@
>  #define TRACE_AUGMENT_H
>  
>  #include <linux/compiler.h>
> +#include <sys/types.h>
>  
>  struct bpf_program;
>  struct evlist;
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 
