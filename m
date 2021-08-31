Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF362C432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 18:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD236103D
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 18:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbhHaSrN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 14:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34546 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238869AbhHaSrN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 14:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630435576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aKcTGiFsWzKoWPb2efbYmLLsKlRKKqNkhKpgg+hore4=;
        b=CSVTOLJ2tkhIybKC+2rImwmqorrZkgPJLTTu9f9n3Vrv9JxRM8xHlOdX4jIhb8p1OGY4Y7
        wop1vyk4rrBvGUCEZmhLfl3IvsDlM81Puul0LTJXa5mWFtYNp1ZFuQnzSDgkHt57vs3KaH
        Gc+z0rdiKBGfGigLEuMNeguM/1Zpny8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-Un9TMKptPmuv-JU2M7bPSg-1; Tue, 31 Aug 2021 14:46:15 -0400
X-MC-Unique: Un9TMKptPmuv-JU2M7bPSg-1
Received: by mail-ej1-f72.google.com with SMTP id gw26-20020a170906f15a00b005c48318c60eso184285ejb.7
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Aug 2021 11:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aKcTGiFsWzKoWPb2efbYmLLsKlRKKqNkhKpgg+hore4=;
        b=Zp90JnH4+mvysnhqkRpIPCLiBa6LYIMPy1sjDeYxBXdjBlXXYC+zL/A/89j0eelbxt
         6DKl0hHVkiKMTJfWnLC7HHRVGXCKqewJxIlCPu4K/lGTmdEAw+s6LRDOAEQ2Txh5aFxC
         YEx0/xX3GD+NKypFAh1Ef6kx+tN7dL+GrOH1cnrxXI+s8MwGn8ju8LZpPAQhHXjucD4D
         dBngFQzmo5bHbkHw9esWsDnjClELdV0pNu+pm45iuuP/ZfF/D5gaIMgCEq6u252w3fhc
         rafeUa3w+caPhEVs4mgl1IBczt5acdYuFn0VycCiu2IkR+BnxhgjX0tAWo9Lc9LcW5fc
         l9ag==
X-Gm-Message-State: AOAM531oNHkgH5shSfFWhJMfUEpWY3MxVWUT4mmOMKVfzlGgqjWi/biF
        wOKSQXa9cWnzX8URJfPASkgNV6YcVI0cIvC7eVhsegkEs88YoOuURYMShKZw6awO6rvj/BnoEhn
        FwkExK+n2rjZsR7G13+jgSgod1Qaeew==
X-Received: by 2002:a17:906:d94:: with SMTP id m20mr31718169eji.445.1630435573922;
        Tue, 31 Aug 2021 11:46:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgz47gn0Ne+Pgmnr8XYaA3F89DZ8Js6DWXL1ELRxbfhkR/w3QWctD0/e02pyVnHFM0C8OkfQ==
X-Received: by 2002:a17:906:d94:: with SMTP id m20mr31718163eji.445.1630435573768;
        Tue, 31 Aug 2021 11:46:13 -0700 (PDT)
Received: from krava ([2a00:102a:4005:bb4:e4bf:9f13:dbe6:2d14])
        by smtp.gmail.com with ESMTPSA id y32sm9960176ede.22.2021.08.31.11.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 11:46:13 -0700 (PDT)
Date:   Tue, 31 Aug 2021 20:46:10 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools build: Fix feature detect clean for out of source
 builds
Message-ID: <YS548qYreGLtabs4@krava>
References: <20210816130705.1331868-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816130705.1331868-1-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 16, 2021 at 02:07:05PM +0100, James Clark wrote:
> Currently the clean target when using O= isn't cleaning the feature
> detect output. This is because O= and OUTPUT= are set to canonical
> paths. For example in tools/perf/Makefile:
> 
>   FULL_O := $(shell cd $(PWD); readlink -f $(O) || echo $(O))
> 
> This means that OUTPUT ends in a / and most usages prepend it to a file
> without adding an extra /. This line that was changed adds an extra /
> before the 'feature' folder but not to the end, resulting in a clean
> command like this:
> 
>   rm -f /tmp/build//featuretest-all.bin ...
> 
> After the change the clean command looks like this:
> 
>   rm -f /tmp/build/feature/test-all.bin ...
> 
> Signed-off-by: James Clark <james.clark@arm.com>

nice catch!

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/build/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/build/Makefile b/tools/build/Makefile
> index 5ed41b96fcde..6f11e6fc9ffe 100644
> --- a/tools/build/Makefile
> +++ b/tools/build/Makefile
> @@ -32,7 +32,7 @@ all: $(OUTPUT)fixdep
>  
>  # Make sure there's anything to clean,
>  # feature contains check for existing OUTPUT
> -TMP_O := $(if $(OUTPUT),$(OUTPUT)/feature,./)
> +TMP_O := $(if $(OUTPUT),$(OUTPUT)feature/,./)
>  
>  clean:
>  	$(call QUIET_CLEAN, fixdep)
> -- 
> 2.28.0
> 

