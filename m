Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF69EB8FD8
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Sep 2023 14:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjIFOZz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Sep 2023 10:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjIFOZz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Sep 2023 10:25:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E04E4C
        for <linux-perf-users@vger.kernel.org>; Wed,  6 Sep 2023 07:25:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F7BC433C7;
        Wed,  6 Sep 2023 14:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694010349;
        bh=nVDm2AyYvaQbo3PRlV0G+GBs6l+8eMaPhB03AuB8jZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bh0xq67h0mgqBtftvVvet5zgYBcjsoif2YEUIDBqEnntIB72Ju/43RCNtpmpg1Wr9
         cvma8uNoI0qBMUv42+Smi41MKF2TARtkR6DQUgE0S+zb/DtGg73CrxI+LobKLMPn8Y
         hb4pjA91yvLVDx0dlFdzNBPsJif8rHp9ZDyHDIwcWTVbb7oUQaEednR2PMrykA1g9I
         PRRRwE/w+kxK3K3O0xGFGIch0HTWHf47UtGj9XWGtkJSG2hi8eQMvuciXjCZVAUTtq
         puLVtWm7fdvG8Bf4ii6YaCMO+utSq44+sb2Vc+AfqSkNDaDrrGbT0MrsWU+U47PuWd
         UZmrF8aNYlKBw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3AC39403F4; Wed,  6 Sep 2023 11:25:46 -0300 (-03)
Date:   Wed, 6 Sep 2023 11:25:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        disgoel@linux.ibm.com, linux-perf-users@vger.kernel.org,
        namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/3] perf vendor events: Update JSON/events for
 power10 platform
Message-ID: <ZPiL6u+cJAkf6WoX@kernel.org>
References: <20230905114039.176645-1-kjain@linux.ibm.com>
 <20230905114039.176645-2-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905114039.176645-2-kjain@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Sep 05, 2023 at 05:10:38PM +0530, Kajol Jain escreveu:
> Update JSON/Events list with additional data-source events
> for power10 platform.

I changed the cset title to:

"perf vendor events power10: Add extra data-source events"

As it was exactly the same as the first, so when someone does a 'git log
--oneline' it looks like a straight dup.

Please try to provide descriptive subjects.

- Arnaldo
 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  .../arch/powerpc/power10/datasource.json      | 505 ++++++++++++++++++
>  1 file changed, 505 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/arch/powerpc/power10/datasource.json b/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
> index 12cfb9785433..6b0356f2d301 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
> @@ -1278,5 +1278,510 @@
>      "EventCode": "0x0A4240000000C142",
>      "EventName": "PM_MRK_DATA_FROM_NON_REGENT_L2L3_MOD",
>      "BriefDescription": "The processor's L1 data cache was reloaded with a line in the M (exclusive) state from another core's L2 or L3 on the same chip in a different regent due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0A4240000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_NON_REGENT_L2L3_MOD_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a line in the M (exclusive) state from another core's L2 or L3 on the same chip in a different regent due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0A0300000000C142",
> +    "EventName": "PM_MRK_INST_FROM_NON_REGENT_L2L3",
> +    "BriefDescription": "The processor's instruction cache was reloaded from another core's L2 or L3 on the same chip in a different regent due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0A0340000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_NON_REGENT_L2L3",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from another core's L2 or L3 on the same chip in a different regent due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0A0300000010C142",
> +    "EventName": "PM_MRK_INST_FROM_NON_REGENT_L2L3_ALL",
> +    "BriefDescription": "The processor's instruction cache was reloaded from another core's L2 or L3 on the same chip in a different regent due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0A0340000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_NON_REGENT_L2L3_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from another core's L2 or L3 on the same chip in a different regent due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x094100000000C142",
> +    "EventName": "PM_MRK_INST_FROM_LMEM",
> +    "BriefDescription": "The processor's instruction cache was reloaded from the local chip's memory due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x094040000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_LMEM",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from the local chip's memory due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x094100000010C142",
> +    "EventName": "PM_MRK_INST_FROM_LMEM_ALL",
> +    "BriefDescription": "The processor's instruction cache was reloaded from the local chip's memory due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x094040000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_LMEM_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from the local chip's memory due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x098040000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_L_OC_CACHE",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from the local chip's OpenCAPI cache due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x098040000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_L_OC_CACHE_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from the local chip's OpenCAPI cache due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x09C040000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_L_OC_MEM",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from the local chip's OpenCAPI memory due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x09C040000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_L_OC_MEM_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from the local chip's OpenCAPI memory due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x098100000000C142",
> +    "EventName": "PM_MRK_INST_FROM_L_OC_ANY",
> +    "BriefDescription": "The processor's instruction cache was reloaded from the local chip's OpenCAPI cache or memory due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x098140000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_L_OC_ANY",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from the local chip's OpenCAPI cache or memory due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x098100000010C142",
> +    "EventName": "PM_MRK_INST_FROM_L_OC_ANY_ALL",
> +    "BriefDescription": "The processor's instruction cache was reloaded from the local chip's OpenCAPI cache or memory due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x098140000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_L_OC_ANY_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from the local chip's OpenCAPI cache or memory due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C0040000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_RL2_SHR",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a valid line that was not in the M (exclusive) state from another core's L2 from a remote chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C0040000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_RL2_SHR_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a valid line that was not in the M (exclusive) state from another core's L2 from a remote chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C4040000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_RL2_MOD",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a line in the M (exclusive) state from another core's L2 from a remote chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C4040000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_RL2_MOD_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a line in the M (exclusive) state from another core's L2 from a remote chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C0100000000C142",
> +    "EventName": "PM_MRK_INST_FROM_RL2",
> +    "BriefDescription": "The processor's instruction cache was reloaded from another core's L2 from a remote chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C0140000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_RL2",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from another core's L2 from a remote chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C0100000010C142",
> +    "EventName": "PM_MRK_INST_FROM_RL2_ALL",
> +    "BriefDescription": "The processor's instruction cache was reloaded from another core's L2 from a remote chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C0140000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_RL2_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from another core's L2 from a remote chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C8040000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_RL3_SHR",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a valid line that was not in the M (exclusive) state from another core's L3 from a remote chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C8040000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_RL3_SHR_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a valid line that was not in the M (exclusive) state from another core's L3 from a remote chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0CC040000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_RL3_MOD",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a line in the M (exclusive) state from another core's L3 from a remote chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0CC040000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_RL3_MOD_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a line in the M (exclusive) state from another core's L3 from a remote chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C8100000000C142",
> +    "EventName": "PM_MRK_INST_FROM_RL3",
> +    "BriefDescription": "The processor's instruction cache was reloaded from another core's L3 from a remote chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C8140000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_RL3",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from another core's L3 from a remote chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C8100000010C142",
> +    "EventName": "PM_MRK_INST_FROM_RL3_ALL",
> +    "BriefDescription": "The processor's instruction cache was reloaded from another core's L3 from a remote chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C8140000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_RL3_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from another core's L3 from a remote chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C0240000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_RL2L3_SHR",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a valid line that was not in the M (exclusive) state from another core's L2 or L3 from a remote chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C0240000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_RL2L3_SHR_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a valid line that was not in the M (exclusive) state from another core's L2 or L3 from a remote chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C4240000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_RL2L3_MOD",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a line in the M (exclusive) state from another core's L2 or L3 from a remote chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C4240000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_RL2L3_MOD_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a line in the M (exclusive) state from another core's L2 or L3 from a remote chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C0300000000C142",
> +    "EventName": "PM_MRK_INST_FROM_RL2L3",
> +    "BriefDescription": "The processor's instruction cache was reloaded from another core's L2 or L3 from a remote chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C0340000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_RL2L3",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from another core's L2 or L3 from a remote chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C0300000010C142",
> +    "EventName": "PM_MRK_INST_FROM_RL2L3_ALL",
> +    "BriefDescription": "The processor's instruction cache was reloaded from another core's L2 or L3 from a remote chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C0340000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_RL2L3_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from another core's L2 or L3 from a remote chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0D4100000000C142",
> +    "EventName": "PM_MRK_INST_FROM_RMEM",
> +    "BriefDescription": "The processor's instruction cache was reloaded from remote memory (MC slow) due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0D4040000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_RMEM",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from remote memory (MC slow) due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0D4100000010C142",
> +    "EventName": "PM_MRK_INST_FROM_RMEM_ALL",
> +    "BriefDescription": "The processor's instruction cache was reloaded from remote memory (MC slow) due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0D4040000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_RMEM_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from remote memory (MC slow) due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0D8040000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_R_OC_CACHE",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from a remote chip's OpenCAPI cache due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0D8040000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_R_OC_CACHE_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from a remote chip's OpenCAPI cache due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0DC040000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_R_OC_MEM",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from a remote chip's OpenCAPI memory due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0DC040000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_R_OC_MEM_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from a remote chip's OpenCAPI memory due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0D8100000000C142",
> +    "EventName": "PM_MRK_INST_FROM_R_OC_ANY",
> +    "BriefDescription": "The processor's instruction cache was reloaded from a remote chip's OpenCAPI cache or memory due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0D8140000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_R_OC_ANY",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from a remote chip's OpenCAPI cache or memory due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0D8100000010C142",
> +    "EventName": "PM_MRK_INST_FROM_R_OC_ANY_ALL",
> +    "BriefDescription": "The processor's instruction cache was reloaded from a remote chip's OpenCAPI cache or memory due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0D8140000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_R_OC_ANY_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from a remote chip's OpenCAPI cache or memory due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0E0040000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_DL2_SHR",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a valid line that was not in the M (exclusive) state from another core's L2 from a distant chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0E0040000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_DL2_SHR_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a valid line that was not in the M (exclusive) state from another core's L2 from a distant chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0E4040000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_DL2_MOD",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a line in the M (exclusive) state from another core's L2 from a distant chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0E4040000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_DL2_MOD_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a line in the M (exclusive) state from another core's L2 from a distant chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0E0100000000C142",
> +    "EventName": "PM_MRK_INST_FROM_DL2",
> +    "BriefDescription": "The processor's instruction cache was reloaded from another core's L2 from a distant chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0E0140000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_DL2",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from another core's L2 from a distant chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0E0100000010C142",
> +    "EventName": "PM_MRK_INST_FROM_DL2_ALL",
> +    "BriefDescription": "The processor's instruction cache was reloaded from another core's L2 from a distant chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0E0140000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_DL2_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from another core's L2 from a distant chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0E8040000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_DL3_SHR",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a valid line that was not in the M (exclusive) state from another core's L3 from a distant chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0E8040000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_DL3_SHR_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a valid line that was not in the M (exclusive) state from another core's L3 from a distant chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0EC040000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_DL3_MOD",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a line in the M (exclusive) state from another core's L3 from a distant chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0EC040000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_DL3_MOD_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a line in the M (exclusive) state from another core's L3 from a distant chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0E8100000000C142",
> +    "EventName": "PM_MRK_INST_FROM_DL3",
> +    "BriefDescription": "The processor's instruction cache was reloaded from another core's L3 from a distant chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0E8140000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_DL3",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from another core's L3 from a distant chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0E8100000010C142",
> +    "EventName": "PM_MRK_INST_FROM_DL3_ALL",
> +    "BriefDescription": "The processor's instruction cache was reloaded from another core's L3 from a distant chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0E8140000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_DL3_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from another core's L3 from a distant chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0E0240000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_DL2L3_SHR",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a valid line that was not in the M (exclusive) state from another core's L2 or L3 from a distant chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0E0240000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_DL2L3_SHR_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a valid line that was not in the M (exclusive) state from another core's L2 or L3 from a distant chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0E4240000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_DL2L3_MOD",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a line in the M (exclusive) state from another core's L2 or L3 from a distant chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0E4240000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_DL2L3_MOD_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded with a line in the M (exclusive) state from another core's L2 or L3 from a distant chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0E0300000000C142",
> +    "EventName": "PM_MRK_INST_FROM_DL2L3",
> +    "BriefDescription": "The processor's instruction cache was reloaded from another core's L2 or L3 from a distant chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0E0340000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_DL2L3",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from another core's L2 or L3 from a distant chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0E0300000010C142",
> +    "EventName": "PM_MRK_INST_FROM_DL2L3_ALL",
> +    "BriefDescription": "The processor's instruction cache was reloaded from another core's L2 or L3 from a distant chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0E0340000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_DL2L3_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from another core's L2 or L3 from a distant chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0F4100000000C142",
> +    "EventName": "PM_MRK_INST_FROM_DMEM",
> +    "BriefDescription": "The processor's instruction cache was reloaded from distant memory (MC slow) due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0F4040000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_DMEM",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from distant memory (MC slow) due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0F4100000010C142",
> +    "EventName": "PM_MRK_INST_FROM_DMEM_ALL",
> +    "BriefDescription": "The processor's instruction cache was reloaded from distant memory (MC slow) due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0F4040000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_DMEM_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from distant memory (MC slow) due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0F8040000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_D_OC_CACHE",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from a distant chip's OpenCAPI cache due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0F8040000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_D_OC_CACHE_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from a distant chip's OpenCAPI cache due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0FC040000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_D_OC_MEM",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from a distant chip's OpenCAPI memory due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0FC040000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_D_OC_MEM_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from a distant chip's OpenCAPI memory due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0F8100000000C142",
> +    "EventName": "PM_MRK_INST_FROM_D_OC_ANY",
> +    "BriefDescription": "The processor's instruction cache was reloaded from a distant chip's OpenCAPI cache or memory due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0F8140000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_D_OC_ANY",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from a distant chip's OpenCAPI cache or memory due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0F8100000010C142",
> +    "EventName": "PM_MRK_INST_FROM_D_OC_ANY_ALL",
> +    "BriefDescription": "The processor's instruction cache was reloaded from a distant chip's OpenCAPI cache or memory due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0F8140000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_D_OC_ANY_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from a distant chip's OpenCAPI cache or memory due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x080B00000000C142",
> +    "EventName": "PM_MRK_INST_FROM_ONCHIP_CACHE",
> +    "BriefDescription": "The processor's instruction cache was reloaded from another core's L2 or L3 from the same chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x080B40000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_ONCHIP_CACHE",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from another core's L2 or L3 from the same chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x080B00000010C142",
> +    "EventName": "PM_MRK_INST_FROM_ONCHIP_CACHE_ALL",
> +    "BriefDescription": "The processor's instruction cache was reloaded from another core's L2 or L3 from the same chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x080B40000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_ONCHIP_CACHE_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from another core's L2 or L3 from the same chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C0B00000000C142",
> +    "EventName": "PM_MRK_INST_FROM_OFFCHIP_CACHE",
> +    "BriefDescription": "The processor's instruction cache was reloaded from another core's L2 or L3 from a different chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C0B40000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_OFFCHIP_CACHE",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from another core's L2 or L3 from a different chip due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C0B00000010C142",
> +    "EventName": "PM_MRK_INST_FROM_OFFCHIP_CACHE_ALL",
> +    "BriefDescription": "The processor's instruction cache was reloaded from another core's L2 or L3 from a different chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x0C0B40000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_OFFCHIP_CACHE_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from another core's L2 or L3 from a different chip due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x095900000000C142",
> +    "EventName": "PM_MRK_INST_FROM_ANY_MEMORY",
> +    "BriefDescription": "The processor's instruction cache was reloaded from any chip's memory (MC slow) due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x095840000000C142",
> +    "EventName": "PM_MRK_DATA_FROM_ANY_MEMORY",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from any chip's memory (MC slow) due to a demand miss for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x095900000010C142",
> +    "EventName": "PM_MRK_INST_FROM_ANY_MEMORY_ALL",
> +    "BriefDescription": "The processor's instruction cache was reloaded from any chip's memory (MC slow) due to a demand miss or prefetch reload for a marked instruction."
> +  },
> +  {
> +    "EventCode": "0x095840000020C142",
> +    "EventName": "PM_MRK_DATA_FROM_ANY_MEMORY_ALL",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from any chip's memory (MC slow) due to a demand miss or prefetch reload for a marked instruction."
>    }
>  ]
> -- 
> 2.39.3
> 

-- 

- Arnaldo
