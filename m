From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 5/5] perf synthetic events: Remove use of sscanf from
 /proc reading
Date: Thu, 2 Apr 2020 15:40:52 +0200
Message-ID: <20200402134052.GI2518490@krava>
References: <20200401233945.133550-1-irogers@google.com>
 <20200401233945.133550-6-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200401233945.133550-6-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Petr Mladek <pmladek@suse.com>, Andrey Zhizhikin <andrey.z@gmail.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Apr 01, 2020 at 04:39:45PM -0700, Ian Rogers wrote:
> The synthesize benchmark, run on a single process and thread, shows
> perf_event__synthesize_mmap_events as the hottest function with fgets
> and sscanf taking the majority of execution time. fscanf performs
> similarly well. Replace the scanf call with manual reading of each field
> of the /proc/pid/maps line, and remove some unnecessary buffering.
> This change also addresses potential, but unlikely, buffer overruns for
> the string values read by scanf.
> 
> Performance before is:
> Average synthesis took: 120.195100 usec
> Average data synthesis took: 156.582300 usec
> 
> And after is:
> Average synthesis took: 67.189100 usec
> Average data synthesis took: 102.451600 usec
> 
> On a Intel Xeon 6154 compiling with Debian gcc 9.2.1.

I can see the speedup as well, thanks!

jirka
