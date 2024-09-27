Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4670D1B2528;
	Fri, 27 Sep 2024 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727477399; cv=none; b=eavyXP6PlMg1GHXmBJUxb7n7opvnzyVfpDj4xZgxIwisYGPrQHdRONak8wf+yv4Z2HL5/4oox7+wJ85OsG/56rknyCu3nib5VZhhryTaaiDWOB9wnN4G4cnwFzA/m5N3PDPTlfXtBbwkDLHLg8+Q3MtjdyXoGMK3/zA4MJ6R7z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727477399; c=relaxed/simple;
	bh=TydlRKKsGrXlOEySEF0J+UrHqz+uVo7yHDGjTHM18v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B50p+x3PkNsLONA8wHPEbFISRvFdWI6HGjla8mkIXom2+2kbWQKhT1z0JaSK8gd+1gWRJnbWjmh1+Ttb8pZ7Ulub669DBBmwErQBmx6EzJteFJbbOKDGWRcJSomT+w7cUt99P3Ql/rGTJhEqbVvzlesZ25zL0YA7lVM2XgHZVAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoqSbKGG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoqSbKGG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFABC4CEC4;
	Fri, 27 Sep 2024 22:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727477398;
	bh=TydlRKKsGrXlOEySEF0J+UrHqz+uVo7yHDGjTHM18v0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AoqSbKGG8H1EVVA9FFAT+qbpCkYzJrzQcUi/hQ7+68IwkZ2T9ivHsQDiSg7rY0iUm
	 SPu/tKRRJRshU4rg0+BMIgPS4HwRlXxqsusfBUexADeVn3farDM9X1Ts6DhVgGTiiE
	 4yyTZmulkcKFYnqFMxN2xItykvsu0K9R1nLAnT1FjHTPIjHfh3UwAXgXb47zHnGmJ2
	 qKMi5qU0aHI7tWWHRft7y7oBhoHCa97qg7s5+bWKFiGivddsVYuNYoVm8kX9LDaI0+
	 Xk3d4cGowX0NXHy+150uPqwR87he5RZtX0FbK8/Y0iC/vuCI9OkLvktX1/GaMO4c4g
	 kZkTvS/Ad2lnQ==
Date: Fri, 27 Sep 2024 15:49:57 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ben Gainey <ben.gainey@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	james.clark@arm.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 0/2] tools/perf: Support PERF_SAMPLE_READ with inherit
Message-ID: <Zvc2lWIfTcB1NK3I@google.com>
References: <20240805085458.134195-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240805085458.134195-1-ben.gainey@arm.com>

Hello,

On Mon, Aug 05, 2024 at 09:54:56AM +0100, Ben Gainey wrote:
> This revision of this change splits out the tools/perf changes requested 
> by Namhyung Kim for my previous work to enable PERF_SAMPLE READ with inherit (see 
> https://lore.kernel.org/linux-perf-users/20240730084417.7693-1-ben.gainey@arm.com/ ) 
> as the kernel side changes have been picked up by Peter Zijlstra.

Sorry about the long delay.  But unfortunately the current version is
not applied to the current perf-tools-next branch.

Can you please rebase this series?

Thanks,
Namhyung

> 
> Changes since v10:
>  - Fixed a formatting nit
> 
> Changes since v9:
>  - Split out tools/perf patches only
>  - Fixed system-wide mode in `perf record` to not set the inherit bit.
> 
> Changes since v8:
>  - Rebase on v6.11-rc1
> 
> Changes since v7:
>  - Rebase on v6.10-rc3
>  - Respond to Peter Zijlstra's feedback:
>  - Renamed nr_pending to nr_no_switch_fast and merged in nr_inherit_read
>    which otherwise had overlapping use
>  - Updated some of the commit messages to provide better justifications
>    of usecase, behavioural changes and so on
>  - Cleanup perf_event_count/_cumulative
>  - Make it explicit that the sampling event decides whether or not the
>    per-thread value is given in read_format for PERF_RECORD_SAMPLE and
>    PERF_RECORD_READ; updated tools to account for this.
> 
> Changes since v6:
>  - Rebase on v6.10-rc2
>  - Make additional "perf test" tests succeed / skip based on kernel
>    version as per feedback from Namhyung.
> 
> Changes since v5:
>  - Rebase on v6.9
>  - Cleanup feedback from Namhyung Kim
> 
> Changes since v4:
>  - Rebase on v6.9-rc1
>  - Removed the dependency on inherit_stat that was previously assumed
>    necessary as per feedback from Namhyung Kim.
>  - Fixed an incorrect use of zfree instead of free in the tools leading
>    to an abort on tool shutdown.
>  - Additional test coverage improvements added to perf test.
>  - Cleaned up the remaining bit of irrelevant change missed between v3
>    and v4.
> 
> Changes since v3:
>  - Cleaned up perf test data changes incorrectly included into this
>    series from elsewhere.
> 
> Changes since v2:
>  - Rebase on v6.8
>  - Respond to James Clarke's feedback; fixup some typos and move some
>    repeated checks into a helper macro.
>  - Cleaned up checkpatch lints.
>  - Updated perf test; fixed evsel handling so that existing tests pass
>    and added new tests to cover the new behaviour.
> 
> Changes since v1:
>  - Rebase on v6.8-rc1
>  - Fixed value written into sample after child exists.
>  - Modified handling of switch-out so that context with these events
>    take the slow path, so that the per-event/per-thread PMU state is
>    correctly switched.
>  - Modified perf tools to support this mode of operation.
> 
> Ben Gainey (2):
>   tools/perf: Correctly calculate sample period for inherited
>     SAMPLE_READ values
>   tools/perf: Allow inherit + PERF_SAMPLE_READ when opening events
> 
>  tools/lib/perf/evsel.c                        | 48 ++++++++++++++
>  tools/lib/perf/include/internal/evsel.h       | 63 ++++++++++++++++++-
>  tools/perf/tests/attr/README                  |  2 +
>  tools/perf/tests/attr/test-record-C0          |  2 +
>  tools/perf/tests/attr/test-record-dummy-C0    |  2 +-
>  .../tests/attr/test-record-group-sampling     |  3 +-
>  .../tests/attr/test-record-group-sampling1    | 51 +++++++++++++++
>  .../tests/attr/test-record-group-sampling2    | 61 ++++++++++++++++++
>  tools/perf/tests/attr/test-record-group2      |  1 +
>  ...{test-record-group2 => test-record-group3} | 10 +--
>  tools/perf/util/evsel.c                       | 21 ++++++-
>  tools/perf/util/evsel.h                       |  1 +
>  tools/perf/util/session.c                     | 25 +++++---
>  13 files changed, 271 insertions(+), 19 deletions(-)
>  create mode 100644 tools/perf/tests/attr/test-record-group-sampling1
>  create mode 100644 tools/perf/tests/attr/test-record-group-sampling2
>  copy tools/perf/tests/attr/{test-record-group2 => test-record-group3} (81%)
> 
> -- 
> 2.45.2
> 
