Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E557C4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Nov 2022 12:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKYM0Z (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Nov 2022 07:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiKYM0Y (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Nov 2022 07:26:24 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D210E4A5B0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Nov 2022 04:26:23 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id t17so3579115pjo.3
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Nov 2022 04:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nVO5GO2H97oMPcf7ZDtQkY3MrgflITF8Olle77iMyiQ=;
        b=WUMmVvzticzP/A6ao4DVyNOYzmnsKGO1cB6pmldXb+2ccgAFqxEwQlrD2VmvAz79uH
         ZDpL05LNgiUSsMHuq8O7g0hhe9HacSW+7XUQ5X0gqFTvDg69hEOltdBeLjkgzPTNB5fv
         E1WTA6y+8XzfWnuqpbAcGlE0E/Wtq+5yjz9zlA2byC6EqEeAzD5bljay5q62JOo+Nj2x
         nWZgeUXnOshl775vgmw393tX+46r3lODlhY53toeMcg4eO0B+XZsA2HWom05RQuuZNTb
         tG32tO1FzXToBtff+ZagFZucJSUzL1LSaXvGuv8NlTDuQPul6K8USRluDEefztd48zij
         iZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVO5GO2H97oMPcf7ZDtQkY3MrgflITF8Olle77iMyiQ=;
        b=YPwntmvietP5DFcM1S0yVuy21h8IAEPn4+ZSrVcW8jvg+++eF/OWob8BikO6w8uMgq
         dTGnRZ8FdfTspBx0SaXIWoP8CwzhnamIAiAoRLYRo5ekOpGEx4rhOMlC1hnQSnZLUCrn
         y+JqIdmP+56nbTdDehOmnBZ3fNKAcglUGFzKtEsaVHWdCFD9UO9UGIx/vfjy72F26EAB
         dida2RJPTqOfjPd1sGv4fkVhT6fBUt7zV/pgovrigSPNQia+F/xpZMVY9jXJhhMQSgJd
         yofasWgRzDJI3YU26kUmmrbN0pd/1RRbwItlix0MBZmGqea+5m5tJVk8nrz4aW71/ol/
         /1bA==
X-Gm-Message-State: ANoB5plMJKKF5VoiRtxPwaFHQdSB5zaL3DwJ6aNk6UCZ5+QEKppzhIQ1
        6PN+guQ2ICWMv5mkpywfnMm2og==
X-Google-Smtp-Source: AA0mqf6jr0MqqXyyqyUONB9+t73TvM6J1UXdmwAYpYGWSGrB9sTP9fK400T7cH/mY3Kq/npRqgh5VA==
X-Received: by 2002:a17:90a:7885:b0:20a:d81d:a8 with SMTP id x5-20020a17090a788500b0020ad81d00a8mr45705031pjk.177.1669379183206;
        Fri, 25 Nov 2022 04:26:23 -0800 (PST)
Received: from leoy-yangtze.lan (211-75-219-204.hinet-ip.hinet.net. [211.75.219.204])
        by smtp.gmail.com with ESMTPSA id h21-20020aa796d5000000b0056bad6ff1b8sm2987800pfq.101.2022.11.25.04.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 04:26:22 -0800 (PST)
Date:   Fri, 25 Nov 2022 20:26:18 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Marc Jorda <marc.jorda@bsc.es>, James Clark <James.Clark@arm.com>,
        Al Grant <Al.Grant@arm.com>
Cc:     linux-perf-users@vger.kernel.org
Subject: Re: Available Arm CPUs with SPE
Message-ID: <Y4C0RkbpGP4KX36C@leoy-yangtze.lan>
References: <2695ecbe-816e-eab7-8da2-30e0f62ae926@bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2695ecbe-816e-eab7-8da2-30e0f62ae926@bsc.es>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Nov 25, 2022 at 12:17:18PM +0100, Marc Jorda wrote:
> Hello,
> 
> I am trying to know which currently available Arm CPUs implement the
> Statistical Profiling Extension (SPE), does anyone know where can I find
> such information?

I don't know we have such kind of info, usually the most safe way is
to check SoC vendor's spec and confirm if Arm SPE is supported or not.

> As far as I know, it is an optional extension in Armv8.2, but I don't know
> if it is mandatory for newer versions. Is it correct to assume that all Arm
> Neoverse CPUs have this extension?

Yes, since SPE is an optional extension, my understanding is we cannot
100% say SPE is implemented in Armv8.2 and upwards CPUs (though it's
unlikely not to implement SPE in Arm standard CPUs).

To avoid to mislead you, I would like loop in James and Al for more
reliable answer.

Thanks,
Leo
