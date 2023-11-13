Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B88C1CFAF
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Nov 2023 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0F51D70;
	Mon, 13 Nov 2023 03:50:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9610FEC;
	Mon, 13 Nov 2023 03:51:04 -0800 (PST)
Received: from [10.57.3.129] (unknown [10.57.3.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1575A3F6C4;
	Mon, 13 Nov 2023 03:50:17 -0800 (PST)
Message-ID: <df428c93-e3b8-c60c-001f-2228845983cf@arm.com>
Date: Mon, 13 Nov 2023 11:50:16 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] perf lock info: Enforce exactly one of --map and
 --thread
Content-Language: en-GB
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20231031120526.11502-1-nick.forrington@arm.com>
 <20231031120526.11502-3-nick.forrington@arm.com>
 <ZUEfXU34ZijKe8aA@kernel.org> <3ae2cf90-b0a1-5f54-56aa-ed4a04dca8b0@arm.com>
 <CAM9d7cjQs0BrFAMa4=PGxxPBoGOAVzermH=0HrA1rhegmAA8zg@mail.gmail.com>
 <ZUvvXhkY+NcSxaJU@kernel.org>
From: Nick Forrington <nick.forrington@arm.com>
In-Reply-To: <ZUvvXhkY+NcSxaJU@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 08/11/2023 20:28, Arnaldo Carvalho de Melo wrote:
> Em Wed, Nov 01, 2023 at 11:00:42PM -0700, Namhyung Kim escreveu:
>> On Wed, Nov 1, 2023 at 7:35 AM Nick Forrington <nick.forrington@arm.com> wrote:
>>>
>>> On 31/10/2023 15:38, Arnaldo Carvalho de Melo wrote:
>>>> Em Tue, Oct 31, 2023 at 12:05:25PM +0000, Nick Forrington escreveu:
>>>>> Improve error reporting for command line arguments.
>>>>>
>>>>> Display error/usage if neither --map or --thread are specified (rather
>>>>> than a non user-friendly error "Unknown type of information").
>>>>>
>>>>> Display error/usage if both --map and --thread are specified (rather
>>>>> than ignoring "--map" and displaying only thread information).
>>>> Shouldn't one of them be the default so that we type less for the most
>>>> common usage?
>>>>
>>>> - Arnaldo
>>>>
>>> There isn't an obvious choice (to me) for which would be the default.
>>>
>>> Both options display completely different data/outputs, so I think it
>>> makes sense to be explicit about which data is requested.
>> Maybe we can default to display both. :)
> Yeah, that would be a better approach, I think.
>
> - Arnaldo
>   


I'll submit an updated series for this, with the next update to patch 1/2

Thanks,
Nick

>> Thanks,
>> Namhyung
>>
>>>
>>> An alternative could be to use sub-commands e.g. "perf lock info
>>> threads" or just "perf lock threads", although changing the existing
>>> options would be more disruptive.
>>>
>>>
>>> Cheers,
>>> Nick
>>>
>>>>> Signed-off-by: Nick Forrington <nick.forrington@arm.com>
>>>>> ---
>>>>>    tools/perf/builtin-lock.c | 25 +++++++++++++++++++++++++
>>>>>    1 file changed, 25 insertions(+)
>>>>>
>>>>> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
>>>>> index 3aa8ba5ad928..cf29f648d291 100644
>>>>> --- a/tools/perf/builtin-lock.c
>>>>> +++ b/tools/perf/builtin-lock.c
>>>>> @@ -2021,6 +2021,27 @@ static int check_lock_report_options(const struct option *options,
>>>>>       return 0;
>>>>>    }
>>>>>
>>>>> +static int check_lock_info_options(const struct option *options,
>>>>> +                               const char * const *usage)
>>>>> +{
>>>>> +    if (!info_map && !info_threads) {
>>>>> +            pr_err("Requires one of --map or --threads\n");
>>>>> +            parse_options_usage(usage, options, "map", 0);
>>>>> +            parse_options_usage(NULL, options, "threads", 0);
>>>>> +            return -1;
>>>>> +
>>>>> +    }
>>>>> +
>>>>> +    if (info_map && info_threads) {
>>>>> +            pr_err("Cannot show map and threads together\n");
>>>>> +            parse_options_usage(usage, options, "map", 0);
>>>>> +            parse_options_usage(NULL, options, "threads", 0);
>>>>> +            return -1;
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>>    static int check_lock_contention_options(const struct option *options,
>>>>>                                        const char * const *usage)
>>>>>
>>>>> @@ -2709,6 +2730,10 @@ int cmd_lock(int argc, const char **argv)
>>>>>                       if (argc)
>>>>>                               usage_with_options(info_usage, info_options);
>>>>>               }
>>>>> +
>>>>> +            if (check_lock_info_options(info_options, info_usage) < 0)
>>>>> +                    return -1;
>>>>> +
>>>>>               /* recycling report_lock_ops */
>>>>>               trace_handler = &report_lock_ops;
>>>>>               rc = __cmd_report(true);
>>>>> --
>>>>> 2.42.0
>>>>>
>>>>>
