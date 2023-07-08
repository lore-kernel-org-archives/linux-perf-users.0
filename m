Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E379EB64DA
	for <linux-perf-users@archiver.kernel.org>; Sat,  8 Jul 2023 19:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjGHTQd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 8 Jul 2023 15:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGHTQc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 8 Jul 2023 15:16:32 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ED4FC
        for <linux-perf-users@vger.kernel.org>; Sat,  8 Jul 2023 12:16:31 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so3505655a12.3
        for <linux-perf-users@vger.kernel.org>; Sat, 08 Jul 2023 12:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688843790; x=1691435790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mLZlu9xJmqIEDMbaskzro9PEeknNhuP2jk6hFXnqIJo=;
        b=gCKIBVvKL3qPNuTeoRLSB9oSYkTore3fHEcqbLFhGCXeHnmqrXItHexJ6O3HRsGIm1
         S0aXR7Fjua80J2beXfslhVtew77McBL81ikgxZAbg4GCJ32K8oVcgaNUG/VW0lrn7EEM
         As6x/F01E1T5/hlLnfZkk1W04GQGMGCYud07U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688843790; x=1691435790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLZlu9xJmqIEDMbaskzro9PEeknNhuP2jk6hFXnqIJo=;
        b=SFTUjbDAM9gsRUCx2DUtNhCc3sW0qDMnsUotbggkntduRBxXDbTPnwoE4oQ7emwjaM
         vEl/YJCVl3lyudSBCnZJsYWOv6KtGoHtbAgqRVR/EDwtubO6xBbZVRyrY/0OxctQ7sDn
         pXwydXiIvkR8uCv+6r2LM5yyoYw1aTCh6O99AUX9knpGOsP8hLQ1xs0pWBdH1+xI7LI1
         /k3jAHZhh5VtXCdRaRw7All9wwIFicoyeFdGrAn1zVRbEhrZvLbkRpqebQ6KfsGIku+b
         euHFIOQ55FDrTAbMm2QGmOXaCiZirlld/EURiFFbOGX8RtfYdFbse6V1h9ROuo4KKgRG
         /4Jg==
X-Gm-Message-State: ABy/qLaXX3G7AB+/hM+eRsSOWacrpaLWFMxDxqM6skwR/g9WnMJF0TtL
        4qmMunJhDxvDZRNnDKLa215a+QXNIPGdnPtPldcNVqVL
X-Google-Smtp-Source: APBJJlHfDeo+O7s9O9gb674LdfkyfVwoy/qNO921k390PNlKSf1PyWtxgm2KeeMWBy94k71odIQr1Q==
X-Received: by 2002:a05:6402:1645:b0:51e:34d5:a23f with SMTP id s5-20020a056402164500b0051e34d5a23fmr6316688edx.23.1688843790008;
        Sat, 08 Jul 2023 12:16:30 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id s26-20020a056402165a00b0051df1797222sm3559133edx.11.2023.07.08.12.16.28
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jul 2023 12:16:29 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso41285815e9.0
        for <linux-perf-users@vger.kernel.org>; Sat, 08 Jul 2023 12:16:28 -0700 (PDT)
X-Received: by 2002:a5d:52cc:0:b0:314:f7e:8755 with SMTP id
 r12-20020a5d52cc000000b003140f7e8755mr9103807wrv.55.1688843788496; Sat, 08
 Jul 2023 12:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230707042644.94061-1-namhyung@kernel.org>
In-Reply-To: <20230707042644.94061-1-namhyung@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Jul 2023 12:16:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRP0qeuTSWtHgDdvgUTfBD1mGwrenbOyJC7_ygsbWCEQ@mail.gmail.com>
Message-ID: <CAHk-=wgRP0qeuTSWtHgDdvgUTfBD1mGwrenbOyJC7_ygsbWCEQ@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.5: 2nd batch
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 6 Jul 2023 at 21:26, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello Linus,
>
> Please consider pulling more perf tool changes.  These are remaining
> changes and fixes for this cycle.  The last two fixes are relatively
> new but other changes have been sitting on -next for a number of days.

Hmm.

I htink there's some dependency problem in the perf tools build that
just caused a random build error for me:

   util/expr-flex.c:214: error: unterminated #ifdef

that error went away on a re-build, and it's clearly nonsensical when
I look at that file, so it looks to me like somehow the parallel buld
used that file while it 3as being generated.

I don't see anything obviously wrong, and I've only seen this error
once. I've done the pull - I doubt it was introduced by the recent
changes - but I wanted to just mention that there seems to be some
problem in this area..

Am I the only one to have ever seen something like this?

                 Linus
