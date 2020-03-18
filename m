From: Vijay Thakkar <vijaythakkar@me.com>
Subject: Re: [PATCH v5 2/3] perf vendor events amd: add Zen2 events
Date: Wed, 18 Mar 2020 11:21:12 -0400
Message-ID: <20200318152112.GA231037@shwetrath.localdomain>
References: <20200316225238.150154-1-vijaythakkar@me.com>
 <20200316225238.150154-3-vijaythakkar@me.com>
 <20200318142057.GD11531@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200318142057.GD11531@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Kim Phillips <kim.phillips@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>, Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

>   floating point:
>     fpu_pipe_assignment.total                         
>          [Total number of fp uOps]
>   
>   
>   Metric Groups:
>  

I just realized that I did not add back the counters for per pipe total
assignment as I said in the commit message. Patch 3/3 adds the total
uOp assignments per pipe for Zen1 based processors. Although the PPR for
Matisse does not list these counters, I can still sample them on my
Ryzen 3900X system and they seem to report correct numbers. For example,
here is the result of running:

$> perf stat -e r100,r200,r400,r800,rf00 ls

$> Performance counter stats for 'ls':

            5,047      r100:u
            5,236      r200:u
            31,300     r400:u
            2,040      r800:u
            43,623     fpu_pipe_assignment.total:u

Note that the per pipe total counters add up the overall total, which
makes me think I should submit a v6 of this patch adding the per pipe
totals for zen2 as well, especially since it is mentioned in the commit
message.

-Vijay
