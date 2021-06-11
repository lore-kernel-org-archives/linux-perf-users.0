Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFC5C48BE5
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 13:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 068A561407
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 13:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhFKN70 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Jun 2021 09:59:26 -0400
Received: from foss.arm.com ([217.140.110.172]:59162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhFKN7Z (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Jun 2021 09:59:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7DE01FB;
        Fri, 11 Jun 2021 06:57:27 -0700 (PDT)
Received: from [10.57.8.45] (unknown [10.57.8.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F7303F73D;
        Fri, 11 Jun 2021 06:57:25 -0700 (PDT)
Subject: Re: [PATCH v6 1/1] perf cs-etm: Split Coresight decode by aux records
To:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210611090039.22450-1-james.clark@arm.com>
 <20210611090039.22450-2-james.clark@arm.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <e63e820d-d84a-cb83-cf1d-cc9750dfb7b0@arm.com>
Date:   Fri, 11 Jun 2021 14:57:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210611090039.22450-2-james.clark@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 11/06/2021 12:00, James Clark wrote:
> Populate the auxtrace queues using AUX records rather than whole
> auxtrace buffers so that the decoder is reset between each aux record.
> 

I'd like to not have this applied for the time being. Testing Leo's
snapshot fix has turned up some interactions with snapshot mode that I'm not
100% sure about yet.
