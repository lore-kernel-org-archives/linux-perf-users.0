Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EA2C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 11:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C25660F44
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 11:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbhI1Lzn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 07:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbhI1Lzn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 07:55:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F583C061575;
        Tue, 28 Sep 2021 04:54:04 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id r7so14219638pjo.3;
        Tue, 28 Sep 2021 04:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T02aH7Mxy+WrSChuwnEMQ/OGK1+oFfy3dy9rIQ//44g=;
        b=AKUO5KfHqOIbGJtyq/SRl6kGd2SKdOPs+UUt/TW5OrS9X71yNlzFvPgYS6xL/c2Tth
         WJSKTgce1mUWiEQ721Bm1fJLuRn/5M4eidVpHZh6kLqowCl8DdDBlinpuq/lJphdlaoG
         1gBnf3mynVHb1dFRdhJEFBQcLPAniPoUkCnaUB81UjXhIulcvdVwrjZQgtdcIaTz97Wy
         yRKuSo+l4mB1iAh6/pdiKw9JqJl8KGNhtr5ckTeW4Fa78X5e6OKEkqTSen/HXA73YHxq
         VRK6fu3+NT603QgANkNa9mJK1VXppHOvI+bHDSCShqpR1j7cvWT0bDrfGzIg7lgUYIZ2
         o+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=T02aH7Mxy+WrSChuwnEMQ/OGK1+oFfy3dy9rIQ//44g=;
        b=t0MC1zCbuCvGt8Gl4oaajd4tXswD+dCdVXlCO5yvCR5kicQJih2RJpXeWnAuAVZiDk
         JGA4yBTrvRwOaJqPTiClDDbAc89lSA6ibhyBI4BNCMDZhwUcv+ZZgXk2TuwOs7Rrk2e/
         kNAvug6gNDjvIhEVbOuqhwkPrH+o6AQi0TrlnHGE2TvmaTmgm58hKZqgYFpk8oN/EYo7
         XUm7QSxp4FjnFLx/wASHMc3GUjXDvlfy+llHjPHEleCIOEaiAaN8C69jYPxX+2Fvgd4O
         ruXUAAhDmG+Smm6tKgWiMShKqgUImuBsRcXfjEiHtayxoWXlcvmG5B64X80RXvh+z6G8
         R0Nw==
X-Gm-Message-State: AOAM530QP/ltSY2xXA9PCK3XwGO7pCcK6p5q6GYH/TKTYtk7PqkSvhII
        65NTkyLPubmTdORAoUn19nfbD7T9rxB7hw==
X-Google-Smtp-Source: ABdhPJxKetPtDb0VMYGWmHkUMoIBDrnKfpj4VxYRUbDRgAhbae4Nw4zR7qzVwiYJfe7Pw7PrRn2vLw==
X-Received: by 2002:a17:90a:b009:: with SMTP id x9mr5022447pjq.100.1632830043558;
        Tue, 28 Sep 2021 04:54:03 -0700 (PDT)
Received: from Likes-MacBook-Pro.local ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id x13sm19855324pff.70.2021.09.28.04.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 04:54:03 -0700 (PDT)
Subject: Re: [PATCH] perf jevents: Fix sys_event_tables to be freed like
 arch_std_events
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     John Garry <john.garry@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210928102938.69681-1-likexu@tencent.com>
 <YVMB5kt8XG+OdJ1M@kernel.org>
From:   Like Xu <like.xu.linux@gmail.com>
Organization: Tencent
Message-ID: <7ff0a3bf-ebfc-2462-f6ed-d86a67bbd614@gmail.com>
Date:   Tue, 28 Sep 2021 19:53:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVMB5kt8XG+OdJ1M@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 28/9/2021 7:52 pm, Arnaldo Carvalho de Melo wrote:
> Em Tue, Sep 28, 2021 at 06:29:38PM +0800, Like Xu escreveu:
>> From: Like Xu <likexu@tencent.com>
>>
>> The compiler reports that free_sys_event_tables() is dead code. But
>> according to the semantics, the "LIST_HEAD(arch_std_events)" should
Sorry, s/arch_std_events/sys_event_tables/, please --amend.

>> also be released, just like we do with 'arch_std_events' in the main().
> 
> Thanks, applied.
> 
> - Arnaldo
> 
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
