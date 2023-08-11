Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A217C001B0
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Aug 2023 13:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjHKNzx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Aug 2023 09:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbjHKNzc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Aug 2023 09:55:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865F92D78
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Aug 2023 06:55:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2661D63D30
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Aug 2023 13:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4A9C433C8;
        Fri, 11 Aug 2023 13:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691762130;
        bh=UkgBygCz01uYtfZgJPAYAw3hDod7s6by5RvrWS+roXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SJoM7tBWKvb4QgM+r9Iz12SUKJYpK/cuh/2g8Cpl6TNFH5/HSh/bMpWiOA12M00Y1
         KZiZ/AA/LKUh2dLvijty78PHoNSXTpCbm5r7LZr+D7LEzncVcWtkgjyHAO7Y5robXj
         KM4vpScUR7gTqBtmNP0iodH7b7gFqtRwufq5Q2bgo9nj3xAKvucGQhIuaJvbOBWI1x
         Bs78+VBgH7TQ0Vqo+BVD3iSaHEE7K3N9G+tsr63rq/psgZjseSpA7NOyU2grvVajjc
         vk3kzdKyav4wp1s1jN1eSsDez5OC0P1TFaicZTjHb5tJLj3cl7vCXCvIT22GxjuWt9
         9Jk4O3c2Y/X3A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8A99F404DF; Fri, 11 Aug 2023 10:55:27 -0300 (-03)
Date:   Fri, 11 Aug 2023 10:55:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] tools/perf: Add text_end to "struct dso" to save
 .text section size
Message-ID: <ZNY9zwZOs47ETwnU@kernel.org>
References: <20230811052128.70282-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811052128.70282-1-atrajeev@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Aug 11, 2023 at 10:51:27AM +0530, Athira Rajeev escreveu:
> Update "struct dso" to include new member "text_end".
> This new field will represent the offset for end of text
> section for a dso. This value is derived as:
> sh_size (Size of section in byes) + sh_offset (Section file
> offst) of the elf header for text.

You're stating what this patch does, but not why. So far was not needed,
why now?

Probably the second patch will have the answer, but please try to add
the reason on the patch that introduces the new field.

Thanks,

- Arnaldo
 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/util/dso.h        | 1 +
>  tools/perf/util/symbol-elf.c | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index b41c9782c754..70fe0fe69bef 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -181,6 +181,7 @@ struct dso {
>  	u8		 rel;
>  	struct build_id	 bid;
>  	u64		 text_offset;
> +	u64		 text_end;
>  	const char	 *short_name;
>  	const char	 *long_name;
>  	u16		 long_name_len;
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 8bd466d1c2bd..252d26a59e64 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1512,8 +1512,10 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  	}
>  
>  	if (elf_section_by_name(runtime_ss->elf, &runtime_ss->ehdr, &tshdr,
> -				".text", NULL))
> +				".text", NULL)) {
>  		dso->text_offset = tshdr.sh_addr - tshdr.sh_offset;
> +		dso->text_end = tshdr.sh_offset + tshdr.sh_size;
> +	}
>  
>  	if (runtime_ss->opdsec)
>  		opddata = elf_rawdata(runtime_ss->opdsec, NULL);
> -- 
> 2.31.1
> 

-- 

- Arnaldo
