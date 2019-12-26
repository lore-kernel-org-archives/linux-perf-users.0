From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCHSET 0/9] perf: Improve cgroup profiling (v3)
Date: Thu, 26 Dec 2019 09:46:59 -0300
Message-ID: <20191226124659.GA20204@kernel.org>
References: <20191223060759.841176-1-namhyung@kernel.org>
 <alpine.DEB.2.21.1912231235090.775@macbook-air>
 <CAM9d7cj06Hj3hOSdcyTpRWaoBY0wLjPpt7_+CbUqtsF-_08Czg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAM9d7cj06Hj3hOSdcyTpRWaoBY0wLjPpt7_+CbUqtsF-_08Czg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Vince Weaver <vincent.weaver@maine.edu>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Dec 24, 2019 at 09:40:04AM +0900, Namhyung Kim escreveu:
> On Tue, Dec 24, 2019 at 2:35 AM Vince Weaver <vincent.weaver@maine.edu> wrote:
> > On Mon, 23 Dec 2019, Namhyung Kim wrote:
> > > This work is to improve cgroup profiling in perf.  Currently it only
> > > supports profiling tasks in a specific cgroup and there's no way to
> > > identify which cgroup the current sample belongs to.  So I added
> > > PERF_SAMPLE_CGROUP to add cgroup id into each sample.  It's a 64-bit
> > > integer having file handle of the cgroup.  And kernel also generates
> > > PERF_RECORD_CGROUP event for new groups to correlate the cgroup id and
> > > cgroup name (path in the cgroup filesystem).  The cgroup id can be
> > > read from userspace by name_to_handle_at() system call so it can
> > > synthesize the CGROUP event for existing groups.

> > so is there a patch to the manpage that describes this new behavior in
> > perf_event_open()?

> Not yet.  I'll cook a patch once it's merged to the Linus' tree.

Vince, was it ever considered to carry the man page in the kernel
sources and then make it so that new features need to come with the
respective changes to the man page? I think that would be a good move,
you would be the maintainer for that file, what do you think?

- Arnaldo
