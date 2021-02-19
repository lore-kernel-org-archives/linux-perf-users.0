Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B94C433E0
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 Feb 2021 07:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073DF64DEC
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 Feb 2021 07:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhBSHKq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 02:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBSHKp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 Feb 2021 02:10:45 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4007C061574
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Feb 2021 23:10:04 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id g1so8839182ljj.13
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Feb 2021 23:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Unpyq0FYtLVCWSkRTjKHP+CUo5tS++z4NyBSikjDnvs=;
        b=HOfdiPaOUz5DryOwEKlTpfSaUtccTXgnACbq3eLu2uk2teRBzK2OvYrHP5QIbzPXb5
         TQvA229tkgjhpW3yIwEsZxKyjFYLESAAPKxaKcVELTi56vyKqhsMS/fn465DNq4vWxfy
         KeguRk2yP+mh6xENzaZKXT6ffXrME7rGjXQu/8qAf3CCO1CiuK1jn0zw2buKqh4ejsjN
         z4I3NeEOQhOtsSPTgaJ1ZxiDj01LMa2GNxJOrc8AxQj6fOHYEMOh3nFea3UR6uJCFZAq
         g98zeM1YcuugGjZMrUe5kB5Li8KDrzN6y7HrZ8YMEcgUGhjKIfN/SPisoJlD6wQaEzkE
         +hEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Unpyq0FYtLVCWSkRTjKHP+CUo5tS++z4NyBSikjDnvs=;
        b=NhngM5wybicEeg2mehXAgslu90vvJTwSulgQueUyE6YtF0fDDyS5Ry/+B8u1PpfQjq
         keymN31r19WDivx1BqYRXPr7VrJLSEXvIDCF8aM97FP7AWJmgkNNTwLaYdI+f2XvID3g
         CoddxwVgdoBJ1zrsRfCPFNhvzslCqoP63qaJl6gO/NE+em3RGNLk3ghMOKVRWI8fg7Gn
         jQtjDj/srHDrFel/wk3Do+HOGfYKjA9SAru1abLlA9xklgiFEOn/CdViCmMY82N1dU5D
         6eKpwB8e47E29yyDgQOI3DnvU6dYHJzOgW3+BbQSae+CnD3wTP7Ia63utkoSTgjgbweK
         FIZg==
X-Gm-Message-State: AOAM531nX6kZgQxdN7JJZfw3gx4kJaBKW1Um7ktKaMqVz2ETjOyqan+f
        uvYCAtyqfRuMiAP+mNZXT21oY08ZckWfrgcLCqE=
X-Google-Smtp-Source: ABdhPJxdF0fRbm/tctMULBu6J0S/XeUG2+AOnCd/D81fhsecxQKyGaHSQYLl4Im+QLy4zUEi+16vESwC+BabbLVCTPw=
X-Received: by 2002:a2e:87c2:: with SMTP id v2mr4665132ljj.23.1613718603213;
 Thu, 18 Feb 2021 23:10:03 -0800 (PST)
MIME-Version: 1.0
References: <CAHb-xavRszhCbGcs0DgrdoJCHmOznHC4UzhLXxtXz=gXXk+wMQ@mail.gmail.com>
 <CAM9d7cg2qfQcNkH__XL8HUPSfsFqSwnYUXWCJZQLr06dip9RCw@mail.gmail.com> <CAHb-xau-HhbuLL0aKyzmHjCixETcMNV7xGxGj_bBYoSVQd_R2w@mail.gmail.com>
In-Reply-To: <CAHb-xau-HhbuLL0aKyzmHjCixETcMNV7xGxGj_bBYoSVQd_R2w@mail.gmail.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 19 Feb 2021 16:09:51 +0900
Message-ID: <CAM9d7cjX-ZaNfR-ObpeaWQXkLkxzWrYt9Szdrh1=Kaz+UhDK9w@mail.gmail.com>
Subject: Re: [Question] How to sample PERF_TYPE_HARDWARE
To:     rainkin <rainkin1993@gmail.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Feb 18, 2021 at 11:05 AM rainkin <rainkin1993@gmail.com> wrote:
>
> Hi Namhyung,
> Thanks for your reply.
> Let me make my goal more clear: record the number of occurring branch
> instructions (PERF_COUNT_HW_BRANCH_INSTRUCTIONS) every N cycles
> (PERF_COUNT_HW_CPU_CYCLES).

Please try this:

  perf record -c N -e '{cycles,branches}:S'
  perf script

Thanks,
Namhyung
