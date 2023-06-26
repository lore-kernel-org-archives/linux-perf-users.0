Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E46EB64D7
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jun 2023 23:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjFZXKD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Jun 2023 19:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFZXKC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Jun 2023 19:10:02 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFC610FC
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 16:10:01 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-bff0beb2d82so3896769276.2
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 16:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687821001; x=1690413001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3P2oyRWtxu7qu8aJM5SSjGX2KOYLwQHYvCeH8ev3qU4=;
        b=k0RzWkhfzft/WU7Ouy7MEq53DiVw0Q7bYOJWf9Zi+cfYbaTVOJZuc5TOnGBx88gJXx
         Bagim+bQ/oE40RxjwasT65Kn7ghzvka40ykbnnQzc4uxmWW+7N/ikHs/r2YOW9uXP4Se
         wbb22Y2mLmdzd+zISSrY80KOyfLNZYsALAGTmDIyYGFDforojPGuBGJt/Gx5L6sJz4jU
         JaXlPpAQAug1mUT7lR2NvhRFJGoEQ1snpCg/03Vxu9J3TuDmO3tmk6uavkIA4KtihGbr
         BX4Iq/8RFc7zL751jfy6o+AQpap6OSuTc8sTuXEI6VgSAi2Xj2EmbgWvVc2KLfW9Z2l2
         T3OQ==
X-Gm-Message-State: AC+VfDz2oXs1OuiSSyESr2y4SfqVBSHuyBYGGnuptb6FxSksBWEn3npX
        07f0h2YHhLvi/Jekx/hczYJVpUKZhTGMn3FQyi8=
X-Google-Smtp-Source: ACHHUZ5RrBes66CWdKlEmZatckqkNirkRz6BeRwsvnu/+lqa15d+UZ1Sb3CjcAeSREMSJ3j3JfsQA5D1JNkYyyUj/AM=
X-Received: by 2002:a25:34cf:0:b0:bb1:568c:437d with SMTP id
 b198-20020a2534cf000000b00bb1568c437dmr25283881yba.3.1687821000621; Mon, 26
 Jun 2023 16:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <ZJOmXU/41HMzanM9@tassilo> <CAP-5=fWZAcXcE3CP-V7t=gSehO-AacHJWhjHjtA5nCd5B2-n1A@mail.gmail.com>
 <ZJQSUHLe9Cqpw21n@tassilo> <CAM9d7cgpegLH9QpUhHQy0ckMpO6CaKaYrAeHKNm4CT01R4bhGw@mail.gmail.com>
 <ZJSr2PbOrpFrSIaL@tassilo> <CAM9d7cj1XXpuaPss7qa7eSD8LJCQZ1KorviOxxnt2Hpk_J3ugQ@mail.gmail.com>
 <ZJXl5vdhxPnVBRze@tassilo> <CAP-5=fXOi=xQ4=j5xAq+jWLR9n7uvfsWK+PzXkY1MZ3Fz-xccw@mail.gmail.com>
 <CAM9d7cg5ZQvHGs3fh9iXxdgRY2uidgDTQ0WSQGuicub+wX8KFQ@mail.gmail.com> <ZJcu5XiTFWtXC7QU@tassilo>
In-Reply-To: <ZJcu5XiTFWtXC7QU@tassilo>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 26 Jun 2023 16:09:48 -0700
Message-ID: <CAM9d7chyic6tf0nvJVE+Mt+X0fagecxESqVj9=pLNtxbCP5NeQ@mail.gmail.com>
Subject: Re: Perf stat regression from d15480a3d67
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Jun 24, 2023 at 10:59 AM Andi Kleen <ak@linux.intel.com> wrote:
>
> > > So with perf-tools-next it appears that we're not merging the uncore
> > > events, but that's different than skipping events.
>
> Isn't that a regression too? We're supposed to merge.

Right, should be fixed by Ian's patch.

>
> >
> > Right, not sure what's changed though.
> >
> > Andi, what's your expectation?
>
> The original test case passes with perf-next, but I still see failures,
> but that might be related to PMU reordering. I'll investigate that.
>
> However if the original hiding is still in the code the problem could still
> happen, right? I would still prefer to do what i suggested earlier,
> to only do hiding on --per-thread with an option to turn off.

I think the hiding should not happen in normal conditions
besides the --per-thread.  So I want to be clear what makes
it disappears.  Then we can decide what to do.

Thanks,
Namhyung
