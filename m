From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Fri, 10 Jan 2020 18:50:51 +0100
Message-ID: <20200110175051.GA83292@gmail.com>
References: <20200106160705.10899-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200106160705.10899-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>, David Ahern <dsahern@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Vitaly Chikunov <vt@altlinux.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit b9fb2de0115bbacab36da31fd10483ea66d9cfab:
> 
>   Merge tag 'perf-urgent-for-mingo-5.5-20191223' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-12-23 22:27:44 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.6-20200106
> 
> for you to fetch changes up to 6c4798d3f08b81c2c52936b10e0fa872590c96ae:
> 
>   tools lib: Fix builds when glibc contains strlcpy() (2020-01-06 11:46:10 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes.
> 
> perf record:
> 
>   Alexey Budankov:
> 
>   - Adapt affinity for machines with #CPUs > 1K to overcome current 1024 CPUs
>     mask size limitation of cpu_set_t type.
> 
> perf report/top TUI:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Make ENTER consistently present the pop up menu with and without call
>     chains, to eliminate confusion. The menu continues available at all times
>     use 'm' and '+' can be used to toggle just one call chain level, 'e' for all
>     the call chains for a top level histogram entry and 'E' to expand all call
>     chains in all top level entries. Extra info about these options was added to
>     the pop up menu entries. Pressing 'k' serves as special hotkey to go straight
>     to the main vmlinux entries, to avoid having to press enter and then select
>     "Zoom into the kernel DSO".
> 
> perf sched timehist:
> 
>   David Ahern:
> 
>   - Add support for filtering on CPU.
> 
> perf tests:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Show expected versus obtained values in bp_signal test.
> 
> libperf:
> 
>   Jiri Olsa:
> 
>   - Move to tools/lib/perf.
> 
>   - Add man pages.
> 
> libapi:
> 
>   Andrey Zhizhikin:
> 
>   - Fix gcc9 stringop-truncation compilation error.
> 
> tools lib:
> 
>   Vitaly Chikunov:
> 
>   - Fix builds when glibc contains strlcpy(), which is the case for ALT Linux.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Alexey Budankov (3):
>       tools bitmap: Implement bitmap_equal() operation at bitmap API
>       perf mmap: Declare type for cpu mask of arbitrary length
>       perf record: Adapt affinity to machines with #CPUs > 1K
> 
> Andrey Zhizhikin (1):
>       tools lib api fs: Fix gcc9 stringop-truncation compilation error
> 
> Arnaldo Carvalho de Melo (12):
>       perf tests bp_signal: Show expected versus obtained values
>       perf hists browser: Restore ESC as "Zoom out" of DSO/thread/etc
>       perf report/top: Make ENTER consistently bring up menu
>       perf report/top: Add menu entry for toggling callchain expansion
>       perf report/top: Improve toggle callchain menu option
>       perf hists browser: Generalize the do_zoom_dso() function
>       perf report/top: Add 'k' hotkey to zoom directly into the kernel map
>       perf hists browser: Allow passing an initial hotkey
>       tools ui popup: Allow returning hotkeys
>       perf report/top: Allow pressing hotkeys in the options popup menu
>       perf report/top: Do not offer annotation for symbols without samples
>       perf report/top: Make 'e' visible in the help and make it toggle showing callchains
> 
> David Ahern (1):
>       perf sched timehist: Add support for filtering on CPU
> 
> Jiri Olsa (2):
>       libperf: Move to tools/lib/perf
>       libperf: Add man pages
> 
> Vitaly Chikunov (1):
>       tools lib: Fix builds when glibc contains strlcpy()

>  70 files changed, 1565 insertions(+), 352 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
