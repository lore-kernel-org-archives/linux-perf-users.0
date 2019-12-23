From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: [PATCHSET 0/9] perf: Improve cgroup profiling (v3)
Date: Mon, 23 Dec 2019 12:35:47 -0500 (EST)
Message-ID: <alpine.DEB.2.21.1912231235090.775@macbook-air>
References: <20191223060759.841176-1-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191223060759.841176-1-namhyung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, 23 Dec 2019, Namhyung Kim wrote:

> This work is to improve cgroup profiling in perf.  Currently it only
> supports profiling tasks in a specific cgroup and there's no way to
> identify which cgroup the current sample belongs to.  So I added
> PERF_SAMPLE_CGROUP to add cgroup id into each sample.  It's a 64-bit
> integer having file handle of the cgroup.  And kernel also generates
> PERF_RECORD_CGROUP event for new groups to correlate the cgroup id and
> cgroup name (path in the cgroup filesystem).  The cgroup id can be
> read from userspace by name_to_handle_at() system call so it can
> synthesize the CGROUP event for existing groups.

so is there a patch to the manpage that describes this new behavior in 
perf_event_open()?

Vince
