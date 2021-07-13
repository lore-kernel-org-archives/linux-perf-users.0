Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA955C07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 09:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 930A261158
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 09:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbhGMKAq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 06:00:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234857AbhGMKAq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 06:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626170276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ux0PfeAXzOBlghNBmZ0mm1ZgRmQRaTVzR3iizUuPVT0=;
        b=bJNPFgGatpMKZGB82VPGWIwd7SzLf5gFW8FWu9P3buvH5B6Oom23mfxkLUGHh1KrmO9PK8
        USnJK0KUHhVC2xvhKV0s57p9v5ynMBcIlikmarUJoJdc/Cgb3fKMe+Raa+57q8HN+ovPCe
        1B7h6Ce148dyhsaW7deAMUiTlKJh9cY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-4qds3ADCOZKaLzQjDIPwKg-1; Tue, 13 Jul 2021 05:57:54 -0400
X-MC-Unique: 4qds3ADCOZKaLzQjDIPwKg-1
Received: by mail-wr1-f72.google.com with SMTP id y15-20020a5d614f0000b029013cd60e9baaso6105465wrt.7
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jul 2021 02:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ux0PfeAXzOBlghNBmZ0mm1ZgRmQRaTVzR3iizUuPVT0=;
        b=BzVSfsg4KzS6mJMLta/HYL3+VLjy+w24jwXnyxlEwzPS8nJhwfaXrXRPrw2rG5WidC
         iR6RNXUsXDVdSgAB98q04P10Bdubw4GqqI4zRnvPihm0tnEyNgUKQWkQBLWY5vDoK2P7
         1nNZb5yQbmvZosAD60gHI9kzi09SO/zdKkEQaYr2bSyVB9mGwylZoJxG8u6w1hoHI8nL
         Va4MSbmh8o6IOSXP1nT7KB+LPZoeoBn0cvLGZDaaE79yfLqYXH9vf3wPUM+GdMgNVf35
         F/ADMS6+qi5Z69PSFSkzQoZGgAUTjrhMu8e0+aMWwtQmWb4B/lmpe54Sq1YbENBMBVpB
         txBQ==
X-Gm-Message-State: AOAM532+SaMm0lKdOkzCeH3Nwa4bY/qQU0GhAqLP3k15G5BWumPqyV7S
        Eb59nrGAcaB2a7YvPss+/B86TFmo9iYSe87fgKtNyevqx9GKXKXmUja8PwjkmHXYdZUMnbcETFy
        TQFp3Oq4Wr2OnVYYhqdcpD92/c1CEcg==
X-Received: by 2002:adf:e107:: with SMTP id t7mr4557148wrz.165.1626170273701;
        Tue, 13 Jul 2021 02:57:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRXcscEbtweoNvDykByU0x2geYjbVhx2fh+FYLF+uLiJkfw5lMhGHodZMku5u2c9EnBCt60g==
X-Received: by 2002:adf:e107:: with SMTP id t7mr4557133wrz.165.1626170273546;
        Tue, 13 Jul 2021 02:57:53 -0700 (PDT)
Received: from krava ([5.171.209.239])
        by smtp.gmail.com with ESMTPSA id r9sm15099853wmq.25.2021.07.13.02.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 02:57:52 -0700 (PDT)
Date:   Tue, 13 Jul 2021 11:57:50 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org
Subject: Re: [PATCH] perf tests vmlinux-kallsyms: ignore hidden symbols
Message-ID: <YO1jnjHofv9oSR0M@krava>
References: <20210708122805.2832-1-mpetlan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708122805.2832-1-mpetlan@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 08, 2021 at 02:28:05PM +0200, Michael Petlan wrote:
> Symbols containing particular prefixes are purposely hidden from kallsyms.
> The prefixes are listed in scripts/kallsyms.c, using ignored_prefixes[]
> string array. The perf test "vmlinux symtab matches kallsyms" fails in case
> perf finds some of the hidden symbols in its machine image and can't match
> them to kallsyms.

there's also other arrays like ignored_suffixes, ignored_matches ...
should we have them as well? should we take the whole is_ignored_symbol
function?

> 
> Let's add a filter to check if a symbol not found isn't one of these before
> failing the test.
> 
> The ignored_prefixes[] array has been copied from scripts/kallsyms.c and needs
> to be updated along with the original.
> 
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> ---
>  tools/perf/tests/vmlinux-kallsyms.c | 41 +++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
> index 193b7c91b4e2..11cd276ec8fd 100644
> --- a/tools/perf/tests/vmlinux-kallsyms.c
> +++ b/tools/perf/tests/vmlinux-kallsyms.c
> @@ -14,6 +14,41 @@
>  
>  #define UM(x) kallsyms_map->unmap_ip(kallsyms_map, (x))
>  
> +/* Symbol names that begin with the following are ignored. (a copy from scripts/kallsyms.c) */
> +static const char * const ignored_prefixes[] = {
> +	"$",			/* local symbols for ARM, MIPS, etc. */
> +	".LASANPC",		/* s390 kasan local symbols */
> +	"__crc_",		/* modversions */
> +	"__efistub_",		/* arm64 EFI stub namespace */
> +	"__kvm_nvhe_",		/* arm64 non-VHE KVM namespace */
> +	"__AArch64ADRPThunk_",	/* arm64 lld */
> +	"__ARMV5PILongThunk_",	/* arm lld */
> +	"__ARMV7PILongThunk_",
> +	"__ThumbV7PILongThunk_",
> +	"__LA25Thunk_",		/* mips lld */
> +	"__microLA25Thunk_",
> +	NULL
> +};
> +
> +static int has_prefix(const char *prefix, const char *string)
> +{
> +	while(*prefix)
> +        if(*prefix++ != *string++)
> +            return 0;
> +
> +	return 1;
> +}
> +
> +static int should_be_hidden(const char *sym_name)
> +{
> +	int i;
> +	for(i = 0; ignored_prefixes[i] != NULL; i++)
> +		if(has_prefix(ignored_prefixes[i], sym_name))
> +			return 1;
> +
> +	return 0;

please check your patch with scripts/checkpatch.pl before posting

thanks,
jirka

