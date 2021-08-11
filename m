Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949A6C4338F
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 08:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79894600CD
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 08:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbhHKIBW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 11 Aug 2021 04:01:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3623 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbhHKIA3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 11 Aug 2021 04:00:29 -0400
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gl2K95Xq9z6D8n2;
        Wed, 11 Aug 2021 15:59:25 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 11 Aug 2021 10:00:01 +0200
Received: from [10.47.80.4] (10.47.80.4) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 11 Aug
 2021 09:00:00 +0100
Subject: Re: [PATCH 02/11] perf jevents: Relocate test events to cpu folder
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <yao.jin@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <irogers@google.com>, <linuxarm@huawei.com>
References: <1627566986-30605-1-git-send-email-john.garry@huawei.com>
 <1627566986-30605-3-git-send-email-john.garry@huawei.com>
 <YQgHMt4BsDeJnE09@kernel.org>
 <90094733-741c-50e5-ac7d-f5640b5f0bdd@huawei.com>
 <88294bb8-6fb1-b485-446c-4ec15ff28d4a@huawei.com>
 <YRKGo1AtfBn85sZ7@kernel.org>
 <40e85ad2-3db4-aecf-d972-7d4aa5c2278c@huawei.com>
 <YRK+X/f44UK+btRx@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b64a644a-1dfd-2e3b-319c-c53d43c96025@huawei.com>
Date:   Wed, 11 Aug 2021 08:59:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YRK+X/f44UK+btRx@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.4]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 10/08/2021 18:58, Arnaldo Carvalho de Melo wrote:
>> I think that you can apply it before the series. This is a pre-existing
>> issue that there was no dependency checking on the test events folder for
>> rebuilding pmu-event.c .
> Its all now in tmp.perf/core, will move to perf/core as soon as my test
> suite finishes.

Excellent, thanks!
