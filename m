Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE71C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 May 2022 12:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiEQMys (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 May 2022 08:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346762AbiEQMyi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 May 2022 08:54:38 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEA94D9D1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 05:54:13 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id fw21-20020a17090b129500b001df9f62edd6so220710pjb.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 05:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tjiV1xKHbPTP8VkdWgv75f9elF2yNt/M/Hgxyubwsvs=;
        b=jJAeyDDGVYAM6anJp5eoX+Bdo0+J99EROle8FXnCYomSg/lbrcKJLLjd6hcvwzDvUm
         6zr4/avmcBBW6EM5X3wFV/U9Ynp8o4RUuago9cZIMUpj55YnxmTwlBg3M+h97wI0fOiW
         49eJ9lwL8F26LCUDhVAeljV8Hs6OWpTO/V3DqQv1co1K45gP1DEyjY4J8OIac6KE3CY+
         /KjuLFXew+595Z8SpuJCTvFRgpYCLioPegnwmdHFMe8E8DcQGmo9mfKH2xHfuWJ4LNFn
         2BAwRhWXavX2UiGRAsGVfYBH2NLdqOAgqwTokZNJjG5RkOtC6E7gJuy4CpCBcNCc3NLg
         IQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tjiV1xKHbPTP8VkdWgv75f9elF2yNt/M/Hgxyubwsvs=;
        b=mRQZluc9MapbS3eu+YsdiIUBys8VzOEERNjjsjUOlb39ZO6ZmFT2zGqYgUoOJ3248p
         Qrbwa0LOHAJcwxm56KdW94uD/K/Q0pMo5Ca0Qld/mz1/teN2bRnjWXo4zzAuTcZ8TIeD
         +qJed0ZfI4y8z5YiOD+TGVKVMpMlChGmfJYpnOTVwV4q9yWv9R8sndEUoFxfP5biAK8+
         0Vx8TkrBQHGjKBxKYyiq2fuQNjBnCRFWrgLQQMzJDI4oeaDGv0KPMo5cLHtWgT1+G6aU
         1XnfFridMxbCZ73IGnADFUQYjNHQRVBu5MkFAMFXnf6IRLE5er1Ur3sHrMA4KXfmo0Ld
         BCiQ==
X-Gm-Message-State: AOAM533QbrDFJp93F/xBaLBBMwJXhLfVcgqiRfY9wcrsBG53NMtvHI20
        HVAIhRHTjh2ZPMP2jkPcnP+EcQ==
X-Google-Smtp-Source: ABdhPJyipCIyJ38tRbhMT94MHL3O0NMmglFB3vvh77tC+0eyDQ2a4pEKSzIHKnqG3HbX+LeUaMee2g==
X-Received: by 2002:a17:90b:1a8b:b0:1dc:e565:3238 with SMTP id ng11-20020a17090b1a8b00b001dce5653238mr24998790pjb.64.1652792052892;
        Tue, 17 May 2022 05:54:12 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([46.249.98.195])
        by smtp.gmail.com with ESMTPSA id gt13-20020a17090af2cd00b001df4b919937sm1598571pjb.16.2022.05.17.05.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 05:54:12 -0700 (PDT)
Date:   Tue, 17 May 2022 20:54:04 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        broonie@kernel.org, acme@kernel.org, german.gomez@arm.com,
        mathieu.poirier@linaro.org, john.garry@huawei.com,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/4] perf tools: arm64: Decouple Libunwind register
 names from Perf
Message-ID: <20220517125404.GD153558@leoy-ThinkPad-X240s>
References: <20220517102005.3022017-1-james.clark@arm.com>
 <20220517102005.3022017-4-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517102005.3022017-4-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 17, 2022 at 11:20:04AM +0100, James Clark wrote:
> Dwarf register numbers and real register numbers on aarch64 are
> equivalent. Remove the references to the register names from
> Libunwind so that new registers are supported without having to
> add build time feature checks for each new register.
> 
> The unwinder won't ask for a register that it doesn't know about
> and Perf will already report an error for an unknown or unrecorded
> register in the perf_reg_value() function so extra validation
> isn't needed.
> 
> After this change the new VG register can be read by libunwind.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Looks good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
