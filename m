From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 1/5] perf bench: add event synthesis benchmark
Date: Thu, 2 Apr 2020 15:41:17 +0200
Message-ID: <20200402134117.GK2518490@krava>
References: <20200401233945.133550-1-irogers@google.com>
 <20200401233945.133550-2-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200401233945.133550-2-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Petr Mladek <pmladek@suse.com>, Andrey Zhizhikin <andrey.z@gmail.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Apr 01, 2020 at 04:39:41PM -0700, Ian Rogers wrote:
> Event synthesis may occur at the start or end (tail) of a perf command.
> In system-wide mode it can scan every process in /proc, which may add
> seconds of latency before event recording. Add a new benchmark that
> times how long event synthesis takes with and without data synthesis.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

awesome, please put the command line example in changelog

jirka
