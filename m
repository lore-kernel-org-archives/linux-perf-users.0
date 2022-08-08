Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD7FC00140
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Aug 2022 15:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbiHHPHA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Aug 2022 11:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiHHPG7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Aug 2022 11:06:59 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6748B63B5
        for <linux-perf-users@vger.kernel.org>; Mon,  8 Aug 2022 08:06:58 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso4630017wmq.3
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Aug 2022 08:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=OYUBSmT3VH7eZdDQ7fMZ91lcnew+sGEhSV7yBFdrkzA=;
        b=LiARel5+W4e3yVhRKSxREvFZ4zSIBvDEzwOMdqrN6PdMxuLdKhIb8w1PBO48c5fb2g
         5DVkyytqRiwCVHpgXtQxNbqaQro0pzAMSMdCVBMfCTSnbVmaATKjz69tVTvs1vHR93qE
         ni9zblnFGuQMIeKXfi2YeB9mvwv/1XNCagZjDdcpvkykL1RO3Nr85OMQSI2HoZyGTPr9
         Oqzfb+a8comq8SJ73LCP0Bm8vnDvsSIBcv7hshyKpDzn1TJNXNyXmcXIjYOdGisYVw4L
         eYLP4IiwHwOQbrdy26sZ2Vwie6sQLpH0QORsD8IkNu58bii/q1HF5pEYA0sxgrIrxxHg
         A5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=OYUBSmT3VH7eZdDQ7fMZ91lcnew+sGEhSV7yBFdrkzA=;
        b=D/4tDtuOH1ahV0hOxnegJ7cwMheLTbtAVxiVcNUW1UkRgB8nSOaPydH6tI0Vvyl4zT
         4hjwMp2QENF/7mQFqq7cksLou7iCKv8yL+BCxUWuBP7L6gxEnWWjTd7Wd4xfi0Wu17xR
         feZXiLM0RA6WSW50SpRblpJQ+to3M5/+kokq9T+HbuBTT5D2Q4inoAPK1qeHQQ0sG1Xn
         4dHfM5JvNmhCkpBw1vP8IaHsg/ipHCIl9zO5RD4Mqb1cyBcwbY+921V6RInNRkfQxtd1
         Lf1Bmg9luNujA6oTJ9wKSESWpBfll8eT5XQ7DKDPnH6STmmR3+/JPr3kmXt57VxZb3Rj
         rpiA==
X-Gm-Message-State: ACgBeo38LMgC59KfRp6s+4J8Sk2YeHkf7UThYa41MJr245Y9uqTL50BA
        WAEXqiQRa4zfX+5ny0G4t/p4HEIowL07W6mvyXXgbg==
X-Google-Smtp-Source: AA6agR7U48+bT4iSfCh3vGfxQT6GTKPO2tOE9J0f7KAZqT3b6b7t64Emfk7gm2m538KOwSdral81YJHlTu+ZpJA116E=
X-Received: by 2002:a7b:cb44:0:b0:3a4:e8c7:59a2 with SMTP id
 v4-20020a7bcb44000000b003a4e8c759a2mr12996744wmj.67.1659971216755; Mon, 08
 Aug 2022 08:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <defae7d2-5f3e-5de1-bcd0-f7ee7871a9f9@linux.ibm.com>
 <20220808083618.GA35313@leoy-ThinkPad-X240s> <b8ce5423-f6ee-42bc-75eb-ce182cc325b8@linux.ibm.com>
 <20220808105556.GC35313@leoy-ThinkPad-X240s> <F4B3D957-548A-4AD6-B00A-1C5BDD18E6EB@gmail.com>
In-Reply-To: <F4B3D957-548A-4AD6-B00A-1C5BDD18E6EB@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 8 Aug 2022 08:06:44 -0700
Message-ID: <CAP-5=fXfPgtiQnvZDoLTveGWgC9O5uGFFfxAst8jhLgyTT+5Vg@mail.gmail.com>
Subject: Re: perf recording with java runtime broken with commit 2d86612aacb7
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 8, 2022 at 4:30 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On August 8, 2022 7:55:56 AM GMT-03:00, Leo Yan <leo.yan@linaro.org> wrote:
> >On Mon, Aug 08, 2022 at 11:25:29AM +0200, Thomas Richter wrote:
> >
> >[...]
> >
> >> > Ian has committed a patch "perf symbol: Fail to read phdr workaround" to
> >> > address java JIT symbol issue:
> >> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=tmp.perf/core&id=6d518ac7be6223811ab947897273b1bbef846180
> >> >
> >> > Could you confirm if have included this patch in your code base?
> >> >
> >>
> >> Thanks Leo, this patch fixes my issue.
> >
> >Great!  Thanks for confirmation.
>
> It's upstream already:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6d518ac7be6223811ab947897273b1bbef846180

Thanks! Plus the fixes tag is there and so the backporting should
happen. Nice to know this wasn't broken for long.

Ian

> - Arnaldo
