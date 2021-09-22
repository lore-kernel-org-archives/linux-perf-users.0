Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE0CC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 21:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC92961181
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 21:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbhIVVg1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 17:36:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238022AbhIVVg0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 17:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632346495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tkHP6mmjG7SBJfcpCC261TiUWmXihHKnsMoMGcToTiQ=;
        b=ZU7Dxtkiq5twh+n01SpeETB1N8ejE3cxLjPuNbRkc7n5Uk9daA6UDiu/PmOwOpu+6BqEYL
        rAqbX/i4PNPNkdfmDtqtKOEETxdLe+Sx1JGNMmcAxOzlMcioI/A0bPI3j1f4WidmaTVx7L
        FfHrtt0naGdgqiDjJz5AC4d6EVsF8OY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-r3qP0gDANpyLxlYUXAqT4w-1; Wed, 22 Sep 2021 17:34:54 -0400
X-MC-Unique: r3qP0gDANpyLxlYUXAqT4w-1
Received: by mail-wr1-f71.google.com with SMTP id f7-20020a5d50c7000000b0015e288741a4so3376025wrt.9
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 14:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tkHP6mmjG7SBJfcpCC261TiUWmXihHKnsMoMGcToTiQ=;
        b=vdARh2C5gNYCXhB5tQX/nfogmMCqHPinwxny4gBhZ8QpP1rLZ1avOskTakR17zeWHq
         clY85mwhvRoEzDuJ67NJVTeNVJzwVdZI42CmVUO7cmRBNpbZiGv6rqihkBpaee+eJmdn
         0mSd710UiDTp2Y+zC94JvovpJUtI6uH3Fbse1uQM6+/hk7o6uFn9dbqqxPgsJzllEulA
         PjFa4FVH60wjQNoRShseZtmu+mfNw+ye36PDPCj3CLKtYedAy39QX3qthdRiDEikZk5R
         U9TLk0Xk2i+KuFNJt8ELQiLHGF2fwqsW2I3E/DaGqHkJshNtL1tBFL3BLM6MP2Hsa3cu
         RY5A==
X-Gm-Message-State: AOAM530jN20x869ky0zbKvMGWLcU/ik6Ezn7ECDR6Pow8AtgKZsEY37E
        PVsDsWhMX5/9BNxZMyVPT6XDlKrO4rWlVf4OBNBCOsyC3Hs4B4hDmU0m9mDiqlTSBvUv9tZqKID
        JdQol3s6SeF8Ap8i6J6hDHXPP89BvkA==
X-Received: by 2002:a1c:4645:: with SMTP id t66mr1125850wma.130.1632346493729;
        Wed, 22 Sep 2021 14:34:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxd1RkKSZkPhwjIrnO7GuZSEPf5kCr25yr28k0XTQOtRFZvlE8bh9XkB8b5QIMw3larpzNauQ==
X-Received: by 2002:a1c:4645:: with SMTP id t66mr1125833wma.130.1632346493521;
        Wed, 22 Sep 2021 14:34:53 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id n186sm7105048wme.31.2021.09.22.14.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 14:34:53 -0700 (PDT)
Date:   Wed, 22 Sep 2021 23:34:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] libperf: Add processing to scale the counters
 obtained during the read() system call when multiplexing
Message-ID: <YUuhe7e0J0PSea+b@krava>
References: <20210922101627.3396398-1-nakamura.shun@fujitsu.com>
 <20210922101627.3396398-2-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922101627.3396398-2-nakamura.shun@fujitsu.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 22, 2021 at 07:16:26PM +0900, Shunsuke Nakamura wrote:
> From: nakamura shunsuke <nakamura.shun@fujitsu.com>
> 
> perf_evsel__read() scales counters obtained by RDPMC during multiplexing, but
> does not scale counters obtained by read() system call.
> 
> Add processing to perf_evsel__read() to scale the counters obtained during the
> read() system call when multiplexing.
> 
> 
> Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> ---
>  tools/lib/perf/evsel.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 8441e3e1aaac..0ebd1d34436f 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -18,6 +18,7 @@
>  #include <sys/ioctl.h>
>  #include <sys/mman.h>
>  #include <asm/bug.h>
> +#include <linux/math64.h>
>  
>  void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
>  		      int idx)
> @@ -321,6 +322,11 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
>  	if (readn(*fd, count->values, size) <= 0)
>  		return -errno;
>  
> +	if (count->ena != count->run) {
> +		if (count->run != 0)
> +			count->val = mul_u64_u64_div64(count->val, count->ena, count->run);
> +	}

so I think perf stat expect raw values in there and does the
scaling by itself, please check following code:

read_counters
  read_affinity_counters
    read_counter_cpu
      read_single_counter
        evsel__read_counter

  perf_stat_process_counter
    process_counter_maps
      process_counter_values
        perf_counts_values__scale


perhaps we could export perf_counts_values__scale if it'd be any help

jirka


> +
>  	return 0;
>  }
>  
> -- 
> 2.27.0
> 

