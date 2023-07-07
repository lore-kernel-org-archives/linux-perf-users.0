Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2AFEB64DA
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 Jul 2023 23:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjGGXRJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 7 Jul 2023 19:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjGGXRI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 7 Jul 2023 19:17:08 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C5B1FF9
        for <linux-perf-users@vger.kernel.org>; Fri,  7 Jul 2023 16:17:07 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso3852105e87.0
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Jul 2023 16:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688771825; x=1691363825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOafIyCGwjK7DCqgtmzW7AxV1GIwfC8+hSMuDBuTPac=;
        b=d38MzkGHrUFrrBHcvq6K2D/SYRmb5ZXtPeRyNPbJSx9mJ4Dy0aguumujRC1xm2SUdY
         MnYrydlv0D3wxsIMJCuVd9H0KOaXW1qEE+JnakdKB3czoR7WyksoFZHVhoDDhRKJFk3a
         93YCYi+/J7TuWTiuYfz3k7CQ4HK6Ix21rlyIG4DjNl2YDwzPH7Qb70l2ZAxWxOKs8lcn
         9rx5pYD244sNn7OQf4Q1xQ+RP2xfHpk9RfqmA5LmtBCGKtPGTqykHC+Z0fdA67mJSvZs
         f4s8X4anpxLTAsqGfZEFDNQ4am5zqxiEy/bsyX+y8nWZ6NoVn5IxBvphJj1e6wQC1uBh
         jgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688771825; x=1691363825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOafIyCGwjK7DCqgtmzW7AxV1GIwfC8+hSMuDBuTPac=;
        b=jb5Y9/+YPfNfpmmMaqQsopgVgan0WMhZwij0HIfeVojgefPbQHoLOJjYfJOq6pcoCR
         a70j3HEoZFQ473HbbJ7onki12bQg/gWmJz+Uilf3+y6+U8KKF0kzQd2IEw9lB9SoVMQl
         BVs65CCToAFlXEj71m0vFib/gpYEWiI/WjOTDLFypt2L4rxf+eso47Z7gJAZIt3SsjOJ
         9fcZtRZh3bdxGbIW9NP9OteFI8oEj1BuJNosUdhcND9piMEpI7fWTD25gLLe9g7rTHyL
         DK59wDINPeLbf3W6UXlUI4iVEpxjYQ1szI88XQrIatDkC3bYSE8cYeQfrsvE2ItTFrNA
         VPfA==
X-Gm-Message-State: ABy/qLbIlkw12TbGUKQgnI3wJ7EEET2KyrG9KASy0uIgBoUrk2HpAdPO
        j5zOd0ujSryalqt2Chd06IuWRiNzblsbYUZG3A8=
X-Google-Smtp-Source: APBJJlEC2kKrCFU/v9C6NcYBDQ5uR/lDq3BzFCkQ/KxKo3BPAcXrmqyIyOAk3AQ+n0SBCGzSTBYOBbAwMm7LGvZ3LgQ=
X-Received: by 2002:a19:381e:0:b0:4f8:70b0:eec6 with SMTP id
 f30-20020a19381e000000b004f870b0eec6mr4356489lfa.28.1688771824998; Fri, 07
 Jul 2023 16:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <ab865e6d-06c5-078e-e404-7f90686db50d@amd.com>
In-Reply-To: <ab865e6d-06c5-078e-e404-7f90686db50d@amd.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 7 Jul 2023 16:16:52 -0700
Message-ID: <CAEf4BzZK=zm9PkUwzJRgeQ=KXjKOK9TENUMTz+_FmU6kPjab7Q@mail.gmail.com>
Subject: Re: [BUG] perf test: Regression because of d6e6286a12e7
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     andrii@kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 5, 2023 at 9:39=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.com=
> wrote:
>
> Hi Andrii,
>
> I'm seeing perf test failure because of commit d6e6286a12e7 ("libbpf:
> disassociate section handler on explicit bpf_program__set_type() call").
>

Yep, this commit would reset catch-all custom handler, which perf is
setting. I've just sent a fix upstream ([0]). And once it lands, I'll
cut a v1.2.1 libbpf bugfix release with just this fix on top of v1.2.

Can you please double-check that this patch indeed fixes the issue for
you? I tried to do this locally, but for me perf test 42 fails both at
current bpf-next, with the above commit reverted, and with my fix
applied on top. So I can't be 100% sure.

Thanks!

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20230707231156.1=
711948-1-andrii@kernel.org/


> With 6.4 kernel and perf:
>
>   $ ./tools/perf/perf version
>   perf version 6.4.g6995e2de6891
>   $ sudo ./tools/perf/perf test 42
>    42: BPF filter                               :
>    42.1: Basic BPF filtering                    : Ok
>    42.2: BPF pinning                            : Ok
>    42.3: BPF prologue generation                : FAILED!
>
> After reverting d6e6286a12e7 commit:
>
>   $ git revert d6e6286a12e7
>   $ make -C tools/perf/
>   $ sudo ./tools/perf/perf test 42
>    42: BPF filter                               :
>    42.1: Basic BPF filtering                    : Ok
>    42.2: BPF pinning                            : Ok
>    42.3: BPF prologue generation                : Ok
>
> Is it a known issue?
>
> Thanks,
> Ravi
