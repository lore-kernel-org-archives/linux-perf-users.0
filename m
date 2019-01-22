From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 0/7] perf/urgent fixes
Date: Tue, 22 Jan 2019 12:30:08 +0100
Message-ID: <20190122113008.GB113758@gmail.com>
References: <20190121183507.23490-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190121183507.23490-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Song Liu <liu.song.a23@gmail.com>, Stephane Eranian <eranian@google.com>, Tony Jones <tonyj@suse.de>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> Regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 4e72ee8872279a70ebe973172133b98e8acbf54e:
> 
>   Merge tag 'perf-core-for-mingo-5.0-20190110' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-01-11 08:12:09 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.0-20190121
> 
> for you to fetch changes up to 8bf8c6da53c2265aea365a1de6038f118f522113:
> 
>   perf script: Fix crash when processing recorded stat data (2019-01-21 11:29:07 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> Kernel:
> 
>   Stephane Eranian:
> 
>   - Fix perf_proc_update_handler() bug.
> 
> perf script:
> 
>   Andi Kleen:
> 
>   - Fix crash with printing mixed trace point and other events.
> 
>   Tony Jones:
> 
>   - Fix crash when processing recorded stat data.
> 
> perf top:
> 
>   He Kuang:
> 
>   - Fix wrong hottest instruction highlighted.
> 
> perf python:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Remove -fstack-clash-protection when building with some clang versions.
> 
> perf ordered_events:
> 
>   Jiri Olsa:
> 
>   - Fix out of buffers crash in ordered_events__free().
> 
> perf cpu_map:
> 
>   Stephane Eranian:
> 
>   - Handle TOPOLOGY headers with no CPU.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andi Kleen (1):
>       perf script: Fix crash with printing mixed trace point and other events
> 
> Arnaldo Carvalho de Melo (1):
>       perf python: Remove -fstack-clash-protection when building with some clang versions
> 
> He Kuang (1):
>       perf top: Fix wrong hottest instruction highlighted
> 
> Jiri Olsa (1):
>       perf ordered_events: Fix crash in ordered_events__free
> 
> Stephane Eranian (2):
>       perf core: Fix perf_proc_update_handler() bug
>       perf tools: Handle TOPOLOGY headers with no CPU
> 
> Tony Jones (1):
>       perf script: Fix crash when processing recorded stat data
> 
>  kernel/events/core.c              | 14 +++++++-------
>  tools/perf/builtin-script.c       |  9 +++------
>  tools/perf/ui/browsers/annotate.c | 16 ++++++++++------
>  tools/perf/util/cpumap.c          | 11 +++++++++--
>  tools/perf/util/ordered-events.c  |  6 ++++--
>  tools/perf/util/setup.py          |  2 ++
>  6 files changed, 35 insertions(+), 23 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
