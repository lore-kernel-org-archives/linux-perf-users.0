Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4EEC43334
	for <linux-perf-users@archiver.kernel.org>; Sun, 24 Jul 2022 03:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbiGXDmg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 23 Jul 2022 23:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239162AbiGXDme (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 23 Jul 2022 23:42:34 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83F617E32
        for <linux-perf-users@vger.kernel.org>; Sat, 23 Jul 2022 20:42:32 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 75so14420662ybf.4
        for <linux-perf-users@vger.kernel.org>; Sat, 23 Jul 2022 20:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7+ulekm/rIpNgF6zTp1SluoPjC0MHxhO3RCNuWMRhc0=;
        b=MA749CnffTv8Toy957TETK5/uzo18jM9ZnA02l8w9AAhl1KngdiFPqt8W7S8xmPMU0
         9Wcd6zZR/uekzIsIYmW2/PMzGpBuWBM0lsMtsCQQCNd8D27zrgGxu6sKQKgbKjBWCPeV
         7APKhelSBKJrMjvDeAlSWiwZQER4orO8lZtS2n1AFlXpIp1FEpzTNKnsKpALt3cA/Miu
         Pgzpoly31/jJbklslE12C782r30Q7zSmJ29/mPm8VmgDB86i68HtN6E0O3t833huJAjF
         LabsdOBC3Uiog2gG41u+gRAPPmby2s2y/1a4iDEMuMVBo5fHFnZuza5MGi2wJnQ+C+4j
         elYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7+ulekm/rIpNgF6zTp1SluoPjC0MHxhO3RCNuWMRhc0=;
        b=uwJQRMm6tXxeTiCE2s5q+qLngxe/HsDRKSm/qMByI98EB8Ls4eLWCcFLruQlNfLLin
         JE+5MGVbuQUTUsBodJikpNblnjg6qctJn4LsUjJM4ANh1PyEuDfN3Q4RjDUtSHOGSmUk
         W68hl29EsBJ31F8lRAQoGhdTlPHdwQo1FGg2hww3s4/+3cFRrS+dm1LuGuNXjwdj2+Fx
         JIWuijdv39i6UzEn8q0EwmRADtV46hBSAQlgarS7dWjoswrbtObzvgWUuJy/WoWllbiN
         wVtPjx8c3j+Jy59LR/oyQ/7SHXglQSailOIa3OrHKcbAnIglRO1cFq0hK0yKoDZ6yY+j
         puWg==
X-Gm-Message-State: AJIora9QEA6qVI4eVOE3/vSLqxa8tb+CzcSbwqHdg5XLroTBXG8KSEle
        90mQ+5v6xXrdjk2VvC430h2wrdN8Cyx5x/O9n7dn0X3kT3mtpw==
X-Google-Smtp-Source: AGRyM1u3/+a4fvHVyUtV1UOj4lRmnGThAZPeEWymbo8IaqjzC1mi0MTNqX9E/MVsRDKFE6aPoabdWDCWM4yoX7zrxEo=
X-Received: by 2002:a25:40c4:0:b0:670:b7da:6329 with SMTP id
 n187-20020a2540c4000000b00670b7da6329mr5147202yba.250.1658634151265; Sat, 23
 Jul 2022 20:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220724022857.2621520-1-leo.yan@linaro.org> <20220724022857.2621520-3-leo.yan@linaro.org>
In-Reply-To: <20220724022857.2621520-3-leo.yan@linaro.org>
From:   Fangrui Song <maskray@google.com>
Date:   Sat, 23 Jul 2022 20:42:20 -0700
Message-ID: <CAFP8O3LJq1rt6i0_rAW5pShUiA=FJ38ceb4Ps0KmLdCNzC9xbQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf symbol: Skip recording symbols in
 '.gnu.warning.*' sections
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Jul 23, 2022 at 7:29 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> Some symbols are observed their 'st_value' field are zeros.  E.g.
> libc.so.6 in Ubuntu contains a symbol '__evoke_link_warning_getwd' which
> resides in the '.gnu.warning.getwd' section, unlike normal symbols, this
> kind of symbols are only used for linker warning.
>
> This patch skips to record symbols from '.gnu.warning.*' sections by
> detecting the sub string '.gnu.warning' is contained in section name.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Presumably __evoke_link_warning_getwd is due to `clang -fuse-ld=3Dlld
-static ...` on a file calling the deprecated getwd.
GNU ld and gold implement a .gnu.warning.* feature which removes the
section. ld.lld just ignores this section as the usefulness of the
functionality is unclear.

The section .gnu.warning.getwd does not have the SHF_ALLOC flag. Such
sections are not part of memory images and I think it is more generic
ignoring all symbols residing in a non-SHF_ALLOC section.

> ---
>  tools/perf/util/symbol-elf.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index ef6ced5c5746..4b621e355c0e 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1277,6 +1277,14 @@ dso__load_sym_internal(struct dso *dso, struct map=
 *map, struct symsrc *syms_ss,
>
>                 section_name =3D elf_sec__name(&shdr, secstrs);
>
> +               /*
> +                * A symbol coming from ".gnu.warning.*" sections is used=
 to
> +                * generate linker warnings, its 'sym.st_value' field usu=
ally
> +                * is zero, skip to record it.
> +                */
> +               if (strstr(section_name, ".gnu.warning"))
> +                       continue;
> +
>                 /* On ARM, symbols for thumb functions have 1 added to
>                  * the symbol address as a flag - remove it */
>                 if ((ehdr.e_machine =3D=3D EM_ARM) &&
> --
> 2.25.1
>


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
