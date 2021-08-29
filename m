Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DBCC432BE
	for <linux-perf-users@archiver.kernel.org>; Sun, 29 Aug 2021 10:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6392260F44
	for <linux-perf-users@archiver.kernel.org>; Sun, 29 Aug 2021 10:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbhH2K56 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 29 Aug 2021 06:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbhH2K55 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 29 Aug 2021 06:57:57 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB25C061756
        for <linux-perf-users@vger.kernel.org>; Sun, 29 Aug 2021 03:57:05 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n12so6807959plk.10
        for <linux-perf-users@vger.kernel.org>; Sun, 29 Aug 2021 03:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tfP/krxvcnInh/boLMug9kccVlBY9EQoc4gHBGYYM5A=;
        b=qFJ9eRLs6U/BcPFnO0UmaRWq0012AJHQJJN5XO6KoTRbpqZiFNT5eImTLaGIGYjx7/
         byuwJreRw3i2bMYpH+2PP5Hzdq2DvrYZ6OQcAQgSIOs/PO+Mw7CKHRRUPkffSmOao1qx
         QavCQ7XYDanpcOFgs6JdctJW4bK3h3T2u31siOxYo2PxG0rsUKThncUY4wMn/TWnvGOd
         FZklltzjANQ1JGOCjnyKZKe2QbyKNYeZIcjJ44Sp/nXUfZzVMCeDKvDZaN/2R+VqwVbX
         diAimcdF/iPTrYZylJ8DMbEpdVUGRA8xABkGnTfb8qTUGKST9YZwe9M06PXBpR7G4Fwo
         g9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tfP/krxvcnInh/boLMug9kccVlBY9EQoc4gHBGYYM5A=;
        b=Lnpsh0bmI05M/lYZQbUgsEOJbsTZfv1TfEB8CbKaZYhDMKb2g+GOlF138rjFn+Fytn
         XH6HjO0KwWPrH7sy6IUcici97yfK/S/wPiNQ3csFrdTILN/NE1cMCLZnr7svnvKI7ATD
         Tka8pO6ltWuS7BDszYeiHvsAUpJyOtncErxYrkh+TM1/1Uzy5lzrugUPKpyaIaM7O307
         rEFG+ozbpBSt/RwtlcB8t3RHuzIzdy0dMjgQFNUENj/h/3Tf4QJv0bWtuP92cGGLKrxb
         xGu/BGg+obxW0Q4CD1gORSOiW5NDDzLZTGadqbIg1au9H8CZiv0hGoYC5WJusUjXa5BL
         aEmg==
X-Gm-Message-State: AOAM532NsP4rIgPF3b1zjXNfj6OiCFj5C/oVbQFIo9kNf7VXqA2SVx5U
        cGBi2KRoveG1N9xJBaAih2EakWWj1QLpQV4R
X-Google-Smtp-Source: ABdhPJxrBNEU0550CFx1Eu1vN+zAIx8qpjQJeNe+huvOi+b0n2P+QilPJruTOy2qyJnUi7lrYr7q1Q==
X-Received: by 2002:a17:90a:aa85:: with SMTP id l5mr20990787pjq.111.1630234625344;
        Sun, 29 Aug 2021 03:57:05 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id c15sm11465005pfl.181.2021.08.29.03.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 03:57:04 -0700 (PDT)
Date:   Sun, 29 Aug 2021 18:56:57 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH v5 4/9] perf/x86: Add compiler barrier after updating BTS
Message-ID: <20210829105657.GC14461@leoy-ThinkPad-X240s>
References: <20210809111407.596077-1-leo.yan@linaro.org>
 <20210809111407.596077-5-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809111407.596077-5-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Peter, or any x86 maintainer,

On Mon, Aug 09, 2021 at 07:14:02PM +0800, Leo Yan wrote:
> Since BTS is coherent, simply add a compiler barrier to separate the BTS
> update and aux_head store.

Could you reivew this patch and check if BTS needs the comipler
barrier in this case?  Thanks.

> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  arch/x86/events/intel/bts.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
> index 6320d2cfd9d3..974e917e65b2 100644
> --- a/arch/x86/events/intel/bts.c
> +++ b/arch/x86/events/intel/bts.c
> @@ -209,6 +209,12 @@ static void bts_update(struct bts_ctx *bts)
>  	} else {
>  		local_set(&buf->data_size, head);
>  	}
> +
> +	/*
> +	 * Since BTS is coherent, just add compiler barrier to ensure
> +	 * BTS updating is ordered against bts::handle::event.
> +	 */
> +	barrier();
>  }
>  
>  static int
> -- 
> 2.25.1
> 
