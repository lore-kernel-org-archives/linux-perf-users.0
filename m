Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73697C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 20:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5069C611CB
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 20:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344847AbhIIU3L (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 16:29:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345119AbhIIU3K (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Sep 2021 16:29:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBD93611AD;
        Thu,  9 Sep 2021 20:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631219281;
        bh=jPUN6W/xkG1ppfaJb7l4yOz/5ULBSSfyBuZRaP9ZWNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OroZwrt/xO67l+KPDGQZnDSbMNhRWXA1aSxjgglTXHGuIhw0x8hh6q6p61tKBmRlj
         JBYGHg/xeYw2hL0DOogBvcOgS99RqGasvJiGmX5ZuvuWVRDOKjLIwPEfxdQYDeIiXF
         Q0O8IDWdxzitPgv6M3jomBGcvEQcjFp2GmD27DN0mi/SrDF5BC0k3gd1smguOyOWaP
         o0QSNNFCzgfGu+c1BXs8vQG7RZjtwGc26W9VzmfSH5UL2AxyGDUSGjEn94sugQk+sW
         t0eOB9VtVq8eBCAnLon7zteskAxOdPZnddkq5FViNh25/2BFe/6DA+L8yEFpiTuv9m
         3gEdyU32h6f2g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 869DC4038F; Thu,  9 Sep 2021 17:27:58 -0300 (-03)
Date:   Thu, 9 Sep 2021 17:27:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Remi Bernon <rbernon@codeweavers.com>,
        Nicholas Fraser <nfraser@codeweavers.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf symbol: Look for ImageBase in PE file to compute
 .text offset
Message-ID: <YTpuTiYzkTKbUM/l@kernel.org>
References: <20210909192637.4139125-1-rbernon@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909192637.4139125-1-rbernon@codeweavers.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Sep 09, 2021 at 09:26:36PM +0200, Remi Bernon escreveu:
> Instead of using the file offset in the debug file.
> 
> This fixes a regression from 00a3423492bc90be99e529a64f13fdd80a0e8c0a,
> causing incorrect symbol resolution when debug file have been stripped
> from non-debug sections (in which case its .text section is empty and
> doesn't have any file position).
> 
> The debug files could also be created with a different file alignment,
> and have different file positions from the mmap-ed binary, or have the
> section reordered.
> 
> This instead looks for the file image base, using the corresponding bfd
> *ABS* symbols. As PE symbols only have 4 bytes, it also needs to keep
> .text section vma high bits.

I added a:

Fixes: 00a3423492bc90be ("perf symbols: Make dso__load_bfd_symbols() load PE files from debug cache only")

To help stable@kernel.org to pick it, its on my local tree now.

It would be great to get a:

Reviewed-by: Nicholas Fraser <nfraser@codeweavers.com> 

Can we have it, please?

- Arnaldo

> Signed-off-by: Remi Bernon <rbernon@codeweavers.com>
> ---
> 
> Hi!
> 
> As I'm not updating it often I only recently realized that perf had a
> regression when using stripped debug info files, and all symbols from
> PE files are off. This should make things better.
> 
> Cheers,
> 
>  tools/perf/util/symbol.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 77fc46ca07c0..0fc9a5410739 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1581,10 +1581,6 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
>  	if (bfd_get_flavour(abfd) == bfd_target_elf_flavour)
>  		goto out_close;
>  
> -	section = bfd_get_section_by_name(abfd, ".text");
> -	if (section)
> -		dso->text_offset = section->vma - section->filepos;
> -
>  	symbols_size = bfd_get_symtab_upper_bound(abfd);
>  	if (symbols_size == 0) {
>  		bfd_close(abfd);
> @@ -1602,6 +1598,22 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
>  	if (symbols_count < 0)
>  		goto out_free;
>  
> +	section = bfd_get_section_by_name(abfd, ".text");
> +	if (section) {
> +		for (i = 0; i < symbols_count; ++i) {
> +			if (!strcmp(bfd_asymbol_name(symbols[i]), "__ImageBase") ||
> +			    !strcmp(bfd_asymbol_name(symbols[i]), "__image_base__"))
> +				break;
> +		}
> +		if (i < symbols_count) {
> +			/* PE symbols can only have 4 bytes, so use .text high bits */
> +			dso->text_offset = section->vma - (u32)section->vma;
> +			dso->text_offset += (u32)bfd_asymbol_value(symbols[i]);
> +		} else {
> +			dso->text_offset = section->vma - section->filepos;
> +		}
> +	}
> +
>  	qsort(symbols, symbols_count, sizeof(asymbol *), bfd_symbols__cmpvalue);
>  
>  #ifdef bfd_get_section
> -- 
> 2.33.0

-- 

- Arnaldo
