Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA98CC0015E
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Jul 2023 21:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjGMVaN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Jul 2023 17:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGMVaN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Jul 2023 17:30:13 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C302D5F
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jul 2023 14:30:10 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-401d1d967beso104481cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jul 2023 14:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689283810; x=1691875810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/JNP/JfTWR5zwBZEIgoOVX2FZCg3paaU7sFnjyCuGA=;
        b=k2MZ1P4Kpki/Girn+QT7nzwToM9hNWc7TU8O8Ly7tH8gky0evrmGx9S1n9NMIDlvuD
         5U+HidgzvL0wGuaXKTmtNwZkQ+M/kpX0fbBL6AaBeGohIkAiAqtfkEmbCNzeQPSjULyc
         bVPitfLnJScw2apTOPN5dj5XMajjC3dDDjBnn+gNKF78NFnyL6RhsFVVMmGz2KQRYyyI
         P8JRWw1gKr/gR2705TOCw5q/2EJvNYafqg23KrKtPpUqD8WkTbk9jZ/g4oPdDXez+obQ
         bswNeQ7XcbaUd3OHwfGJcjTtwrjw+zwSV+rE5iYcoQOzu8cwRclpoR8ox+7roVcPEPaQ
         fQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689283810; x=1691875810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/JNP/JfTWR5zwBZEIgoOVX2FZCg3paaU7sFnjyCuGA=;
        b=P/04NXPe8U2Bl6TzsoBLHcqdN/yhmATA7UWKAM6JwFdPIZkxHKxawq8B4rd9sm6lSM
         Jb5TnmJ3xz0oOwXbYRzVVm09cyqBApn5JKJPuwtlArI2vNhRMomGt7bSelsb3bda8q0d
         yPLC2Wmlq46QJlP+14pCH/lQ45EmiQOcSHD2KoiuhAp/WZmk9+r2+xzAlnR/L+H5cF5G
         oJWVNTXnSzEmzEwMTk4Z8x4Ct3iML0rTTCARSCqI+ZC74DP7fuCoH51J+7wZ/m86WDCS
         rdjz+DNddyWqVQZFepe+clQjCf4P+XRsMSZkfTviOnT8mWv3NzQGyzWVoOLUIoYCaQYm
         XXFQ==
X-Gm-Message-State: ABy/qLYMkMKumswAkIr4sYgE3kYa4uen3EK/fgQnXUZmFEgg2HYP/Wv9
        Jtp5tCZ72D1LYdamVGCkw9NwtK8Nb0yPqwbk5BylOQ==
X-Google-Smtp-Source: APBJJlEGg7TIMFdQlcMu2Ev4OCGCqO/0cdvrvwdmMDasWPHdbQJZxHciYjKT/DhzxvRwc7gAktvE7KX6K1vrovbub+Y=
X-Received: by 2002:ac8:7f11:0:b0:3f9:6930:1308 with SMTP id
 f17-20020ac87f11000000b003f969301308mr658200qtk.13.1689283809782; Thu, 13 Jul
 2023 14:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <ZLAphRzys2lcNICF@tassilo>
In-Reply-To: <ZLAphRzys2lcNICF@tassilo>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 13 Jul 2023 14:29:58 -0700
Message-ID: <CAP-5=fXBWNAv1wdp0NzNoUEh6jCnLtug8SaH8QznTFBTeZcn=A@mail.gmail.com>
Subject: Re: perf command line error handling regression
To:     Andi Kleen <ak@linux.intel.com>,
        Anup Sharma <anupnewsmail@gmail.com>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 13, 2023 at 9:42=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> Ian,
>
> Since the commit below, I see the following:
>
> $ perf foo
> Segmentation fault (core dumped)
> $
>
> Before:
>
> $ perf foo
> perf: 'foo' is not a perf-command. See 'perf --help'.
> $
>
> (gdb) bt
> #0  0x00007ffff6f89fe2 in __strcmp_evex () from /lib64/libc.so.6
> #1  0x00007ffff6e6387d in msort_with_tmp.part () from /lib64/libc.so.6
> #2  0x00007ffff6e63bd6 in qsort_r () from /lib64/libc.so.6
> #3  0x00000000005895af in help_unknown_cmd (cmd=3Dcmd@entry=3D0x7fffffffd=
af2 "foo") at util/help-unknown-cmd.c:71
> #4  0x000000000040cb52 in main (argc=3D1, argv=3D0x7fffffffd750) at perf.=
c:543
>
>
> commit 657a3efee43a29d13c4f30e4c8f6a178fd2bf14a
> Author: Ian Rogers <irogers@google.com>
> Date:   Sun Jun 11 16:36:06 2023 -0700
>
>     lib subcmd: Avoid memory leak in exclude_cmds
>
>     exclude_cmds will shorten the cmds names array, before doing so free =
the
>     removed entry.

Thanks Andi, this was also reported by Anup in the office hours.

The regression is fixed by:
https://lore.kernel.org/lkml/ZK2xk2qJE2M+bGCb@kernel.org/
which is already merged and should merge through to other trees.

Thanks,
Ian
