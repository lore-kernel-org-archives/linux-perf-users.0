Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590BB1ADFFE;
	Mon, 23 Jun 2025 23:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720953; cv=none; b=EgBVBPpbX0Zg8SvIfz6wI4BU+aoGMyD4crnf1pkt2iBvOeWMH0YOc0gf6FZMG2q+aWpuw4oeOXTYxrUOcwJ89XBS8drGB1AKxFfYElehm+3aNZ44jV8YAp3SL6BjYQ1FrXcopS2ph/UdkOjyoNgNrvOprIv2UY/vzywNLxjn2JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720953; c=relaxed/simple;
	bh=3JCIdm/lY3A3oO6QC7tcIajIJHdvKIoWTTw2glf7/54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdkCTVnsPcIxqxhtMEa0NzVg/nxGudqXx3hIvMRMRKcnXPKZvArNyV+p3FNCEoffpponaReR30Ng5/r9KVj4ouerC76qQiQPXrFPvJxN/fPu/bXN6aJBjRsj2qbLYSUnF+s4oCrZRKWLf/jYc3VUU4z1w5NeY6egOfXVaecnrdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pu4TbMB9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pu4TbMB9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89782C4CEEA;
	Mon, 23 Jun 2025 23:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750720953;
	bh=3JCIdm/lY3A3oO6QC7tcIajIJHdvKIoWTTw2glf7/54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pu4TbMB91T2GhcMXvI3d4Jkr2w1CX0pAEOIMT6qewGZTn7f+uRoSQa/DzEpfI4Ybb
	 ulgy+H4D2PsgRB8PcdmK3qNPcu/+lNXPKjR/rVQP1y7bWvYFisKgqBkZOJFJZf5xR8
	 RVk3ltO0dZ60H4OqnXZS8KsAo1ukVoqUbGp8AC8zj3zDqRpnUskQygPWuNMet3XIJA
	 +IG1TibO5eP7vtfSx8lSJVQDk9QPNXdqxBbnmPSaB2q9s5n/dwGc4ZvcVTzXppIf3B
	 s2kni0Kr+xArbYqCv3MgUjvI2se7AXkvZbWiJeQGH+vhfZI19IcwVwm6bT88KqNMW4
	 64nv6BgDcmfSg==
Date: Mon, 23 Jun 2025 16:22:31 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Junhao He <hejunhao3@huawei.com>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 0/4] Add support for a DRM tool like PMU
Message-ID: <aFnht37mLV6ZFost@google.com>
References: <20250403202439.57791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250403202439.57791-1-irogers@google.com>

Hi Ian,

On Thu, Apr 03, 2025 at 01:24:35PM -0700, Ian Rogers wrote:
> DRM clients expose information through usage stats as documented in
> Documentation/gpu/drm-usage-stats.rst (available online at
> https://docs.kernel.org/gpu/drm-usage-stats.html). Add a tool like
> PMU, similar to the hwmon PMU, that exposes DRM information.
> 
> v3: Minor tweak to the test so the skip (exit 2) doesn't trigger the
>     trap cleanup.
> 
> v2: Add support to only scan hwmon and drm PMUs if the event or PMU
> wildcard can match. Add a test as requested by Namhyung. Add file
> comments.
> 
> v1:
> https://lore.kernel.org/lkml/20250211071727.364389-1-irogers@google.com/
> 
> Ian Rogers (4):
>   perf parse-events: Avoid scanning PMUs that can't contain events
>   perf parse-events: Avoid scanning PMUs that can't match a wildcard
>   perf drm_pmu: Add a tool like PMU to expose DRM information
>   perf tests: Add a DRM PMU test

Can you please refresh this series?  It doesn't apply cleanly anymore.

Thanks,
Namhyung

> 
>  tools/perf/tests/shell/drm_pmu.sh |  78 ++++
>  tools/perf/util/Build             |   1 +
>  tools/perf/util/drm_pmu.c         | 689 ++++++++++++++++++++++++++++++
>  tools/perf/util/drm_pmu.h         |  39 ++
>  tools/perf/util/evsel.c           |   9 +
>  tools/perf/util/parse-events.c    |  30 +-
>  tools/perf/util/pmu.c             |  15 +
>  tools/perf/util/pmu.h             |   4 +-
>  tools/perf/util/pmus.c            | 101 ++++-
>  tools/perf/util/pmus.h            |   2 +
>  10 files changed, 952 insertions(+), 16 deletions(-)
>  create mode 100755 tools/perf/tests/shell/drm_pmu.sh
>  create mode 100644 tools/perf/util/drm_pmu.c
>  create mode 100644 tools/perf/util/drm_pmu.h
> 
> -- 
> 2.49.0.504.g3bcea36a83-goog
> 
