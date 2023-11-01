Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6971415C8
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Nov 2023 06:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1629C199;
	Tue, 31 Oct 2023 23:35:59 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SKxyb5f1Gz1P7jD;
	Wed,  1 Nov 2023 14:32:55 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 1 Nov 2023 14:35:56 +0800
Subject: Re: [PATCH] perf debug: List available options when no variable is
 specified
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231031080823.1418025-1-yangjihong1@huawei.com>
 <ZUEgVDlBQjFQB2W/@kernel.org>
From: Yang Jihong <yangjihong1@huawei.com>
Message-ID: <7cd2db58-03ad-4424-94a7-712d03c4adb0@huawei.com>
Date: Wed, 1 Nov 2023 14:35:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZUEgVDlBQjFQB2W/@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected

Hello,

On 2023/10/31 23:42, Arnaldo Carvalho de Melo wrote:
> Em Tue, Oct 31, 2023 at 08:08:23AM +0000, Yang Jihong escreveu:
>> Before:
>   
>>    # perf --debug
>>    No variable specified for --debug.
>   
>> After:
>   
>>    # perf --debug
>>    No variable specified for --debug, available options: verbose,ordered-events,stderr,data-convert,perf-event-open.
> 
> Looks useful, but the implementation can be different to reduce
> maintainership costs, see below:
> 
>> +++ b/tools/perf/perf.c
>> @@ -279,7 +279,9 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>>   		} else if (!strcmp(cmd, "--debug")) {
>>   			if (*argc < 2) {
>> -				fprintf(stderr, "No variable specified for --debug.\n");
>> +				fprintf(stderr,
>> +					"No variable specified for --debug, available options: %s.\n",
>> +					perf_debug_options_string);
>>   				usage(perf_usage_string);
> 
>> +++ b/tools/perf/util/debug.c
>> @@ -215,6 +215,9 @@ void trace_event(union perf_event *event)
>>   		     trace_event_printer, event);
>>   }
>>   
>> +const char perf_debug_options_string[] =
>> +	"verbose,ordered-events,stderr,data-convert,perf-event-open";
> 
> Instead of adding a new variable that has to be kept in sync with
> debug_opts[], you could provide a function that iterates debug_opts,
> printing its options names, then use that function on perf.c handle_options.

Thanks for the advice.
OK, will send a v2 patch according to this scheme.

Thanks,
Yang
