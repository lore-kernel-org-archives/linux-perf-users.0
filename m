From: "David S. Ahern" <daahern@cisco.com>
Subject: Re: [PATCH 1/2] perf tools: Add reference timestamp to perf header
Date: Mon, 13 Dec 2010 10:36:39 -0700
Message-ID: <4D0659A7.9030608@cisco.com>
References: <1291773285-16254-1-git-send-email-daahern@cisco.com> <1291773285-16254-2-git-send-email-daahern@cisco.com> <20101212201613.GA1784@nowhere> <4D06301C.2090309@cisco.com> <20101213155451.GA1691@nowhere> <20101213164854.GL5407@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-1.cisco.com ([171.71.176.70]:58021 "EHLO
	sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757393Ab0LMRgq (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 13 Dec 2010 12:36:46 -0500
In-Reply-To: <20101213164854.GL5407@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org



On 12/13/10 09:48, Arnaldo Carvalho de Melo wrote:
> Em Mon, Dec 13, 2010 at 04:54:56PM +0100, Frederic Weisbecker escreveu:
>> On Mon, Dec 13, 2010 at 07:39:24AM -0700, David S. Ahern wrote:
>>> On 12/12/10 13:16, Frederic Weisbecker wrote:
>>>>>  int perf_session__create_kernel_maps(struct perf_session *self)
>>>>>  {
>>>>>  	int ret = machine__create_kernel_maps(&self->host_machine);
>>>>> @@ -167,6 +190,9 @@ struct perf_session *perf_session__new(const char *filename, int mode, bool forc
>>>>>  		 */
>>>>>  		if (perf_session__create_kernel_maps(self) < 0)
>>>>>  			goto out_delete;
>>>>> +
>>>>> +		if (perf_session__create_ref_time(self) < 0)
>>>>> +			goto out_delete;
> 
>>>> So, it does record it anytime?
> 
>>> Simplest to always add it the header as it does no harm if not used.
>>> To make it conditional means adding an input parameter to
>>> perf_session__new() and then updating all the callers.
> 
>>> Is the preference to make it conditional?
> 
>> No, I suspect the overhead is plain unnoticeable. And if it becomes
>> any problem one day, we can still make that conditional later.
> 
> Right, but it just ocurred to me, can't we encode this in the file stat?

I would not want to rely on stat output for timestamps. eg., copy that
file off box and not have the timestamp preserved.

> Also, how do we deal with:
> 
> $ perf record --help
> <SNIP>
>        -A, --append
>            Append to the output file to do incremental profiling.
> <SNIP>
> 
> ?

Is it realistic to expect/allow an append using different perf binaries?
That just seems plain odd. Then, if one invocation used --timehist and
another did not output would be bizarre. Of course an append with a
reboot between tests would cause problems as well.


> 
> I now think this should be implemented as a PERF_RECORD_WALL_CLOCK
> synthesized event, to be inserted just before we start collecting the
> other events.
> 
> That way, when --appending, we just insert another and use that from
> that point on.
> 
> Look at tools/perf/util/event.h, enum perf_user_event_type and look how
> those are synthesized.

I see the thread on this part. I don't have preference; just let me know
what the final decision is. ie., synthesized event versus header entry.

David


> 
> Thanks,
> 
> - Arnaldo
