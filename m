Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AC7EE49B2
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Aug 2023 18:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjHVSD0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Aug 2023 14:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjHVSD0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Aug 2023 14:03:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD4F10D3
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Aug 2023 11:03:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D9DD65D5E
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Aug 2023 18:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEB8C433C7;
        Tue, 22 Aug 2023 18:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692727377;
        bh=4jEKuSPyHW8FpFNbKwoLd9oFXQQVr1W5mx8Bz9JrrMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X6nh4bccoEfgSFZiQJbGNEGjd+WM8uY3l/rxeARYeDhVMAdEJsB7VBdhzC0Fcr7Qs
         TYjuyVFcx1lE3v5otam1UQcAqxEYs2IgnWI58VE24eQarFPz4M1rVZWgg9BuGoMUZ5
         gRMSRUtHq/GnN3LIGbwoz+F3Al9P5h4+Yt0zEhTg8VgCrD/c06mG3I1T6z7BrpdzM3
         KMacDCdcyWaluWLBlcN2tNDcIPYdvxYo8oo4bcW4bsBDq6da9f25TffDApXqwvnQVA
         ePE7QX4jbDUwR0lIHr5ybA0eMY3yMpVr7N9rgHx7je3bLSEJMQ9+bUycApCmHoIwvj
         2kqPa03giHN3A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D72BE40722; Tue, 22 Aug 2023 15:02:54 -0300 (-03)
Date:   Tue, 22 Aug 2023 15:02:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     mingo@redhat.com, peterz@infradead.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        chenhuacai@kernel.org, linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev
Subject: Re: [PATCH v1 1/2] perf/trace: Fix mmap_flags for archs use generic
 mman.h
Message-ID: <ZOT4Tuc6JGrbDqFW@kernel.org>
References: <cover.1692694595.git.siyanteng@loongson.cn>
 <03ddc1c0e01518df63aac88e561cd0ec3c1e0028.1692694595.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03ddc1c0e01518df63aac88e561cd0ec3c1e0028.1692694595.git.siyanteng@loongson.cn>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Aug 22, 2023 at 05:32:06PM +0800, Yanteng Si escreveu:
> Silence this warning:
> 
> grep: /root/linux-next/tools/arch/xxxxx/include/uapi/asm//mman.h:
> No such file or directory

 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  tools/perf/trace/beauty/mmap_flags.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
> index 3022597c8c17..d035b29fc5ec 100755
> --- a/tools/perf/trace/beauty/mmap_flags.sh
> +++ b/tools/perf/trace/beauty/mmap_flags.sh
> @@ -19,7 +19,7 @@ arch_mman=${arch_header_dir}/mman.h
>  
>  printf "static const char *mmap_flags[] = {\n"
>  regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MAP_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
> -grep -E -q $regex ${arch_mman} && \
> +([ -f ${arch_mman} ] && grep -E -q $regex ${arch_mman}) && \
>  (grep -E $regex ${arch_mman} | \
>  	sed -r "s/$regex/\2 \1 \1 \1 \2/g"	| \
>  	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef MAP_%s\n#define MAP_%s %s\n#endif\n")

Humm, wouldn't this be simpler without that extra subshell? Like this:

diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
index 3022597c8c178f21..0ac1886a83b5aceb 100755
--- a/tools/perf/trace/beauty/mmap_flags.sh
+++ b/tools/perf/trace/beauty/mmap_flags.sh
@@ -19,6 +19,7 @@ arch_mman=${arch_header_dir}/mman.h
 
 printf "static const char *mmap_flags[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MAP_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
+test -f ${arch_mman} && \
 grep -E -q $regex ${arch_mman} && \
 (grep -E $regex ${arch_mman} | \
 	sed -r "s/$regex/\2 \1 \1 \1 \2/g"	| \
