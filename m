Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D43FC4338F
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Aug 2021 16:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE024610A5
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Aug 2021 16:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhHSQ3D (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Aug 2021 12:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhHSQ3C (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Aug 2021 12:29:02 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4098BC061575;
        Thu, 19 Aug 2021 09:28:26 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x27so14188036lfu.5;
        Thu, 19 Aug 2021 09:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6L92tsHz4xRaI2n9RSKW5nUbF1dUMupAAvGnM5bJez0=;
        b=G9NZWF2O5KMOjAPkundHYoTTUpxmwcbVdtpmGlcVvobfRHAPc4M3R2HYmSkLZzUSbw
         mK7VU2XXwNDLOXnWqvghjtpBYjCEiMtI2rREeK1GS9xGcmB6xkCBfz6Wz8j9Kusp5pFE
         MgvsiAsAJm9TbBEXnSh+lL+oZTPvs56IcFLkNZS4H4BK9Qj3RtG2MaYkGCURFXxuAUNR
         sUjv2JCHNxVCuum2SYJOwqIcr1tN6duX3xVuKen8dN9aSkHm4RVEGDfxxhCBJFImdDqA
         Pl1rUvk51RCYHyI/KwsQL0MducqVyiaVCzrLEwPQAHnvnGACYnk+l91+fsCOzxwiGqER
         LaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6L92tsHz4xRaI2n9RSKW5nUbF1dUMupAAvGnM5bJez0=;
        b=UJDrzV5gHe8e4lGFwrXje3cWXBQbV6ovmPg5cEl9Z1fYYqE78To+3pjz5RZAiJJbzo
         p/6cbfP4PHVg6MenAQqW9yyN5Mvf9ZSG3mzZ/mQ3mZhiN4OK+4hNLepShS0VhB+a49Jj
         02/pbYehfooN2uYZaAkXhjlRla8N8rpZO/fZLgnd5AVZZppQnXtCZH0cmid6UEEgv4ei
         QHxw/r9PAp2biq4GlXdf0/RCjTzFAg2RsaTCJFaKVn5coOBYQbac9+0gt48u5Py+P0Ew
         Ddvn3GQxT72TJMXVDd15PtcIA8pEbNfpfvAumXPEQLEW3yP/B9jp9KMawkqTQX535ga3
         Q/yA==
X-Gm-Message-State: AOAM530RTgc2ky5gR5swdeW/6Snzbc+fYLHsqauDZgLEgndR+0i6yEVw
        mtsTwPMLIiAoOlYa/3sFBV/MGYJCUdKWXKzl0Og=
X-Google-Smtp-Source: ABdhPJzTVwT3bdMn9DU/VQmwKY9YTGZXOl9jH7MDoJMTCzOkGZqSFL5UwH5Y/D2qcVGLySyhp9kr9pxow6DcLbOG7J0=
X-Received: by 2002:a05:6512:158b:: with SMTP id bp11mr3210927lfb.300.1629390504645;
 Thu, 19 Aug 2021 09:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <YRukaQbrgDWhiwGr@localhost.localdomain>
In-Reply-To: <YRukaQbrgDWhiwGr@localhost.localdomain>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Thu, 19 Aug 2021 09:28:13 -0700
Message-ID: <CAM9d7chOtKDTmiZz7EUDX76BMWRzWJATmJZLcTiLeu5k_qRg0g@mail.gmail.com>
Subject: Re: [PATCH] perf, android: fixup get_current_dir_name() compilation
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

On Tue, Aug 17, 2021 at 4:59 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> strdup() prototype doesn't live in stdlib.h .
>
> Add limits.h for PATH_MAX definition as well.
>
> Signed-off-by: Alexey Dobriyan (SK hynix) <adobriyan@gmail.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>
>  tools/perf/util/get_current_dir_name.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> --- a/tools/perf/util/get_current_dir_name.c
> +++ b/tools/perf/util/get_current_dir_name.c
> @@ -3,8 +3,9 @@
>  //
>  #ifndef HAVE_GET_CURRENT_DIR_NAME
>  #include "get_current_dir_name.h"
> +#include <limits.h>
> +#include <string.h>
>  #include <unistd.h>
> -#include <stdlib.h>
>
>  /* Android's 'bionic' library, for one, doesn't have this */
>
