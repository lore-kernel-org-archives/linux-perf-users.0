Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C519CC77B73
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jun 2023 10:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjFEKRT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Jun 2023 06:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjFEKRS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Jun 2023 06:17:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C79FD
        for <linux-perf-users@vger.kernel.org>; Mon,  5 Jun 2023 03:17:14 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f629ccb8ebso1069598e87.1
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Jun 2023 03:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685960232; x=1688552232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TL8FrjBvLOB0J2ckzU5zDN3LDIwLONem+iih3uE7XWU=;
        b=ebkFPWdYNLaMUho9qkYIBITcTiBJ2nApjX+DQB0ZJVhlPjub8qj1PnFJA57FRIbhTh
         Z7Wg1ON57LiP5SF4kl0tH4W3es3l5CoZ/SNPFRmm189Z84uxrT68h0WxfQlGEyUT8Vc1
         BDMYxXGo/IzdFNVayXgK5Yrn3yfwgDaxWCxsN/GLhtUDy/+FnO0F6gTrbOn5banDbteP
         rFYM2TsS5omPUt3Rb9qjv/YrvC1YtrCWDZ8vB6cSf7hZE7RP2t62jTmTGCxCAYbOkZ18
         uzVi3DTe5rusrudnAQqcVkLSNnZWUtKQlyZMQ1AeRYAxdqHHQjjY4RfCm6Fhn2ZmaOjf
         H17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685960232; x=1688552232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TL8FrjBvLOB0J2ckzU5zDN3LDIwLONem+iih3uE7XWU=;
        b=XTpP+NwbvpLRxVYMPhsCpUPJcXqGkWe5NHG1M9OYPbtQpgACjmLgZCJo97a1Z9AYjl
         dv0jYcTc7AzxcNSdC9zcwK9ErbAkfLwUhaszfAhf0v/tCY9ftEnFs5uMsNQmufGLN6KE
         kIemFVqPW6ejYThgKNgd2oBXc4d851BaSG8n5QM6YOGlRBZExN5qRvNcIcLYm3OhEMsi
         zrwmUIuHzea0vf0jRw0jcG1R5B/AEJtAHUDlVVF2vi8xh8/sV9WMRS8m1WV9SFdSuiA6
         3VQwvtotIe8i4VpCcFm6FLYDX3oyqoRqYDiPGBiokh3vPX+M7EozMYv8BGntJjFXW+cd
         7gWQ==
X-Gm-Message-State: AC+VfDx/ayRFCBtMKPH4lsKZtfTa8g254F0z+VMsLp+uDrSHECUJ52H8
        NhjP+gztGzJq5HsLjdKsrbrjow==
X-Google-Smtp-Source: ACHHUZ5f5CSb1CXsNeNN9VuNkuNB/1isot/4az07Iw1a4lCB2CL9zour0PLPocTC3rUSKLr/qvO9fg==
X-Received: by 2002:a19:ac02:0:b0:4f3:b222:1eed with SMTP id g2-20020a19ac02000000b004f3b2221eedmr4624466lfc.2.1685960232283;
        Mon, 05 Jun 2023 03:17:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id bm11-20020a0564020b0b00b00514b2717ec6sm3766757edb.28.2023.06.05.03.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 03:17:11 -0700 (PDT)
Message-ID: <f24981d8-e384-e02e-8257-4b03b37e6c0e@linaro.org>
Date:   Mon, 5 Jun 2023 12:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [REGRESSION][BISECT] perf/core: Remove pmu linear searching code
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>, jolsa@kernel.org,
        irogers@google.com, bp@alien8.de, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <3abd3693-ad87-9abf-a762-337076638fcc@linaro.org>
 <ZH2KVyyC5oMr+Vk2@FVFF77S0Q05N>
 <20230605092731.GZ4253@hirez.programming.kicks-ass.net>
 <20230605101401.GL38236@hirez.programming.kicks-ass.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605101401.GL38236@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 05/06/2023 12:14, Peter Zijlstra wrote:
> On Mon, Jun 05, 2023 at 11:27:31AM +0200, Peter Zijlstra wrote:
> 
>> That said; given that this commit has been tagged twice now, I suppose I
>> should go revert it and we'll try again after a more thorough audit.
> 
> I'll go queue this then...
> 
> ---
> Subject: perf: Re-instate the linear PMU search
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon Jun  5 11:42:39 CEST 2023
> 
> Full revert of commit 9551fbb64d09 ("perf/core: Remove pmu linear
> searching code").
> 
> Some architectures (notably arm/arm64) still relied on the linear
> search in order to find the PMU that consumes
> PERF_TYPE_{HARDWARE,HW_CACHE,RAW}.
> 
> This will need a more thorought audit and clean.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks.

Best regards,
Krzysztof

