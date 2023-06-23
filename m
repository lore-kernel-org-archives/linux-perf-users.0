Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33ADC0015E
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 23:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjFWXFg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 19:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjFWXFB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 19:05:01 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28672965
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 16:04:47 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-44096f01658so472362137.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 16:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687561486; x=1690153486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qPyGqqEJSlGjq1gP6YaEK9/+oMCcqYFzNLb+PBJtuk=;
        b=IzAGteGnCvRjoAhryfhZmQ3BPxBLoBspcYi1OUkeV380jILPp0YUSZLMrjSMVZk9hP
         un+k+MtI0rlHXS+bsl2ekz+ltPOiGk9vMvc5lLR6PoGQMFBUyPE7QZfppjeWqfHKi1bb
         8EWGKqacEVMdo1XLqV18zfcZ0s7u44JYIUZitMHUCnO9r+pXeDuE65ArCBJUKclgECCU
         InWZIqpmJtdG/EauPzcugUbluKNIm4a8cceYuNeEW9ygG0HZQq3+DHOHZl+9xNjqK6EH
         JlpLdqSxiJPXOAUqnYR4VqEyPwxPEuYdMGZnP4PXLVVc/aTOFQPx5v+dMsCPI/6sqByN
         uS8w==
X-Gm-Message-State: AC+VfDxkUYtfWC5FCHjWXH2uP/1eUNGo34iBbVi9zFtK1qi4oSWN0kj+
        K8rugG0Zo+uPO0qaKLVCSgfOnTIXysOS5s/7usI=
X-Google-Smtp-Source: ACHHUZ4ocIaXFcOoaGEGOqMB+Y25K+xbL/uAqGkLeK2yWn6IcyfFqEprZX1DN0QE3q/qlrru3MWWxWUK9XNUBCxVylI=
X-Received: by 2002:a67:f2d7:0:b0:440:a868:f3d0 with SMTP id
 a23-20020a67f2d7000000b00440a868f3d0mr10848153vsn.17.1687561486499; Fri, 23
 Jun 2023 16:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <ZJOmXU/41HMzanM9@tassilo> <CAP-5=fWZAcXcE3CP-V7t=gSehO-AacHJWhjHjtA5nCd5B2-n1A@mail.gmail.com>
 <ZJQSUHLe9Cqpw21n@tassilo> <CAM9d7cgpegLH9QpUhHQy0ckMpO6CaKaYrAeHKNm4CT01R4bhGw@mail.gmail.com>
 <ZJSr2PbOrpFrSIaL@tassilo> <CAM9d7cj1XXpuaPss7qa7eSD8LJCQZ1KorviOxxnt2Hpk_J3ugQ@mail.gmail.com>
 <ZJXl5vdhxPnVBRze@tassilo> <CAP-5=fXOi=xQ4=j5xAq+jWLR9n7uvfsWK+PzXkY1MZ3Fz-xccw@mail.gmail.com>
In-Reply-To: <CAP-5=fXOi=xQ4=j5xAq+jWLR9n7uvfsWK+PzXkY1MZ3Fz-xccw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 23 Jun 2023 16:04:35 -0700
Message-ID: <CAM9d7cg5ZQvHGs3fh9iXxdgRY2uidgDTQ0WSQGuicub+wX8KFQ@mail.gmail.com>
Subject: Re: Perf stat regression from d15480a3d67
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 23, 2023 at 11:53 AM Ian Rogers <irogers@google.com> wrote:
>
> On Fri, Jun 23, 2023 at 11:35 AM Andi Kleen <ak@linux.intel.com> wrote:
> >
> > > Can you please help me to find a minimal repro?
> >
> > Here's a smaller test case (works on SKX):
> >
> > perf stat -a -e uncore_imc/event=0x4,umask=0x3/,uncore_imc/event=0x4,umask=0xc/,cycles <something the doesn't idle for 1s>
> >
>
> Hmm.. not sure I'm seeing what you are seeing:
>
> Perf 6.1:
> ```
> $ perf stat -a -e
> uncore_imc/event=0x4,umask=0x3/,uncore_imc/event=0x4,umask=0xc/,cycles
> perf bench sched pipe
> # Running 'sched/pipe' benchmark:
> # Executed 1000000 pipe operations between two processes
>
>      Total time: 7.915 [sec]
>
>        7.915043 usecs/op
>          126341 ops/sec
>
>  Performance counter stats for 'system wide':
>
>         24,396,429      uncore_imc/event=0x4,umask=0x3/
>         17,621,319      uncore_imc/event=0x4,umask=0xc/
>     74,773,564,295      cycles
>
>        7.937755581 seconds time elapsed
> ```
>
> perf-tools-next:
> ```
> $ perf stat -a -e
> uncore_imc/event=0x4,umask=0x3/,uncore_imc/event=0x4,umask=0xc/,cycles
> perf bench sched pipe
> # Running 'sched/pipe' benchmark:
> # Executed 1000000 pipe operations between two processes
>
>      Total time: 7.677 [sec]
>
>        7.677456 usecs/op
>          130251 ops/sec
>
>  Performance counter stats for 'system wide':
>
>          2,315,325      uncore_imc/event=0x4,umask=0x3/
>          2,316,490      uncore_imc/event=0x4,umask=0x3/
>          2,452,872      uncore_imc/event=0x4,umask=0x3/
>          2,280,681      uncore_imc/event=0x4,umask=0x3/
>          2,479,263      uncore_imc/event=0x4,umask=0x3/
>          2,477,248      uncore_imc/event=0x4,umask=0x3/
>          1,268,114      uncore_imc/event=0x4,umask=0xc/
>          1,267,928      uncore_imc/event=0x4,umask=0xc/
>          1,323,996      uncore_imc/event=0x4,umask=0xc/
>          1,229,923      uncore_imc/event=0x4,umask=0xc/
>          1,352,914      uncore_imc/event=0x4,umask=0xc/
>          1,352,125      uncore_imc/event=0x4,umask=0xc/
>     58,873,911,111      cycles
>
>        7.687930565 seconds time elapsed
> ```
>
> So with perf-tools-next it appears that we're not merging the uncore
> events, but that's different than skipping events.

Right, not sure what's changed though.

Andi, what's your expectation?

Thanks,
Namhyung
