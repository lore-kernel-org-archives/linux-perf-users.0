Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0B0EB64D8
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jun 2023 04:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjFNEof (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jun 2023 00:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242712AbjFNEn4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jun 2023 00:43:56 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E68EC5
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 21:43:46 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f9b7de94e7so150401cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 21:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686717825; x=1689309825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xStsRUfwt3o1gdSJ2s0/TITPGbAEFU/Ue0fEGPIasQk=;
        b=o1ZcBfYUpUqhK/eDBa8d1BZLnrTaqO+mpq2YE0uVA6w8pdtdmWJP5yF5LxarZ3UOx1
         4TZEC6Hy6WEZb0qMVSxsJFbYoaGZ5MjQFAB9LTTblu/QvWo2gV2qruPsFHFyBJenIkvG
         pZu6SUqYudGDeO1jcglkIkwoYL7vMHhIQzVWJgjK3YODYqIdgDg9lYO5l7ayLdmeV53q
         cplKuBbrWLkPNWTydZ1MYxDRXlLkayeci2jXI8LRe9sjH0HptpUsTfP03OKx5P8RKlqe
         JqnojCEe6lU+4flYogW0LdPxOgsQx3YYRnhOcBD5zgSroiVS8CHzcWK+hCWIiM0YlgGu
         8shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686717825; x=1689309825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xStsRUfwt3o1gdSJ2s0/TITPGbAEFU/Ue0fEGPIasQk=;
        b=fBMMQStUwfAEoumJ3tJl2BNbHv6adr7V5kUihjQPLfgRMvzxmt9/ShRF8Lz1LGnWwP
         ACaOGrdWn5E1ojbU5jgmFrOZdbE3kVEaqaaHja7AqYYRwlC74lGuWjlUMasdwqZkNeJK
         S9ZN7/oh7Ng0ZTm2Of24hTbOc4MJYycvL4b6pXCiqf8rP83fS3Z2W4u7CrRfqWh2LZWB
         qK5Sp0Ewtbra9U2e1umjVDcFfE29p+BZ0kohxv26cBrAxL1+2G+5puEA6ysVwmNNjoSy
         mnRtRUYsp9L3l29iHJR6Hdljxe8Z0T6cJEVW74R4M5KpNC6sjKCa0aDTtme1/xbJAHNw
         sFPw==
X-Gm-Message-State: AC+VfDz/2nUwg4Yp3hWIbb9wPbcfdVthZFNPqAYY+NlFhJH85fX+KjsN
        2aw36KWSnBKJ1qjInnAwnJM/pFO781a2hkpY3/kVCQ==
X-Google-Smtp-Source: ACHHUZ4OL9sIBmAtVDwp+dVs+Z6kDk/oIf/XsL/DfGPr7PN8H8rO2tnVAE26UuOfmXB4RQ4DbPv1fCriI9iSl6bvovg=
X-Received: by 2002:ac8:5743:0:b0:3fa:7dbf:f268 with SMTP id
 3-20020ac85743000000b003fa7dbff268mr55189qtx.23.1686717825150; Tue, 13 Jun
 2023 21:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230614033437.48549-1-luojianhong@cdjrlc.com> <475df60d9dd518e20ae9df396c60b69b@208suo.com>
In-Reply-To: <475df60d9dd518e20ae9df396c60b69b@208suo.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 21:43:32 -0700
Message-ID: <CAP-5=fWtrQABXFnuAQWEuaFcvXJ5gaKf=gZUyTLqm8-aY9znrQ@mail.gmail.com>
Subject: Re: [PATCH] perf bench: remove unneeded variable
To:     baomingtong001@208suo.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 13, 2023 at 8:38=E2=80=AFPM <baomingtong001@208suo.com> wrote:
>
> fix the following coccicheck warning:
>
> tools/perf/bench/find-bit-bench.c:127:5-8: Unneeded variable: "err".
> Return "0".
>
> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>   tools/perf/bench/find-bit-bench.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/bench/find-bit-bench.c
> b/tools/perf/bench/find-bit-bench.c
> index 7e25b0e413f6..70619bc73841 100644
> --- a/tools/perf/bench/find-bit-bench.c
> +++ b/tools/perf/bench/find-bit-bench.c
> @@ -124,7 +124,7 @@ static int do_for_each_set_bit(unsigned int
> num_bits)
>
>   int bench_mem_find_bit(int argc, const char **argv)
>   {
> -    int err =3D 0, i;
> +    int i;
>
>       argc =3D parse_options(argc, argv, options, bench_usage, 0);
>       if (argc) {
> @@ -135,5 +135,5 @@ int bench_mem_find_bit(int argc, const char **argv)
>       for (i =3D 1; i <=3D 2048; i <<=3D 1)
>           do_for_each_set_bit(i);
>
> -    return err;
> +    return 0;
>   }
