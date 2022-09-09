Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1363DECAAA1
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Sep 2022 13:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiIINrG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 9 Sep 2022 09:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiIINqx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Sep 2022 09:46:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899A2142D80;
        Fri,  9 Sep 2022 06:46:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9654B8234C;
        Fri,  9 Sep 2022 13:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6C1C433D7;
        Fri,  9 Sep 2022 13:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662731163;
        bh=trwxe4IAvNyEME56RQVerBqHxD5EQM85KO+x9pEr+BE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UbvrhDDm6UwismMwQg8S08Z6FLJv+446HAmX9WTTCLq9kcBjjT0BkFp5fm/FZ6EE6
         L/HzrOfoutOjiQ4HKFvWKWvaAMhkB/uEsREn1Ph21qlMb6XyccexqskGQ3YG5/yGId
         UeX1BrddAILgMBPEBnWgdfM22bGcdVuicmzodMyJgfsw1pF5WDhm+fXJAlPPLqSRc3
         OEfcNi8sD640juil+rCcWkXea7v1AkpLPDn6PeGauphyu3xvq04Op+rWRT/9PDf4PL
         o1PKlGdEzCjWixgTZHshwyexCRwzC0cxdty9GfR8Nqi7mhLp+UJkW3zVvhRwXR1PO+
         8Vdndh2TpOTSw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8F07B404A1; Fri,  9 Sep 2022 10:46:00 -0300 (-03)
Date:   Fri, 9 Sep 2022 10:46:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, atrajeev@linux.vnet.ibm.com,
        eranian@google.com
Subject: Re: [PATCH 2/2] perf tools: remove perf_pmu_lex declaration
Message-ID: <YxtDmJWVx05Pmwwl@kernel.org>
References: <20220909044542.1087870-1-cuigaosheng1@huawei.com>
 <20220909044542.1087870-3-cuigaosheng1@huawei.com>
 <50fba997-d8c1-257b-fd11-db2bb1e53f70@arm.com>
 <YxtDGLZwi2Cu2U+p@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxtDGLZwi2Cu2U+p@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Sep 09, 2022 at 10:43:52AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Sep 09, 2022 at 11:29:43AM +0100, James Clark escreveu:
> > 
> > 
> > On 09/09/2022 05:45, Gaosheng Cui wrote:
> > > perf_pmu_lex has been removed since
> > > commit 65f3e56e0c81 ("perf tools: Remove auto-generated bison/flex files"),
> > > so remove it.
> > 
> > Not 100% sure if that is the right commit to reference because it didn't
> > touch pmu.y.
> 
> Yeah, indeed, unsure if at that time the declaration was needed.
>  
> > perf_pmu_lex is still used and there are plenty of references to it, but
> > maybe the extern declaration isn't needed anymore because it still
> > builds for me with this change.
> 
> Ditto here, I'll remove the reference and rewrite the cset log a bit.

I left it as:

perf pmu: Remove perf_pmu_lex() needless declaration

It builds without it, perhaps with some older combination of flex/bison
we needed this, clean it up a bit removing this.
