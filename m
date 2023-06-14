Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25730EB64D8
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jun 2023 17:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbjFNRhB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jun 2023 13:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236958AbjFNRhA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jun 2023 13:37:00 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1570119
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jun 2023 10:36:59 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f9d619103dso13451cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jun 2023 10:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686764219; x=1689356219;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EljyySPJN/DBQ8Xy5B6EfkCPm3Xjn/z4XXSJw0Skw10=;
        b=B+iGVkxNGASP+ybziEfosMBaGFc9ZUFAwWx20Q2Kxgjz3gVBkuddF9lJnNQDDQu5/Z
         ClTzTWiftydz2soapXU2EiIrtsvzmxpbUqsvJrSn2Ya/g/4Nmjaj6BzVIgy1hpzyYW9m
         5JRGYyJq3PZ0cj7188D5pK4w01Dsw5xZUqDYMDG4O3Zl3ZttBbUyP8jCUq0eRfO7iZ0R
         bK0U2HTi4WYXh11cc2hX5VX5p1AnFMb6Ycx1vINPTmJOOrjPcEimuj1Yzb+GCB/+INjg
         5DeVjSJUw2sEnEFUQT83vtXDVn7LOWckuw/CjRE1ParpFE29dWYLKpex58C3eYsBBiu4
         z4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686764219; x=1689356219;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EljyySPJN/DBQ8Xy5B6EfkCPm3Xjn/z4XXSJw0Skw10=;
        b=N4NEMpEGu8wiGEdILakRs81rql9ljlIbfIk/9+/jyyV43w3XQp+iRI+zA82bDgFPOL
         vveN9/XTw/sWvg1sH3qYUA74w2Ydk6g+rjObbBxzYW1+DNKwS7EhkUtAP84Db6iVDAKN
         RMgmYRxJfYvhtXb/xBsBMYTVfZtalmLV9QTYnjtKx7YOBLQmzdSQgyjBsWvAHgNpLrr7
         uXSIXM2SRJZRYbd0FUksTYqosr1IXK89auljl5kmOmfB0SR6VCByIIP8EqQ1qHC0h6Mq
         DwMHQFdB6zAlMng87qhEBtT2/8BP5NOsJjLHGiGXyY1L84nr6Ei3G0PiVAPmLksahhyc
         SibA==
X-Gm-Message-State: AC+VfDy2/nf241Z5cvbo//+acta66VD5T0uZgr+ZzBN+sprmDMV1UK7P
        3wsAqYi5wEp5WYrET5h+WyUtn4+LP2vDFctz/fck0g==
X-Google-Smtp-Source: ACHHUZ7wE2k19SrUhc7gV+jBBssbQRnmtml/5ZhqHEk87Z3CiBYgVCDQvZ0Mu3CifQp0jQZvSGP9xlq91FFqzRtbKmU=
X-Received: by 2002:ac8:5b01:0:b0:3ef:2f55:2204 with SMTP id
 m1-20020ac85b01000000b003ef2f552204mr8923qtw.6.1686764218769; Wed, 14 Jun
 2023 10:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230608061812.3715566-1-irogers@google.com>
In-Reply-To: <20230608061812.3715566-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Jun 2023 10:36:47 -0700
Message-ID: <CAP-5=fX1X=A7gkExsV917EntTdfgytNA8LBvHwTCsXfq1zHixw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] tools api: Add simple timeout to io read
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 7, 2023 at 11:20=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> In situations like reading from a pipe it can be useful to have a
> timeout so that the caller doesn't block indefinitely. Implement a
> simple one based on poll.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

There is overlap in what these patches aim to fix with the 2 submitted
patches making addr2line more robust:
https://lore.kernel.org/all/20230613034817.1356114-2-irogers@google.com/

I think it could be pragmatic to take both of them. Be robust but
timeout if addr2line doesn't respond for 1s. What do you think?

Thanks,
Ian

> ---
>  tools/lib/api/io.h | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> index d5e8cf0dada0..9fc429d2852d 100644
> --- a/tools/lib/api/io.h
> +++ b/tools/lib/api/io.h
> @@ -8,6 +8,7 @@
>  #define __API_IO__
>
>  #include <errno.h>
> +#include <poll.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> @@ -23,6 +24,8 @@ struct io {
>         char *end;
>         /* Currently accessed data pointer. */
>         char *data;
> +       /* Read timeout, 0 implies no timeout. */
> +       int timeout_ms;
>         /* Set true on when the end of file on read error. */
>         bool eof;
>  };
> @@ -35,6 +38,7 @@ static inline void io__init(struct io *io, int fd,
>         io->buf =3D buf;
>         io->end =3D buf;
>         io->data =3D buf;
> +       io->timeout_ms =3D 0;
>         io->eof =3D false;
>  }
>
> @@ -47,7 +51,29 @@ static inline int io__get_char(struct io *io)
>                 return -1;
>
>         if (ptr =3D=3D io->end) {
> -               ssize_t n =3D read(io->fd, io->buf, io->buf_len);
> +               ssize_t n;
> +
> +               if (io->timeout_ms !=3D 0) {
> +                       struct pollfd pfds[] =3D {
> +                               {
> +                                       .fd =3D io->fd,
> +                                       .events =3D POLLIN,
> +                               },
> +                       };
> +
> +                       n =3D poll(pfds, 1, io->timeout_ms);
> +                       if (n =3D=3D 0)
> +                               errno =3D ETIMEDOUT;
> +                       if (n > 0 && !(pfds[0].revents & POLLIN)) {
> +                               errno =3D EIO;
> +                               n =3D -1;
> +                       }
> +                       if (n <=3D 0) {
> +                               io->eof =3D true;
> +                               return -1;
> +                       }
> +               }
> +               n =3D read(io->fd, io->buf, io->buf_len);
>
>                 if (n <=3D 0) {
>                         io->eof =3D true;
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>
