Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3808FEB64DD
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jun 2023 15:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjF3PT3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 11:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjF3PTE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jun 2023 11:19:04 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746353C1D
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 08:19:02 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-401f4408955so251171cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 08:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688138341; x=1690730341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7y85+CsbEknGYolZq9ltwi/sLY28N+60rkHxxiN/96I=;
        b=aqlpp13fau6b/AMECgbtGX07mxMGSbx3NyWZWBzftVHNCu3uE+q78Vtq39Xt4+8IZx
         MY60D4oQIZPyEVwjOQPEVaJafMR80yvvUf6UiETAdxuBuqpUkqPHBkVDP3csWAj/nbri
         nwNxjXQl+VNWTqnkjebhwCJFPEQyWD0VTt6b1myZeq8g2FD1p4JjY+5Bt4tfS8XSRo6E
         ycBIFdW6u3BH5D3z/DXNEbhJ8zCDFr+0+SfmyS4xuIdmFLN6WB4v/GgrHsKkR2+S9KAi
         8LbeX1AT3eNYq1uyb1ix+EunI7NpPUUNaU5r5hr+QIKw52FHwnkuw0ELBgiqqAFvpIxg
         rWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688138341; x=1690730341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7y85+CsbEknGYolZq9ltwi/sLY28N+60rkHxxiN/96I=;
        b=EIOWzcX2qWtMYBtaJPOZY7v4yWO0QYWuLU/egJ7ndpdAsREInvWTVGNMHLPxIRRKFw
         DAvQ5lD6O/45Y5G6qcMgbJ4UfX5MkiPln9l8wSe7uPg7tHTQ78kFRkduZdRIbzBxyyk3
         A1paU4EFMvGp855ArGOcQi4/eGoKmjSkB/SSeda9BF1H+LZnd4gFqrTt33CrGIk+af0y
         rP6G4oGuwf5MktF86HtpXcb6d4ckdFKz3PCtTT1XEqv8FsC1eQ/LAERtkHhfqz8LxHrz
         1gFPofLIRIRsBUPUzXTNSJq8krxOM7pzJl6ymalkrNof5iTgHAAKoTMWvFM2r8uOn0gG
         vChw==
X-Gm-Message-State: AC+VfDxiSNTEEkPBtZr1z8F9PH0CA1Bc9J2IllTSjw8h8lIGAjUcqs4e
        ioYSzIcl0g3d4hy3gJFYpFhCa/CGQE2XnnIjHwqOhw==
X-Google-Smtp-Source: ACHHUZ7GoyWKFwgMIOb5nMpnMqBXPwzzWjgKhNo/zhlInr9v0vOCULYLICY2l91NepNXZAFa4macgqfs35shWJDihQ8=
X-Received: by 2002:a05:622a:110f:b0:3ef:302c:319e with SMTP id
 e15-20020a05622a110f00b003ef302c319emr832038qty.8.1688138340945; Fri, 30 Jun
 2023 08:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230630080029.15614-1-colin.i.king@gmail.com>
In-Reply-To: <20230630080029.15614-1-colin.i.king@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Jun 2023 08:18:49 -0700
Message-ID: <CAP-5=fUX_ktsmrrVGr9kwa3-C_4=yobTFgm5L+TpFNt8UZMZGg@mail.gmail.com>
Subject: Re: [PATCH][next] perf/benchmark: Fix spelling mistake "synchronious"
 -> "synchronous"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 30, 2023 at 1:00=E2=80=AFAM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There is a spelling mistake in an option description. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/bench/sched-seccomp-notify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/bench/sched-seccomp-notify.c b/tools/perf/bench/s=
ched-seccomp-notify.c
> index eac4ef60090f..2e8205c61141 100644
> --- a/tools/perf/bench/sched-seccomp-notify.c
> +++ b/tools/perf/bench/sched-seccomp-notify.c
> @@ -33,7 +33,7 @@ static bool sync_mode;
>  static const struct option options[] =3D {
>         OPT_U64('l', "loop",    &loops,         "Specify number of loops"=
),
>         OPT_BOOLEAN('s', "sync-mode", &sync_mode,
> -                   "Enable the synchronious mode for seccomp notificatio=
ns"),
> +                   "Enable the synchronous mode for seccomp notification=
s"),
>         OPT_END()
>  };
>
> --
> 2.39.2
>
