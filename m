From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
Date: Fri, 20 Dec 2019 17:48:02 +0100
Message-ID: <20191220164802.GO2827@hirez.programming.kicks-ass.net>
References: <20191220043253.3278951-1-namhyung@kernel.org>
 <20191220043253.3278951-3-namhyung@kernel.org>
 <20191220152324.GG2914998@devbig004.ftw2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191220152324.GG2914998@devbig004.ftw2.facebook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>
List-Id: linux-perf-users.vger.kernel.org

On Fri, Dec 20, 2019 at 07:23:24AM -0800, Tejun Heo wrote:
> On Fri, Dec 20, 2019 at 01:32:46PM +0900, Namhyung Kim wrote:
> > The PERF_SAMPLE_CGROUP bit is to save (perf_event) cgroup information
> > in the sample.  It will add a 64-bit id to identify current cgroup and
> > it's the file handle in the cgroup file system.  Userspace should use
> > this information with PERF_RECORD_CGROUP event to match which cgroup
> > it belongs.
> 
> You don't need PERF_RECORD_CGROUP for that.  Something like the
> following should work.
> 
> 	struct {
> 		struct file_handle fh;
> 		char stor[MAX_HANDLE_SZ];
> 	} fh_store;
> 	struct file_handle *fh = &fh_store;
> 
> 	fh->handle_type = 0xfe; // FILEID_KERNFS
> 	fh->handle_bytes = sizeof(u64);
> 	*(u64 *)fh->f_handle = cgrp_id;
> 
> 	mnt_fd = open('/sys/fs/cgroup', O_RDONLY);
> 	fd = open_by_handle_at(mnt_fd, fh, O_RDONLY);
> 
> 	snprintf(proc_path, PATH_MAX, "/proc/self/fd/%d", fd);
> 	readlink(proc_path, cgrp_path, PATH_MAX);

That assumes the cgroup is still in existence, which might not be the
case I presume.
