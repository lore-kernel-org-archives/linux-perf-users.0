Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF69CC433FE
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Dec 2020 11:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F85822A84
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Dec 2020 11:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgLDLtt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 4 Dec 2020 06:49:49 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2208 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgLDLtt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Dec 2020 06:49:49 -0500
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CnWBn2fqhz67L7M;
        Fri,  4 Dec 2020 19:46:41 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 4 Dec 2020 12:49:07 +0100
Received: from [10.47.5.251] (10.47.5.251) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 4 Dec 2020
 11:49:06 +0000
Subject: Re: [PATCH v6 00/12] perf tools: fix perf stat with large socket IDs
To:     Jiri Olsa <jolsa@redhat.com>, James Clark <james.clark@arm.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <namhyung@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>
References: <20201126141328.6509-1-james.clark@arm.com>
 <20201203153923.GA3613481@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <30c4426d-b314-98ff-e6d5-6d5152f316e8@huawei.com>
Date:   Fri, 4 Dec 2020 11:48:36 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201203153923.GA3613481@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.5.251]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 03/12/2020 15:39, Jiri Olsa wrote:

+

> On Thu, Nov 26, 2020 at 04:13:16PM +0200, James Clark wrote:
>> Changes since v5:
>>    * Fix test for cpu_map__get_die() by shifting id before testing.
>>    * Fix test for cpu_map__get_socket() by not using cpu_map__id_to_socket()
>>      which is only valid in CPU aggregation mode.
>>
>> James Clark (12):
>>    perf tools: Improve topology test
>>    perf tools: Use allocator for perf_cpu_map
>>    perf tools: Add new struct for cpu aggregation
>>    perf tools: Replace aggregation ID with a struct
>>    perf tools: add new map type for aggregation
>>    perf tools: drop in cpu_aggr_map struct
>>    perf tools: Start using cpu_aggr_id in map
>>    perf tools: Add separate node member
>>    perf tools: Add separate socket member
>>    perf tools: Add separate die member
>>    perf tools: Add separate core member
>>    perf tools: Add separate thread member
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> 

Tested-by: John Garry <john.garry@huawei.com>

I still think that vendors (like us) need to fix/improve their firmware 
tables so that we don't get silly big numbers for socket/package IDs, 
like S5418-D0, below:

$./perf stat -a --per-die

  Performance counter stats for 'system wide':

S36-D0   48   72,216.31 msec cpu-clock      #   47.933 CPUs utilized
S36-D0   48        174     context-switches #   0.002 K/sec
S36-D0   48         48     cpu-migrations   #   0.001 K/sec
S36-D0   48         0     page-faults    #   0.000 K/sec
S36-D0   48   7,991,698     cycles    #   0.000 GHz
S36-D0   48   4,750,040     instructions   #   0.59  insn per cycle
S36-D0    1   <not supported>     branches
S36-D0   48      32,928     branch-misses    #   0.00% of all branches
S5418-D0   48   72,189.54 msec cpu-clock     #   47.915 CPUs utilized
S5418-D0   48        176     context-switches  #   0.002 K/sec
S5418-D0   48         48     cpu-migrations   #   0.001 K/sec
S5418-D0   48         0     page-faults     #   0.000 K/sec
S5418-D0   48   5,677,218     cycles    #    0.000 GHz
S5418-D0   48   3,872,285     instructions   #  0.68  insn per cycle
S5418-D0    1   <not supported>     branches
S5418-D0   48      29,208     branch-misses   #  0.00% of all branches

       1.506615297 seconds time elapsed

but at least it works now. Thanks.

> 
>>
>>   tools/perf/builtin-stat.c      | 128 ++++++++++++------------
>>   tools/perf/tests/topology.c    |  64 ++++++++++--
>>   tools/perf/util/cpumap.c       | 171 ++++++++++++++++++++++-----------
>>   tools/perf/util/cpumap.h       |  55 ++++++-----
>>   tools/perf/util/stat-display.c | 102 ++++++++++++--------
>>   tools/perf/util/stat.c         |   2 +-
>>   tools/perf/util/stat.h         |   9 +-
>>   7 files changed, 337 insertions(+), 194 deletions(-)
>>
>> -- 
>> 2.28.0
>>
> 
> .
> 

