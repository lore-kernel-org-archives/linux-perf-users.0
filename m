From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/9] perf/core: Add PERF_RECORD_CGROUP event
Date: Fri, 20 Dec 2019 07:16:22 -0800
Message-ID: <20191220151622.GF2914998@devbig004.ftw2.facebook.com>
References: <20191220043253.3278951-1-namhyung@kernel.org>
 <20191220043253.3278951-2-namhyung@kernel.org>
 <20191220093335.GC2844@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191220093335.GC2844@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Fri, Dec 20, 2019 at 10:33:35AM +0100, Peter Zijlstra wrote:
> On Fri, Dec 20, 2019 at 01:32:45PM +0900, Namhyung Kim wrote:
> > To support cgroup tracking, add CGROUP event to save a link between
> > cgroup path and inode number.  The attr.cgroup bit was also added to
> > enable cgroup tracking from userspace.
> > 
> > This event will be generated when a new cgroup becomes active.
> > Userspace might need to synthesize those events for existing cgroups.
> > 
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Li Zefan <lizefan@huawei.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> TJ, is this the right thing to do? ISTR you had concerns on this topic
> on the past.

Yeah, cgroup->id is now the same as ino (on 64bit ino matchines) and
fhandle and uniquely identifies a cgroup instance in that boot
instance.  That said, id -> path mapping can be done from userspace by
passing the cgroup id to open_by_handle_at(2) and then reading the
symlink in /proc/self/fd, so this event isn't necessary per-se if the
goal is mapping back ids to paths.

Thanks.

-- 
tejun
