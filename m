Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C100C32771
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Sep 2022 16:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbiIZQNE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Sep 2022 12:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbiIZQMi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Sep 2022 12:12:38 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E621D0D2
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Sep 2022 08:00:44 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id v186so6949849pfv.11
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Sep 2022 08:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=luKDVnypX5afpIls8MMBXE0djWek8K+aFQk2eWpO7x8=;
        b=vqNdnbP5aU1mG0c+AQKSOVRqTpubW4jCvO5ebK4bwHmhzJWbm8gfoAMQF0e9GvxMGx
         zp2uPR/FP44ZsaRDC14M+Ux/8GkgSLJ06u+4uQJKtjsxSv7F9VBXX4mG067ccwgIaENU
         f3ztKBUUOfoo2ByPictMRlsCxqC0UN2OwQetfxXuUq7JIFxxViHcLj92qQ8nE9NdWE5v
         CxQsQOhwQBpk6xwTKLEJv4dsybnWz++lW6oTiKp7Pp4TE0nuAJYZ57Lwnfj+Wb47U9WI
         KIqVqpdfXsJlks7mFvlSqPiy9FLolX9Mp19L3yFBQanx0a8sK5yVPAm3Nojk+3pCZHhF
         gwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=luKDVnypX5afpIls8MMBXE0djWek8K+aFQk2eWpO7x8=;
        b=kr1XNyrk0PCw3nrM0CK+mdQEfccbXXBHzpylH/dggsT0/O+5KT6eq6GCZ33GAaYP5N
         ZH8s1fZwMUrB6IDDJ7B1GQGoU1tvZIDgVGCjI3pnYvG0AYiQ5kCCvH7rOV65Sl7pLhmW
         qMtXwh1AA/aTF24zQB+mAvXLEsVR+Z07KjcHcUsyx/PG0hOsmeB62x8qr+eJ03con15w
         fdlB+/rTRXYeVOP2qC0bHXNiKI6ipLc6k5Yk5ukaPqLJnT1BtMcSUSMghKcX3giE0abh
         Vo3jB+gJIWrYGXte1qJs07BG5Lo43s0r72fvIq2Vhp/5PHJgRRN1zFjA9zCV4W1Zvc8J
         N/QA==
X-Gm-Message-State: ACrzQf3C3NqvWgWFvntMGHPFgbdXVowE3HK/ki2vd/7rF1CJLLydhBHY
        EpJ9DAxqFYK9sDz/a7SBBZ+3Lw==
X-Google-Smtp-Source: AMsMyM4ud5Zg/B48WZpucWTo5+F7MQ58XBMCpIYmc6U4hmW6pz7wVglMHLQ7z4KHiTYnfnB3WmK2OA==
X-Received: by 2002:a63:1001:0:b0:43c:c4cf:470c with SMTP id f1-20020a631001000000b0043cc4cf470cmr2296378pgl.609.1664204443933;
        Mon, 26 Sep 2022 08:00:43 -0700 (PDT)
Received: from leoy-huanghe.lan ([137.184.34.254])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902e88500b00172f4835f60sm11344686plg.189.2022.09.26.08.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 08:00:43 -0700 (PDT)
Date:   Mon, 26 Sep 2022 23:00:31 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     renyu.zj@linux.alibaba.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, german.gomez@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mike.leach@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, timothy.hayes@arm.com, will@kernel.org,
        xueshuai@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH] perf arm-spe: augment the data source type with
 neoverse_spe list
Message-ID: <YzG+goZySC4K8S4Z@leoy-huanghe.lan>
References: <1664197396-42672-1-git-send-email-renyu.zj@linux.alibaba.com>
 <20220926141032.30734-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926141032.30734-1-alisaidi@amazon.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Sep 26, 2022 at 02:10:32PM +0000, Ali Saidi wrote:
> > When synthesizing event with SPE data source, commit 4e6430cbb1a9("perf
> > arm-spe: Use SPE data source for neoverse cores") augment the type with
> > source information by MIDR. However, is_midr_in_range only compares the
> > first entry in neoverse_spe.
> > 
> > Change is_midr_in_range to is_midr_in_range_list to traverse the
> > neoverse_spe array so that all neoverse cores synthesize event with data
> > source packet.
> > 
> > Fixes: 4e6430cbb1a9("perf arm-spe: Use SPE data source for neoverse cores")
> > Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> 
> Thanks for catching this, you're absolutely right.
> 
> Reviewed-by: Ali Saidi <alisaidi@amazon.com>

It's also good for me:
Reviewed-by: Leo Yan <leo.yan@linaro.org>
