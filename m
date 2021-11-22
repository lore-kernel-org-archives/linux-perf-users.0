Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B5DC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Nov 2021 16:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbhKVQvX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 Nov 2021 11:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbhKVQvW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Nov 2021 11:51:22 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20172C061574
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Nov 2021 08:48:16 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id w15so18784113ill.2
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Nov 2021 08:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1gACT1sHKqFy5UIECzTsfbajrpwS6UaEnlIAguK+Trk=;
        b=oA2Mc0OB5WBLQIIDgSgGg6bBzeHocJzN8eDkh1mmq036Kc+Nz4yxJaYyFfQL2K7/Sk
         XfAUKxxCyUz14W8Aw2n/WZqHQ09ErGnXPt+4Yde0BjC+xEH2ai+QJIMQaxBVQfy9GQCD
         AOX/QgZiXsEDIJe14JYmH3VIGWAdOWyEhCe39CZ+Y9qmg16PXIFojtSTAUKUNhPAsUm5
         xH79O3uabEZCT0jXya/s0k0SMVmC/Z4kRi2MfFs95U3aaHZCbGzXkU+Of6jSRdNn1Q1n
         xhAx/ZYPmdwekIB6QQBHG7Rpj7HyF9V+ACJzysU8qbKmLeEm5VRiLNCbERXxEMTRgQWl
         wmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1gACT1sHKqFy5UIECzTsfbajrpwS6UaEnlIAguK+Trk=;
        b=KI2Oa4pmTmaXfrS+ZmYXl5fdh8AmgyTRzzq3EvF5Xse9yC6AGxhKgxouRCjrkZtFQD
         Ga5csHtY/PHzSeet5WufVogffDnELMHw6zbbJzSvuMws4ib1jJfY7OMeBxURfn9UfEZX
         046laRlG9vAOdysV7OKbwyq7sZEJT6PCHW7/rCjsPUiaSD9MbcRNSl68G/h6cwQGGizO
         6yX0Gf+3BhINwMyV5gx9JecvehlMmLMJ+Q6Gu1Uq7Yx1jqkm4gj8i8ayVCoVc1ocRbVd
         yIN5E04pxLwNuiY6CrYLMWhTNnUfhhmzAGfvRUeBllL7721M0clN62fJ0VZ+sdDS/eZP
         ctdA==
X-Gm-Message-State: AOAM533HpPUl35FIVN6JlpxWuasx5aDUUqICR7qZPIe4YQqjiRBrLcfk
        FAAgxYLF5HGfG/7pC7mVRTyARrRceC9/vTkIkMLBCQ==
X-Google-Smtp-Source: ABdhPJxeAgcZlHqN6XQTNcvD/+t6dSTweFQJZ1xcabSsBQondCIN5Y5GSscFgnJ0nzXWHKVI6RoY8LlG1zlGcKNR8Ow=
X-Received: by 2002:a05:6e02:8ee:: with SMTP id n14mr18174132ilt.53.1637599695359;
 Mon, 22 Nov 2021 08:48:15 -0800 (PST)
MIME-Version: 1.0
References: <56480f10-4b9f-e88f-7c67-9158868a8e44@linux.ibm.com>
In-Reply-To: <56480f10-4b9f-e88f-7c67-9158868a8e44@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 22 Nov 2021 08:48:03 -0800
Message-ID: <CAP-5=fWaFnQYRqEpS6SvN5pijrRP_0xjX+UpW4Vvpd46LNq6Bw@mail.gmail.com>
Subject: Re: Perf test 7 fails on s390 (perf expr: Add metric literals for topology)
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 22, 2021 at 8:04 AM Thomas Richter <tmricht@linux.ibm.com> wrot=
e:
>
> Commit fdf1e29b6118 ("perf expr: Add metric literals for topology.")
> fails on s390:
>
>  # ./perf test -Fv 7
>    ...
>  # FAILED tests/expr.c:173 #num_dies >=3D #num_packages
>    ---- end ----
>    Simple expression parser: FAILED!
>  #
> Investigating this issue leads to function:
>    static bool has_die_topology(void)
>    {
>         char filename[MAXPATHLEN];
>         struct utsname uts;
>
>         if (uname(&uts) < 0)
>                 return false;
>
>         if (strncmp(uts.machine, "x86_64", 6))
>                 return false;
>
>         ....
>    }
> which always return false on s390.
> When I get this right, there is no build up of CPU topology with
> dies on s390. The the #num_dies value in above test is always zero
> and lower than the #num_packages field.
>
> I am also suprised by the architecture specific code in a common
> code function. Wouldn't it be better to define a weak function with
> archticture specfic overrides?
>
> Is this intended?
> What is the recommended approach for other architectures?
> Should I skip this test on s390?
> Should s390 invent die for CPUs mapping?
>
> Thanks a lot for your help and advice.

Hi Thomas,

sorry to hear of this breakage and it was in no way intentional. The
'dies' ABI is supposedly stable:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/ABI/stable/sysfs-devices-system-cpu
hence having a test. It looks like something to dig into for s390. It
seems preferable to fix s390 than to add weak symbol workarounds.

Thanks,
Ian

> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> Vorsitzender des Aufsichtsrats: Gregor Pillen
> Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
