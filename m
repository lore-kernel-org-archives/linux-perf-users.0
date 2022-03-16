Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BCAC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Mar 2022 18:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345952AbiCPSbU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Mar 2022 14:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiCPSbU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Mar 2022 14:31:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEA35F27D;
        Wed, 16 Mar 2022 11:30:05 -0700 (PDT)
Received: from zn.tnic (p200300ea971561ec329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:61ec:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5064E1EC0347;
        Wed, 16 Mar 2022 19:30:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647455400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pb3rAmTPQdoOpkczge2tpTU7w0ED0PgJBxCzVuNRtpA=;
        b=KH0w64BKSFKeoGKejtnc0whoa0n4cjGnZzK0iGH3qQX/XWERAV/4qNfjCIkWVuH8tzFJlN
        XlPpulIbREG3kPLu6zRaBbo9GLZlhc2FwgwW0N+RTDjq5t1UR0p/MUoF2oZhEih6M8fhkL
        qJNpKX1b9Jp9kdO8eFaVLJTh5v8OUUY=
Date:   Wed, 16 Mar 2022 19:29:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dongli Si <kvmx86@gmail.com>
Cc:     peterz@infradead.org, joerg.roedel@amd.com,
        liam.merwick@oracle.com, kim.phillips@amd.com, mingo@kernel.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf/x86/amd: Don't touch the Host-only bit inside
 the guest hypervisor
Message-ID: <YjIspMR0lm6+W/Pp@zn.tnic>
References: <20220314042254.1487836-1-sidongli1997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220314042254.1487836-1-sidongli1997@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Mar 14, 2022 at 12:22:54PM +0800, Dongli Si wrote:
> diff --git a/arch/x86/include/asm/hypervisor.h b/arch/x86/include/asm/hypervisor.h
> index e41cbf2ec41d..fcc66c23cc72 100644
> --- a/arch/x86/include/asm/hypervisor.h
> +++ b/arch/x86/include/asm/hypervisor.h
> @@ -73,11 +73,21 @@ static inline bool hypervisor_is_type(enum x86_hypervisor_type type)
>  {
>  	return x86_hyper_type == type;
>  }
> +
> +static inline bool run_as_host(void)
> +{
> +	return hypervisor_is_type(X86_HYPER_NATIVE);
> +}

What's the point of this "wrapper"?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
