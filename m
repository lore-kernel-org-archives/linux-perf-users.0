From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: [PATCHSET 0/9] perf: Improve cgroup profiling (v3)
Date: Fri, 27 Dec 2019 13:31:29 -0500 (EST)
Message-ID: <alpine.DEB.2.21.1912271327320.4876@macbook-air>
References: <20191223060759.841176-1-namhyung@kernel.org> <alpine.DEB.2.21.1912231235090.775@macbook-air> <CAM9d7cj06Hj3hOSdcyTpRWaoBY0wLjPpt7_+CbUqtsF-_08Czg@mail.gmail.com> <20191226124659.GA20204@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191226124659.GA20204@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, Adrian Hunter <adrian.hunter@intel.com>, mtk.manpages@gmail.com
List-Id: linux-perf-users.vger.kernel.org

On Thu, 26 Dec 2019, Arnaldo Carvalho de Melo wrote:

> Em Tue, Dec 24, 2019 at 09:40:04AM +0900, Namhyung Kim escreveu:
> > On Tue, Dec 24, 2019 at 2:35 AM Vince Weaver <vincent.weaver@maine.edu> wrote:
> > > On Mon, 23 Dec 2019, Namhyung Kim wrote:
> > > > This work is to improve cgroup profiling in perf.  Currently it only
> > > > supports profiling tasks in a specific cgroup and there's no way to
> > > > identify which cgroup the current sample belongs to.  So I added
> > > > PERF_SAMPLE_CGROUP to add cgroup id into each sample.  It's a 64-bit
> > > > integer having file handle of the cgroup.  And kernel also generates
> > > > PERF_RECORD_CGROUP event for new groups to correlate the cgroup id and
> > > > cgroup name (path in the cgroup filesystem).  The cgroup id can be
> > > > read from userspace by name_to_handle_at() system call so it can
> > > > synthesize the CGROUP event for existing groups.
> 
> > > so is there a patch to the manpage that describes this new behavior in
> > > perf_event_open()?
> 
> > Not yet.  I'll cook a patch once it's merged to the Linus' tree.
> 
> Vince, was it ever considered to carry the man page in the kernel
> sources and then make it so that new features need to come with the
> respective changes to the man page? I think that would be a good move,
> you would be the maintainer for that file, what do you think?

While I do a lot of work on the perf_event_open() manpage,  it's part of 
the linux man-pages project so I don't really control where it is 
maintained.

I personally do not think it would help much merging into the kernel tree.
I still think the idea of moving everything into linux-git (such as the  
"perf" tool) isn't always the best idea and can make it harder for people
who aren't kernel developers to work on things.

Vince
