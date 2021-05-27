Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A35C4707F
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 07:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D7E06139A
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 07:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhE0H4K (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 May 2021 03:56:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:47126 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234828AbhE0H4J (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 May 2021 03:56:09 -0400
IronPort-SDR: OaNU4YWfWpBaUcXkjxd4y5UE+SxvWQLisDjy0WfyMIobR5WgbdCPTSUk0l5VGP5mY5QOAyb63Q
 OZXRLFabBq4Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="202683021"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="202683021"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 00:54:35 -0700
IronPort-SDR: aYMgbIo7tJITXQWv98gBDb/96yNeLidVngMYp6u8YJMreIDdTjQ/hYYIU8TcxvQuNbLjjyCprT
 Mm+QKEh7lDzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="480467583"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga002.fm.intel.com with ESMTP; 27 May 2021 00:54:33 -0700
Subject: Re: [PATCH v1 1/2] perf auxtrace: Change to use SMP memory barriers
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210519140319.1673043-1-leo.yan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d1fc3dd3-e79a-4e93-1083-6b08e0cabe59@intel.com>
Date:   Thu, 27 May 2021 10:54:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210519140319.1673043-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 19/05/21 5:03 pm, Leo Yan wrote:
> The AUX ring buffer's head and tail can be accessed from multiple CPUs
> on SMP system, so changes to use SMP memory barriers to replace the
> uniprocessor barriers.

I don't think user space should attempt to be SMP-aware.

For perf tools, on __x86_64__ it looks like smp_rmb() is only a compiler barrier, whereas
rmb() is a "lfence" memory barrier instruction, so this patch does not
seem to do what the commit message says at least for x86.

With regard to the AUX area, we don't know in general how data gets there,
so using memory barriers seems sensible.

> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/auxtrace.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 472c0973b1f1..8bed284ccc82 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -452,7 +452,7 @@ static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
>  	u64 head = READ_ONCE(pc->aux_head);
>  
>  	/* Ensure all reads are done after we read the head */
> -	rmb();
> +	smp_rmb();
>  	return head;
>  }
>  
> @@ -466,7 +466,7 @@ static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
>  #endif
>  
>  	/* Ensure all reads are done after we read the head */
> -	rmb();
> +	smp_rmb();
>  	return head;
>  }
>  
> @@ -478,7 +478,7 @@ static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
>  #endif
>  
>  	/* Ensure all reads are done before we write the tail out */
> -	mb();
> +	smp_mb();
>  #if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
>  	pc->aux_tail = tail;
>  #else
> 

