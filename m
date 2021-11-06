Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B54CC433F5
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 03:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB1261058
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 03:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbhKFDfB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 Nov 2021 23:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbhKFDfA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 Nov 2021 23:35:00 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C511C061714
        for <linux-perf-users@vger.kernel.org>; Fri,  5 Nov 2021 20:32:20 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s136so9920006pgs.4
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Nov 2021 20:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kPw4IpQgVBr/ID80OekzGmZKKaWfDwtzZQlyt4TvPck=;
        b=WAi+C8/Ck8zZ0zAPSHoEakdHLL+EjKgGG6vUEqDWiAP+aOofMnXUPSfAw86q4mgO+g
         kHJ8YFyKAi38co/Cg1Vref/EzgQrBw7IiimsN09gvkvUUB0Hctu1ua7G6EuMpxXJlhmG
         9TGQIyWHLdoZViQKT+ba52KUi1sSx1d3Rg8TC/AmUxdvtmZYE/by6AYmphSPw6wMcKN3
         NEWp/kZhJyw/1lasVZOLlL/FtJReS+F1DUCxvR/55nsY4rwQ0Lz+XzhpYV+SX0L9Ku8z
         o8ChK3jAjD8fIyYSf7I+mviVbKARRVnKgGgGE3FNs09jh6NkpDxiRUk+Oh//qmJLoaul
         NAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kPw4IpQgVBr/ID80OekzGmZKKaWfDwtzZQlyt4TvPck=;
        b=kNUISXQV+VHL1AkNJSNmjun7yqBKtTBtiiMGhvKLKusAIs/BlzFQrjydktSQxBE+9H
         yvN5DMUH9IVt6Fi78uO/9dBKQeiSv8hbe5J0ouG9KnshLl+CsD+zgBScktTlYRGEL6V3
         q7dgGjwW7kSukWIZK3Q4yzo5ACSK1/0HcoH1wabOyHlPZ1hB6RNtkKSpZr9O1lor6t32
         aDAzFfW8L4IzW+1Cb86dURoNWs24bEGy1PKk0Yk3qNiHh0v6DrHVcUTJWQBGD1aKGrJK
         /b3/PzCrJL7SdFIWWPoOezAZEPAr4+AiM2bEHn/vckYy3jaQqiqmWVlxCNDNoXGO4tb8
         ZjWw==
X-Gm-Message-State: AOAM531F4a9StKEYQ2C7+FaCerRx7o8qnHXqkCcxvd1gug4KVwNyn+yC
        Zavgl10w+2YqXXbrIxQ5G9s/LQ==
X-Google-Smtp-Source: ABdhPJzw6SsCiB4uzMEDwuRTSSnGPepGGpqVQ+/aFnAW3PQvPu/K8rK4c3kiilDUM2Xm/4jruhK1sg==
X-Received: by 2002:a62:7cd3:0:b0:494:6e78:9959 with SMTP id x202-20020a627cd3000000b004946e789959mr13846321pfc.46.1636169539171;
        Fri, 05 Nov 2021 20:32:19 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id y4sm9048024pfi.178.2021.11.05.20.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 20:32:18 -0700 (PDT)
Date:   Sat, 6 Nov 2021 11:32:13 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] perf arm-spe: Save context ID in record
Message-ID: <20211106033213.GH477387@leoy-ThinkPad-X240s>
References: <20211102180739.18049-1-german.gomez@arm.com>
 <20211102180739.18049-3-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102180739.18049-3-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Nov 02, 2021 at 06:07:38PM +0000, German Gomez wrote:
> This patch is to save context ID in record, this will be used to set TID
> for samples.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: German Gomez <german.gomez@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 2 ++
>  tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> index 32fe41835..1b58859d2 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> @@ -151,6 +151,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>  	u64 payload, ip;
>  
>  	memset(&decoder->record, 0x0, sizeof(decoder->record));
> +	decoder->record.context_id = -1;
>  
>  	while (1) {
>  		err = arm_spe_get_next_packet(decoder);
> @@ -180,6 +181,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>  		case ARM_SPE_COUNTER:
>  			break;
>  		case ARM_SPE_CONTEXT:
> +			decoder->record.context_id = payload;
>  			break;
>  		case ARM_SPE_OP_TYPE:
>  			if (idx == SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC) {
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index 59bdb7309..46a8556a9 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -38,6 +38,7 @@ struct arm_spe_record {
>  	u64 timestamp;
>  	u64 virt_addr;
>  	u64 phys_addr;
> +	u64 context_id;
>  };
>  
>  struct arm_spe_insn;
> -- 
> 2.25.1
> 
