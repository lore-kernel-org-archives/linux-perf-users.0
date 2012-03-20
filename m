From: David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH 1/1] Fix number of events displayed in header
Date: Tue, 20 Mar 2012 13:46:16 -0600
Message-ID: <4F68DE88.1040301@gmail.com>
References: <1332271396-21756-1-git-send-email-ashay.r@gmail.com> <20120320194241.GA24870@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48353 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111Ab2CTTq1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 20 Mar 2012 15:46:27 -0400
In-Reply-To: <20120320194241.GA24870@infradead.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Ashay Rane <ashay.r@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, Ashay Rane <ashay.rane@tacc.utexas.edu>

On 3/20/12 1:42 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 20, 2012 at 02:23:16PM -0500, Ashay Rane escreveu:
>> From: Ashay Rane<ashay.rane@tacc.utexas.edu>
>
> Too short a changeset comment, please elaborate.
>
> The change at least would have to be changed from
>
> "Events: %llu", total_period
>
> to
>
> "Total period: %llu", total_period
>
> To be consistent in what we call "Events", i.e. right now it is telling
> the number of PERF_RECORD_SAMPLE events, with your change it woul0d be
> showing the sum of the periods in all samples.

Does not seem appropriate to change from number of sample events to 
period for all event types. This change assumes the event is cycles, 
cpu-clock or task-clock.

David


>
> - Arnaldo
>
>> Signed-off-by: Ashay Rane<ashay.rane@tacc.utexas.edu>
>> ---
>>   tools/perf/builtin-report.c |    6 ++----
>>   1 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>> index 25d34d4..58a20cf 100644
>> --- a/tools/perf/builtin-report.c
>> +++ b/tools/perf/builtin-report.c
>> @@ -202,11 +202,9 @@ static size_t hists__fprintf_nr_sample_events(struct hists *self,
>>   					      const char *evname, FILE *fp)
>>   {
>>   	size_t ret;
>> -	char unit;
>> -	unsigned long nr_events = self->stats.nr_events[PERF_RECORD_SAMPLE];
>> +	u64 total_period = self->stats.total_period;
>>
>> -	nr_events = convert_unit(nr_events,&unit);
>> -	ret = fprintf(fp, "# Events: %lu%c", nr_events, unit);
>> +	ret = fprintf(fp, "# Events: %llu", total_period);
>>   	if (evname != NULL)
>>   		ret += fprintf(fp, " %s", evname);
>>   	return ret + fprintf(fp, "\n#\n");
>> --
>> 1.7.4.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
