Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B231F63C5;
	Tue,  7 Jan 2025 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736278959; cv=none; b=iDXxJszC2Apwof754n4RJPlVfC0RyMq/pKcqsvZwvi67f5WzX3yMWgG6kCK20b+tHzJrFnQPkquWGrQLnHCH3Cm3x5fslr75MSrM/3yPbI5TGVYiORwCQ8LpL9gDB9lw0Pw1zYkmxa5vzi4UN8G8w3yTMqGUd1QXOwzDDnxONTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736278959; c=relaxed/simple;
	bh=LZYbH4+efdzN64InDGZ1UOSWl3OZt6f7izr0a1Ht8hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryNARJsvT1tDxhbhopwYIdY9Xj6/TJgH24n0M6cSg+Zq/2KrHrjnGufC6ut2jzXpqW45q2UsoJvXzdBgqR3RAfbig71iJCyc7Cz0csK0rE9sHIgpExwUbByUyw9Q9L96iT0nc7gy0V7vYpkOshVB1uoX5LcwumpzNki4pOlzXw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBG4Lxyq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBG4Lxyq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5E2C4CED6;
	Tue,  7 Jan 2025 19:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736278959;
	bh=LZYbH4+efdzN64InDGZ1UOSWl3OZt6f7izr0a1Ht8hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pBG4LxyqKVPFs+N4JPMkGrUhhpilriWaEGk2c6nAvUeMC2r8AZNTpzODlB3A8HZRd
	 CYMr3CzOFifVW05e5zG0/aunXCq9HBazm3ns7NwNWaeoVfTTr4Q4zYA73KSgMxBAxF
	 TXT9wibGYdgZwIr7am6ZMCFlGkyk80RexmigToWsBnxbamYBid2Q8kmHAW1Pt2afV5
	 v3MAoM/ROGT74y8NSZ4Bjaz35xn2kricK1jjIg19yP54CBbOCzz/t8pJ6m8bwbvm2q
	 MKrhBmCluKd4gutBFg6s4oa9CrKRu35+IesGSBvtAVaRRc/x41rq+c90XdVLWM2Sry
	 MMkrtkW32QLGA==
Date: Tue, 7 Jan 2025 16:42:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 1/3] perf evsel: Improve the evsel__open_strerror for
 EBUSY
Message-ID: <Z32DrId5qw-IE21R@x1>
References: <20241106003007.2112584-1-ctshao@google.com>
 <CAP-5=fVyDp2TcUGfmxRoKnE8yOp3xgfrJ5tagMiaieTjepEF+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVyDp2TcUGfmxRoKnE8yOp3xgfrJ5tagMiaieTjepEF+A@mail.gmail.com>

On Mon, Jan 06, 2025 at 01:59:25PM -0800, Ian Rogers wrote:
> On Tue, Nov 5, 2024 at 4:30 PM Chun-Tse Shao <ctshao@google.com> wrote:
> >
> > From: Ian Rogers <irogers@google.com>
> >
> > The existing EBUSY strerror message is:
> >
> >   The sys_perf_event_open() syscall returned with 16 (Device or resource busy) for event (intel_bts//).
> >   "dmesg | grep -i perf" may provide additional information.
> >
> > The dmesg won't be useful. What is more useful is knowing what
> > processes are potentially using the PMU, which some procfs scanning can
> > reveal. When parallel testing tests/shell/stat_all_pmu.sh this yields:
> >
> >   Testing intel_bts//
> >   Error:
> >   The PMU intel_bts counters are busy and in use by another process.
> >   Possible processes:
> >   2585882 perf list
> >   2585902 perf list -j -o /tmp/__perf_test.list_output.json.KF9MY
> >   2585904 perf list
> >   2585911 perf record -e task-clock --filter period > 1 -o /dev/null --quiet true
> >   2585912 perf list
> >   2585915 perf list
> >   2586042 /tmp/perf/perf record -asdg -e cpu-clock -o /tmp/perftool-testsuite_report.dIF/perf_report/perf.data -- sleep 2
> >   2589078 perf record -g -e task-clock:u -o - perf test -w noploop
> >   2589148 /tmp/perf/perf record --control=fifo:control,ack -e cpu-clock -m 1 sleep 10
> >   2589379 perf --buildid-dir /tmp/perf.debug.Umx record --buildid-all -o /tmp/perf.data.YBm /tmp/perf.ex.MD5.ZQW
> >   2589568 perf record -o /tmp/__perf_test.program.mtcZH/perf.data --branch-filter any,save_type,u -- perf test -w brstack
> >   2589649 perf record --per-thread -o /tmp/__perf_test.perf.data.5d3dc perf test -w thloop
> >   2589898 perf record -o /tmp/perf-test-script.BX2b27Dcnj/pp-perf.data --sample-cpu uname
> >
> > Which gets a little closer to finding the issue.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping.

Thanks for the ping, great stuff, testing the first patch:

Committer testing:

  root@number:~#
  root@number:~# grep -m1 "model name" /proc/cpuinfo
  model name    : Intel(R) Core(TM) i7-14700K
  root@number:~#

Before:

  root@number:~# perf stat -e intel_bts// &
  [1] 197954
  root@number:~# perf test "perf all PMU test"
  124: perf all PMU test                                               : FAILED!
  root@number:~# perf test -v "perf all PMU test" |& tail
  Testing i915/vecs0-busy/
  Testing i915/vecs0-sema/
  Testing i915/vecs0-wait/
  Testing intel_bts//
  Unexpected signal in main
  Error:
  The sys_perf_event_open() syscall returned with 16 (Device or resource busy) for event (intel_bts//).
  "dmesg | grep -i perf" may provide additional information.
  ---- end(-1) ----
  124: perf all PMU test                                               : FAILED!
  root@number:~#

After:

  root@number:~# perf stat -e intel_bts// &
  [1] 200195
  root@number:~# perf test "perf all PMU test"
  123: perf all PMU test                                               : FAILED!
  root@number:~# perf test -v "perf all PMU test" |& tail
  Testing i915/vecs0-wait/
  Testing intel_bts//
  Unexpected signal in main
  Error:
  The PMU intel_bts counters are busy and in use by another process.
  Possible processes:
  200195 perf stat -e intel_bts//
  2319766 /root/bin/perf top --stdio
  ---- end(-1) ----
  123: perf all PMU test                                               : FAILED!
  root@number:~#
