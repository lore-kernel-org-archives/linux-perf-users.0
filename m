Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA47C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Mar 2022 02:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357700AbiCYCMA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Mar 2022 22:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357703AbiCYCLv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Mar 2022 22:11:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0602FA6E3F;
        Thu, 24 Mar 2022 19:06:49 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KPlm92dXVzfZmJ;
        Fri, 25 Mar 2022 10:05:13 +0800 (CST)
Received: from [10.174.179.211] (10.174.179.211) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Mar 2022 10:06:47 +0800
Subject: Re: [PATCH RESEND 1/2] perf string: Add strcmp_prefix()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rui.xiang@huawei.com>, <guohanjun@huawei.com>
References: <20220318092245.2700489-1-liwei391@huawei.com>
 <20220318092245.2700489-2-liwei391@huawei.com> <Yjo+MdJaauraN6eX@kernel.org>
From:   "liwei (GF)" <liwei391@huawei.com>
Message-ID: <da8c82ac-3895-f4ef-9887-dae9ba80787a@huawei.com>
Date:   Fri, 25 Mar 2022 10:06:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <Yjo+MdJaauraN6eX@kernel.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.211]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 2022/3/23 5:22, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 18, 2022 at 05:22:44PM +0800, Wei Li escreveu:
>> Add a helper to check whether a string has the given prefix.
>> This function is stolen from fs/xattr.c
> 
> Can't you use strstarts()? See tools/include/linux/string.h.
> 

Sorry, i haven't known that before, will use strstarts() in v2.

Thanks,
Wei

>  
>> Signed-off-by: Wei Li <liwei391@huawei.com>
>> ---
>>  tools/perf/util/string.c  | 17 +++++++++++++++++
>>  tools/perf/util/string2.h |  1 +
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
>> index f6d90cdd9225..0ed3e2d0b70f 100644
>> --- a/tools/perf/util/string.c
>> +++ b/tools/perf/util/string.c
>> @@ -209,6 +209,23 @@ int strtailcmp(const char *s1, const char *s2)
>>  	return 0;
>>  }
>>  
>> +/**
>> + * strcmp_prefix - check string for given prefix
>> + * @str: the target string to check
>> + * @prefix: the given prefix to match
>> + *
>> + * Return the rest string in @str if @str has the given @prefix, return NULL
>> + * otherwise.
>> + */
>> +const char *strcmp_prefix(const char *str, const char *prefix)
>> +{
>> +	while (*prefix && *str == *prefix) {
>> +		str++;
>> +		prefix++;
>> +	}
>> +	return *prefix ? NULL : str;
>> +}
>> +
>>  char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints)
>>  {
>>  	/*
>> diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
>> index 56c30fef9682..58929ad928f7 100644
>> --- a/tools/perf/util/string2.h
>> +++ b/tools/perf/util/string2.h
>> @@ -20,6 +20,7 @@ static inline bool strisglob(const char *str)
>>  	return strpbrk(str, "*?[") != NULL;
>>  }
>>  int strtailcmp(const char *s1, const char *s2);
>> +const char *strcmp_prefix(const char *str, const char *prefix);
>>  
>>  char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints);
>>  
>> -- 
>> 2.25.1
> 
