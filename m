Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010933AFAE6;
	Sat,  3 Oct 2026 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791018619; cv=none; b=aTKLnlAKVv2ccyOlHszxmogSyH2vrHcnbLorDh2a+a4YpDN7NVkHnUCzq/n2DkwwTRemwFSLn6k8O+GKjh1zP/xDMfjZ3+ar92xVRsaltDWq5Qgwe61AJa4aTkELd4b6Wsmo6skGTaehG1Pry38GhsGmDYp1TDZdXCykbgeq+/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791018619; c=relaxed/simple;
	bh=Dr6sJKb7b9UDmB9MRE94u+ZYk7L9k+KPzUJvrosIwus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aX1Nh9DA3oiVnd6rGNl3Ynll9UYW9ErWgDN30TxE/CWbMMFnvaJKqJknTYIuVQL8m4GCx+W8M6R6BGRnlLQ5K0pGmJnpSSoHThz2poyhXU4M3QWcgbZHiX+f/vlTEi4Zl1ykqicchRmZJKEfrmqJrAEoO7nNJNuYUiyWiqY5POg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmKe3Ii9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmKe3Ii9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4841F008A0;
	Sat,  3 Oct 2026 09:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791018615;
	bh=UvxblGiGtFsut8JoBQ8w/0+oKgGm9fB5SoLT7QAqrUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EmKe3Ii9/1FQ5rIAelG5xSQVxyjnRv2ekSRBZRx7c+WpE81QehJ8OfuH8fg9rkWaw
	 WQwaRhsCvD1MYvN1tOSlifNnd1PhID9EZ4dPJd7riUFHLyA7UGrud22zmVjey8/ZTS
	 e6tC7pnkyWf2fywJ3qnt1SXUVQMyXt2plFRdsZ3MUpga/xgJhrJ9Taqw16QB/i2fDn
	 YIiWgzrH3ti89lQaCRcdd7T7pnmX+NJEn2jvV3dEPp8wvOpv2zqWljO3CJwyW9GU4+
	 4arcKBJa7QMaSIsud+x4qEdhoX+b2IgtMv/VQGWDTwMaOmmHw6+DrjiNlyb8HVLmeA
	 ro8n6qVsLE2DQ==
Date: Sat, 3 Oct 2026 11:10:07 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Alice Rogers <alice.mei.rogers@gmail.com>,
	Changbin Du <changbin.du@huawei.com>,
	Tengda Wu <wutengda@huaweicloud.com>, tanze <tanze@kylinos.cn>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 00/13] perf timechart/list/treport: Interactive
 Textual TUIs and perf python session improvements
Message-ID: <asDGb6qOgJzXDpNo@x2>
References: <20261002182624.3259797-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002182624.3259797-1-irogers@google.com>

On Fri, Oct 02, 2026 at 11:26:09AM -0700, Ian Rogers wrote:
> This series adds interactive terminal user interfaces (TUIs) built with
> Python's textual framework for 'perf timechart' (--tui and --live) and
> 'perf list' (--tui), updates 'treport' to progressively display profiles
> while loading in the background, adds headless shell tests for all three
> TUIs, and improves the 'perf' Python extension module to support
> responsive background and live pipe event processing:
> 
> 1. Session and Python extension improvements (patches 1-5):
>    - Skip flushing remaining deferred samples and auxtrace events once
>      session_done() is set so stopping event processing is immediate.
>    - Quietly stop processing events when a Python session callback raises
>      an exception (e.g., to cancel a background load on quit) without
>      corrupting TUI output with reader error messages.
>    - Lazily copy perf_event and perf_sample in process_events() only when
>      a Python callback retains a reference beyond its return, shrinking
>      struct pyrf_event to fit in CPython's small-object allocator.
>    - Lazily unwind and resolve sample callchains only when
>      event.callchain is accessed.
>    - Release the Python GIL around perf_session__new() and
>      perf_session__process_events() (reacquiring it in callbacks and
>      guarding concurrent thread/comm/symbol access) so blocking pipe
>      reads do not freeze TUI threads.

Nice optimizations, applied and tested by running some of the live
python scripts (twatch, ilist, etc)

> 2. 'perf list --tui' and ilist test (patches 6-7):
>    - Add 'perf list --tui' to launch the interactive ilist script via
>      'perf script', and add a shell test driving ilist headlessly.

Applied and tested
 
> 3. Progressive loading in treport and test (patches 8-9):
>    - Load profiles in a background thread in treport.py so the report
>      tree and flame graph are interactive while loading, with lazy tree
>      node creation and a headless shell test.

Ditto
 
> 4. 'perf timechart --tui' and '--live' and tests (patches 10-13):
>    - Add ttimechart.py and 'perf timechart --tui' to interactively view,
>      zoom, and pan per-CPU (busy, frequency, idle), per-task (running,
>      runnable, blocked, wakeups), and I/O timelines along with a summary
>      table.
>    - Add 'perf timechart --live' to stream live scheduler, power, or I/O
>      events from a 'perf record' subprocess over a pipe with a rolling
>      time window, pause/resume via the control pipe, and optional output
>      recording (-o).
>    - Add headless shell tests covering both '--tui' and '--live' modes.

Applied up to patch 11, 12 has an issue, you can resubmit once
addressing the issue.

Thanks,

- Arnaldo
 
> Alice Rogers (6):
>   perf treport: Show the profile while it loads
>   perf test: Add a test for the treport script
>   perf timechart: Add an interactive --tui mode
>   perf test: Add a test for perf timechart --tui
>   perf timechart: Add a --live mode to the TUI
>   perf test: Test perf timechart --live
> 
> Ian Rogers (7):
>   perf session: Don't flush remaining events once processing is done
>   perf python: Quietly stop processing events when a callback raises
>   perf python: Lazily copy events and samples from process_events
>   perf python: Lazily resolve sample callchains
>   perf python: Release the GIL while processing session events
>   perf list: Add a --tui option to launch ilist
>   perf test: Add a test for the ilist script
> 
>  tools/perf/Documentation/perf-list.txt        |   10 +
>  tools/perf/Documentation/perf-timechart.txt   |   24 +
>  tools/perf/builtin-list.c                     |   34 +
>  tools/perf/builtin-timechart.c                |  114 +-
>  tools/perf/python/treport.py                  |  458 ++-
>  tools/perf/python/ttimechart.py               | 2467 +++++++++++++++++
>  tools/perf/tests/shell/test_ilist_python.sh   |  181 ++
>  tools/perf/tests/shell/test_treport_python.sh |  247 ++
>  .../tests/shell/test_ttimechart_python.sh     |  537 ++++
>  tools/perf/util/auxtrace.c                    |    7 +
>  tools/perf/util/python.c                      | 1191 +++++---
>  tools/perf/util/session.c                     |    8 +
>  12 files changed, 4754 insertions(+), 524 deletions(-)
>  create mode 100755 tools/perf/python/ttimechart.py
>  create mode 100755 tools/perf/tests/shell/test_ilist_python.sh
>  create mode 100755 tools/perf/tests/shell/test_treport_python.sh
>  create mode 100755 tools/perf/tests/shell/test_ttimechart_python.sh
> 
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
