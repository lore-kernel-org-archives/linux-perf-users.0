Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BDEC3DA66
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 13:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245288AbjHYNpr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Aug 2023 09:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245251AbjHYNpW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Aug 2023 09:45:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642C22680
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 06:45:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F272167A66
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 13:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D02CC433C7;
        Fri, 25 Aug 2023 13:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692971119;
        bh=p6xhQBPRgg79wDY30Dy2w8BQlNFM3BRt8/ppENFT20c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=euOKz8xWzJjRsQ3Vx+frRZc42WwRYGXl0kbYGbBRwXMs43sqfwi5U+TkJLX0vJOur
         Pt+xjN2IrFuWtd3iUFGC+KBdIQYqDL+bNG3jO/aYHsM4tZ77Cha/858Vj0XIUUJ9ih
         MQ52cM/llKKe1UQLrg8WBtJvPwAy8f27JiNdOt2qnem8YwNsEylEnGFWuK9YsqYgQr
         8LO5eQxushxsTVkraLCOiY8kFE1/TRwy+dD97BVndL+XjC4egW9/fTAb392co2ZCoR
         xQa+OiKAoDTJJfKxMNiKdNxJhUKF8BJFOB1QO6jWnmStTMVguGvI1JMUnu6cobNExr
         iUvlYD72TL3xA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BE0EE40722; Fri, 25 Aug 2023 10:45:16 -0300 (-03)
Date:   Fri, 25 Aug 2023 10:45:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     mingo@redhat.com, peterz@infradead.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        chenhuacai@kernel.org, linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev
Subject: Re: [PATCH v2 1/3] perf/tools: Allow to use cpuinfo on LoongArch
Message-ID: <ZOiwbNrwaodRfbSN@kernel.org>
References: <cover.1692962043.git.siyanteng@loongson.cn>
 <db968a186a10e4629fe10c26a1210f7126ad41ec.1692962043.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db968a186a10e4629fe10c26a1210f7126ad41ec.1692962043.git.siyanteng@loongson.cn>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Aug 25, 2023 at 07:28:02PM +0800, Yanteng Si escreveu:
> Define these macros so that the CPU name can be displayed
> when running perf report and perf timechart.
> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  tools/perf/util/header.c    | 2 ++
>  tools/perf/util/svghelper.c | 5 ++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
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
> index 5c62d3118c41..5744a3036b01 100644
> --- a/tools/perf/util/svghelper.c
> +++ b/tools/perf/util/svghelper.c
> @@ -331,7 +331,10 @@ static char *cpu_model(void)
>  	file = fopen("/proc/cpuinfo", "r");
>  	if (file) {
>  		while (fgets(buf, 255, file)) {
> -			if (strstr(buf, "model name")) {
> +			if (strcasestr(buf, "Model Name")) {
> +				strlcpy(cpu_m, &buf[13], 255);
> +				break;
> +			} else if (strcasestr(buf, "model name")) {
>  				strlcpy(cpu_m, &buf[13], 255);

Hey, the point of strcasestr() is to do a case _insensitive_ substring
search, so all we need is:

> --- a/tools/perf/util/svghelper.c
> +++ b/tools/perf/util/svghelper.c
> @@ -331,7 +331,10 @@ static char *cpu_model(void)
>  	file = fopen("/proc/cpuinfo", "r");
>  	if (file) {
>  		while (fgets(buf, 255, file)) {
> -			if (strstr(buf, "model name")) {
> +			if (strcasestr(buf, "model Name")) {
>  				strlcpy(cpu_m, &buf[13], 255);
>  				break;

Right? I'm doing this change while applying your patches.

See:

[acme@five c]$ grep -m1 "model name" /proc/cpuinfo | ./strcasestr "Model NAME"
needle=Model NAME
haystack=model name	: AMD Ryzen 9 5950X 16-Core Processor

found: model name	: AMD Ryzen 9 5950X 16-Core Processor
found[13..]: AMD Ryzen 9 5950X 16-Core Processor
[acme@five c]$ grep -m1 "model name" /proc/cpuinfo | ./strcasestr "model name"
needle=model name
haystack=model name	: AMD Ryzen 9 5950X 16-Core Processor

found: model name	: AMD Ryzen 9 5950X 16-Core Processor
found[13..]: AMD Ryzen 9 5950X 16-Core Processor
[acme@five c]$ grep -m1 "model name" /proc/cpuinfo | ./strcasestr "Model Name"
needle=Model Name
haystack=model name	: AMD Ryzen 9 5950X 16-Core Processor

found: model name	: AMD Ryzen 9 5950X 16-Core Processor
found[13..]: AMD Ryzen 9 5950X 16-Core Processor
acme@five c]$ echo "Model Name : AMD Ryzen 9 5950X 16-Core Processor" | ./strcasestr "model name"
needle=model name
haystack=Model Name	: AMD Ryzen 9 5950X 16-Core Processor

found: Model Name	: AMD Ryzen 9 5950X 16-Core Processor
found[13..]: AMD Ryzen 9 5950X 16-Core Processor
[acme@five c]$ echo "MODEL NAME : AMD Ryzen 9 5950X 16-Core Processor" | ./strcasestr "model name"
needle=model name
haystack=MODEL NAME	: AMD Ryzen 9 5950X 16-Core Processor

found: MODEL NAME	: AMD Ryzen 9 5950X 16-Core Processor
found[13..]: AMD Ryzen 9 5950X 16-Core Processor
[acme@five c]$
[acme@five c]$ cat strcasestr.c
#define _GNU_SOURCE
#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[])
{
	char *needle = argv[1], haystack[128], *found;
	printf("needle=%s\n", needle);
	fgets(haystack, sizeof(haystack), stdin);
	printf("haystack=%s\n", haystack);
	found = strcasestr(haystack, needle);
	printf("found: %s", found);
	printf("found[13..]: %s", found + 13);
	return 0;
}
[acme@five c]$
