Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27CF9CA5C
	for <linux-perf-users@vger.kernel.org>; Sun, 24 Sep 2023 18:11:07 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFC4100
	for <linux-perf-users@vger.kernel.org>; Sun, 24 Sep 2023 11:11:05 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-414ba610766so322921cf.0
        for <linux-perf-users@vger.kernel.org>; Sun, 24 Sep 2023 11:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695579065; x=1696183865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cG//7W4GvFKB3RUZel/s/r0KoIAXjuYDKz7+aYl6dbw=;
        b=gxizrCvWUbszQ73Mnb2OBfYODjAjIsfgzglB6kYN3qD2u5Ps92tS5uuIqxAHdZEFLa
         mtbQBle3HrWd8uPDwTmhxIa1eb0VXPgPFJXVyHUb70rTJlzF6C49TS7bPGRYFrb3oSMy
         MuU9AgUz0jbIqt1yVKP06FrRUkeQbQ/sHFeIi857hF2unztlSunREfM8u4yMM3uzN8Nd
         SdFY4d7iiaItdpXkcj6Ki4P4jLHt4YMc2wSwmDGd2SYUn0VHGSG58oVddxOoD9XSEtm0
         xBZSa4yTHkRSv2hpYWzvmoNek8QCuNoxeue0zK3cmb0EPqLJ6m/Nz/B+siPKHHlOokw/
         45mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695579065; x=1696183865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cG//7W4GvFKB3RUZel/s/r0KoIAXjuYDKz7+aYl6dbw=;
        b=DFv1nFplCy6NBPK2NbdUJPD7im4SwPwYwIlIDTK9eKEdDlzrXbSaavha0qdvYzv+jG
         E+N9CX0wYB8aEAlzzk0S5t7UEahBOEBXfeibf6D1TVo4xr3JmqcsTNsCC30rH1XlZ0HW
         pbL9Tl6MOAd88c0Ve2YxZUH98X1kDvUlT1XBg6Vf1Uda4UEQDpbvKXit6mz00iDm0orW
         +WlO+DnD/WaKJW8Y9KdZnP5uqFRwJfS635k1neCJ/ylkCFy/VJY9JfdQ4iYoRoUAbple
         Suh1IoqOuWh4LdFUBIuYnmjXgtJWXz4c6SshSNgb0PIsGALfHEQZtLc7hLEcI9ycl2o6
         4rDQ==
X-Gm-Message-State: AOJu0YxsgXk99GhzMZmQHeCdkqjp9K3/8OrIHbADjGqJWdezvqZkxHaI
	yq1FUFHg3n3o7K2dIR15/xWrmEE4KuYS/v4g+OYlIg==
X-Google-Smtp-Source: AGHT+IE2x2zMKhx6VgB5uMiZT3B7zLGQ2fylz9BV1K3bxporY8GHHsHjBCelDLvCj8RqqMtNubif3frEMB55fZcySMs=
X-Received: by 2002:a05:622a:1050:b0:40d:eb06:d3cc with SMTP id
 f16-20020a05622a105000b0040deb06d3ccmr300808qte.7.1695579064870; Sun, 24 Sep
 2023 11:11:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230923093037.961232-1-yangjihong1@huawei.com> <20230923093037.961232-2-yangjihong1@huawei.com>
In-Reply-To: <20230923093037.961232-2-yangjihong1@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 24 Sep 2023 11:10:52 -0700
Message-ID: <CAP-5=fWpZk-sXjy5D28Os6YgDeMiu9UiVRzqZM9RHMs8YFj-3Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf bench messaging: Fix coding style issues for sched-messaging
To: Yang Jihong <yangjihong1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	namhyung@kernel.org, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 23, 2023 at 2:32=E2=80=AFAM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> Fixed several code style issues in sched-messaging:
> 1. Use one space around "-" and "+" operators.
> 2. When a long line is broken, the operator is at the end of the line.
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Series:
Reviewed-by: Ian Rogers <irogers@google.com>
I wonder with the SIGTERM improvements whether there should be
improvements to tools/lib/subcmd and then we use that.

Thanks,
Ian

> ---
>  tools/perf/bench/sched-messaging.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-=
messaging.c
> index fa1f8f998814..6a33118c8f9b 100644
> --- a/tools/perf/bench/sched-messaging.c
> +++ b/tools/perf/bench/sched-messaging.c
> @@ -98,7 +98,7 @@ static void *sender(struct sender_context *ctx)
>
>  again:
>                         ret =3D write(ctx->out_fds[j], data + done,
> -                                   sizeof(data)-done);
> +                                   sizeof(data) - done);
>                         if (ret < 0)
>                                 err(EXIT_FAILURE, "SENDER: write");
>                         done +=3D ret;
> @@ -201,8 +201,8 @@ static unsigned int group(pthread_t *pth,
>                 int wakefd)
>  {
>         unsigned int i;
> -       struct sender_context *snd_ctx =3D malloc(sizeof(struct sender_co=
ntext)
> -                       + num_fds * sizeof(int));
> +       struct sender_context *snd_ctx =3D malloc(sizeof(struct sender_co=
ntext) +
> +                                               num_fds * sizeof(int));
>
>         if (!snd_ctx)
>                 err(EXIT_FAILURE, "malloc()");
> @@ -239,7 +239,7 @@ static unsigned int group(pthread_t *pth,
>                 snd_ctx->wakefd =3D wakefd;
>                 snd_ctx->num_fds =3D num_fds;
>
> -               pth[num_fds+i] =3D create_worker(snd_ctx, (void *)sender)=
;
> +               pth[num_fds + i] =3D create_worker(snd_ctx, (void *)sende=
r);
>         }
>
>         /* Close the fds we have left */
> @@ -288,7 +288,7 @@ int bench_sched_messaging(int argc, const char **argv=
)
>
>         total_children =3D 0;
>         for (i =3D 0; i < num_groups; i++)
> -               total_children +=3D group(pth_tab+total_children, num_fds=
,
> +               total_children +=3D group(pth_tab + total_children, num_f=
ds,
>                                         readyfds[1], wakefds[0]);
>
>         /* Wait for everyone to be ready */
> --
> 2.34.1
>
