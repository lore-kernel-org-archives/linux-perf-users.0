From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHSET 00/10] perf: Improve cgroup profiling (v5)
Date: Tue, 24 Mar 2020 12:34:44 -0400
Message-ID: <20200324163444.GA162390@mtj.duckdns.org>
References: <20200224043749.69466-1-namhyung@kernel.org>
 <CAM9d7chneHzibiQFopmN1rED=mf-nBpy58kauXWSOSYy2zCtzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAM9d7chneHzibiQFopmN1rED=mf-nBpy58kauXWSOSYy2zCtzQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Mar 23, 2020 at 08:58:04AM +0900, Namhyung Kim wrote:
> Hello Peter, Tejun and folks.
> 
> Do you have any other comments on the kernel side?
> If not, can I get your Ack?

Everything looks good from cgroup side. I think I acked all cgroup parts already
but if not please feel free to add

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
