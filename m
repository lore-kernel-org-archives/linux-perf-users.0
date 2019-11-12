From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Tue, 12 Nov 2019 12:08:09 +0100
Message-ID: <20191112110809.GA106922@gmail.com>
References: <20191107190011.23924-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Ian Rogers <irogers@google.com>, Igor Lubashev <ilubashe@akamai.com>, James Clark <james.clark@arm.com>, Jin Yao <yao.jin@linux.intel.com>, Jiwei Sun <jiwei.sun@windriver.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, Will Deacon <will@kernel.org>, Yunfeng Ye <yeyunfeng@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit d44f821b0e13275735e8f3fe4db8703b45f05d52:
> 
>   perf/core: Optimize perf_init_event() for TYPE_SOFTWARE (2019-10-28 12:53:28 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.5-20191107
> 
> for you to fetch changes up to 7fa46cbf20d327d78114b1c8c7e69fabe7c57794:
> 
>   perf report: Sort by sampled cycles percent per block for tui (2019-11-07 10:14:48 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:

>  87 files changed, 22145 insertions(+), 19453 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
