Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D303EB64DA
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Jul 2023 18:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjGESJe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Jul 2023 14:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjGESJd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jul 2023 14:09:33 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A33170B
        for <linux-perf-users@vger.kernel.org>; Wed,  5 Jul 2023 11:09:32 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-c01e1c0402cso6618134276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Jul 2023 11:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688580572; x=1691172572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25IhV79GGxnPjGPOZFmmn6T90UuWMvkNhe+QXJFLRLA=;
        b=WJarxVu0JsqkeuyWyY+hnyEw10kVQKz5inR+1i9HUvmdZIMjqnCjy2FUUwOn4EWlaY
         I1IrrVfwoy0vgRy41uxBiSQnWi28FNoTDxaCCmhg8Pv3kqjWb1gHVsuQN9o1vOVM29fm
         10CJ/Oa5EPsZolZgjIkdSrYCEJUhEFiIkP4n4Wc7rMovBZETwYO06/HkU3rMhjbLgJXm
         Hp4api07s9rrzMnRkKDHU315Q3tVza/PkHPgkMCZEMJjjK1ktgFqMKO8ewBp2iNMfcVw
         I6/uZkt/igtsKi+/xZj9JrmjNcuPgM2pmL2J/6g6izohVOx70+OXc3ToRSzJZuHZ3qOp
         lRuw==
X-Gm-Message-State: ABy/qLZop0JGkGZalL66wnRrjO8E+T6Di3AxqranoD5HApTDf618dA0Q
        325vd2gDVVOr/LKK+Hcod6kTcTAuLYVbLT/Geqg=
X-Google-Smtp-Source: APBJJlHwrS4nf8rJTk5f0YBRHvIgjXfKS71w5014nQJecXOGCKHjxX2wEzvCCeojB12kpj0VL+rOXigMan1MOeWwDig=
X-Received: by 2002:a25:60d6:0:b0:be6:6539:7fdc with SMTP id
 u205-20020a2560d6000000b00be665397fdcmr12273915ybb.1.1688580571841; Wed, 05
 Jul 2023 11:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230704050327.14963-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20230704050327.14963-1-atrajeev@linux.vnet.ibm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 5 Jul 2023 11:09:20 -0700
Message-ID: <CAM9d7chgkbsRn4Zt_hXodEzMYgVQAuAJux-kWQTjCFXb4z=TbQ@mail.gmail.com>
Subject: Re: [PATCH] tools/perf/tests: Fix Basic BPF llvm compile to check for
 libbpf support
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     acme@kernel.org, jolsa@kernel.org, ak@linux.intel.com,
        irogers@google.com, james.clark@arm.com, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, rnsastry@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

On Mon, Jul 3, 2023 at 10:03 PM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> Basic BPF llvm compile fails in systems with libbpf
> that doesn't support BTF. Log shows below information.
>
>         libbpf: BTF is required, but is missing or corrupted.
>         Failed to parse test case 'Basic BPF llvm compile'
>         test child finished with -2
>         ---- end ----
>
> Here BPF llvm compile fails due to missing BTF support.
> Fix the llvm test to skip the test incase BTF support is
> missing.
>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/tests/llvm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/llvm.c b/tools/perf/tests/llvm.c
> index 0bc25a56cfef..4c73c9eab0bb 100644
> --- a/tools/perf/tests/llvm.c
> +++ b/tools/perf/tests/llvm.c
> @@ -4,6 +4,7 @@
>  #include <string.h>
>  #include "tests.h"
>  #include "debug.h"
> +#include <errno.h>
>
>  #ifdef HAVE_LIBBPF_SUPPORT
>  #include <bpf/libbpf.h>
> @@ -14,8 +15,12 @@ static int test__bpf_parsing(void *obj_buf, size_t obj_buf_sz)
>         struct bpf_object *obj;
>
>         obj = bpf_object__open_mem(obj_buf, obj_buf_sz, NULL);
> -       if (libbpf_get_error(obj))
> +       if (libbpf_get_error(obj)) {
> +               /* Skip if there is no BTF support */
> +               if (errno == ENOENT)

Can we use the return value of libbpf_get_error() instead of
using the errno?

Also I'm curious why it requires BTF even if the BPF program
doesn't use it.  Is there an option or something for that?

Thanks,
Namhyung


> +                       return TEST_SKIP;
>                 return TEST_FAIL;
> +       }
>         bpf_object__close(obj);
>         return TEST_OK;
>  }
> --
> 2.27.0
>
