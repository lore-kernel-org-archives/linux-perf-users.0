Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA0AC6FD1A
	for <linux-perf-users@archiver.kernel.org>; Tue,  7 Mar 2023 18:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjCGSpK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Mar 2023 13:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbjCGSoi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Mar 2023 13:44:38 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C2AA9DCB
        for <linux-perf-users@vger.kernel.org>; Tue,  7 Mar 2023 10:34:35 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id 4so8932577ilz.6
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Mar 2023 10:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678214006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5IKF/wsNpch5kvYfjJD05zz11I2xpXAsWHYDo9mWyw=;
        b=tNpMm35+X6ecwkKkevjGBZwu1cYO/BLh11Zq9okE/3D3TpHD9Kk9/JbT4qSphJ0x4j
         +W2kYujXN9kAPGd9XWCFCrO7BX7msrEiMs5vdqdhTYiN9sJDNXCZRbdNbEzHe5ap4Q9m
         +HidVxBV9x1lsYRjgHhSWcYleJfOqhEAG0y+Jejo+GnH+8FLpswMTTE5u8DgvSEDqEeB
         80FmZ4WAGRdSPEY3NKXuVDc/GmLk9jndfSDLPaxeHBr8j76NSA1rI7LUDcjNBrFihiry
         vITQgdSlSVw7Asa3dgwdXHjHaVD4ZCsY6g18Iv//DxwoBHrb0RdmbXfPUYP0O8SykxwJ
         Eh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678214006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5IKF/wsNpch5kvYfjJD05zz11I2xpXAsWHYDo9mWyw=;
        b=RYOR1WYPytA2AvjUsMD78aXhthgTUHwO0rMJyYiXkLmLWmKfCOU5TutYM2WRBo1NrG
         hqDkKbB0IQmlY8M7AWvGCGjsitsjPDT6ncKwcNdbY/GJasWMLnXC+aqQ1oShmx64FDqA
         VBpXcvmx3Zy8+nzUrwy2cE0HRQma9gP/IlMuif2aZUl0qHRvfLq+mtAcEG0ezAU8E1aJ
         M0nLCVSGrj+c9mWDO6lHzp5hLX3uhaDAicMly5Kws/gRRl1hbFZyf7rc3y8wzD2hDEYD
         kmmEu5LHtPvEMTTBQBPvnC9U5+kpnxW7XlopN7Pa8enXiLvJFYWIuaTcw8fQlGZ/m51/
         eBrA==
X-Gm-Message-State: AO0yUKWkc5DhaHXaX1DK/dzuXGUXqDHwEK6hNgt3zH0DBKn3PWHbyqdd
        p58qxaQJuO74jwkOW7hOviVeBvwTGzYDB2KJp6UVvw==
X-Google-Smtp-Source: AK7set/BQKxv7tdZI9XQIsj/G34VZUzE4hpqgDN5Gf0wSMpQ+phfmCxU5ogoMAurXeZ2rlA/0THSa/4Uhsky+GD3aCc=
X-Received: by 2002:a05:6e02:118b:b0:315:459e:177d with SMTP id
 y11-20020a056e02118b00b00315459e177dmr7122231ili.2.1678214006007; Tue, 07 Mar
 2023 10:33:26 -0800 (PST)
MIME-Version: 1.0
References: <CABDzTvaZMCoSah-XNnvnewMUkTp_skOSy3Nbhvex-D_=szpJkg@mail.gmail.com>
In-Reply-To: <CABDzTvaZMCoSah-XNnvnewMUkTp_skOSy3Nbhvex-D_=szpJkg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 7 Mar 2023 10:33:14 -0800
Message-ID: <CAP-5=fXZtcs5QGD014MXwXr2871T0Ymabca9RkncU0mO7BXRpA@mail.gmail.com>
Subject: Re: GSoC'2023: Perf: The Linux-Foundation
To:     Madhu patel <patelmadhu06@gmail.com>
Cc:     irogers+gsoc22@google.com, namhyung@kernel.org, acme@kernel.org,
        linux-perf-users@vger.kernel.org,
        "mingo@redhat.com" <mingo@redhat.com>, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Mar 7, 2023 at 8:33=E2=80=AFAM Madhu patel <patelmadhu06@gmail.com>=
 wrote:
>
> Hi Ian Rogers, Namhyung Kim
>
> I'm very interested in working on the project perf in Linux-Foundation or=
ganization through GSoC'2023.
>
> I am Madhu Patel, a fourth-year B.Tech. student in Computer Science at IG=
DTUW, with a current CGPA of 8.7/10. I have previously interned at Adobe In=
dia, Rabvik Innovations, and FM solutions, and I am currently a research in=
tern at IIT Roorkee. I am also working on a research paper on Linux Kernel =
Evolution for the USENIX publication. Moreover, my research paper on Stock =
Price Prediction was recently accepted at the IEEE Conference. You can find=
 more information about my work on my LinkedIn and GitHub profiles.
>
> Can you please suggest a few initial tasks I can work on during the appli=
cation period and attach them to my application? I have already prepared a =
timeline/planner, great if you could have a look at it and suggest any enha=
ncements. Additionally, I have signed in to the mailing lists, and IRCs and=
 explored them as described on the project page [1].


Hi Madhu,

Thank you for your interest in contributing to Linux perf! One area
we're trying to improve is the Linux perf wiki:
http://perf.wiki.kernel.org/ You can register for an account and help
to fill out topics, provide tutorials, etc.

Another idea is if you run the `perf test` command, especially for the
current developer tree [1] branch perf-tools (targeting Linux 6.3) or
perf-tools-next (targeting Linux 6.4) then you will see tests passing,
skipping or failing. An improvement would be to add detail to the skip
messages so that users know why a test skipped. Of course you'll need
to build the perf command to see this.

These tasks are both ongoing, so there's no expectation to fix
everything. For GSoC we'd just appreciate seeing that you're engaged
with the linux-perf-users community and able to make contributions.

Thanks,
Ian

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/

>
> Thanks,
> Madhu Patel
> LinkedIn | Github
>
>
>
