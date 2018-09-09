From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/13] perf/urgent fixes
Date: Sun, 9 Sep 2018 21:39:38 +0200
Message-ID: <20180909193938.GA14324@gmail.com>
References: <20180903145224.12318-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180903145224.12318-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Anton Blanchard <anton@samba.org>, Chris Phlipot <cphlipot0@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Ahern <dsahern@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Hisao Tanabe <xtanabe@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Kim Phillips <kim.phillips@arm.com>, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>, Michael Ellerman <mpe@ellerman.id.au>, Milin
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
> The following changes since commit 66e5db4a1ccc64f278653bc69dc406d184dc750a:
> 
>   Merge tag 'perf-core-for-mingo-4.19-20180820' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2018-08-23 10:29:19 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.19-20180903
> 
> for you to fetch changes up to 4e67b2a5df5d3f341776d12ee575e00ca3ef92de:
> 
>   perf annotate: Fix parsing aarch64 branch instructions after objdump update (2018-08-30 15:51:54 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> Kernel:
> 
> - Modify breakpoint fixes (Jiri Olsa)
> 
> perf annotate:
> 
> - Fix parsing aarch64 branch instructions after objdump update (Kim Phillips)
> 
> - Fix parsing indirect calls in 'perf annotate' (Martin Liška)
> 
> perf probe:
> 
> - Ignore SyS symbols irrespective of endianness on PowerPC (Sandipan Das)
> 
> perf trace:
> 
> - Fix include path for asm-generic/unistd.h on arm64 (Kim Phillips)
> 
> Core libraries:
> 
> - Fix potential null pointer dereference in perf_evsel__new_idx() (Hisao Tanabe)
> 
> - Use fixed size string for comms instead of scanf("%m"), that is
>   not present in the bionic libc and leads to a crash (Chris Phlipot)
> 
> - Fix bad memory access in trace info on 32-bit systems, we were reading
>   8 bytes from a 4-byte long variable when saving the command line in the
>   perf.data file.  (Chris Phlipot)
> 
> Build system:
> 
> - Streamline bpf examples and headers installation, clarifying
>   some install messages. (Arnaldo Carvalho de Melo)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (1):
>       perf tools: Streamline bpf examples and headers installation
> 
> Chris Phlipot (2):
>       perf util: Fix bad memory access in trace info.
>       perf event-parse: Use fixed size string for comms
> 
> Hisao Tanabe (1):
>       perf evsel: Fix potential null pointer dereference in perf_evsel__new_idx()
> 
> Jiri Olsa (5):
>       perf tests: Add breakpoint modify tests
>       perf/hw_breakpoint: Modify breakpoint even if the new attr has disabled set
>       perf/hw_breakpoint: Remove superfluous bp->attr.disabled = 0
>       perf/hw_breakpoint: Enable breakpoint in modify_user_hw_breakpoint
>       perf/hw_breakpoint: Simplify breakpoint enable in perf_event_modify_breakpoint
> 
> Kim Phillips (2):
>       perf arm64: Fix include path for asm-generic/unistd.h
>       perf annotate: Fix parsing aarch64 branch instructions after objdump update
> 
> Martin Liška (1):
>       perf annotate: Properly interpret indirect call
> 
> Sandipan Das (1):
>       perf probe powerpc: Ignore SyS symbols irrespective of endianness
> 
>  kernel/events/core.c                              |  11 +-
>  kernel/events/hw_breakpoint.c                     |  13 +-
>  tools/perf/Makefile.perf                          |  14 +-
>  tools/perf/arch/arm64/Makefile                    |   5 +-
>  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl |   6 +-
>  tools/perf/arch/powerpc/util/sym-handling.c       |   4 +-
>  tools/perf/arch/x86/include/arch-tests.h          |   1 +
>  tools/perf/arch/x86/tests/Build                   |   1 +
>  tools/perf/arch/x86/tests/arch-tests.c            |   6 +
>  tools/perf/arch/x86/tests/bp-modify.c             | 213 ++++++++++++++++++++++
>  tools/perf/util/annotate.c                        |  32 +++-
>  tools/perf/util/annotate.h                        |   1 +
>  tools/perf/util/evsel.c                           |   5 +-
>  tools/perf/util/trace-event-info.c                |   2 +-
>  tools/perf/util/trace-event-parse.c               |   7 +-
>  15 files changed, 282 insertions(+), 39 deletions(-)
>  create mode 100644 tools/perf/arch/x86/tests/bp-modify.c

Pulled into tip:perf/urgent, thanks a lot Arnaldo!

	Ingo
