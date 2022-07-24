Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22CFC43334
	for <linux-perf-users@archiver.kernel.org>; Sun, 24 Jul 2022 05:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiGXFXg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 24 Jul 2022 01:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbiGXFXf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 24 Jul 2022 01:23:35 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC1318E27
        for <linux-perf-users@vger.kernel.org>; Sat, 23 Jul 2022 22:23:35 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id pc13so7594033pjb.4
        for <linux-perf-users@vger.kernel.org>; Sat, 23 Jul 2022 22:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DVcGMUg63ZuyRPGB+ax8hjQYbRon/AMmT/KHY/uYZvM=;
        b=N44XlBThF9hr0YdMwSqE/Y8pqxRR0qN7YJASl4rflgM929JO2OHiZZC3Tt9eG//5Mr
         bksL1BeskWKeL5+tl9ML0hAeD7Let4DHvVZSj7JFppsP/flZNhp6Da/GQWkoLVAXSh8s
         82e7TBIoe4GdJG6yXOEIHcpmNUlm7f/fn9WNB3cKy4tk+dM61JaL7pv9BDmkhR3Hg+4d
         t7kXbus2/xDk2L+LnvvVhOq8HahOafa68USNdYtJbENOlK4n63nPvYYam3OSv1utrz74
         p/zGFwbWqP/wO/YM7ylhCE6XkzL3+7D5gDaAhDM83sP/Q4tSMfEOZittVPXU3zMjOyfg
         wRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DVcGMUg63ZuyRPGB+ax8hjQYbRon/AMmT/KHY/uYZvM=;
        b=ciuqmuecN6hjSHR0zhrNrfkrJQD+y6vSOvZWMiPCBXGl2O+qRWNjwc11YTUcaDNoWT
         st3nEw2kSFEd+n7zm9sL310e5SnVCQwQ2XU2NTqwBj/uA+jQcoQ64AwT9uIMtTusTgIg
         5VoRAu/Yon4jLUNk95aSfOMW85aYR9GQbLvzI6oz/LTyzq9e94c9+KDs5Gt5U97tj9tK
         X9BgMn1qv74pRU3GD6pMe8Yn4uq097FoA4qdxMbeogpKx77dimMIsCkaGb1GBTfYHzDM
         qjlSrYVp5oUu3numKxLOQYVI5rBAh+yqRVzuAI3NH0Ja80edUEM4M/2Vjj2IXd8rzHjO
         wKrg==
X-Gm-Message-State: AJIora8dyoIJ68FFOyLmH5qtcN3eZnGtmaqr0fhgQPcg35JOoZwNAJB7
        xO49gUfepV+w7gG+z7cmV0OTiqfnkI1aMX0o+Bg=
X-Google-Smtp-Source: AGRyM1t3x6rRtN3QukoCbgl9JRd33Dij9jGSlDj01WFH5DH93wV4aRi8wtun5sMyW9geJeJSJAFQSw==
X-Received: by 2002:a17:90a:17e1:b0:1f2:2ff2:6cae with SMTP id q88-20020a17090a17e100b001f22ff26caemr17913677pja.196.1658640214217;
        Sat, 23 Jul 2022 22:23:34 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-144-7-244.us-west-1.compute.amazonaws.com. [18.144.7.244])
        by smtp.gmail.com with ESMTPSA id p64-20020a622943000000b0052b9351737fsm7036475pfp.92.2022.07.23.22.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 22:23:33 -0700 (PDT)
Date:   Sun, 24 Jul 2022 13:23:27 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf symbol: Skip recording symbols in
 '.gnu.warning.*' sections
Message-ID: <20220724052327.GB82137@leoy-ThinkPad-X240s>
References: <20220724022857.2621520-1-leo.yan@linaro.org>
 <20220724022857.2621520-3-leo.yan@linaro.org>
 <CAFP8O3LJq1rt6i0_rAW5pShUiA=FJ38ceb4Ps0KmLdCNzC9xbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFP8O3LJq1rt6i0_rAW5pShUiA=FJ38ceb4Ps0KmLdCNzC9xbQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Jul 23, 2022 at 08:42:20PM -0700, Fangrui Song wrote:
> On Sat, Jul 23, 2022 at 7:29 PM Leo Yan <leo.yan@linaro.org> wrote:
> >
> > Some symbols are observed their 'st_value' field are zeros.  E.g.
> > libc.so.6 in Ubuntu contains a symbol '__evoke_link_warning_getwd' which
> > resides in the '.gnu.warning.getwd' section, unlike normal symbols, this
> > kind of symbols are only used for linker warning.
> >
> > This patch skips to record symbols from '.gnu.warning.*' sections by
> > detecting the sub string '.gnu.warning' is contained in section name.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Presumably __evoke_link_warning_getwd is due to `clang -fuse-ld=lld
> -static ...` on a file calling the deprecated getwd.
> GNU ld and gold implement a .gnu.warning.* feature which removes the
> section. ld.lld just ignores this section as the usefulness of the
> functionality is unclear.
> 
> The section .gnu.warning.getwd does not have the SHF_ALLOC flag. Such
> sections are not part of memory images and I think it is more generic
> ignoring all symbols residing in a non-SHF_ALLOC section.

Good point!  Will refine the patch for this and send out soon.

Thanks a lot, Fangrui.
