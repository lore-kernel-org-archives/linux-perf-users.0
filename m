From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/3] perf script: change process_event prototype
Date: Thu, 3 Mar 2011 03:40:06 +0100
Message-ID: <20110303024003.GC1946@nowhere>
References: <1299086960-26964-1-git-send-email-daahern@cisco.com>
 <1299086960-26964-2-git-send-email-daahern@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1299086960-26964-2-git-send-email-daahern@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Ahern <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, paulus@samba.org, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org

On Wed, Mar 02, 2011 at 10:29:18AM -0700, David Ahern wrote:
> Prepare for handling of samples for any event type.
> 
> Signed-off-by: David Ahern <daahern@cisco.com>
> ---
>  tools/perf/builtin-script.c                        |   40 +++++++++++--------
>  .../util/scripting-engines/trace-event-python.c    |   20 ++++++++-

What about Perl?

>  tools/perf/util/trace-event-scripting.c            |    8 +--
>  tools/perf/util/trace-event.h                      |    6 ++-
>  4 files changed, 47 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 5f40df6..0bee150 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -20,6 +20,27 @@ static u64			last_timestamp;
>  static u64			nr_unordered;
>  extern const struct option	record_options[];
>  
> +static void process_event(union perf_event *event,
> +			  struct perf_sample *sample,
> +			  struct perf_session *session)
> +{
> +	struct thread *thread = perf_session__findnew(session, event->ip.pid);
> +
> +	if (thread == NULL) {
> +		pr_debug("problem processing %d event, skipping it.\n",
> +			 event->header.type);
> +		return;
> +	}

Seems the thread is needed by any endpoints. It would be better to resolve
it from process_sample_event and pass it to the process_event() handler.

> +
> +	/*
> +	 * FIXME: better resolve from pid from the struct trace_entry
> +	 * field, although it should be the same than this perf
> +	 * event pid
> +	 */
> +	print_event(sample->cpu, sample->raw_data, sample->raw_size,
> +		    sample->time, thread->comm);
> +}
[...]
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 2040b85..5b03fb6 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -204,9 +204,9 @@ static inline struct event *find_cache_event(int type)
>  	return event;
>  }
>  
> -static void python_process_event(int cpu, void *data,
> -				 int size __unused,
> -				 unsigned long long nsecs, char *comm)
> +static void python_process_event(union perf_event *pevent,
> +				struct perf_sample *sample,
> +				struct perf_session *session)
>  {
>  	PyObject *handler, *retval, *context, *t, *obj, *dict = NULL;
>  	static char handler_name[256];
> @@ -218,6 +218,20 @@ static void python_process_event(int cpu, void *data,
>  	int type;
>  	int pid;

Please avoid such blank line in the middle of local vars declaration.

> +	int cpu = sample->cpu;
> +	void *data = sample->raw_data;
> +	unsigned long long nsecs = sample->time;
> +	char *comm;
> +	struct thread *thread;
> +
> +	thread = perf_session__findnew(session, pevent->ip.pid);
> +	if (thread == NULL) {
> +		pr_debug("problem processing %d event, skipping it.\n",
> +			 pevent->header.type);
> +		return;
> +	}
> +	comm = thread->comm;
> +
