Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86243ECAAA3
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Aug 2022 14:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiHZO2Z (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Aug 2022 10:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbiHZO2Y (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Aug 2022 10:28:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE94A50F1
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661524102; x=1693060102;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Cm0451/mKshQSOfDSVXa4prysq/+RDrl1m0al2oPBbo=;
  b=chuVIUlie+f8N3x/hk6b96dJhqHanntc6rmJWlMNvRiCYlBBzd8rvD37
   JAlnDebi5TRnU+n969pSngafCpflyARYnp8LFMfYuUZo+I1WeUVsaDhx2
   lFc5wQWJNPobflw/mG8HqvqopO0vviCRYmbbarHz2jIKg3Dw+O9qWyCPC
   su1ipKX09r6w3PCyFnz2bQ7j/BhzPeGylR7YHmsYNBiRBbMnMTeLVEVpI
   uvV9uklgWdR0b1fBxiruEa9grv3GUY74bm9hy8ofol1NIyVld8Gb+ilG6
   TcPnLMwlML9f3vQs7TqFdn+KSY39XZ7BaFmgQ6QIUGsAEmuU4xSFPkNCZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="295295258"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="295295258"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 07:28:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="786397358"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 26 Aug 2022 07:28:22 -0700
Received: from [10.252.208.172] (kliang2-mobl1.ccr.corp.intel.com [10.252.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 237B1580ABD;
        Fri, 26 Aug 2022 07:28:22 -0700 (PDT)
Message-ID: <9b3f785e-1370-cf23-2ba4-2b0163185b2e@linux.intel.com>
Date:   Fri, 26 Aug 2022 10:28:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: Cannot use address filtering with user register sampling
Content-Language: en-US
To:     Hongtao Yu <Hongtao.Yu@outlook.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
References: <MW4PR18MB503443512239B3F40267004C8A729@MW4PR18MB5034.namprd18.prod.outlook.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <MW4PR18MB503443512239B3F40267004C8A729@MW4PR18MB5034.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 2022-08-24 8:14 p.m., Hongtao Yu wrote:
> Hi,
>  
> I was exploring address filtering together with user reg sampling on Intel Skylake hardware. The idea behind it is to make reg sampling more selectively. Unfortunately, I hit ` This CPU does not support address filtering` error. The command I ran is:
>  
>    perf record -e br_inst_retired.all_branches:uppp --user-regs=DI --filter 'filter * @/bin/ls'  ls
>  
>    This CPU does not support address filtering
>  
> IIUC, the br_inst_retired event is also hardware-based, similarly with the intel_pt event. But the latter works with address filtering while the former doesn’t. What is rational behind this?

The --filter only supports the tracepoint event(s) or or a hardware
trace, e.g., Intel PT. They trace and dump each single instruction. You
can use the --filter option to choose and only retrieve the
data/instructions you are interested.

Perf record -e br_inst_retired.all_branches event does sampling. I would
recommend you to use "-c" option to control the event period.(The number
of events that triggers a single sample.) For example, -c1000 means 1000
events occur then the HW dumps a sample (only for the 1000th event).
e.g.,
    perf record -e br_inst_retired.all_branches:uppp --user-regs=DI
-c1000 ls

Then you can use the post-processing tools, e.g., perf report or perf
script, to filter and output the results.
e.g.,
   perf script --dsos ls -F+uregs


Thanks,
Kan
