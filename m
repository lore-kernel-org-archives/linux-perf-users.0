Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F862C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 May 2022 16:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbiETQQh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 May 2022 12:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351411AbiETQQg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 May 2022 12:16:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C792C5DBD9;
        Fri, 20 May 2022 09:16:34 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L4Ww82TKXz67PTQ;
        Sat, 21 May 2022 00:12:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Fri, 20 May 2022 18:16:31 +0200
Received: from [10.47.85.144] (10.47.85.144) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 20 May
 2022 17:16:30 +0100
Message-ID: <1afa1215-012d-1fad-132c-d2b5db241b3a@huawei.com>
Date:   Fri, 20 May 2022 17:16:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/1] perf vendors events arm64: Update Cortex A57/A72
To:     Nick Forrington <nick.forrington@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220517135805.313184-1-nick.forrington@arm.com>
 <20220517135805.313184-2-nick.forrington@arm.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220517135805.313184-2-nick.forrington@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.85.144]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 17/05/2022 14:58, Nick Forrington wrote:
> Categorise and add missing PMU events for Cortex-A57/A72, based on:
> https://github.com/ARM-software/data/blob/master/pmu/cortex-a57.json
> https://github.com/ARM-software/data/blob/master/pmu/cortex-a72.json
> 
> These contain the same events, and are based on the Arm Technical
> Reference Manuals for Cortex-A57 and Cortex-A72.
> 
> Signed-off-by: Nick Forrington<nick.forrington@arm.com>
> ---

Thanks

Reviewed-by: John Garry <john.garry@huawei.com>
