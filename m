From: Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH] perf script report: fix segfault when using DWARF mode
Date: Thu, 2 Apr 2020 14:07:51 -0500
Message-ID: <6a098ce1-1981-dcff-ea62-af5fc07ec7fb@amd.com>
References: <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
 <20200402125417.422232-1-agerstmayr@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200402125417.422232-1-agerstmayr@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Gerstmayr <agerstmayr@redhat.com>, linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 4/2/20 7:54 AM, Andreas Gerstmayr wrote:
> When running perf script report with a Python script and a callgraph in
> DWARF mode, intr_regs->regs can be 0 and therefore crashing the regs_map
> function.
> 
> Added a check for this condition (same check as in builtin-script.c:595).
> 
> Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
> ---

Tested-by: Kim Phillips <kim.phillips@amd.com>

Thanks,

Kim
