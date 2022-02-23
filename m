Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94868C4167B
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Feb 2022 01:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbiBWBPK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Feb 2022 20:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbiBWBPK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Feb 2022 20:15:10 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24513B01B
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Feb 2022 17:14:43 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id h15so24199488edv.7
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Feb 2022 17:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DNij7dJZj5zCpqmuUWdIbA82PPs/8sAPmCNMapkES6s=;
        b=XNspZZ4driA4cb2FKagm4/dWDOnodKxf+OlobbFuUf8VqQkTUrI4L+94mfIP+VU5lS
         omlhFibWic8kSV97vsaLuQs/u0HoESkoOrDFKA9ipYeYB22OExU6AEswJ1FRgW5r+nYW
         1n1HgpWnoPj2VblVKVuPMFn6SjEanltt9efvK7zczVo87/IHGED+Y01JDdO63DJfIBTu
         4paJX+NOPmwk2OXHNradQ5SEVcaDuUZLbIYGpk6lPW0+kGhJtn7SfuwwKAm2Qecgwi4s
         Zx5W5K0IQkKAVVZGC8uGWEtcLrUzGo7c0l81pl4ZTUxoEbpqZluGwGbcgxH1cGKmgB35
         E5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DNij7dJZj5zCpqmuUWdIbA82PPs/8sAPmCNMapkES6s=;
        b=md16/IR4IKIiu5vjraJAAp/xwPbRkWR7H7cNVDPMKo9T1pZgZ8fByjd/h+I4r2B5X7
         sYZZwpI+934HEb7KAzJ8hACslwfN4kD+bNd2t+hjMTPyiRlAHUYLvg1niDUuC1TqphVH
         DhZZmNPI43/D4w3RJD1BBixd/S2qA2EagLjMAk2cgDGx4+BCHo/WBA1oZ8rCzOmQ+86E
         vXxUVfmNscY8t1cA7jVFW4mvFHHwcp+fA4y4GvJK6p2Y2qbdKzHUGbVP4AmD0OZOecEz
         k+AEVfNFvQSL4/I7lag5mSj0Kcz5rGFTJsZgHWWtUlRtWJvDKZJIBLNlIUsPMKFoS7e+
         Gh6A==
X-Gm-Message-State: AOAM5334iOv0xCJm1p6HVMipV1AG+z0Chr19Ghp/1B+Rl79dbohqEPAu
        veomVlJ7aG4sSOP1g3eC0fCfOQyue16yplxbHKE=
X-Google-Smtp-Source: ABdhPJzFf7MKIat98fe1ra0oh3XxS6M4SiPYcL3oOvRcS3tqDQFQR0ugtEpr0i1sUZvufrEyRCc+gA==
X-Received: by 2002:a05:6402:278f:b0:410:d242:465e with SMTP id b15-20020a056402278f00b00410d242465emr29984419ede.292.1645578882145;
        Tue, 22 Feb 2022 17:14:42 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([104.245.96.223])
        by smtp.gmail.com with ESMTPSA id n25sm10775059eds.89.2022.02.22.17.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 17:14:41 -0800 (PST)
Date:   Wed, 23 Feb 2022 09:14:36 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf arm-spe: Use advertised caps/min_interval as
 default sample_period
Message-ID: <20220223011436.GA414932@leoy-ThinkPad-X240s>
References: <20220221171042.58460-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221171042.58460-1-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Feb 21, 2022 at 05:10:42PM +0000, German Gomez wrote:
> When recording SPE traces, the default sample_period is currently being
> set to 1 in the perf_event_attr fields, instead of the value advertised
> in '/sys/devices/arm_spe_0/caps/min_interval':
> 
> Before:
> 
> $ perf record -e arm_spe// -vv -- sleep 1
> [...]
>   { sample_period, sample_freq }   1
> [...]
> 
> Use the value from the above sysfs location as a more sensible default
> (it was already being read, but the value not being used)
> 
> After:
> 
> $ perf record -e arm_spe// -vv -- sleep 1
> [...]
>   { sample_period, sample_freq }   1024
> [...]
> 
> Signed-off-by: German Gomez <german.gomez@arm.com>

The change looks good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
