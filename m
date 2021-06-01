Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450F6C47080
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 13:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18F2B613AE
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 13:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhFANj0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Jun 2021 09:39:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233584AbhFANj0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Jun 2021 09:39:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 636CC61263;
        Tue,  1 Jun 2021 13:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622554664;
        bh=pkFlErKqCbMKfuoBC4+Cn0CMLj9ZRkztvcHyPpIn5L0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VH4nF+u0ltS3vwi4R55bofpmRvLFeHe3SG8sVb2sAEArEdSxUI4ZjA5R7Iml+j7uw
         L0gYNIV0OM9dO2g9YGEMvYX58cQ5sgaJLXBdmSdR5B7rTW/7fIcXwnDXigzJJOHNSK
         O9O464pO67RZADXp09JWscqiZx6LxIQTqfF8jXENL5FCG3aqzQ4jzYrp0jfPxxyG/a
         8MVC5pA+ByenUlfLOc6RM+uxyANO04YLGQz5BYZBhxGfMcde8WaxlgB96rUSnD9eXj
         HkY5aOQWRdvDmoQ1RThoXQUyOM6HsGk1kiX7Bf9fS9fb4gNQaYXWguHv9vFLCmK6Ix
         guEORrEK68Llg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A5EAB4011C; Tue,  1 Jun 2021 10:37:41 -0300 (-03)
Date:   Tue, 1 Jun 2021 10:37:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: fix segfault when wrong option for --debug is
 provided
Message-ID: <YLY4JfCmgaYGNBQO@kernel.org>
References: <20210531212828.240077-1-rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531212828.240077-1-rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, May 31, 2021 at 11:28:28PM +0200, Riccardo Mancini escreveu:
> The command `perf --debug record` causes a segfault instead of notifying
> the user of the unrecognized option for --debug (the correct syntax would
> be `perf --debug verbose=2 record`).
> 
> The bug is caused by a call to pr_err before debug_file (debug.c:34) is
> set via perf_debug_setup(). It has been introduced in
> commit 8abceacff87d ("perf debug: Add debug_set_file function").
> 
> This patch resolves the bug by calling perf_debug_setup earlier in the
> main, so that debug_file is set to stderr before any call to a debug
> printing function is made.

Ian fixed this earlier and it is already even upstream:

https://git.kernel.org/torvalds/c/c59870e2110e1229a6e4

Thanks,

- Arnaldo
 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/perf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index 20cb91ef06ffc..cffbab2d085a7 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -448,6 +448,7 @@ int main(int argc, const char **argv)
>  	pager_init(PERF_PAGER_ENVIRONMENT);
>  
>  	libperf_init(libperf_print);
> +	perf_debug_setup();
>  
>  	cmd = extract_argv0_path(argv[0]);
>  	if (!cmd)
> @@ -531,8 +532,6 @@ int main(int argc, const char **argv)
>  	 */
>  	pthread__block_sigwinch();
>  
> -	perf_debug_setup();
> -
>  	while (1) {
>  		static int done_help;
>  
> -- 
> 2.23.0
> 

-- 

- Arnaldo
