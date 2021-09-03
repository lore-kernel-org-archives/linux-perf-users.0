Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE5AC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Sep 2021 09:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BABA360F90
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Sep 2021 09:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244006AbhICJKH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 3 Sep 2021 05:10:07 -0400
Received: from foss.arm.com ([217.140.110.172]:39118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242812AbhICJKH (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Sep 2021 05:10:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 544021FB;
        Fri,  3 Sep 2021 02:09:07 -0700 (PDT)
Received: from [10.57.92.220] (unknown [10.57.92.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17CDA3F694;
        Fri,  3 Sep 2021 02:09:04 -0700 (PDT)
Subject: Re: [PATCH v2 5/9] perf cs-etm: Fix typo
To:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, mike.leach@linaro.org
Cc:     acme@kernel.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-6-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <5679e1e1-b5c4-b763-2fe7-7dd8b7ef1a9d@arm.com>
Date:   Fri, 3 Sep 2021 10:09:03 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210806134109.1182235-6-james.clark@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 06/08/2021 14:41, James Clark wrote:
> TRCIRD2 should be TRCIDR2
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
