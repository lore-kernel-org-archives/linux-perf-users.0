From: Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH] perf script report: fix segfault when using DWARF mode
Date: Mon, 6 Apr 2020 09:28:22 -0500
Message-ID: <f523cfca-5592-c1ea-ad5a-7603c967c0c5@amd.com>
References: <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
 <20200402125417.422232-1-agerstmayr@redhat.com>
 <6a098ce1-1981-dcff-ea62-af5fc07ec7fb@amd.com>
 <20200403124028.GA18559@kernel.org>
 <bf95c9f1-1970-fce4-c6f2-dc231730e7ab@redhat.com>
 <0a942366-c8dd-4767-ee84-fdc0024b035f@redhat.com>
 <20200406125915.GQ9917@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200406125915.GQ9917@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Andreas Gerstmayr <agerstmayr@redhat.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 4/6/20 7:59 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Apr 06, 2020 at 11:30:23AM +0200, Andreas Gerstmayr escreveu:
>> On 03.04.20 15:16, Andreas Gerstmayr wrote:
>>> On 03.04.20 14:40, Arnaldo Carvalho de Melo wrote:
>>>> Em Thu, Apr 02, 2020 at 02:07:51PM -0500, Kim Phillips escreveu:
>>>>> On 4/2/20 7:54 AM, Andreas Gerstmayr wrote:
>>>>>> When running perf script report with a Python script and a callgraph in
>>>>>> DWARF mode, intr_regs->regs can be 0 and therefore crashing
>>>>>> the regs_map
>>>>>> function.
>>>>>> Added a check for this condition (same check as in
>>>>>> builtin-script.c:595).
>>>>>> Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
>>>>> Tested-by: Kim Phillips <kim.phillips@amd.com>
>>>> Thanks, added this to that patch.
>>> Great, thanks!
>> Ah, I thought you were referring to my initial flamegraph.py perf script.
>> Is there anything I can do to get it merged?
> 
> I'll test it today, were there any Tested-by: or Reviewed-by: to that
> flamegraph.py?

I just added mine.

Kim
