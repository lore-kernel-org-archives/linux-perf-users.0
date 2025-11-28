Received: from a7-30.smtp-out.eu-west-1.amazonses.com (a7-30.smtp-out.eu-west-1.amazonses.com [54.240.7.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9192E0417;
	Fri, 28 Nov 2025 21:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764367019; cv=none; b=hQnIwdch8zaznZ5cvcOBaUqK+UloVnFMCFwrFWClz6MuXjegKuBX9/7yPIpe2AidbtEt8+I0sOOPwj77zgrVrgDdecM+JDUzU+O3U7HDG2bBgwGyxweV5YOHf9joxsWt2iOcnOCHcH6GgJMCCT2frNNpjYnCTQqy6EORImZHuBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764367019; c=relaxed/simple;
	bh=Saa5pNgP2pKUD4OHZdkqRgrnxMwpNYXd9S/zK6VIRnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJI95Iebf1GELUC/LDR+G4ccbAcEzqUcZLWm4MxfTVYcblfARfU3BFBpXUXtNeCMEPdSK3p4NJg1Qcr+ZFDSAZBMYdRqwx077ae8GXmbTOkI+QEHXL+2zzfpA3KZbe6wXxlQvR+HMURgh19vbK6EaT8Zy4nmb38fwzDbz7sMdbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dlybyKOH; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=B0DG2BX9; arc=none smtp.client-ip=54.240.7.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dlybyKOH";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="B0DG2BX9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=5uqmrq7mz5dkaze44elodgxarejai7vg; d=collabora.com; t=1764367015;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Saa5pNgP2pKUD4OHZdkqRgrnxMwpNYXd9S/zK6VIRnM=;
	b=dlybyKOHSe9l6RlOFUCwfrws95AxmnwfY9WHTs6NYDmadAr3TK/4czWr3cd+DYjG
	FRt6iFOd4nar8buJIMwcB82t4RZLZBdUI4OUivs5c2MssqmQYN6XTSsF7TxL5ytwUD/
	5qYL0Ag5zmApgd1V8nKzur0sjcu3GibTgEBXn3vZEAVQZjc5wjGduTS+oIhKdXfHVfV
	o0LcUafcBGzqGtqYcmkh18ynCzbXwlpXNltWMwsU1ZUJT7K2yIxrDD9FER5/1KrRPee
	krMOCDoF7WM/TUHU1M8By30YsHZ/zvlOnib2ouGt5mAgOV3nfG8LSt6TT/3YiIjlHFT
	epW7WZ7XcQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1764367015;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=Saa5pNgP2pKUD4OHZdkqRgrnxMwpNYXd9S/zK6VIRnM=;
	b=B0DG2BX9iJAFOE2MOmsLccFeK0+IViCJp2wru8xqu+Eu+SbQpjVtc9+PKxflo7k9
	YkWHvaulyi3nZHSD5PpgaeBd2xYdS2DU13dXSaAMvVpypiHtVd/U5zh9grlFP7ODPHx
	9ft7MQ06BTlYUa7hc5C9Gd9UqYxnmnQTNrrWYLCM=
Message-ID: <0102019acc781e84-04b7506a-b3d0-4290-a2dd-5c8e6a8a1f5b-000000@eu-west-1.amazonses.com>
Date: Fri, 28 Nov 2025 21:56:55 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf data: Allow filtering conversion by start and end
 time
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, kernel@collabora.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251124212301.450296-1-derek.foreman@collabora.com>
 <aSjD8WC9qUzjrvH6@google.com>
Content-Language: en-CA
From: Derek Foreman <derek.foreman@collabora.com>
In-Reply-To: <aSjD8WC9qUzjrvH6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2025.11.28-54.240.7.30

On 11/27/25 3:34 PM, Namhyung Kim wrote:
> Hello,
>
> On Mon, Nov 24, 2025 at 03:23:00PM -0600, Derek Foreman wrote:
>> This adds a feature to allow restricting the range of converted samples
>> with start and end times specified in nanoseconds.
>>
>> Use it like this:
>>
>>    $ perf data convert --to-json out.json -s 12345 -e 13340
>>
>> Start, end, or both may be omitted.
> Looks useful, thanks!
Thanks for the review!
>> Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
>> ---
>>   tools/perf/Documentation/perf-data.txt |  6 ++++++
>>   tools/perf/builtin-data.c              |  4 ++++
>>   tools/perf/util/data-convert-bt.c      | 18 ++++++++++++++++++
>>   tools/perf/util/data-convert-json.c    | 18 ++++++++++++++++++
>>   tools/perf/util/data-convert.h         |  3 +++
>>   5 files changed, 49 insertions(+)
>>
>> diff --git a/tools/perf/Documentation/perf-data.txt b/tools/perf/Documentation/perf-data.txt
>> index 417bf17e265c..db0de1f354a3 100644
>> --- a/tools/perf/Documentation/perf-data.txt
>> +++ b/tools/perf/Documentation/perf-data.txt
>> @@ -40,6 +40,12 @@ OPTIONS for 'convert'
>>   --force::
>>   	Don't complain, do it.
>>   
>> +-s::
> Please add this as well.
>
> --start=<TIME>::
>
>> +	Start time, in nanoseconds. Samples before this time will not be converted.
> It'd be nice if you mention that users can see the timestamp from perf
> script or so.

After looking at perf script, I realized I'd reinvented the wheel here, 
so in v2 I've used `--time` and the util functions that already exist 
for parsing and filtering time strings.

I mostly copy and pasted the --time help from another file. I think 
asciidoc has a way to templatize this with an include file (it's in at 
least 3 files now), but I wasn't sure if I should try to do that.

>
>> +
>> +-e::
> --end=<TIME>::
>
>> +	End time, in nanoseconds. Samples after this time will not be converted.
>> +
>>   -v::
>>   --verbose::
>>           Be more verbose (show counter open errors, etc).
>> diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
>> index ce51cbf6dc97..da813c62e284 100644
>> --- a/tools/perf/builtin-data.c
>> +++ b/tools/perf/builtin-data.c
>> @@ -33,6 +33,8 @@ const char *to_ctf;
>>   struct perf_data_convert_opts opts = {
>>   	.force = false,
>>   	.all = false,
>> +	.range_start = 0,
>> +	.range_end = 0,
>>   };
>>   
>>   const struct option data_options[] = {
>> @@ -45,6 +47,8 @@ const struct option data_options[] = {
>>   #endif
>>   		OPT_BOOLEAN('f', "force", &opts.force, "don't complain, do it"),
>>   		OPT_BOOLEAN(0, "all", &opts.all, "Convert all events"),
>> +		OPT_U64('s', "start", &opts.range_start, "Earliest timestamp to convert"),
>> +		OPT_U64('e', "end", &opts.range_end, "Latest timestamp to convert"),
>>   		OPT_END()
>>   	};
>>   
>> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
>> index 3d2e437e1354..6819f11fe900 100644
>> --- a/tools/perf/util/data-convert-bt.c
>> +++ b/tools/perf/util/data-convert-bt.c
>> @@ -91,9 +91,13 @@ struct convert {
>>   	struct perf_tool	tool;
>>   	struct ctf_writer	writer;
>>   
>> +	u64			start;
>> +	u64			end;
>> +
>>   	u64			events_size;
>>   	u64			events_count;
>>   	u64			non_sample_count;
>> +	u64			skipped;
>>   
>>   	/* Ordered events configured queue size. */
>>   	u64			queue_size;
>> @@ -811,6 +815,12 @@ static int process_sample_event(const struct perf_tool *tool,
>>   	if (WARN_ONCE(!priv, "Failed to setup all events.\n"))
>>   		return 0;
>>   
>> +	if (sample->time < c->start ||
>> +	    (c->end && sample->time > c->end)) {
>> +		++c->skipped;
>> +		return 0;
>> +	}
>> +
>>   	event_class = priv->event_class;
>>   
>>   	/* update stats */
>> @@ -1626,6 +1636,9 @@ int bt_convert__perf2ctf(const char *input, const char *path,
>>   	c.tool.namespaces      = perf_event__process_namespaces;
>>   	c.tool.ordering_requires_timestamps = true;
>>   
>> +	c.start = opts->range_start;
>> +	c.end = opts->range_end;
>> +
>>   	if (opts->all) {
>>   		c.tool.comm = process_comm_event;
>>   		c.tool.exit = process_exit_event;
>> @@ -1677,6 +1690,11 @@ int bt_convert__perf2ctf(const char *input, const char *path,
>>   		"[ perf data convert: Converted '%s' into CTF data '%s' ]\n",
>>   		data.path, path);
>>   
>> +	if (c.skipped)
>> +		fprintf(stderr,
>> +			"[ perf data convert: Skipped %" PRIu64 " samples",
>> +			c.skipped);
> This is a strange style to have the literal in a different line.  It'd
> be nice if you can fix others too - probably in a separate commit.
>
> And this line could come after the next, but it's up to you.
I think it's better your way, yes.
> Also it'd be recommended to have a pair of parentheses for multi-line
> bodies even it's a single statement.

I've added a second patch for v2. One of the lines exceeded 100 chars, 
which bothered checkpatch.pl, so I left the literal on the second line 
for now.

Thanks,
Derek

>> +
>>   	fprintf(stderr,
>>   		"[ perf data convert: Converted and wrote %.3f MB (%" PRIu64 " samples",
>>   		(double) c.events_size / 1024.0 / 1024.0,
>> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
>> index 9dc1e184cf3c..dcbba34d6b08 100644
>> --- a/tools/perf/util/data-convert-json.c
>> +++ b/tools/perf/util/data-convert-json.c
>> @@ -35,7 +35,11 @@ struct convert_json {
>>   	struct perf_tool tool;
>>   	FILE *out;
>>   	bool first;
>> +	u64 start;
>> +	u64 end;
>> +
>>   	u64 events_count;
>> +	u64 skipped;
>>   };
>>   
>>   // Outputs a JSON-encoded string surrounded by quotes with characters escaped.
>> @@ -165,6 +169,12 @@ static int process_sample_event(const struct perf_tool *tool,
>>   		return -1;
>>   	}
>>   
>> +	if (sample->time < c->start ||
>> +	    (c->end && sample->time > c->end)) {
>> +		++c->skipped;
>> +		return 0;
>> +	}
>> +
>>   	++c->events_count;
>>   
>>   	if (c->first)
>> @@ -320,6 +330,9 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
>>   	struct convert_json c = {
>>   		.first = true,
>>   		.events_count = 0,
>> +		.start = opts->range_start,
>> +		.end = opts->range_end,
>> +		.skipped = 0,
>>   	};
>>   	struct perf_data data = {
>>   		.mode = PERF_DATA_MODE_READ,
>> @@ -407,6 +420,11 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
>>   			"[ perf data convert: Converted '%s' into JSON data '%s' ]\n",
>>   			data.path, output_name);
>>   
>> +	if (c.skipped)
>> +		fprintf(stderr,
>> +				"[ perf data convert: Skipped %" PRIu64 " samples.\n",
>> +				c.skipped);
> Ditto.
>
> Thanks,
> Namhyung
>
>> +
>>   	fprintf(stderr,
>>   			"[ perf data convert: Converted and wrote %.3f MB (%" PRIu64 " samples) ]\n",
>>   			(ftell(c.out)) / 1024.0 / 1024.0, c.events_count);
>> diff --git a/tools/perf/util/data-convert.h b/tools/perf/util/data-convert.h
>> index 1b4c5f598415..5d055e1c31c8 100644
>> --- a/tools/perf/util/data-convert.h
>> +++ b/tools/perf/util/data-convert.h
>> @@ -3,11 +3,14 @@
>>   #define __DATA_CONVERT_H
>>   
>>   #include <stdbool.h>
>> +#include <linux/types.h>
>>   
>>   struct perf_data_convert_opts {
>>   	bool force;
>>   	bool all;
>>   	bool tod;
>> +	u64 range_start;
>> +	u64 range_end;
>>   };
>>   
>>   #ifdef HAVE_LIBBABELTRACE_SUPPORT
>> -- 
>> 2.47.3
>>
