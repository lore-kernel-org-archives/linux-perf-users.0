Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7502EC433FE
	for <linux-perf-users@archiver.kernel.org>; Sat,  7 May 2022 08:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383638AbiEGIKN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 7 May 2022 04:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359089AbiEGIKI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 7 May 2022 04:10:08 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483A621E10
        for <linux-perf-users@vger.kernel.org>; Sat,  7 May 2022 01:06:20 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 7so7899926pga.12
        for <linux-perf-users@vger.kernel.org>; Sat, 07 May 2022 01:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aWQfnp8p3Sa/CZYziUv8sJFvgH/DhWMow1Ki0jzKInQ=;
        b=d7sa/vJyLfF9BR72n72H6iTcORw0kbeaXS21B2+FXdbG66FYCW7FBC02LCRup2bO0T
         VbztyRzKE447Dsr5bQyIcT/N6Q1+c4/IXMaJT3GrJsKz9ltWgOCmeIOcoalYl/8o+V6Q
         JCxhKqmLoYC0fCUjLs/ACK38p33kuWfTfdyYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aWQfnp8p3Sa/CZYziUv8sJFvgH/DhWMow1Ki0jzKInQ=;
        b=wP9KbCUsRC7MBb0RegfUx7RHg5DCbNysGhXWct16foGTIiPKyIqq+hZh+wqgAdvFfc
         ZWNkyIBNgGYrowqPXo/9v5tu3SqLUIXhQui6FjfQkdQu5sUJL7AYzbAZbVHB1HhiA3Bc
         /vWIkDiYLEvD8ual45CrW40IHWxGM+Nd6igsIh/xBb+1v02UhV+i5w7YRVd++a7d9FjF
         DAK4OKphml0J4G+R7wSRxPklXvd60V/bDmccKzY03254VEPAGyPBf90/tJJvxPkNbTnQ
         YVDl8QKUhE9p1PIqxhoZ6F+OkmIuaXRfak13uOYaZzsLaRGuQZgyZIdc7y8SI8pS5PxT
         oKqw==
X-Gm-Message-State: AOAM531Of/pm34P+2KCNDsDJeOds7/zmb4Avil8+moPae7wL7UAOWqUn
        CobFOfdElPZytEFTaH/6ZkIk2Q==
X-Google-Smtp-Source: ABdhPJyPh1ezOw2sy0EQ6kjmLgD1rSsrITTXAJHnhVIq/PJRePuQKh9Kel3rSaI68O428UlbxAszUg==
X-Received: by 2002:a63:6fc4:0:b0:393:9567:16dc with SMTP id k187-20020a636fc4000000b00393956716dcmr5757855pgc.593.1651910779774;
        Sat, 07 May 2022 01:06:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j192-20020a638bc9000000b003c14af505fcsm4564376pge.20.2022.05.07.01.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 01:06:19 -0700 (PDT)
Date:   Sat, 7 May 2022 01:06:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        kunit-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v6 00/23] Rust support
Message-ID: <202205070056.ACC3C3D@keescook>
References: <20220507052451.12890-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507052451.12890-1-ojeda@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, May 07, 2022 at 07:23:58AM +0200, Miguel Ojeda wrote:
> ## Patch series status
> 
> The Rust support is still to be considered experimental. However,
> support is good enough that kernel developers can start working on the
> Rust abstractions for subsystems and write drivers and other modules.

I'd really like to see this landed for a few reasons:

- It's under active development, and I'd rather review the changes
  "normally", incrementally, etc. Right now it can be hard to re-review
  some of the "mostly the same each version" patches in the series.

- I'd like to break the catch-22 of "ask for a new driver to be
  written in rust but the rust support isn't landed" vs "the rust
  support isn't landed because there aren't enough drivers". It
  really feels like "release early, release often" is needed here;
  it's hard to develop against -next. :)

Should we give it a try for this coming merge window?

-- 
Kees Cook
