From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 03/15] perf tools script: Filter COMM/FORK/.. events
 by CPU
Date: Fri, 8 Mar 2019 07:08:27 -0800
Message-ID: <20190308150827.GH7535@tassilo.jf.intel.com>
References: <20190305144758.12397-1-andi@firstfloor.org>
 <20190305144758.12397-4-andi@firstfloor.org>
 <6d837d6b-da67-9878-dcc5-a2b0f2dc6826@intel.com>
 <20190307110231.GB8979@krava>
 <20190308133901.GB26260@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190308133901.GB26260@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Fri, Mar 08, 2019 at 10:39:01AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 07, 2019 at 12:02:31PM +0100, Jiri Olsa escreveu:
> > On Wed, Mar 06, 2019 at 04:23:40PM +0200, Adrian Hunter wrote:
> > > On 5/03/19 4:47 PM, Andi Kleen wrote:
> > > > From: Andi Kleen <ak@linux.intel.com>
> > > > 
> > > > The --cpu option only filtered samples. Filter other perf events,
> > > > such as COMM, FORK, SWITCH by the CPU too.
> > > 
> > > Because tasks can migrate from cpu to cpu, we probably need to process most
> > > of the events anyway, even if they are not printed.
> > 
> > agreed, I wonder we could just make the perf_event__fprintf conditional
> 
> Humm, probably just do the filtering on PERF_RECORD_SAMPLE is enough?
> I.e. having the other PERF_RECORD_{COMM,MMAP,} etc is required in face
> of migration.

The goal was to only show the output for the correct CPU in the perf
sample context browser. Otherwise the output on larger systems
is very confusing because most of it is for irrelevant CPUs.

-andi
