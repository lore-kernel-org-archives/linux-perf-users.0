Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C79C07E99
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jul 2021 14:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F09661156
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jul 2021 14:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbhGLOkD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Jul 2021 10:40:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:61407 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235179AbhGLOkD (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Jul 2021 10:40:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="190370585"
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="190370585"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 07:37:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="492143061"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.79]) ([10.237.72.79])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jul 2021 07:37:09 -0700
Subject: Re: [PATCH v4 10/11] perf env: Set flag for kernel is 64-bit mode
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-11-leo.yan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2df0e179-6302-ac7e-b41c-4f91bfc103de@intel.com>
Date:   Mon, 12 Jul 2021 17:37:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210711104105.505728-11-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 11/07/21 1:41 pm, Leo Yan wrote:
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
>  
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

perf_env__init() is also used for session->header.env which is not
necessarily the current machine.  So this initialization could be
separate from perf_env__init() to avoid confusion.

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
> 

