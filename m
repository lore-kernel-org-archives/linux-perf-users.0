Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8751EB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 18:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjFWSxh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 14:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjFWSxh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 14:53:37 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBF02949
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 11:53:17 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3fde9bfb3c8so45701cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 11:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687546396; x=1690138396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=935rGTtEpPqjTx4Lejs9Y17RLswTLBi1l11gAOSj7X0=;
        b=J/KG8HZi4PA4AnTONFA7/KZrB2i+r3RQqY3Mzv3DqcZ4M4oZLJVlsrMPChd5oOztuM
         6nLF8wOMeqvI+VwDRqohf3LGuXltj6yoqFWoEwYpfV60DTYpfePr4uPb3RyHGyU8CJU7
         LibkbWS/YYT/k/lZ+y58KXBPtvekIiokLXibrIfRxeP6DnV9uwNMIFpfW35cRKoec2lw
         +e1H9XjaPdLAdzXPrAuUkyjV7XwKQJEbMWXTah86Wve/9CUbLYuYvt9UKMusAGXSedii
         6UPH7RurskJo7WCq15YNAjcUqSvFXuvyPAl+Afg4EYutCkzXT9QwFNcL6vBJevzEZ9Od
         ok/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687546396; x=1690138396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=935rGTtEpPqjTx4Lejs9Y17RLswTLBi1l11gAOSj7X0=;
        b=DslUoP8MiABttcv4UXkgEj2H5D72flDoIgxL5GeEGyHLKfkzPxijOpPKIlUy4IG+Pp
         +o2kiu6sYGVzKVPkHwpbrEnl3l1p/hF9jIRrw8Mo1y+nv92hmOakuN70qgqqVAVtB2fy
         BNDSCQK23IuUZUy0+/7X9/S2kjIO2NuMauCAWpxm6Cu+SwYhjjhdEM0IeCWri8Nt0G9K
         kMNO7TKgCu3QAYhwPUPCJu//rxOUZm0ky8uNcV2Oy9/0wPHcvWQ6izPH7gOj84WLdLAr
         8UBBekBBPq1+TkNE6L+MhlzrNsQlw5JX6T5Dx0KLBtT74xJlmOaVJTUfg1cAL7Ue7qXJ
         6BKQ==
X-Gm-Message-State: AC+VfDxdhfAUVw6O7bRho8KzErfmgtnPzHrRp7VZ6k7OnIE1oZPzw94U
        EJfzRPBhrc0jA77ojIAjHmuzY9rrmdCPRZEZz7U+o9Ce0iTokSeDtFINfw==
X-Google-Smtp-Source: ACHHUZ68BHbG8wd3AiIbZg/nnF7lZ8S91svt6PgMBGfKD/BK4WuPLMZf784M26ik6l2SuGOAuF7x8Umo4ZicxjvKR7s=
X-Received: by 2002:a05:622a:1007:b0:3ef:3083:a437 with SMTP id
 d7-20020a05622a100700b003ef3083a437mr7152qte.18.1687546396142; Fri, 23 Jun
 2023 11:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <ZJOmXU/41HMzanM9@tassilo> <CAP-5=fWZAcXcE3CP-V7t=gSehO-AacHJWhjHjtA5nCd5B2-n1A@mail.gmail.com>
 <ZJQSUHLe9Cqpw21n@tassilo> <CAM9d7cgpegLH9QpUhHQy0ckMpO6CaKaYrAeHKNm4CT01R4bhGw@mail.gmail.com>
 <ZJSr2PbOrpFrSIaL@tassilo> <CAM9d7cj1XXpuaPss7qa7eSD8LJCQZ1KorviOxxnt2Hpk_J3ugQ@mail.gmail.com>
 <ZJXl5vdhxPnVBRze@tassilo>
In-Reply-To: <ZJXl5vdhxPnVBRze@tassilo>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 23 Jun 2023 11:53:04 -0700
Message-ID: <CAP-5=fXOi=xQ4=j5xAq+jWLR9n7uvfsWK+PzXkY1MZ3Fz-xccw@mail.gmail.com>
Subject: Re: Perf stat regression from d15480a3d67
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 23, 2023 at 11:35=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wr=
ote:
>
> > Can you please help me to find a minimal repro?
>
> Here's a smaller test case (works on SKX):
>
> perf stat -a -e uncore_imc/event=3D0x4,umask=3D0x3/,uncore_imc/event=3D0x=
4,umask=3D0xc/,cycles <something the doesn't idle for 1s>
>

Hmm.. not sure I'm seeing what you are seeing:

Perf 6.1:
```
$ perf stat -a -e
uncore_imc/event=3D0x4,umask=3D0x3/,uncore_imc/event=3D0x4,umask=3D0xc/,cyc=
les
perf bench sched pipe
# Running 'sched/pipe' benchmark:
# Executed 1000000 pipe operations between two processes

     Total time: 7.915 [sec]

       7.915043 usecs/op
         126341 ops/sec

 Performance counter stats for 'system wide':

        24,396,429      uncore_imc/event=3D0x4,umask=3D0x3/
        17,621,319      uncore_imc/event=3D0x4,umask=3D0xc/
    74,773,564,295      cycles

       7.937755581 seconds time elapsed
```

perf-tools-next:
```
$ perf stat -a -e
uncore_imc/event=3D0x4,umask=3D0x3/,uncore_imc/event=3D0x4,umask=3D0xc/,cyc=
les
perf bench sched pipe
# Running 'sched/pipe' benchmark:
# Executed 1000000 pipe operations between two processes

     Total time: 7.677 [sec]

       7.677456 usecs/op
         130251 ops/sec

 Performance counter stats for 'system wide':

         2,315,325      uncore_imc/event=3D0x4,umask=3D0x3/
         2,316,490      uncore_imc/event=3D0x4,umask=3D0x3/
         2,452,872      uncore_imc/event=3D0x4,umask=3D0x3/
         2,280,681      uncore_imc/event=3D0x4,umask=3D0x3/
         2,479,263      uncore_imc/event=3D0x4,umask=3D0x3/
         2,477,248      uncore_imc/event=3D0x4,umask=3D0x3/
         1,268,114      uncore_imc/event=3D0x4,umask=3D0xc/
         1,267,928      uncore_imc/event=3D0x4,umask=3D0xc/
         1,323,996      uncore_imc/event=3D0x4,umask=3D0xc/
         1,229,923      uncore_imc/event=3D0x4,umask=3D0xc/
         1,352,914      uncore_imc/event=3D0x4,umask=3D0xc/
         1,352,125      uncore_imc/event=3D0x4,umask=3D0xc/
    58,873,911,111      cycles

       7.687930565 seconds time elapsed
```

So with perf-tools-next it appears that we're not merging the uncore
events, but that's different than skipping events.

Thanks,
Ian

> -Andi
