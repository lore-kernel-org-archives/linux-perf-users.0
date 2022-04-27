Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF52C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Apr 2022 16:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241389AbiD0QDv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Apr 2022 12:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241576AbiD0QDj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Apr 2022 12:03:39 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C6F289378
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Apr 2022 08:59:50 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id j17so1938737pfi.9
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Apr 2022 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=B7bCPSAqni/eXnk1LqJkGqy1IOK7BdN/WKgexnP+sSs=;
        b=wm5xTSYCz9ImGQOBbgtUP1ff6okO5z5MEKS4Ra9Q+9ZGRX4Sh2LozU7GiIrBErvXAR
         3+Sv9iMqS+IT+wyhnbLG1cg59xi8BU96rjrfGqmrslU5A1fQ8/9xQpyxAsqScgLnvusw
         haUA8dCRMZgbI5h2voBta7cefY4wYB+UQRRLm9fESog4XJpY0cjCQHVsNN+H7teOrdSU
         SSajLEtZzEFwrOHv6JT22Qdii4pXDEzZwU5bxCebqkwdMdpJegLzdSOd3+GQUfjhqiSu
         iGt31/fPbboUzAhv9SpTWYKuJ9HhuIu1o6fNCofEufP/1VaBAOrVOauzGH3I7cq+f0uv
         EXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=B7bCPSAqni/eXnk1LqJkGqy1IOK7BdN/WKgexnP+sSs=;
        b=wz287CLY6Am8t0Io5DaUX/yRqBxIXxeXOIX97j8g/WIOMMr7FJeTItBakeHj7JAArN
         L40GcZ8bplPHfX1oIYbPDYJenjGqoE7CLW6C04mAewlX0CSrgmWkKK/gXgXdZTkCs7Qa
         QfYBB3L8MD76cD9DOGdiMGB9bx8jWt8V5ooYVojE7F+0FEeghDsS2Ds+h8sOneCEK70J
         izvt/ZD1Z2Ose7MpJe98m5pfCJZBGrHnadiTJMwKoGxF/GjvizBcLN0W3Gd8083OnRZY
         j45vbmSSxA/YjVmuQ9Jfm6QhtAg45/EG/8zE2urePoJOyJwTHNqSoHp2ApMO9S/ffyaG
         mnhg==
X-Gm-Message-State: AOAM533tpLk+KLEFQ+luD9E7ZQnjOoTsuhs31lrqvbPGLh+dDTKLld3C
        PzooRd2FIctQ8jgA6E4I/4RqBg==
X-Google-Smtp-Source: ABdhPJymOsPeD6HUMpzYXIRJtQHQErVz91u2xNJ09OSkyp0fxCsF6Ms6ClrJB2T8aUxViCrzVmZqNQ==
X-Received: by 2002:a62:2742:0:b0:505:89a5:2023 with SMTP id n63-20020a622742000000b0050589a52023mr30923743pfn.18.1651075183688;
        Wed, 27 Apr 2022 08:59:43 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id k198-20020a633dcf000000b003aa9116ba17sm16707374pga.35.2022.04.27.08.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:59:43 -0700 (PDT)
Date:   Wed, 27 Apr 2022 23:59:34 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        acme@kernel.org, benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v7 5/5] perf arm-spe: Use SPE data source for neoverse
 cores
Message-ID: <20220427155934.GC562576@leoy-ThinkPad-X240s>
References: <20220426135937.18497-1-alisaidi@amazon.com>
 <20220426135937.18497-6-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220426135937.18497-6-alisaidi@amazon.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Apr 26, 2022 at 01:59:37PM +0000, Ali Saidi wrote:
> When synthesizing data from SPE, augment the type with source information
> for Arm Neoverse cores. The field is IMPLDEF but the Neoverse cores all use
> the same encoding. I can't find encoding information for any other SPE
> implementations to unify their choices with Arm's thus that is left for
> future work.
> 
> This change populates the mem_lvl_num for Neoverse cores as well as the
> deprecated mem_lvl namespace.
> 
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>

I tested this patch and also did the integration testing with perf ć2c
tool, this patch looks good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>

James, German, it's better if this patch set can get the green light
from you.  So please take a look, thanks!

Leo
