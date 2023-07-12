Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7A9EB64DA
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 Jul 2023 23:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjGLXnx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjGLXnw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Jul 2023 19:43:52 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C3B1BEC
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 16:43:50 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-55b5a3915f5so165663a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 16:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689205430; x=1691797430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4IwbsLNMZjoBI8pt2zzSuSleIDve//tt+1qPzYCGebU=;
        b=knCtFMbN4WML7vj766sEtY8KvxapiU2by8fS/mxlg7A9NlKY6gTDWsRrCG++Ao3uMm
         ljImTF0tep7vUF7b0Z0u3jKnOC2ANSzndhehbtN5RBZysfVoKdrkWIncAOlr9TCKczBv
         mRX/2KHZE8O62zUYUxwD6QwApWqpHXBsZvMKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205430; x=1691797430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IwbsLNMZjoBI8pt2zzSuSleIDve//tt+1qPzYCGebU=;
        b=SbtfTnEH5OtDGksHGUPB6xpGAeecGILSIOM0x/Roal8VSa7aGAh1pMhtdiUApOxQ/7
         w/88tO2fKnX4qb1gto6euq5iuRxzbEBEYoQ7nV2nogewGw6vIaoJMA0/4b6hU8+vLfsW
         iQGpJTXLSlZzSosgpHCSrbwmV8Iqp31Q6lU7PRXTM6v76fxBMZQo213Ao6bd61riCrRj
         Xk41l4g7uowSCBwMUQkGiwA7AQwsI8Z2u8GTje30Qel7SKy18LCu/MM03lv9UiZAJxv8
         e2BXhNvtBv06BQXV5BxKMO83wD6JHTTyr0F1SCqfhx0zj1psM6w393HoWWWDnXOeuUFG
         UDHQ==
X-Gm-Message-State: ABy/qLagOHEbb/benSRT02xmtQt+L9blR561fzpitAsYZ0VbbXCw5zko
        jGgImO2MGIXFc1hAlv/R7LUWCA==
X-Google-Smtp-Source: APBJJlG2587sgWGWzoLeo2iZEAvVs8nrf1/dt7I567aIm5zKF1zfvqFb6t3P/L2tTUZYA0qQ3fY3mA==
X-Received: by 2002:a17:903:2288:b0:1b8:a3a6:df9c with SMTP id b8-20020a170903228800b001b8a3a6df9cmr32020plh.60.1689205430441;
        Wed, 12 Jul 2023 16:43:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b001b83e5ec666sm4561085plg.6.2023.07.12.16.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:43:49 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:43:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-hardening@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Replace strlcpy with strscpy
Message-ID: <202307121643.096BAB33@keescook>
References: <20230703165817.2840457-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703165817.2840457-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 03, 2023 at 04:58:16PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
