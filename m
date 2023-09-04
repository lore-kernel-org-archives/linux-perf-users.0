Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA441C83F33
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Sep 2023 04:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242338AbjIDEFX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 4 Sep 2023 00:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbjIDEFW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Sep 2023 00:05:22 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344CCF5
        for <linux-perf-users@vger.kernel.org>; Sun,  3 Sep 2023 21:05:19 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-414b35e686cso241551cf.0
        for <linux-perf-users@vger.kernel.org>; Sun, 03 Sep 2023 21:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693800318; x=1694405118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vTiutHQJ5tX6C9Vz+jmTI4dlLCn3gjqAwkDhmzq99Y=;
        b=vDsWN7mJEeGb5DRD5yCNyi96lt0CTgIM3dbX11d9jit/pbJZdGf5y6FyLr/OHnnfNE
         LNHIitM5JubwZZHHvDVZzweuOvZomGk2Mhd/cGzkWLlsbT70ClvgCRnrNp9A8x/ST/T5
         0C/lSf6m/bJTwPW65t/BO2ONt5NxPJKc96wM4zJrnlyI2C8Rvio4aknKYpXtbotM+Ed+
         xJDZswP9hEwbpNQazzfgQIvcGH1L5L5pCDp53v6asFWkLWoSFTh6Plfn8F87QbRd089C
         /ItoiO8HkpUepl8iyhxM65bBEreQSz1bjop5h6qxDiWvuCqDqGudgLeO9SBPq8YIl88/
         EGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693800318; x=1694405118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vTiutHQJ5tX6C9Vz+jmTI4dlLCn3gjqAwkDhmzq99Y=;
        b=Qz9uVkaL2ZRqz23K4ZHe1V1LdGr2+F3C9NY7o7Ke251uNgW4rCHGCRuBo/LGrAhWrN
         DjPuCF8DW0sEqG2oNAjKRkznqk2wLz+sHxzWsXLGOPB/bxA64o+h9bxCL3E8bsn1dyi+
         wrYM2Kb0UAs4in8/3bYXHdJQDcA77R9I1sBKM+llIUokx1gfwcW2VKcTWGQP9cdv8AO3
         4ipxaG2bCFlhoDTm8yajAgdjLszyJkgxYD9r6lm8MYJpfcIz3iygUx2PuxWUMNz1w6UQ
         buc2l+36Rm57AtdW2xeE56oNrNmUamOElvHbxvr+SFK9NxoUuHEPEWJBCGhZedcfydOh
         Fg/A==
X-Gm-Message-State: AOJu0YznH2v9R54LoUvU/+T5fBVJycjF7FSVpGcwsMTHdTSnGELYq3Ri
        psnj3/PoXFC/jG6WOI4LuWH4dHMBNNnukCsHfCljEQ==
X-Google-Smtp-Source: AGHT+IEXUMkE3CDSUCOKMUAznwQv7YPuJfMEJZtz/yNTacFjSK/XYTO7H5pL9WFEKxD6lsK9TwXh0ePPmTScS60aYIo=
X-Received: by 2002:a05:622a:1045:b0:412:9cd:473b with SMTP id
 f5-20020a05622a104500b0041209cd473bmr297076qte.4.1693800318283; Sun, 03 Sep
 2023 21:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230812084917.169338-1-yangjihong1@huawei.com> <20230812084917.169338-2-yangjihong1@huawei.com>
In-Reply-To: <20230812084917.169338-2-yangjihong1@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 3 Sep 2023 21:05:06 -0700
Message-ID: <CAP-5=fUVY9eL-t4Ya5bqHz7gDKDSi9=kvDgMdGmb02Yh8LhVaA@mail.gmail.com>
Subject: Re: [RFC v1 01/16] perf kwork: Fix incorrect and missing free atom in work_push_atom()
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, sandipan.das@amd.com,
        ravi.bangoria@amd.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Aug 12, 2023 at 1:52=E2=80=AFAM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> 1. Atoms are managed in page mode and should be released using atom_free(=
)
>    instead of free().
> 2. When the event does not match, the atom needs to free.
>
> Fixes: f98919ec4fcc ("perf kwork: Implement 'report' subcommand")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/builtin-kwork.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index 14bf7a8429e7..73b5dc099a8a 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
> @@ -406,12 +406,14 @@ static int work_push_atom(struct perf_kwork *kwork,
>
>         work =3D work_findnew(&class->work_root, &key, &kwork->cmp_id);
>         if (work =3D=3D NULL) {
> -               free(atom);
> +               atom_free(atom);

Presumably this is fixing a memory-leak. It would be nice if kwork had
perf tests, then our builds with -fsanitize=3Daddress would highlight
this kind of issue. Here is a build command I use for this:
make -C tools/perf O=3D/tmp/perf DEBUG=3D1 EXTRA_CFLAGS=3D"-O0 -g
-fno-omit-frame-pointer -fsanitize=3Daddress" BUILD_BPF_SKEL=3D1
NO_LIBTRACEEVENT=3D1

Thanks,
Ian

>                 return -1;
>         }
>
> -       if (!profile_event_match(kwork, work, sample))
> +       if (!profile_event_match(kwork, work, sample)) {
> +               atom_free(atom);
>                 return 0;
> +       }
>
>         if (dst_type < KWORK_TRACE_MAX) {
>                 dst_atom =3D list_last_entry_or_null(&work->atom_list[dst=
_type],
> --
> 2.30.GIT
>
