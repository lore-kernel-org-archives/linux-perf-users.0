Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11349EB64D7
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jun 2023 05:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjFZFdt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Jun 2023 01:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjFZFds (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Jun 2023 01:33:48 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8850EE43
        for <linux-perf-users@vger.kernel.org>; Sun, 25 Jun 2023 22:33:47 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b54594ce62so148135ad.1
        for <linux-perf-users@vger.kernel.org>; Sun, 25 Jun 2023 22:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687757627; x=1690349627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qyun1xPw4UegVORHRpXF4+0NUZJM/WIAcV1rZWG4eao=;
        b=xaGJpbJO8n6GhO92pZHsJUYCxYJr0k2xraykGGefgJnELJHgZidw5ApwQcgi6OV3q1
         sfK0sJKBtE2zL5wbRrtEjXTGdFtmvxD5H6wCWYODZNk/hlKz3SMAC1TzFMcMYqX8GAM7
         Ow5rsYCB/i58RZIbKlcI7cZKNHJBYWJ8Ysifl0B99K63w24UPDsngKytMFl1tddSQ6MN
         MRHEVsrZSjp1W0meZn0WHxOtMWCLhdnLPNRV8fZypqklr+UUpuWKv+SA06byU2BMDrJO
         JtQG9oOhLUTPxj+EzjokzgpjXh3Q33M1ojkkrWmaRk0BChNMmEXzZC79atg8leSGNDee
         02DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687757627; x=1690349627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qyun1xPw4UegVORHRpXF4+0NUZJM/WIAcV1rZWG4eao=;
        b=CBrDsfkDvUqgshCUu1Xhx4iepMOJLjduU0r82u0WQkYy0gcm2kAE6/vzqzlq5wDPmm
         JKUTZA9yON4lqf7vf8wriA6G7xeUfoSoBo4VUG+voqRTmh+/lXtSvPwCR7hMibPFYV9e
         6PeSvBkrPqZqOlPdYLhGyZvZpwI/GtVgY8BFQD9Rof/bdA1D+hfmzte2vBjWi4IQzxte
         SmhRCq+W90PhDS4LXn+u65n8Y3zm4cYmxFv6tycdYfCQp2jwR+7Smeq3PsHBOtuXpvWE
         z0yAFAkZw9s7bpYoRXJHlDJT8/J3eyBE4PyUCE4F1S4pPfj5AJ90dStrche2VUsxL06x
         GTuw==
X-Gm-Message-State: AC+VfDwj8wW1jGUHqnbT0TCcgxXrnaSh4xfUQB6X02xnm9O2sT/OibKN
        viYGlqWylKDkHmfOAa0XL8gOp9vmes43tPMmtKE9RWdk/eJvJX/JfR2t/Q==
X-Google-Smtp-Source: ACHHUZ6TmKBCWQHdJExZ3sUcMZQ99mv544GXFJtf/57KzK4GRwXoIhOuN/Xst0Ag5cn2SiYOL4dZ0rF/Dp1b68NtHu8=
X-Received: by 2002:a17:902:d506:b0:1ae:3f71:c18 with SMTP id
 b6-20020a170902d50600b001ae3f710c18mr1163615plg.11.1687757626871; Sun, 25 Jun
 2023 22:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <ZJOmXU/41HMzanM9@tassilo> <CAP-5=fWZAcXcE3CP-V7t=gSehO-AacHJWhjHjtA5nCd5B2-n1A@mail.gmail.com>
 <ZJQSUHLe9Cqpw21n@tassilo> <CAM9d7cgpegLH9QpUhHQy0ckMpO6CaKaYrAeHKNm4CT01R4bhGw@mail.gmail.com>
 <ZJSr2PbOrpFrSIaL@tassilo> <CAM9d7cj1XXpuaPss7qa7eSD8LJCQZ1KorviOxxnt2Hpk_J3ugQ@mail.gmail.com>
 <ZJXl5vdhxPnVBRze@tassilo> <CAP-5=fXOi=xQ4=j5xAq+jWLR9n7uvfsWK+PzXkY1MZ3Fz-xccw@mail.gmail.com>
 <CAM9d7cg5ZQvHGs3fh9iXxdgRY2uidgDTQ0WSQGuicub+wX8KFQ@mail.gmail.com> <ZJcu5XiTFWtXC7QU@tassilo>
In-Reply-To: <ZJcu5XiTFWtXC7QU@tassilo>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 25 Jun 2023 22:33:34 -0700
Message-ID: <CAP-5=fVTuPp75yWi+YNs5fTWyoTe=TCJNscsvn648-OxNtk_mg@mail.gmail.com>
Subject: Re: Perf stat regression from d15480a3d67
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Jun 24, 2023 at 10:59=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wr=
ote:
>
> > > So with perf-tools-next it appears that we're not merging the uncore
> > > events, but that's different than skipping events.
>
> Isn't that a regression too? We're supposed to merge.

Right, bisected and sent a fix:
https://lore.kernel.org/lkml/20230626053048.257959-1-irogers@google.com/

Thanks,
Ian

> >
> > Right, not sure what's changed though.
> >
> > Andi, what's your expectation?
>
> The original test case passes with perf-next, but I still see failures,
> but that might be related to PMU reordering. I'll investigate that.
>
> However if the original hiding is still in the code the problem could sti=
ll
> happen, right? I would still prefer to do what i suggested earlier,
> to only do hiding on --per-thread with an option to turn off.
>
> -Andi
