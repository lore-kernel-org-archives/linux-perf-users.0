Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BD8EC8748
	for <linux-perf-users@archiver.kernel.org>; Sun, 10 Sep 2023 09:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345684AbjIJJWM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 10 Sep 2023 05:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbjIJJWM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 10 Sep 2023 05:22:12 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CED4184
        for <linux-perf-users@vger.kernel.org>; Sun, 10 Sep 2023 02:22:07 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3aa1446066aso2470882b6e.1
        for <linux-perf-users@vger.kernel.org>; Sun, 10 Sep 2023 02:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694337726; x=1694942526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F7KmoimTZXBn7xxEa4JoD6DLQsYP/FrWOgfaS5hIz0M=;
        b=FQHsx4WS6KrDjMGAM+iUFk3rdg33j0Izz3gD3zOTLh0za4o5zwMEFFES/7fqmp9I5S
         JbntrPsgKVDyiDFKjJsGu9dBvak9KNTMMTT1hqFvZ1jcydAbYNTueg+vN2EmsbCsbFsy
         gEo/L3lCzlQOkD6JEkhPc10iRl6H1v66Vux6H0HuFopGfiflwSnN3J72fnTIE397CzcQ
         d6mlTTX2moVaqUAEUZBGBL6a9PvBt4FkllbMvCIFZV5ltAkApFLhmVXiI5sC6mTHEXtz
         Y0FoDiRztw41n3I+Dkqe0bfK+qQgkbXja9QbNVtKXVc6JLZLPALSx1yzX+bPXCE1XE7D
         Uk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694337726; x=1694942526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7KmoimTZXBn7xxEa4JoD6DLQsYP/FrWOgfaS5hIz0M=;
        b=iPXHZ18z8un1uyCrGfE86Djq6Y/TQUd5v/kRIdRGoAvUUZ/B9rouqVcU14t8+XPSkO
         F7mOpKfoIzKbtC4GKtD/nVmBt4+lmWq+xBGEWBtfemuyHDyzvDAoEBf//8g9D1G4DyS1
         lcsh1OIm4t02gp7AcjRSVW3EmfU/mn484szM8ZPlOvfCPrjqTKc3CjkPcetyBiAUF9Ay
         d0s1DijPfArlGI/IOd0rlcfqfS41sfYL9RbA7ZEF3iM+b637a4af9oRmkKWWGFrxvSe0
         vOzK34retquGHmIsIshhG/G8GRFRaGRnGlywOXeuq1tIDY0Gs4QjblOiZ+nNaV84RjEe
         1tVg==
X-Gm-Message-State: AOJu0YxIoNJmBrjAM5uULm8dceBplCWTeULM46wxkEa71cZD7EgFhNWO
        iEYEKxWRggKArhbTAgeGwwehwQ==
X-Google-Smtp-Source: AGHT+IEtF3iC/N+5TNNRC07S/EAfYtFzU+WyK//BgA8OVKmPnpzu4mk4hiYrDRGGJDzoNWuNfC03Ag==
X-Received: by 2002:a05:6808:b3b:b0:3a7:8e05:1699 with SMTP id t27-20020a0568080b3b00b003a78e051699mr8498783oij.37.1694337726511;
        Sun, 10 Sep 2023 02:22:06 -0700 (PDT)
Received: from leoy-huanghe.lan ([98.98.49.29])
        by smtp.gmail.com with ESMTPSA id d5-20020a63a705000000b005633311c70dsm3607356pgf.32.2023.09.10.02.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 02:22:05 -0700 (PDT)
Date:   Sun, 10 Sep 2023 17:22:01 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf cs-etm: Bump minimum OpenCSD version to ensure a
 bugfix is present
Message-ID: <20230910092201.GA52362@leoy-huanghe.lan>
References: <20230901133716.677499-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901133716.677499-1-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Sep 01, 2023 at 02:37:15PM +0100, James Clark wrote:
> Since commit d927ef5004ef ("perf cs-etm: Add exception level consistency
> check"), the exception that was added to Perf will be triggered unless
> the following bugfix from OpenCSD is present:
> 
>  - _Version 1.2.1_:
>   - __Bugfix__:
>     ETM4x / ETE - output of context elements to client can in some
>     circumstances be delayed until after subsequent atoms have been
>     processed leading to incorrect memory decode access via the client
>     callbacks. Fixed to flush context elements immediately they are
>     committed.
> 
> Rather than remove the assert and silently fail, just increase the
> minimum version requirement to avoid hard to debug issues and
> regressions.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Tested-by: Leo Yan <leo.yan@linaro.org>
