Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E137EC6FD1C
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Mar 2023 18:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCWSEH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Mar 2023 14:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjCWSEF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Mar 2023 14:04:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D37410402
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Mar 2023 11:04:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3ec1e8c4cacso71455e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Mar 2023 11:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679594641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zj4NTRRYf9tl+T5ZE6zhhjJ0xM3vQzOj+7c+ERPQwac=;
        b=HiS0GbKA2j+CmiVlryYxw7gUmylwNKiWTKbk3SsCGFPFjqn1SUYGsd2nnMqKkE7FOL
         jlAxJadqFzEFQ+Ewm8CL49wI2ywONPQ2qEiUNHbs86qVxwzdzcXX35DVtsl4IisDM6on
         IlPZN8X5GfVrbW1i+DVgPs0fra+KTZRxiZzih3NJOMmf+qPS1B84WxtGgCAiJmIsVEha
         Vug3jAbfy6xfoLoHjRaA5X7rzUzz057niUzXkHTISvwTgcUfGDu7BJmZMk70ArmEwb6s
         PUI4rCXh9PMMkhqzjCBv7npkLV0kKFAD6FsW3RSH0oiP4AgrFqkd72Jg17RN99hiCyKB
         7BUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679594641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zj4NTRRYf9tl+T5ZE6zhhjJ0xM3vQzOj+7c+ERPQwac=;
        b=xc6OX6Wv2jpx9u2wCJZrUuEUv+cNgOXv0EA6OYIOxyjzzD4XQtlH50MdfaKqUxll3D
         8nUhieyl85+uejvw9OXwzvcz7gk3L7CIejc1Ryr4KqJd1S1otSw/EGxsGqtPYqbdEGrP
         s/ECKLFeytAeKYIWIl6MP6ylItBQrBr4IieBJ+KZ3tYdizcaRC393DI5YOkr0DARXyDZ
         tGrbZsHFFtueh2N32KmCXxrIqnXc/h7oG56L2PkplC9N01GgBqc28Q3hz69vqyGLvBJx
         rFxb2gkhQcebVICK99TByzBTo/IStIJLlZmJdxRkaavhNlndsbX37irNPU8sQ9iSc+YQ
         Lg7A==
X-Gm-Message-State: AO0yUKVFB+kgaKz7Zi8/Ll8pP/hkwYdCptFKTHVBP4zM+Axh9jTvRoaJ
        qysdB6RLP/+1uKmlOHs6Lhd7G7ePkrkzWZCsRp9h1g==
X-Google-Smtp-Source: AK7set/25I8XE2XqAJdLvA/6bZApSXkFRvMjCfs2B3QbHwwx/FE2N2lRnVMYXlSUs/SkNG0KYNeINmvIIHaX+is4Vrw=
X-Received: by 2002:a05:600c:5127:b0:3ed:cc03:36bc with SMTP id
 o39-20020a05600c512700b003edcc0336bcmr7246wms.3.1679594641423; Thu, 23 Mar
 2023 11:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAGKjw9KHDnVgRz5bstJYkq4t0-bT5fvkuQZbEB48d-8jo4Q00g@mail.gmail.com>
 <20230303193058.21274-1-patrice.duroux@gmail.com> <CAP-5=fV5h9AEf3V1taXA++frs=AAPeuPbd=Hb0koVjKfGpQNsw@mail.gmail.com>
In-Reply-To: <CAP-5=fV5h9AEf3V1taXA++frs=AAPeuPbd=Hb0koVjKfGpQNsw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 23 Mar 2023 11:03:49 -0700
Message-ID: <CAP-5=fUy_mLJ2-z89dc0vro+1aqWFn-CrvqZA1Ji3etPXg+RTg@mail.gmail.com>
Subject: Re: [PATCH 1/2] replace 2&>1 by 2>&1
To:     Patrice Duroux <patrice.duroux@gmail.com>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Mar 6, 2023 at 1:46=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Fri, Mar 3, 2023 at 11:31=E2=80=AFAM Patrice Duroux <patrice.duroux@gm=
ail.com> wrote:
> >
> > Signed-off-by: Patrice Duroux <patrice.duroux@gmail.com>
>
> Fixes: ade1d0307b2f ("perf offcpu: Update offcpu test for child process")
> Acked-by: Ian Rogers <irogers@google.com>
>
> Thanks,
> Ian

Arnaldo, could we pick this up?

Thanks,
Ian

> > ---
> >  tools/perf/tests/shell/record_offcpu.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests=
/shell/record_offcpu.sh
> > index e01973d4e0fb..f062ae9a95e1 100755
> > --- a/tools/perf/tests/shell/record_offcpu.sh
> > +++ b/tools/perf/tests/shell/record_offcpu.sh
> > @@ -65,7 +65,7 @@ test_offcpu_child() {
> >
> >    # perf bench sched messaging creates 400 processes
> >    if ! perf record --off-cpu -e dummy -o ${perfdata} -- \
> > -    perf bench sched messaging -g 10 > /dev/null 2&>1
> > +    perf bench sched messaging -g 10 > /dev/null 2>&1
> >    then
> >      echo "Child task off-cpu test [Failed record]"
> >      err=3D1
> > --
> > 2.39.2
> >
