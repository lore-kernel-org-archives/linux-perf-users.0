From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 0/3] perf/urgent fixes
Date: Tue, 10 Oct 2017 19:23:44 +0200
Message-ID: <20171010172344.btom65sr3pu4d5wa@gmail.com>
References: <20171010152657.27435-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171010152657.27435-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov <ast@fb.com>, Borislav Petkov <bp@alien8.de>, David Ahern <dsahern@gmail.com>, "David S . Miller" <davem@davemloft.net>, Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Santaniello <marksan@fb.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit 874d48f2af91efc38c720e7c6450547f6ea8c843:
> 
>   Merge tag 'perf-urgent-for-mingo-4.14-20171005' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2017-10-05 20:07:08 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.14-20171010
> 
> for you to fetch changes up to aa7b4e02b328f0589b6133e72aafb1289f614a79:
> 
>   tools include uapi bpf.h: Sync kernel ABI header with tooling header (2017-10-09 15:55:45 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Unbreak 'perf record' for arm/arm64 with events with explicit PMU (Mark Rutland)
> 
> - Add missing separator for "perf script -F ip,brstack" (and brstackoff) (Mark Santaniello)
> 
> - One line, comment only, sync kernel ABI header with tooling header (Arnaldo Carvalho de Melo)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (1):
>       tools include uapi bpf.h: Sync kernel ABI header with tooling header
> 
> Mark Rutland (1):
>       perf pmu: Unbreak perf record for arm/arm64 with events with explicit PMU
> 
> Mark Santaniello (1):
>       perf script: Add missing separator for "-F ip,brstack" (and brstackoff)
> 
>  tools/include/uapi/linux/bpf.h |  2 +-
>  tools/perf/builtin-script.c    |  4 +--
>  tools/perf/util/parse-events.c |  9 ++++---
>  tools/perf/util/pmu.c          | 56 +++++++++++++++++++++++++++++++-----------
>  tools/perf/util/pmu.h          |  1 +
>  5 files changed, 50 insertions(+), 22 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
