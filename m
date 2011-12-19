From: Arun Sharma <asharma@fb.com>
Subject: Re: [PATCH 3/6] perf: add ability to record event period
Date: Mon, 19 Dec 2011 11:20:43 -0800
Message-ID: <4EEF8E8B.80607@fb.com>
References: <1323266161-394927-1-git-send-email-avagin@openvz.org> <1323266161-394927-4-git-send-email-avagin@openvz.org> <4EEAEF83.3080100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="KOI8-R"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60036 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752077Ab1LSTVd (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 19 Dec 2011 14:21:33 -0500
In-Reply-To: <4EEAEF83.3080100@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: avagin@gmail.com
Cc: acme@ghostprotocols.net, Andrew Vagin <avagin@openvz.org>, linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu, devel@openvz.org, dsahern@gmail.com, linux-perf-users@vger.kernel.org


Acked-by: Arun Sharma <asharma@fb.com>

Need PERF_SAMPLE_PERIOD for the sleep profiling kernel patch I posted 
earlier.

  -Arun

On 12/15/11 11:13 PM, Andrew Vagin wrote:
> Hi Arnaldo,
>
> Could you review and commit this patch. It's quite common functionality,
> which allow to get events more effectively and to avoid losing events.
>
> All other patches may be postponed, because Arun Sharma wants to suggest
> your version of "Profiling sleep times".
>
> Thanks.
>
> On 12/07/2011 05:55 PM, Andrew Vagin wrote:
>> Signed-off-by: Andrew Vagin<avagin@openvz.org>
>> ---
>> tools/perf/builtin-record.c | 1 +
>> tools/perf/perf.h | 1 +
>> tools/perf/util/evsel.c | 3 +++
>> 3 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 766fa0a..f8fd14f 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -700,6 +700,7 @@ const struct option record_options[] = {
>> OPT_BOOLEAN('d', "data",&record.opts.sample_address,
>> "Sample addresses"),
>> OPT_BOOLEAN('T', "timestamp",&record.opts.sample_time, "Sample
>> timestamps"),
>> + OPT_BOOLEAN('P', "period",&record.opts.period, "Sample period"),
>> OPT_BOOLEAN('n', "no-samples",&record.opts.no_samples,
>> "don't sample"),
>> OPT_BOOLEAN('N', "no-buildid-cache",&record.no_buildid_cache,
>> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
>> index ea804f5..64f8bee 100644
>> --- a/tools/perf/perf.h
>> +++ b/tools/perf/perf.h
>> @@ -200,6 +200,7 @@ struct perf_record_opts {
>> bool sample_time;
>> bool sample_id_all_avail;
>> bool system_wide;
>> + bool period;
>> unsigned int freq;
>> unsigned int mmap_pages;
>> unsigned int user_freq;
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index e2d1b22..8550018 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -108,6 +108,9 @@ void perf_evsel__config(struct perf_evsel *evsel,
>> struct perf_record_opts *opts)
>> if (opts->system_wide)
>> attr->sample_type |= PERF_SAMPLE_CPU;
>>
>> + if (opts->period)
>> + attr->sample_type |= PERF_SAMPLE_PERIOD;
>> +
>> if (opts->sample_id_all_avail&&
>> (opts->sample_time || opts->system_wide ||
>> !opts->no_inherit || opts->cpu_list))
>
