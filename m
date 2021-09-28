Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE684C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 12:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FE4610E5
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 12:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbhI1MsE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 08:48:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3883 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240578AbhI1MsD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 08:48:03 -0400
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HJfLt2rLvz67jYn;
        Tue, 28 Sep 2021 20:43:34 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 28 Sep 2021 14:46:22 +0200
Received: from [10.47.85.67] (10.47.85.67) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 13:46:21 +0100
Subject: Re: [PATCH] perf jevents: Fix sys_event_tables to be freed like
 arch_std_events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Like Xu <like.xu.linux@gmail.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210928102938.69681-1-likexu@tencent.com>
 <YVMB5kt8XG+OdJ1M@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c547bc2d-ab7c-1e89-5d12-bd5d875f7aa5@huawei.com>
Date:   Tue, 28 Sep 2021 13:49:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YVMB5kt8XG+OdJ1M@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.85.67]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 28/09/2021 12:52, Arnaldo Carvalho de Melo wrote:
> Em Tue, Sep 28, 2021 at 06:29:38PM +0800, Like Xu escreveu:
>> From: Like Xu <likexu@tencent.com>
>>
>> The compiler reports that free_sys_event_tables() is dead code. But
>> according to the semantics, the "LIST_HEAD(arch_std_events)" should
>> also be released, just like we do with 'arch_std_events' in the main().
> 
> Thanks, applied.
> 
> - Arnaldo
> 

If not too late:
Reviewed-by: John Garry <john.garry@huawei.com>

I think that it could be a good idea to raise gcc warning level to 
detect unused static functions, like this was

thanks

>   
>> Fixes: e9d32c1bf0cd7a98 ("perf vendor events: Add support for arch standard events")
>> Signed-off-by: Like Xu <likexu@tencent.com>
>> ---
>>   tools/perf/pmu-events/jevents.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
>> index 6731b3cf0c2f..7c887d37b893 100644
>> --- a/tools/perf/pmu-events/jevents.c
>> +++ b/tools/perf/pmu-events/jevents.c
>> @@ -1285,6 +1285,7 @@ int main(int argc, char *argv[])
>>   	}
>>   
>>   	free_arch_std_events();
>> +	free_sys_event_tables();
>>   	free(mapfile);
>>   	return 0;
>>   
>> @@ -1306,6 +1307,7 @@ int main(int argc, char *argv[])
>>   		create_empty_mapping(output_file);
>>   err_out:
>>   	free_arch_std_events();
>> +	free_sys_event_tables();
>>   	free(mapfile);
>>   	return ret;
>>   }
>> -- 
>> 2.32.0
> 

