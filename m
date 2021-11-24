Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5CEC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Nov 2021 16:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbhKXQk6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 Nov 2021 11:40:58 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4161 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242220AbhKXQkt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Nov 2021 11:40:49 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HzmqN69jYz67lv8;
        Thu, 25 Nov 2021 00:36:32 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 17:37:36 +0100
Received: from [10.202.227.179] (10.202.227.179) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 16:37:35 +0000
Subject: Re: [PATCH v2 2/4] perf tools: Fix SMT not detected
To:     Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
        "Jiri Olsa" <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <eranian@google.com>
References: <20211124001231.3277836-1-irogers@google.com>
 <20211124001231.3277836-2-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <087b81b9-311c-0d75-1255-1122d0a05223@huawei.com>
Date:   Wed, 24 Nov 2021 16:37:34 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211124001231.3277836-2-irogers@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 24/11/2021 00:12, Ian Rogers wrote:
> sysfs__read_int returns 0 on success, and so the fast read path was
> always failing.
> 
> Fixes: bb629484d924 (perf tools: Simplify checking if SMT is active.)
> Signed-off-by: Ian Rogers<irogers@google.com>
> ---

Reviewed-by: John Garry <john.garry@huawei.com>
