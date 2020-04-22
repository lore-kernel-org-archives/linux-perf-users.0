From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Wed, 22 Apr 2020 14:09:43 +0200
Message-ID: <20200422120943.GA110748@gmail.com>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andreas Gerstmayr <agerstmayr@redhat.com>, He Zhe <zhe.he@windriver.com>, Ian Rogers <irogers@google.com>, Kajol Jain <kjain@linux.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, Konstantin Kharlamov <hi-angel@yandex.ru>, Stephane Eranian <eranian@google.com>, Thomas Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit cd0943357bc7570f081701d005318c20982178b8:
> 
>   Merge tag 'perf-urgent-for-mingo-5.7-20200414' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2020-04-16 10:21:31 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.8-20200420
> 
> for you to fetch changes up to 12e89e65f446476951f42aedeef56b6bd6f7f1e6:
> 
>   perf hist: Add fast path for duplicate entries check (2020-04-18 09:05:01 -0300)

>  85 files changed, 1851 insertions(+), 513 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
