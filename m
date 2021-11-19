Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B3CC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 Nov 2021 14:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C7E961B27
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 Nov 2021 14:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbhKSOuu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 19 Nov 2021 09:50:50 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4113 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhKSOut (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 Nov 2021 09:50:49 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HwfYp4Y7sz67h5c;
        Fri, 19 Nov 2021 22:43:58 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 19 Nov 2021 15:47:45 +0100
Received: from [10.47.86.94] (10.47.86.94) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 19 Nov
 2021 14:47:44 +0000
Subject: Re: [PATCH v2 2/2] perf parse-events: Architecture specific leader
 override
To:     Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
        "Jiri Olsa" <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Vineet Singh" <vineet.singh@intel.com>
CC:     <eranian@google.com>
References: <20211118220647.2355999-1-irogers@google.com>
 <20211118220647.2355999-2-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <17f31c73-052d-ef15-879a-c6a224977e8d@huawei.com>
Date:   Fri, 19 Nov 2021 14:47:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211118220647.2355999-2-irogers@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.86.94]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 18/11/2021 22:06, Ian Rogers wrote:
> Currently topdown events must appear after a slots event:
> 
> $ perf stat -e '{slots,topdown-fe-bound}' /bin/true
> 
>   Performance counter stats for '/bin/true':
> 
>           3,183,090      slots
>             986,133      topdown-fe-bound
> 
> Reversing the events yields:
> 
> $ perf stat -e '{topdown-fe-bound,slots}' /bin/true
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (topdown-fe-bound).
> 
> For metrics the order of events is determined by iterating over a
> hashmap, and so slots isn't guaranteed to be first which can yield this
> error.
> 
> Change the set_leader in parse-events, called when a group is closed, so
> that rather than always making the first event the leader, if the slots
> event exists then it is made the leader. It is then moved to the head of
> the evlist otherwise it won't be opened in the correct order.
> 
> The result is:
> 
> $ perf stat -e '{topdown-fe-bound,slots}' /bin/true

Just curious - does this just affect topdown events? I think x86 is the 
only arch which has them.

Thanks,
John
