Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FCC14EC55;
	Thu, 21 Nov 2024 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732174228; cv=none; b=VFGpMtP9D1M4bce6ZNyre4zCqgc05Ia6oO3f4ZwcVJUIjgZSb0V+Avre8KGIsc+KnEGSbr3l5A9NgBcX6LwDCife4gAspU3wPIOGxn6Rxf9jEd0dolf9LHwjAaQwgTdLs0Se9P4//4Q6sKI1G8k6gVtFGD2GCcooWomW0d5X4PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732174228; c=relaxed/simple;
	bh=nhje7TW8z+eKwp6xS7nSD+uB3e6VolprP3/Ux0+1vCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plqENnUiPKKqHx3n/AOyWu3rwfWHv7INoVoKfdYsMbjynzHfGzW6W2KAiNiPjKBRs4T45t+FsiWmGZyL1UF/pa0+TCIKJjcEIAU60lhNuLEbRa4oxQVBjm/MhSMpWRHuXOSFwzLMRzaTOfvftehUX4hSIPGt63Mnjc6NqdiHu0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbNrF3uu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbNrF3uu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A068AC4CECC;
	Thu, 21 Nov 2024 07:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732174227;
	bh=nhje7TW8z+eKwp6xS7nSD+uB3e6VolprP3/Ux0+1vCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fbNrF3uuUqrADLPH1O4X+MeP8um1/88KJLfeQ3C8EeeIopTSZBVdYXODa122ogKRK
	 wBmGRKqw3QKeBUqYjBw2P+nr9pc6nu+xCRvkHLVPyAsygTtLAJZKUgcDp9+XsWfKAp
	 WyS6PlR0C5mEYTajsDJDPtkZ8Cj6TNUzJkhqblqlSSX5lMhh3y71AL0MVQzvBZo3vz
	 H8G4qQTPil+vCMwqKk7Bu41KCKMJ3zhIQ+YpeKoW68KBRb2D/ZPrzn8bXAfPhN+yhD
	 kePEqAebLwWwOj3iGsIlCmSdQ1jUzykPeZesZGQqMYBd9EXCNidbHL9Jfp4RYm/i4o
	 BUQLF04qt+Cjg==
Date: Wed, 20 Nov 2024 23:30:25 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	James Clark <james.clark@linaro.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>,
	Ben Gainey <ben.gainey@arm.com>,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>,
	Paran Lee <p4ranlee@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: Re: [PATCH v5 0/7] Avoid parsing tracepoint format just for id
Message-ID: <Zz7hkZ7FYdcbccp9@google.com>
References: <20241118225345.889810-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118225345.889810-1-irogers@google.com>

On Mon, Nov 18, 2024 at 02:53:38PM -0800, Ian Rogers wrote:
> The tracepoint format isn't needed to open an event, just the id for
> the config value. Refactor the use of evsel->tp_format to use an
> accessor that will lazily construct its value. In evsel__newtp_idx
> read the id so the config value can be set up/used.
> 
> This allows tracepoints to be used without libtraceevent in a number
> of tests. Other functionality is enabled without libtracevent, such as
> mapping a tracepoint id back to its name. There may be some
> performance benefit to code using tracepoints but not using the format
> information.
> 
> v5. Add perf env fixed found by Namhyung.
> v4. Rebase due to conflict with 9ac98662dbd3 ("perf: event: Remove deadcode")
> v3. Whitespace changes, Arnaldo.
> v2. Add additional error checking/handling in evsel__tp_format.
> 
> Ian Rogers (7):
>   perf env: Ensure failure broken topology file reads are always -1
>     encoded
>   tool api fs: Correctly encode errno for read/write open failures
>   perf trace-event: Constify print arguments
>   perf trace-event: Always build trace-event-info.c
>   perf evsel: Add/use accessor for tp_format
>   perf evsel: Allow evsel__newtp without libtraceevent
>   perf tests: Enable tests disabled due to tracepoint parsing

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/lib/api/fs/fs.c                         |   6 +-
>  tools/perf/builtin-kmem.c                     |  12 +-
>  tools/perf/builtin-kwork.c                    |   3 +-
>  tools/perf/builtin-record.c                   |   2 -
>  tools/perf/builtin-script.c                   |   9 +-
>  tools/perf/builtin-trace.c                    |  79 +++++++++----
>  tools/perf/tests/Build                        |   6 +-
>  tools/perf/tests/builtin-test.c               |   2 -
>  tools/perf/tests/parse-events.c               |  25 +---
>  tools/perf/util/Build                         |   2 +-
>  tools/perf/util/data-convert-bt.c             |  10 +-
>  tools/perf/util/data-convert-json.c           |   8 +-
>  tools/perf/util/env.c                         |   9 +-
>  tools/perf/util/evsel.c                       | 110 +++++++++++++-----
>  tools/perf/util/evsel.h                       |   9 +-
>  tools/perf/util/evsel_fprintf.c               |   4 +-
>  tools/perf/util/parse-events.c                |  16 +--
>  tools/perf/util/perf_event_attr_fprintf.c     |   4 -
>  .../util/scripting-engines/trace-event-perl.c |   3 +-
>  .../scripting-engines/trace-event-python.c    |   3 +-
>  tools/perf/util/sort.c                        |  33 ++++--
>  tools/perf/util/trace-event-parse.c           |   2 +-
>  tools/perf/util/trace-event-scripting.c       |  10 +-
>  tools/perf/util/trace-event.h                 |   2 +-
>  24 files changed, 220 insertions(+), 149 deletions(-)
> 
> -- 
> 2.47.0.338.g60cca15819-goog
> 
