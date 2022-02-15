Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9530FC4167E
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Feb 2022 18:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242969AbiBOSSA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Feb 2022 13:18:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242975AbiBOSR4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Feb 2022 13:17:56 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63E811AA3A
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Feb 2022 10:17:42 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id qe15so18049248pjb.3
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Feb 2022 10:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rU/cr+2YS83r8ZzfG0ihHyfke5lY7dzNO33vRqwTRo0=;
        b=BbY3zUMbpsKVLuD6QiFaFpnxej58wpxQPVVGisDcf+K+2coTsFmZNXGoWqBeKoLb1x
         3ZptFg7el6LpqeSuHR1QjwuSCHfpkEX/T+XcjAHpaQzkvx2kHT7d0+kYGoaayuMfQhPV
         CAs5kcpK7DDzn/NDlTFukbq1xe316LjUYcWLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rU/cr+2YS83r8ZzfG0ihHyfke5lY7dzNO33vRqwTRo0=;
        b=x21+zSa7oUvgO86Y/9a+cMDur1TiJLJY9u2g1wd07srm84sbCK7SEqAc43LRbKdjm8
         RQ5WP/t+r1e2yJnDJsng1vol2s8yEuBhwRk1kxMs1EKDKipJtxokFoISniRJIJOj0PhV
         05RXkLVbc8wBDC0tx+07IOSagtlWpN1Qa2THuZdJQELYkMt3u2jddnwxcRpITe0q9oV7
         0znUx3iHAT1C1OxQvwsLvB2bISuYcyIg9yzsKctexg8DvdHiGRS+ZrlHZ2EC9U5vIZtn
         UHJgLzzV00rj13+5bOFXnUQace3IqmMJLguklnzPgxLjft2wslex0cJgQ8nGELvJ/tbV
         pLOA==
X-Gm-Message-State: AOAM5317TAV5NiLbrMmDAzt2eiW6pKV+InnA1/m/jh3WUFBksyTqJRBV
        ukoDzjEaau2P1HlOTq6bm5priQ==
X-Google-Smtp-Source: ABdhPJwjJJkj0fC2gO+FdGjnaisWCk9FKkCf0qazg7PUuY4rrjoW+egyeLOWB+yCEr/MI5qa+9+dbA==
X-Received: by 2002:a17:902:eb8f:: with SMTP id q15mr235036plg.67.1644949062021;
        Tue, 15 Feb 2022 10:17:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a186sm3157627pgc.70.2022.02.15.10.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 10:17:41 -0800 (PST)
Date:   Tue, 15 Feb 2022 10:17:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     GR-QLogic-Storage-Upstream@marvell.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-crypto@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org, sparmaintainer@unisys.com,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-ext4@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-arch@vger.kernel.org, linux-mm@kvack.org,
        greybus-dev@lists.linaro.org, linux-i3c@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] treewide: Replace zero-length arrays with
 flexible-array members
Message-ID: <202202151016.C0471D6E@keescook>
References: <20220215174743.GA878920@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220215174743.GA878920@embeddedor>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Feb 15, 2022 at 11:47:43AM -0600, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> This code was transformed with the help of Coccinelle:
> (next-20220214$ spatch --jobs $(getconf _NPROCESSORS_ONLN) --sp-file script.cocci --include-headers --dir . > output.patch)
> 
> @@
> identifier S, member, array;
> type T1, T2;
> @@
> 
> struct S {
>   ...
>   T1 member;
>   T2 array[
> - 0
>   ];
> };

These all look trivially correct to me. Only two didn't have the end of
the struct visible in the patch, and checking those showed them to be
trailing members as well, so:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
