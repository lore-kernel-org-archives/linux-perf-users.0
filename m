From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf script report: fix segfault when using DWARF mode
Date: Fri, 3 Apr 2020 09:40:28 -0300
Message-ID: <20200403124028.GA18559@kernel.org>
References: <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
 <20200402125417.422232-1-agerstmayr@redhat.com>
 <6a098ce1-1981-dcff-ea62-af5fc07ec7fb@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6a098ce1-1981-dcff-ea62-af5fc07ec7fb@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim Phillips <kim.phillips@amd.com>
Cc: Andreas Gerstmayr <agerstmayr@redhat.com>, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Apr 02, 2020 at 02:07:51PM -0500, Kim Phillips escreveu:
> On 4/2/20 7:54 AM, Andreas Gerstmayr wrote:
> > When running perf script report with a Python script and a callgraph in
> > DWARF mode, intr_regs->regs can be 0 and therefore crashing the regs_map
> > function.
> > 
> > Added a check for this condition (same check as in builtin-script.c:595).
> > 
> > Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
> > ---
> 
> Tested-by: Kim Phillips <kim.phillips@amd.com>

Thanks, added this to that patch.

- Arnaldo
