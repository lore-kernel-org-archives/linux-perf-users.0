Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41382125AA;
	Sat,  4 Jul 2026 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783184077; cv=none; b=Ga2w7gVc0W5Ezc2x/OwH9+WWQB8EvUXTbQz8/tqctboumasAr7+T3YR8OCz2ZmUmVWAdo8zEOjPs1Pi3qLzwurSaHVP7irsbIcy0AaG/m6Il0y0+lzWJ6fZMELu3NevdTjlJVORl7cTO0eBVJwSZifEq1DLUTrAXh7+dxhrQaXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783184077; c=relaxed/simple;
	bh=6HcNj7CyInIUqQshnxTruUQWknNP5bmQ0H1zdxY0p8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e62GPMPqW/+eq1oBG7JUPwgl/BiU8tHdb98A/ZohOifTEgipSk/4nEcNbOK5PZBTUPrMNehhisBx1kwI/b35aT4MFHOJHSuJ7D7KpOR3cgwwIrN6In6QqN8YhFA0DEZTrPOk2//baKDblSgg5gCKsiDFhBJ+3oCK2Ve8uEZCOOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+yNiQdi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+yNiQdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760531F000E9;
	Sat,  4 Jul 2026 16:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783184075;
	bh=wpTz/OMGL68+O/E1EcVtgUT/y3oNCBcEUeWX7tAflpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n+yNiQdiAWxS3H203V1c5QSN4cQWVmYAOVd3f6HUCMZPtNoauassHRrYO2Z4UwPJf
	 SX0t+i35KmqAGCKeHrSUHSvJue2NNM7yTrHSEzAnWTg987MS93Cvlczt3EThULrtvu
	 3DcQ0KWnCTMVs0NZY7SQoTMxqrG33fMDkK5mNDN4CGOVnf5HJYmF7asjKP8i1bUTHn
	 c+qae5NMfGrPoS3Pum3xmRZISri3AewGzHLCxYDCl5GqqgWglyXquRBa6KJ8cFGVEu
	 HUL7WAvPF+1w0/mUaasNS4PAjQjfPoKp5eJlbqpsYP3YKm1XZIEfwTzwnydNOb7VI6
	 qnkGqb1SjHVOA==
Date: Sat, 4 Jul 2026 09:54:34 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com,
	dapeng1.mi@linux.intel.com, james.clark@linaro.org,
	leo.yan@linux.dev, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v2 00/16] perf python: Fix python extension bugs from v19
 review
Message-ID: <akk6yvqJuXWOrGUr@google.com>
References: <20260623053515.2677888-1-irogers@google.com>
 <20260624051535.3584977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260624051535.3584977-1-irogers@google.com>

Hi Ian,

On Tue, Jun 23, 2026 at 10:15:17PM -0700, Ian Rogers wrote:
> Phase 1 of splitting the v19 review patches into smaller fixes.
> These patches address issues identified in the python extension during
> the review of the v19 script porting series, as well as fixing several
> pre-existing bugs and leaks.
> 
> v2:
> - Addressed sashiko review feedback:
>   - Fixed 64-bit casting for counts_values by using T_ULONGLONG and PyLong_FromUnsignedLongLong.
>   - Replaced strict Py_TYPE checks with PyObject_TypeCheck for thread/cpu maps.
>   - Fixed a missing CHECK_INITIALIZED for pyrf_thread__get_cpu, pyrf_pmu__name, pyrf_pmu__events.
>   - Included <string.h> where memset was used.
> - Fixed line splitting formatting on PyObject_New in pyrf_evsel__read.
> - Added fixes for memory leaks and issues discovered during review:
>   - Fix memory leak of key and value in pyrf__metrics_cb
>   - Fix count_values memory leak in pyrf_evsel__read
>   - Fix sb_evlist leaks in both top and record paths.
>   - Fix potential divide by zero in perf_event__synthesize_threads
> 
> v1:
> - Decomposed the single large "Fix python extension bugs" patch into 13 individual fixes.
> - Added Fixes: tags for issues that date back to earlier commits.
> - Addressed checkpatch warnings (line lengths, Signed-off-by, etc).
> 
> 
> Ian Rogers (16):
>   perf script: Fix metric_evlist leak in script_find_metrics
>   perf stat: Fix evsel_list leak in cmd_stat
>   perf tools: Fix sb_evlist leaks in top and record
>   perf python: Fix memory leak in pyrf_evlist__get_pollfd
>   perf synthetic-events: Fix uninitialized pthread_join
>   perf data: Fix directory file descriptor leak in perf_data__switch
>   perf test: Fix skiplist leak in cmd_test
>   perf python: Check counts_values size in set_values
>   perf python: Validate CPU and thread maps in pyrf_evsel__open
>   perf python: Validate attribute setters in pyrf_evsel
>   perf python: Zero initialize perf_data in pyrf_data__init
>   perf python: Add thread and PMU uninitialized checks
>   perf python: Fix MetricGroup return type in perf.pyi
>   perf python: Fix count_values memory leak in pyrf_evsel__read
>   perf python: Fix memory leak in pyrf__metrics_cb
>   perf synthetic-events: Fix divide by zero in
>     perf_event__synthesize_threads

Will you send v3?  You don't need to fix all pre-existing issues but we
should not introduce new bugs or regressions.  I think some of Sashiko
comments found them like data switch and pmu init checks.

Thanks,
Namhyung

> 
>  tools/perf/builtin-record.c        |   2 +
>  tools/perf/builtin-script.c        |   2 +-
>  tools/perf/builtin-stat.c          |   9 +-
>  tools/perf/builtin-top.c           |   2 +
>  tools/perf/python/perf.pyi         |   4 +-
>  tools/perf/tests/builtin-test.c    |   5 +-
>  tools/perf/util/data.c             |   3 +-
>  tools/perf/util/python.c           | 160 ++++++++++++++++++++++++-----
>  tools/perf/util/synthetic-events.c |   6 +-
>  9 files changed, 153 insertions(+), 40 deletions(-)
> 
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
