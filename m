Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D15C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 12:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB86E6135E
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 12:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhJTMhB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53560 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230189AbhJTMhA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Oct 2021 08:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634733285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CWo7Mu1LgbVcoVhIHgDtxt4QkLrq2mjDYhM5i0I36Fc=;
        b=OmrW12Xrxio2kKNgftmiNqOZ4wd3U6M3wZzlGKXNe5KL6PsS9hIKXNLbuaAPNTqFZAdKtH
        m8n4gbzni4eNXWLx4vBcuBjQhZkcKQIo7Rts2V1mJMF5zbvw4tVnJYz1DkrBFPiYIjWQZi
        lK1b6nCe00hImS9l1jc9rBgIMgrGYvQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-4B1-GEcUM7CA15lB8d0mZA-1; Wed, 20 Oct 2021 08:34:42 -0400
X-MC-Unique: 4B1-GEcUM7CA15lB8d0mZA-1
Received: by mail-ed1-f71.google.com with SMTP id l10-20020a056402230a00b003db6977b694so20821945eda.23
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Oct 2021 05:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CWo7Mu1LgbVcoVhIHgDtxt4QkLrq2mjDYhM5i0I36Fc=;
        b=kug00V8ZoDV0NEw8g3kBO9xzoe5F7nFY7FXlXkus3SROYeqZ/le73cIW65Sais+reY
         9n6Or3uSV5lTcpW3HJAY6++vWnSPUL69ZtjCPpsJyWiulHrkkcBPAi3Ibzd0WhOvM5uV
         yI1hAc7b7/FKYWwbqUhlH6FKB2c3Myfc70YiNXbEieFB+VdLHzPpguYtwS2YFGVm8SBi
         uHvYgHrewCFNcdfsGE1KVCfHqISt8U4iZP43wZkSIGZZXLRt1T+3xzrOVngdKSilC4aY
         Vc/JjEJXxBMt81xzOsONMdNKu/dG0/K8C6LZSavEi2oFl9ssXAvYnXoY65Yep2KKiT2h
         8Uyw==
X-Gm-Message-State: AOAM532q7O1SXzvUYVEXoevWc09OutlR9KzOrY1vk9b20Ql37x037TTD
        SvAESbOfZsgyRXI6S++/3OkWlGoOp4AX6SHbe+ZmBC5ZtsOii72Ka9nOfggb6Q+DrZemR8duNgA
        SAWuTdNVhwwJ2QJm+8FpE+BhSxkLTfg==
X-Received: by 2002:a17:907:c22:: with SMTP id ga34mr43230112ejc.380.1634733281434;
        Wed, 20 Oct 2021 05:34:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpL7lpBsDFsNSZbROWL3gXO2SPB4mMKZakczxEZ7WBtzg0oR0ugQxn8GUdpy5+09Vh74R/Bg==
X-Received: by 2002:a17:907:c22:: with SMTP id ga34mr43230087ejc.380.1634733281247;
        Wed, 20 Oct 2021 05:34:41 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id e30sm987114ejl.117.2021.10.20.05.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 05:34:40 -0700 (PDT)
Date:   Wed, 20 Oct 2021 14:34:39 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>, eranian@google.com
Subject: Re: [PATCH v2 06/22] perf test: Add helper functions for abstraction.
Message-ID: <YXAM31HKzS4/qJw/@krava>
References: <20211013174604.747276-1-irogers@google.com>
 <20211013174604.747276-7-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013174604.747276-7-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Oct 13, 2021 at 10:45:48AM -0700, Ian Rogers wrote:

SNIP

>  	else
>  		pr_debug("%s subtest %d:", t->desc, subtest + 1);
> @@ -218,11 +257,10 @@ static int test_and_print(struct test_suite *t, bool force_skip, int subtest)
>  		pr_info(" Ok\n");
>  		break;
>  	case TEST_SKIP: {
> -		const char *skip_reason = NULL;
> -		if (t->subtest.skip_reason)
> -			skip_reason = t->subtest.skip_reason(subtest);
> -		if (skip_reason)
> -			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (%s)\n", skip_reason);
> +		const char *reason = skip_reason(t, subtest);
> +
> +		if (reason)
> +			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (%s)\n", reason);
>  		else
>  			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip\n");
>  	}
> @@ -397,7 +435,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>  	int width = shell_tests__max_desc_width();
>  
>  	for_each_test(j, k, t) {
> -		int len = strlen(t->desc);
> +		int len = strlen(test_description(t, -1));
>  
>  		if (width < len)
>  			width = len;
> @@ -407,17 +445,15 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>  		int curr = i++, err;
>  		int subi;
>  
> -		if (!perf_test__matches(t->desc, curr, argc, argv)) {
> +		if (!perf_test__matches(test_description(t, -1), curr, argc, argv)) {
>  			bool skip = true;
>  			int subn;
>  
> -			if (!t->subtest.get_nr)
> -				continue;
> -
> -			subn = t->subtest.get_nr();
> +			subn = num_subtests(t);

should you call continue on !subn ?

jirka

>  
>  			for (subi = 0; subi < subn; subi++) {
> -				if (perf_test__matches(t->subtest.get_desc(subi), curr, argc, argv))
> +				if (perf_test__matches(test_description(t, subi),
> +							curr, argc, argv))
>  					skip = false;
>  			}
>  
> @@ -425,22 +461,23 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>  				continue;
>  		}
>  

SNIP

