From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 0/7] perf/urgent fixes
Date: Fri, 29 Sep 2017 19:33:05 +0200
Message-ID: <20170929173305.vyabhunztrfk7x7n@gmail.com>
References: <20170929160017.29335-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37680 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751830AbdI2RdK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Sep 2017 13:33:10 -0400
Content-Disposition: inline
In-Reply-To: <20170929160017.29335-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Akemi Yagi <toracat@elrepo.org>, Alan Bartlett <ajb@elrepo.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, David Ahern <dsahern@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Krister Johansen <kjlx@templeofstupid.com>, Li Bin <huawei.libin@huawei.com>, Mengting Zhang <zhangmengting@huawei.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Taeung Song <treeze.taeung@gmail.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@hu>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit b130a699c07155a1d6ef7d971a5f3bf0e3818d5a:
> 
>   Merge tag 'perf-urgent-for-mingo-4.14-20170912' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2017-09-13 09:25:10 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.14-20170928
> 
> for you to fetch changes up to 5357413f5c067f60933e4b8d79d483fbe62b2bb5:
> 
>   perf test: Fix vmlinux failure on s390x part 2 (2017-09-28 13:01:42 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Fix syscalltbl build failure (Akemi Yagi)
> 
> - Fix attr.exclude_kernel setting for default cycles:p, this time for
>   !root with kernel.perf_event_paranoid = -1 (Arnaldo Carvalho de Melo)
> 
> - Sync kernel ABI headers with tooling headers (Ingo Molnar)
> 
> - Remove misleading debug messages with --call-graph option (Mengting Zhang)
> 
> - Revert vmlinux symbol resolution patches for s390x (Thomas Richter)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Akemi Yagi (1):
>       perf tools: Fix syscalltbl build failure
> 
> Arnaldo Carvalho de Melo (2):
>       perf tools: Get all of tools/{arch,include}/ in the MANIFEST
>       perf evsel: Fix attr.exclude_kernel setting for default cycles:p
> 
> Ingo Molnar (1):
>       tools include: Sync kernel ABI headers with tooling headers
> 
> Mengting Zhang (1):
>       perf report: Fix debug messages with --call-graph option
> 
> Thomas Richter (2):
>       perf test: Fix vmlinux failure on s390x
>       perf test: Fix vmlinux failure on s390x part 2
> 
>  tools/arch/s390/include/uapi/asm/kvm.h         |  6 ++
>  tools/arch/x86/include/asm/cpufeatures.h       |  2 +
>  tools/arch/x86/include/asm/disabled-features.h |  4 +-
>  tools/include/asm-generic/hugetlb_encode.h     | 34 ++++++++++
>  tools/include/uapi/asm-generic/mman-common.h   | 14 +----
>  tools/include/uapi/drm/drm.h                   | 22 +++++++
>  tools/include/uapi/drm/i915_drm.h              | 51 ++++++++++++++-
>  tools/include/uapi/linux/bpf.h                 | 32 ++++++----
>  tools/include/uapi/linux/kvm.h                 |  3 +-
>  tools/include/uapi/linux/mman.h                | 24 ++++++-
>  tools/perf/MANIFEST                            | 87 +-------------------------
>  tools/perf/arch/s390/util/Build                |  1 -
>  tools/perf/arch/s390/util/sym-handling.c       | 29 ---------
>  tools/perf/util/callchain.c                    | 35 ++++++-----
>  tools/perf/util/evsel.c                        |  7 ++-
>  tools/perf/util/symbol-elf.c                   |  8 +--
>  tools/perf/util/symbol.h                       |  3 -
>  tools/perf/util/syscalltbl.c                   |  2 +-
>  18 files changed, 195 insertions(+), 169 deletions(-)
>  create mode 100644 tools/include/asm-generic/hugetlb_encode.h
>  delete mode 100644 tools/perf/arch/s390/util/sym-handling.c

Pulled, thanks a lot Arnaldo!

	Ingo
