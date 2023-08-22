Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3359EE49AF
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Aug 2023 17:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjHVRuu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Aug 2023 13:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHVRut (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Aug 2023 13:50:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC8B196
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Aug 2023 10:50:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF5E063E0E
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Aug 2023 17:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1551C433C8;
        Tue, 22 Aug 2023 17:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692726647;
        bh=8wyz7tIdSjCDpv2YyMio1rNav9NpU1p5w5n1ziqSooY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P39XmaDlgE+FbqLMhrQmh6S8v23NLkUiZmm10OQP9n+5Z/nPhLbCLTPpbO//+jaBa
         jetUvMq8WWFhmhSefgkrIoHQeuWMqomxZ6Qjn3x7mMAB8XmTOO6gZcT6yqROZXOAmS
         6jBiduYtKqlw63lN/Ck4KpXEyXXsTN4/xZRVxOclXK2fsXxnSI4STYVO0PEf3zoWOQ
         HtOOCw1Ls9vXhs9VxbWUJOZmgsAffVsFpC1kldUblLFWcnN1dU4hXvYHBf6xYit/4f
         O3mIw9jhL9waAecNvUbQCohKNehrv0OzQFoctTMZnN+/bnV4Gxlmqi7uk3thCG+30G
         dnzIrG5GPh0hw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B5EE640722; Tue, 22 Aug 2023 14:50:43 -0300 (-03)
Date:   Tue, 22 Aug 2023 14:50:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     mingo@redhat.com, peterz@infradead.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        chenhuacai@kernel.org, linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev
Subject: Re: [PATCH v1 2/2] perf/tools: Allow to use cpuinfo on loongarch
Message-ID: <ZOT1c/MRwkaPaqf1@kernel.org>
References: <cover.1692694595.git.siyanteng@loongson.cn>
 <fbb71a04bf3b19b1d1b239e464c1acbcc572e9a8.1692694595.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbb71a04bf3b19b1d1b239e464c1acbcc572e9a8.1692694595.git.siyanteng@loongson.cn>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Aug 22, 2023 at 05:32:07PM +0800, Yanteng Si escreveu:
> Define these macros so that the CPU name can be displayed
> when running perf report and perf timechart.
> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  tools/perf/util/header.c    | 2 ++
>  tools/perf/util/svghelper.c | 7 ++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 52fbf526fe74..c6e19192bd28 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -456,6 +456,8 @@ static int write_cpudesc(struct feat_fd *ff,
>  #define CPUINFO_PROC	{ "Processor", }
>  #elif defined(__xtensa__)
>  #define CPUINFO_PROC	{ "core ID", }
> +#elif defined(__loongarch__)
> +#define CPUINFO_PROC	{ "Model Name", }
>  #else
>  #define CPUINFO_PROC	{ "model name", }
>  #endif
> diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
> index 5c62d3118c41..0259715ad6a6 100644
> --- a/tools/perf/util/svghelper.c
> +++ b/tools/perf/util/svghelper.c
> @@ -322,6 +322,11 @@ void svg_waiting(int Yslot, int cpu, u64 start, u64 end, const char *backtrace)
>  
>  static char *cpu_model(void)
>  {
> +#if defined(__loongarch__)
> +#define CPU_TYPE	"Model Name"
> +#else
> +#define CPU_TYPE	"model name"
> +#endif
>  	static char cpu_m[255];
>  	char buf[256];
>  	FILE *file;
> @@ -331,7 +336,7 @@ static char *cpu_model(void)
>  	file = fopen("/proc/cpuinfo", "r");
>  	if (file) {
>  		while (fgets(buf, 255, file)) {
> -			if (strstr(buf, "model name")) {
> +			if (strstr(buf, CPU_TYPE)) {

Isn't it better to just switch to strcasestr()?

- Arnaldo

>  				strlcpy(cpu_m, &buf[13], 255);
>  				break;
>  			}
> -- 
> 2.31.4
> 

-- 

- Arnaldo
