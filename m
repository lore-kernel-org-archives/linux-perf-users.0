Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E22C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 May 2022 09:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiEPJZ4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 May 2022 05:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiEPJZz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 May 2022 05:25:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D78F7212;
        Mon, 16 May 2022 02:25:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 966641063;
        Mon, 16 May 2022 02:25:54 -0700 (PDT)
Received: from [10.57.4.89] (unknown [10.57.4.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4734D3F66F;
        Mon, 16 May 2022 02:25:52 -0700 (PDT)
Message-ID: <3b0e1226-91bd-a470-3d18-9fdd465eca4e@arm.com>
Date:   Mon, 16 May 2022 10:25:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 00/20] perf vendors events arm64: Multiple Arm CPUs
To:     John Garry <john.garry@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20220510104758.64677-1-nick.forrington@arm.com>
 <YnqJwMfi/bcDmN4H@kernel.org>
 <b1081013-2cd9-f223-8125-d7e51d784f90@huawei.com>
 <eec03f0d-d491-511c-d9b0-694c6d527b38@arm.com>
 <1062b28d-9c7b-89fb-d3bf-519f84029b96@huawei.com>
From:   Nick Forrington <nick.forrington@arm.com>
In-Reply-To: <1062b28d-9c7b-89fb-d3bf-519f84029b96@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 12/05/2022 16:52, John Garry wrote:
> Generally this looks ok:
>
> Reviewed-by: John Garry <john.garry@huawei.com>
>
> If you are feeling particularly helpful then you can add support for 
> any events missing to pre-existing core support, like a57-a72.

Thanks John.

I'll submit a separate patch for A57/A72.

Nick

