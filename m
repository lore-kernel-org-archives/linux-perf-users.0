Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCF8C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 20:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F13DB6101E
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 20:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhHIUMy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 16:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233122AbhHIUMy (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 16:12:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EBE960F11;
        Mon,  9 Aug 2021 20:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628539953;
        bh=EspkTptJWNcCjEtEuHL0zQWAAqCwaT5wWDI6oGL/1k8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qBLCrVvg2GzJPYenRNLdT7QMI/+D2knBb4vII0Zw07u3kQ65Ya4frlonmGpCKkqtb
         MSae/GGFCW+7+F5egPQbiWiTOvpgWV0MlmKvW8vyVPgNtuWlUrCn3iRfKJW2H12x3K
         K/Q+OJxHItA+oeXX895OCKrfrNnDK7MMeNFsFzM/7uCO1Jyz7OS1vIW/Z6epW5hvCM
         3LhIn39UiQ2EbasVR5roYLis2bDreoRp4BZ+8GfhamevVM3rIl7p4aa9Nac6rqVSJD
         FNAMDlW7pQGE+4f9GoHeXzZfswom6E61a91XyTzAk6KaT5xpvx7beMz79alab7V9Rf
         SiClhTWraTehQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 42B58403F2; Mon,  9 Aug 2021 17:12:30 -0300 (-03)
Date:   Mon, 9 Aug 2021 17:12:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Li Huafei <lihuafei1@huawei.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] perf auxtrace: Add
 compat_auxtrace_mmap__{read_head|write_tail}
Message-ID: <YRGMLsEnWI+opAqB@kernel.org>
References: <20210809112727.596876-1-leo.yan@linaro.org>
 <20210809112727.596876-3-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809112727.596876-3-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Aug 09, 2021 at 07:27:26PM +0800, Leo Yan escreveu:
> When perf runs in compat mode (kernel in 64-bit mode and the perf is in
> 32-bit mode), the 64-bit value atomicity in the user space cannot be
> assured, E.g. on some architectures, the 64-bit value accessing is split
> into two instructions, one is for the low 32-bit word accessing and
> another is for the high 32-bit word.
> 
> This patch introduces weak functions compat_auxtrace_mmap__read_head()
> and compat_auxtrace_mmap__write_tail(), as their naming indicates, when
> perf tool works in compat mode, it uses these two functions to access
> the AUX head and tail.  These two functions can allow the perf tool to
> work properly in certain conditions, e.g. when perf tool works in
> snapshot mode with only using AUX head pointer, or perf tool uses the
> AUX buffer and the incremented tail is not bigger than 4GB.
> 
> When perf tool cannot handle the case when the AUX tail is bigger than
> 4GB, the function compat_auxtrace_mmap__write_tail() returns -1 and
> tells the caller to bail out for the error.
> 
> These two functions are declared as weak attribute, this allows to
> implement arch specific functions if any arch can support the 64-bit
> value atomicity in compat mode.

Adrian, ARM guys, can you please review this?

Thanks,

- Arnaldo
 
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/auxtrace.c | 88 ++++++++++++++++++++++++++++++++++++--
>  tools/perf/util/auxtrace.h | 22 ++++++++--
>  2 files changed, 103 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index f33f09b8b535..60975df05d54 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -1669,6 +1669,82 @@ int perf_event__process_auxtrace_error(struct perf_session *session,
>  	return 0;
>  }
>  
> +/*
> + * In the compat mode kernel runs in 64-bit and perf tool runs in 32-bit mode,
> + * 32-bit perf tool cannot access 64-bit value atomically, which might lead to
> + * the issues caused by the below sequence on multiple CPUs: when perf tool
> + * accesses either the load operation or the store operation for 64-bit value,
> + * on some architectures the operation is divided into two instructions, one
> + * is for accessing the low 32-bit value and another is for the high 32-bit;
> + * thus these two user operations can give the kernel chances to access the
> + * 64-bit value, and thus leads to the unexpected load values.
> + *
> + *   kernel (64-bit)                        user (32-bit)
> + *
> + *   if (LOAD ->aux_tail) { --,             LOAD ->aux_head_lo
> + *       STORE $aux_data      |       ,--->
> + *       FLUSH $aux_data      |       |     LOAD ->aux_head_hi
> + *       STORE ->aux_head   --|-------`     smp_rmb()
> + *   }                        |             LOAD $data
> + *                            |             smp_mb()
> + *                            |             STORE ->aux_tail_lo
> + *                            `----------->
> + *                                          STORE ->aux_tail_hi
> + *
> + * For this reason, it's impossible for the perf tool to work correctly when
> + * the AUX head or tail is bigger than 4GB (more than 32 bits length); and we
> + * can not simply limit the AUX ring buffer to less than 4GB, the reason is
> + * the pointers can be increased monotonically, whatever the buffer size it is,
> + * at the end the head and tail can be bigger than 4GB and carry out to the
> + * high 32-bit.
> + *
> + * To mitigate the issues and improve the user experience, we can allow the
> + * perf tool working in certain conditions and bail out with error if detect
> + * any overflow cannot be handled.
> + *
> + * For reading the AUX head, it reads out the values for three times, and
> + * compares the high 4 bytes of the values between the first time and the last
> + * time, if there has no change for high 4 bytes injected by the kernel during
> + * the user reading sequence, it's safe for use the second value.
> + *
> + * When update the AUX tail and detects any carrying in the high 32 bits, it
> + * means there have two store operations in user space and it cannot promise
> + * the atomicity for 64-bit write, so return '-1' in this case to tell the
> + * caller an overflow error has happened.
> + */
> +u64 __weak compat_auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
> +{
> +	struct perf_event_mmap_page *pc = mm->userpg;
> +	u64 first, second, last;
> +	u64 mask = (u64)(UINT32_MAX) << 32;
> +
> +	do {
> +		first = READ_ONCE(pc->aux_head);
> +		/* Ensure all reads are done after we read the head */
> +		smp_rmb();
> +		second = READ_ONCE(pc->aux_head);
> +		/* Ensure all reads are done after we read the head */
> +		smp_rmb();
> +		last = READ_ONCE(pc->aux_head);
> +	} while ((first & mask) != (last & mask));
> +
> +	return second;
> +}
> +
> +int __weak compat_auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
> +{
> +	struct perf_event_mmap_page *pc = mm->userpg;
> +	u64 mask = (u64)(UINT32_MAX) << 32;
> +
> +	if (tail & mask)
> +		return -1;
> +
> +	/* Ensure all reads are done before we write the tail out */
> +	smp_mb();
> +	WRITE_ONCE(pc->aux_tail, tail);
> +	return 0;
> +}
> +
>  static int __auxtrace_mmap__read(struct mmap *map,
>  				 struct auxtrace_record *itr,
>  				 struct perf_tool *tool, process_auxtrace_t fn,
> @@ -1680,8 +1756,9 @@ static int __auxtrace_mmap__read(struct mmap *map,
>  	size_t size, head_off, old_off, len1, len2, padding;
>  	union perf_event ev;
>  	void *data1, *data2;
> +	int kernel_is_64_bit = perf_env__kernel_is_64_bit(evsel__env(NULL));
>  
> -	head = auxtrace_mmap__read_head(mm);
> +	head = auxtrace_mmap__read_head(mm, kernel_is_64_bit);
>  
>  	if (snapshot &&
>  	    auxtrace_record__find_snapshot(itr, mm->idx, mm, data, &head, &old))
> @@ -1764,10 +1841,13 @@ static int __auxtrace_mmap__read(struct mmap *map,
>  	mm->prev = head;
>  
>  	if (!snapshot) {
> -		auxtrace_mmap__write_tail(mm, head);
> -		if (itr->read_finish) {
> -			int err;
> +		int err;
> +
> +		err = auxtrace_mmap__write_tail(mm, head, kernel_is_64_bit);
> +		if (err < 0)
> +			return err;
>  
> +		if (itr->read_finish) {
>  			err = itr->read_finish(itr, mm->idx);
>  			if (err < 0)
>  				return err;
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index d68a5e80b217..5f383908ca6e 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -440,23 +440,39 @@ struct auxtrace_cache;
>  
>  #ifdef HAVE_AUXTRACE_SUPPORT
>  
> -static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
> +u64 compat_auxtrace_mmap__read_head(struct auxtrace_mmap *mm);
> +int compat_auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail);
> +
> +static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm,
> +					   int kernel_is_64_bit __maybe_unused)
>  {
>  	struct perf_event_mmap_page *pc = mm->userpg;
> -	u64 head = READ_ONCE(pc->aux_head);
> +	u64 head;
> +
> +#if BITS_PER_LONG == 32
> +	if (kernel_is_64_bit)
> +		return compat_auxtrace_mmap__read_head(mm);
> +#endif
> +	head = READ_ONCE(pc->aux_head);
>  
>  	/* Ensure all reads are done after we read the head */
>  	smp_rmb();
>  	return head;
>  }
>  
> -static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
> +static inline int auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail,
> +					    int kernel_is_64_bit __maybe_unused)
>  {
>  	struct perf_event_mmap_page *pc = mm->userpg;
>  
> +#if BITS_PER_LONG == 32
> +	if (kernel_is_64_bit)
> +		return compat_auxtrace_mmap__write_tail(mm, tail);
> +#endif
>  	/* Ensure all reads are done before we write the tail out */
>  	smp_mb();
>  	WRITE_ONCE(pc->aux_tail, tail);
> +	return 0;
>  }
>  
>  int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
> -- 
> 2.25.1
> 

-- 

- Arnaldo
