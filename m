From: zhangmengting <zhangmengting@huawei.com>
Subject: Re: [PATCH] perf report: Fix debug messages with --call-graph option
Date: Sat, 23 Sep 2017 16:19:38 +0800
Message-ID: <526e703d-8d14-f43a-e09a-cba6bdb31f65@huawei.com>
References: <1506046013-34848-1-git-send-email-zhangmengting@huawei.com>
 <20170922091841.GJ15856@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:6556 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbdIWIVr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 23 Sep 2017 04:21:47 -0400
In-Reply-To: <20170922091841.GJ15856@krava>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org, kjlx@templeofstupid.com, milian.wolff@kdab.com, wangnan0@huawei.com, huawei.libin@huawei.com

Hi Jiri,

Thanks for the review. Agreed, the patch seems confused.

I'll add more details in the next version patch and resend it later.

Thanks,

Mengting Zhang


On 2017/9/22 17:18, Jiri Olsa wrote:
> On Fri, Sep 22, 2017 at 10:06:53AM +0800, zhangmengting wrote:
>> With --call-graph option, perf report can display call chains using
>> type, min percent threshold, optional print limit and order. And the
>> default call-graph parameter is 'graph,0.5,caller,function,percent'.
>>
>> Before this patch, 'perf report --call-graph' shows incorrect debug
>> messages as below:
>> [root@localhost perf]# ./perf report --call-graph
>> Invalid callchain mode: 0.5
>> Invalid callchain order: 0.5
>> Invalid callchain sort key: 0.5
>> Invalid callchain config key: 0.5
>> Invalid callchain mode: caller
>> Invalid callchain mode: function
>> Invalid callchain order: function
>> Invalid callchain mode: percent
>> Invalid callchain order: percent
>> Invalid callchain sort key: percent
> hum, could you please mention what was wrong with
> the code and why the change fixes them?
>
> looks like you just moved the warning out of the
> way of the report
>
> thanks,
> jirka
>
>> The patch fixes this issue.
>>
>> Signed-off-by: zhangmengting <zhangmengting@huawei.com>
>> ---
>>   tools/perf/util/callchain.c | 35 +++++++++++++++++++++--------------
>>   1 file changed, 21 insertions(+), 14 deletions(-)
>>
>> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
>> index 510b513..be09d77 100644
>> --- a/tools/perf/util/callchain.c
>> +++ b/tools/perf/util/callchain.c
>> @@ -65,8 +65,6 @@ static int parse_callchain_mode(const char *value)
>>   		callchain_param.mode = CHAIN_FOLDED;
>>   		return 0;
>>   	}
>> -
>> -	pr_err("Invalid callchain mode: %s\n", value);
>>   	return -1;
>>   }
>>   
>> @@ -82,8 +80,6 @@ static int parse_callchain_order(const char *value)
>>   		callchain_param.order_set = true;
>>   		return 0;
>>   	}
>> -
>> -	pr_err("Invalid callchain order: %s\n", value);
>>   	return -1;
>>   }
>>   
>> @@ -105,8 +101,6 @@ static int parse_callchain_sort_key(const char *value)
>>   		callchain_param.branch_callstack = 1;
>>   		return 0;
>>   	}
>> -
>> -	pr_err("Invalid callchain sort key: %s\n", value);
>>   	return -1;
>>   }
>>   
>> @@ -124,8 +118,6 @@ static int parse_callchain_value(const char *value)
>>   		callchain_param.value = CCVAL_COUNT;
>>   		return 0;
>>   	}
>> -
>> -	pr_err("Invalid callchain config key: %s\n", value);
>>   	return -1;
>>   }
>>   
>> @@ -319,12 +311,27 @@ int perf_callchain_config(const char *var, const char *value)
>>   
>>   		return ret;
>>   	}
>> -	if (!strcmp(var, "print-type"))
>> -		return parse_callchain_mode(value);
>> -	if (!strcmp(var, "order"))
>> -		return parse_callchain_order(value);
>> -	if (!strcmp(var, "sort-key"))
>> -		return parse_callchain_sort_key(value);
>> +	if (!strcmp(var, "print-type")){
>> +		int ret;
>> +		ret = parse_callchain_mode(value);
>> +		if (ret == -1)
>> +			pr_err("Invalid callchain mode: %s\n", value);
>> +		return ret;
>> +	}
>> +	if (!strcmp(var, "order")){
>> +		int ret;
>> +		ret = parse_callchain_order(value);
>> +		if (ret == -1)
>> +			pr_err("Invalid callchain order: %s\n", value);
>> +		return ret;
>> +	}
>> +	if (!strcmp(var, "sort-key")){
>> +		int ret;
>> +		ret = parse_callchain_sort_key(value);
>> +		if (ret == -1)
>> +			pr_err("Invalid callchain sort key: %s\n", value);
>> +		return ret;
>> +	}
>>   	if (!strcmp(var, "threshold")) {
>>   		callchain_param.min_percent = strtod(value, &endptr);
>>   		if (value == endptr) {
>> -- 
>> 1.7.12.4
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> .
>
