Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8951D4D5980
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350889; cv=none; b=nHHxBTxAqA57A20gK55h9+nkECW037WsCXg6QlxYdDW5ZGRm6EgPv1+HSbuWIadPJNIt4tyyrcLxfjVelSzAUA8nzqWbPGy43xJYhtVD0Hr9ig3VvX5Bseg/OJRidMfR+XazHbtggiWOG21iDWcqZ0xTFfXjcw8UmCPXgKCo/vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350889; c=relaxed/simple;
	bh=f9V7nvRuDDXA+9B+o+2ItSTKcrIbEbqDtEAXahAyMpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ily9T1+ILzhTd1ELryPQh8o8iWUSx6DGmU7M2njtC561n6aT4LehfymaxP0h7oL/I8TaBcarkaoP1WlblXC3TPa4rAwb0mgQPW0G5hPtJIKmTBzPywpxaIDOL13ZkiPwoXwvEqJP2GczSVmLJ42aN/NrhNiQnkaZIZIUX4//MzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFqeBTdd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFqeBTdd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9CA1F000FF;
	Fri, 25 Sep 2026 15:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790350884;
	bh=VXeqvXIuJ4yai0BSO6NRfIL/HZGbDnuDGZ0q1cfO7Ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EFqeBTdd810On/zYjJsHdC1GuZAx91oCcaOQWyMzRh6rT7BsHktZ2r48fJGVeieR+
	 74kHo/McwG8BS/wqXqSy7Wb2hUv7t4AgC5E6Cx5zROYtuPoRduVGpLl/zvwMBOXk5e
	 H3JrknhoeHKQCl7huXsn2uH3jCjGAnJCa6jGC/QGeE5EPSTu/424W3SlAOTQXFEk2l
	 YLwJDueAdgCUAG+jfYFXMt9tJe4l4pJrBjeCUkTHg6UWqRh/EqlqHNqGJYQohaAIdY
	 s2kLCT0rDPdf/RSh5NCOdXuiI+4vnLYmgUbF9JrFwvylqs58rY5aG8rz/ujk10ZFux
	 FadEXZixiv1Sg==
Date: Fri, 25 Sep 2026 08:41:22 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: Re: [PATCH 1/1] perf test workload: Use unsigned int in
 code_with_type instead of uint
Message-ID: <araWImOoVxsvDGrz@z2>
References: <araUAt-S6YM_bbAf@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <araUAt-S6YM_bbAf@x2>

On Fri, Sep 25, 2026 at 05:32:18PM +0200, Arnaldo Carvalho de Melo wrote:
> The declaration of the Rust helper test_rs() uses "uint", a BSD-ism
> that lives in <sys/types.h>, so on glibc it is only visible by
> accident: glibc's <stdlib.h> includes <sys/types.h>, where uint is
> exposed under __USE_MISC, which is on by default.
> 
> musl does none of that: its <stdlib.h> doesn't include <sys/types.h>
> and it typedefs uint there only when _GNU_SOURCE/_BSD_SOURCE is
> defined, while nothing else in this translation unit includes
> <sys/types.h>. Building it on Alpine therefore fails with:
> 
>   tests/workloads/code_with_type.c:9:21: error: unknown type name 'uint'; did you mean 'int'?
>   tests/workloads/code_with_type.c:39:17: error: implicit declaration of function 'test_rs' [-Wimplicit-function-declaration]
> 
> The second error is a consequence of the first one: with the
> declaration at line 9 rejected, the call at line 39 has no prototype,
> which is an error since gcc 14.
> 
> The breakage is only visible when rustc is present, because
> tests/workloads/Build adds code_with_type.o when CONFIG_RUST_SUPPORT
> is detected, and tools/build/feature only checks for "rustc
> --version". That is why alpine:3.23 and alpine:3.24 fail while
> alpine:3.22 and alpine:edge, lacking rustc, build fine and hide it.
> 
> Use unsigned int, which needs no header at all.
> 
> Fixes: 2e05bb52a12d3 ("perf test workload: Add code_with_type test workload")
> Cc: Dmitrii Dolgov <9erthalion6@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/tests/workloads/code_with_type.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/workloads/code_with_type.c b/tools/perf/tests/workloads/code_with_type.c
> index 65d7be7dac24d411..d2d437b86e0c6dbd 100644
> --- a/tools/perf/tests/workloads/code_with_type.c
> +++ b/tools/perf/tests/workloads/code_with_type.c
> @@ -6,7 +6,7 @@
>  #include <linux/compiler.h>
>  #include "../tests.h"
>  
> -extern void test_rs(uint count);
> +extern void test_rs(unsigned int count);
>  
>  static volatile sig_atomic_t done;
>  
> -- 
> 2.55.0
> 
