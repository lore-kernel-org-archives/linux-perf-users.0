From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 06/12] perf report/top: Add 'k' hotkey to zoom directly
 into the kernel map
Date: Sat, 21 Dec 2019 16:20:02 +0900
Message-ID: <CAM9d7cih8nwWcCd4Pwf+5oYS4jYy9U_=7hY0f6T2R3e1kYDGsA@mail.gmail.com>
References: <20191217144828.2460-1-acme@kernel.org> <20191217144828.2460-7-acme@kernel.org>
 <CAM9d7ciL-Qnm5v3Tn1rsrNzW3mTWx5HY6W5XBU1MKnLQ7YBdkw@mail.gmail.com> <20191220121723.GC2032@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191220121723.GC2032@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-perf-users.vger.kernel.org

On Fri, Dec 20, 2019 at 9:17 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Dec 20, 2019 at 03:48:23PM +0900, Namhyung Kim escreveu:
> > On Tue, Dec 17, 2019 at 11:49 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > As a convenience, equivalent to pressing Enter in a line with a kernel
> > > symbol and then selecting "Zoom" into the kernel DSO.
>
> > We already have 'd' key for 'zoom into current dso'.
>
> Right, current DSO, 'k' is equivalent to:
>
> 1. Navigate to a kernel map entry
> 2. Press 'd'
>
> And also to:
>
> 1. Navigate to a kernel map entry
> 2. Press ENTER
> 3. Navigate to "Zoom into Kernel DSO"
> 4. Press ENTER
>
> One key versus 2 or four.
>
> > Do you really want 'k' for kernel specially?
>
> I thought kernel hackers would like the convenience, doing:
>
>   perf top + k
>
> To get the main kernel samples looks faster than:
>
>   perf top -e cycles:k
>
> And those are not even equivalent, as cycles:k will show everything in
> ring 0, while 'perf top + k' will show just what is in the kernel _and_
> in the main kernel map.

I'm fine with adding 'k' key itself, but I thought a bit strange when
it suggests kernel even with user DSOs.

Thanks
Namhyung
