Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3CEC19F2A
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Aug 2022 15:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbiHDPck (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Aug 2022 11:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiHDPck (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Aug 2022 11:32:40 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6093FD11
        for <linux-perf-users@vger.kernel.org>; Thu,  4 Aug 2022 08:32:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j15so104305wrr.2
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Aug 2022 08:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CrO/3RU8M4nH9jMDntBlAOSvA7YlDjMGyHvPq8QzUzs=;
        b=s0c2ZVE8y5v9vqetvKgmMKu7YpiWXb4MB9+f7m5KRzf8MhMKCJVXoJysG8RDxbejFA
         AB282uHImzYppKPoQlVjwTRtdS8rkHTzhJkLrfEPqRun3Nzclw5YCJ6HkFsJGHWShLC6
         qpG1n1+GKERtQcAHJWhm2rIznqOgKie9bHVH41BcAjvarorbr+jXfsQIeLddyx4eJPBL
         r1K0hhWVqvnMkRz5/KglSCylYK2VbhLjmO3QLBAeWEbsKJT404n+URIdDHNS/MOpHeT5
         rFIF2hkAJ/7cwQAiBN3s+BzWaNUQAWQwsv6cWT+17aRIiP3O4KrGBwPlzCF2W5u9jNF/
         yNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CrO/3RU8M4nH9jMDntBlAOSvA7YlDjMGyHvPq8QzUzs=;
        b=MKR7GZIqX4V19qtnLNb5URzrYhUmmRc4rxC4PH0moi2iPtHhor0uHU4YoTgQTkt7Gs
         Mydqj3tkVjTOuDymvh/vurCCkKPybexjenVjY9WgLSYsK398WNYBgOm5bsiqQTwNE0mf
         y453KzmJdj2l3insBdTZglmwrE1WR3sHhuXi+omP7ZefHfRVi7KCsDtjLoRoK3DNlF6w
         PBBCJlMMIlycRqNNWGTPj2/Tb7a4p1nRBohIvBjw2rsEMTavKb5UJehUcga7zx79gRHS
         /DMl30FwiUcdxRc1SxOhoji3iopsy8o5tIyoIeViaw4Yh4sRHB1mafs8s9rleQZe3Lfl
         B7Uw==
X-Gm-Message-State: ACgBeo04Zq9RBrRRiXIY8IAZgo0h6MNdvN7L1jnguO3LuVxr8SfnkFMU
        bF2oD5dTfp0REcla6zUCwhzw6/MXu+wdDYHDkFK3Jbh6Ylg=
X-Google-Smtp-Source: AA6agR6bLbjn/TQWap24acgv/E89tnpB1mXoFYikwI6a3vU5NoiTNsEUdSfg1wb1gOon55LZvbwxBGADrSxSv1MTagI=
X-Received: by 2002:adf:e28d:0:b0:21e:4c3b:b446 with SMTP id
 v13-20020adfe28d000000b0021e4c3bb446mr1791886wri.300.1659627154121; Thu, 04
 Aug 2022 08:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220804005213.71990-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220804005213.71990-1-yang.lee@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 4 Aug 2022 08:32:22 -0700
Message-ID: <CAP-5=fX_2sfYOa+4=28-JKfYoTg9wG3i8MRkGvqc3fLE1R=qYQ@mail.gmail.com>
Subject: Re: [PATCH -next] perf stat: Remove duplicated include in builtin-stat.c
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 3, 2022 at 5:52 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> util/topdown.h is included twice in builtin-stat.c,
> remove one of them.
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=1818
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-stat.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 3d22543fc305..e326226656e4 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -71,7 +71,6 @@
>  #include "util/bpf_counter.h"
>  #include "util/iostat.h"
>  #include "util/pmu-hybrid.h"
> - #include "util/topdown.h"
>  #include "asm/bug.h"
>
>  #include <linux/time64.h>
> --
> 2.20.1.7.g153144c
>
