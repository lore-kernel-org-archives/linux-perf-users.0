Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467FDC38145
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Sep 2022 12:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiIHMoa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 8 Sep 2022 08:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiIHMoT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Sep 2022 08:44:19 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CB9E6230
        for <linux-perf-users@vger.kernel.org>; Thu,  8 Sep 2022 05:44:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o4so17646240pjp.4
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Sep 2022 05:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=khkD2dZzZ1EEcyqVqdCXrOdiAvPW7C2pQAJ2+w6ajfc=;
        b=G24+T71hHbRypj8u9LCRDMedhcqyK1IU0NXIT9GeHoIDnkHzYf6b8tKCBMsmBSGGI1
         ZHSoNdnvtkrtmj7+GgT02Tz7Euwof6zcruMiAAM2lZhO67Q5leUtR7+Wnl/zCBOi+AhX
         4iQrViZgH9hFLZi5GG5oSEATQZEuoM1MSF3YmwWEZcSaz8zCpo3T1WsoMlhbfrt1Pae6
         keBSbm/lzWialYu5kop6xuH+HLcomOtg3GQvpPrclERbTuhfXN7bymLzhT65I+Vw6cds
         +ILKJRLI1xKsvKKRXdJYwHWp9COvXG4+/XWwVzs4rGF1bWwiypjchPbw4bC9iY2LI3wK
         LSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=khkD2dZzZ1EEcyqVqdCXrOdiAvPW7C2pQAJ2+w6ajfc=;
        b=oon7VpfzFcx1/aoKdO3YItFX+oHX8xBKpKxDbOFfDo1Xv/KD0eApIw9F1gu8cootS+
         fbqnR1GbSu7Bjg2b3LYsjMaAxMU/6R2kC85Hh3S12SAML/urrbmAthcvqxMYed2EnS+F
         +/laM3sa6gMJFMFdVv/OXOXqkq7z9nzfGjzcX8bAZf8TgfK1ICARrGhYVE3FuxB9/3BT
         xNIu5caaOgFvwHoPvDmETgZm35JwxbHWEAq6OHsi7B6fkGjTJFXRlSEQ6MOhBn2nY5TF
         RCfPMRAdXDivaKebpb/YD7b8ajHM9OOlV9vHZwkpUHsUQLu1MRWW3+5zRdv+kDdZB4CP
         IkMg==
X-Gm-Message-State: ACgBeo3PP+s5tGHXTAi3spvXauN5dY3y8JxcBQWTe5V79XiRcOB/MEQa
        mgul1N+VZSIiRKNXsBpA5KU2WA==
X-Google-Smtp-Source: AA6agR7MWp6ExrMDeku20UJ0zL1Z+aO74rWDLTG8O9WLEJoy0GLnr9VEy6q72voqmO5PrRAhhtvcRA==
X-Received: by 2002:a17:903:2282:b0:177:faeb:3606 with SMTP id b2-20020a170903228200b00177faeb3606mr1029332plh.135.1662641057008;
        Thu, 08 Sep 2022 05:44:17 -0700 (PDT)
Received: from leoy-huanghe.lan (ec2-13-208-210-110.ap-northeast-3.compute.amazonaws.com. [13.208.210.110])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090a664300b001fd803f057bsm1640126pjm.33.2022.09.08.05.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 05:44:16 -0700 (PDT)
Date:   Thu, 8 Sep 2022 20:44:11 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH v8 02/13] perf test: Add build infra for perf test tools
 for CoreSight tests
Message-ID: <Yxnjm7sA2Uit0X1M@leoy-huanghe.lan>
References: <20220906103044.761250-1-carsten.haitzler@foss.arm.com>
 <20220906103044.761250-3-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906103044.761250-3-carsten.haitzler@foss.arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Carsten,

On Tue, Sep 06, 2022 at 11:30:33AM +0100, carsten.haitzler@foss.arm.com wrote:

[...]

> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/Makefile
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +include ../../../../../tools/scripts/Makefile.include
> +include ../../../../../tools/scripts/Makefile.arch
> +include ../../../../../tools/scripts/utilities.mak
> +
> +SUBDIRS =
> +
> +all: $(SUBDIRS)
> +$(SUBDIRS):
> +	$(Q)$(MAKE) -C $@
> +
> +INSTALLDIRS = $(SUBDIRS:%=install-%)
> +
> +install-tests: $(INSTALLDIRS)
> +$(INSTALLDIRS):
> +	$(Q)$(MAKE) -C $(@:install-%=%) install-tests
> +
> +CLEANDIRS = $(SUBDIRS:%=clean-%)
> +
> +clean: $(CLEANDIRS)
> +$(CLEANDIRS):
> +	$(Q)$(MAKE) -C $(@:clean-%=%) clean >/dev/null
> +
> +.PHONY: all clean $(SUBDIRS) $(CLEANDIRS) $(INSTALLDIRS)
> +

I observed that git reports warning when applied this patch:

Applying: perf test: Add build infra for perf test tools for CoreSight tests
.git/rebase-apply/patch:107: new blank line at EOF.
+

The last blank line is redundant, it's good to drop it.  When you fix the
warning for rst doc file, you could fix this together.

P.s. at my side, git can automatically fix the redundant blink line
since I added "whitespace = fix" in my gitconfig.

Thanks,
Leo
