Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393D9C4338F
	for <linux-perf-users@archiver.kernel.org>; Thu, 12 Aug 2021 04:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0643560F91
	for <linux-perf-users@archiver.kernel.org>; Thu, 12 Aug 2021 04:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhHLEdV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 12 Aug 2021 00:33:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:37429 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhHLEdV (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 12 Aug 2021 00:33:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10073"; a="215303541"
X-IronPort-AV: E=Sophos;i="5.84,314,1620716400"; 
   d="scan'208";a="215303541"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 21:32:56 -0700
X-IronPort-AV: E=Sophos;i="5.84,314,1620716400"; 
   d="scan'208";a="517293211"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.249.174.184]) ([10.249.174.184])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 21:32:52 -0700
Subject: Re: [PATCH v4 1/2] perf pmu: Add PMU alias support
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        rickyman7@gmail.com, Kan Liang <kan.liang@linux.intel.com>
References: <20210811024827.9483-1-yao.jin@linux.intel.com>
 <20210811024827.9483-2-yao.jin@linux.intel.com> <YRQjreot69DL0xVV@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <6401ef3a-1a59-4575-7c1d-8065e8a2b5c6@linux.intel.com>
Date:   Thu, 12 Aug 2021 12:32:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRQjreot69DL0xVV@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Jiri,

On 8/12/2021 3:23 AM, Jiri Olsa wrote:
> On Wed, Aug 11, 2021 at 10:48:26AM +0800, Jin Yao wrote:
> 
> SNIP
> 
>>   				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index fc683bc41715..796a4be752f4 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -946,6 +946,18 @@ perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
>>   	return NULL;
>>   }
>>   
>> +char * __weak
>> +pmu_find_real_name(const char *name)
>> +{
>> +	return strdup(name);
>> +}
> hm, why does this need to return already strdup? it forces you
> to add all those goto below.. could just return name and keep
> the 'pmu->name = strdup(name);' below?
> 
> that should make the change simpler
> 
> jirka
> 

In x86 specific __pmu_find_real_name,

static char *__pmu_find_real_name(const char *name)
{
	struct perf_pmu_alias_name *pmu;

	list_for_each_entry(pmu, &pmu_alias_name_list, list) {
		if (!strcmp(name, pmu->alias))
			return strdup(pmu->name);
	}

	return strdup(name);
}

We have returned with strdup(name).

OK, I will change the code to:

static char *__pmu_find_real_name(const char *name)
{
	struct perf_pmu_alias_name *pmu;

	list_for_each_entry(pmu, &pmu_alias_name_list, list) {
		if (!strcmp(name, pmu->alias))
			return pmu->name;
	}

	return name;
}

And keep 'pmu->name = strdup(name);' in pmu_lookup().

Thanks
Jin Yao
