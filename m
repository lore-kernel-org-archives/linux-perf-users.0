Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287B3C433F5
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 09:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F26AA60E52
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 09:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbhIEJMI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 5 Sep 2021 05:12:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:52572 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhIEJMI (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 5 Sep 2021 05:12:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10097"; a="206980093"
X-IronPort-AV: E=Sophos;i="5.85,269,1624345200"; 
   d="scan'208";a="206980093"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2021 02:11:05 -0700
X-IronPort-AV: E=Sophos;i="5.85,269,1624345200"; 
   d="scan'208";a="535866588"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.249.168.84]) ([10.249.168.84])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2021 02:11:01 -0700
Subject: Re: [PATCH v7 1/2] perf pmu: Add PMU alias support
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, rickyman7@gmail.com,
        john.garry@huawei.com, Kan Liang <kan.liang@linux.intel.com>
References: <20210902065955.1299-1-yao.jin@linux.intel.com>
 <20210902065955.1299-2-yao.jin@linux.intel.com> <YTIJLyL4Ba7wuZqs@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <ce0e8ecd-94fc-886d-665a-744ceff5a129@linux.intel.com>
Date:   Sun, 5 Sep 2021 17:10:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTIJLyL4Ba7wuZqs@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On 9/3/2021 7:38 PM, Arnaldo Carvalho de Melo wrote:
>      Committer notes:
>      
>      Rename 'struct perf_pmu_alias_name' to 'pmu_alias', the 'perf_' prefix
>      should be used for libperf, things inside just tools/perf/ are being
>      moved away from that prefix.
>      
>      Also 'pmu_alias' is shorter and reflects the abstraction.
>      
>      Also don't use 'pmu' as the name for variables for that type, we should
>      use that for the 'struct perf_pmu' variables, avoiding confusion. Use
>      'pmu_alias' for 'struct pmu_alias' variables.

I fully agree your recommended changes. I think Kan will agree too. :) Thanks so much!

Thanks
Jin Yao
