Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5A3C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 20:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E4F5613D0
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 20:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhHWUNE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 Aug 2021 16:13:04 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:36718 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhHWUND (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Aug 2021 16:13:03 -0400
Received: by mail-ot1-f52.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso18685095otv.3;
        Mon, 23 Aug 2021 13:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L179XY5+/AP6kKn6By4MFvJ/DUa+ej7EMi3LsNJUgg8=;
        b=erHp3HLxbYf/S6WhkPf4Y3Ej1b4GH0+1grqoP2SBYTv3W5NclIQY7B9VBlOKHW+qJS
         NkmjQ4GTKQZvBkrPyA8OT68Xtqw3Bc2QqKL9bePwPTupt1M/cJfLRIuWazxINu8J8DBt
         sbMBdHI+n9pCF81EU2HV27p0CqojHK29HeOBAcQucQ/wX9IU76Cnz1L7AxYSeI5f6bJS
         drICXj0E8IIzZW6xeSwN9xIYKX5QnAvCsYrEfPCO/5lQz1WAS+m9gFXdYIWI8ngcpFtk
         iWhE6T7f3dXxJW82S4OJmh5cj0QIJa6FlyAKyRHfCh0mJJJ+huJSvIMnTDFamPkRz4oS
         xIRw==
X-Gm-Message-State: AOAM533pfGaj0ne3ZfFqgQxhqKA0GOUNcnQL6hmrXqPp7uPTXf3XYg0d
        /MRQeWnPDdwGgIP8TGWqaA==
X-Google-Smtp-Source: ABdhPJypZUdl4H1QY/HJlh7aKbMM5b7Qh20n0jvTwPptwLCsuyebV8QC6AAF5p2YxVxyTTLbXBnlRw==
X-Received: by 2002:aca:b341:: with SMTP id c62mr252257oif.136.1629749540372;
        Mon, 23 Aug 2021 13:12:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 68sm4040897otj.57.2021.08.23.13.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 13:12:19 -0700 (PDT)
Received: (nullmailer pid 2638653 invoked by uid 1000);
        Mon, 23 Aug 2021 20:12:19 -0000
Date:   Mon, 23 Aug 2021 15:12:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/3] libperf: Add processing to scale the counters
 obtained during the read() system call when multiplexing
Message-ID: <YSQBI+FZLBvKr088@robh.at.kernel.org>
References: <20210820093908.734503-1-nakamura.shun@fujitsu.com>
 <20210820093908.734503-2-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820093908.734503-2-nakamura.shun@fujitsu.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 20, 2021 at 06:39:06PM +0900, Shunsuke Nakamura wrote:
> perf_evsel__read() scales counters obtained by RDPMC during multiplexing, but
> does not scale counters obtained by read() system call.
> 
> Add processing to perf_evsel__read() to scale the counters obtained during the
> read() system call when multiplexing.

Which one is right though? Changing what read() returns could break 
users, right? Or are you implying that the RDPMC path is correct and 
read() was not. More likely the former case since I wrote the latter.

> 
> Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> ---
>  tools/lib/perf/evsel.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index d8886720e83d..005cf64a1ad7 100644
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
> @@ -308,6 +309,9 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
>  	if (readn(FD(evsel, cpu, thread), count->values, size) <= 0)
>  		return -errno;
>  
> +	if (count->ena != count->run)
> +		count->val = mul_u64_u64_div64(count->val, count->ena, count->run);
> +
>  	return 0;
>  }
>  
> -- 
> 2.25.1
> 
> 
