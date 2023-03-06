Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6559FC61DA4
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Mar 2023 21:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjCFVqU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 6 Mar 2023 16:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCFVqU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 6 Mar 2023 16:46:20 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52327532B9
        for <linux-perf-users@vger.kernel.org>; Mon,  6 Mar 2023 13:46:19 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id 76so4620347iou.9
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Mar 2023 13:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678139178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0be8Fuk83PUDgGdvru7aKlbepqqNL6DJVgCmbNx06ek=;
        b=NussaeJr1ZURMudzZH5Mbi0lfWMbHfYKjS+es87wSq6ARBboWjMkatuMD3W7YOPaLc
         v7sCF2jZT5zs/OLCxoHV2cbP0+Im8Nfn1e7bKwW1u3sCOOOxGT9D/v4ZD1Ir3igM7DG2
         kGT2ZlUsqkVwDfGTFLQ/8g0Zt8vYRjuog9po1NtPWRGJGJEQqPnN3B9aMdL0owfsq3e2
         UEKXie4om7S4FfLHhncwkxCIrW1K8xmqU9gpsoGn0ik6rhW1bppTjWNpNPPEvKI9Q53B
         v/z6nr221lLE42r/qqrtrw5XzAKdznW2wBgKOooUZwoJEGv5k8+kAXDYMkVwm6qvMLVG
         2fzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678139178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0be8Fuk83PUDgGdvru7aKlbepqqNL6DJVgCmbNx06ek=;
        b=JiWg7Wtpaa4XAW8NNGbf1TJ1wmEweL7HisDThvD649zLMGCjwGA7eqbNRw1BovkRIy
         2Bv3EyDdzaBEdsVxerQsG7G8L6MxGBAePthbb6BM256CE0hFrZXi0EfdE+1fWzFu9qbF
         LZClh35WI+69xwM0i7zv4H7uUh3/V77f/FPGOM/VQcA7YnmfRYRme7Tioe2t/Sd9hcrL
         KOksAk/tEh17RSR+z9+vwigbkLV165VYpyIfH9McsLGzwLW0NOeD2fK+uN1rGHJHKX0t
         3NDzJT0rM/PQDZP9kw0zgEhZAaYO4/BpWBLON5KLImboh2MZBma0wu54AsxRa/nkd9dv
         ZIkg==
X-Gm-Message-State: AO0yUKVFuxxrRsuMnxfbuRjWRLFWnlM4CDCEaRNXxAK8H+qFfGZK9kgU
        +xQrkMISQLNZ1sI6lT31TpwQFk3rUa3+Ewmf8MlGJQ==
X-Google-Smtp-Source: AK7set81xTHXxgxn+7pCS9xs2h0YSAn5FF+ggGpxzIwLmVvOAUeYfc1xekrqoskI97yyEpKGM6sa/Rfc3YVFbsnKni0=
X-Received: by 2002:a02:2ac1:0:b0:3eb:3166:9da4 with SMTP id
 w184-20020a022ac1000000b003eb31669da4mr6324985jaw.2.1678139178477; Mon, 06
 Mar 2023 13:46:18 -0800 (PST)
MIME-Version: 1.0
References: <CAGKjw9KHDnVgRz5bstJYkq4t0-bT5fvkuQZbEB48d-8jo4Q00g@mail.gmail.com>
 <20230303193058.21274-1-patrice.duroux@gmail.com>
In-Reply-To: <20230303193058.21274-1-patrice.duroux@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 6 Mar 2023 13:46:07 -0800
Message-ID: <CAP-5=fV5h9AEf3V1taXA++frs=AAPeuPbd=Hb0koVjKfGpQNsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] replace 2&>1 by 2>&1
To:     Patrice Duroux <patrice.duroux@gmail.com>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Mar 3, 2023 at 11:31=E2=80=AFAM Patrice Duroux <patrice.duroux@gmai=
l.com> wrote:
>
> Signed-off-by: Patrice Duroux <patrice.duroux@gmail.com>

Fixes: ade1d0307b2f ("perf offcpu: Update offcpu test for child process")
Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record_offcpu.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/s=
hell/record_offcpu.sh
> index e01973d4e0fb..f062ae9a95e1 100755
> --- a/tools/perf/tests/shell/record_offcpu.sh
> +++ b/tools/perf/tests/shell/record_offcpu.sh
> @@ -65,7 +65,7 @@ test_offcpu_child() {
>
>    # perf bench sched messaging creates 400 processes
>    if ! perf record --off-cpu -e dummy -o ${perfdata} -- \
> -    perf bench sched messaging -g 10 > /dev/null 2&>1
> +    perf bench sched messaging -g 10 > /dev/null 2>&1
>    then
>      echo "Child task off-cpu test [Failed record]"
>      err=3D1
> --
> 2.39.2
>
