Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A78C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 26 Mar 2022 05:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiCZFvs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 26 Mar 2022 01:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiCZFvl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 26 Mar 2022 01:51:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D59B20DB39
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Mar 2022 22:50:05 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a8so18993849ejc.8
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Mar 2022 22:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2O4yXpqsURvfM5TB1UAWHWz+8FkEHYO0gCz767gxti8=;
        b=Sod/FcT9Ks5jijNGSYWpQqzd2JM5VDQVU8LgvK+b5kJXeLJ7QA0CZcDCF05sYHAjYm
         BVFzuU76IglUwI8JQsnzAKI3cuQXLirS7G9bp1t/al+3dw/TGAiv9wUpyabRDndtCgEP
         eO4epxHuxmxlplL3zY2SC1wstRqM9gJiP1CpDnIP+s1YVx7Ynhpdr/E2brjy0fnY2Zii
         4lBi4HZmW3pg92GjJuMNzCZagWrEPEWU2emY2IFElEotn5Mrat+h2gwXe9X00yEoNYJx
         TKH0Se9JgX02mX7U7XEDoLLw6GUbFpSFdYFrw1wEbFV1onAQsWXAQD/ud+LGaASHvSeV
         YQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2O4yXpqsURvfM5TB1UAWHWz+8FkEHYO0gCz767gxti8=;
        b=l3hGc4S+Cbv+mRVYect7VPk/F3qi51uYnO0pIftL97GkmYcuflaDzyUk5Kah/sbMSH
         PcBXXz6JV7IbJwkMMTUKeX98zmrK4STM1yogDOIfQnhStdP4/MgTKoSkrOUADMdHw2H1
         wj+C2IoWfqjZVDRzXBun/V/nddPtadng0IfRu8H2C0ZnO+yQ4MzcCYJoZ/DJmgdIvLdn
         g6AYzU/1RsOh/Ls6DFoMzyq2Y/xOUcF9fyJeMi7VNfu72xI4LMFewoEcw1LVJQKCDVoK
         Lw83vz2nrO6KOChlqtbb5S1g/jlrNdoYjNoxnPg63t2YUES+PffZYzM1v0ivOP2I862k
         D2cw==
X-Gm-Message-State: AOAM530vdC1ZD3sSFLkqXeTFUBOu3WYw+k/ogxsZY93lRduI1QBM9p8i
        43MvZWX8XNTaLcf4A1UBmLVJMg==
X-Google-Smtp-Source: ABdhPJz2DiccS9xVih0qkcsHHv/ejttJp0IsCc3Xakcv/Utb1G9VsI1XMGaRvbMGOYF83H//hNnB7g==
X-Received: by 2002:a17:906:9751:b0:6e0:5cdd:cabf with SMTP id o17-20020a170906975100b006e05cddcabfmr15961766ejy.38.1648273803777;
        Fri, 25 Mar 2022 22:50:03 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id c5-20020a170906d18500b006ce371f09d4sm3064171ejz.57.2022.03.25.22.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 22:50:03 -0700 (PDT)
Date:   Sat, 26 Mar 2022 13:49:56 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v4 1/4] tools: arm64: Import cputype.h
Message-ID: <20220326054956.GB20556@leoy-ThinkPad-X240s>
References: <20220324183323.31414-1-alisaidi@amazon.com>
 <20220324183323.31414-2-alisaidi@amazon.com>
 <Yj4McMHsxtJ3PfKk@kernel.org>
 <Yj4bKHrmKhujZdpj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yj4bKHrmKhujZdpj@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo, Ali,

On Fri, Mar 25, 2022 at 04:42:32PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 25, 2022 at 03:39:44PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Mar 24, 2022 at 06:33:20PM +0000, Ali Saidi escreveu:
> > > Bring-in the kernel's arch/arm64/include/asm/cputype.h into tools/
> > > for arm64 to make use of all the core-type definitions in perf.
> 
> > > Replace sysreg.h with the version already imported into tools/.
>  
> > You forgot to add it to tools/perf/check-headers.sh so that we get
> > notificed when the original file in the kernel sources gets updated, so
> > that we can check if this needs any tooling adjustments.
>  
> > I'll add the entry together with the waiver for this specific
> > difference.
> 
> This:
> 
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index 30ecf3a0f68b6830..6ee44b18c6b57cf1 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -146,6 +146,7 @@ done
>  check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memcpy_\(erms\|orig\))"'
>  check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
>  check arch/x86/include/asm/amd-ibs.h  '-I "^#include [<\"]\(asm/\)*msr-index.h"'
> +check arch/arm64/include/asm/cputype.h '-I "^#include [<\"]\(asm/\)*sysreg.h"'
>  check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common\(-tools\)*.h>"'
>  check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
>  check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)* static_assert$"'

LGTM.  I did the testing on both my x86 and Arm64 platforms, thanks for
the fixing up.

Thanks,
Leo
