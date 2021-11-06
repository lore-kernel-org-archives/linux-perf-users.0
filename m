Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0CAC433F5
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 13:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E8E2611AE
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 13:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhKFNuS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 Nov 2021 09:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhKFNuR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 Nov 2021 09:50:17 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494C0C061714
        for <linux-perf-users@vger.kernel.org>; Sat,  6 Nov 2021 06:47:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso5377583pjo.3
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Nov 2021 06:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cpPMO+oyCgCm4JMMdEnYJQPJnzv6BIKAi1V6GfI7xUA=;
        b=v5mEqjJBFLHCL2H+vbyoD8h7c/OK8u2x6BVSkvfTVJu2ym+Q1oFfJyqYW8sMjBad43
         kionLzcQfNSHLC2FS4WKmExtY3u94h1UxFEoG31S5PGm4dwKBr/UHQzUBKKgOVeDpTxF
         MKbmAV9lKcbFa16+vWA8VNm2BepL2dFZeIestYmLslUYhppFZJw+CsZKwH2tDxWTDMgL
         nq3c85j3bgjYnfwD3S0SCIaewLjVoGj6PUJZ6fH2aTOTeAbaUD9O9CDM20QpgqO558Vz
         5BT4xeR0D7aFQoN+ari7JJG0xcUR6Z7baIgHVKFmjxKdIStEhP1sK+SjkMlUSS75lew6
         HBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cpPMO+oyCgCm4JMMdEnYJQPJnzv6BIKAi1V6GfI7xUA=;
        b=iTAG5CCs2aEuppnHz2j/X5tq6GjS/JPGHXswKmbXJnRv1EBjH3eqPKz8ATXOP+IxwD
         15RTbuKL/pY1WNU83YGxRcIJ+/UngWjgexGOsJs7n3UlHEggtxZNrhdGQDXCW529p7e4
         adBX8Cd203h9yo6Mea0794I+bF8JRXmFKgWR51WQLtY7v6jTLFtSA7SJNyulhDvLyMC4
         oxPlHRebzGohRCXbY5wfCvoYfFH0oDC3f1hrwlxM7UCFoLTdYz45UQwqkF6jLHCPamrS
         qi6lU29tynP3/z9CnALcklZROruWIqoaFWK3HKW8DY6Zoh2gB2twRTZDjbbJFL5+r3SX
         M/gw==
X-Gm-Message-State: AOAM532wGig+31WZ2xpY/n0Q0fHoTEhLMGXH/5YCd6HMu+tPgS72ZDeL
        4y8VVxS6rNawDtZGkgBUq1BliA==
X-Google-Smtp-Source: ABdhPJwwtrmOcgNOnynP3D3Y+zgQzsZtX6gLsQWCWXog4kHLg3MsIDrrLiQxzOeYTDuq2Q3OLwekdw==
X-Received: by 2002:a17:90a:408f:: with SMTP id l15mr37664768pjg.34.1636206453806;
        Sat, 06 Nov 2021 06:47:33 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id z2sm11005889pfh.135.2021.11.06.06.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 06:47:33 -0700 (PDT)
Date:   Sat, 6 Nov 2021 21:47:25 +0800
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
Message-ID: <20211106134725.GI477387@leoy-ThinkPad-X240s>
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

Since 'context_id' is type u64, here it's good to assign '(u64)-1'.

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
