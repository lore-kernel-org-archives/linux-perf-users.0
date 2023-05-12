Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC473C77B75
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 May 2023 13:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbjELNtC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 May 2023 09:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241316AbjELNtB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 May 2023 09:49:01 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD711329C
        for <linux-perf-users@vger.kernel.org>; Fri, 12 May 2023 06:48:58 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d1so72300075e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 May 2023 06:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683899337; x=1686491337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=67+i61jguyp+ViZ9g6BdKZA7MoS8H9z+3IWq9oh/QL4=;
        b=OwLBvsSCAL4IKqngbyeoNx/oUbfIXwpu3OvJhWUAlVCiT6A9dVvRwxpOuPJqfIbT/6
         PrRcyqgLS3++Foa3bBtNBv/pj2lvZa83iigcr+fC8lrKrUMNsAQzjyEy+PMw5OMm/Mhf
         xF0yyGQzDsuSOMbxKBHHyAFAEKrz+LS4Fyu3wgjp0bEG6ZAZ6d6zsvotf2t02PXSwHRW
         FfnDosgrkDUWBd8K4VTIE+ETIO+fdaZ1mayOHMPSoB8rpU8IPhOHJYHvOjr5iMGiPkQF
         8qstkH9p0C0OucOJviu7r6yDgaQ9C5Z5Y9EfGtbIHXO5xfXzDSrQ5BQ6gaa5O1McMXua
         2pOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683899337; x=1686491337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67+i61jguyp+ViZ9g6BdKZA7MoS8H9z+3IWq9oh/QL4=;
        b=D6y5btMV0NlWXL8URdxZmZuPAL+8aFg3xacRNhtR6Wc6noDYeMwjjvc4pVbj0eUMaf
         0prVrdyYkW1dh2GDxbMx9I+NWhk/5g5Gdu7YojpXOaCxBTBGq+V8yEHWFzzK6a+C6UaX
         mCHw/S8NQNOIv7gk2le3Yt3rl9J5Nkd33J/G64OrQcO+FYinT0cPbDxZT1TPT/+1wbbd
         /p7LhSBJZLMXL+TWO/BN6nUVAivHGc3AoLeeDCxudj6zbt8wtXWu6anHSVy3esHQjehi
         6nDdfVoQ4pJ42Qw5NIDzKY6/qugGFFyaKIXiYsT34EimiQuYjpqmxY5lyNllDmD9XrqX
         Zw8Q==
X-Gm-Message-State: AC+VfDzL0e43g45JBOtcp+Hiut5mHEtjN6YSEr7vP53x9bOAHbcYpXL0
        pLBd9NbPsAEdYho0KshjDbPU8w==
X-Google-Smtp-Source: ACHHUZ587vmfUkFwUYJByiVpeFrZ7RH44sF7IGxP8ERhwrP7uly1qe+BtE/g9t78xP4zh4ZmSj7afw==
X-Received: by 2002:a05:600c:2198:b0:3f4:253b:92a9 with SMTP id e24-20020a05600c219800b003f4253b92a9mr11929533wme.30.1683899337069;
        Fri, 12 May 2023 06:48:57 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id k14-20020a7bc40e000000b003f4272c2d0csm13894413wmi.36.2023.05.12.06.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 06:48:56 -0700 (PDT)
Date:   Fri, 12 May 2023 14:48:53 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 07/10] kgdb: Expose default CPUs roundup fallback
 mechanism
Message-ID: <20230512134853.GA216623@aspen.lan>
References: <20230419225604.21204-1-dianders@chromium.org>
 <20230419155341.v8.7.I21d92f8974c8e4001a5982fea6c98da1bed33ef5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419155341.v8.7.I21d92f8974c8e4001a5982fea6c98da1bed33ef5@changeid>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Apr 19, 2023 at 03:56:01PM -0700, Douglas Anderson wrote:
> From: Sumit Garg <sumit.garg@linaro.org>
>
> Add a new API kgdb_smp_call_nmi_hook() to expose default CPUs roundup
> mechanism to a particular archichecture as a runtime fallback if it
> detects to not support NMI roundup.
>
> Currently such an architecture example is arm64 supporting pseudo NMIs
> feature which is only available on platforms which have support for GICv3
> or later version.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Tested-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> (no changes since v1)
>
>  include/linux/kgdb.h      | 12 ++++++++++++
>  kernel/debug/debug_core.c |  8 +++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index 258cdde8d356..87713bd390f3 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -199,6 +199,18 @@ kgdb_arch_handle_qxfer_pkt(char *remcom_in_buffer,
>
>  extern void kgdb_call_nmi_hook(void *ignored);
>
> +/**
> + *	kgdb_smp_call_nmi_hook - Provide default fallback mechanism to
> + *				 round-up CPUs
> + *
> + *	If you're using the default implementation of kgdb_roundup_cpus()
> + *	this function will be called.  And if an arch detects at runtime to
> + *	not support NMI based roundup then it can fallback to default
> + *	mechanism using this API.
> + */
> +
> +extern void kgdb_smp_call_nmi_hook(void);

Concept looks sensible but this is a terrible name for aa command to
round up the CPUs using smp_call... functions. Whilst it is true it that
kgdb_roundup_cpus() does use kgdb_call_nmi_hook() internally that
doesn't mean we should name functions after it. They should be named
after what they are do, not how they do it.

Something more like kgdb_roundup_cpus_with_smp_call() would be a much
better name.


Daniel.
