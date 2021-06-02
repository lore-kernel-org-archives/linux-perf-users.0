Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D3EC47083
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 10:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D956023F
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 10:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhFBKuP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:50:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:38328 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231905AbhFBKtW (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Jun 2021 06:49:22 -0400
IronPort-SDR: fRVUJcIsQ37FAWndKJTDp/Lf7/Dv8ELFxw3JaJPj3qAGbKbinoRnFiWS8cd5lGJryfI/CXzPQs
 sRdJjQlLuNqw==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="289386926"
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="289386926"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 03:47:27 -0700
IronPort-SDR: Qz6muSZFi2ahvoQYCouIM8vwxtXgOzHC7ph/awKQc8NhnCWD3LEcZa1By6dLhZGIsxPtciCSfC
 upSLURDM66xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="479663459"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga001.jf.intel.com with ESMTP; 02 Jun 2021 03:47:22 -0700
Subject: Re: [PATCH v2 6/8] perf auxtrace: Drop legacy __sync functions
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
References: <20210602103007.184993-1-leo.yan@linaro.org>
 <20210602103007.184993-7-leo.yan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <fc7bfa25-d96e-ea6d-2756-f94653dc4771@intel.com>
Date:   Wed, 2 Jun 2021 13:47:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602103007.184993-7-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 2/06/21 1:30 pm, Leo Yan wrote:
> The main purpose for using __sync built-in functions is to support
> compat mode for 32-bit perf with 64-bit kernel.  But using these
> built-in functions might cause couple potential issues.
> 
> Firstly, __sync functions originally support Intel Itanium processoer [1]
> but it cannot promise to support all 32-bit archs.  Now these
> functions have become the legacy functions.
> 
> As Peter also pointed out the logic issue in the function
> auxtrace_mmap__write_tail(), it does a cmpxchg with 0 values to load
> old_tail, and then executes a further cmpxchg with old_tail to write
> the new tail.  If consider the aux_tail might be assigned to '0' in the
> middle of loops, this can introduce mess for AUX buffer if the kernel
> fetches the temporary value '0'.
> 
> Considering __sync functions cannot really fix the 64-bit value
> atomicity on 32-bit archs, thus this patch drops __sync functions.
> 
> Credits to Peter for detailed analysis.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/_005f_005fsync-Builtins.html#g_t_005f_005fsync-Builtins
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/auxtrace.h | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 42b7ef811bde..e625bc76cdde 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -432,12 +432,6 @@ struct auxtrace_cache;
>  
>  #ifdef HAVE_AUXTRACE_SUPPORT
>  
> -/*
> - * In snapshot mode the mmapped page is read-only which makes using
> - * __sync_val_compare_and_swap() problematic.  However, snapshot mode expects
> - * the buffer is not updated while the snapshot is made (e.g. Intel PT disables
> - * the event) so there is not a race anyway.
> - */
>  static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
>  {
>  	struct perf_event_mmap_page *pc = mm->userpg;
> @@ -451,11 +445,7 @@ static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
>  static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
>  {
>  	struct perf_event_mmap_page *pc = mm->userpg;
> -#if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)

The test and setup for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT is not needed anymore either.

>  	u64 head = READ_ONCE(pc->aux_head);
> -#else
> -	u64 head = __sync_val_compare_and_swap(&pc->aux_head, 0, 0);
> -#endif
>  
>  	/* Ensure all reads are done after we read the head */
>  	smp_rmb();
> @@ -465,19 +455,10 @@ static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
>  static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
>  {
>  	struct perf_event_mmap_page *pc = mm->userpg;
> -#if BITS_PER_LONG != 64 && defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
> -	u64 old_tail;
> -#endif
>  
>  	/* Ensure all reads are done before we write the tail out */
>  	smp_mb();
> -#if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
>  	pc->aux_tail = tail;
> -#else
> -	do {
> -		old_tail = __sync_val_compare_and_swap(&pc->aux_tail, 0, 0);
> -	} while (!__sync_bool_compare_and_swap(&pc->aux_tail, old_tail, tail));
> -#endif
>  }
>  
>  int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
> 

