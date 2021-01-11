Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BE7C433DB
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Jan 2021 16:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36557229CA
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Jan 2021 16:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbhAKQ4s (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Jan 2021 11:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729821AbhAKQ4r (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Jan 2021 11:56:47 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5F9C061786
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Jan 2021 08:56:07 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id e2so123436plt.12
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Jan 2021 08:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sq2FqrzDyoQz9BNrYG3sZPVfF1ZaYE0pB1skj9ELFjc=;
        b=onrBw1GPHkgynAnAEeSSbPWi21Krue7y5Rhppl5Q7EyJqoIg3uViib/enI60U0SpG5
         86Cd9fRvacZZO3GTdg5LTL3kN/Ynd7cVPDu7WVQWSyPd4cowrbhJ43fqGuaFTzaa8Tbs
         T4Umg3Uej6PrrSW9byEJIojRYLftXr5Kk1L39qrK0Hm3HpcODM5OHoX7FJnnIo4bl8CJ
         zEPeQrAo5Y6K3s2j3HMkRnPYUNNYgvaTnnBToe4Zmrr764ynX7/eIlP8J5rkPEYrfNPh
         jGeGkKfezWJbv9BI9WzUiMIwelyNYaT2vMBhcufypl0ET9MfVLzvqq8Mz1VLRadBfV9n
         XIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sq2FqrzDyoQz9BNrYG3sZPVfF1ZaYE0pB1skj9ELFjc=;
        b=YfT6Utae5kA9TAEYFXcxDcgbvVymdU+OhdhW7WDzjTT0kfTCiq5JJQm7lw0BEFUgbS
         95jrwHCq1xgQ5NEynHHudnzQWYYletXvjPMIiIuazyqkNdO0P2E7Fh1slsJAbQ8bQKa8
         qDvRKQl5Gc39PfWVcR6TBCOvrLcv2e+YCq4vjd1L5PQ+8oxZK+H2RdOozn1IS2fthdSx
         aPSoPdDCkMvjrEL1e6e8Qkrh/UnFCJxyLhLswKfQBCtbdhz60JKnRreQs3GCqXNvylIR
         2VQx46ZUeTS2iml3+druDqRHtBcP0/agLXus4dl8VKbzIgJzYUvOuKT2GUXUmiuLVubE
         z0hA==
X-Gm-Message-State: AOAM531Rd1AjnZYHTw4+yFjtxGyz0whVuzkBtdDZROsphjUWcSmJ3PoH
        MzEhA/IgPBuWD+Npp42p5uUqOg==
X-Google-Smtp-Source: ABdhPJw5Ga1bQgrMJQN1BQDx7WNtwLOuNJl3y3VbY7TEzg1avaAboesxUzYk01s/y/E+/kYsj4no5w==
X-Received: by 2002:a17:902:a401:b029:dc:3e1d:234a with SMTP id p1-20020a170902a401b02900dc3e1d234amr223959plq.48.1610384167224;
        Mon, 11 Jan 2021 08:56:07 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id a29sm160231pfr.73.2021.01.11.08.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 08:56:06 -0800 (PST)
Date:   Mon, 11 Jan 2021 09:56:04 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>, acme@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Al Grant <al.grant@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf tools: Update OpenCSD to v1.0.0
Message-ID: <20210111165604.GA144935@xps15>
References: <20210108142752.27872-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108142752.27872-1-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jan 08, 2021 at 04:27:52PM +0200, James Clark wrote:
> Replace the OCSD_INSTR switch statement with an if to
> fix compilation error about unhandled values and avoid
> this issue again in the future.
> 
> Add new OCSD_GEN_TRC_ELEM_SYNC_MARKER and
> OCSD_GEN_TRC_ELEM_MEMTRANS enum values to fix unhandled
> value compilation error. Currently they are ignored.
> 
> Increase the minimum version number to v1.0.0 now
> that new enum values are used that are only present
> in this version.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Al Grant <al.grant@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/build/feature/test-libopencsd.c           |  4 ++--
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 15 ++++-----------
>  2 files changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
> index 1547bc2c0950..52c790b0317b 100644
> --- a/tools/build/feature/test-libopencsd.c
> +++ b/tools/build/feature/test-libopencsd.c
> @@ -4,9 +4,9 @@
>  /*
>   * Check OpenCSD library version is sufficient to provide required features
>   */
> -#define OCSD_MIN_VER ((0 << 16) | (14 << 8) | (0))
> +#define OCSD_MIN_VER ((1 << 16) | (0 << 8) | (0))
>  #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
> -#error "OpenCSD >= 0.14.0 is required"
> +#error "OpenCSD >= 1.0.0 is required"
>  #endif
>  
>  int main(void)
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index cd007cc9c283..3f4bc4050477 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -419,19 +419,10 @@ cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
>  	packet->last_instr_subtype = elem->last_i_subtype;
>  	packet->last_instr_cond = elem->last_instr_cond;
>  
> -	switch (elem->last_i_type) {
> -	case OCSD_INSTR_BR:
> -	case OCSD_INSTR_BR_INDIRECT:
> +	if (elem->last_i_type == OCSD_INSTR_BR || elem->last_i_type == OCSD_INSTR_BR_INDIRECT)
>  		packet->last_instr_taken_branch = elem->last_instr_exec;
> -		break;
> -	case OCSD_INSTR_ISB:
> -	case OCSD_INSTR_DSB_DMB:
> -	case OCSD_INSTR_WFI_WFE:
> -	case OCSD_INSTR_OTHER:
> -	default:
> +	else
>  		packet->last_instr_taken_branch = false;
> -		break;
> -	}
>  
>  	packet->last_instr_size = elem->last_instr_sz;
>  
> @@ -572,6 +563,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  	case OCSD_GEN_TRC_ELEM_EVENT:
>  	case OCSD_GEN_TRC_ELEM_SWTRACE:
>  	case OCSD_GEN_TRC_ELEM_CUSTOM:
> +	case OCSD_GEN_TRC_ELEM_SYNC_MARKER:
> +	case OCSD_GEN_TRC_ELEM_MEMTRANS:
>  	default:
>  		break;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Arnaldo please consider.

Thanks,
Mathieu

>  	}
> -- 
> 2.28.0
> 
