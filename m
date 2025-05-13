Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBDFB672;
	Tue, 13 May 2025 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747166553; cv=none; b=kaquD5zNgc7Om251jl/C6ipFctnUu5gUMlHtFHt9jXoIKXVGs/1zeYhFxv7q7S13ZU+IXeRv5DXCj7CuBq+7jXXpog5ec0tlYqmDZEYFQQupUyoAuz9lztovXMhnm3YewJAzFb5kGDlVHHS0tjKviP0lPLWTleD9PlJImGe3D+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747166553; c=relaxed/simple;
	bh=p6WCYhpxp8GLyuOSXIMeDTqqLGaMAAOsV7qsxmiGo+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaUlMyYg3dmxJD6fpiJp3ry0iWyTMGyXsQgjD6nZ8Wi3D6S/89FRugaIy/BNRLSIK9QywJk1BUDeHsEG74DtZ1aFwvE3MnlHBTHnl0ts5jQkHiayA5Ih0V2w78LFBB0+IFucnIXmh/Qk09838bBV+7K5ou41hwQr+SXn73upJLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9GkyfPT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9GkyfPT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE51C4CEE4;
	Tue, 13 May 2025 20:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747166553;
	bh=p6WCYhpxp8GLyuOSXIMeDTqqLGaMAAOsV7qsxmiGo+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n9GkyfPTIwQzjPfwG8LPh5FCg6qnjlZXGB48RvSLebYvdF6ZB76Uyq4Ma/zERdsd9
	 tal4NsiHb6FqLW+wLZnOypVQO9PbHyuh8aAijH6/2LqMLqyFBf3U8d68+qkpNt4KGU
	 cIV++1waIZAbVQFZeG74yx2quxh9WerUp3TY4ozBvnZqcDOthDiUASmv2RAMbC7yu5
	 M9UZi6RMj+/a2dB4AvY3XuGOjJ/o2e0YaMeXTHsUZrYbVNyHHu7tf0Ggcjex39ZZjr
	 +e2G2d49fPpA8YyRygjG6OhXRg4hB0hIJwMaUavqK+ITJSiTAYTPOAAQ11x5aMIjUM
	 ln/KzwM5WUnyg==
Date: Tue, 13 May 2025 17:02:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@linaro.org,
	howardchu95@gmail.com, weilin.wang@intel.com, yeoreum.yun@arm.com,
	linux@treblig.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Fix incorrect counts when count the same uncore
 event multiple times
Message-ID: <aCOlViKRwS0kE0tg@x1>
References: <20250512215929.2098240-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512215929.2098240-1-ctshao@google.com>

On Mon, May 12, 2025 at 02:50:29PM -0700, Chun-Tse Shao wrote:
> Let's take a look an example, the machine is SKX with 6 IMC devices.
> 
>   perf stat -e clockticks,clockticks -I 1000
>   #           time             counts unit events
>        1.001127430      6,901,503,174      uncore_imc_0/clockticks/
>        1.001127430      3,940,896,301      uncore_imc_0/clockticks/
>        2.002649722        988,376,876      uncore_imc_0/clockticks/
>        2.002649722        988,376,141      uncore_imc_0/clockticks/
>        3.004071319      1,000,292,675      uncore_imc_0/clockticks/
>        3.004071319      1,000,294,160      uncore_imc_0/clockticks/
> 
> 1) The events name should not be uniquified.
> 2) The initial count for the first `clockticks` is doubled.
> 3) Subsequent count only report for the first IMC device.
> 
> The first patch fixes 1) and 3), and the second patch fixes 2).

So, after having just the first patch applied I'm getting:

  CC      /tmp/build/perf-tools-next/util/bpf-filter-flex.o
util/parse-events.c: In function ‘__parse_events’:
util/parse-events.c:2270:25: error: implicit declaration of function ‘evlist__uniquify_name’; did you mean ‘evlist__uniquify_evsel_names’? [-Wimplicit-function-declaration]
 2270 |                         evlist__uniquify_name(evlist);
      |                         ^~~~~~~~~~~~~~~~~~~~~
      |                         evlist__uniquify_evsel_names
make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:85: /tmp/build/perf-tools-next/util/parse-events.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:142: util] Error 2
make[2]: *** [Makefile.perf:798: /tmp/build/perf-tools-next/perf-util-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....


  CC      /tmp/build/perf-tools-next/pmu-events/pmu-events.o
  LD      /tmp/build/perf-tools-next/pmu-events/pmu-events-in.o
make[1]: *** [Makefile.perf:290: sub-make] Error 2
make: *** [Makefile:119: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
⬢ [acme@toolbx perf-tools-next]$ 
⬢ [acme@toolbx perf-tools-next]$ 
⬢ [acme@toolbx perf-tools-next]$ 
⬢ [acme@toolbx perf-tools-next]$ 
⬢ [acme@toolbx perf-tools-next]$ 
⬢ [acme@toolbx perf-tools-next]$ 
⬢ [acme@toolbx perf-tools-next]$ 
⬢ [acme@toolbx perf-tools-next]$ git log --oneline -3
6ffcaec3ac0d055a (HEAD) perf evlist: Make uniquifying counter names consistent
4102ff8b1fdaa588 perf metricgroup: Binary search when resolving referred to metrics
754baf426e099fbf perf pmu: Change aliases from list to hashmap
⬢ [acme@toolbx perf-tools-next]$

When test building the second patch, it builds, so I'm now looking if
you used things from the future or if the second patch removes the
problem.

- Arnaldo
 
> After these fix:
> 
>   perf stat -e clockticks,clockticks -I 1000
>   #           time             counts unit events
>        1.001127586      4,126,938,857      clockticks
>        1.001127586      4,121,564,277      clockticks
>        2.001686014      3,953,806,350      clockticks
>        2.001686014      3,953,809,541      clockticks
>        3.003121403      4,137,750,252      clockticks
>        3.003121403      4,137,749,048      clockticks
> 
> I also tested `-A`, `--per-socket`, `--per-die` and `--per-core`, all
> looks good.
> 
> Ian tested `hybrid-merge` and `hwmon`, all looks good as well.
> 
> Chun-Tse Shao (1):
>   perf test: Add stat uniquifying test
> 
> Ian Rogers (2):
>   perf evlist: Make uniquifying counter names consistent
>   perf parse-events: Use wildcard processing to set an event to merge
>     into
> 
>  tools/perf/builtin-record.c                   |   7 +-
>  tools/perf/builtin-top.c                      |   7 +-
>  .../tests/shell/stat+event_uniquifying.sh     |  69 ++++++++
>  tools/perf/util/evlist.c                      |  66 +++++---
>  tools/perf/util/evlist.h                      |   3 +-
>  tools/perf/util/evsel.c                       | 119 ++++++++++++-
>  tools/perf/util/evsel.h                       |  11 +-
>  tools/perf/util/parse-events.c                |  90 +++++++---
>  tools/perf/util/stat-display.c                | 160 ++----------------
>  tools/perf/util/stat.c                        |  40 +----
>  10 files changed, 332 insertions(+), 240 deletions(-)
>  create mode 100755 tools/perf/tests/shell/stat+event_uniquifying.sh
> 
> --
> v3: Rebase with tmp.perf-tools-next. Since most of the conflicts are from
> lore.kernel.org/20250403194337.40202-5-irogers@google.com, tested v3
> patches with:
> 
>   perf stat -A -C 0,4-5,8 -e "instructions/cpu=0/,l1d-misses/cpu=4,cpu=5/,inst_retired.any/cpu=8/,cycles" -a sleep 0.1
> 
>    Performance counter stats for 'system wide':
> 
>   CPU0              682,860      instructions/cpu=0/              #    0.27  insn per cycle
>   CPU4               53,774      l1d-misses
>   CPU5               18,725      l1d-misses
>   CPU8              608,698      inst_retired.any/cpu=8/
>   CPU0            2,574,325      cycles
>   CPU4            4,267,115      cycles
>   CPU5            1,741,536      cycles
>   CPU8            1,969,547      cycles
> 
>          0.102746958 seconds time elapsed
> 
> v2: lore.kernel.org/20250327225651.642965-1-ctshao@google.com
>   - Fixes for `hwmon` and `--hybrid-merge`.
>   - Add a test for event uniquifying.
> 
> v1: lore.kernel.org/20250326234758.480431-1-ctshao@google.com
> 
> 2.49.0.1045.g170613ef41-goog
