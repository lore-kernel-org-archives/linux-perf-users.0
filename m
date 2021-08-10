Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA76CC4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 00:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F2DC61004
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 00:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbhHJAhJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 20:37:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:31820 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233500AbhHJAhJ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 20:37:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="214540545"
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="214540545"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 17:36:48 -0700
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="525721020"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.147]) ([10.238.4.147])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 17:36:43 -0700
Subject: Re: [PATCH v4 0/3] perf tool: Enable cpu list for hybrid
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20210723063433.7318-1-yao.jin@linux.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <2a179676-05af-8e4c-d7e1-210076eb3b08@linux.intel.com>
Date:   Tue, 10 Aug 2021 08:36:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210723063433.7318-1-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Jiri,

Any comments for v4 series?

Thanks
Jin Yao

On 7/23/2021 2:34 PM, Jin Yao wrote:
> The perf-record and perf-stat have supported the option '-C/--cpus'
> to count or collect only on the list of CPUs provided. This option
> needs to be supported for hybrid as well.
> 
> v4:
> ---
> Rename evlist__use_cpu_list to evlist__fix_hybrid_cpus
> Add comments to evlist__fix_hybrid_cpus.
> 
> v3:
> ---
> Rebase to latest perf/core branch.
> 
> v2:
> ---
> Automatically map to hybrid pmu.
> 
> For example,
> 
> If cpu0-7 are 'cpu_core' and cpu9-11 are 'cpu_atom',
> 
>    # perf stat -e cycles -C0,11 -- sleep 1
>    WARNING: use 0 in 'cpu_core' for 'cycles', skip other cpus in list.
>    WARNING: use 11 in 'cpu_atom' for 'cycles', skip other cpus in list.
> 
>     Performance counter stats for 'CPU(s) 0,11':
> 
>             1,914,704      cpu_core/cycles/
>             2,036,983      cpu_atom/cycles/
> 
>           1.005815641 seconds time elapsed
> 
> It automatically selects cpu0 for cpu_core/cycles/, selects cpu11 for
> cpu_atom/cycles/, also with some warnings output.
> 
> Jin Yao (3):
>    libperf: Add perf_cpu_map__default_new()
>    perf tools: Create hybrid flag in target
>    perf tools: Enable on a list of CPUs for hybrid
> 
>   tools/lib/perf/cpumap.c              |  5 ++
>   tools/lib/perf/include/perf/cpumap.h |  1 +
>   tools/perf/builtin-record.c          |  7 +++
>   tools/perf/builtin-stat.c            |  6 +++
>   tools/perf/util/evlist-hybrid.c      | 73 ++++++++++++++++++++++++++++
>   tools/perf/util/evlist-hybrid.h      |  1 +
>   tools/perf/util/evlist.c             |  3 +-
>   tools/perf/util/pmu.c                | 35 +++++++++++++
>   tools/perf/util/pmu.h                |  4 ++
>   tools/perf/util/target.h             |  1 +
>   10 files changed, 135 insertions(+), 1 deletion(-)
> 
