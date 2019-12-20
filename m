From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
Date: Fri, 20 Dec 2019 08:59:07 -0800
Message-ID: <20191220165907.GI2914998@devbig004.ftw2.facebook.com>
References: <20191220043253.3278951-1-namhyung@kernel.org>
 <20191220043253.3278951-3-namhyung@kernel.org>
 <20191220152324.GG2914998@devbig004.ftw2.facebook.com>
 <20191220164802.GO2827@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191220164802.GO2827@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>
List-Id: linux-perf-users.vger.kernel.org

On Fri, Dec 20, 2019 at 05:48:02PM +0100, Peter Zijlstra wrote:
> That assumes the cgroup is still in existence, which might not be the
> case I presume.

Yeah, if the cgroup is already gone by the time the first event is
looked up, this wouldn't work.

-- 
tejun
