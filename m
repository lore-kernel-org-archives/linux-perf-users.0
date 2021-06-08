Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8313C47082
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Jun 2021 19:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFD8F6135D
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Jun 2021 19:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbhFHTwt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 15:52:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:61209 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233476AbhFHTwt (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Jun 2021 15:52:49 -0400
IronPort-SDR: spwDKhuSTlOki6sI+XMum3mkMxlU/NWJjurdNh3bC8+0eUKvyJ+S/45Nv0pGxr7fmKr5/qcJsd
 MnzCC2Gk2wFg==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="192247120"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="192247120"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 12:50:55 -0700
IronPort-SDR: K+Fbsgp6zkcbWP70pKaHi3PIckhajlqgLhqWw8vp4JyGHat0lUATKhYwVUqDejqZehgBL3hNFB
 uCdH0ZtePuOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="402092105"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 08 Jun 2021 12:50:54 -0700
Received: from [10.209.71.109] (kliang2-MOBL.ccr.corp.intel.com [10.209.71.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 48AF75808B1;
        Tue,  8 Jun 2021 12:50:53 -0700 (PDT)
Subject: Re: [PATCH 1/4] perf/x86/intel/uncore: Constify intel_uncore_ops
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Antonov <alexander.antonov@linux.intel.com>
References: <20210605155653.21850-1-rikard.falkeborn@gmail.com>
 <20210605155653.21850-2-rikard.falkeborn@gmail.com>
 <77212f9f-1914-afd2-99c1-a5ced5b7c265@linux.intel.com>
 <YL/CQIA0vk1CiQcf@rikard>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <c823311c-7685-17fa-aa62-25746d768474@linux.intel.com>
Date:   Tue, 8 Jun 2021 15:50:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YL/CQIA0vk1CiQcf@rikard>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 6/8/2021 3:17 PM, Rikard Falkeborn wrote:
> On Mon, Jun 07, 2021 at 03:09:11PM -0400, Liang, Kan wrote:
>>
>> On 6/5/2021 11:56 AM, Rikard Falkeborn wrote:
>>> These are not modified, so make them const to allow the compiler to put
>>> them in read-only memory.
>> For most of the cases, yes, but the ops are modified for the TGL/RKL. We may
>> want to create a read-only ops for the TGL/RKL as below, and make both
>> skl_uncore_msr_ops and rkl_uncore_msr_ops const as well.
>>
> Thanks for the feedback.
> 
> Yes, that was the odd one out, the commit message could have been
> clearer. What I meant above was "Constify all intel_uncore_ops that are
> not modified", which was all but skl_uncore_msr_ops. So the patch is
> correct, but in order to also constify skl_uncore_msr_ops, we could do
> as you suggested. Is it worth doing?

Since the patch set changes the intel_uncore_ops *ops to const, I think 
it's better to change them all at once. It will bring confusion if some 
of them are read-only but others can be modified.

> And if so, in a V2 of this patch,
> or as a follow-up patch?

Either is fine for me.

Thanks,
Kan
