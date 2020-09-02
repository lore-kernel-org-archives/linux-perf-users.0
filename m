From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v6 1/5] perf/jevents: Remove jevents.h file
Date: Wed, 2 Sep 2020 08:25:08 +0100
Message-ID: <6967c008-acda-6df4-799a-a657ec231476@huawei.com>
References: <20200827130958.189146-1-kjain@linux.ibm.com>
 <20200827130958.189146-2-kjain@linux.ibm.com> <20200831084348.GB287892@krava>
 <ca73d0ff-0dfa-8d9e-1cb8-5791a78eb4e2@huawei.com>
 <92f58d69-849a-5df4-6b24-87542138806d@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <92f58d69-849a-5df4-6b24-87542138806d@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: kajoljain <kjain@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 01/09/2020 06:56, kajoljain wrote:
>>>> +#define min(x, y) ({                \
>>>> +    typeof(x) _min1 = (x);            \
>>>> +    typeof(y) _min2 = (y);            \
>>>> +    (void)(&_min1 == &_min2);        \
>>>> +    _min1 < _min2 ? _min1 : _min2; })
>>>> +#endif
>> Wondering what is special about this definition of min that it's required? Compiled ok for me without it.
> Hi John,
>       You are right, for me also in power it compiled without any issues, but not sure if somewhere we have dependency,
> that's why I didn't remove it.

If it builds for x86, then that's main thing ;) But seriously, Arnaldo 
has lots of bots to test builds also.

BTW, I got this from your patchset:

pmu-events/jevents.c:98:29: warning: no previous prototype for 
‘get_cpu_str’ [-Wmissing-prototypes]
__attribute__((weak)) char *get_cpu_str(void)
                             ^~~~~~~~~~~
pmu-events/jevents.c:529:5: warning: no previous prototype for 
‘json_events’ [-Wmissing-prototypes]
int json_events(const char *fn,
     ^~~~~~~~~~~

But I think that you will remove this.

Finally, generated pmu-events.c looks ok for arm64, which I am 
interested in.

Thanks,
John
