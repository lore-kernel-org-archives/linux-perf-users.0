From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 0/8] perf/urgent fixes
Date: Fri, 20 Oct 2017 09:16:48 +0200
Message-ID: <20171020071648.lb6nnqlpnyil5qmw@gmail.com>
References: <20171019174515.7407-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171019174515.7407-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Changbin Du <changbin.du@intel.com>, David Ahern <dsahern@gmail.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>, Kim Phillips <kim.phillips@arm.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Philip Li <philip.li@intel.com>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Taeung Song <treeze.taeung@gmail.com>, Thomas-Mich Richter <tmricht@l>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 47a74bdcbfeff543f706dc0e385eebbb5d655ed2:
> 
>   Merge tag 'perf-urgent-for-mingo-4.14-20171010' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2017-10-10 19:21:37 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.14-20171019
> 
> for you to fetch changes up to 74f8e22c153f4464060a0c2e4cfd1d6e51af2109:
> 
>   perf test shell trace+probe_libc_inet_pton.sh: Be compatible with Debian/Ubuntu (2017-10-18 09:14:18 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Fix crash in perf_hpp__reset_output_field() (Jiri Olsa)
> 
> - Fix eBPF file/vendor events ambiguity in event specification (Jiri Olsa)
> 
> - Fix closing evsel fd in 'perf stat' (Jin Yao)
> 
> - Make perf test shell trace+probe_libc_inet_pton.sh pass in Debian/Ubuntu (Li Zhijian)
> 
> - Fix 'perf buildid-list --with-hits' crash when processing PERF_RECORD_NAMESPACE (Namhyung Kim)
> 
> - Fix documentation for a inexistent option 'perf record -l' (Taeung Song)
> 
> - Add long time reviewers to MAINTAINERS (Arnaldo Carvalho de Melo)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (1):
>       perf tools: Add long time reviewers to MAINTAINERS
> 
> Jin Yao (1):
>       perf xyarray: Fix wrong processing when closing evsel fd
> 
> Jiri Olsa (3):
>       perf hists: Fix crash in perf_hpp__reset_output_field()
>       perf hists: Add extra integrity checks to fmt_free()
>       perf tools: Check wether the eBPF file exists in event parsing
> 
> Li Zhijian (1):
>       perf test shell trace+probe_libc_inet_pton.sh: Be compatible with Debian/Ubuntu
> 
> Namhyung Kim (1):
>       perf buildid-list: Fix crash when processing PERF_RECORD_NAMESPACE
> 
> Taeung Song (1):
>       perf record: Fix documentation for a inexistent option '-l'
> 
>  MAINTAINERS                                          |  2 ++
>  tools/perf/Documentation/perf-record.txt             |  4 ++--
>  tools/perf/tests/shell/trace+probe_libc_inet_pton.sh |  9 ++++++---
>  tools/perf/ui/hist.c                                 |  9 ++++++++-
>  tools/perf/util/parse-events.l                       | 17 +++++++++++++++--
>  tools/perf/util/session.c                            |  2 ++
>  tools/perf/util/xyarray.h                            |  4 ++--
>  7 files changed, 37 insertions(+), 10 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
