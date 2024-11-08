Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922FF233D6E;
	Fri,  8 Nov 2024 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731089943; cv=none; b=B0Gq9oVTneNkGetXcRO/xiSpeFHgEMXALXxDY5RWEtYSFm2qsyIsiYeywwKNaeMvkTucAB9Rn36lUiyqLjxdYTWwUu4hrYofcxWMRGzmzbwUDbrz9LM7Xdcwwf69vgaYqdmX/kN0cvlEhfB0XFND9eYs5QHlXWkFAY0aCUsDJjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731089943; c=relaxed/simple;
	bh=rOFwXUAy+/+iBDIpO72Sr6FxlUBXqL2IRqthrCUDx6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfRq2BIeD4v3+gjibJRJb4Ia3rnJkRk6NTTzX/LqfA6KVFLcMis7zVwBf2BN0d7VGyQXK7R6VOSi/EdXgIri4P9sIEMU/FRUvPx/NjDSbqPSTfm1Lkq+rnSae5DWu7KvhQXw6I79r4p4HleDXQ7aD5p+gfTWI57XG/M8kMCFfeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+I/rZaI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+I/rZaI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2617DC4CECD;
	Fri,  8 Nov 2024 18:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731089943;
	bh=rOFwXUAy+/+iBDIpO72Sr6FxlUBXqL2IRqthrCUDx6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+I/rZaIJH/u4ImDPs5UDAlW/pHq8uykK80/adHL//d5M9XqjXpqnkR5IclpUyg38
	 F/pW5F4vaYEkE5lS7H9ut7h/gTRz+x/VxVtZjhs4ZjzVuSfQUSLBCepMc5aqPWkHx1
	 9qY2tfPQm/c5CXQCH7awwvkaVeRYqxA9SIC4jHZI4yn8w+tJmdxJTCSkkekFw+GYJF
	 v8rQe8Uq4B+a6HK3OA+Z1FIeTNOEnqJTpXvIXNDZ01ZcUtWYWajMpRUiHzMa/GrX92
	 fVSThq1X1VPTrKZoRhWQkaHYfNhPOm/7LsLko7elZuxd9L7UujqFfUA5D3NA2+MfXc
	 Q3oOmZ90ERTNQ==
Date: Fri, 8 Nov 2024 10:19:00 -0800
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
Subject: Re: [PATCH v3 0/6] Avoid parsing tracepoint format just for id
Message-ID: <Zy5WFHo5zvpbxSlH@google.com>
References: <20241105212652.401943-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105212652.401943-1-irogers@google.com>

Hi Ian,

On Tue, Nov 05, 2024 at 01:26:46PM -0800, Ian Rogers wrote:
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
> v3. Whitespace changes, Arnaldo.
> v2. Add additional error checking/handling in evsel__tp_format.
> 
> Ian Rogers (6):
>   tool api fs: Correctly encode errno for read/write open failures
>   perf trace-event: Constify print arguments
>   perf trace-event: Always build trace-event-info.c
>   perf evsel: Add/use accessor for tp_format
>   perf evsel: Allow evsel__newtp without libtraceevent
>   perf tests: Enable tests disabled due to tracepoint parsing

Looks good now.  But it doesn't apply to perf-tools-next cleanly.
Could you please rebase?

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
>  tools/perf/util/evsel.c                       | 110 +++++++++++++-----
>  tools/perf/util/evsel.h                       |   9 +-
>  tools/perf/util/evsel_fprintf.c               |   4 +-
>  tools/perf/util/parse-events.c                |  16 +--
>  tools/perf/util/perf_event_attr_fprintf.c     |   4 -
>  .../util/scripting-engines/trace-event-perl.c |   3 +-
>  .../scripting-engines/trace-event-python.c    |   3 +-
>  tools/perf/util/sort.c                        |  33 ++++--
>  tools/perf/util/trace-event-parse.c           |   4 +-
>  tools/perf/util/trace-event-scripting.c       |  10 +-
>  tools/perf/util/trace-event.h                 |   4 +-
>  23 files changed, 216 insertions(+), 148 deletions(-)
> 
> -- 
> 2.47.0.199.ga7371fff76-goog
> 
