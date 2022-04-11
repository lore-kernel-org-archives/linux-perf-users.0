Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBD4C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Apr 2022 14:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343732AbiDKOiV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Apr 2022 10:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345751AbiDKOiT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Apr 2022 10:38:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0F082BDD;
        Mon, 11 Apr 2022 07:36:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C4761570;
        Mon, 11 Apr 2022 07:36:02 -0700 (PDT)
Received: from [10.1.30.132] (e127744.cambridge.arm.com [10.1.30.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BBF43F73B;
        Mon, 11 Apr 2022 07:35:58 -0700 (PDT)
Subject: Re: [PATCH v5 3/5] perf tools: sync addition of PERF_MEM_SNOOPX_PEER
From:   German Gomez <german.gomez@arm.com>
To:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, leo.yan@linaro.org,
        acme@kernel.org
Cc:     benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
References: <20220408195344.32764-1-alisaidi@amazon.com>
 <20220408195344.32764-4-alisaidi@amazon.com>
 <39448754-adf5-f1ba-25e7-8ee3d76f0159@arm.com>
Message-ID: <47ec29fe-75ea-62ef-447b-1164569616de@arm.com>
Date:   Mon, 11 Apr 2022 15:35:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <39448754-adf5-f1ba-25e7-8ee3d76f0159@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 11/04/2022 11:26, German Gomez wrote:
> On 08/04/2022 20:53, Ali Saidi wrote:
>> Add a flag to the perf mem data struct to signal that a request caused a
>> cache-to-cache transfer of a line from a peer of the requestor and
>> wasn't sourced from a lower cache level.  The line being moved from one
>> peer cache to another has latency and performance implications. On Arm64
>> Neoverse systems the data source can indicate a cache-to-cache transfer
>> but not if the line is dirty or clean, so instead of overloading HITM
>> define a new flag that indicates this type of transfer.
> I think it's fine to merge this and the previous commit rather than have
> two commits with the same msg.
>

I take it back. It has been pointed out to me that having the separation
is normal/ok. So my comment doesn't apply.
