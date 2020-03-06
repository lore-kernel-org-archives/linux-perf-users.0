From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCHSET 00/10] perf: Improve cgroup profiling (v5)
Date: Fri, 6 Mar 2020 16:05:14 +0100
Message-ID: <20200306150514.GE290743@krava>
References: <20200224043749.69466-1-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200224043749.69466-1-namhyung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Feb 24, 2020 at 01:37:39PM +0900, Namhyung Kim wrote:
> Hello,
> 
> This work is to improve cgroup profiling in perf.  Currently it only
> supports profiling tasks in a specific cgroup and there's no way to
> identify which cgroup the current sample belongs to.  So I added
> PERF_SAMPLE_CGROUP to add cgroup id into each sample.  It's a 64-bit
> integer having file handle of the cgroup.  And kernel also generates
> PERF_RECORD_CGROUP event for new groups to correlate the cgroup id and
> cgroup name (path in the cgroup filesystem).  The cgroup id can be
> read from userspace by name_to_handle_at() system call so it can
> synthesize the CGROUP event for existing groups.
> 
> So why do we want this?  Systems running a large number of jobs in
> different cgroups want to profiling such jobs precisely. This includes
> container hosting systems widely used today. Currently perf supports
> namespace tracking but the systems may not use (cgroup) namespace for
> their jobs. Also it'd be more intuitive to see cgroup names (as
> they're given by user or sysadmin) rather than numeric
> cgroup/namespace id even if they use the namespaces.
> 
> From Stephane Eranian:
> > In data centers you care about attributing samples to a job not such
> > much to a process.  A job may have multiple processes which may come
> > and go. The cgroup on the other hand stays around for the entire
> > lifetime of the job. It is much easier to map a cgroup name to a
> > particular job than it is to map a pid back to a job name,
> > especially for offline post-processing.
> 
> Note that this only works for "perf_event" cgroups (obviously) so if
> users are still using cgroup-v1 interface, they need to have same
> hierarchy for subsystem(s) want to profile with it.
> 
>  * Changes from v4:
>   - use CONFIG_CGROUP_PERF
>   - move cgroup tree to perf_env
>   - move cgroup fs utility function to tools/lib/api/fs
>   - use a local buffer and check its size for cgroup systhesis

the perf top tui should all cgroup id as 0 and the headers are
misaligned

	Samples
	Overhead  cgroup id (dev/inode        Pid:Command
	  83.78%  0/0x0                 N/A     6508:perf
	   8.82%  0/0x0                 N/A        0:swapper
	   2.59%  0/0x0                 N/A     6466:perf
	   1.69%  0/0x0                 N/A     6509:perf-top-UI
	   0.56%  0/0x0                 N/A       12:rcu_sched
	   0.29%  0/0x0                 N/A      429:kworker/0:2-mm_
	   0.15%  0/0x0                 N/A     1416:sshd
	   0.12%  0/0x0                 N/A      187:migration/35


jirka
