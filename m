From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [GIT PULL] perf tools fixes for v5.9
Date: Wed, 2 Sep 2020 10:30:34 -0300
Message-ID: <20200902133034.GB3444345@kernel.org>
References: <20200901224154.3436175-1-acme@kernel.org>
 <CAHk-=wifL-04oOF3RAbX9Odyfgz4zc4dE=pq-QL+2C-aTxUmqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=wifL-04oOF3RAbX9Odyfgz4zc4dE=pq-QL+2C-aTxUmqw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Al Grant <al.grant@arm.com>, Chris Wilson <chris@chris-wilson.co.uk>, David Ahern <dsahern@kernel.org>, Ian Rogers <irogers@google.com>, Jin Yao <yao.jin@linux.intel.com>, Leo Yan <leo.yan@linaro.org>, Like Xu <like.xu@linux.intel.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Sumanth Korikkar <sumanthk@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, Wei Li <liwei391@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Sep 01, 2020 at 07:43:33PM -0700, Linus Torvalds escreveu:
> On Tue, Sep 1, 2020 at 3:42 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > - The SNOOPX and REMOTE offsets in the data_src bitmask in perf records were
> >   were both 37, SNOOPX is 38, fix it.
> 
> The kernel uapi side thinks it's 37. What's up?
> 
>   $ git grep PERF_MEM_SNOOPX_SHIFT
> 
> results in
> 
>   include/uapi/linux/perf_event.h:#define PERF_MEM_SNOOPX_SHIFT   37
>   tools/include/uapi/linux/perf_event.h:#define PERF_MEM_SNOOPX_SHIFT     38

Its going in a separate patch, via PeterZ/Ingo,

- Arnaldo
