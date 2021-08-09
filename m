Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AD2C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 20:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F5CA61052
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 20:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbhHIUAv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 16:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233496AbhHIUAu (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 16:00:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC16A61004;
        Mon,  9 Aug 2021 20:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628539230;
        bh=TW5Z07X1gH/zM2GID6GiUFMpFybiFvmvsv9FOxzh5o0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dBHO6UaxxzJVdReLbDg484WhhgWTM1F/t1GqhCijWvk1radTKDstUpHIpmJOqDWVL
         9I2+V39XpMc+FrgUUTwCW0yXE3K81rY/ZYJiSxUl3zZcNOpoFy/nd45gkMqrI/fcoR
         +hYCvSxD5vjKQpnkVVsDmaJkHCtsa8eiy2nk144pg71cMUiQiDxs9ORIeIJTD4GTzc
         PtckQdCGzBNoaCBK5C4cutSccsNpwI1ut/44l9gb587+Ouh+7iRzYssGZch6UOfIUj
         6dxur5Db9oN8w6RAUIWrEAKNdz3EkMLBRBHYFL+/8zTlQ7BCACu7fQidW295SpLvZA
         N2Un9nK7SJpGA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 86626403F2; Mon,  9 Aug 2021 17:00:27 -0300 (-03)
Date:   Mon, 9 Aug 2021 17:00:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>, x86@kernel.org,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
Subject: Re: [PATCH v5 6/9] perf auxtrace: Drop legacy __sync functions
Message-ID: <YRGJW2+ku/AOrCll@kernel.org>
References: <20210809111407.596077-1-leo.yan@linaro.org>
 <20210809111407.596077-7-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809111407.596077-7-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Aug 09, 2021 at 07:14:04PM +0800, Leo Yan escreveu:
> The main purpose for using __sync built-in functions is to support
> compat mode for 32-bit perf with 64-bit kernel.  But using these
> built-in functions might cause potential issues.
> 
> __sync functions originally support Intel Itanium processoer [1]
> but it cannot promise to support all 32-bit archs.  Now these
> functions have become the legacy functions.
> 
> Considering __sync functions cannot really fix the 64-bit value
> atomicity on 32-bit archs, thus this patch drops __sync functions.
> 
> Credits to Peter for detailed analysis.

Thanks, applied to perf/core.

- Arnaldo

 
> [1] https://gcc.gnu.org/onlinedocs/gcc/_005f_005fsync-Builtins.html#g_t_005f_005fsync-Builtins
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/auxtrace.h | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 79227b8864cd..4f9176368134 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -440,12 +440,6 @@ struct auxtrace_cache;
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
> @@ -459,11 +453,7 @@ static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
>  static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
>  {
>  	struct perf_event_mmap_page *pc = mm->userpg;
> -#if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
>  	u64 head = READ_ONCE(pc->aux_head);
> -#else
> -	u64 head = __sync_val_compare_and_swap(&pc->aux_head, 0, 0);
> -#endif
>  
>  	/* Ensure all reads are done after we read the head */
>  	smp_rmb();
> @@ -473,19 +463,10 @@ static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
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
>  	WRITE_ONCE(pc->aux_tail, tail);
> -#else
> -	do {
> -		old_tail = __sync_val_compare_and_swap(&pc->aux_tail, 0, 0);
> -	} while (!__sync_bool_compare_and_swap(&pc->aux_tail, old_tail, tail));
> -#endif
>  }
>  
>  int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
> -- 
> 2.25.1
> 

-- 

- Arnaldo
