Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC4DC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Jun 2022 10:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbiFIKC4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Jun 2022 06:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiFIKCz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Jun 2022 06:02:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C77BF6F;
        Thu,  9 Jun 2022 03:02:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A445561D18;
        Thu,  9 Jun 2022 10:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C715FC34114;
        Thu,  9 Jun 2022 10:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654768974;
        bh=fy3sOySJYMqPfYsXKFz0lzwOIVOW00fot8ATyI+aFKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d7NAOLOMyNEMKzhUAG39/2KJRmzAenVdUfRcoNkvJLwRmDgK0oSRozlHKQKJVxLfH
         BjxbJ1/nI0+tTnmwNFKk1BN4ghei6IQ9HYFL5zIiPeB5bCOR6Zabd3ty0JFRSvsKxs
         AHsyhvhhhBY2IjQqc3wgeTWxVAtvDK6ibpElPPIfJb4lbH8GRNjqwaCYmiO9v9dfYc
         s5vJSAZ89CQTmo4WqSSDdfCzXXAPffcS9YjDf11xeRiQpyVg7KLHqD7rqZQds8oVga
         olqTGldbPuyIhpPSVUlnGMFD5KRNXkd4916syxyeGO0cr75fU1UGVf49uL/J3OoAOm
         csoBUD6dQxBOA==
Date:   Thu, 9 Jun 2022 11:02:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
Cc:     mark.rutland@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5] arm64: perf: Make exporting of pmu events configurable
Message-ID: <20220609100247.GA2187@willie-the-truck>
References: <1653306574-20946-1-git-send-email-quic_c_spathi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653306574-20946-1-git-send-email-quic_c_spathi@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, May 23, 2022 at 05:19:34PM +0530, Srinivasarao Pathipati wrote:
> The PMU export bit (PMCR_EL0.X) is getting reset during pmu reset,
> Make is configurable using sysctls to enable/disable at runtime.
> It can also be enabled at early bootup with kernel arguments.
> 
> Signed-off-by: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
> ---
> Changes since V4:
> 	- Registering sysctls dynamically for only arm64 as suggested by Will
> 	- Not removed the code to configure with kernel parameters 
> 	  as the sysctl's kernel parameter(sysctl.kernel.export_pmu_events)
> 	  is not working at early bootup. pmu_reset() getting called before 
> 	  sysctl's kernel parameter is set.

Why do you need this during early bootup? Perf won't program any events
until much later and if somebody else is configuring the PMU before
entering Linux then they can also set that X bit in the PMCR.

Will
