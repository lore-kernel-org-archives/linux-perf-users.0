From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v5 0/3] perf synthetic events
Date: Thu, 16 Apr 2020 23:19:19 +0900
Message-ID: <CAM9d7cj4fMsnDLgq0rHwqb6_ZLKP-AOzyyAP4kd=b=P5-t5NGQ@mail.gmail.com>
References: <20200415054050.31645-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200415054050.31645-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Petr Mladek <pmladek@suse.com>, Andrey Zhizhikin <andrey.z@gmail.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Ian,

On Wed, Apr 15, 2020 at 2:40 PM Ian Rogers <irogers@google.com> wrote:
>
> Add a multi-threaded version of the internals synthesize benchmark. It
> attempts to compute a time per event synthesized, but as it is reading
> /proc there are issues:
>  - permissions if not run as root
>  - "random" nature of /proc
>
> By default the benchmark is disabled but can be enabled with a
> flag. It has been useful in gauging the value of multi-threaded
> improvements not included here as their value appears minimal.
>
> The patch set includes 2 patches that improve synthesis performance
> and updates the benchmark numbers:
> https://lore.kernel.org/lkml/20200411064248.247530-1-irogers@google.com/
>
> v4 added a missing test file
> v3 improved documenation, return values and added testing to the io framework
>    following feedback from namhyung@kernel.org.
> v2 addressed single threaded synthesize benchmark issues from jolsa@redhat.com
> https://lore.kernel.org/lkml/20200402154357.107873-1-irogers@google.com/
>
> Ian Rogers (3):
>   perf bench: add a multi-threaded synthesize benchmark
>   tools api: add a lightweight buffered reading api
>   perf synthetic events: Remove use of sscanf from /proc reading

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung
