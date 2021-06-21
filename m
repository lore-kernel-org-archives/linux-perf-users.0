Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D30C48BE5
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 06:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E17260FEA
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 06:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhFUGRL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Jun 2021 02:17:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:1282 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhFUGRL (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Jun 2021 02:17:11 -0400
IronPort-SDR: WKzPaS9VckEx1W04EKhXITiDxmTG5+T2YqwKbpQAmG0s0ULcC4xEmpDbu7RMh6gQ4t5YkFvoC4
 S4X82kQLn0fA==
X-IronPort-AV: E=McAfee;i="6200,9189,10021"; a="187159662"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="187159662"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2021 23:14:50 -0700
IronPort-SDR: mic3ggS1jowK5/3XUZpgQduQqc3iUE4WCafiAcQbozfPRGVvzpf071B1EVDjnLPTaptoVQleb6
 VSBBRNS0/r0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="405518819"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.79]) ([10.237.72.79])
  by orsmga006.jf.intel.com with ESMTP; 20 Jun 2021 23:14:47 -0700
Subject: Re: [PATCH 0/3] perf intel-pt: Add PEBS-via-PT side-band
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210609142055.32226-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <23211445-d02b-2b6c-a72c-6bf9b412798d@intel.com>
Date:   Mon, 21 Jun 2021 09:15:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210609142055.32226-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 9/06/21 5:20 pm, Adrian Hunter wrote:
> Hi
> 
> PEBS output to Intel Processor Trace was introduced with Atom
> processors based on Tremont.  Currently there is software support
> only for a single PEBS-via-PT event.
> 
> Here is support for multiple PEBS-via-PT events.

Any comments on this patch set?

> 
> The first patch is the kernel change which adds a new event,
> namely PERF_RECORD_AUX_OUTPUT_HW_ID which contains the counter
> index.  That is output when the PEBS-via-PT event is enabled in hardware.
> There is an optimization, to report the index only when it changes
> for the event.  That will work only so long as all PEBS-via-PT
> events are scheduled together, which they are for a recording
> session because they are in a single group.
> 
> Also no attribute bit is used to select the new event, so a new
> kernel is not compatible with older perf tools.  The assumption
> being that PEBS-via-PT is sufficiently esoteric that users will not
> be troubled by this.
> 
> The second patch adds the usual boiler plate to perf tools for
> a new event.
> 
> The third patch adds support for processing the new event by
> perf tool's Intel PT decoder.
> 
> 
> Adrian Hunter (3):
>       perf/x86: Add new event for AUX output counter index
>       perf tools: Add support for PERF_RECORD_AUX_OUTPUT_HW_ID
>       perf intel-pt: Add support for PERF_RECORD_AUX_OUTPUT_HW_ID
> 
>  arch/x86/events/core.c                     |  1 +
>  arch/x86/events/intel/ds.c                 | 16 ++++++
>  include/linux/perf_event.h                 |  2 +
>  include/uapi/linux/perf_event.h            | 15 ++++++
>  kernel/events/core.c                       | 30 +++++++++++
>  tools/include/uapi/linux/perf_event.h      | 15 ++++++
>  tools/lib/perf/include/perf/event.h        |  6 +++
>  tools/perf/Documentation/perf-intel-pt.txt |  7 ++-
>  tools/perf/builtin-inject.c                |  4 +-
>  tools/perf/builtin-record.c                |  2 +-
>  tools/perf/util/event.c                    | 18 +++++++
>  tools/perf/util/event.h                    |  5 ++
>  tools/perf/util/intel-pt.c                 | 85 ++++++++++++++++++++++++++++--
>  tools/perf/util/machine.c                  | 10 ++++
>  tools/perf/util/machine.h                  |  2 +
>  tools/perf/util/session.c                  |  5 ++
>  tools/perf/util/tool.h                     |  1 +
>  17 files changed, 217 insertions(+), 7 deletions(-)
> 
> 
> Regards
> Adrian
> 

