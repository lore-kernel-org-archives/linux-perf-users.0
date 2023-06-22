Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FB1EB64D8
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jun 2023 06:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjFVGKz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jun 2023 02:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFVGKy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jun 2023 02:10:54 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2982EEA
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jun 2023 23:10:53 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40079b6fc56so106311cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jun 2023 23:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687414252; x=1690006252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYE9CLgVFQtQm8opYgdm6U7/H5rXIkw4SGgWMqIYMIM=;
        b=ip1H0KdmMFuPHihoBZbV7B1Abp73bcPGtQXZ6+CJELnHoTeZ5BdhLp0tDKG9V8sOjT
         a8AoZ9o93WzeNjglJWkTlaCpz5ApE0hN/fMFHmZLF7l+CPbVZCRny5kBNezVZp+v+8b0
         S6CpiRP0Tsm30XDAc7urBYRqMohqE0CpeClvMlcobDdqp3iDllg5mjIlBtZWztvYg3L4
         2PthPEu1KbqucLF0vJyYoDvvkmI3Mg9jIiiQbtk2PtoVH+WtO0ipOtFYKjEqHw6Nz/Rd
         +ZN9wY94ulMa/bSKlLtGW/BpPicfVrdYna9tqa28OlXK3nQrsis9l6l/YMySUQ1MNmmM
         s5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687414252; x=1690006252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYE9CLgVFQtQm8opYgdm6U7/H5rXIkw4SGgWMqIYMIM=;
        b=TefjZqV2OIJiwRUh7ktlRo5VHq16DVD6nGp+ZWWvTvTu6vpsnsbeQFX+7xDW+WoP9O
         ffm6d3pQSzMDO/64qz8LmA8SERy4NxZcA1cHGVZHdlec39xWyjMnDAQmTg31JPiSWgph
         /w1sFKSRma1LmHgIx/0JqOEE/VNprZQu5RNvbyo0KochPs0UTee0d8yNS328EDmqqBrg
         kPFnwHy/6kuUd718VokJwUvqgh4wt10BzC1N5tuWUfHkdo9VpiffU94FN8bQtWRjgsyR
         xZptZGt2Y1SZUjB46dEuSU1TD2/4NUDTSkKBcLFg4fFD7NSFojJuq1Ie01RhFjkp1+DE
         Yb4A==
X-Gm-Message-State: AC+VfDymJ01Lr7wD9W+wBWobxnxPFFlcqK6NnRNzhdZJjBSxQDARvJJq
        WwWYscxvAAD2FQXheiwDtNH/6saoOyeEmbbx2sj86oFXvfkkMqQxCRxVgA==
X-Google-Smtp-Source: ACHHUZ6yfCSlxw2Wh4CLROnlJRDpIZhEdEJ50amQbK8JFiamxCjMXQHXdz1MqFL8J10j7oOyig3qX0OhLLg4SMoznb4=
X-Received: by 2002:ac8:5989:0:b0:3e8:684b:195d with SMTP id
 e9-20020ac85989000000b003e8684b195dmr850369qte.10.1687414252084; Wed, 21 Jun
 2023 23:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <ZJOmXU/41HMzanM9@tassilo>
In-Reply-To: <ZJOmXU/41HMzanM9@tassilo>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 21 Jun 2023 23:10:30 -0700
Message-ID: <CAP-5=fWZAcXcE3CP-V7t=gSehO-AacHJWhjHjtA5nCd5B2-n1A@mail.gmail.com>
Subject: Re: Perf stat regression from d15480a3d67
To:     Andi Kleen <ak@linux.intel.com>
Cc:     namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 21, 2023 at 6:39=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> Hi Namhyung,
>
> I have a tool (toplev in pmu-tools) that parses the perf stat output
> for generated command lines. It expects that the output contains the
> events in the same order as specified with -e.
>
> Unfortunately this broke for uncore events.
> I bisected it down to the following commit.
>
> I believe just arbitrarily hiding events will break any tool that parses
> the perf stat output and expect the input order.
>
> Can the original problem be fixed without hiding events?

Hi Andi,

Can you provide an example that is breaking?

Wrt event order, cases like:
```
$ sudo perf stat -e '{data_read,data_write}' -a --no-merge sleep 1

Performance counter stats for 'system wide':

         1,960.81 MiB  data_read [uncore_imc_free_running_1]
           438.48 MiB  data_write [uncore_imc_free_running_1]
         1,961.85 MiB  data_read [uncore_imc_free_running_0]
           438.79 MiB  data_write [uncore_imc_free_running_0]

      1.001127356 seconds time elapsed
```
Reorder events so that the PMUs match (ie the -e order would 2x
data_read followed by 2x data_write). This covers more cases now so
that perf metric (aka topdown) events aren't broken when coming out of
metrics:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/util/parse-events.c?h=3Dperf-tools-next#n2139

Given the original commit message there seems little point to give the
0 counts, but perhaps it is something that could be done on the more
tool oriented CSV and JSON output formats.

Thanks,
Ian

> Thanks,
>
> -Andi
>
> commit dd15480a3d67b9cf04a1f6f5d60f1c0dc018e22f
> Author: Namhyung Kim <namhyung@kernel.org>
> Date:   Wed Jan 25 11:24:31 2023 -0800
>
>     perf stat: Hide invalid uncore event output for aggr mode
>
>     The current display code for perf stat iterates given cpus and build =
the
>     aggr map to collect the event data for the aggregation mode.
>
>
>
>
