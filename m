Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE86C83F2C
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Sep 2023 03:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243089AbjIDDgv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 3 Sep 2023 23:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjIDDgv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 3 Sep 2023 23:36:51 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBD2C5
        for <linux-perf-users@vger.kernel.org>; Sun,  3 Sep 2023 20:36:47 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-414c54b2551so61601cf.1
        for <linux-perf-users@vger.kernel.org>; Sun, 03 Sep 2023 20:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693798606; x=1694403406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9nH/6/TTQDAG7adjT3U+XyBZqgj5QsLIPK6YrJMS58=;
        b=eZqGekTZ1wIkHhJwNVnu6XBuZHTErox9yw2UUIbLgI9pYyhR8/0erjwemt4A0xdtxh
         xrCd4GdNyZDRfYbEtXad2muj6Vxg44s2YQ5APas8bPtgD4QWdn3Zs5bxP99rXQ7qFtlU
         09z6FELbkEDpGMGl9IRPK5rFkzfqffusfM4BFYiNXb4/IddXM9XrvDs9A5CMMsuJnLIV
         mXiA6HYgezQe6EEbumRqoFLClsS2Xoq4Fvw8E7SJyZfXFU1tC33LI8tB/7XeLS2mhda9
         GWEgZAaFIy9g1NeNXKJ4HBcUQBXY1pnGvXAecsNiaTSHHfZZguePHOjwxR3eB7TrrQR0
         POJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693798606; x=1694403406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9nH/6/TTQDAG7adjT3U+XyBZqgj5QsLIPK6YrJMS58=;
        b=K4iZhzq6NyNz5e3OHRBN4WkVUJiAMOo/ZmyC/HpfXvFxXrHWodHvgfqmKRhA7XhtrO
         29Cn7N6BaD6+zyf9cdG6107cWQVbLZZc4rrNRHwScACwApQ1Vf5+uES0fbvZS/qQ8AGg
         O628x51c9nDGLun7myw1ZShXztzCLKREJ6rYeHsyckZZCxEIK4YXgOw+NR5FydV4YY1M
         aTUVDuhXujrqme61ZLLtRnyTREFv1cJUFyAR3v+/XR6hM3J0dGbBMMWvzdCIOYtlCRi3
         XusbVMWZHflqzkRxI+lrgaXIJXhEKUv8LwONM2fqzEii2hCe6fx+ixdNsYYBCd+hGYHK
         wayA==
X-Gm-Message-State: AOJu0YyYmwOCSqNcC9VTog57L7YkD06yQLx3baduXPAH34aku3Y5rJJ6
        eZAOFqbmExhlqnbusj1abjKYVPiynZkGiyLRcGXVY8zJhUWIAbjGGymxFw==
X-Google-Smtp-Source: AGHT+IGjcPytkF6/gVWXpaY+XEbXMXdofr5GrFxRTqVaB/j7HTAZGRZPwCmNM6RMt6lkZDrNnux642mhwRCZiN8eCXw=
X-Received: by 2002:ac8:5bc5:0:b0:3ef:5f97:258f with SMTP id
 b5-20020ac85bc5000000b003ef5f97258fmr233379qtb.16.1693798606484; Sun, 03 Sep
 2023 20:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230901133716.677499-1-james.clark@arm.com>
In-Reply-To: <20230901133716.677499-1-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 3 Sep 2023 20:36:35 -0700
Message-ID: <CAP-5=fUE2jVDXCMszLDTmrhJ67mXi68yt1581i9R42G80p=QsA@mail.gmail.com>
Subject: Re: [PATCH] perf cs-etm: Bump minimum OpenCSD version to ensure a
 bugfix is present
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Sep 1, 2023 at 6:37=E2=80=AFAM James Clark <james.clark@arm.com> wr=
ote:
>
> Since commit d927ef5004ef ("perf cs-etm: Add exception level consistency
> check"), the exception that was added to Perf will be triggered unless
> the following bugfix from OpenCSD is present:
>
>  - _Version 1.2.1_:
>   - __Bugfix__:
>     ETM4x / ETE - output of context elements to client can in some
>     circumstances be delayed until after subsequent atoms have been
>     processed leading to incorrect memory decode access via the client
>     callbacks. Fixed to flush context elements immediately they are
>     committed.
>
> Rather than remove the assert and silently fail, just increase the
> minimum version requirement to avoid hard to debug issues and
> regressions.
>
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/build/feature/test-libopencsd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/=
test-libopencsd.c
> index eb6303ff446e..4cfcef9da3e4 100644
> --- a/tools/build/feature/test-libopencsd.c
> +++ b/tools/build/feature/test-libopencsd.c
> @@ -4,9 +4,9 @@
>  /*
>   * Check OpenCSD library version is sufficient to provide required featu=
res
>   */
> -#define OCSD_MIN_VER ((1 << 16) | (1 << 8) | (1))
> +#define OCSD_MIN_VER ((1 << 16) | (2 << 8) | (1))
>  #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
> -#error "OpenCSD >=3D 1.1.1 is required"
> +#error "OpenCSD >=3D 1.2.1 is required"
>  #endif
>
>  int main(void)
> --
> 2.34.1
>
