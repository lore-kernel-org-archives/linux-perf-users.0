Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63358C48BC2
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 17:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370D96008E
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 17:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhF0RVY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Jun 2021 13:21:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46596 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230321AbhF0RVY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Jun 2021 13:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624814339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nO1HYtUGepaP54RHNLOYpWbEr/WXtbWrhjQVbsu7bwY=;
        b=Cf16ikJgVDDoFemthT9xvdmut9DwCRjpV7Ri3nti7h5aR2c4EXLaGw8KKrlbkCm1Vs2Akw
        8xRIQutJKC9V1TJ9rCfcnN4KW1X36UyB2ed9SYP5OS6NltlxBlIPK4jspC1/q0VIETlcyz
        /XYKydOQq0+Av66RvH3Vva8gJshAUT0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-owbuNkRaPHu16AehJbcEpA-1; Sun, 27 Jun 2021 13:18:57 -0400
X-MC-Unique: owbuNkRaPHu16AehJbcEpA-1
Received: by mail-ed1-f69.google.com with SMTP id t11-20020a056402524bb029038ffacf1cafso8082907edd.5
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Jun 2021 10:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nO1HYtUGepaP54RHNLOYpWbEr/WXtbWrhjQVbsu7bwY=;
        b=qGNGCuWnYFnTu6efLp2b37xha4bNE3SwAUqmCnOAI5WBiuUpRr8NQ2dX1uDbkWV9wM
         oG6VqUEqEKkVxVx8X3ldT14o+O/gEYkU4j68aPbnVfkG7KDb18fp19rrj4rnyydstrDf
         NQwgo1ul912nJovUhEYyJu7aiX/laS9Zinv/450wqO59l4Jjy+07w6mhohwmdBrJMpMP
         22jUfJW91/bH4WAa7oAG8vtI9sOHMCK/aTEDFSI+w+I17N3rMhtkHIO1Bw4tv9ZMhyxy
         xKTwZjnXIK1l3bLEbwQJ7PeVz3wHHHwU1V+4lYvzFwjWrhnT0tMKsN7s3HPGT2xhzKxr
         36fA==
X-Gm-Message-State: AOAM533CBmxggSmNcFyQtUG8zrDUlUjkRvoBPpO3m4bssVsANO4RQX/1
        5pEA9fbeNRV5Zr5FrbHCCQM5uIYceNvpZxsPSEQpwYwDoKLe4Yn1BXZkas4Viz7hHVixqassmGX
        W08Yy2BIB9mdEewxr29413Y0K4nIH1A==
X-Received: by 2002:a05:6402:849:: with SMTP id b9mr19940325edz.270.1624814334977;
        Sun, 27 Jun 2021 10:18:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5xbSlYE2H+MlqNjRgjX+573f7yhaT6i5TZnhF0wBUpzGsjvyIkx9wF5Wa016IbJXJMu/P1A==
X-Received: by 2002:a05:6402:849:: with SMTP id b9mr19940309edz.270.1624814334803;
        Sun, 27 Jun 2021 10:18:54 -0700 (PDT)
Received: from krava ([5.171.209.125])
        by smtp.gmail.com with ESMTPSA id d25sm8400554edu.83.2021.06.27.10.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 10:18:54 -0700 (PDT)
Date:   Sun, 27 Jun 2021 19:18:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Eirik Fuller <efuller@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, acme@redhat.com,
        mpetlan@redhat.com
Subject: Re: [PATCH] perf test: Handle fd gaps in test__dso_data_reopen
Message-ID: <YNiy+4fXtB/YAHBU@krava>
References: <20210626023825.1398547-1-efuller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626023825.1398547-1-efuller@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 25, 2021 at 10:38:25PM -0400, Eirik Fuller wrote:
> https://github.com/beaker-project/restraint/issues/215 describes a file
> descriptor leak which revealed the test failure described here.
> 
> The 'DSO data reopen' perf test assumes that RLIMIT_NOFILE limits the
> number of open file descriptors, but it actually limits newly opened
> file descriptors. When the file descriptor limit is reduced, file
> descriptors already open remain open regardless of the new limit. This
> test failure does not occur if open file descriptors are contiguous,
> beginning at zero.
> 
> The following command triggers this perf test failure.
> 
> perf test 'DSO data reopen' 3>/dev/null 8>/dev/null
> 
> This patch determines the file descriptor limit by opening four files
> and then closing them. The limit is set to the fourth file descriptor,
> leaving only the first three available because any newly opened file
> descriptor must be less than the limit.
> 
> Signed-off-by: Eirik Fuller <efuller@redhat.com>
> ---
>  tools/perf/tests/dso-data.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
> index 627c1aaf1c9e..43e1b01e5afc 100644
> --- a/tools/perf/tests/dso-data.c
> +++ b/tools/perf/tests/dso-data.c
> @@ -308,10 +308,20 @@ int test__dso_data_cache(struct test *test __maybe_unused, int subtest __maybe_u
>  	return 0;
>  }
>  
> +static long new_limit(int count)
> +{
> +	int fd = open("/dev/null", O_RDONLY);
> +	long ret = fd;
> +	if (count > 0)
> +		ret = new_limit(--count);
> +	close(fd);
> +	return ret;
> +}

nice idea.. thanks

Acked-by: Jiri Olsa <jolsa@redhat.com>

jirka

> +
>  int test__dso_data_reopen(struct test *test __maybe_unused, int subtest __maybe_unused)
>  {
>  	struct machine machine;
> -	long nr_end, nr = open_files_cnt();
> +	long nr_end, nr = open_files_cnt(), lim = new_limit(3);
>  	int fd, fd_extra;
>  
>  #define dso_0 (dsos[0])
> @@ -334,7 +344,7 @@ int test__dso_data_reopen(struct test *test __maybe_unused, int subtest __maybe_
>  
>  	/* Make sure we are able to open 3 fds anyway */
>  	TEST_ASSERT_VAL("failed to set file limit",
> -			!set_fd_limit((nr + 3)));
> +			!set_fd_limit((lim)));
>  
>  	TEST_ASSERT_VAL("failed to create dsos\n", !dsos__create(3, TEST_FILE_SIZE));
>  
> -- 
> 2.27.0
> 

