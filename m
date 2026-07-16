Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B71397350
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186399; cv=none; b=XWE2ad6xgpEFLdYTyYPlymk/Iur499roIEc+WixeV4sXuepbV3JV4TLDE78VMkw/FhLGheyguY/YnQHXcOGkYz608fuJ7ha9jr74kpcdcohkJoynOKON8gwUgc7EZkKfOgGjhHRt9oSvvJ0h/371Sdmyl5DP/LpHT5GJFlcK95U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186399; c=relaxed/simple;
	bh=3GxIepgl/cieXFVnbYJ40loST1UaqH4hEnmM0xym++E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lTx5c06m9eQ5K6GcxgjpMiq3QFT0Dl/JHgL0Fwy5Lvi/BQx9pusBA4Sb/FZMmY06uUZQwhkhpKOR0pAaG8HtXsFGsrUXl58oVBfRM5PQ0AGCsAiXvJOyeaAw9bSoSx1NB6LmwTopE+++cLnGy5AEuqodtr33Nlcqd835DxHOe/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfKLyuXY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfKLyuXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99491F000E9;
	Thu, 16 Jul 2026 07:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784186377;
	bh=EJD57WiKiyu3T3gEGMwewEHiYF/SyeEY+5X5UERbOmM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FfKLyuXYQz1G0mhTWcSLvqMPp44x0qa09oG0TMqKMqhzrn+hDuHAs7ybSVRWuqevg
	 4h7voNIcAZ+wfVJlTkMQ+cEtsW9tTjT+RkMpXkvwu4sBLU/eUPjMzqJ/ZKpPPCDSo7
	 u2xz3QgtuXPw1NjW0i4kDJ7OcQ8uHH2utPKdO7p4fTryiDCvaTULOlBLBIHpZTO8/u
	 VvcoyLQGaCWJirn08Bmi8uX/AVXPfDoBPZViJcwVPYKRPw0uDW2PXG+iHUoCfCBas6
	 92qTR8m862E7mJaxJneHM5RVzHsMdRu4olqPpnamPuYplrMnZ8T8pfGISwr33s1ZJH
	 4Bgwn9D6aHn7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/14] perf stat: Implement streaming JSON formatting
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716070303.507066-11-irogers@google.com>
References: <20260716043223.388233-1-irogers@google.com>
 <20260716070303.507066-1-irogers@google.com>
 <20260716070303.507066-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 07:19:37 +0000
Message-Id: <20260716071937.B99491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The JSON output completely ignores cgroup identification and stati=
stical variance data for events.
- [Low] The state structs contain fields that are initialized but never use=
d by any print callbacks.

Pre-existing issues:
- [High] Missing bounds and NULL check on `evsel->core.threads` in `print_a=
ggr_id_json` when formatting `AGGR_THREAD` JSON output.
- [High] Passing a potentially NULL string from `perf_thread_map__comm()` t=
o the `%s` format specifier causes undefined behavior and leads to a crash =
on musl libc systems.
--

--- Patch [10]: [PATCH v4 10/14] perf stat: Implement streaming JSON format=
ting callbacks ---
commit 77f0723329ce102d572ddc7616c0e8a06c6c64f1
Author: Ian Rogers <irogers@google.com>

perf stat: Implement streaming JSON formatting callbacks

This patch implements streaming JSON formatting callbacks inside
util/stat-print-json.c, replacing the empty stubs introduced in Commit 1. It
delivers a highly optimized, zero-allocation, and streaming print engine for
JSON normal and metric-only modes.

Assisted-by: Antigravity:gemini-3.5-flash
Acked-by: Chun-Tse Shao <ctshao@google.com>

> diff --git a/tools/perf/util/stat-print-json.c b/tools/perf/util/stat-pri=
nt-json.c
> index 4690c4286fd2a..7ed00aae89f4b 100644
> --- a/tools/perf/util/stat-print-json.c
> +++ b/tools/perf/util/stat-print-json.c
[ ... ]
> +struct json_print_state {
> +	FILE *fp;
> +	char timestamp[64];
> +};
> +
> +/**
> + * struct json_metric_only_print_state - Metric-only print state context=
 for JSON output.
> + * @fp: File descriptor to output to.
> + * @timestamp: Formatted interval timestamp (optional).
> + * @evlist: Evlist to query entries from.
> + * @last_aggr_idx: The aggregation index of the last printed metric.
> + * @first_in_group: Whether the current metric is the first in its group.
> + */
> +struct json_metric_only_print_state {
> +	FILE *fp;
> +	char timestamp[64];
> +	struct evlist *evlist;

[Severity: Low]
Are the fp field in json_print_state and the evlist field in
json_metric_only_print_state needed? It appears they are initialized in
perf_stat__print_json but never actually read or used by any print callback=
s,
which introduces unnecessary dead state.

> +	int last_aggr_idx;
> +	bool first_in_group;
> +};
[ ... ]
> +	case AGGR_THREAD:
> +		fprintf(output, "\"thread\" : \"%s-%d\", ",
> +			perf_thread_map__comm(evsel->core.threads, id.thread_idx),
> +			perf_thread_map__pid(evsel->core.threads, id.thread_idx));

[Severity: High]
This is a pre-existing issue, but is it possible for evsel->core.threads to
be NULL or id.thread_idx to be out of bounds here? Calling
perf_thread_map__comm without validating the index can lead to a determinis=
tic
segmentation fault.

[Severity: High]
This isn't a bug introduced by this patch, but does perf_thread_map__comm
safely return a non-NULL string in all cases? If the comm string pointer
is NULL, passing it to the %s format specifier in fprintf causes a
segmentation fault on systems using musl libc.

> +		break;
[ ... ]
> +static int json_print_event(void *ctx, struct perf_stat_config *config,
> +			    struct evsel *evsel, int aggr_idx, u64 val,
> +			    u64 ena, u64 run, double stdev_pct __maybe_unused,
> +			    const char *cgrp __maybe_unused)

[Severity: High]
Does ignoring the stdev_pct and cgrp parameters result in a regression of t=
he
JSON output parity? The baseline code formatted cgroup and variance into the
JSON output, so marking these as unused here seems to silently drop standard
deviation and cgroup data, which could break automated profiling pipelines.

> +{

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716070303.5070=
66-1-irogers@google.com?part=3D10
