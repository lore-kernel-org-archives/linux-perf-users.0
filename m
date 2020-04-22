From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 2/8] perf metrics: fix parse errors in cascade lake metrics
Date: Wed, 22 Apr 2020 08:34:02 -0700
Message-ID: <CAP-5=fUnWAycQehCJ9=btquV2c3DVDX+tTEc85H8py9Kfehq4w@mail.gmail.com>
References: <20200422074809.160248-1-irogers@google.com> <20200422074809.160248-3-irogers@google.com>
 <20200422143840.GJ608746@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200422143840.GJ608746@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Apr 22, 2020 at 7:38 AM Andi Kleen <ak@linux.intel.com> wrote:
>
> On Wed, Apr 22, 2020 at 12:48:03AM -0700, Ian Rogers wrote:
> > Remove over escaping with \\.
> > Remove extraneous if 1 if 0 == 1 else 0 else 0.
>
> So where do these parse errors happen exactly? Some earlier
> patches introduced them as regressions?

I'll work to track down a Fixes tag. I can repro the Skylakex errors
without the test in this series, by doing:

$ perf stat -M DRAM_Read_Latency sleep 1
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (cha/event=0x36\,uma
sk=0x21/).
/bin/dmesg | grep -i perf may provide additional information.

This was just the escaping issue. I'm less clear on the other cascade
lake issue, and it is a bit more work for me to test on cascade lake.
What is "if 1 if 0 == 1 else 0 else 0" trying to do? Perhaps hunting
for the Fixes will let me know, but it looks like a copy-paste error.

> The original metrics worked without parse errors as far as I know.

The skylake issue above repros on 5.2.17 and so it seems like it is
broken for a while. The test in this series will prevent this in the
future, but without this patch that test fails.

> If it fixes something earlier it would need Fixes: tags.

Working on it. Thanks for the input!

Ian

> -Andi
