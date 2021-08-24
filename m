Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE9EC4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 08:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F266115A
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 08:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbhHXIhH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 04:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbhHXIhH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Aug 2021 04:37:07 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877B8C06175F
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Aug 2021 01:36:23 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y190so17729467pfg.7
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Aug 2021 01:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F1XMyMZTrlMsAyxJHJ7+jgxpDBQIUvOlx6q4619hvdU=;
        b=NUoRDRdLXEWTEekCDmBtZ/exdtGXze3rrbYg+ex/+uIqp7rJsa6G1CjW9ZlBEbGJPa
         0E9ZTiBZqMWIHwk7RZqP77HaITamZxBNT5RVqPYk0GC4AG8bcGOqwG6McNx/1WRjBYBZ
         aDAXLl9Mjfl68opbSN2x68GaPNFYOVo6orj7fRjUDwa/kZLN3+OZTwxFE03UekCI6qhR
         3I2uNbJQVkKOsWInW3GrI+etyfetVKbN6j/7w0fuZB2RqYweNmNrkge8BnBLNF6xVwdy
         wqF6TjBxK2KjbLdlWUR2uSSpM53Yf9dG5mFMUrtxcOzUV2tjRiP2zld8yCb1tnES86TI
         KmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F1XMyMZTrlMsAyxJHJ7+jgxpDBQIUvOlx6q4619hvdU=;
        b=FXoEZWXLygusx7NW4WcSdIdSHOrTvNlq6aEVa3N3b6/FKFH/DzQLvCnd89aggE5aVa
         vY0IxhBmqaj5+2QtEwRFiEDhI1PhBrJcZxcHUWCo2gKkcBbHVjQChNOFAABgeRWsQNpf
         IxzfusFSlV39vBGfi4XKR65qHIAyxSs7ZFsPaPSy1MD/of+q23oyUb/kWdv5+2AXoHpu
         yUnPgbf4RmMXRlixvUJSxhQPmFya9f1fPKxPP/76KEnPLHIjRVCbGXek60G5eEZ2aXHi
         TjvA5uADsXv4ZG7EHrS5DCd6DkJZUuVhODTdMuLmAZp7IB+PHdwbuQi9hUBL919V/kSO
         vNUA==
X-Gm-Message-State: AOAM531qILDbeDD1fOovzu+K36PbQL+GU8DFCiJnZzxHwPsUh5pUxIHZ
        +VdT+NaWhfohAALsgq+LtwIP0Q==
X-Google-Smtp-Source: ABdhPJyUW69QXyRkb+6UuNtr5+pZZHByZSuSk3OEROQ/prtfEBYN0rOUFRkvTRN1VPFRsmRgERbpVw==
X-Received: by 2002:aa7:86c3:0:b0:3eb:1857:8ae9 with SMTP id h3-20020aa786c3000000b003eb18578ae9mr14612757pfo.52.1629794182897;
        Tue, 24 Aug 2021 01:36:22 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id z3sm18612008pff.47.2021.08.24.01.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 01:36:22 -0700 (PDT)
Date:   Tue, 24 Aug 2021 16:36:15 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, mike.leach@linaro.org,
        acme@kernel.org, suzuki.poulose@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] perf cs-etm: Show a warning for an unknown magic
 number
Message-ID: <20210824083615.GF204566@leoy-ThinkPad-X240s>
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-10-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806134109.1182235-10-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 06, 2021 at 02:41:09PM +0100, James Clark wrote:
> Currently perf reports "Cannot allocate memory" which isn't very helpful
> for a potentially user facing issue. If we add a new magic number in
> the future, perf will be able to report unrecognised magic numbers.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/util/cs-etm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 788ad5a099f6..5b276bdb96a6 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2973,6 +2973,11 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  
>  			/* ETE shares first part of metadata with ETMv4 */
>  			trcidr_idx = CS_ETMV4_TRCTRACEIDR;
> +		} else {
> +			ui__error("CS ETM Trace: Unrecognised magic number %#"PRIx64". File could be from a newer version of perf.\n",
> +				  ptr[i]);
> +			err = -EINVAL;
> +			goto err_free_metadata;
>  		}
>  
>  		if (!metadata[j]) {
> -- 
> 2.28.0
> 
