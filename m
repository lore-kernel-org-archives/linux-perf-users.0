Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2504C43217
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Nov 2022 13:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKCNcG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Nov 2022 09:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiKCNcE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Nov 2022 09:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6418365E3
        for <linux-perf-users@vger.kernel.org>; Thu,  3 Nov 2022 06:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667482261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J1pwMoixehBB6/exsa/xgFUL6PKhjwpqvEeah5GcAlk=;
        b=iW0/jonnrA7eMEqBDQoyYwSsrkFEq4zl/NXrt5KjMqqy66O/6H4OyZ0jYPaVo/ATeesOVn
        OvM37oA2HewMB/lAL38LvJIVIgKyUiyoLn7HS+S9ZRisvNvXg5lwpQ0d4of7yyWd9aMCB5
        0rAjvahaJzrSgpaMvULBDucT4iVuo4g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-371-riT6TtQiNpGi7W6sYbBuxw-1; Thu, 03 Nov 2022 09:31:00 -0400
X-MC-Unique: riT6TtQiNpGi7W6sYbBuxw-1
Received: by mail-ej1-f69.google.com with SMTP id xj11-20020a170906db0b00b0077b6ecb23fcso1249911ejb.5
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Nov 2022 06:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1pwMoixehBB6/exsa/xgFUL6PKhjwpqvEeah5GcAlk=;
        b=O4jnIh0n75CMOVJmPzoFD1WHhz1LTnw0U/eOs6zsJ48CCpLlMHNYGtRFDIhnzkiTTY
         n+pZbpfVK1dcLUJ3otZ7028/jb+4YVd+SHyE7hbj9T1iFoQLLW9zOOAglBI2O/4xL8aF
         ngDsfgopRRLs+2nHrxKQ/wQz4QIh6eDBQBfrqfIrqAalCchCOfwS1G+f3BWklOvEQtkX
         xIhjwGVAkEGF4hSpD19/hr2qQLCwP8ASHGYj+TE0i29eaMRhLeA0WVNVbDottqoZoQDn
         TTV1SvpwwhfW32K9MDxq49T2OoBnaGoZq4kjvHacpW4FDN1d7mSU4PlSDRbjJ8sp2xbC
         TLwA==
X-Gm-Message-State: ACrzQf1qM7/6No8h0wYg0tkgCLQO7wq9E4ldiHrVscbmnLvSodySCSoJ
        /rnMV2GCDrOlk0E1xBgRjNnjGIiFNtAJAEWNrYrZ1KNJ15sKHusrw6AN0hRpyepwhbShv0e/Rxh
        laJGYOcmwkgKf7rv2+7wzrHNOsYB/ZQ==
X-Received: by 2002:aa7:da0a:0:b0:461:135e:7298 with SMTP id r10-20020aa7da0a000000b00461135e7298mr29826280eds.242.1667482259083;
        Thu, 03 Nov 2022 06:30:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4uP66wYjZQz+zFm2TRRot723nL19VWlEAfPOzWcUzZlqhtnavJOZFU4zZK5IHLVc6ZLRkUpw==
X-Received: by 2002:aa7:da0a:0:b0:461:135e:7298 with SMTP id r10-20020aa7da0a000000b00461135e7298mr29826243eds.242.1667482258880;
        Thu, 03 Nov 2022 06:30:58 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id g16-20020a170906539000b007ad98918743sm513858ejo.1.2022.11.03.06.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 06:30:58 -0700 (PDT)
Message-ID: <122e2dc2-743a-0518-c910-fdf5ced328e3@redhat.com>
Date:   Thu, 3 Nov 2022 14:30:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 1/5] perf/x86/intel/lbr: use setup_clear_cpu_cap
 instead of clear_cpu_cap
Content-Language: en-US
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        Borislav Petkov <bp@alien8.de>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jane Malalane <jane.malalane@citrix.com>,
        Kees Cook <keescook@chromium.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>
References: <20220718141123.136106-1-mlevitsk@redhat.com>
 <20220718141123.136106-2-mlevitsk@redhat.com> <Yyh9RDbaRqUR1XSW@zn.tnic>
 <c105971a72dfe6d46ad75fb7e71f79ba716e081c.camel@redhat.com>
 <YzGlQBkCSJxY+8Jf@zn.tnic>
 <c1168e8bd9077a2cc9ef61ee06db7a4e8c0f1600.camel@redhat.com>
 <Y1EOBAaLbv2CXBDL@zn.tnic> <fd2cf028-bd83-57ff-7e6d-ef3ee11852a1@redhat.com>
 <MW5PR84MB18428331677C881764E615D2AB399@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <MW5PR84MB18428331677C881764E615D2AB399@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 11/2/22 15:27, Elliott, Robert (Servers) wrote:
> 
> 3. Similarly, modules using X86_FEATURE_XMM2 probably need to
> check XFEATURE_MASK_SSE:
> 
> Currently checking XSAVE SSE:
>    aegis128-aesni-glue
> 
> Current not checking XSAVE SSE:
>    nhpoly1305-sse2_glue
>    serpent_sse2_glue

These should check boot_cpu_has(X86_FEATURE_FXSR).  Checking 
XFEATURE_MASK_SSE will fail on systems without XSAVE, because 
fpu_kernel_cfg.max_features is zero there (see fpu__init_system_xstate() 
in arch/x86/kernel/fpu/xstate.c).

It happens to work for aegis128-aesni-glue because AES instructions only 
exist on new-enough parts, but it should probably be changed as well.

Paolo

