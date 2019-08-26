From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: BoF on LPC 2019 : Linux Perf advancements for compute intensive
 and server systems
Date: Mon, 26 Aug 2019 10:55:36 -0300
Message-ID: <20190826135536.GA24801@kernel.org>
References: <43216530-4410-6cc4-aa4a-51fa7e7c1b0c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <43216530-4410-6cc4-aa4a-51fa7e7c1b0c@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>, Song Liu <songliubraving@fb.com>, "Jin, Yao" <yao.jin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Kees Cook <keescook@chromium.org>, Jonatan Corbet <corbet@lwn.net>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Aug 26, 2019 at 02:36:48PM +0300, Alexey Budankov escreveu:
> 
> Hi,
> 
> There is a BoF session scheduled on Linux Plumbers Conference 2019 event.
> If you plan attend the event feel free to join and discuss about the BoF 
> topic and beyond:
> 
> Linux Perf advancements for compute intensive and server systems:
> 
> "Modern server and compute intensive systems are naturally built around 
>  several top performance CPUs with large amount of cores and equipped 
>  by shared memory that spans a number of NUMA domains. Compute intensive 
>  workloads usually implement highly parallel CPU bound cyclic codes 
>  performing mathematics calculations that reference data located in 
>  the shared memory. Performance observability and profiling of these 
>  workloads on such systems have unique characteristics and impose specific 
>  requirements on software performance tools. The requirements include 
>  tools CPU scalability, coping with high rate and volume of collected 
>  performance data as well as NUMA awareness. In order to fulfill that 
>  requirements a number of extensions have been implemented in Linux Perf 
>  tool that are currently a part of the Linux kernel source tree 
>  [1], [2], [3], [4]"

All those are already merged, after long reviewing phases and lots of
testing, right?

I think the next step for people working in this area, in preparation
for this BoF, is to list what are their current efforts, like Ian et all
did in:

  https://linuxplumbersconf.org/event/4/contributions/291/

- Arnaldo
 
> Best regards,
> Alexey
> 
> [1] https://marc.info/?l=linux-kernel&m=154149439404555&w=2
> [2] https://marc.info/?l=linux-kernel&m=154817912621465&w=2
> [3] https://marc.info/?l=linux-kernel&m=155293062518459&w=2
> [4] https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html

-- 

- Arnaldo
