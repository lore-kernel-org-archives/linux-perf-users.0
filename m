From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v4 03/15] perf tools script: Filter COMM/FORK/.. events
 by CPU
Date: Thu, 7 Mar 2019 12:02:31 +0100
Message-ID: <20190307110231.GB8979@krava>
References: <20190305144758.12397-1-andi@firstfloor.org>
 <20190305144758.12397-4-andi@firstfloor.org>
 <6d837d6b-da67-9878-dcc5-a2b0f2dc6826@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6d837d6b-da67-9878-dcc5-a2b0f2dc6826@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Mar 06, 2019 at 04:23:40PM +0200, Adrian Hunter wrote:
> On 5/03/19 4:47 PM, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > The --cpu option only filtered samples. Filter other perf events,
> > such as COMM, FORK, SWITCH by the CPU too.
> 
> Because tasks can migrate from cpu to cpu, we probably need to process most
> of the events anyway, even if they are not printed.

agreed, I wonder we could just make the perf_event__fprintf conditional

jirka

> 
> > 
> > Reported-by: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > ---
> >  tools/perf/builtin-script.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index fbc440bdf880..3813f60d1dc0 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -2038,6 +2038,9 @@ static int process_comm_event(struct perf_tool *tool,
> >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> >  	int ret = -1;
> >  
> > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > +		return 0;
> > +
> >  	thread = machine__findnew_thread(machine, event->comm.pid, event->comm.tid);
> >  	if (thread == NULL) {
> >  		pr_debug("problem processing COMM event, skipping it.\n");
> > @@ -2073,6 +2076,9 @@ static int process_namespaces_event(struct perf_tool *tool,
> >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> >  	int ret = -1;
> >  
> > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > +		return 0;
> > +
> >  	thread = machine__findnew_thread(machine, event->namespaces.pid,
> >  					 event->namespaces.tid);
> >  	if (thread == NULL) {
> > @@ -2108,6 +2114,9 @@ static int process_fork_event(struct perf_tool *tool,
> >  	struct perf_session *session = script->session;
> >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> >  
> > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > +		return 0;
> > +
> >  	if (perf_event__process_fork(tool, event, sample, machine) < 0)
> >  		return -1;
> >  
> > @@ -2141,6 +2150,9 @@ static int process_exit_event(struct perf_tool *tool,
> >  	struct perf_session *session = script->session;
> >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> >  
> > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > +		return 0;
> > +
> >  	thread = machine__findnew_thread(machine, event->fork.pid, event->fork.tid);
> >  	if (thread == NULL) {
> >  		pr_debug("problem processing EXIT event, skipping it.\n");
> > @@ -2174,6 +2186,9 @@ static int process_mmap_event(struct perf_tool *tool,
> >  	struct perf_session *session = script->session;
> >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> >  
> > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > +		return 0;
> > +
> >  	if (perf_event__process_mmap(tool, event, sample, machine) < 0)
> >  		return -1;
> >  
> > @@ -2206,6 +2221,9 @@ static int process_mmap2_event(struct perf_tool *tool,
> >  	struct perf_session *session = script->session;
> >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> >  
> > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > +		return 0;
> > +
> >  	if (perf_event__process_mmap2(tool, event, sample, machine) < 0)
> >  		return -1;
> >  
> > @@ -2238,6 +2256,9 @@ static int process_switch_event(struct perf_tool *tool,
> >  	struct perf_session *session = script->session;
> >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> >  
> > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > +		return 0;
> > +
> >  	if (perf_event__process_switch(tool, event, sample, machine) < 0)
> >  		return -1;
> >  
> > @@ -2266,6 +2287,9 @@ process_lost_event(struct perf_tool *tool,
> >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> >  	struct thread *thread;
> >  
> > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > +		return 0;
> > +
> >  	thread = machine__findnew_thread(machine, sample->pid,
> >  					 sample->tid);
> >  	if (thread == NULL)
> > 
> 
