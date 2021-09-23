Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD79EC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 16:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 904E460EB2
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 16:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbhIWQ0M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Sep 2021 12:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbhIWQ0J (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Sep 2021 12:26:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69835C061574
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Sep 2021 09:24:37 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id il14-20020a17090b164e00b0019c7a7c362dso6023740pjb.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Sep 2021 09:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+mvRxQ/9Ym+apTi7SELQjAMP9+j2UVU8a1FoPdxwoEw=;
        b=vXfpnwJPn+o1iDrAYRTpffl3dtTT5keS2pP2UOw4dSffaueW2sfsKr57vhKD33fGi9
         ltf/5XEb/K3uHQNPWmuiiIpQW/skVtWh9Jhf5l6JA6IjKvD0ykUjRH48dgI/DlmjVRKx
         ssQ9A+kghQp5K65sPfianrXagszo6ri4/rzecyTWMUNrUvuJC3dHl3WhYu3Y50lHX16J
         XewsAlUQoKMVQJIbb0k19dkZaBzvUHgPAnzML3wtNkYvCICkl7JAQW4Odu/Yygen6PXc
         CX+nHSmI35C1yhfhnsUFTXftjJUb35u3aR5yd/qjDmf1pS7NDU6FHiQKbwTAegEKryFK
         o7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+mvRxQ/9Ym+apTi7SELQjAMP9+j2UVU8a1FoPdxwoEw=;
        b=tYp3PGfZ6QOwqfeSHT9IBl46Di2wlgug3i2o/yBOuflke6RwtepVZQanoGEf4LV5Er
         D73OTuSS9NtM2mHbY/lAsQs8rjMbqNiqU4BBHQlU0fRlzyOUaSUehy5u3rjz1vk2npP0
         /OGIvpp6nOKJ7K3t7RrAAB0UjmpQoe2b/THsZbx54Bc2V4zEtYCHAAW4MSLtmsdhCwpm
         +UlH7K2oia+PaIHDeMHPNjl9nI0paT8awqqHzvkuOBLrgATsEsM7eyHJWCkZyGGDOzPk
         FIVBfwJ155ZhPcpdOQOhMFsL8/2FITtkkK/Qte7fjajxh1sIEnkj9UKp9kpolgO1eplB
         98Pg==
X-Gm-Message-State: AOAM5314VAny2x4HklAtPDDEyJrjIt+Hb9e1UW4mcx/IG/CoI5Ntubxt
        fAhjVu8fZwaBMIaFuEadeQT4qg==
X-Google-Smtp-Source: ABdhPJxU3AEW85yNwW19+0HD60DixujFWhwIpdqfyAJEXe3AY6IzRlCipZYeYp/E02g04gpVHzW9Mg==
X-Received: by 2002:a17:90a:9912:: with SMTP id b18mr18911339pjp.46.1632414276879;
        Thu, 23 Sep 2021 09:24:36 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id w13sm9822413pjc.29.2021.09.23.09.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 09:24:36 -0700 (PDT)
Date:   Thu, 23 Sep 2021 10:24:34 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: Re: [PATCH 1/5] perf cs-etm: Print size using consistent format
Message-ID: <20210923162434.GA2189675@p14s>
References: <20210916154635.1525-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916154635.1525-1-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi German,

On Thu, Sep 16, 2021 at 04:46:31PM +0100, German Gomez wrote:
> From: Andrew Kilroy <andrew.kilroy@arm.com>
> 
> Since the size is already printed earlier in hex, print the same data
> using the same format, in hex.
> 
> Reviewed-by: James Clark <james.clark@arm.com>
> Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
> Signed-off-by: German Gomez <german.gomez@arm.com>
> ---
>  tools/perf/util/cs-etm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index f323adb1af85..4f672f7d008c 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -537,7 +537,7 @@ static void cs_etm__dump_event(struct cs_etm_queue *etmq,
>  
>  	fprintf(stdout, "\n");
>  	color_fprintf(stdout, color,
> -		     ". ... CoreSight %s Trace data: size %zu bytes\n",
> +		     ". ... CoreSight %s Trace data: size %#zx bytes\n",

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

A couple of things to improve for your next interactions with the Linux community:

1) Using a cover letter, even for small changes, is always a good idea.
2) RB tags should be picked up publicly rather than done internally and added to
a patchset.
3) Keep patches semantically grouped.  Here patches 04 and 05 have nothing to do
with 01, 02 and 03.

Moreover Arnaldo queues changes to the perf tools but I don't see him CC'ed to
this patchset.  As such he will not see your work.  Ask James about how to
proceed when submitting patches to the perf tools.

Thanks,
Mathieu

>  		     cs_etm_decoder__get_name(etmq->decoder), buffer->size);
>  
>  	do {
> -- 
> 2.17.1
> 
