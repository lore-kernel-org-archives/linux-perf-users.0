From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 0/7] perf/urgent fixes
Date: Thu, 31 May 2018 12:40:14 +0200
Message-ID: <20180531104014.GA29957@gmail.com>
References: <20180531103220.24684-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180531103220.24684-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, coresight@lists.linaro.org, Daniel Borkmann <daniel@iogearbox.net>, David Ahern <dsahern@gmail.com>, Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, He Kuang <hekuang@huawei.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Kan Liang <kan.liang@linux.intel.com>, kim.phillips@arm.co, Kim Phillips <kim.phillips@arm.com>, Lakshman
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
> The following changes since commit f3903c9161f0d636a7b0ff03841628928457e64c:
> 
>   Merge tag 'perf-urgent-for-mingo-4.17-20180514' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2018-05-15 08:20:45 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.17-20180531
> 
> for you to fetch changes up to 18a7057420f8b67f15d17087bf5c0863db752c8b:
> 
>   perf tools: Fix perf.data format description of NRCPUS header (2018-05-30 15:40:26 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Fix 'perf test Session topology' segfault on s390 (Thomas Richter)
> 
> - Fix NULL return handling in bpf__prepare_load() (YueHaibing)
> 
> - Fix indexing on Coresight ETM packet queue decoder (Mathieu Poirier)
> 
> - Fix perf.data format description of NRCPUS header (Arnaldo Carvalho de Melo)
> 
> - Update perf.data documentation section on cpu topology
> 
> - Handle uncore event aliases in small groups properly (Kan Liang)
> 
> - Add missing perf_sample.addr into python sample dictionary (Leo Yan)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (1):
>       perf tools: Fix perf.data format description of NRCPUS header
> 
> Kan Liang (1):
>       perf parse-events: Handle uncore event aliases in small groups properly
> 
> Leo Yan (1):
>       perf script python: Add addr into perf sample dict
> 
> Mathieu Poirier (1):
>       perf cs-etm: Fix indexing for decoder packet queue
> 
> Thomas Richter (2):
>       perf test: "Session topology" dumps core on s390
>       perf data: Update documentation section on cpu topology
> 
> YueHaibing (1):
>       perf bpf: Fix NULL return handling in bpf__prepare_load()
> 
>  tools/perf/Documentation/perf.data-file-format.txt |  10 +-
>  tools/perf/tests/topology.c                        |  30 ++++-
>  tools/perf/util/bpf-loader.c                       |   6 +-
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  12 +-
>  tools/perf/util/evsel.h                            |   1 +
>  tools/perf/util/parse-events.c                     | 130 ++++++++++++++++++++-
>  tools/perf/util/parse-events.h                     |   7 +-
>  tools/perf/util/parse-events.y                     |   8 +-
>  .../util/scripting-engines/trace-event-python.c    |   2 +
>  9 files changed, 185 insertions(+), 21 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
