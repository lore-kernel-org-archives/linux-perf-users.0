Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93DCC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Mar 2022 03:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355447AbiCQDL2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Mar 2022 23:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346961AbiCQDL1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Mar 2022 23:11:27 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254B821257
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Mar 2022 20:10:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d7so5523303wrb.7
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Mar 2022 20:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DK6P0vsqvqxWi0Zvgtd3pmUt6OtvktIwMYnSOV1EMeo=;
        b=bGaZY09cU0XgGRfnDAVp2vOIGStTcryrqsMhU1TyKAgsYNcozH0dDGXzJQkE3P8/V1
         fqSgsFkHSHaAqaD8VkhjnIeVx3Hnmm8bJNBvq8RHnhPL5kobiViDWhMABBPLyzGjIwsa
         votXUrc/9/zhJeW+eXmCxVs0NqRhONq4iIDuWTqwxcwyReIXtd6TNxaUqNqdB6r9fhaU
         Azp6hPioSDEsJgu0bwcANwsBprV4XCwyGaFK0xILbojy+qsn/zKyk1KWGDY3YYRgx4sV
         276gCshT/PeMu9M3DmUbmobKrjOWsbLTXIH17NHmEk/snwPGckve5TMP+j7MF7qfS+8Q
         9zkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DK6P0vsqvqxWi0Zvgtd3pmUt6OtvktIwMYnSOV1EMeo=;
        b=zW5sKOdW0lFc1snUG0fMj111g5opqeElitm+czhmszs6jNgqQqJzkNiRCnjT8KOPxZ
         XWD0aIubI6kwQyMqY+xBGOIIJIxG+HoyTbR5k201WNSuSii4T4YgCQQrRmWBzFzvo8G0
         rUA96u2O9+6jAuEX41jRdBa7omPZeIUwLeVhoVFOkzhxwm4XcEXls3dI8ZkDS4Qpi04B
         gBArHDmep7EyTVyCQ25H7+HK1fqww8kfQAJsGekm35CIQGGbqeFDpXy4hvPv7/++W2tH
         uam2kS6ig1GetE8rfuWwh9yLbWv3PCrYLOvstB8SVBGUageaZFvcppUA+MwOhlil6PbR
         Ut5Q==
X-Gm-Message-State: AOAM5328Fev0IwI3qPVk5YDTbK7LkFRGurv3e/xXdPwDZBb0OZGQQdZ/
        VMNwnZOas5+JXDm/3mHAymkGBNKZbcwt9LvT0U1QOw==
X-Google-Smtp-Source: ABdhPJwc4MP3hf5ky2/ukJUnLS79rR1XwMXn+/aci0lvkPWmm2yQmgLAbWf5gNVX+WklAX31SZt7g+RxSvS2R0fRPos=
X-Received: by 2002:a5d:6c68:0:b0:203:691f:b95b with SMTP id
 r8-20020a5d6c68000000b00203691fb95bmr2127564wrz.375.1647486610606; Wed, 16
 Mar 2022 20:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220316232212.52820-1-colin.i.king@gmail.com>
In-Reply-To: <20220316232212.52820-1-colin.i.king@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 16 Mar 2022 20:09:58 -0700
Message-ID: <CAP-5=fXbGWec6RVoEhhR4YnCSBOA5iU--_fOA6_+=375wm3SQA@mail.gmail.com>
Subject: Re: [PATCH] perf header: Fix spelling mistake "could't" -> "couldn't"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Mar 16, 2022 at 4:22 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There is a spelling mistake in a pr_debug2 message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/header.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 6da12e522edc..4a44a0740f43 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1335,7 +1335,7 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
>
>         dir = opendir(path);
>         if (!dir) {
> -               pr_debug2("%s: could't read %s, does this arch have topology information?\n",
> +               pr_debug2("%s: couldn't read %s, does this arch have topology information?\n",
>                           __func__, path);
>                 return -1;
>         }
> --
> 2.35.1
>
