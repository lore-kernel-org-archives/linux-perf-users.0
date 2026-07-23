Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF76293B75;
	Thu, 23 Jul 2026 06:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784786613; cv=none; b=tYO+mUQ3UFfzPLHOVEio6GDYDMvDeq/LSMwJu8SxVnw5RAabIXrF3iKqsXiymrUi3ygkae+CtV9aWQASw3E2z9cE7NkFEH596TaggNt/vAylTxl9BowlbS9i0Ff3ieMxkoPlwUMcAojSYcQ8KSNbpKfvmYMBHSm9880TjSTRsDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784786613; c=relaxed/simple;
	bh=y4WQo4p6BEE2gyqHTKB0rFmU3elAicQDAOTc2Vi8Nwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y25txe579fRNbKV9P3Slk7EFbuKumVTgt34ZrXZXBbHP5KdiN5gkLRqOgAMg6JupUvfTTqZ0GGWcUbTpWZImbE/PmUk1FFI5OytDtKL7X1v4s1MguC1QufNtS5LUHLGMjrcOk1Lj1bsjdhfrnvHUj6OdeZYflXuQYp9X7qMzei0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4c4BtuX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4c4BtuX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EEE1F000E9;
	Thu, 23 Jul 2026 06:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784786611;
	bh=hzjSZc8sGEgs4lgNUSVp7dgpq8/C1NjvhXOr+53TX60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T4c4BtuXWNaL64t4l1dmfWhw3Ry6J5fMQuzANsQsFzqLpIch5RIuvGN6FlQKmt2nd
	 VYnf+gxQcjwU1PiSGBWt+Qob095w4FjaM4KnQPJoq8vXnzGajJ9E7l/+Vzk5Q80jTd
	 QQ4CxSNfyHnf8l4B/CJPfPgHEh2Xap7EjF0GcFLYlcaC03yY/gCyyUI03Gj7rE1ndD
	 ngYK2QML1VMgoQKnSwbYlXSP9mfRDF6emzpY0Br2bIv1IzlxaXMfxdOG4ErDuZo/ub
	 8XWqi5wBGVx7O1momKaoiFCPUFtG/087AlUKaL7jfCWtO9pLhEjs5Wx59+FQelxcku
	 HPASovYv0kAuQ==
Date: Wed, 22 Jul 2026 23:03:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>, Chun-Tse Shao <ctshao@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf stat: Include PMU name and split uncore events
 per PMU in metric-only JSON output
Message-ID: <amGusmHqiinoxh8T@google.com>
References: <20260715203055.2981363-1-ctshao@google.com>
 <CAP-5=fWByxhcT0RY_NgXeFADEg4zUiWBbBrEHXMLV3pjqAQ97Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWByxhcT0RY_NgXeFADEg4zUiWBbBrEHXMLV3pjqAQ97Q@mail.gmail.com>

On Wed, Jul 15, 2026 at 08:15:46PM -0700, Ian Rogers wrote:
> On Wed, Jul 15, 2026 at 1:30 PM Chun-Tse Shao <ctshao@google.com> wrote:
> >
> > When running `perf stat` with `-A` (--no-aggr) and `--metric-only` in
> > JSON output mode (`-j`), `perf stat` evaluates metric expressions
> > across all matching PMUs (including uncore PMUs like `uncore_iio_0`,
> > `uncore_iio_1`, etc.).
> >
> > However, `perf stat` previously formatted JSON output by printing only
> > "cpu" : "<id>" and grouping all metric values on a single line per CPU
> > without identifying which PMU instance evaluated each metric. As a
> > result, when an uncore event spans multiple PMU boxes, `perf stat`
> > printed repeated, ambiguous metric keys without PMU names.
> >
> > Fix this by:
> > 1. Including "pmu" : "<pmu_name>" in print_aggr_id_json when evsel->pmu
> >    is a non-core or hybrid PMU in AGGR_NONE mode (-A).
> > 2. Starting a new JSON metric line in AGGR_NONE mode (-A) whenever the
> >    underlying PMU instance changes across PMU events.
> > 3. Updating perf_json_output_lint.py to recognize the new "pmu" key in
> >    the JSON test suite.
> >
> > Example output:
> >   $ perf stat -M iio_bandwidth_read -a -A --metric-only -j -I 1000
> >   {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_0", "MB/s  iio_bandwidth_read" : "0.0"}
> >   {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_1", "MB/s  iio_bandwidth_read" : "0.1"}
> >   {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_11", "MB/s  iio_bandwidth_read" : "0.0"}
> >   ...
> >   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_0", "MB/s  iio_bandwidth_read" : "0.0"}
> >   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_1", "MB/s  iio_bandwidth_read" : "0.0"}
> >   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_11", "MB/s  iio_bandwidth_read" : "0.0"}
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > Assisted-by: Gemini:gemini-3.1-pro-preview
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Nit: It may be nice to include the before output (i.e., without the
> PMU showing that differentiation isn't possible) in the commit
> message.

Hi CT, can you please update the commit message?  It'd be very helpful
for others to understand the problem.

Thanks,
Namhyung

