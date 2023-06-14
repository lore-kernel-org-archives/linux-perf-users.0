Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0149FEB64D7
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jun 2023 01:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241935AbjFNBVO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 21:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjFNBVO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 21:21:14 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A569C123
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 18:21:12 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-54fba092ef5so837432a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 18:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686705672; x=1689297672;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y3HJWmlCMR1mIBGBb7/AYb1h6XObIBRabet2yfWnztE=;
        b=X5dobPDJnYA4qsiSCnbNMy3Qd3X24vOGeOijsRmwiSmAhqPvFzFUv8YsNVAJQRYTCK
         OG0G+OAn4yBfePLZuRE9/hrY7D8dHKcgkcZDL/Rxq2Ue9teISfGZYZly3x17QMrFOcWr
         imbBSz7GUnE34sN0C9nYJQsu2QkSFJs5xe9AFYat5MJEFBpLqGmGQBNiAD5/AAPyBszL
         xvE3Tw1jtFaSTe48CPGFTT84UXzW0bQRm500N2PvATCK07dFzZsmTF7SQT0rdwGA0KXn
         nJwu/46uQYWYAagJCQ1dAD07laSIkpXb8tTAA32aRcKe5gQ4anH3z/TDuYgoa/KM32ZI
         SMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686705672; x=1689297672;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3HJWmlCMR1mIBGBb7/AYb1h6XObIBRabet2yfWnztE=;
        b=NYB2WKeJ6Dnj2NzaLPoB7XxKm+KrSR4RUpJTr8LI6CVHvZdAd4N5isEdzm5AOWg4m8
         wgrcR7N2SMgMsHCu2c51ifWdxpA2d/u/p8j3DJl5pvKNMjGE1i9YSjPD0gWG/4Z3Vs4f
         dTvwMiyn2TTzluPiXHOnxZ+Lq0lNcDkdaFJfgS34lByy98Q0gatslnyYG9Ob3gDISjlP
         YUUMY8djrAlVPUKD0szJPp+5u/YNI6hzDceuGWk+BtO8uJ3MC3F3aSkGpP+Dl8gPuyJF
         Vge+HTqPnuY15u66HzK/yWM0BR9OZu2wHrQGZNAhhS9qhHF9M9CrRLBFVYIJZAKyhiYL
         65UA==
X-Gm-Message-State: AC+VfDwVlCjVraRl/iIZdYHNQ6pu29Mpc5teJQBNxRBjtjw2KuCOhz5j
        Acg9iuT2RWY3H3iXe2xkTJ0dIQ==
X-Google-Smtp-Source: ACHHUZ77FmKF2KF3zfAvn9yOFxa7gwFJaNMhe/QqB7w76JnhWGrn7nVqDRNPipewLg5s2/4md9D1pw==
X-Received: by 2002:a05:6a21:338b:b0:114:f824:655 with SMTP id yy11-20020a056a21338b00b00114f8240655mr376882pzb.58.1686705671860;
        Tue, 13 Jun 2023 18:21:11 -0700 (PDT)
Received: from leoy-huanghe.lan ([117.136.8.91])
        by smtp.gmail.com with ESMTPSA id n15-20020aa7904f000000b0063d29df1589sm4068515pfo.136.2023.06.13.18.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 18:21:11 -0700 (PDT)
Date:   Wed, 14 Jun 2023 09:21:02 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     =?utf-8?B?6JSh5rKF5L+h?= <fissure2010@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Cc:     James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org
Subject: Re: Some questions about using the perf tool in ARM-SPE
Message-ID: <20230614012102.GJ217089@leoy-huanghe.lan>
References: <CALDTKqiVNLHM8b21T-zikuNvhfE0N_-kEinpZGSRjSO-04R96w@mail.gmail.com>
 <874963e2-f97e-b463-1351-b00640b0f67b@arm.com>
 <CALDTKqg01+xJ2xu218c_QH2PbX9wdhYOiJfDieCXL5PHWV-6FQ@mail.gmail.com>
 <77773641-26e5-a754-63cf-e7d3443e11fc@arm.com>
 <CALDTKqgek3Bicxkvnq3BQnSaS2keQG6UK8S6_0oJn26r0D00MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALDTKqgek3Bicxkvnq3BQnSaS2keQG6UK8S6_0oJn26r0D00MA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Tue, Jun 13, 2023 at 09:23:33PM +0800, 蔡沅信 wrote:
> OK
> I have a new discovery that c2c seems to support only certain Arm
> Neoverse (N1/N2/V1) CPUs, I wonder if cortex-X4 could support it?

Based on Cortex-X4 TRM [1], we can see Cortex-X4 has the same SPE data
source packet format with Neoverse CPUs.  In theory, we can add
Cortex-X4's MIDR into the neoverse_spe[] array in
tools/perf/util/arm-spe.c to support Cortex-X4.

Linux master branch misses the definition for Cortex-X4's MIDR [2],
Mark.R / Suzuki / James, could you confirm if Arm has plan or already
has patches for enabling Cortex-X4's MIDR?

Come back to your current issue, as James said, seems the issue is
related with NUMA (or CPU topology) which is missed in your kernel
config, it's very unlikely related with CPU type, even Cortex-X4 is not
supported, perf should still work for SPE packets except data source
packet.  But your shared log is not related with decoding, anyway, you
can try below change to rule out if the issue is related with CPU type:

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 7b36ba6b4079..3c3a3846f253 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -527,6 +527,7 @@ static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 m
        else
                return 0;

+       is_neoverse = 1;
        if (is_neoverse)
                arm_spe__synth_data_source_neoverse(record, &data_src);
        else


[1] https://developer.arm.com/documentation/102484/0001/Statistical-Profiling-Extension-support/Statistical-Profiling-Extension-data-source-packet
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/include/asm/cputype.h

> Using the Arm Statistical Profiling Extension to detect false
> cache-line sharing | Blog | Linaro
> 
> Thanks
> Zack
