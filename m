Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97B4C07E9A
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jul 2021 18:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAA8061186
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jul 2021 18:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbhGLSR0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Jul 2021 14:17:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhGLSR0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Jul 2021 14:17:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80B93610CB;
        Mon, 12 Jul 2021 18:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626113677;
        bh=2QGnvZ11CkY8+JV0LtxXLifgU9ChKnEBvlhtlmEAkC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cs1id13CBpepjJ6I0WV6gDwPjZJEijLGpy6chD9WQj8BqKytod+2fLK8zvrzd2Fdc
         HNqc5NFVhGRbzYnam/dUw4Z+txy0jwwI8macGS1iD0woO4HjzFkjRcxE490VYVeaUb
         kyv+zNmYEV4Oc+uczm6/xb2SVanC6GRIgqvQZgOniQ1BgiXUv484+JSomDxZqRd8DV
         Y1JPvS80gnJ9eGeVDKw7y1XZDRlkz63oH1C/Z21sCIzcDFdODHmz7VuuVimzDdF08M
         qARCiJcmvJpG0gUQAMS3bSTBy51BaciZwNZ8haiqIybzUdiVKXiLnfB1R170qIgivR
         +JvOtxxedw76A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 28339403F2; Mon, 12 Jul 2021 15:14:35 -0300 (-03)
Date:   Mon, 12 Jul 2021 15:14:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 10/11] perf env: Set flag for kernel is 64-bit mode
Message-ID: <YOyGi9Zdrio7OmBX@kernel.org>
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-11-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210711104105.505728-11-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sun, Jul 11, 2021 at 06:41:04PM +0800, Leo Yan escreveu:
> It's useful to know that the kernel is running in 32-bit or 64-bit
> mode.  E.g. We can decide if perf tool is running in compat mode
> from this info.
> 
> This patch adds a global variable "kernel_is_64_bit", it's initialized
> when a session setups environment, its value is decided by checking the
> architecture string.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/env.c | 17 ++++++++++++++++-
>  tools/perf/util/env.h |  1 +
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index ebc5e9ad35db..345635a2e842 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -11,6 +11,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>  
> +int kernel_is_64_bit;
>  struct perf_env perf_env;

Why can't this be in 'struct perf_env'?

- Arnaldo
  
>  #ifdef HAVE_LIBBPF_SUPPORT
> @@ -172,6 +173,19 @@ static void perf_env__purge_bpf(struct perf_env *env __maybe_unused)
>  }
>  #endif // HAVE_LIBBPF_SUPPORT
>  
> +static void perf_env__init_kernel_mode(struct perf_env *env)
> +{
> +	const char *arch = perf_env__raw_arch(env);
> +
> +	if (!strncmp(arch, "x86_64", 6) || !strncmp(arch, "aarch64", 7) ||
> +	    !strncmp(arch, "arm64", 5) || !strncmp(arch, "mips64", 6) ||
> +	    !strncmp(arch, "parisc64", 8) || !strncmp(arch, "riscv64", 7) ||
> +	    !strncmp(arch, "s390x", 5) || !strncmp(arch, "sparc64", 7))
> +		kernel_is_64_bit = 1;
> +	else
> +		kernel_is_64_bit = 0;
> +}
> +
>  void perf_env__exit(struct perf_env *env)
>  {
>  	int i;
> @@ -217,13 +231,14 @@ void perf_env__exit(struct perf_env *env)
>  	zfree(&env->hybrid_cpc_nodes);
>  }
>  
> -void perf_env__init(struct perf_env *env __maybe_unused)
> +void perf_env__init(struct perf_env *env)
>  {
>  #ifdef HAVE_LIBBPF_SUPPORT
>  	env->bpf_progs.infos = RB_ROOT;
>  	env->bpf_progs.btfs = RB_ROOT;
>  	init_rwsem(&env->bpf_progs.lock);
>  #endif
> +	perf_env__init_kernel_mode(env);
>  }
>  
>  int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index 6824a7423a2d..cc989ff49740 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -139,6 +139,7 @@ enum perf_compress_type {
>  struct bpf_prog_info_node;
>  struct btf_node;
>  
> +extern int kernel_is_64_bit;
>  extern struct perf_env perf_env;
>  
>  void perf_env__exit(struct perf_env *env);
> -- 
> 2.25.1
> 

-- 

- Arnaldo
