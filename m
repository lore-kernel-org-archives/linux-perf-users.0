From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v3 12/12] perf test: improve pmu event metric testing
Date: Thu, 30 Apr 2020 12:44:00 +0100
Message-ID: <6a3d68fd-c489-c0d5-8612-69f15be1bf64@huawei.com>
References: <20200430075144.132716-1-irogers@google.com>
 <20200430075144.132716-13-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200430075144.132716-13-irogers@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paul Clarke <pc@us.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kajoljain <kjain@linux.ibm.com>, linux-perf-user
Cc: Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On 30/04/2020 08:51, Ian Rogers wrote:
> Add a basic floating point number test to expr.
> Break pmu-events test into 2 and add a test to verify that all pmu metric
> expressions simply parse.

Could we add also add something in jevents to ensure this?

Thanks,
John

  Try to parse all metric ids/events, failing if
> metrics for the current architecture fail to parse.
> 
