Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E233C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 20:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 031A46103A
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 20:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhHWU1c (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 Aug 2021 16:27:32 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:35663 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhHWU1b (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Aug 2021 16:27:31 -0400
Received: by mail-ot1-f50.google.com with SMTP id y14-20020a0568302a0e00b0051acbdb2869so32936577otu.2;
        Mon, 23 Aug 2021 13:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mc9lmGyL+jeXNfl+ikUp3ZPLt4CjX1mmz8iQ61bWTSw=;
        b=E2Jj18DlmMySvIpbTBk2/B/LnaQQIvsnslXlfsJ1ZSEtGxobrlv2ziqu6FyIjPBAjw
         PgX+GLBR3jB4nbg20xW3qoBLTq4ZY7AW15rCD3dOmEu0lnah5sVwZ8jNqgWMt8wHpaGc
         apfFQJTg/i6jezvi/H1mVghfw8KjYK5WVzg5Z5he574QO5jUvzYIcgEXHnZMJCz65rCQ
         Vc0aQaR/NG/Q8u0fBDSlvjM4tTup9Q1tRGTzeNuHssvrRb4qKYRx611hSUhe/hc6LLPl
         ldVT0e4QsPs3NQ6q/zOYdY9rQZLY2J2NkXf4xeZcXU3EN4o6fSyh19/Wm/FOlr4eiJTE
         R5kg==
X-Gm-Message-State: AOAM532X4qni2ffEBaE4Qm9ykM+5zFZpY3jbMKELjWD8q7Hf6KUTiLH7
        thjYbsFWok53TDJUmV7cxA==
X-Google-Smtp-Source: ABdhPJx9TVZlSTriEOcPu+y1bXUWIWmA8WK4eIs83drHb2BEbfukR4hcMW8BKRsqjVpo9ofJ1PbzsQ==
X-Received: by 2002:a05:6808:1494:: with SMTP id e20mr260053oiw.111.1629750408451;
        Mon, 23 Aug 2021 13:26:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b11sm3560434ooi.0.2021.08.23.13.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 13:26:48 -0700 (PDT)
Received: (nullmailer pid 2662470 invoked by uid 1000);
        Mon, 23 Aug 2021 20:26:42 -0000
Date:   Mon, 23 Aug 2021 15:26:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/3] libperf tests: Fix verbose printing
Message-ID: <YSQEghUuFobZN5T+@robh.at.kernel.org>
References: <20210820093908.734503-1-nakamura.shun@fujitsu.com>
 <20210820093908.734503-3-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820093908.734503-3-nakamura.shun@fujitsu.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 20, 2021 at 06:39:07PM +0900, Shunsuke Nakamura wrote:
> libperf's verbose printing checks the -v option every time the macro _T_ START

__T_START

> is called.
> 
> Since there are currently four libperf tests registered, the macro _T_ START is
> called four times, but verbose printing after the second time is not output.
> 
> Resets the index of the element processed by getopt() and fix verbose printing
> so that it prints in all tests.
> 
> Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> ---
>  tools/lib/perf/include/internal/tests.h | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/tools/lib/perf/include/internal/tests.h b/tools/lib/perf/include/internal/tests.h
> index 61052099225b..b130a6663ff8 100644
> --- a/tools/lib/perf/include/internal/tests.h
> +++ b/tools/lib/perf/include/internal/tests.h
> @@ -23,6 +23,8 @@ static inline int get_verbose(char **argv, int argc)
>  			break;
>  		}
>  	}
> +	optind = 1;
> +
>  	return verbose;
>  }
>  
> -- 
> 2.25.1
> 
> 
