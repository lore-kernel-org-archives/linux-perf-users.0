Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1D8C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 12:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15FC861371
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 12:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJTMsR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230523AbhJTMro (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Oct 2021 08:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634733929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rueOf8KMpS3z3LUq01QHzmR1IIrXiaimKXs4I9trnHY=;
        b=UDfDvXEYQpAMOmUlmI79xascJdihBHlfCytUQ1j0mD+tY6U60GLMahlOqnTdh3i4YPCytl
        YovOb3j5YlrS6uTsBr084dhvpG0djUGoX1lmRWq2L3oyc0z2TIFlIi5QrbJlpbOGsR63j8
        y7B9Uk4/1Q3C238ZhZkg4wfPDT1f04A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-lQ3iIoXVMHWoVcKVJ2bhIQ-1; Wed, 20 Oct 2021 08:45:28 -0400
X-MC-Unique: lQ3iIoXVMHWoVcKVJ2bhIQ-1
Received: by mail-ed1-f72.google.com with SMTP id i7-20020a50d747000000b003db0225d219so16249709edj.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Oct 2021 05:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rueOf8KMpS3z3LUq01QHzmR1IIrXiaimKXs4I9trnHY=;
        b=F/9e2lnyFpoGndIuwTLhz7tMSrXSreOIP3UMuHxy4xOCPyg4wB9YoI8IVunyTDHofP
         wJ7cFlvXY5CNSA3Q6cT2SZ4OH1IbewoltkJ6oAhAgkj5d9wJCFhqL8ianaLGdpJ1auZc
         avPOnWNfBMYODLOo4LnItqQFiTZaou49kp030k2XXf0N2fjgyr3PJkOHdAmKCps9B7JV
         WQTr3XjM/eRQ63nciNdYogQ/JS+ZhwOaTB7p9tKxFUpfUZxVZvuntx5l5BrEQ/s4fBp/
         wH6ky+fE5aiFIbRgkSeD14tbzQzfA5rwoRamBxQ38UUhA4Z4Rh3h9L5iDt3YTk/oHsIO
         bYpw==
X-Gm-Message-State: AOAM531AL2hz7PreAUazXqzfsPmiCf3hTer9Xa3qVYJ6w9lwEdsInR1q
        8DNKyXPgWVLWH7v+AhfgSCuxVaL1qbd8fZ2PQ6ZgrBk4szQV9kVBLIMhgrwlaycEf5DXzWj9ezY
        adO22aV4UpIGRsPBj3wstWI3Ey7lt3w==
X-Received: by 2002:a05:6402:4382:: with SMTP id o2mr61174619edc.271.1634733927239;
        Wed, 20 Oct 2021 05:45:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmy5cJWgtyOctz3iJSnO1cHrn2IZwnI/RCoU3YuPfySGWKKfdgaTx1xq03MiP89ErGyByL5w==
X-Received: by 2002:a05:6402:4382:: with SMTP id o2mr61174572edc.271.1634733926935;
        Wed, 20 Oct 2021 05:45:26 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id x16sm1031298ejj.8.2021.10.20.05.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 05:45:26 -0700 (PDT)
Date:   Wed, 20 Oct 2021 14:45:24 +0200
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
Subject: Re: [PATCH v2 11/22] perf test: Convert watch point tests to test
 cases.
Message-ID: <YXAPZIKwHbnLOL4b@krava>
References: <20211013174604.747276-1-irogers@google.com>
 <20211013174604.747276-12-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013174604.747276-12-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Oct 13, 2021 at 10:45:53AM -0700, Ian Rogers wrote:
> Use null terminated array of test cases rather than the previous sub
> test functions.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/wp.c | 128 ++++++++++--------------------------------
>  1 file changed, 30 insertions(+), 98 deletions(-)
> 
> diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
> index 904bdf2dcf81..2c0513257b15 100644
> --- a/tools/perf/tests/wp.c
> +++ b/tools/perf/tests/wp.c
> @@ -62,8 +62,12 @@ static int __event(int wp_type, void *wp_addr, unsigned long wp_len)
>  	return fd;
>  }
>  
> -static int wp_ro_test(void)
> +static int test__wp_ro(struct test_suite *test __maybe_unused,
> +		       int subtest __maybe_unused)
>  {
> +#if defined(__s390x__) || defined(__x86_64__) || defined(__i386__)
> +	return TEST_SKIP;
> +#else
>  	int fd;
>  	unsigned long tmp, tmp1 = rand();
>  
> @@ -79,10 +83,15 @@ static int wp_ro_test(void)
>  
>  	close(fd);
>  	return 0;
> +#endif
>  }
>  
> -static int wp_wo_test(void)
> +static int test__wp_wo(struct test_suite *test __maybe_unused,
> +		       int subtest __maybe_unused)
>  {
> +#if defined(__s390x__)
> +	return TEST_SKIP;
> +#else
>  	int fd;
>  	unsigned long tmp, tmp1 = rand();
>  
> @@ -98,10 +107,15 @@ static int wp_wo_test(void)
>  
>  	close(fd);
>  	return 0;
> +#endif
>  }
>  
> -static int wp_rw_test(void)
> +static int test__wp_rw(struct test_suite *test __maybe_unused,
> +		       int subtest __maybe_unused)
>  {
> +#if defined(__s390x__)
> +	return TEST_SKIP;
> +#else
>  	int fd;
>  	unsigned long tmp, tmp1 = rand();
>  
> @@ -118,10 +132,15 @@ static int wp_rw_test(void)
>  
>  	close(fd);
>  	return 0;
> +#endif
>  }
>  
> -static int wp_modify_test(void)
> +static int test__wp_modify(struct test_suite *test __maybe_unused,
> +			   int subtest __maybe_unused)
>  {
> +#if defined(__s390x__)
> +	return TEST_SKIP;
> +#else
>  	int fd, ret;
>  	unsigned long tmp = rand();
>  	struct perf_event_attr new_attr;
> @@ -163,105 +182,18 @@ static int wp_modify_test(void)
>  
>  	close(fd);
>  	return 0;
> -}
> -
> -static bool wp_ro_supported(void)
> -{
> -#if defined (__x86_64__) || defined (__i386__)
> -	return false;
> -#else
> -	return true;
> -#endif
> -}
> -
> -static const char *wp_ro_skip_msg(void)
> -{
> -#if defined (__x86_64__) || defined (__i386__)
> -	return "missing hardware support";
> -#else
> -	return NULL;
>  #endif
>  }
>  
> -static struct {
> -	const char *desc;
> -	int (*target_func)(void);
> -	bool (*is_supported)(void);
> -	const char *(*skip_msg)(void);
> -} wp_testcase_table[] = {
> -	{
> -		.desc = "Read Only Watchpoint",
> -		.target_func = &wp_ro_test,
> -		.is_supported = &wp_ro_supported,
> -		.skip_msg = &wp_ro_skip_msg,
> -	},
> -	{
> -		.desc = "Write Only Watchpoint",
> -		.target_func = &wp_wo_test,
> -	},
> -	{
> -		.desc = "Read / Write Watchpoint",
> -		.target_func = &wp_rw_test,
> -	},
> -	{
> -		.desc = "Modify Watchpoint",
> -		.target_func = &wp_modify_test,
> -	},
> +static struct test_case wp_tests[] = {
> +	TEST_CASE_REASON("Read Only Watchpoint", wp_ro, "missing hardware support"),
> +	TEST_CASE_REASON("Write Only Watchpoint", wp_wo, "missing hardware support"),
> +	TEST_CASE_REASON("Read / Write Watchpoint", wp_rw, "missing hardware support"),
> +	TEST_CASE_REASON("Modify Watchpoint", wp_modify, "missing hardware support"),
> +	{ .name = NULL, }
>  };
>  
> -static int test__wp_subtest_get_nr(void)
> -{
> -	return (int)ARRAY_SIZE(wp_testcase_table);
> -}
> -
> -static const char *test__wp_subtest_get_desc(int i)
> -{
> -	if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
> -		return NULL;
> -	return wp_testcase_table[i].desc;
> -}
> -
> -static const char *test__wp_subtest_skip_reason(int i)
> -{
> -	if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
> -		return NULL;
> -	if (!wp_testcase_table[i].skip_msg)
> -		return NULL;
> -	return wp_testcase_table[i].skip_msg();
> -}
> -
> -static int test__wp(struct test_suite *test __maybe_unused, int i)
> -{
> -	if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
> -		return TEST_FAIL;
> -
> -	if (wp_testcase_table[i].is_supported &&
> -	    !wp_testcase_table[i].is_supported())
> -		return TEST_SKIP;
> -
> -	return !wp_testcase_table[i].target_func() ? TEST_OK : TEST_FAIL;
> -}
> -
> -/* The s390 so far does not have support for
> - * instruction breakpoint using the perf_event_open() system call.
> - */
> -static bool test__wp_is_supported(void)
> -{
> -#if defined(__s390x__)
> -	return false;
> -#else
> -	return true;
> -#endif
> -}
> -
>  struct test_suite suite__wp = {
>  	.desc = "Watchpoint",
> -	.func = test__wp,
> -	.is_supported = test__wp_is_supported,

hm, why do we get rid of this callback and instead use #ifdef 3 times above?

jirka

> -	.subtest = {
> -		.skip_if_fail	= false,
> -		.get_nr		= test__wp_subtest_get_nr,
> -		.get_desc	= test__wp_subtest_get_desc,
> -		.skip_reason    = test__wp_subtest_skip_reason,
> -	},
> +	.test_cases = wp_tests,
>  };
> -- 
> 2.33.0.882.g93a45727a2-goog
> 

