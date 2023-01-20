Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0546C05027
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Jan 2023 17:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjATRj6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Jan 2023 12:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjATRj4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Jan 2023 12:39:56 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DBB5FDD
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jan 2023 09:39:55 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id z5so5501958wrt.6
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jan 2023 09:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=177H3aE/gx4vdhNPl1GvfGMYEJuaLzpSE2GgxhCmBlc=;
        b=RjVYCgDOvY+fWK49/7NF5YasI2KbKC/7zS7TAuHnAfOlTFhFGBetNxgtovE+28IU0b
         Saws/n6Rk7Fjk5IuUwAMF1dUNGDKxDB2u6HVzGJB9MqGyrLBoG/nVNAHyp1nWfNynP5w
         I8FGcfiHoYzShW0jao1qlx7/SzPvhCz4K+ls48ormJUnSsc+NMLkHuGZ/IHAAGF7Oywb
         RX9wEVReB6mLPBpCzW2wMkSjmqAV51Rf6/GYaRpK6IvqdxztgTE4zQsHXG7gWMLr4mPc
         JAELG2cBHV8HTpES5Va1+Ra/ZQTb8DB2uqrIqSWfKVwXP9Ug0HTThsAL/JkLDzO1oLkt
         Ofxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=177H3aE/gx4vdhNPl1GvfGMYEJuaLzpSE2GgxhCmBlc=;
        b=MNHd/cGKQj70QNolZGrI3SBIQRK7W87dW7dfexekLTQTjPVKWYfPR7SGGwfWM0SKJx
         R816UbhwQ0AyvqfzRZQ5Rgyznn+c616uSBcGGABmqWwYdREcP21NKwx9XxQ1PYLGs5gm
         qAd8Tac1y2Zvjb2TFPaHAxedX2P0/FZRK3REDtA9p6vg2hq4U0Amo92V8hF268gBoFtl
         SrSPHtzMPEYepaBnrC/s6ADXCf5UY7XLNa67uVuPSb+xlu4oQCdTzaibG86Nmin64Im0
         f16+eQNr4C32aeKgDWlRX4Uk6eefyCoe6RHUpvuWPVFMGjQl7htZlkVIgy09mBggI+nQ
         Cbbw==
X-Gm-Message-State: AFqh2krqXXB/+bXI+t6dtziYmquVgMnnSUaSlIvp6vitgtyesrnK/zuq
        re6BmgJ22EHYLjLFXF99ZMKyzdnY9Dk0EuGw4hCbFg==
X-Google-Smtp-Source: AMrXdXseY93oSeZNttsxTrgs3mqFO1Nxo85jcQgRK5AQqaBmrcq+Dmq7M8ASsDS9tiR0H9uBz/0WiYVHojsW+i4yKzk=
X-Received: by 2002:adf:e2cd:0:b0:2bd:f8da:9be0 with SMTP id
 d13-20020adfe2cd000000b002bdf8da9be0mr516838wrj.375.1674236393299; Fri, 20
 Jan 2023 09:39:53 -0800 (PST)
MIME-Version: 1.0
References: <CAGm1_kv1AiMfq489W5ig05Zqq52Z5zmOxQPrjhb0ci=TSQtPkw@mail.gmail.com>
In-Reply-To: <CAGm1_kv1AiMfq489W5ig05Zqq52Z5zmOxQPrjhb0ci=TSQtPkw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 20 Jan 2023 09:39:41 -0800
Message-ID: <CAP-5=fUdMw=-V3Lfh5gkOf-LbaDksji1OnDonqAhRPP2ORj1Gg@mail.gmail.com>
Subject: Re: Profiling ftdi_sio driver
To:     Yegor Yefremov <yegorslists@googlemail.com>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jan 20, 2023 at 3:55 AM Yegor Yefremov
<yegorslists@googlemail.com> wrote:
>
> HI,
>
> I have network performance degradation on TI's am335x platform when
> enabling the low_latency flag on a number of FTDI ports.
>
> When I start perf to record minicom's activity, I see no traces of the
> musb or ftdi_sio drivers:
>
> perf record -o /tmp/perf.data -p 315 -gR -- sleep 10
>
> But when I examine the perf.data with -D option, I can see that such
> events were recorded. What do I need to see this info in the call
> graph?

Hi Yegor,

you forgot a "-a" system wide collection flag. You are just profiling
the sleep command, and it of course does very little.

Thanks,
Ian

> Regards,
> Yegor
