Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAE01A9FB0;
	Wed, 24 Jun 2026 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782331125; cv=none; b=e+Buw2IGgUvuZ8iKbtcOeFDscm/5e9xz6t5lTI6tN0xm56BnhFC23mVQpEYbs7fkJEq3Tn51QAsk1eURaLQc96vMlwPakkqViVgTkjwSw1M8B1EDS7YuQb2fIkLPuZDOf32lPS90tqbKmDDx0Y3S7c6ixhjliHCkgpLc5Wjh7ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782331125; c=relaxed/simple;
	bh=SpLSv/jLHAx1s3HSo1akAK5trq8/6Up1BA+b/MtPJKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThIrV3e9jy1XlfFCGtcxt5irSN2hcTyvWrG0DRcw+jDPMSvcm2xEDnRTpMukoTdzuCDRLUscJzYbEXYCzE674H+W+SORlWCFPVwZqgP85ltNTy6AGrX1AmDpBBxLsqoNPTHuU2Fmc1dJQN9d3LY8SCXh7iop/0YM7bKxTFvk0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ao72++ii; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ao72++ii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1AF1F000E9;
	Wed, 24 Jun 2026 19:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782331123;
	bh=Ea3HIUVto5uwz2Q2ZR8R/Q6C7MwhYo1rdMh3Z+B5Zow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ao72++iiPoFqzJl2YBsSYZPh4n4xYyvUTnNNajCu1hcd6VeiYmJijo77sns55UflP
	 NA8N08hF0H6bhwqDP5WTDg9sz8tarvMFAvc44L4tSqSDk2597ikCgRgUost2aQ5EuX
	 RJ9oC+Pk2tojI6Mv/PuwNDVTUATo1AF9E1pIyB6eXf8S062mrsmBghZiFbqz73T5f4
	 0vv4BICnJ1iJ90boPuH3mp0gGONcbnX0TgfLF40SDaqSaXVQlEb6iHCc2oaJgxWIpa
	 rNlITbjYWM5xWsGZjxa7oX0tWJXs4CxYQSt6ViNAR2XapvEAMulGStLUKkotZGC3xf
	 ksgLCYQ6z/eFw==
Date: Wed, 24 Jun 2026 12:58:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Michael Jeanson <mjeanson@efficios.com>,
	Dmitrii Dolgov <9erthalion6@gmail.com>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Yuzhuo Jing <yuzhuo@google.com>, Leo Yan <leo.yan@arm.com>,
	German Gomez <german.gomez@arm.com>,
	Anubhav Shelat <ashelat@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1 0/3] perf pmu: Add tool-provided NVMe PMU
Message-ID: <ajw28nITeOgtH0GF@google.com>
References: <20260609070348.541964-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609070348.541964-1-irogers@google.com>

On Tue, Jun 09, 2026 at 12:03:45AM -0700, Ian Rogers wrote:
> This patch series introduces a tool-provided PMU for NVMe devices to expose
> various hardware logs as perf events.
> 
> Using libnvme, the new nvme_pmu extracts metrics from standard NVMe log pages
> including:
> - SMART / Health Information (e.g. data units read/written, power cycles,
>   temperature)
> - Endurance Group Information
> - FDP (Flexible Data Placement) Statistics
> - Error Information
> - Zoned Namespaces (ZNS) Changed Zones
> 
> Key features:
> - Dynamic probing of supported log pages on /dev/nvmeX. Unsupported events
>   are marked as deprecated and hidden from `perf list` by default.
> - Generic configuration encoding where the log type, size, and offset are
>   encoded directly into the event configuration.
> - Correct interval delta tracking using baseline offset snapshots. This mimics
>   the behavior of the hwmon PMU, allowing gauges like Temperature to be
>   reported instantaneously in `perf stat -I`, while standard counters
>   correctly accumulate deltas.
> - Robust handling of cross-architecture endianness when reading 128-bit and
>   64-bit fields from the NVMe specification.

Can you please show actual output so that we can understand what you're
doing?

Thanks,
Namhyung

> 
> The series is broken down into:
> 1. Adding the libnvme feature detection via pkg-config in tools/build.
> 2. The core implementation of the NVMe tool PMU.
> 3. A unit test suite verifying the parsing and encoding of the NVMe PMU
>    events using a mocked device.
> 
> Ian Rogers (3):
>   perf build: Add libnvme feature detection
>   perf pmu: Implement tool-provided NVMe PMU
>   perf tests: Add NVMe PMU event parsing test
> 
>  tools/build/Makefile.feature       |   2 +
>  tools/build/feature/Makefile       |   3 +
>  tools/build/feature/test-libnvme.c |  11 +
>  tools/perf/Makefile.config         |  12 +
>  tools/perf/tests/Build             |   1 +
>  tools/perf/tests/builtin-test.c    |   1 +
>  tools/perf/tests/nvme_pmu.c        | 176 ++++++++++
>  tools/perf/tests/tests.h           |   1 +
>  tools/perf/util/Build              |   1 +
>  tools/perf/util/evsel.c            |  11 +-
>  tools/perf/util/nvme_pmu.c         | 535 +++++++++++++++++++++++++++++
>  tools/perf/util/nvme_pmu.h         | 143 ++++++++
>  tools/perf/util/pmu.c              |  15 +
>  tools/perf/util/pmu.h              |   8 +-
>  tools/perf/util/pmus.c             |  31 +-
>  tools/perf/util/pmus.h             |   1 +
>  16 files changed, 945 insertions(+), 7 deletions(-)
>  create mode 100644 tools/build/feature/test-libnvme.c
>  create mode 100644 tools/perf/tests/nvme_pmu.c
>  create mode 100644 tools/perf/util/nvme_pmu.c
>  create mode 100644 tools/perf/util/nvme_pmu.h
> 
> -- 
> 2.54.0.1064.gd145956f57-goog
> 
