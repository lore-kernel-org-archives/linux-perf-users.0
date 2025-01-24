Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C1129406;
	Fri, 24 Jan 2025 23:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762863; cv=none; b=R69KkKv/+Wy29RC6iG3sBeUEOLBNV5G+LkMC2cHmQGBd8gHhbEK3gbB74YUk3ebxAAI0W/ORJ2Y6xeFR1l31IA0pEDepVZvQiohUhIZWxrMQCkrlhNqJIQGnAlC1kMwyDQ2waEFuzeMIgoztRI24tYf7QxKtxrkhD7qvOaYW/R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762863; c=relaxed/simple;
	bh=1Fcf5zFsQ3NoO0seBKax63vY8tXH9/FpZnpBs2crnaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUu0e1GaZljU/Qa5KY7KbyRc+OnYFTUI4Xv0ch7ihzJ0nMAZkqIlF2wCL3eaWvPZHiRoLMtkVMcSsQddUd0AcOUi/DG3ePdp0peN5lRWJIGSt7l9YM/aEKPyeOJdWi6PEW6uJACgRLlBYoseMXPoVE6othDezDsLgDLw/lxwPRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VE0s5TL8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE0s5TL8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B83C4CED2;
	Fri, 24 Jan 2025 23:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737762863;
	bh=1Fcf5zFsQ3NoO0seBKax63vY8tXH9/FpZnpBs2crnaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VE0s5TL8eOmU82dCy0QwdFXurVRttEPnaZOJ+DENQfpTrmmqFUeVJDtHhIwi3JpOL
	 2wKofFRTZyMmNg5KU/nYkby4DztEvJGpEL+jgg7HeZYKdXnaxu0fUu9sndGTVruEvB
	 spsAQO5XLfBAFygFb4nAUGpIaUlkvI4QDIgUlkjfACnEwtkM0L1J9Lh9jeNJQmagal
	 ezp7UgzJyNHsATA5w9SOLaLhBKOa7KhmFoS0t7zvw7WMls4vIYjT77W+NBvno8eo7K
	 qIJu+IEwOaxSXt8wR6DXVu0jsAq0yMSIe9U4CY5YaJduxnOrKS0YJzkLwOwpBuiGWR
	 wJGQL2RMg98qQ==
Date: Fri, 24 Jan 2025 15:54:21 -0800
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
	John Garry <john.g.garry@oracle.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 0/6] Mypy and pylint build support
Message-ID: <Z5QoLTut5eApiOxX@google.com>
References: <20241025172303.77538-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025172303.77538-1-irogers@google.com>

On Fri, Oct 25, 2024 at 10:22:57AM -0700, Ian Rogers wrote:
> Support building perf checking the python code with mypy and/or
> pylint. Currently there are too many errors to make this a default.
> 
> Shellcheck generates no output on success, so linking shellcheck files
> doesn't cause `ld` to fail. Mypy and pylint generate output that will
> break `ld` so change the Makefile.build to ignore test log files.
> 
> Address some initial mypy errors.
> 
> Ian Rogers (6):
>   tools/build: Don't pass test log files to linker
>   perf build: Rename TEST_LOGS to SHELL_TEST_LOGS
>   perf build: Add mypy build tests
>   perf build: Add pylint build tests
>   perf test: Address attr.py mypy error
>   perf python: Fix setup.py mypy errors

It doesn't apply to the perf-tools-next cleanly.  Can you please rebase?

Thanks,
Namhyung

> 
>  tools/build/Makefile.build         |  6 +++++-
>  tools/perf/Build                   | 32 +++++++++++++++++++++++++++---
>  tools/perf/Makefile.perf           | 14 +++++++++++--
>  tools/perf/arch/x86/Build          |  6 +++---
>  tools/perf/arch/x86/tests/Build    |  6 +++---
>  tools/perf/pmu-events/Build        | 25 ++++++++++++++++++++++-
>  tools/perf/scripts/Build           | 26 ++++++++++++++++++++++++
>  tools/perf/tests/Build             | 32 +++++++++++++++++++++++++++---
>  tools/perf/tests/shell/lib/attr.py |  8 +-------
>  tools/perf/trace/beauty/Build      |  6 +++---
>  tools/perf/util/Build              | 31 ++++++++++++++++++++++++++---
>  tools/perf/util/setup.py           | 10 ++++++++--
>  12 files changed, 171 insertions(+), 31 deletions(-)
> 
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 
