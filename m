From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 5/7] perf metricgroup: Remove duped metric group events
Date: Thu, 21 May 2020 14:28:16 -0300
Message-ID: <20200521172816.GE14034@kernel.org>
References: <20200520072814.128267-1-irogers@google.com>
 <20200520072814.128267-6-irogers@google.com>
 <20200520134847.GM157452@krava>
 <CAP-5=fVGf9i7hvQcht_8mnMMjzhQYdFqPzZFraE-iMR7Vcr1tw@mail.gmail.com>
 <20200520220912.GP157452@krava>
 <CAP-5=fU12vP45Sg3uRSuz-xoceTPTKw9-XZieKv1PaTnREMdrw@mail.gmail.com>
 <20200521105412.GS157452@krava>
 <CAP-5=fWfV=+TY80kvTz9ZmzzzR5inYbZXRuQfsLfe9tPG7eJrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP-5=fWfV=+TY80kvTz9ZmzzzR5inYbZXRuQfsLfe9tPG7eJrQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andriin@fb.com>, Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Kim Phillips <kim.phillips@amd.com>, Paul Clarke <pc@us.ibm.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, linux-perf-users
List-Id: linux-perf-users.vger.kernel.org

Em Thu, May 21, 2020 at 10:26:02AM -0700, Ian Rogers escreveu:
> On Thu, May 21, 2020 at 3:54 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > ok, I misunderstood and thought you would colaps also M3 to
> > have A,B computed via M1 group and with separate D ...
> >
> > thanks a lot for the explanation, it might be great to have it
> > in the comments/changelog or even man page
> 
> Thanks Jiri! Arnaldo do you want me to copy the description above into
> the commit message of this change and resend?

Send as a follow on patch, please.

- Arnaldo

> This patch adds some description to find_evsel_group, this is expanded
> by the next patch that adds the two command line flags:
> https://lore.kernel.org/lkml/20200520072814.128267-7-irogers@google.com/
> When writing the patches it wasn't clear to me how much detail to
> include in say the man pages.
> 
> Thanks,
> Ian
