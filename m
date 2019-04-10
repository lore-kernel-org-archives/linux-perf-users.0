From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf/report: [RFC] Handling OOM in perf report
Date: Wed, 10 Apr 2019 09:17:30 +0200
Message-ID: <06273b1f-faea-5d88-1696-eb686ef47a6c@linux.ibm.com>
References: <20190401142000.17679-1-tmricht@linux.ibm.com>
 <20190409104205.GB29688@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190409104205.GB29688@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 4/9/19 12:42 PM, Jiri Olsa wrote:
> On Mon, Apr 01, 2019 at 04:20:00PM +0200, Thomas Richter wrote:
> 
> SNIP
> 
>> perf_session__process_event() returns to its caller, where -ENOMEM is
>> changed to -EINVAL and processing stops:
>>
>>  if ((skip = perf_session__process_event(session, event, head)) < 0) {
>>       pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
>> 	     head, event->header.size, event->header.type);
>>       err = -EINVAL;
>>       goto out_err;
>>  }
>>
>> This occured in the FINISHED_ROUND event when it has to process some
>> 10000 entries and ran out of memory.
>>
>> I understand that my perf.data file might just be too big, but I would
>> like to see some error message indicating OOM error instead of
>> processing failure of a unrelated event.
> 
> you can limit the size of the report queue via ~/.perfconfig file:
> 
> [report]
> queue-size=1M
> 
> above should use only 1M for the queue management data the data
> for sample still get allocated thought.. but it could help
> 
>>
>> However this patch just does what the pr_debug() statement indicates,
>> the event is skipped and processing continues.
>> But at least the root cause is indicated and also shows up in the
>> GUI.
>>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> ---
>>  tools/perf/builtin-report.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>> index 4054eb1f98ac..7a27b815f7a8 100644
>> --- a/tools/perf/builtin-report.c
>> +++ b/tools/perf/builtin-report.c
>> @@ -283,8 +283,13 @@ static int process_sample_event(struct perf_tool *tool,
>>  		al.map->dso->hit = 1;
>>  
>>  	ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
>> -	if (ret < 0)
>> +	if (ret < 0) {
>>  		pr_debug("problem adding hist entry, skipping event\n");
>> +		if (ret == -ENOMEM) {
>> +			pr_err("Running out of memory\n");
>> +			ret = 0;
>> +		}
>> +	}
> 
> 
> I think we can propagate the error completely (like below),
> and even warn about ENOMEM specificaly
> 
> but I think we should bail out in case of ENOMEM, because
> the data are incomplete and misleading
> 
> jirka
> 
> 
> ---
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index b17f1c9bc965..eea247a26ad8 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1933,7 +1933,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
>  		       file_offset + head, event->header.size,
>  		       event->header.type);
> -		err = -EINVAL;
> +		err = skip;
>  		goto out;
>  	}
>  
> 

Above patch does not help, you simply return -ENOMEM instead of -EINVAL and processing
stops with no indication that perf ran out of memory. Bailing out in this case is ok.

I am fine with your patch, as long as it gives a reason why processing stopped.
In the GUI it shows on the bottom line the reason:

  0xf4198 [0x8]: failed to process type: 68 [Cannot allocate memory]


diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index b17f1c9bc965..e89716175588 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1930,10 +1930,10 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
        if (size < sizeof(struct perf_event_header) ||
            (skip = rd->process(session, event, file_pos)) < 0) {
-               pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
+               pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
                       file_offset + head, event->header.size,
-                      event->header.type);
-               err = -EINVAL;
+                      event->header.type, strerror(-skip));
+               err = skip;
                goto out;
        }
 
[root@m35lp76 perf]#
-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
