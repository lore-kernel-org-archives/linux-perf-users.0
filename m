Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CA4C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 Oct 2022 14:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiJZODR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbiJZODQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Oct 2022 10:03:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE41E099D
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Oct 2022 07:03:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 885A361F10
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Oct 2022 14:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BE9C433D6;
        Wed, 26 Oct 2022 14:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666792994;
        bh=+OYbymwXVTHjvyIEncJj+Ub6BuMmBJ+TqAfwpTzCG6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BBGu/bMrJfbLF4zDN30qDk1YV8yHnqEgNf0ONFiJkT8e5nZuiP3HbpOqnZOATwayL
         y3PkhHpnl+JaHwusm05BH0ZgVQsiR5YF34Kacu5ErvBtC8SMmr1K855nm3WFoM1P9J
         l3SFolJqOeEcg74pEURUtrBDf7O4MAnrSHFTyEjs/KUst1eXCSX8vCFH1J8ZvABii3
         Vl1xWO9Ydiu+W8I0a7py0KKuJWdbkBgEbVMJxXkjudWFmmahi1q2XnVUhmt9a0/yQm
         S/6Zxx+C3/IcXi49VhTiEwfdOoNhEYszOGk0L+gcjnpAJnSAPckwL3oSpNL+Inj9rr
         krTYvir8uTlAg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 64BF9404BE; Wed, 26 Oct 2022 11:03:12 -0300 (-03)
Date:   Wed, 26 Oct 2022 11:03:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Shang XiaoJing <shangxiaojing@huawei.com>, will@kernel.org,
        james.clark@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, kjain@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/3] perf vendor events arm64: Fix incorrect Hisi
 hip08 L3 metrics
Message-ID: <Y1k+IPn+uvgdyY5c@kernel.org>
References: <20221021105035.10000-1-shangxiaojing@huawei.com>
 <20221021105035.10000-2-shangxiaojing@huawei.com>
 <c84fa985-7c86-880a-a10b-088120fb2b06@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c84fa985-7c86-880a-a10b-088120fb2b06@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Oct 26, 2022 at 10:07:44AM +0100, John Garry escreveu:
> On 21/10/2022 11:50, Shang XiaoJing wrote:
> > Commit 0cc177cfc95d ("perf vendor events arm64: Add Hisi hip08 L3
> > metrics") add L3 metrics of hip08, but some metrics (IF_BP_MISP_BR_RET,
> > IF_BP_MISP_BR_RET, IF_BP_MISP_BR_BL) have incorrect event number due to
> > the mistakes in document, which caused incorrect result. Fix the
> > incorrect metrics.
> > 
> > before:
> > 65,811,214,308	armv8_pmuv3_0/event=0x1014/	# 18.87 push_branch
> > 						# -40.19 other_branch
> > 3,564,316,780	BR_MIS_PRED			# 0.51 indirect_branch
> > 						# 21.81 pop_branch
> > 
> > after:
> > 6,537,146,245	BR_MIS_PRED			# 0.48 indirect_branch
> > 						# 0.47 pop_branch
> > 						# 0.00 push_branch
> > 						# 0.05 other_branch
> > 
> > Fixes: 0cc177cfc95d ("perf vendor events arm64: Add Hisi hip08 L3 metrics")
> > Signed-off-by: Shang XiaoJing<shangxiaojing@huawei.com>
> > Cc: John Garry<john.garry@huawei.com>
> > Acked-by: James Clark<james.clark@arm.com>
> 
> Reviewed-by: John Garry <john.garry@huawei.com>

Applied to perf/urgent.

- Arnaldo
