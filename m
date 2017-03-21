From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/11] perf/core improvements and fixes
Date: Tue, 21 Mar 2017 07:43:28 +0100
Message-ID: <20170321064328.GA30094@gmail.com>
References: <20170321011641.25763-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170321011641.25763-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>, Andi Kleen <ak@linux.intel.com>, Changbin Du <changbin.du@intel.com>, Clark Williams <williams@redhat.com>, David Ahern <dsahern@gmail.com>, Hemant Kumar <hemant@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Li Zhong <zhong@linux.vnet.ibm.com>, Marc Zyngier <marc.zyngier@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Paul Mackerras <paulus@ozlabs.org>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
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
> The following changes since commit 61f63e383784bd0ab6529cfc95ddc59c713afcc9:
> 
>   Merge tag 'perf-core-for-mingo-4.12-20170316' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-03-16 17:29:23 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.12-20170320
> 
> for you to fetch changes up to affa6c169bae8dc9cb1a2d070c7cd2fe1939c5b8:
> 
>   tools headers: Sync {tools/,}arch/powerpc/include/uapi/asm/kvm.h (2017-03-20 15:02:29 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> Fixes:
> 
> - Fix concat_probe_trace_events() in 'perf probe', it should dereference a
>   pointer, not test its value (Ravi Bangoria)
> 
> User visible:
> 
> - Handle partial AUX records, checking if 'kvm_intel.ko' is loaded and
>   if its 'vmm_exclusive' parameter is set to 0, suggesting tweaking
>   it to reduce gaps (Alexander Shishkin)
> 
> Infrastructure:
> 
> - Sync the kvm.h, cpufeatures.h and perf_event.h tools/ headers copies
>   with the kernel (Arnaldo Carvalho de Melo, Alexander Shishkin)
> 
> - 'perf lock' subcommands should include common options, using
>   OPT_PARENT() (Changbin Du)
> 
> - Ditto for 'perf timechart' (Arnaldo Carvalho de Melo)
> 
> Documentation:
> 
>   Correct 'perf stat --no-aggr' description (Ravi Bangoria)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Alexander Shishkin (3):
>       tools lib api fs: Introduce sysfs__read_bool
>       tools include: Sync {,tools/}include/uapi/linux/perf_event.h
>       perf tools: Handle partial AUX records and print a warning
> 
> Arnaldo Carvalho de Melo (5):
>       perf lock: Make 'f' part of the common 'lock_options'
>       perf timechart: Use OPT_PARENT for common options
>       tools headers: Sync {tools/,}arch/x86/include/asm/cpufeatures.h
>       tools headers: Sync {tools/,}arch/arm{64}/include/uapi/asm/kvm.h
>       tools headers: Sync {tools/,}arch/powerpc/include/uapi/asm/kvm.h
> 
> Changbin Du (1):
>       perf lock: Subcommands should include common options
> 
> Ravi Bangoria (2):
>       perf stat: Correct --no-aggr description
>       perf probe: Fix concat_probe_trace_events
> 
>  tools/arch/arm/include/uapi/asm/kvm.h     | 13 +++++++++++++
>  tools/arch/arm64/include/uapi/asm/kvm.h   | 13 +++++++++++++
>  tools/arch/powerpc/include/uapi/asm/kvm.h | 22 ++++++++++++++++++++++
>  tools/arch/x86/include/asm/cpufeatures.h  |  3 ++-
>  tools/include/uapi/linux/perf_event.h     |  1 +
>  tools/lib/api/fs/fs.c                     | 29 +++++++++++++++++++++++++++++
>  tools/lib/api/fs/fs.h                     |  1 +
>  tools/perf/Documentation/perf-stat.txt    |  3 +--
>  tools/perf/builtin-lock.c                 | 22 ++++++++++++----------
>  tools/perf/builtin-timechart.c            | 16 +++++++---------
>  tools/perf/util/event.c                   |  5 +++--
>  tools/perf/util/event.h                   |  1 +
>  tools/perf/util/probe-event.c             |  2 +-
>  tools/perf/util/session.c                 | 27 ++++++++++++++++++++++++---
>  14 files changed, 130 insertions(+), 28 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
