Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE7EC77B73
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Apr 2023 00:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344032AbjD1A2F (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 Apr 2023 20:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343716AbjD1A2D (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 Apr 2023 20:28:03 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FE32D50
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Apr 2023 17:28:02 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f0a2f8216fso868511cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Apr 2023 17:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682641681; x=1685233681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHkXe29J0rH8JTdbNwSRd8QPJhbLRY43ryyovIJGnsM=;
        b=hgdsAO6uMrKNw2z6LsvZgPvbnSKIfLf7zoTS4QxqdYtQEGgQC0dm7qlPV+zlHFkGPY
         skPeyJ99yRfgNsWydkwncjcTZveFiA3JxHgYbCVxCdsQQdBGQFqwC5f0xnbpeOTzAZua
         5gCpwgssgA0XZ40bB6PU+Mpsq0QhoFPav4JX/Ra5Xr19C5kgHcAVFMTlnxs+FlqWMZnH
         jkYbKynFHQ/Bd0c3s07U9bJVfcg/5P4BGWhQBco5+tW2NAs/ZqC7dak9bWMod6+NIQgR
         xmuaJjASiIDNpB4jaD3abUU9wWy0URSq95LWJMbGWoGa7DLOB7rkvUe3xvx/OZRwiZ5/
         /gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682641681; x=1685233681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHkXe29J0rH8JTdbNwSRd8QPJhbLRY43ryyovIJGnsM=;
        b=Kwn6ZguJl6H0XiG+gnF2y6jVBnkxHniTWqfLJ8t9u4dD0hncjrleoA82eVOEU+FsO6
         W53KyVfvY1FFsa8aC7TgWOEq6gvQOsBmKoUmhmqkdlFbVv+HCnYudp18cE1pUHrl0wS8
         7Ftzlr2XWTtgu4fCTJvPagEQ6RYkUEltWkoJgE/xmiD0Mu98oXDDRzR2deuXMkOxTovU
         qNidhC0oJ2rg4MtK+SO7Y90XdNMWYJvwKFR+fqYiZz+z7a5Fygai8sn5i+wORZaCmUaI
         q7Uz6nvR2LWCLXi441HAdrPeUTYiLsBgXnTNyMHvc0eMOSNMB9F81XXfi4J1BhWW4gwI
         OWSA==
X-Gm-Message-State: AC+VfDwMD/qtvH3Qnr++YLWnNp9MppPU3sINCpDiIIEpTFYGdS2Qw3Rc
        DjinnhIpzt3wRzSzK7Qre9ltcU42rUp9tgBlB0id9jxEVmDS/LqZ8EQ=
X-Google-Smtp-Source: ACHHUZ7e+gtNGqUY0Us2JQuPzoAFOc54z7qsE4n4ASaCnlqteYLhb7K23F8WHD1MYYV7YKDMkAeIFxwvlTigifKrgK8=
X-Received: by 2002:ac8:57d3:0:b0:3d6:5f1b:1e7c with SMTP id
 w19-20020ac857d3000000b003d65f1b1e7cmr74403qta.9.1682641681488; Thu, 27 Apr
 2023 17:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230427230502.1526136-1-namhyung@kernel.org>
In-Reply-To: <20230427230502.1526136-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 27 Apr 2023 17:27:50 -0700
Message-ID: <CAP-5=fUYfVDfi_+JGqU=o_TcPRNVboMwZewuhU6q+K3md6nUkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf list: Fix memory leaks in print_tracepoint_events()
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Apr 27, 2023 at 4:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It should free entries (not only the array) filled by scandirat()
> after use.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/print-events.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-event=
s.c
> index d416c5484cd5..0a97912fd894 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -83,11 +83,11 @@ void print_tracepoint_events(const struct print_callb=
acks *print_cb __maybe_unus
>                 if (sys_dirent->d_type !=3D DT_DIR ||
>                     !strcmp(sys_dirent->d_name, ".") ||
>                     !strcmp(sys_dirent->d_name, ".."))
> -                       continue;
> +                       goto next_sys;
>
>                 dir_fd =3D openat(events_fd, sys_dirent->d_name, O_PATH);
>                 if (dir_fd < 0)
> -                       continue;
> +                       goto next_sys;
>
>                 evt_items =3D scandirat(events_fd, sys_dirent->d_name, &e=
vt_namelist, NULL, alphasort);
>                 for (int j =3D 0; j < evt_items; j++) {
> @@ -98,12 +98,12 @@ void print_tracepoint_events(const struct print_callb=
acks *print_cb __maybe_unus
>                         if (evt_dirent->d_type !=3D DT_DIR ||
>                             !strcmp(evt_dirent->d_name, ".") ||
>                             !strcmp(evt_dirent->d_name, ".."))
> -                               continue;
> +                               goto next_evt;
>
>                         snprintf(evt_path, sizeof(evt_path), "%s/id", evt=
_dirent->d_name);
>                         evt_fd =3D openat(dir_fd, evt_path, O_RDONLY);
>                         if (evt_fd < 0)
> -                               continue;
> +                               goto next_evt;
>                         close(evt_fd);
>
>                         snprintf(evt_path, MAXPATHLEN, "%s:%s",
> @@ -119,9 +119,13 @@ void print_tracepoint_events(const struct print_call=
backs *print_cb __maybe_unus
>                                         /*desc=3D*/NULL,
>                                         /*long_desc=3D*/NULL,
>                                         /*encoding_desc=3D*/NULL);
> +next_evt:
> +                       free(evt_namelist[j]);
>                 }
>                 close(dir_fd);
>                 free(evt_namelist);
> +next_sys:
> +               free(sys_namelist[i]);
>         }
>
>         free(sys_namelist);
> --
> 2.40.1.495.gc816e09b53d-goog
>
