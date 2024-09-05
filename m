Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BCC7FD;
	Thu,  5 Sep 2024 04:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509381; cv=none; b=b6/ZqXSs4QcI6ivYOkgZ0m9T+oZZJ+wyPRHTynQ18dl1pjOFWeExlp7aTsupoCHPwOmdtoZzu2jmP8Ork6ci+NYfHQNQ2t3gyUgklZS8bqDEXtJnVhBgD9qH6Qf++4V32WD2rG4oXDvQcJP9gcPT3Uf0XovrBBb8YuYcu+lq+sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509381; c=relaxed/simple;
	bh=CgFAoE0nEzqrslNgPcZtYsFOVnY2AUEo7ZAOGjHf8dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTIzFIN2S1jXfxACgEEpTNVRegVyeE3g/JVtC4JureG0eZREQW6D4XnECgF7Fu/mdIa8LiG3urwwd6TGel4sGPZR2PGPufgzgugL5ZkL26YsvdWJ2rWY49/8mQ+jyyP87xsnFVzsvAsYjqNim0CK2WWHDFGbS/3u9ZbfgCjLGoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i07Az2Wp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i07Az2Wp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99605C4CEC4;
	Thu,  5 Sep 2024 04:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725509380;
	bh=CgFAoE0nEzqrslNgPcZtYsFOVnY2AUEo7ZAOGjHf8dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i07Az2WpYl8ZXEjoDLtqgJJH0QeQXjEUmKM3RNMfNxYlwNPZRC9Gcgp3TRHUih53c
	 yyKwBlXwblAYolGW0LB+FQsxw8/W+XgCdqMXTXOvcUyarK0WFdjucdVJ80KmXbJc1C
	 R5thTg4RHm0ngmkTo35GC07zVgv3HkV6kOU3F08yxmMqaJJi+7RfnlSc2sBFOBN41t
	 AlhB0gQlwdwnmDJiDTFSp1Z+craXkvc5fKuxfGUNmVvhfqx138SmVBG4pOVnLvsBCh
	 3IQqmAuWazlqS70Lsr2Xorzvc9M1uFLyPA2sJkm2pcusVj4Ab5xms3uVeOYdvxSZ1f
	 iUZqhy2RAG7kw==
Date: Wed, 4 Sep 2024 21:09:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com, ak@linux.intel.com,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Howard Chu <howardchu95@gmail.com>, Ze Gao <zegao2021@gmail.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] Event parsing fixes
Message-ID: <ZtkvAtvRk2Mbb7e8@google.com>
References: <20240903102005.78049-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240903102005.78049-1-james.clark@linaro.org>

On Tue, Sep 03, 2024 at 11:19:44AM +0100, James Clark wrote:
> I rebased this one and made some other fixes so that I could test it,
> so I thought I'd repost it here in case it's helpful. I also added a
> new test.
> 
> But for the testing it all looks ok.
> 
> There is one small difference where it now hides _all_ default
> <not supported> events, when previously it would only hide some
> selected subset of events like "stalled-cycles-frontend". I think
> this is now more consistent across platforms because, for example,
> Apple M only has cycles and instructions, and the rest of the
> default events would always show as <not supported> there.
> 
> Tested on Raptor Lake, Kaby Lake, Juno, N1, Ampere (with the DSU
> cycles PMU) and I also faked an Apple M on Juno. 
> 
> Changes since v5:
>   * Test on x86 non hybrid
>   * Assume 1 PMU in the test when no PMUs expose /cpus file
> 
> Changes since v4:
> 
>   * Hide all <not supported> default events when not verbose
>   * Remove previous note about <not supported> behavior from the cover
>     letter and replace it with a new note about the new behavior
>  
> Changes since v3:
> 
>   * Rebase onto perf-tools-next 6236ebe07
>   * Fix Intel TPEBS counting mode test
>   * Fix arm-spe build
>   * Add support for DT devices in stat test
>   * Add a new test for hybrid perf stat default arguments
> 
> Ian Rogers (5):
>   perf evsel: Add alternate_hw_config and use in evsel__match
>   perf stat: Uniquify event name improvements
>   perf stat: Remove evlist__add_default_attrs use strings
>   perf evsel x86: Make evsel__has_perf_metrics work for legacy events
>   perf evsel: Remove pmu_name
> 
> James Clark (2):
>   perf test: Make stat test work on DT devices
>   perf test: Add a test for default perf stat command

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/arch/arm64/util/arm-spe.c          |   4 +-
>  tools/perf/arch/x86/util/evlist.c             |  74 +----
>  tools/perf/arch/x86/util/evsel.c              |  35 ++-
>  tools/perf/builtin-diff.c                     |   6 +-
>  tools/perf/builtin-stat.c                     | 291 +++++++-----------
>  tools/perf/tests/parse-events.c               |   2 +-
>  tools/perf/tests/shell/stat.sh                |  37 ++-
>  .../perf/tests/shell/test_stat_intel_tpebs.sh |  11 +-
>  tools/perf/util/evlist.c                      |  46 +--
>  tools/perf/util/evlist.h                      |  12 -
>  tools/perf/util/evsel.c                       |  28 +-
>  tools/perf/util/evsel.h                       |  22 +-
>  tools/perf/util/metricgroup.c                 |   4 +-
>  tools/perf/util/parse-events.c                |  58 ++--
>  tools/perf/util/parse-events.h                |   8 +-
>  tools/perf/util/parse-events.y                |   2 +-
>  tools/perf/util/pmu.c                         |   6 +-
>  tools/perf/util/pmu.h                         |   2 +-
>  tools/perf/util/stat-display.c                | 109 +++++--
>  tools/perf/util/stat-shadow.c                 |  14 +-
>  tools/perf/util/stat.c                        |   2 +-
>  21 files changed, 360 insertions(+), 413 deletions(-)
> 
> -- 
> 2.34.1
> 
