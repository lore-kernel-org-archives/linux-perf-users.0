Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61F2C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 13:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC43D60249
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 13:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhJTNIt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Oct 2021 09:08:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52785 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229998AbhJTNIs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Oct 2021 09:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634735194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F2gH7rb7/m5w1MSubEzeVAyg/+4ulkXtrUYC/5EhnAA=;
        b=KENZlkOnGSCf0DFjskKgvVzlq1KIIR6siftKGZbJtUoKTKnOgr2bRaxVoZ4ZM1jjqv73+V
        1rKx5ukLFXZ/DFNOz3dfzq5BZbtDRUTlNgnWItcP2pUX9VAiJO9xLqebfiIc5HYML2OQgY
        WdtpeyMTr6pVx+3v+wWdz7wusrvXb3A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-vgMAvhh6Pq6KIYFeNXFVQQ-1; Wed, 20 Oct 2021 09:06:32 -0400
X-MC-Unique: vgMAvhh6Pq6KIYFeNXFVQQ-1
Received: by mail-ed1-f71.google.com with SMTP id r25-20020a05640216d900b003dca3501ab4so4479446edx.15
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Oct 2021 06:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F2gH7rb7/m5w1MSubEzeVAyg/+4ulkXtrUYC/5EhnAA=;
        b=6KDTEOFuXMCvipHOaUYyn3VgoXSYCNtocSKTHh7mTag/yd0tu4o9Dx0KUdprWYKNy4
         0qznu1OgfY1mbhnLCcRRS7En+EpdDQ4p874lxB5EPuL+Gah1JAvX/pepoEI1ciCaHqUu
         6tbu4cGWb/Mc59WksEQhUYezFC+G/L5G4nrcSt1FDafiqII6nMuegfAVZHQUmYl4HOMY
         lzLLYInlnI5QQGUd0buh5fAyInvV6OlttevkCFZntry5hKjynzNHaqG9ut8sZbup2S1b
         E8fDQvgZILnIqofkNZe2uWRYbo8I8rOP3ABtNnGqQoj0BfBjKDeEVN8T9j3p6PnyPkSI
         RM0Q==
X-Gm-Message-State: AOAM530DkuFr7oCZqKr7JBQRvi0UYq7WcQYpisWzCS5THjEomEJNctGU
        fLqU3OYWaNSlJHzGTIhF/L6NdQ3IZRISwXhjNDzPyQgWB7jpawtXjtAlU+uvjql977BG+6j3AN5
        KbAevJmKECGBE2Kf8a0wRNpMf3JNJbg==
X-Received: by 2002:a05:6402:3554:: with SMTP id f20mr62789708edd.354.1634735191142;
        Wed, 20 Oct 2021 06:06:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzew6vEv7MbBQdtbRq7+Y/PNegbNzQ9IdbBjC4Yk1ALEtf96492aeUApmo/qQzoSbe9tY969A==
X-Received: by 2002:a05:6402:3554:: with SMTP id f20mr62789681edd.354.1634735190914;
        Wed, 20 Oct 2021 06:06:30 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id b26sm1047355ejl.82.2021.10.20.06.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:06:30 -0700 (PDT)
Date:   Wed, 20 Oct 2021 15:06:28 +0200
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
Subject: Re: [PATCH v2 21/22] perf test: Remove is_supported function
Message-ID: <YXAUVJgFqcxYoiaa@krava>
References: <20211013174604.747276-1-irogers@google.com>
 <20211013174604.747276-22-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013174604.747276-22-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Oct 13, 2021 at 10:46:03AM -0700, Ian Rogers wrote:
> All tests now return TEST_SKIP if not supported. Removing this function
> brings perf's test_suite struct more inline with kunit.

ah ok, forget my previous comment then ;-)

jirka

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/builtin-test.c | 14 +-------------
>  tools/perf/tests/tests.h        |  1 -
>  2 files changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 966948cacba3..086641f60015 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -150,11 +150,6 @@ static const char *test_description(const struct test_suite *t, int subtest)
>  	return t->desc;
>  }
>  
> -static bool is_supported(const struct test_suite *t)
> -{
> -	return !t->is_supported || t->is_supported();
> -}
> -
>  static test_fnptr test_function(const struct test_suite *t, int subtest)
>  {
>  	if (subtest <= 0)
> @@ -480,12 +475,6 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>  				continue;
>  		}
>  
> -		if (!is_supported(t)) {
> -			pr_debug("%2d: %-*s: Disabled\n", i, width,
> -				 test_description(t, -1));
> -			continue;
> -		}
> -
>  		pr_info("%2d: %-*s:", i, width, test_description(t, -1));
>  
>  		if (intlist__find(skiplist, i)) {
> @@ -583,8 +572,7 @@ static int perf_test__list(int argc, const char **argv)
>  	for_each_test(j, k, t) {
>  		int curr = i++;
>  
> -		if (!perf_test__matches(test_description(t, -1), curr, argc, argv) ||
> -		    !is_supported(t))
> +		if (!perf_test__matches(test_description(t, -1), curr, argc, argv))
>  			continue;
>  
>  		pr_info("%2d: %s\n", i, test_description(t, -1));
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 958f94dcc94c..15051801c790 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -44,7 +44,6 @@ struct test_suite {
>  		bool skip_if_fail;
>  	} subtest;
>  	struct test_case *test_cases;
> -	bool (*is_supported)(void);
>  	void *priv;
>  };
>  
> -- 
> 2.33.0.882.g93a45727a2-goog
> 

