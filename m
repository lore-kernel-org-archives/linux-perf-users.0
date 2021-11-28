Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4DAC433EF
	for <linux-perf-users@archiver.kernel.org>; Sun, 28 Nov 2021 17:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358526AbhK1RFa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 28 Nov 2021 12:05:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358608AbhK1RD3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 28 Nov 2021 12:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638118813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hv3mUN/Ti1jWQO+IHXGJK90zoQnHriwLvawJYNBsi0M=;
        b=QNfHzDMeG/nofNCRfDIY9l6p/YfetgEIiLoIDO60rFhXeTUA3SQ07o1eMPzBlcQVtWJsNu
        0wqT/solC81jRGCMbUqp4Rty64GCawr62xOKrjBZ5QRv2GIH5kw28DLOED1gKxRoCHkirT
        6bLqQbAuCxCovdHFBJTamVF8bSSNHnI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-ZWDUxrGjNACMtGLquv_6ow-1; Sun, 28 Nov 2021 12:00:11 -0500
X-MC-Unique: ZWDUxrGjNACMtGLquv_6ow-1
Received: by mail-wm1-f71.google.com with SMTP id l4-20020a05600c1d0400b00332f47a0fa3so9069701wms.8
        for <linux-perf-users@vger.kernel.org>; Sun, 28 Nov 2021 09:00:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hv3mUN/Ti1jWQO+IHXGJK90zoQnHriwLvawJYNBsi0M=;
        b=261Irfk563dD1MfytiturNxG0A85pcBBqIj3SyAf0OsNZjhXvJgSPRVbS7cI23GLO7
         2/QZtwuPkNehvbyUiIw4vSScu2v6o4439qVOY0Ry8E93yzdRwKYEAVu7eX356FMSNwdO
         qkdnNYtY8/6qEuUy/aY1JHZfv57NJGP2xLjjz/sir8zfhCZ8Xxy6c7DXeAOcQx4gFkjR
         y/2hMRAxQ85zaLbXGkUKERXdlBXp7up8IP8ls9GPm9s8jkrYvIoav0GFpV5fHmTl422n
         jriUBe0n2m7DMyqoCEqJMvc2TlVQbzsQYEifr32GH6D6AeR3QKSqOBOG9WdvSzKXN0pO
         Kbww==
X-Gm-Message-State: AOAM5322BRa+og31IqV+OCGzGQaEHBap4vDGHexsThlmTJ6aAX87UJDo
        PJugMYw6s3pjbVFVO1MBAE2/7x5BaSTGUeANF/mZhSoyhM0HNgE9AJfxdaPLuIVeDi0n8MKfE0v
        gQbEoLVqg8QdOYYkLm7Eg6LZMlx3B2Q==
X-Received: by 2002:adf:f2ca:: with SMTP id d10mr27762986wrp.79.1638118810597;
        Sun, 28 Nov 2021 09:00:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhNeic8ASk3JN4l+USlK6zRcaKtMEX2TtZEIKpe/ZHIMchluzOnJC7qMWZIxiEBPDrZ3fbaA==
X-Received: by 2002:adf:f2ca:: with SMTP id d10mr27762967wrp.79.1638118810466;
        Sun, 28 Nov 2021 09:00:10 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id u23sm12141760wru.21.2021.11.28.09.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 09:00:10 -0800 (PST)
Date:   Sun, 28 Nov 2021 18:00:08 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     cgel.zte@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, yao.jin@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] perf tools: remove unneeded variable
Message-ID: <YaO1mETPEL+QLPak@krava>
References: <20211122014159.25317-1-ran.jianping@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122014159.25317-1-ran.jianping@zte.com.cn>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 22, 2021 at 01:41:59AM +0000, cgel.zte@gmail.com wrote:
> From: ran jianping <ran.jianping@zte.com.cn>
> 
> Fix the following coccicheck review:
> ./tools/perf/util/evlist.c:1303:5-8: Unneeded variable
> 
> Remove unneeded variable used to store return value.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ran jianping <ran.jianping@zte.com.cn>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/evlist.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 5f92319ce258..d64fe767f583 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1300,7 +1300,6 @@ static int evlist__create_syswide_maps(struct evlist *evlist)
>  {
>  	struct perf_cpu_map *cpus;
>  	struct perf_thread_map *threads;
> -	int err = -ENOMEM;
>  
>  	/*
>  	 * Try reading /sys/devices/system/cpu/online to get
> @@ -1325,7 +1324,7 @@ static int evlist__create_syswide_maps(struct evlist *evlist)
>  out_put:
>  	perf_cpu_map__put(cpus);
>  out:
> -	return err;
> +	return -ENOMEM;
>  }
>  
>  int evlist__open(struct evlist *evlist)
> -- 
> 2.25.1
> 

