Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37729C83F19
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Aug 2023 17:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbjH2RSj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Aug 2023 13:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237874AbjH2RS1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044FA1B9
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Aug 2023 10:18:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0769F65D39
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Aug 2023 17:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A08C433C8;
        Tue, 29 Aug 2023 17:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693329412;
        bh=uglJZMr/rEggfPbd5Sq8n+ucNVnh5OnYWf4rm594aQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rnrjRqZjkqu2MiF5EDeisPuiywkfxD6ppfgUDE6x82UySVxGyCQa1kH4ZASkcTzFo
         sfwI2pYUKwtRX+zibS4GyB90eKahoPdHBm3cf/hiTwSslDQsWwv3D5X2h/vIIVXETm
         HpC1spjd5rbwKogoc3hDLfvqoYGnbA3yMlmIsr9EPrNyE65rCelAFI+ZjXojeMXfVG
         frtuArZbojcHUBYfkgwPtW+Jf+ux7GVLSjHeDu40OgMh0ZK+nNNtImzj2j5gaFp3aH
         RprJeNG8Ws3L1fXDQIVOJtTwdmT7SwSspp8enbat4mOi4Q0LZm89XlOHf6+6QVH9cX
         aHppdcVHNgA6A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9943540722; Tue, 29 Aug 2023 14:16:49 -0300 (-03)
Date:   Tue, 29 Aug 2023 14:16:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     mingo@redhat.com, peterz@infradead.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        chenhuacai@kernel.org, linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev
Subject: Re: [PATCH v4 0/3] tools/perf: Add loongarch cpuinfo and fix build
 warning
Message-ID: <ZO4oAeXdSvnqdku3@kernel.org>
References: <cover.1693315043.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1693315043.git.siyanteng@loongson.cn>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Aug 29, 2023 at 09:21:10PM +0800, Yanteng Si escreveu:
> v4:
> * Modify commit message. [3/3]

Thanks, I updated the commit log messages adding the Acked-by and the
new description for 3/3 since I hadn't published this in perf-tools-next
yet.

- Arnaldo
 
> v3:
> * Using strcasest() correctly.
> * Picking Huacai's Acked tag, I seem to have lost it in the last version.
> 
> v2:
> * Switch to strcasestr().
> * Use "test -f" instead of "[-f FILE]".
> 
> v1:
> * LoongArch and riscv don't have tools/arch/xxxxx/include/uapi/asm/mman.h,
>   let's modify the detection rules.
> * Allow to use cpuinfo on loongarch.
> 
> Yanteng Si (3):
>   perf/tools: Allow to use cpuinfo on LoongArch
>   perf/trace: Fix mmap_flags for archs use generic mman.h
>   perf/trace: Use "test -f" instead of "[-f FILE]"
> 
>  tools/perf/trace/beauty/mmap_flags.sh | 7 +++++--
>  tools/perf/trace/beauty/mmap_prot.sh  | 5 +++--
>  tools/perf/util/header.c              | 2 ++
>  tools/perf/util/svghelper.c           | 2 +-
>  4 files changed, 11 insertions(+), 5 deletions(-)
> 
> -- 
> 2.31.4
> 

-- 

- Arnaldo
