From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 0/7] perf/urgent fixes
Date: Fri, 12 Apr 2019 18:33:07 +0200
Message-ID: <20190412163307.GB123006@gmail.com>
References: <20190412142946.21966-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190412142946.21966-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, "Gustavo A . R . Silva" <gustavo@embeddedor.com>, Mao Han <han_mao@c-sky.com>, Peter Zijlstra <peterz@infradead.org>, Rikard Falkeborn <rikard.falkeborn@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit 6d3edaae16c6c7d238360f2841212c2b26774d5e:
> 
>   x86/perf/amd: Resolve NMI latency issues for active PMCs (2019-04-03 11:40:32 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.1-20190412
> 
> for you to fetch changes up to 21e6dfe04861c2c1b529f2759850bc62a80ca050:
> 
>   perf evsel: Use hweight64() instead of hweight_long(attr.sample_regs_user) (2019-04-10 10:25:28 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> core:
> 
>   Mao Han:
> 
>   - Use hweight64() instead of hweight_long(attr.sample_regs_user) when parsing
>     samples, this is what the kernel uses and fixes de problem in 32-bit
>     architectures such as C-SKY that have more than 32 registers that can come
>     in a sample.
> 
> perf stat:
> 
>   Jiri Olsa:
> 
>   - Disable DIR_FORMAT feature for 'perf stat record', fixing an assert()
>     failure.
> 
> Intel PT:
> 
>   Adrian Hunter:
> 
>   - Fix use of parent_id in calls_view in export-to-sqlite.py.
> 
> BPF:
> 
>   Gustavo A. R. Silva:
> 
>   - Fix lock/unlock imbalances when processing BPF/BTF info, found by the
>     coverity tool.
> 
> libtraceevent:
> 
>   Rikard Falkeborn:
> 
>   - Fix missing equality check for strcmp(), detected by the cppcheck tool.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (1):
>       perf scripts python: export-to-sqlite.py: Fix use of parent_id in calls_view
> 
> Gustavo A. R. Silva (1):
>       perf header: Fix lock/unlock imbalances when processing BPF/BTF info
> 
> Jiri Olsa (1):
>       perf stat: Disable DIR_FORMAT feature for 'perf stat record'
> 
> Lendacky, Thomas (2):
>       x86/perf/amd: Remove need to check "running" bit in NMI handler
>       x86/perf/amd: Fix build failure when CONFIG_HAVE_NMI_WATCHDOG is not set
> 
> Mao Han (1):
>       perf evsel: Use hweight64() instead of hweight_long(attr.sample_regs_user)
> 
> Rikard Falkeborn (1):
>       tools lib traceevent: Fix missing equality check for strcmp
> 
>  arch/x86/events/amd/core.c                    | 21 +++++++++++++++++++--
>  arch/x86/events/core.c                        | 13 +++----------
>  tools/lib/traceevent/event-parse.c            |  2 +-
>  tools/perf/builtin-stat.c                     |  1 +
>  tools/perf/scripts/python/export-to-sqlite.py |  2 +-
>  tools/perf/util/evsel.c                       | 12 ++++++------
>  tools/perf/util/header.c                      | 22 +++++++++++++---------
>  7 files changed, 44 insertions(+), 29 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
