Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6E8C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 May 2022 13:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbiEWNRX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 May 2022 09:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbiEWNRV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 May 2022 09:17:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7DA2AC6E;
        Mon, 23 May 2022 06:17:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D9F2B810A1;
        Mon, 23 May 2022 13:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCDAC385A9;
        Mon, 23 May 2022 13:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653311836;
        bh=KFEHU236y6VqkSkQWCNV3d0BLyzEIo25bCle6ZOpgPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XHBup+s7RC6b9YY60S0RMxtlvYdme3pMTEU93aiSwpECTlsd8nZa0WdX1+eNTmPH0
         V5Hxk/AJV1xaf/n22Q3wQZNMDZl51Tow7PH52BC3T5T0qEQ+aZssVqJxzKJGRiDa0m
         YGu4p5dTspfEc/QT+eASltxkrOSn28yiadl5qU3vFOWprzAWk0rwHZ3VrsN1iYptqn
         u9YMjFqR6F4bM2z6U3bHEDGeSh97xekMwwyykjVe5CUJSHQSxUFF3RLcqFeZD4Y1vd
         nx2ftEhZQcnCbdZQ3gflxbxMKOnHr+Ot6gyttCgMFdqHrPJQnRn6CJ0+Y4YICHcdAP
         sUSYMWp1pJznA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2E69A400B1; Mon, 23 May 2022 10:17:14 -0300 (-03)
Date:   Mon, 23 May 2022 10:17:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Nick Forrington <nick.forrington@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] perf vendors events arm64: Update Cortex A57/A72
Message-ID: <YouJWoJ+u1bB7WFp@kernel.org>
References: <20220517135805.313184-1-nick.forrington@arm.com>
 <20220517135805.313184-2-nick.forrington@arm.com>
 <1afa1215-012d-1fad-132c-d2b5db241b3a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1afa1215-012d-1fad-132c-d2b5db241b3a@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, May 20, 2022 at 05:16:29PM +0100, John Garry escreveu:
> On 17/05/2022 14:58, Nick Forrington wrote:
> > Categorise and add missing PMU events for Cortex-A57/A72, based on:
> > https://github.com/ARM-software/data/blob/master/pmu/cortex-a57.json
> > https://github.com/ARM-software/data/blob/master/pmu/cortex-a72.json
> > 
> > These contain the same events, and are based on the Arm Technical
> > Reference Manuals for Cortex-A57 and Cortex-A72.
> > 
> > Signed-off-by: Nick Forrington<nick.forrington@arm.com>
> > ---
> 
> Thanks
> 
> Reviewed-by: John Garry <john.garry@huawei.com>


Thanks, applied.

- Arnaldo

