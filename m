Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C5EC433F5
	for <linux-perf-users@archiver.kernel.org>; Sun, 24 Apr 2022 15:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiDXPhC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 24 Apr 2022 11:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240088AbiDXPZO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 24 Apr 2022 11:25:14 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCB739B83
        for <linux-perf-users@vger.kernel.org>; Sun, 24 Apr 2022 08:22:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bv19so25159505ejb.6
        for <linux-perf-users@vger.kernel.org>; Sun, 24 Apr 2022 08:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JvwMaNfpyczcBz5FjlcmZ5tT4tBB4pJUkY5VC5Yl08k=;
        b=Z4XeHrbt4PNpBQEEW2O8Cv/abfRosw9nTHVB11JUPU+VcHQ/OsH2PeKK3Vb++6ZuP6
         Y1Iy2J5QaI3bzFjHOO+j8PtilLUjaceub84QlAlpbkbZZokSkx+q+r6/thQ3+Q+o3YhC
         VT/9LvC77zoZdQD9jcmHpOSpq7LMw6fFpXmrq1VCEabtEM8W7ghuHi10H3lHDkTOYrLE
         XEWkn6Hvu5pjOs5KDqh3hekPTVxDHcOsdWwwWsFQ0VQaVznN5wjm2Ria4Inx3bHlCoct
         bfJyC2GyYYkmQk8tPhX3gFHpoKCn7sKnuq7WgMUig3wjo7msJmasGUZYsnXL0ipCJBGx
         sJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JvwMaNfpyczcBz5FjlcmZ5tT4tBB4pJUkY5VC5Yl08k=;
        b=Rx5fODgRZiehwblaJ4NPhHQEqn0t/ODO5z1pGfQJyeR1KMc2lBa2owflYRsB/+5aEc
         oip3cD5inLNZ94ooI378SaXk85/gfWCYyeki6Lku261xpdDi4MLCz7x6lXH2mf+yQ3J0
         k5H4EKre33V1akzrbv6iaSiqhgavleO32+7uu/dNzSrA3dlWTI0n2ojVHNDdTBiAzBGu
         74dqYgsYrXwEyAu81JNBhMimMTCCOe5Toh0EQlYP4+vYRZeR34c2wwlZiWa75B2HkRez
         niVEel8lidCZqcbIs7Qd4DOXAiFuGtcH+hNIbvQmci6Iqbdv5j4pufAdpywUNzlrAgly
         aVog==
X-Gm-Message-State: AOAM532Yk20c47DPYTOqjIjFd6NFXkprSfyEGlIG1vp2fXgE+i+U6BIy
        5BwO2l6zTYqMfjEv3Ho93JSczA==
X-Google-Smtp-Source: ABdhPJzmw2hXC9+KxqcyIogQ1sGB29hYOGxq6qBBX2IiElUpSPzpeEwu7QAlHQ3yskB9NidScLhrew==
X-Received: by 2002:a17:906:66c8:b0:6e8:8b06:1b32 with SMTP id k8-20020a17090666c800b006e88b061b32mr12265608ejp.236.1650813732169;
        Sun, 24 Apr 2022 08:22:12 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id c13-20020a056402100d00b0042294fdbcf9sm3328082edu.14.2022.04.24.08.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 08:22:11 -0700 (PDT)
Date:   Sun, 24 Apr 2022 23:22:04 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Timothy Hayes <timothy.hayes@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 1/3] perf: arm-spe: Fix addresses of synthesized SPE
 events
Message-ID: <20220424152204.GA1810164@leoy-ThinkPad-X240s>
References: <20220421165205.117662-1-timothy.hayes@arm.com>
 <20220421165205.117662-2-timothy.hayes@arm.com>
 <20220424122831.GC978927@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424122831.GC978927@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Apr 24, 2022 at 08:28:31PM +0800, Leo Yan wrote:
> On Thu, Apr 21, 2022 at 05:52:03PM +0100, Timothy Hayes wrote:
> > This patch corrects a bug whereby synthesized events from SPE
> > samples are missing virtual addresses.
> > 
> > Signed-off-by: Timothy Hayes <timothy.hayes@arm.com>
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Supplement for fixed tag:

Since patches 01, 02 are fixing bugs, please add fixed tag [1]:

Fixes: 54f7815efef7 ("perf arm-spe: Fill address info for samples")

Thanks,
Leo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n138
