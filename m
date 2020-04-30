From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v3 12/12] perf test: improve pmu event metric testing
Date: Thu, 30 Apr 2020 18:53:28 +0100
Message-ID: <49698917-cdc0-52d5-9c08-ba82f8438657@huawei.com>
References: <20200430075144.132716-1-irogers@google.com>
 <20200430075144.132716-13-irogers@google.com>
 <6a3d68fd-c489-c0d5-8612-69f15be1bf64@huawei.com>
 <CAP-5=fUA3UDNdreJBhdLBPgyFUutN_qUqaL-Diu3yihSDc_niw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAP-5=fUA3UDNdreJBhdLBPgyFUutN_qUqaL-Diu3yihSDc_niw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paul Clarke <pc@us.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kajoljain <kjain@linux.ibm.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger>
List-Id: linux-perf-users.vger.kernel.org

On 30/04/2020 15:31, Ian Rogers wrote:
> On Thu, Apr 30, 2020 at 4:44 AM John Garry <john.garry@huawei.com> wrote:
>>
>> On 30/04/2020 08:51, Ian Rogers wrote:
>>> Add a basic floating point number test to expr.
>>> Break pmu-events test into 2 and add a test to verify that all pmu metric
>>> expressions simply parse.
>>
>> Could we add also add something in jevents to ensure this?
> 
> I think it is an interesting possibility. Instead of strings we could
> also parse the metrics into C functions, that could cause build time
> errors at least for the simple expressions. An issue I've faced is
> that if jevents fails, such as a json parse error, it has an exit code
> of 0 and creates an empty map file. This allows the build to proceed
> but with the pmu-events functionality broken. I'd prefer a build to
> fail as early as possible.

Yeah, the idea is to allow perf to continue to build even when we have 
broken JSONs, but without aliases. It's been that way since day one, so 
maybe that can be turned off now.

Thanks,
John
