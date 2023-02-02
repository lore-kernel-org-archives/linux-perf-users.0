Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF6CC636CD
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Feb 2023 00:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjBBA56 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Feb 2023 19:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBBA55 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Feb 2023 19:57:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521CE5C0ED
        for <linux-perf-users@vger.kernel.org>; Wed,  1 Feb 2023 16:57:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04130B82396
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Feb 2023 00:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0B3C433D2;
        Thu,  2 Feb 2023 00:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675299472;
        bh=s42/VVaCIYQ0nI3ZhFObWiwS/t5JoeInmu8DKR5/Gvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u24iMQwqDSuzKZUdgG4vRc5KYHyIRIAXyne/t58zIEX0bNEE3TvoQ6BFouO3wn+S7
         fJt4S+81W6EAnIprfJzDdBzVc39e+520QTJqFfp3zVkFD9ONRKILhpB+KvwR/lt+Qh
         MA4I3m9uTqWbuJZ1fdDZSv9vbKjBwTvQtILUniBzpv1k0w+dS4vCe3u9bQVEz7litB
         PdL82IekoPyqW5vFSp1Q4yu7ndewa0vFnAAPSuX54bXTe3sKH23c08OtaTAblL2sz2
         IojsSC5V3gqi4HSQ3aXAMXpwga1RWjWSBm0VMGWMcXPCZ4zpeTO2gj87tCBQFWERaz
         0gPk+cvQAhkdQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7F094405BE; Wed,  1 Feb 2023 21:57:49 -0300 (-03)
Date:   Wed, 1 Feb 2023 21:57:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     jolsa@kernel.org, ak@linux.intel.com, namhyung@kernel.org,
        irogers@google.com, james.clark@arm.com, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.ibm.com
Subject: Re: [PATCH] tests/bpf: Fix the bpf test to check for libtraceevent
 support
Message-ID: <Y9sKjYV8b37vstQ0@kernel.org>
References: <20230131135001.54578-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131135001.54578-1-atrajeev@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jan 31, 2023 at 07:20:01PM +0530, Athira Rajeev escreveu:
> "bpf" tests fails in environment with missing libtraceevent
> support as below:
> 
>  # ./perf test 36
>  36: BPF filter                                                      :
>  36.1: Basic BPF filtering                                           : FAILED!
>  36.2: BPF pinning                                                   : FAILED!
>  36.3: BPF prologue generation                                       : FAILED!
> 
> The environment has clang but missing the libtraceevent
> devel. Hence perf is compiled without libtraceevent support.

Thanks, applied.

- Arnaldo

 
> Detailed logs:
> 	./perf test -v "Basic BPF filtering"
> 
> 	Failed to add BPF event syscalls:sys_enter_epoll_pwait
> 	bpf: tracepoint call back failed, stop iterate
> 	Failed to add events selected by BPF
> 
> The bpf tests tris to add probe event which fails
> at "parse_events_add_tracepoint" function due to missing
> libtraceevent. Add check for "HAVE_LIBTRACEEVENT" in the
> "tests/bpf.c" before proceeding with the test.
> 
> With the change,
> 
> 	# ./perf test 36
>  	36: BPF filter                                                      :
>  	36.1: Basic BPF filtering                                           : Skip (not compiled in or missing libtraceevent support)
>  	36.2: BPF pinning                                                   : Skip (not compiled in or missing libtraceevent support)
>  	36.3: BPF prologue generation                                       : Skip (not compiled in or missing libtraceevent support)
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/tests/bpf.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> index 17c023823713..4af39528f611 100644
> --- a/tools/perf/tests/bpf.c
> +++ b/tools/perf/tests/bpf.c
> @@ -23,7 +23,7 @@
>  #define NR_ITERS       111
>  #define PERF_TEST_BPF_PATH "/sys/fs/bpf/perf_test"
>  
> -#ifdef HAVE_LIBBPF_SUPPORT
> +#if defined(HAVE_LIBBPF_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
>  #include <linux/bpf.h>
>  #include <bpf/bpf.h>
>  
> @@ -330,10 +330,10 @@ static int test__bpf(int i)
>  static int test__basic_bpf_test(struct test_suite *test __maybe_unused,
>  				int subtest __maybe_unused)
>  {
> -#ifdef HAVE_LIBBPF_SUPPORT
> +#if defined(HAVE_LIBBPF_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
>  	return test__bpf(0);
>  #else
> -	pr_debug("Skip BPF test because BPF support is not compiled\n");
> +	pr_debug("Skip BPF test because BPF or libtraceevent support is not compiled\n");
>  	return TEST_SKIP;
>  #endif
>  }
> @@ -341,10 +341,10 @@ static int test__basic_bpf_test(struct test_suite *test __maybe_unused,
>  static int test__bpf_pinning(struct test_suite *test __maybe_unused,
>  			     int subtest __maybe_unused)
>  {
> -#ifdef HAVE_LIBBPF_SUPPORT
> +#if defined(HAVE_LIBBPF_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
>  	return test__bpf(1);
>  #else
> -	pr_debug("Skip BPF test because BPF support is not compiled\n");
> +	pr_debug("Skip BPF test because BPF or libtraceevent support is not compiled\n");
>  	return TEST_SKIP;
>  #endif
>  }
> @@ -352,17 +352,17 @@ static int test__bpf_pinning(struct test_suite *test __maybe_unused,
>  static int test__bpf_prologue_test(struct test_suite *test __maybe_unused,
>  				   int subtest __maybe_unused)
>  {
> -#if defined(HAVE_LIBBPF_SUPPORT) && defined(HAVE_BPF_PROLOGUE)
> +#if defined(HAVE_LIBBPF_SUPPORT) && defined(HAVE_BPF_PROLOGUE) && defined(HAVE_LIBTRACEEVENT)
>  	return test__bpf(2);
>  #else
> -	pr_debug("Skip BPF test because BPF support is not compiled\n");
> +	pr_debug("Skip BPF test because BPF or libtraceevent support is not compiled\n");
>  	return TEST_SKIP;
>  #endif
>  }
>  
>  
>  static struct test_case bpf_tests[] = {
> -#ifdef HAVE_LIBBPF_SUPPORT
> +#if defined(HAVE_LIBBPF_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
>  	TEST_CASE("Basic BPF filtering", basic_bpf_test),
>  	TEST_CASE_REASON("BPF pinning", bpf_pinning,
>  			"clang isn't installed or environment missing BPF support"),
> @@ -373,9 +373,9 @@ static struct test_case bpf_tests[] = {
>  	TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test, "not compiled in"),
>  #endif
>  #else
> -	TEST_CASE_REASON("Basic BPF filtering", basic_bpf_test, "not compiled in"),
> -	TEST_CASE_REASON("BPF pinning", bpf_pinning, "not compiled in"),
> -	TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test, "not compiled in"),
> +	TEST_CASE_REASON("Basic BPF filtering", basic_bpf_test, "not compiled in or missing libtraceevent support"),
> +	TEST_CASE_REASON("BPF pinning", bpf_pinning, "not compiled in or missing libtraceevent support"),
> +	TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test, "not compiled in or missing libtraceevent support"),
>  #endif
>  	{ .name = NULL, }
>  };
> -- 
> 2.39.0
> 

-- 

- Arnaldo
