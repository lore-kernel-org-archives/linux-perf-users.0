Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C70CC4338F
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 18:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23E406109E
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 18:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhHKSlI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 11 Aug 2021 14:41:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhHKSlH (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 11 Aug 2021 14:41:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8874A6104F;
        Wed, 11 Aug 2021 18:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628707243;
        bh=6FBya3zd7+WtAeRn1jjfYTE4KY3Ha+15NLGh2e389sI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qwETC8ifPyPMBBlkwetsJmwmCnctosRPgsVEt1NST5M3HpQQrseFW/52NQBIvMhOw
         OEGPaB5r5KBU9m2o7WSvamA1NJ3er7lC7SBDa+cpvq7l7ZEV3+qRZ3uuNnFodh8lDU
         R1LG1eUcwAjtkjKXIbQEuDad0zLGZftfBPbiDmyoKzq2q0Th/l4qKd7zO4vbC8L7q0
         yzbj/1iWIXc/YdfLcOqGtoC2KX6BHnTUn0OppGbYiX4Ywha3ZbUPpFldALOmRVYr23
         4Pjr10G/MsClNEk4fdtbsEVHEIlUEGOB5oEbIZaMu6PKSUaQyesCg7igDFj7oxZHZV
         ZF0a9cdVQ7syg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A5696403F2; Wed, 11 Aug 2021 15:40:40 -0300 (-03)
Date:   Wed, 11 Aug 2021 15:40:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf test: make --skip work on shell tests
Message-ID: <YRQZqOH9JLGAX6NE@kernel.org>
References: <20210811180625.160944-1-rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811180625.160944-1-rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Aug 11, 2021 at 08:06:26PM +0200, Riccardo Mancini escreveu:
> perf-test has the option --skip to provide a list of tests to skip.
> However, this option does not work with shell scripts.
> 
> This patch passes the skiplist to run_shell_tests, so that also shell
> scripts could be skipped using --skip.

In such cases please provide an example of the usage you're fixing, what
was it that you tried that didn't work and that now works?

Its obviously a fix, so I'm applying it.

- Arnaldo
 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/tests/builtin-test.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 5e6242576236325c..fb4a75cc8fa9530e 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -594,7 +594,8 @@ static int shell_test__run(struct test *test, int subdir __maybe_unused)
>  	return WEXITSTATUS(err) == 2 ? TEST_SKIP : TEST_FAIL;
>  }
>  
> -static int run_shell_tests(int argc, const char *argv[], int i, int width)
> +static int run_shell_tests(int argc, const char *argv[], int i, int width,
> +				struct intlist *skiplist)
>  {
>  	struct dirent **entlist;
>  	struct dirent *ent;
> @@ -628,6 +629,12 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width)
>  
>  		st.file = ent->d_name;
>  		pr_info("%2d: %-*s:", i, width, test.desc);
> +
> +		if (intlist__find(skiplist, i)) {
> +			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
> +			continue;
> +		}
> +
>  		test_and_print(&test, false, -1);
>  	}
>  
> @@ -727,7 +734,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>  		}
>  	}
>  
> -	return run_shell_tests(argc, argv, i, width);
> +	return run_shell_tests(argc, argv, i, width, skiplist);
>  }
>  
>  static int perf_test__list_shell(int argc, const char **argv, int i)
> -- 
> 2.31.1
> 

-- 

- Arnaldo
