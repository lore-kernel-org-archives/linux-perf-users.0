Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F614C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 13:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82E2D61241
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 13:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhIWNgm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Sep 2021 09:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbhIWNgl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Sep 2021 09:36:41 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E71C061574
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Sep 2021 06:35:10 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s11so6290014pgr.11
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Sep 2021 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VlVB95cNrT7L7B14qG5U08EFg3vZ72o8QrXDE75UfsQ=;
        b=H+7BpQGym/v8soxz1LNyRmIz1lQELJ28aKT/lFaFI5MgA6kMM8dyT3+r4JPGaP258v
         K+ZZosPi5wXIvk0Biw3f7y11tZ90L/0SVhqT+Ueinl+lRR8VCyKL82AO/E5tyubyddip
         qsoclkYBpk8SZP46xjI5XlD/Y3bzA8J7jphPeNGU6lm7kEErYtK9jc/UIMKjRG4xWjNZ
         FbZqdaZKQ90k2sCN8CA2jjaMmFU7PmXaQDYN4FQ/7GwNcPgWhprtwXO0eF+vM2bdtMUG
         YDSKkkf3bklcu+wrq9qiiriOuOV57gJbejbOHSCRIS+W/gat+lY4Y1leBH2PPMh6DX68
         kkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VlVB95cNrT7L7B14qG5U08EFg3vZ72o8QrXDE75UfsQ=;
        b=AxTSzNhiRQM3UeWA/gw+f7JmBlek85svR/yKWTzcNXa7q97QVL9jW2yW08sTLTg2I4
         XojuB5086n92QPhqsP+IPJBQymyWRNUuEUPYYZAdlkMw0O0hCu1TebLKTdm0GlBGy4Z/
         7PO5kxcaKZ5Li1lkmlAE8uKWp+6qvS8jhxfw5QTdHZ99Blrn1v96VOizHoyfotraO7Ky
         r0UoQ3LBYclcWyW2CclJfXb/hbxXeF7K9aEvLqt6hTcd2ObqVv/gBrGkTKGaim4QUc3h
         Aem+KOpZO4GdfFaagtYtJ5O6opN759K3GQ0d1jAT7etpLHedAJP7kHw/C/7v1SSrKuaS
         VBzg==
X-Gm-Message-State: AOAM530hK74OAB66qLN1N2SfJWOlCzE5GlGapm+C8cpeRXPb6EfOt2uR
        A4NNUs5ut110QGRbizNF2tpyPtKOsT5pBXUr
X-Google-Smtp-Source: ABdhPJygZXKn4h3hX7WzpSaABOnvhY3ygPq4cAYtypuJuGsvDXTle4pnBtBlX9/0tzCZaNfTmQy4NA==
X-Received: by 2002:a63:eb41:: with SMTP id b1mr4235459pgk.236.1632404109572;
        Thu, 23 Sep 2021 06:35:09 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([213.173.35.225])
        by smtp.gmail.com with ESMTPSA id d137sm6228691pfd.72.2021.09.23.06.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 06:35:08 -0700 (PDT)
Date:   Thu, 23 Sep 2021 21:35:03 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: Re: [PATCH 1/5] perf cs-etm: Print size using consistent format
Message-ID: <20210923133503.GE400258@leoy-ThinkPad-X240s>
References: <20210916154635.1525-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916154635.1525-1-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 16, 2021 at 04:46:31PM +0100, German Gomez wrote:
> From: Andrew Kilroy <andrew.kilroy@arm.com>
> 
> Since the size is already printed earlier in hex, print the same data
> using the same format, in hex.
> 
> Reviewed-by: James Clark <james.clark@arm.com>
> Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
> Signed-off-by: German Gomez <german.gomez@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

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
>  		     cs_etm_decoder__get_name(etmq->decoder), buffer->size);
>  
>  	do {
> -- 
> 2.17.1
> 
