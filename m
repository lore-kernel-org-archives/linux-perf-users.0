Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDE1C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Nov 2022 09:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiKXJuf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Nov 2022 04:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiKXJud (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Nov 2022 04:50:33 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7535BF608B
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Nov 2022 01:50:30 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so1165058pjj.4
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Nov 2022 01:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YwlHubOhSOM48f58ZZDltroPaPuhMC5Q9GaNSjd7Sr8=;
        b=Rr+cv2/zay90nGt1EYoKkV1/qnJ4WFUmDzJC0dzJ7dUl6prsdedVzh1vZ3fDRxwpy8
         IZLKTqQev6Rm9fzK0d3KltLsK9n6iA7dwZw8Bclgp/IlO53lNWOkD3vEvGhxZT0yFGH3
         JT6tFihpzWmO6TKv5dTZ0yvqOgUdy1yenpBvQa2MXzZUBbpmCky7IprV2g4hswelxkKH
         QQ5aQZs1Wm4XC/2c7xIyvztDUCuuJWhZEq8l5oEFCq2V/Sm+u9r6z3BO9GKTdVtUfIFA
         dPMTbxXRBGFZy5iAbhT2O7ufwNgexwYogQDSRIEqAZwgR728RXoxoLVpjfL/WZatYzfl
         tkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwlHubOhSOM48f58ZZDltroPaPuhMC5Q9GaNSjd7Sr8=;
        b=Nqk2N0DVSUsrkN78/aVGTCeVZJCThvvCF1Q5znzZIvhrRQPCn7HmGwJyYQ40eY4afr
         rFOlbsEzn1UeRFFtCa+rp9e/v6JqXCdE5aTCK1Dipb/H/QlNYzpq5c4vfXniGEXULKc9
         fOnXjMZA0R58ogBjGWKMEKUJp1o/L2OaOS/2kviOnNqug+oFmgpBRRZiyA4QYy7WhgZl
         3PNxjNaP6CJ8aoON0xHxOhiVzbQf9eAAo8L9Zv7uFAv/c51v7sNe4TtFnpqlOzQ728yQ
         B91ptf9vvJHDc3bNaF3xMtcdXIeR5NIK1Lene9h/vmc1YwYroCn2ekfaLgB7w2Z8uo0x
         mOfQ==
X-Gm-Message-State: ANoB5pkMsiXIczu7TLwKyFUIKA1HClLAWPHW2/OijkEFxPqaB94Y8j6o
        LKs+hjhkMrs1vi9fosF3xC7Qlw==
X-Google-Smtp-Source: AA0mqf4cDnMhArUWyJreeAiUo8r0X63oCB5cDvAyvFtjKz4a2o89ybnEFOGJu83vtnixfGiLQ8HxuQ==
X-Received: by 2002:a17:90b:4a48:b0:213:a9e6:dadf with SMTP id lb8-20020a17090b4a4800b00213a9e6dadfmr34714788pjb.108.1669283429903;
        Thu, 24 Nov 2022 01:50:29 -0800 (PST)
Received: from leoy-yangtze.lan (211-75-219-204.hinet-ip.hinet.net. [211.75.219.204])
        by smtp.gmail.com with ESMTPSA id s67-20020a625e46000000b005743b5ebd7csm794090pfb.92.2022.11.24.01.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 01:50:29 -0800 (PST)
Date:   Thu, 24 Nov 2022 17:50:23 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, rostedt@goodmis.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        srivatsab@vmware.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com
Subject: Re: [PATCH] perf symbol: correction while adjusting symbol
Message-ID: <Y38+NGjF1tZNHkwr@leoy-yangtze.lan>
References: <1669198696-50547-1-git-send-email-akaher@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669198696-50547-1-git-send-email-akaher@vmware.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ajay,

On Wed, Nov 23, 2022 at 03:48:16PM +0530, Ajay Kaher wrote:
> perf doesn't provide proper symbol information for specially crafted
> .debug files.
> 
> Sometimes .debug file may not have similar program header as runtime
> ELF file. For example if we generate .debug file using objcopy
> --only-keep-debug resulting file will not contain .text, .data and
> other runtime sections. That means corresponding program headers will
> have zero FileSiz and modified Offset.
> 
> Example: program header of text section of libxxx.so:
> 
> Type           Offset             VirtAddr           PhysAddr
>                FileSiz            MemSiz              Flags  Align
> LOAD        0x00000000003d3000 0x00000000003d3000 0x00000000003d3000
>             0x000000000055ae80 0x000000000055ae80  R E    0x1000
> 
> Same program header after executing:
> objcopy --only-keep-debug libxxx.so libxxx.so.debug
> 
> LOAD        0x0000000000001000 0x00000000003d3000 0x00000000003d3000
>             0x0000000000000000 0x000000000055ae80  R E    0x1000
> 
> Offset and FileSiz have been changed. 
> 
> Following formula will not provide correct value, if program header
> taken from .debug file (syms_ss):
> 
>     sym.st_value -= phdr.p_vaddr - phdr.p_offset;
> 
> Correct program header information is located inside runtime ELF
> file (runtime_ss).
> 
> Fixes: 2d86612aacb7 ("perf symbol: Correct address for bss symbols")
> Signed-off-by: Ajay Kaher <akaher@vmware.com>


Just curious how you can produce this issue?  IIUC, the runtime symbol
files are copied into .debug folder and they can be found by perf tool
by matching build ID.  Seems to me, you manully use
"objcopy --only-keep-debug" command to strip runtime info from elf files
under .debug folder.  Do I understand correctly?

Though I have above question, this patch itself looks good to me,
thanks for the fixing!

Reviewed-by: Leo Yan <leo.yan@linaro.org>
