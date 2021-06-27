Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9991EC48BC2
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 16:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6211561C51
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 16:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhF0QPo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Jun 2021 12:15:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:52163 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229820AbhF0QPo (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Jun 2021 12:15:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="194998132"
X-IronPort-AV: E=Sophos;i="5.83,304,1616482800"; 
   d="scan'208";a="194998132"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 09:13:07 -0700
X-IronPort-AV: E=Sophos;i="5.83,304,1616482800"; 
   d="scan'208";a="624994541"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.138.183]) ([10.212.138.183])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 09:13:06 -0700
Subject: Re: [PATCH V2 00/10] perf script: Add API for filtering via
 dynamically loaded shared object
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210627131818.810-1-adrian.hunter@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <e2a57ee8-6489-40d5-04d0-7d985eba961f@linux.intel.com>
Date:   Sun, 27 Jun 2021 09:13:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210627131818.810-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 6/27/2021 6:18 AM, Adrian Hunter wrote:
> Hi
>   
> In some cases, users want to filter very large amounts of data (e.g. from
> AUX area tracing like Intel PT) looking for something specific. While
> scripting such as Python can be used, Python is 10 to 20 times slower than
> C. So define a C API so that custom filters can be written and loaded.

While I appreciate this for complex cases, in my experience filtering is 
usually just a simple expression. It would be nice to also have a way to 
do this reasonably fast without having to write a custom C file.   Is 
the 10x-20x overhead just the python interpreter, or is it related to 
perf? Maybe we could have some kind of python fast path just for 
filters? Or maybe the alternative would be to have a frontend in perf 
that can automatically generate/compile such a C filter based on a 
simple expression, but I'm not sure if that would be much simpler.

-Andi

