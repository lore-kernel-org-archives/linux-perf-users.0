Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0714C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Nov 2022 23:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiKHXbI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Nov 2022 18:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiKHXbI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Nov 2022 18:31:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22698BF63;
        Tue,  8 Nov 2022 15:31:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94E2623A;
        Tue,  8 Nov 2022 15:31:10 -0800 (PST)
Received: from [10.57.68.207] (unknown [10.57.68.207])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5B443F703;
        Tue,  8 Nov 2022 15:31:02 -0800 (PST)
Message-ID: <607fe06e-5109-ecfe-155b-624422970bdf@arm.com>
Date:   Tue, 8 Nov 2022 23:31:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v5 09/14] perf: cs-etm: Move mapping of Trace ID and cpu
 into helper function
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20221101163103.17921-1-mike.leach@linaro.org>
 <20221101163103.17921-10-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20221101163103.17921-10-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 01/11/2022 16:30, Mike Leach wrote:
> The information to associate Trace ID and CPU will be changing.
> 
> Drivers will start outputting this as a hardware ID packet in the data
> file which if present will be used in preference to the AUXINFO values.
> 
> To prepare for this we provide a helper functions to do the individual ID
> mapping, and one to extract the IDs from the completed metadata blocks.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: James Clark <james.clark@arm.com>
> ---

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

