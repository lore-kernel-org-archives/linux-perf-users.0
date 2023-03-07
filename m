Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B155C678D5
	for <linux-perf-users@archiver.kernel.org>; Tue,  7 Mar 2023 19:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjCGTOI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Mar 2023 14:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjCGTNv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Mar 2023 14:13:51 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D659CB5A84
        for <linux-perf-users@vger.kernel.org>; Tue,  7 Mar 2023 10:57:35 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id 76so5790150iou.9
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Mar 2023 10:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678215455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0pbmPRNbXrzsHBMsodzTv9eJ/PC2/e8eNMA9CMb/ik=;
        b=H/WxmF8mAmEt2YRM1fzfbr7qBd1F5KbQakgYYiMZVOOOGjf3w/gj9FQ373K9sPZkZK
         fto3bVS9I6+ma2fOBi5ItjLwBkJzG4uh4F6MgFhORDu/xTAbm9pYAbLAfZErYGuf2Nj4
         mhNDQ3N8J2oTJw7VZ6gKbgyaUeBkFz1PWLo+YsmTISafh48tM1n7AvQ7ZEon+QGoUxAn
         tvWtsjnc6fB7Rmy+fis4DYfEolo/UiZoS83PNyIUmHHa6tOqie+G6J7xTAr05vcY4VhQ
         yEQiJ+m+I2v+t1kN6R2kGoZ9hHZWyF8tzKxVH0tPW0Hgh2JoSYrMr2dbUndRWlCdj1up
         bthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678215455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0pbmPRNbXrzsHBMsodzTv9eJ/PC2/e8eNMA9CMb/ik=;
        b=HkPjegalKyQf9VIwz/7lzXWI5kTM/2E3f7rW8lSRvmhlx+EkfPyArs4x8ltEHGb5LL
         ciYENIN553gLlIU2fHIH+ysSm44NgepomVP3ofeoC4Nzl8oJrXjr69UZVFk9zqN/RvC9
         0ZAUV78XwQsfela3oqklprvZfU0uZHgs70r00U5i+41+QrlWuIVwsuoSPCnRF8bQoera
         Yp76V92WEysd1UV6nDyPkeCMdqvuuB8/p8CWhHPND61a5Cy9x7tLPwo8cDsfWr2JjUnV
         OLxadGRbQm5IYXv+XHn42VnFXzpsDFx8/AMYytJG/vYT9XHyhbwHebYEGmIzVlRsSa6r
         LhgQ==
X-Gm-Message-State: AO0yUKWqFwzlTNd5ebsVkqs5yiUiYRLuIQlQvNFTZoomYh07JUBXFX+y
        XRE5D944EI62OuwmcjmfPt42MatX0x1fLLEM0XwYdg==
X-Google-Smtp-Source: AK7set/QGVMXIpm1l175E+xg6ISSt37krg0c7JX+s26xfUQYkoh73esb7bIYNBGvnUoiwWFBjnuSOZXGlGzC4LT1DxM=
X-Received: by 2002:a02:862c:0:b0:3f6:e3c2:d4be with SMTP id
 e41-20020a02862c000000b003f6e3c2d4bemr2424951jai.0.1678215455119; Tue, 07 Mar
 2023 10:57:35 -0800 (PST)
MIME-Version: 1.0
References: <ZAZVazubl60xYaO8@yoga>
In-Reply-To: <ZAZVazubl60xYaO8@yoga>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 7 Mar 2023 10:57:23 -0800
Message-ID: <CAP-5=fVT3vh8j8FVAdr2Zp2bTpCxdLGW4Gkndb6-mmNdRcW7ug@mail.gmail.com>
Subject: Re: [RFC] Open Source Contribution | GSoC Perf
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        namhyung@kernel.org, irogers+gsoc22@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Mar 6, 2023 at 1:04=E2=80=AFPM Anup Sharma <anupnewsmail@gmail.com>=
 wrote:
>
> Hello, Perf!
> I'm interested in joining the perf community and learning more about how =
to start contributing because of my desire to learn more about the Linux ke=
rnel and performance.
> I've only recently started using Perf Tool, but I'm really enjoying seein=
g the metrics and outcomes. I want to resolve a few inconsistencies I found=
 on a wiki page while learning, so if you have any suggestions, please let =
me know.
> 1. LINK BROKEN under Tutorial-> Linux Sourcecode: /tools/perf (hyperlink:=
 ) correct (
> 2. LINK BROKEN under Hardware Reference -> Performance Counters for Linux=
: hyperlink for PCL core kernel data structures, PCL core kernel internals,=
 perf tool internals are not available. Can anyone help me to know why this=
 contents are not available on wiki?
> 3. ALLIGNMENT : Under Glossary -> BPF counter, Off-CPU, Multiplexing is n=
ot alliged properly.
> 4. INFO MISSING: Under Glossary -> offcore is TODO.
>
> I've also invested some time going though Brendan Gregg conference talk a=
nd wiki page,  I'd be delighted to contribute to any of the open tasks!
> Thank you all for your time.

Thanks Anup!

Updating the wiki is great! I was looking at your changes, I'd
encourage linux-perf-users to checkout updates at:
https://perf.wiki.kernel.org/index.php/Special:RecentChanges

I wanted to give some feedback on just one of the changes:
https://perf.wiki.kernel.org/index.php?title=3DTutorial&curid=3D22&diff=3D3=
921&oldid=3D3520
The maintainer's source tree is at:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/
which gets integrated into the main Linus tree at:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
I think it would be better to use these rather than which given the
version number in the URL looks quite out-of-date compared to Linux
6.2:
http://lxr.linux.no/linux+v2.6.39/tools/perf/

Thanks,
Ian

> With regards,
> Anup Sharma
