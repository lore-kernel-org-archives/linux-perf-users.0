From: Andreas Gerstmayr <agerstmayr@redhat.com>
Subject: Re: [PATCH] perf script report: fix segfault when using DWARF mode
Date: Fri, 3 Apr 2020 15:16:48 +0200
Message-ID: <bf95c9f1-1970-fce4-c6f2-dc231730e7ab@redhat.com>
References: <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
 <20200402125417.422232-1-agerstmayr@redhat.com>
 <6a098ce1-1981-dcff-ea62-af5fc07ec7fb@amd.com>
 <20200403124028.GA18559@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200403124028.GA18559@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Kim Phillips <kim.phillips@amd.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 03.04.20 14:40, Arnaldo Carvalho de Melo wrote:
> Em Thu, Apr 02, 2020 at 02:07:51PM -0500, Kim Phillips escreveu:
>> On 4/2/20 7:54 AM, Andreas Gerstmayr wrote:
>>> When running perf script report with a Python script and a callgraph in
>>> DWARF mode, intr_regs->regs can be 0 and therefore crashing the regs_map
>>> function.
>>>
>>> Added a check for this condition (same check as in builtin-script.c:595).
>>>
>>> Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
>>> ---
>>
>> Tested-by: Kim Phillips <kim.phillips@amd.com>
> 
> Thanks, added this to that patch.
> 

Great, thanks!


Cheers,
Andreas
