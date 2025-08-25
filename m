Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D412248A5;
	Mon, 25 Aug 2025 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756159621; cv=none; b=CxxkJfttwg+CQkiNsEyWE+B6DqYReilMfTCPdDOAMh8V0z/nuwbIWmhYBlX9m1GKKTvNKuHRczzeLaco/LkqvOvQDKQM81OhIVgsp5BuxpjnoBx1UIhG0bvxIeQ0hlND2DP9QE4+8z/EnFofea6qVMOVqVj8kENhdzj8ATUXrac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756159621; c=relaxed/simple;
	bh=EN/8PGkWdwzUYM0sZ5pjJI/1JrGadkQiq/cY1hM/yOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9mJOXwrjda/ckWZuAwtHwkAYgihcB8LC7P9oHclAY6m0pjpywDeu2OlZK6NNyEXsrq4g6ZM9Zi3EJQ809PELDP9n5g9kTKXxmFDvGJQ7e4CoYQVbJ8KA1Qfcln69+61ADDJbea//a127O+juAuTQRQmGKPJSd19Vetcn9qUhEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEA4Csc8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEA4Csc8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AD0C4CEED;
	Mon, 25 Aug 2025 22:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756159621;
	bh=EN/8PGkWdwzUYM0sZ5pjJI/1JrGadkQiq/cY1hM/yOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lEA4Csc8CtC/tPSIsZHOqbMENgxuDZo+ps2Pb/uABU3zDkgVcAw48rN4zuoBxG2uN
	 8LJFCn/qGbjeiGQY7E2SAnrWdr4Kqi5Xwx85VBD8BLKeDYkb+GIFaO9vqY648G82XY
	 uHjItrKTjYor0plarKf+UkSeqSq4+8wGr7RMZ+2hNX85SVwwqRg2Un0ERvDxGlm4+p
	 uhd57mgWrdXx4BUn4cfOYvxYSfRBNYcdyd24DvrXMqJiPZiBRyUSIAlvHyWtxKXUf8
	 Ub3u/ZobMyIBblVURdYHBZTNLOFLMuqa/gmpRqytbUdZDgcQfTOXo9o3QoTVAZ0MrL
	 ibeRzwx3ckPVw==
Date: Mon, 25 Aug 2025 15:06:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Haibo Xu <haibo1.xu@intel.com>,
	Dmitry Vyukov <dvyukov@google.com>, Song Liu <song@kernel.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Build ID mmap related fixes
Message-ID: <aKzeglUaXc1rFr4k@google.com>
References: <20250823000024.724394-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250823000024.724394-1-irogers@google.com>

Hi Ian,

On Fri, Aug 22, 2025 at 05:00:22PM -0700, Ian Rogers wrote:
> Now that build ID mmap is the default I was seeing hangs during event
> synthesis in the perftool-testsuite_report. The hang was happening due
> to data pages giving block device file paths and opening the file to
> read a build ID was blocking in the open. In investigating this issue
> a bug in symbol-minimal was found. These 2 patches fix both issues. As
> the issues are present in v6.17-rc2, I think it would be worthwhile to
> add the patches as v6.17 fixes.

Looks good to me.  I'll add them for v6.17.

Thanks,
Namhyung

> 
> Ian Rogers (2):
>   perf symbol-minimal: Fix ehdr reading in filename__read_build_id
>   perf symbol: Add blocking argument to filename__read_build_id
> 
>  tools/perf/bench/inject-buildid.c  |  2 +-
>  tools/perf/builtin-buildid-cache.c |  8 ++--
>  tools/perf/builtin-inject.c        |  4 +-
>  tools/perf/tests/sdt.c             |  2 +-
>  tools/perf/util/build-id.c         |  4 +-
>  tools/perf/util/debuginfo.c        |  8 +++-
>  tools/perf/util/dsos.c             |  4 +-
>  tools/perf/util/symbol-elf.c       |  9 +++--
>  tools/perf/util/symbol-minimal.c   | 59 +++++++++++++++---------------
>  tools/perf/util/symbol.c           |  8 ++--
>  tools/perf/util/symbol.h           |  2 +-
>  tools/perf/util/synthetic-events.c |  2 +-
>  12 files changed, 58 insertions(+), 54 deletions(-)
> 
> -- 
> 2.51.0.rc2.233.g662b1ed5c5-goog
> 
