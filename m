Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B36C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 09:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57AA361374
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 09:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhHWJwt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 Aug 2021 05:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbhHWJws (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Aug 2021 05:52:48 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840F4C06175F
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Aug 2021 02:52:06 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x16so14880535pfh.2
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Aug 2021 02:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bLe7NOAAmoI2YjW7rqz+AC0n9Z70JhMqaIsz3ds/O8M=;
        b=xGZWhF3BetTDV9A5WeXYEQxVznwO1zKCfX1/hgrgCaSrJkODXQ79SS/WHMOg1MzYSe
         yDjP8q2xoYpY71Lxy/tCG3y5t0D+A0zwy/Ti+KklaAyHYSzhVPdKdjUC3ZiSo4Dwi/ho
         VRWd0nh/qvrkqnn/ewIB3uolZbnTU52e/6iLLHN7arbWKcB7RF2bg3IoYPa50LpJSQ9e
         IaokcIhIq2RJ90AMnagijBSmNsqvsuFzQvv6HDfYGIMXP4Ps28cRerDENVZr27FNKsY6
         fFeYlVVtETa4eyznONmCzP0Xu2Qv374L7maj1P1k72C/Wx8G+gBjFRuLHc1WifBzEoRl
         aaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bLe7NOAAmoI2YjW7rqz+AC0n9Z70JhMqaIsz3ds/O8M=;
        b=BAtoKttEeNeOuv+FDXun8uyqyCTTDewUv3hHnW9wBXiFStiiWLAY5zeR1DPx3oLRKp
         qgA5wvg7cKgR8uhe6mmuBLdt3ScLYAwQc8G0c7hMHGT3JqUkK1ifOOPpXXG9838T16+n
         N7R3MvNSh8H2Bv64e/uUHtiFx4DgbESlABysBjPKbLWsFeX8cvqTQ5aes6johOrDpTEr
         BrP5jvnR7w+BfQbXw5wZASxm+kb6V8odlmxrK/HRsSPDccDKuKuwX9wxFn7y9Z4/dWN7
         C/uWhFgYMRV+KKVhmCEZnRAXl5gNWf/8dVQJhsjCKTyOtUWcRVgxSl/GBwOCMxRA5THo
         3cZg==
X-Gm-Message-State: AOAM532B/95ixAo5SXMQdiTHaAqUL+fSHT9riAVC2he9AQROoljgP3yU
        Ipy460rCpP6cvzzkbnmp+HVbOQ==
X-Google-Smtp-Source: ABdhPJxTTddUn0DnLXRasDTBmDVUCAQRuJRI4FWSHbJZoCJ4bTy3wMccBDU5czsBhXqMGfjXTmYz6A==
X-Received: by 2002:a62:a117:0:b029:394:dddf:6b00 with SMTP id b23-20020a62a1170000b0290394dddf6b00mr32502415pff.50.1629712325250;
        Mon, 23 Aug 2021 02:52:05 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id nk17sm1719286pjb.18.2021.08.23.02.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 02:52:04 -0700 (PDT)
Date:   Mon, 23 Aug 2021 17:51:55 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Li Huafei <lihuafei1@huawei.com>, coresight@lists.linaro.org
Subject: Re: [PATCH v1 2/3] perf auxtrace: Add
 compat_auxtrace_mmap__{read_head|write_tail}
Message-ID: <20210823095155.GC100516@leoy-ThinkPad-X240s>
References: <20210809112727.596876-1-leo.yan@linaro.org>
 <20210809112727.596876-3-leo.yan@linaro.org>
 <2b4e0c07-a8df-cca6-6a94-328560f4b0c6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b4e0c07-a8df-cca6-6a94-328560f4b0c6@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi James,

On Fri, Aug 13, 2021 at 05:22:31PM +0100, James Clark wrote:
> On 09/08/2021 12:27, Leo Yan wrote:
> > +/*
> > + * In the compat mode kernel runs in 64-bit and perf tool runs in 32-bit mode,
> > + * 32-bit perf tool cannot access 64-bit value atomically, which might lead to
> > + * the issues caused by the below sequence on multiple CPUs: when perf tool
> > + * accesses either the load operation or the store operation for 64-bit value,
> > + * on some architectures the operation is divided into two instructions, one
> > + * is for accessing the low 32-bit value and another is for the high 32-bit;
> > + * thus these two user operations can give the kernel chances to access the
> > + * 64-bit value, and thus leads to the unexpected load values.
> > + *
> > + *   kernel (64-bit)                        user (32-bit)
> > + *
> > + *   if (LOAD ->aux_tail) { --,             LOAD ->aux_head_lo
> > + *       STORE $aux_data      |       ,--->
> > + *       FLUSH $aux_data      |       |     LOAD ->aux_head_hi
> > + *       STORE ->aux_head   --|-------`     smp_rmb()
> > + *   }                        |             LOAD $data
> > + *                            |             smp_mb()
> > + *                            |             STORE ->aux_tail_lo
> > + *                            `----------->
> > + *                                          STORE ->aux_tail_hi
> > + *
> > + * For this reason, it's impossible for the perf tool to work correctly when
> > + * the AUX head or tail is bigger than 4GB (more than 32 bits length); and we
> > + * can not simply limit the AUX ring buffer to less than 4GB, the reason is
> > + * the pointers can be increased monotonically, whatever the buffer size it is,
> > + * at the end the head and tail can be bigger than 4GB and carry out to the
> > + * high 32-bit.
> > + *
> > + * To mitigate the issues and improve the user experience, we can allow the
> > + * perf tool working in certain conditions and bail out with error if detect
> > + * any overflow cannot be handled.
> > + *
> > + * For reading the AUX head, it reads out the values for three times, and
> > + * compares the high 4 bytes of the values between the first time and the last
> > + * time, if there has no change for high 4 bytes injected by the kernel during
> > + * the user reading sequence, it's safe for use the second value.
> > + *
> > + * When update the AUX tail and detects any carrying in the high 32 bits, it
> > + * means there have two store operations in user space and it cannot promise
> > + * the atomicity for 64-bit write, so return '-1' in this case to tell the
> > + * caller an overflow error has happened.
> > + */
> > +u64 __weak compat_auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
> > +{
> > +	struct perf_event_mmap_page *pc = mm->userpg;
> > +	u64 first, second, last;
> > +	u64 mask = (u64)(UINT32_MAX) << 32;
> > +
> > +	do {
> > +		first = READ_ONCE(pc->aux_head);
> > +		/* Ensure all reads are done after we read the head */
> > +		smp_rmb();
> > +		second = READ_ONCE(pc->aux_head);
> > +		/* Ensure all reads are done after we read the head */
> > +		smp_rmb();
> > +		last = READ_ONCE(pc->aux_head);
> > +	} while ((first & mask) != (last & mask));
> > +
> > +	return second;
> > +}
> > +
> 
> Hi Leo,
> 
> I had a couple of questions about this bit. If we're assuming that the
> high bytes of 'first' and 'last' are equal, then 'second' is supposed
> to be somewhere in between or equal to 'first' and 'last'.
> 
> If that's the case, wouldn't it be better to return 'last', because it's
> closer to the value at the time of reading?

> And then in that case, if last is returned, then why do a read for
> 'second' at all? Can 'second' be skipped and just read first and last?

Simply to say, the logic can be depicted as:

  step 1: read 'first'
  step 2: read 'second' -> There have no any atomicity risk if 'first'
                           is same with 'last'
  step 3: read 'last'

The key point is if the 'first' and 'last' have the same value in the
high word, there have no any increment for high word in the middle of
'first' and 'last', so we don't worry about the atomicity for 'second'.

But we cannot promise the atomicity for reading 'last', let's see
below sequence:

             CPU(a)                                 CPU(b)
  step 1: read 'first' (high word)
          read 'first' (low word)
  step 2: read 'second' (high word)
          read 'second' (low word)
  step 3: read 'last' (high word)
                                       --> write 'last' (high word)
                                       --> write 'last' (low word)
          read 'last' (low word)


Even 'first' and 'last' have the same high word, but the 'last' cannot
be trusted.

> Also maybe it won't make a difference, but is there a missing smp_rmb()
> between the read of 'last' and 'first'?

Good question, from my understanding, we only need to promise the flow
from step 1 to step 3, it's not necessary to add barrier in the middle
of the two continuous loops.

Thanks for reviewing!

Leo
