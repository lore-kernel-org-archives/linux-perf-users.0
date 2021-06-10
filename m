Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BE1C47094
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Jun 2021 13:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F41D3613E9
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Jun 2021 13:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhFJN52 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:57:28 -0400
Received: from foss.arm.com ([217.140.110.172]:60682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230035AbhFJN51 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Jun 2021 09:57:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28C9A106F;
        Thu, 10 Jun 2021 06:55:31 -0700 (PDT)
Received: from [10.57.5.44] (unknown [10.57.5.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98EFF3F73D;
        Thu, 10 Jun 2021 06:55:28 -0700 (PDT)
Subject: Re: [PATCH v5 1/1] perf cs-etm: Split Coresight decode by aux records
To:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210610103647.7038-1-james.clark@arm.com>
 <20210610103647.7038-2-james.clark@arm.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <f92553c4-fe72-1a95-3f7c-f7a8481a0538@arm.com>
Date:   Thu, 10 Jun 2021 16:55:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210610103647.7038-2-james.clark@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 10/06/2021 13:36, James Clark wrote:
> +		return auxtrace_queues__add_event(&etm->queues,
> +					       session,
> +					       &auxtrace_fragment,
> +					       file_offset,
> +					       NULL);

There's one more indentation error here that I will fix in the next set.
