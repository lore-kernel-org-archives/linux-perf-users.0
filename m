From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v5 0/3] perf synthetic events
Date: Fri, 24 Apr 2020 09:42:36 +0200
Message-ID: <20200424074236.GA1255225@krava>
References: <20200415054050.31645-1-irogers@google.com>
 <CAM9d7cj4fMsnDLgq0rHwqb6_ZLKP-AOzyyAP4kd=b=P5-t5NGQ@mail.gmail.com>
 <20200423142431.GJ19437@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200423142431.GJ19437@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Petr Mladek <pmladek@suse.com>, Andrey Zhizhikin <andrey.z@gmail.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Apr 23, 2020 at 11:24:31AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Apr 16, 2020 at 11:19:19PM +0900, Namhyung Kim escreveu:
> > On Wed, Apr 15, 2020 at 2:40 PM Ian Rogers <irogers@google.com> wrote:
> > > v4 added a missing test file
> > > v3 improved documenation, return values and added testing to the io framework
> > >    following feedback from namhyung@kernel.org.
> > > v2 addressed single threaded synthesize benchmark issues from jolsa@redhat.com
> > > https://lore.kernel.org/lkml/20200402154357.107873-1-irogers@google.com/
> > >
> > > Ian Rogers (3):
> > >   perf bench: add a multi-threaded synthesize benchmark
> > >   tools api: add a lightweight buffered reading api
> > >   perf synthetic events: Remove use of sscanf from /proc reading
> > 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Jiri, you seem to be ok with it, can I get your Acked-by or Reviewed-by
> as well?

yep, it's good for me.. and I just found out that the new
version has tests for io functions, great! :-)

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka
