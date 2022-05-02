Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8549CC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 May 2022 16:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242745AbiEBQim (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 2 May 2022 12:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241337AbiEBQim (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 2 May 2022 12:38:42 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63ED2315
        for <linux-perf-users@vger.kernel.org>; Mon,  2 May 2022 09:35:12 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id v139so14133832vsv.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 May 2022 09:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z6DJ90ODhfcrzyxsdSLI1aufmTQv+nQ7WMbPe23N6Co=;
        b=IMs055+hzcvDtAmdZ5LYj6ofVg4Kzj2Dv3sASjpv/mR2QreDifjaqAWAOkNoeVGhfZ
         j9y+hz/ctlaWLs2hf5DLh1FOZ8lOoV+B3zl6Twix2XSPjb18M8qc5e09sXtZ4WkdAciO
         fNXa/pb2T2aLkIJ8HOTvGZW3X6D/YWyvgTAnfuIkts80lYVSm7N70pgtNeRK2DSlC/MG
         KRkzWHaoq/bmUrPWSQ6/fBmHMAwuu96FJflRoyUvEdZ6W9XqQLAMQxhaDRdy/4et9pBg
         EVzCKmclmEni69hLHuDLW2Qxjgfy9mPB3Xk9TcjvNbhCZMaBHgbWyKejgf7uUHQNNKNv
         RBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z6DJ90ODhfcrzyxsdSLI1aufmTQv+nQ7WMbPe23N6Co=;
        b=GucmlFeXUvZQP9Qg64xsMFMUl03RgsPvPDbpTqTfgWqFHE3jiGG9o20ASj0/mkop0J
         olssVWZ4PP9ZUQAm7wujMjVYKFnagHueT9qDfv3JpccOZkkf4ptc6iySIKbplHhuXp3G
         PVXH1FHbBnCmaxvjuXqWRcAN96hq8COVWd7qfjqWwIQuJTmnMWAZDlU+F4jDqYhW98p4
         acMTu04rLcLjGNPzkcgwyCbuWF8F32XosqRbdSelZaFczJVCQaWNcMINfWpshE7vutTF
         3+nBKdC6JlRE0lRT8nYGPFXoZWj/ghbaZV5cErO5neCpXxcfvNQj374h+aNVZmrntHyP
         Np7w==
X-Gm-Message-State: AOAM531kS4DAIgo8PnVTHJ+b7XQVE7Q1uOVLVKM2a367pwWbN4Io2N+i
        6G8b4zbPAG2gn0eAD8JwQh+RDYo9SGPcEIBE70i/HcLd
X-Google-Smtp-Source: ABdhPJztJ2W1embJo/kImZ8RMr4shTPaBiZfLWrRMdF0d8ya0QG0GH0z2pTqcyg/lCTQQ/psSYZgdp53+oe4lXy2v40=
X-Received: by 2002:a05:6102:3091:b0:32d:204b:d489 with SMTP id
 l17-20020a056102309100b0032d204bd489mr1302449vsb.4.1651509311559; Mon, 02 May
 2022 09:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fWkxtm5-Ebwkh4pzA83prvuAJ5yy6CKQYatdkKWu3Tgeg@mail.gmail.com>
In-Reply-To: <CAP-5=fWkxtm5-Ebwkh4pzA83prvuAJ5yy6CKQYatdkKWu3Tgeg@mail.gmail.com>
From:   Tanusree Debnath <tanu235m@gmail.com>
Date:   Mon, 2 May 2022 09:35:00 -0700
Message-ID: <CAPS78pqVdNLWD1bAm6ds7D==+sOaL4amLYZ4wiQgT79zC5xprg@mail.gmail.com>
Subject: Re: Linux Perf Tool Office Hours
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,
Thanks for the email. I have taken the survey and selected the times.
Regards,
Tanu

On Sun, May 1, 2022 at 11:12 AM Ian Rogers <irogers@google.com> wrote:
>
> Hi,
>
> We have multiple Google summer-of-code applicants this year, and we'd
> like to have a forum where they can discuss their proposal, work,
> problems, etc. with the wider developer community. As such we're
> proposing to set up biweekly office hours. It could be that these
> office hours provide useful for other discussions too. To work out the
> best time and video conference tool for this I've created an anonymous
> Google form:
>
> https://forms.gle/WCN19uMjp15bNRJV6
>
> Please help determine the best time and tool by entering what works
> best for you.
>
> Thanks!
> Ian
