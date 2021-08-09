Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C91AC4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 20:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E6B61004
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 20:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbhHIUMK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 16:12:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234637AbhHIUMJ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 16:12:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 595A560F11;
        Mon,  9 Aug 2021 20:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628539908;
        bh=jfw1tYl8A57CAPEONb9M989EngiLdenLu91eHbvweiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V3LnA/nWmB4VMIgXB5zLdw3UbeVYfh+ASo0VL1cbKjFSCSlEqn1ybGRY0ABX2k0Nj
         sLU8j+z1Tn0qF0pURIfTcATOdsRO+V2ykQAPf3QKTSvEu4u9SeHuzxT6gLUlHCbHV2
         Cj6YYkFsGIG31l6razoaqfr225X6B/Jx56PVU8IB/i0kyMUmTVxAkvMR+mX1MS4aDz
         cyVddGWOwFJty4b9ItsJw28+7jsKDh0bPKPR4rv0vB24dBideQaF+MOpFq8kDoaUu1
         qLt9P4Qn9cKJBpWEOX8sA/mb1osBUJOYiktjQzNbRPJ3lwI8LTQJZwOTYbexSQLdAY
         QA2KMv9bO3rmw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 14A8C403F2; Mon,  9 Aug 2021 17:11:44 -0300 (-03)
Date:   Mon, 9 Aug 2021 17:11:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Li Huafei <lihuafei1@huawei.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v1 1/3] perf env: Track kernel 64-bit mode in environment
Message-ID: <YRGMAHj3MUndBEUq@kernel.org>
References: <20210809112727.596876-1-leo.yan@linaro.org>
 <20210809112727.596876-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809112727.596876-2-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Aug 09, 2021 at 07:27:25PM +0800, Leo Yan escreveu:
> It's useful to know that the kernel is running in 32-bit or 64-bit
> mode.  E.g. We can decide if perf tool is running in compat mode
> based on the info.
> 
> This patch adds an item "kernel_is_64_bit" into session's environment
> structure perf_env, its value is initialized based on the architecture
> string.

Thanks, applied.

- Arnaldo

 
> Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/env.c | 24 +++++++++++++++++++++++-
>  tools/perf/util/env.h |  3 +++
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index ab341050be46..8f7ff0035c41 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -219,13 +219,35 @@ void perf_env__exit(struct perf_env *env)
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
> +	env->kernel_is_64_bit = -1;
> +}
> +
> +static void perf_env__init_kernel_mode(struct perf_env *env)
> +{
> +	const char *arch = perf_env__raw_arch(env);
> +
> +	if (!strncmp(arch, "x86_64", 6) || !strncmp(arch, "aarch64", 7) ||
> +	    !strncmp(arch, "arm64", 5) || !strncmp(arch, "mips64", 6) ||
> +	    !strncmp(arch, "parisc64", 8) || !strncmp(arch, "riscv64", 7) ||
> +	    !strncmp(arch, "s390x", 5) || !strncmp(arch, "sparc64", 7))
> +		env->kernel_is_64_bit = 1;
> +	else
> +		env->kernel_is_64_bit = 0;
> +}
> +
> +int perf_env__kernel_is_64_bit(struct perf_env *env)
> +{
> +	if (env->kernel_is_64_bit == -1)
> +		perf_env__init_kernel_mode(env);
> +
> +	return env->kernel_is_64_bit;
>  }
>  
>  int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index 6824a7423a2d..1f5175820a05 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -61,6 +61,7 @@ struct perf_env {
>  	unsigned long long	total_mem;
>  	unsigned int		msr_pmu_type;
>  	unsigned int		max_branches;
> +	int			kernel_is_64_bit;
>  
>  	int			nr_cmdline;
>  	int			nr_sibling_cores;
> @@ -143,6 +144,8 @@ extern struct perf_env perf_env;
>  
>  void perf_env__exit(struct perf_env *env);
>  
> +int perf_env__kernel_is_64_bit(struct perf_env *env);
> +
>  int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[]);
>  
>  int perf_env__read_cpuid(struct perf_env *env);
> -- 
> 2.25.1
> 

-- 

- Arnaldo
