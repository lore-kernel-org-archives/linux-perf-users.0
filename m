From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 11/11] perf test: add expr test for pmu metrics
Date: Thu, 23 Apr 2020 16:11:06 +0100
Message-ID: <0edf66da-bedf-c5e9-aa2b-e9073a2d0203@huawei.com>
References: <20200422220430.254014-1-irogers@google.com>
 <20200422220430.254014-12-irogers@google.com>
 <20200423112847.GF1136647@krava>
 <CAP-5=fVwfu0s8Sqhs7+aTqN1Gh2SaEu=feOEQssSu9MB+7hk8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAP-5=fVwfu0s8Sqhs7+aTqN1Gh2SaEu=feOEQssSu9MB+7hk8Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paul Clarke <pc@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On 23/04/2020 15:22, Ian Rogers wrote:
> On Thu, Apr 23, 2020 at 4:29 AM Jiri Olsa <jolsa@redhat.com> wrote:
>>
>> On Wed, Apr 22, 2020 at 03:04:30PM -0700, Ian Rogers wrote:
>>
>> SNIP
>>
>>> +
>>> +static int pmu_tests(void)
>>> +{
>>> +     struct pmu_events_map *map;
>>> +     struct pmu_event *pe;
>>> +     int i, j, k;
>>> +     const char **ids;
>>> +     int idnum;
>>> +     int ret = 0;
>>> +     struct expr_parse_ctx ctx;
>>> +     double result;
>>> +
>>> +     i = 0;
>>> +     for (;;) {
>>> +             map = &pmu_events_map[i++];
>>> +             if (!map->table) {
>>> +                     map = NULL;
>>> +                     break;
>>> +             }
>>> +             j = 0;
>>> +             for (;;) {
>>> +                     pe = &map->table[j++];
>>> +                     if (!pe->name && !pe->metric_group && !pe->metric_name)
>>> +                             break;
>>> +                     if (!pe->metric_expr)
>>> +                             continue;
>>
>> so we go throught all the metrics for the current cpu
>> and test the parsing on them.. great!
> 
> It's not just the current CPU (such as skylake) it is every map
> (skylake, cascade lake, etc), but this only works for the architecture
> that jevents built.
> If jevents built all architectures then this could check them as well.
> Perhaps there should be a jevents test suite, but I think even then
> this test has value.

note: there is test__pmu_events(), which verifies that some test events 
generated in pmu-events.c are as expected, and also verifies that we 
create PMU events aliases as expected (for those test events). Nothing 
is done for metrics, ATM.

Thanks,
John
