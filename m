From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/urgent fixes and some improvements
Date: Sat, 4 Apr 2020 10:37:00 +0200
Message-ID: <20200404083700.GB21353@gmail.com>
References: <20200403145443.24774-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200403145443.24774-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andreas Gerstmayr <agerstmayr@redhat.com>, Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>, Hagen Paul Pfeifer <hagen@jauu.net>, He Zhe <zhe.he@windriver.com>, Ian Rogers <irogers@google.com>, Jin Yao <yao.jin@linux.intel.com>, kbuild test robot <lkp@intel.com>, Kemeng Shi <shikemeng@huawei.com>, kernel test robot <rong.a.chen@intel.com>, Kim Phillips <kim.phillips@amd.com>, Naresh Kamboju <naresh.kamboju@linaro.org>, Sam Lunt <samuel.j.lunt@gmail.com>, Stephane Eranian <eranian@google.com>, Tony
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling, this is on top of a previous submitted
> perf-core-for-mingo-5.7-20200325 tag,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 0d33b34352531ff7029c58eda2321340c0ea3f5f:
> 
>   perf dso: Fix dso comparison (2020-03-24 10:57:38 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.7-20200403
> 
> for you to fetch changes up to 9ff76cea4e9e6d49a6f764ae114fc0fb8de97816:
> 
>   perf python: Fix clang detection to strip out options passed in $CC (2020-04-03 10:04:59 -0300)

>  68 files changed, 1376 insertions(+), 78 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
