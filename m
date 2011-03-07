From: David Ahern <daahern@cisco.com>
Subject: Re: [PATCH 2/2] perf script: support custom field selection for output
Date: Mon, 07 Mar 2011 10:41:47 -0700
Message-ID: <4D7518DB.9090004@cisco.com>
References: <1299449795-12933-1-git-send-email-daahern@cisco.com> <1299449795-12933-3-git-send-email-daahern@cisco.com> <20110307165009.GF1873@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-2.cisco.com ([171.71.176.71]:35938 "EHLO
	sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab1CGRlP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 7 Mar 2011 12:41:15 -0500
In-Reply-To: <20110307165009.GF1873@nowhere>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, paulus@samba.org, tglx@linutronix.de



On 03/07/11 09:50, Frederic Weisbecker wrote:
>> +-U::
>> +--show-unresolved::
>> +        Display all addresses including unresolved to a symbol.
> 
> We should always do it I think. As long as the sym format is asked, try
> to resolve it, otherwise print the raw address.

Ok. I'll remove.


>> +/* default set to maintain compatibility with current format */
>> +#define output_fields_default   (PERF_OUTPUT_COMM | PERF_OUTPUT_PID | \
>> +				PERF_OUTPUT_CPU | PERF_OUTPUT_TIME | \
>> +				PERF_OUTPUT_EVNAME | PERF_OUTPUT_TRACE)
>> +
>> +u64 output_fields = output_fields_default;
> 
> Hm, we should have one default for tracepoint events and one
> for others. For example dso and sym make sense for hardware,
> breakpoint and software event, but it makes few sense for tracepoints.

That default was strictly to maintain backwards compatibility with
existing output. So you would like to see:

out_fields_def_trace = <the above default>

out_fields_def_sw = PERF_OUTPUT_COMM | PERF_OUTPUT_TID | \
                    PERF_OUTPUT_CPU | PERF_OUTPUT_TIME | \
                    PERF_OUTPUT_EVNAM | PERF_OUTPUT_SYM

If user does not specify custom option, set output_fields to default
based on event type - which conceptually can change sample to sample
(though perf currently can't handle a S/W and a trace event in the same
file).

As for H/W events, the cycles format should be the same as the S/W
format. After that perf-record does not mix well with H/W events.


>>  static void process_event(union perf_event *event __unused,
>>  			  struct perf_sample *sample,
>> @@ -31,8 +107,15 @@ static void process_event(union perf_event *event __unused,
>>  	 * field, although it should be the same than this perf
>>  	 * event pid
>>  	 */
>> -	print_event(sample->cpu, sample->raw_data, sample->raw_size,
>> -		    sample->time, thread->comm);
>> +	if (PRINT_FIELD(TRACE))
>> +		print_event(sample->cpu, sample->raw_data,
>> +			    sample->raw_size, sample->time,
>> +			    thread->comm);
> 
> The print_event() thing we have in trace-event-parse.c should really handle only
> the raw trace itself. More on that below when I reach that file.

Ok


>> +		callchain_cursor_commit(cursor);
>> +		if (cursor->nr == 0)
>> +			return;
> 
> I guess you don't need the above check.

Ok. I'll remove.


>> diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
>> index d8e622d..9ac6524 100644
>> --- a/tools/perf/util/trace-event-parse.c
>> +++ b/tools/perf/util/trace-event-parse.c
>> @@ -32,6 +32,7 @@
>>  #include "../perf.h"
>>  #include "util.h"
>>  #include "trace-event.h"
>> +#include "output.h"
>>  
>>  int header_page_ts_offset;
>>  int header_page_ts_size;
>> @@ -2683,13 +2684,18 @@ static void print_graph_proc(int pid, const char *comm)
>>  	/* sign + log10(MAX_INT) + '\0' */
>>  	char pid_str[11];
>>  	int spaces = 0;
>> -	int len;
>> +	int len = 0;
>>  	int i;
>>  
>>  	sprintf(pid_str, "%d", pid);
>>  
>>  	/* 1 stands for the "-" character */
>> -	len = strlen(comm) + strlen(pid_str) + 1;
>> +	if (PRINT_FIELD(COMM) && PRINT_FIELD(PID))
>> +		len = strlen(comm) + strlen(pid_str) + 1;
>> +	else if (PRINT_FIELD(COMM))
>> +		len = strlen(comm);
>> +	else if (PRINT_FIELD(PID))
>> +		len = strlen(pid_str);
> 
> For now we don't use that function because the function graph tracer
> is not yet supported by perf.
> 
> Just forget about that, we'll take care of that later. Consider
> pretty_print_func_graph() can't be called.

That certainly helps make it simpler. I left the printing of those
fields in that file b/c of that function.

> 
> trace-event-parse.c and its print_event() pretty printing should not care
> about the output format. It only needs to print the raw trace itself.
> All the comm, time, etc... things should be handled from perf script
> core.
> 
> In fact, print_event() should really be renamed print_trace() or something.

Ok. I'll pull the comm, pid, time options into builtin-script's version
and rename the function.

David

> 
> Other than that, looks like a right direction.
> 
> Thanks!
