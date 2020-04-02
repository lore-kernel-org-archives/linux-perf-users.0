From: Andreas Gerstmayr <agerstmayr@redhat.com>
Subject: Re: [PATCH] perf script: add flamegraph.py script
Date: Thu, 2 Apr 2020 15:04:31 +0200
Message-ID: <833a5e74-645a-130c-ceab-068880e0c69a@redhat.com>
References: <20200320151355.66302-1-agerstmayr@redhat.com>
 <7176b535-f95b-bf6d-c181-6ccb91425f96@amd.com>
 <21c81775-876a-4dd2-f52f-42645963350f@redhat.com>
 <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kim Phillips <kim.phillips@amd.com>, linux-perf-users@vger.kernel.org
Cc: Martin Spier <mspier@netflix.com>, Brendan Gregg <bgregg@netflix.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 26.03.20 20:04, Kim Phillips wrote:
> I now get a SIGSEGV when executing perf script report flamegraph.
> 
> Here's a trace:
> 
> #0  0x000055555590a9b2 in regs_map (regs=0x7fffffffbfc8, mask=16715775,
>      bf=0x7fffffffba60 "", size=512) at util/scripting-engines/trace-event-python.c:696
> #1  0x000055555590ab03 in set_regs_in_dict (dict=0x7ffff61dd500, sample=0x7fffffffbf20,
>      evsel=0x555555d7a700) at util/scripting-engines/trace-event-python.c:718

This error seems unrelated to flamegraph.py (occurs also with the 
stackcollapse.py script).

Looks like the intr_regs->regs can be 0 when running in DWARF mode (this 
error doesn't occur in the default mode). I've added a check and sent a 
patch. While at it, valgrind reported an invalid read in a different 
code path, which is fixed by the other patch I just sent a few minutes ago.

Can you please test again and report if there are any other issues?


Cheers,
Andreas
