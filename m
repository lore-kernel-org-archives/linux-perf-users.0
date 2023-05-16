Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C52C77B75
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 May 2023 18:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjEPSOo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 16 May 2023 14:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjEPSOn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 May 2023 14:14:43 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ACC59FB
        for <linux-perf-users@vger.kernel.org>; Tue, 16 May 2023 11:14:42 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-53033a0b473so7512794a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 May 2023 11:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684260881; x=1686852881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cg1IpCs76qt4BHLeBZQq6IvnVtorgmXMxk619Xj1Uqc=;
        b=CMyOZsQ5t1dGqI2Pvqq/Mv7hXz5FG9937GXk2VxgppKxIxFB6lm7hMXHKMFtXFwgUb
         Lp1HdPu0crbRz19dUSCQH5j+8l6CuSOvYI2FASFHa+Wfhi0T4EuYt+qWV6JMviGmbCqs
         FDYBXKuYvXuw838C5SRWPmWiYVRppKIxc1Wds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684260881; x=1686852881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cg1IpCs76qt4BHLeBZQq6IvnVtorgmXMxk619Xj1Uqc=;
        b=a8rIkntSajZDqJpOPKNoT5/Z0wQ6kuJpFssCyMeSLySfhjmm3U0dyOy5NINslbTS/Y
         QIDnJt86ahadd4ONsI/+vgPKsyEpNZQUmCVFLexj998Tc643SyPqmItFK/ERQn0+67z0
         NDSKgg9sqmZCNPWEIShzMfaas8/GZRm7waWL23EoyR6lgNYUhQu/zIRi7KlCEReOYWCC
         uvI0hlktrCVX5ITGP+MMCke8nelkq6J8uD/Vk6jrR+rCMeJ4V95yjSnPIT1KhS+0dZvr
         RCOzEdvp354oa5DRxJOvu4Pv+dFUyikEyBJMao9oFpmR59FXvY8VpVsc/4yoB870tUJA
         /PFA==
X-Gm-Message-State: AC+VfDy93+Cmmont965I8nZ11FmL2gQqhFAn2+cx0i6T2lOdaIuR6x9u
        fO2P9nvm8ISma2/0TGdQq5Wb0A==
X-Google-Smtp-Source: ACHHUZ4izGBD0HFWArYDhM5jgc2TRXuMaB66vHnHRoCb2UTTbkZwSSft+Nt+R/BbgsAwYbSErBoDOA==
X-Received: by 2002:a05:6a20:729e:b0:100:bae5:acf3 with SMTP id o30-20020a056a20729e00b00100bae5acf3mr38344461pzk.37.1684260881349;
        Tue, 16 May 2023 11:14:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79251000000b006468222af91sm13764701pfp.48.2023.05.16.11.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:14:39 -0700 (PDT)
Date:   Tue, 16 May 2023 11:14:38 -0700
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] perf pmu: Replace all non-returning strlcpy with strscpy
Message-ID: <202305161114.DEC49FB91@keescook>
References: <20230516000500.3884588-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516000500.3884588-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 16, 2023 at 12:05:00AM +0000, Azeem Shaikh wrote:
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
