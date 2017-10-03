From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 0/8] perf/core improvements and fixes
Date: Tue, 3 Oct 2017 18:38:15 +0200
Message-ID: <20171003163815.dnjrqsxpfc62f4g6@gmail.com>
References: <20171003125540.331-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171003125540.331-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, He Kuang <hekuang@huawei.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>, Lukasz Odzioba <lukasz.odzioba@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	I pulled tip/perf/urgent to pick up fixes, please consider
> pulling, I've been away for a while, so I'll be harvesting outstanding
> patches in the next few days, as well as trying and reviewing more
> complex patchkits,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit c976a7d6db215481261b63a89a408cb265a9812b:
> 
>   Merge remote-tracking branch 'tip/perf/urgent' into perf/core, to pick up fixes (2017-10-02 13:58:12 -0300)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.15-20171003
> 
> for you to fetch changes up to f6a9820d572bd8384d982357cbad214b3a6c04bb:
> 
>   perf tests attr: Fix group stat tests (2017-10-03 09:41:45 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Multithread the synthesizing of PERF_RECORD_ events for pre-existing
>   threads in 'perf top', speeding up that phase, greatly improving the
>   user experience in systems such as Intel's Knights Mill (Kan Liang)
> 
> - 'perf test' fixes for the perf_event_attr test case (Jiri Olsa, Thomas Richter)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Jiri Olsa (2):
>       perf tests attr: Fix task term values
>       perf tests attr: Fix group stat tests
> 
> Kan Liang (4):
>       perf tools: Lock to protect namespaces and comm list
>       perf tools: Lock to protect comm_str rb tree
>       perf top: Implement multithreading for perf_event__synthesize_threads
>       perf top: Add option to set the number of thread for event synthesize
> 
> Thomas Richter (2):
>       perf test attr: Fix python error on empty result
>       perf test attr: Fix ignored test case result
> 
>  tools/perf/Documentation/perf-top.txt            |   3 +
>  tools/perf/builtin-kvm.c                         |   3 +-
>  tools/perf/builtin-record.c                      |   2 +-
>  tools/perf/builtin-top.c                         |  13 +-
>  tools/perf/builtin-trace.c                       |   2 +-
>  tools/perf/tests/attr.c                          |   2 +-
>  tools/perf/tests/attr.py                         |   6 +-
>  tools/perf/tests/attr/base-record                |   2 +-
>  tools/perf/tests/attr/test-record-group          |   1 +
>  tools/perf/tests/attr/test-record-group-sampling |   2 +-
>  tools/perf/tests/attr/test-record-group1         |   1 +
>  tools/perf/tests/attr/test-stat-group            |   2 +
>  tools/perf/tests/attr/test-stat-group1           |   2 +
>  tools/perf/tests/mmap-thread-lookup.c            |   2 +-
>  tools/perf/util/comm.c                           |  18 ++-
>  tools/perf/util/event.c                          | 163 ++++++++++++++++++-----
>  tools/perf/util/event.h                          |   3 +-
>  tools/perf/util/machine.c                        |   8 +-
>  tools/perf/util/machine.h                        |   9 +-
>  tools/perf/util/thread.c                         |  53 +++++++-
>  tools/perf/util/thread.h                         |   3 +
>  tools/perf/util/top.h                            |   1 +
>  22 files changed, 249 insertions(+), 52 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
