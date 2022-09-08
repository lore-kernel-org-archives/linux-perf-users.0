Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D625C54EE9
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Sep 2022 12:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiIHM1l (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 8 Sep 2022 08:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiIHM1j (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Sep 2022 08:27:39 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F640E5831
        for <linux-perf-users@vger.kernel.org>; Thu,  8 Sep 2022 05:27:37 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso2240479pjk.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Sep 2022 05:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=pQPlhLxrKUNUGTT4UOEL+mGa9lFxIOncWroqIuDltN8=;
        b=tW20rFmZpvEE9PcDR25OPbtNdACwy3ALWQtURbFgjo2pAxM1JTivGbbWy8H0uyZ3CL
         tp9Ya/o0+yNCPCHPT8AQKImBMvWjQC0mFABjicY8thJm7L/PkfMNPmZrA8tT6sk1kGJm
         wi1Rrp3XXCI/mzh6gKqa+j71V4tKCr4WVxYrrLM8VTsnmUfUgguxf/8j0Kk1ZWdO9jcG
         6vgFIn4ZUSm6WHNQi94RiI5O5a/UbJVhriXr5K2S0bb/sGl/jqEYC8F1TIA28lIRt0+V
         iJPOgtQ7jh/rgsd2hHHOrlAlplQlPyNFE+alrCBg9OoMWHwOgmA1anuPNbP3XF1uscf4
         kRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=pQPlhLxrKUNUGTT4UOEL+mGa9lFxIOncWroqIuDltN8=;
        b=ZRmE/zB5qZIuq1wuvxdyg66Gn4tjzBGyS7MURqx0GvmTS2BZDK/6Qc4ts+otVfSA6t
         iB1QngKE9Ro+tzyVWJ9mhPz9ti+vdwSh9wLTVq9Fy+CtEuUWhTsyAW65rr4hH/Nze96v
         xVKtzMBNalD7JKjL0j2c6A5DBHkZ5Jz1wigKBNXSzVEn79MlNorng79zE4KrT+zyMoC8
         EJnb6CMCLTtt6I3Ev1aokD3ii9lmigVF4zhAu3D0dVa4CmCWF1K4HvA1iM9KQH5m50aa
         X9MlC0a9jPE2KoFGQSkPgdo883Km0phAHPMAvS+n8uyVJfuC1YJv05LT8FJSlFaAs1pr
         /G4g==
X-Gm-Message-State: ACgBeo3BmbLU38gSNhIxgXLid3ORFW05j2osmi7+f4YiUEtTW5Tad5vJ
        3uXQNF2xLHptG0No5Bz5OcYS3Q==
X-Google-Smtp-Source: AA6agR5E+bAEHThTzp/7s2iat30vdE5DsbUgfAc82lgbf2JJS+5Tz54CTRthqTfQAcxepyz108I4Vw==
X-Received: by 2002:a17:90a:5783:b0:200:4aa8:a18d with SMTP id g3-20020a17090a578300b002004aa8a18dmr4100091pji.38.1662640056827;
        Thu, 08 Sep 2022 05:27:36 -0700 (PDT)
Received: from leoy-huanghe.lan (ec2-13-208-210-110.ap-northeast-3.compute.amazonaws.com. [13.208.210.110])
        by smtp.gmail.com with ESMTPSA id x14-20020aa79ace000000b0054087e1aeb4sm1621200pfp.111.2022.09.08.05.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 05:27:36 -0700 (PDT)
Date:   Thu, 8 Sep 2022 20:27:31 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     kernel test robot <lkp@intel.com>
Cc:     carsten.haitzler@foss.arm.com, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH v8 13/13] perf test: Add relevant documentation about
 CoreSight testing
Message-ID: <YxnfZSeYzPCJzIp9@leoy-huanghe.lan>
References: <20220906103044.761250-14-carsten.haitzler@foss.arm.com>
 <202209071000.s5lvO8sV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209071000.s5lvO8sV-lkp@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 07, 2022 at 10:59:55AM +0800, kernel test robot wrote:

[...]

> All warnings (new ones prefixed by >>):

Thanks for reporting!

> >> Documentation/trace/coresight/coresight-perf.rst:102: WARNING: Inline emphasis start-string without end-string.
> 
> vim +102 Documentation/trace/coresight/coresight-perf.rst
> 
>     96	
>     97	   CoreSight / ASM Pure Loop
>     98	   CoreSight / Memcpy 16k 10 Threads
>     99	   CoreSight / Thread Loop 10 Threads - Check TID
>    100	   etc.
>    101	
>  > 102	These perf record tests will not run if the tool binaries do not exist
>    103	in tests/shell/coresight/*/ and will be skipped. If you do not have
>    104	CoreSight support in hardware then either do not build perf with
>    105	CoreSight support or remove these binaries in order to not have these
>    106	tests fail and have them skip instead.
>    107	

Hi Carsten,

Just note that I reproduced the warning at my side; after I used the
escape for '*' like below, the warning can be dismissed.

  tests/shell/coresight/\*/

Thanks,
Leo
