From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/11] perf/urgent fixes
Date: Thu, 18 Oct 2018 07:44:15 +0200
Message-ID: <20181018054415.GA62071@gmail.com>
References: <20181017225501.32150-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181017225501.32150-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, "David S . Miller" <davem@davemloft.net>, Drew Schmitt <dasch@google.com>, Hadrien Grasland <grasland@lal.in2p3.fr>, "Herton R. Krzesinski" <herton@redhat.com>, Jarod Wilson <jarod@redhat.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, John Garry <john.garry@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Michael Petlan <mpetlan@redhat.com>, Milian Wolff <milia>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> Best Regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit c1883f10cfe05c707cce46d6999411c50a2413ca:
> 
>   Merge tag 'perf-urgent-for-mingo-4.19-20181005' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2018-10-05 18:14:00 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.19-20181017
> 
> for you to fetch changes up to edeb0c90df3581b821a764052d185df985f8b8dc:
> 
>   perf tools: Stop fallbacking to kallsyms for vdso symbols lookup (2018-10-17 15:56:15 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Stop fallbacking to kallsyms for vDSO symbols lookup, this wasn't
>   being really used and is not valid in arches such as Sparc, where
>   user and kernel space don't share the address space, relying only on
>   cpumode to figure out what DSOs to lookup (Arnaldo Carvalho de Melo)
> 
> - Align cpu map synthesized events properly, fixing SIGBUS in
>   CPUs like Sparc (David Miller)
> 
> - Fix use of alternatives to find JDIR (Jarod Wilson)
> 
> - Store ids for events with their own cpus when synthesizing user
>   level event details (scale, unit, etc) events, fixing a crash
>   when recording a PMU event with a cpumask defined (Jiri Olsa)
> 
> - Fix wrong filter_band* values for uncore Intel vendor events (Jiri Olsa)
> 
> - Fix detection of tracefs path in systems without tracefs, where
>   that path should be the debugfs mountpoint plus "/tracing/" (Jiri Olsa)
> 
> - Pass build flags to traceevent build, allowing using alternative
>   flags in distro packages, RPM, for instance (Jiri Olsa)
> 
> - Fix 'perf report' crash on invalid inline debug information (Milian Wolff)
> 
> - Synch kvm uapi copies (Arnaldo Carvalho de Melo)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (3):
>       tools arch uapi: Sync the x86 kvm.h copy
>       tools headers uapi: Sync kvm.h copy
>       perf tools: Stop fallbacking to kallsyms for vdso symbols lookup
> 
> David Miller (1):
>       perf cpu_map: Align cpu map synthesized events properly.
> 
> Jarod Wilson (1):
>       perf tools: Fix use of alternatives to find JDIR
> 
> Jiri Olsa (5):
>       Revert "perf tools: Fix PMU term format max value calculation"
>       perf vendor events intel: Fix wrong filter_band* values for uncore events
>       perf evsel: Store ids for events with their own cpus perf_event__synthesize_event_update_cpus
>       perf tools: Fix tracing_path_mount proper path
>       perf tools: Pass build flags to traceevent build
> 
> Milian Wolff (1):
>       perf report: Don't crash on invalid inline debug information
> 
>  tools/arch/x86/include/uapi/asm/kvm.h              |  1 +
>  tools/include/uapi/linux/kvm.h                     |  1 +
>  tools/lib/api/fs/tracing_path.c                    |  4 ++--
>  tools/perf/Makefile.config                         |  2 +-
>  tools/perf/Makefile.perf                           |  2 +-
>  tools/perf/builtin-report.c                        |  1 +
>  .../pmu-events/arch/x86/ivytown/uncore-power.json  | 16 ++++++++--------
>  .../pmu-events/arch/x86/jaketown/uncore-power.json | 16 ++++++++--------
>  tools/perf/util/event.c                            | 22 +++-------------------
>  tools/perf/util/evsel.c                            |  3 +++
>  tools/perf/util/pmu.c                              | 13 +++++++------
>  tools/perf/util/srcline.c                          |  3 +++
>  12 files changed, 39 insertions(+), 45 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
