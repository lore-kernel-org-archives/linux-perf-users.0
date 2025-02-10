Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF09825C6E2;
	Mon, 10 Feb 2025 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217567; cv=none; b=ikVI7VAYtmXH5lnf6sRUeMlMq2v1fF0nPO0AaJYR4QC8+U5M0NthJpIwrKR2bgxoG4ZKrkuE0K1Tr4EXf6i6BEf0BhA4POFdIn8mbh6LQDulKJKMHUhH54VnOz/RHVQ3xsagzM+ulXZ17gU/Y9noszeRgNnBYOuV3R88+LYauzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217567; c=relaxed/simple;
	bh=fQTVaLBmxwzCQpGzYKkvesS9adJeVdXniYYtPc98sLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4orMExrg661SxBF8Smc/bvzULP/4//Ij7bknjhipBvYf57N2pcyTfiQRT0Rk2R+XOkotaeWvE2P3CIXFnaMJ+1GwfLFRNaE5uqGRifuLp06//Eay797MvdAL2Ac6Z/NUAKGrO5WGJDnnIlXRrodvU4PjbbHjyuCQ1UCMualAiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sudhREMJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sudhREMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAE8C4CED1;
	Mon, 10 Feb 2025 19:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739217567;
	bh=fQTVaLBmxwzCQpGzYKkvesS9adJeVdXniYYtPc98sLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sudhREMJT4WBnHYFJc/WPrg0ZoMxrcqEUCMOeexJmHaOiEZfimgGYSRjbJ/o5h9Wp
	 RMF272+Jr++MBMkDIXhDPhOfTBJzTfW3N6EtK0Q4xug9A7lS9Ldk5fmad4Y/qnbnlV
	 TYwg6c9W9o/IlgDyk6vNbpXsintBs/foNG+WFLPny1djDBPyO/FOYIH07+mFCc75o2
	 VcekXrcZSmMK3f29jPeSpBQuOoTSzDSivhGVIIkxRPTkiGat9NKHlTqAKP/5h1t8oV
	 c+/DsLO0XwjKfK0xWdhneNUIonZJyR5lQKO+KcNTtJhfWuH28qIEyolXKiHNLfVh9F
	 k8zzaCZlVukqg==
Date: Mon, 10 Feb 2025 11:59:24 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, Hao Ge <gehao@kylinos.cn>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Levi Yun <yeoreum.yun@arm.com>, Xu Yang <xu.yang_2@nxp.com>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/10] Move uid filtering to BPF filters
Message-ID: <Z6panMzNSm1op8Di@google.com>
References: <20250111190143.1029906-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250111190143.1029906-1-irogers@google.com>

On Sat, Jan 11, 2025 at 11:01:33AM -0800, Ian Rogers wrote:
> Rather than scanning /proc and skipping PIDs based on their UIDs, use
> BPF filters for uid filtering. The /proc scanning in thread_map is
> racy as the PID may exit before the perf_event_open causing perf to
> abort. BPF UID filters are more robust as they avoid the race. Add a
> helper for commands that support UID filtering and wire up. Remove the
> non-BPF UID filtering support.

Hmm.. then non-BPF build cannot use the UID filtering anymore, right?
Also non-root users will be limited unless it pinned the BPF program in
advance.

I think you can keep the original behavior and convert to BPF only when
it's available.

Thanks,
Namhyung

> 
> Ian Rogers (10):
>   perf bench evlist-open-close: Reduce scope of 2 variables
>   perf parse-events filter: Use evsel__find_pmu
>   perf target: Separate parse_uid into its own function
>   perf parse-events: Add parse_uid_filter helper
>   perf record: Switch user option to use BPF filter
>   perf top: Switch user option to use BPF filter
>   perf trace: Switch user option to use BPF filter
>   perf bench evlist-open-close: Switch user option to use BPF filter
>   perf target: Remove uid from target
>   perf thread_map: Remove uid options
> 
>  tools/perf/bench/evlist-open-close.c        | 76 ++++++++++++---------
>  tools/perf/builtin-ftrace.c                 |  1 -
>  tools/perf/builtin-kvm.c                    |  2 -
>  tools/perf/builtin-record.c                 | 26 +++----
>  tools/perf/builtin-stat.c                   |  4 +-
>  tools/perf/builtin-top.c                    | 22 +++---
>  tools/perf/builtin-trace.c                  | 25 ++++---
>  tools/perf/tests/backward-ring-buffer.c     |  1 -
>  tools/perf/tests/event-times.c              |  8 +--
>  tools/perf/tests/keep-tracking.c            |  2 +-
>  tools/perf/tests/mmap-basic.c               |  2 +-
>  tools/perf/tests/openat-syscall-all-cpus.c  |  2 +-
>  tools/perf/tests/openat-syscall-tp-fields.c |  1 -
>  tools/perf/tests/openat-syscall.c           |  2 +-
>  tools/perf/tests/perf-record.c              |  1 -
>  tools/perf/tests/perf-time-to-tsc.c         |  2 +-
>  tools/perf/tests/switch-tracking.c          |  2 +-
>  tools/perf/tests/task-exit.c                |  1 -
>  tools/perf/tests/thread-map.c               |  2 +-
>  tools/perf/util/bpf-filter.c                |  2 +-
>  tools/perf/util/evlist.c                    |  3 +-
>  tools/perf/util/parse-events.c              | 25 ++++---
>  tools/perf/util/parse-events.h              |  1 +
>  tools/perf/util/python.c                    | 10 +--
>  tools/perf/util/target.c                    | 54 ++-------------
>  tools/perf/util/target.h                    | 15 +---
>  tools/perf/util/thread_map.c                | 32 +--------
>  tools/perf/util/thread_map.h                |  6 +-
>  tools/perf/util/top.c                       |  4 +-
>  tools/perf/util/top.h                       |  1 +
>  30 files changed, 135 insertions(+), 200 deletions(-)
> 
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 
