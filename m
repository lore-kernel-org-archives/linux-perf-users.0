Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B6A1F1515;
	Fri, 23 May 2025 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748038371; cv=none; b=Wea6VLCUFaqrrdduX5J4tgj2Qz7vXKxy8og+7Ok4RymIimgbDiZ0YJW4+CoWHlIRq7cnQaxyLyJKeoyi1iL6KFcLqKhziFqafR21fWUHyvkihfqHo7cly8Dcm4issNkSMm/7Re+h/Y3jMNvjxueHow4fEHDfTbw2fBazubW+zqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748038371; c=relaxed/simple;
	bh=9WyQqSWjAAcGh6XVufAk5F1cOpB4idI+YrLCGrlVTig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tu6QUVux5h6evXFRaytqq4zleVumBNYUahGFzNHcRNAXtFUph9uIIbk5tFeSJZwV6Cdab/vRbQWnwWWIr8kpE9OcQ/+uH1S1tgD8RO5jfaTM/L+fVgoSNaUvjZ4GuZ9C29bacIfknLe4ZuLbXIzDzIp67dT+NqFaYLdQRPt/C4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxurQF/h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxurQF/h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493CAC4CEE9;
	Fri, 23 May 2025 22:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748038370;
	bh=9WyQqSWjAAcGh6XVufAk5F1cOpB4idI+YrLCGrlVTig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OxurQF/hE4k1ifsHzwo0IEg4GWCF8VSb7k2Wq5wd+C6vmRl13/SOb6CbD5Jfr2i6G
	 yIt5f4Rjc3U45Sk6oQD83oXAW+WGosaUhTLlOxDTei1YJNc5M/TL0687+jNQ1ZKMyy
	 boMVpoa7AkR4f7xJzerJe9sblAby3NTxQz2HRLxi1W9xI2lKNdioE1Q5tVo5MzMMKh
	 LEFu3e0gBkvzArWuQ+OSFwmmmbZKO3X9nNaNEcvnk5EARJaJwPqf8Ok/F/QVNthTSf
	 a2z9gBN0b4zpvIMeCGM54m0SPUY4Ee8KM09ad1QcmC3bnwGapPhLB1fdiVtOrUa98n
	 nSiIgLs40Q3Zg==
Date: Fri, 23 May 2025 15:12:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf test: Add cgroup summary test case for perf trace
Message-ID: <aDDy4FQe7sBwECL8@google.com>
References: <20250522142551.1062417-1-namhyung@kernel.org>
 <CAH0uvoiZ2difXdPsjkdLikHTRwYROYUeuCdZ+gQ5uRfQ2rzwGQ@mail.gmail.com>
 <aC9VoTL_Cv4R7J-j@x1>
 <aC-hHTgArwlF_zu9@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aC-hHTgArwlF_zu9@x1>

On Thu, May 22, 2025 at 07:11:41PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, May 22, 2025 at 01:49:37PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, May 22, 2025 at 08:33:16AM -0700, Howard Chu wrote:
> > > $ sudo /tmp/perf/perf test -vv 112
> > > 112: perf trace summary:
> > > 112: perf trace summary
> > > --- start ---
> > > test child forked, pid 1574993
> > > testing: perf trace -s -- true
> > > testing: perf trace -S -- true
> > > testing: perf trace -s --summary-mode=thread -- true
> > > testing: perf trace -S --summary-mode=total -- true
> > > testing: perf trace -as --summary-mode=thread --no-bpf-summary -- true
> > > testing: perf trace -as --summary-mode=total --no-bpf-summary -- true
> > > testing: perf trace -as --summary-mode=thread --bpf-summary -- true
> > > testing: perf trace -as --summary-mode=total --bpf-summary -- true
> > > testing: perf trace -aS --summary-mode=total --bpf-summary -- true
> > > testing: perf trace -as --summary-mode=cgroup --bpf-summary -- true
> > > testing: perf trace -aS --summary-mode=cgroup --bpf-summary -- true
> > > ---- end(0) ----
> > > 112: perf trace summary                                              : Ok
>  
> > Thanks, tested and applied to perf-tools-next,
> 
> But then when running all the tests, since this does system wide
> tracing, it fails:
> 
> 112: perf trace summary                                              : FAILED!
> 
> It works with the following patch applied, please check and ack/review:
> 
> From 8c868979d886e2e88aa89f4e3d884e1b6450a7b2 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Thu, 22 May 2025 19:01:47 -0300
> Subject: [PATCH 1/1] perf tests trace_summary.sh: Run in exclusive mode
> 
> And it is being successfull only when running alone, probably because
> there are some tests that add the vfs_getname probe that gets used by
> 'perf trace' and alter how it does syscall arg pathname resolution.
> 
> This should be removed or made a fallback to the preferred BPF mode of
> getting syscall parameters, but till then, run this in exclusive mode.
> 
> For reference, here are some of the tests that run close to this one:
> 
>   127: perf record offcpu profiling tests                              : Ok
>   128: perf all PMU test                                               : Ok
>   129: perf stat --bpf-counters test                                   : Ok
>   130: Check Arm CoreSight trace data recording and synthesized samples: Skip
>   131: Check Arm CoreSight disassembly script completes without errors : Skip
>   132: Check Arm SPE trace data recording and synthesized samples      : Skip
>   133: Test data symbol                                                : Ok
>   134: Miscellaneous Intel PT testing                                  : Skip
>   135: test Intel TPEBS counting mode                                  : Skip
>   136: perf script task-analyzer tests                                 : Ok
>   137: Check open filename arg using perf trace + vfs_getname          : Ok
>   138: perf trace summary                                              : Ok
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Howard Chu <howardchu95@gmail.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Looks good to me.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/tests/shell/trace_summary.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/trace_summary.sh b/tools/perf/tests/shell/trace_summary.sh
> index bb350dfabdc2bf5e..49766524dc21b534 100755
> --- a/tools/perf/tests/shell/trace_summary.sh
> +++ b/tools/perf/tests/shell/trace_summary.sh
> @@ -1,5 +1,5 @@
>  #!/bin/sh
> -# perf trace summary
> +# perf trace summary (exclusive)
>  # SPDX-License-Identifier: GPL-2.0
>  
>  # Check that perf trace works with various summary mode
> -- 
> 2.49.0
> 
