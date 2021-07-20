Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D0DC07E9B
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Jul 2021 05:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76236113C
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Jul 2021 05:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbhGTFQQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 20 Jul 2021 01:16:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:7710 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232431AbhGTFQP (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Jul 2021 01:16:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="211240200"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="211240200"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 22:56:54 -0700
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="500513712"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.147]) ([10.238.4.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 22:56:51 -0700
Subject: Re: [bug report] Patch "perf tools: Fix pattern matching for same
 substring in different pmu type" broken
To:     John Garry <john.garry@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        "liuqi (BA)" <liuqi115@huawei.com>,
        Andi Kleen <ak@linux.intel.com>, "Jin, Yao" <yao.jin@intel.com>
References: <44e25825-5f23-c641-9f1c-72268d895f75@huawei.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <1522c39e-5658-d030-2e1e-f6e5d849d29b@linux.intel.com>
Date:   Tue, 20 Jul 2021 13:56:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <44e25825-5f23-c641-9f1c-72268d895f75@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi John, Hi Arnaldo,

On 7/19/2021 10:13 PM, John Garry wrote:
> Hi guys,
> 
> The named patch has broken PMU alias matching on my arm64 system.
> 
> Specifically it is broken for when multiple tokens are used in the alias. For example, alias 
> "hisi_sccl,l3c" would previously match for PMU "hisi_sccl3_l3c7", but that no longer works.
> 
> In my example, in looking at the code, the callchain pmu_uncore_alias_match("hisi_sccl,l3c", 
> "hisi_sccl3_l3c7") -> per_pmu__valid_suffix("hisi_sccl3_l3c7", "hisi_sccl") fails in the following 
> check:
> 
> static bool perf_pmu__valid_suffix(char *pmu_name, char *tok)
> {
>      char *p;
>      ...
>      p = pmu_name + strlen(tok);
>      ...
>      if (*p != '_') //here
>          return false;
> }
> 
> This check assumes the first token must be followed by a '_', but it is possibly a numeric.
> 

It looks that the PMU alias format on arm64 has big difference than the format on x86. My new idea 
is we create a x86 specific perf_pmu__valid_suffix, and for other arch, the weak function always 
returns true. That will not change original behavior.

What do you think?

> Please let me know how this should work. Previously it would match on the tokens, ignoring numerics 
> and '_'.
> 
> As an aside, I'll look at why our testcases don't cover this scenario and look to add a test if 
> necessary.
> 
> Thanks,
> john
> 
> Ps, please cc linux-perf-users@vger.kernel.org as in the MAINTAINERS file in future, as not all 
> subscribe to the open kernel list (and so cannot easily reply directly).
> 

Sorry about that! I will remember that, cc linux-perf-users@vger.kernel.org in next patch.

Thanks
Jin Yao
