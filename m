Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67610C19F2A
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Aug 2022 04:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiHGENM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 7 Aug 2022 00:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiHGENK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 Aug 2022 00:13:10 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51240B1EA
        for <linux-perf-users@vger.kernel.org>; Sat,  6 Aug 2022 21:13:10 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 130so5497598pfv.13
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Aug 2022 21:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CBDQhy2aeTBlls3zoFxkclz+Cxr66E9lxfgdg+Soit4=;
        b=jcxUoZ3UyqFjnh/HaMnXn5NDV+gcKq+Iw9EHZkFbZxOBPhj6Wq1vV6Gr7UWQm2748l
         CLD+1mJTBWpFe16fDs688C0UhooC2p7ilflGR7IMirfwYzO3N1WWt0jpPnd2nzlhElfk
         zyPRi/uXeyDjHKP9sl27daaEt5NvW8AJiIcQ/QwlLR3JuOGbi3Im+x4cKru8FvVJqd1w
         j7NMzwYMkdGg1BC2fcZqZXx+0+rlbvvmgr5kBb/jHILXM2gYloBgXchf5dNZlxWfW66S
         OxdLT9soq2y/YwF8zaVGBOw7wIyk8H4V9vIzUegbMydk7pdB4AJ6vHWK4KZlItoISh3n
         sVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CBDQhy2aeTBlls3zoFxkclz+Cxr66E9lxfgdg+Soit4=;
        b=eFtHdZg8AgPfljEqzcsToQCwZkP8TlVjRwO1faKHriQDuafYAB5H1TBiulAqzo4ciB
         dAKoPeGnbuzD0sJ0IyPqRWE9ug+qZ6oQW4RcKKNIvOkAAzOEAeGFJN4ileHDXA4+u+3E
         rjSmgp+fEmSnfBGKxweB06opViWQXFDT0qb2TFLfEVuEd043FCsK41Yh4sJZiHSd+7Gp
         9tvbBizJpI4WuNE77PSAgbI5KOSbH9D9AUtuNwM7Vqr1eTGnLt8hFHBPXrFfqlllz7bP
         60dauqrzsR7//8RHP5MECzVCNzFuAmD3klSjX51oMf3v5/rcSdxzJcmxQk+keH2UWwWV
         uEdw==
X-Gm-Message-State: ACgBeo2L3e7TFujGrAOTPa7PH65cpCaSdFgJf/Yw+d6w7B3TPQPis5lp
        cvj9Pi3OLGRi/vAQL8yZMomY0B+nLxB0LQDPbf8=
X-Google-Smtp-Source: AA6agR4xM1graXn3qBWOTqN+0KOZYoY0qycaShmmYXTZREj3ga8V2FDckoxQnxxHqbLKr1ESetTqKg==
X-Received: by 2002:a17:902:da92:b0:16e:f4a4:9f93 with SMTP id j18-20020a170902da9200b0016ef4a49f93mr13571528plx.27.1659845578988;
        Sat, 06 Aug 2022 21:12:58 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (173.242.120.104.16clouds.com. [173.242.120.104])
        by smtp.gmail.com with ESMTPSA id f10-20020a170902860a00b0016d33b8a231sm5697014plo.270.2022.08.06.21.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 21:12:58 -0700 (PDT)
Date:   Sun, 7 Aug 2022 12:12:54 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH v5 08/14] perf test: Add memcpy thread test shell script
Message-ID: <20220807041254.GC34254@leoy-ThinkPad-X240s>
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
 <20220728145256.2985298-9-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728145256.2985298-9-carsten.haitzler@foss.arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 28, 2022 at 03:52:50PM +0100, carsten.haitzler@foss.arm.com wrote:
> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
> 
> Add a script to drive the threaded memcpy test that gathers data so
> it passes a minimum bar for amount and quality of content that we
> extract from the kernel's perf support.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
