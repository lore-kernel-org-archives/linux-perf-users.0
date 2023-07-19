Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6760EC001B0
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 Jul 2023 22:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjGSWb5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 Jul 2023 18:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjGSWb4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Jul 2023 18:31:56 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3052102
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Jul 2023 15:31:53 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-345bc4a438fso28255ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Jul 2023 15:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689805913; x=1692397913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiNsp140u/z6iaEw6m3evD3OsE+pjKNY88u57By7+DM=;
        b=MWnmjKVm7AYL27gaU9Vyk22i9b/I03CZ2m3162rteHKQ0h6PQ+eQJFrnU0gdW5S/sA
         5AYA+Ot2dAes2ZoyaFtHJAF4VQEcJi/hoVusA+yjI0PkWr1tHKUKOFjV4UEWtz1A3A6W
         CrpAB9k8A9M1BD7vJc4NnwGswA1YlfSR43p2qYT7m9VUunZ9wMZ1TmpnRI3KJoSd038Z
         iSYhj4Dw6FFxF+vlId7PlFyh/0kSZisDo0les+2TgUsfW8XuluThywlb8lMddoFHASY8
         IJvJtWZ5guTPqByisvww8eb9QnENwIe2I2lJaf578Sul9C79FIXW7Qzqkf98klTH6NyN
         5eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689805913; x=1692397913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiNsp140u/z6iaEw6m3evD3OsE+pjKNY88u57By7+DM=;
        b=kQ2hcsbiLEe/EZNz6NqZpzTRG9t6MQkDM4VniMjThuEd0KynMEY63Sd7ChFvYadujy
         +yUdvWCBBZ4ziCZchNhdDDLm666jQs53Yr1P+2P3HWVijBmFSBcustLCgX88TWuzdWlR
         ahvuDgdzX3jiHOJnowrtLu+N8vG5cw/ZpTwXLbLXxX1mQckfkDQT8jdBXRzrBqdW0XK6
         ky96UjrUp3dKprZcx3tEHFU6EoMX10ccWPx9XzvnZnxup7HpwXfeAUlt2YjnQ799IfRX
         uUib32Jb7X6nzqCwJjbV96lwM28n6DRZLoxsqaoCIJTJwKTkWhyN6xkC/HQ4+FgdKygU
         VbjA==
X-Gm-Message-State: ABy/qLZfvPI/rP8KTjyKgCnyEWtfwCWWrMoy0Bc5L++cwqtB/mQj3MVl
        lKqq1leo2iZWuuMDEqtUuj5geSmxixN6dLqrOE2RfQ==
X-Google-Smtp-Source: APBJJlH9BzVTG/2sfDIAuUfdaGvxpNlVQtgmXmW6P6EhWaGK5HeN313qhFDPSDiTYWH9S+nNpyiNfOADKTIwVEXEmgw=
X-Received: by 2002:a05:6e02:1ba3:b0:346:9c8:b011 with SMTP id
 n3-20020a056e021ba300b0034609c8b011mr37657ili.19.1689805912815; Wed, 19 Jul
 2023 15:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230719202951.534582-1-acme@kernel.org> <20230719202951.534582-3-acme@kernel.org>
In-Reply-To: <20230719202951.534582-3-acme@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Jul 2023 15:31:41 -0700
Message-ID: <CAP-5=fV3Er=Ek8=iE=bSGbEBmM56_PJffMWot1g_5Bh8B5hO7A@mail.gmail.com>
Subject: Re: [PATCH 2/6] perf thread: Allow tools to register a thread->priv destructor
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 19, 2023 at 1:30=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> So that when thread__delete() runs it can be called and free stuff tools
> stashed into thread->priv, like 'perf trace' does and will use this
> new facility to plug some leaks.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/thread.c | 11 +++++++++++
>  tools/perf/util/thread.h |  2 ++
>  2 files changed, 13 insertions(+)
>
> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index 0b166404c5c365cf..35dd4e716e411da9 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
> @@ -80,6 +80,13 @@ struct thread *thread__new(pid_t pid, pid_t tid)
>         return NULL;
>  }
>
> +static void (*thread__priv_destructor)(void *priv);
> +
> +void thread__set_priv_destructor(void (*destructor)(void *priv))
> +{

Perhaps:
assert(thread__priv_destructor =3D=3D NULL);

To make it clear that there should never be >1 currently.

> +       thread__priv_destructor =3D destructor;
> +}
> +
>  void thread__delete(struct thread *thread)
>  {
>         struct namespaces *namespaces, *tmp_namespaces;
> @@ -112,6 +119,10 @@ void thread__delete(struct thread *thread)
>         exit_rwsem(thread__namespaces_lock(thread));
>         exit_rwsem(thread__comm_lock(thread));
>         thread__free_stitch_list(thread);
> +
> +       if (thread__priv_destructor)
> +               thread__priv_destructor(thread__priv(thread));
> +
>         RC_CHK_FREE(thread);
>  }
>
> diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> index 9068a21ce0fa1b0f..e79225a0ea46b789 100644
> --- a/tools/perf/util/thread.h
> +++ b/tools/perf/util/thread.h
> @@ -71,6 +71,8 @@ struct thread *thread__new(pid_t pid, pid_t tid);
>  int thread__init_maps(struct thread *thread, struct machine *machine);
>  void thread__delete(struct thread *thread);
>
> +void thread__set_priv_destructor(void (*destructor)(void *priv));
> +
>  struct thread *thread__get(struct thread *thread);
>  void thread__put(struct thread *thread);
>
> --
> 2.41.0
>
