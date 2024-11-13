Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1B11FE0F8
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731517044; cv=none; b=e0NZ1wNIDe3gmdEBZNEzQdYlFLK6fnLpt9mZ7ltwGxqB8JjPjzKhXhesPTrDgJvNJMag0maf0dmpe61LhhWSPGtFs9QaUnZ+lNGXL8bBE+fLH7MQ3xYuve/eu4Q8Fc/hnURZj1MwLJEfHFcRH0DyYp3rvKJPyx8tfIbzOf/hx1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731517044; c=relaxed/simple;
	bh=roY9kyECMD+3vngFI1/UwaeZzLwM+IHZFvROogGuYnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bh9N3bf9Z1qq7MOFEElv5GwJPfc6XPKGKVwS1KjOpZafuLi9QxhIiS4x170hxfp4BTMe4nCMtc38meCFgUV2+vtAjjq/remzGYEe/ueS6f9mysCiKGkjamn/wRWdB7knKKrIkB+uPeLYywkGGEwcC3vUBQcIDefwZYN129DO/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d7Cf48B2; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d7Cf48B2"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a71d034bd7so44855ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 08:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731517040; x=1732121840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8KxvDaLBUqx0245RDy11VfTWydZkirOEBvvWNT6X60=;
        b=d7Cf48B2NTbcderNfV+e6eWg0T77gjo/mCqY9WQZ0evlU89Q+02qrSrs/jSDIg3TKJ
         npTjy0IfSqDTaePDLS8BuTz/iC2svv0dGYwjlYNk/T0WNAI6p1ep7zE6mo+pK6HWavaa
         6SdzMMoOKMIJokTeFVc59vtC6eRiQSTtpo7w6TnBp1mVg/QbDbdTNS9sVeh7uhWBuOOH
         nardyFybKoxLBVZa01C1Yzr6aX7pz/qtfVpBRf6VY1Pj8/W9Xs+NgKYbfU0a2UZJ+T7M
         ycAR/LSChWC98KJ0h6d2WQOeH5A6VXqdcp9eHPoPwDmFrj8U6udDijB4TE7w5Xiun+2a
         12PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731517040; x=1732121840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8KxvDaLBUqx0245RDy11VfTWydZkirOEBvvWNT6X60=;
        b=hwWb/pRKiTPqfOgnl9WfaS6YgVj03SPEGZ0xME6BpO3qixL6aEFIyggAfILGN8lWEx
         73xT0Q3YTAaLcxYRT83IIkYQyFJDLO4bkcoy+CJC9wS+Ci784d3ErzqudSEK1afA7I/q
         8h2BNoSPGnketZGuOBrsHjMe/gGa96MdjVv8Mk5O0Fmc6kll86j+Mhl7Y7JkLyb3VETb
         1SRWy07n6qJQIJ2TU9N1nYnv1eNfQgAFSDJqZ5zQBO/7eNH/tzvUy0EmlgxHdDxRXB4I
         IfRoeHqvZxg7xomFdMpa3Ai8Gp95TICbcGgY9Nhbes/fHl73nalMbs0hshsuxXnyWG/S
         dbyg==
X-Forwarded-Encrypted: i=1; AJvYcCWAWQvLB+H+eyjzX925dq+UkKI+ieckUnLhb4zNfNWJ22vZ1rfs4PvIWfjhQcRHzZiJx5j7IbtUHg4BxjlJn4Ty@vger.kernel.org
X-Gm-Message-State: AOJu0YxNVzOPwwEU2NxKfubhlBDsXmcam+ttSfjtuau5iTAvSF1bnGq+
	bpBwv5RXwz/ynq1b13KLXATNW1EO3ob68sZAG1VWoCdbMTNkMc+VVv58uPxaICAMdFVNIhqAzDC
	x/IDHGxImHNLLgJlB/X4DYzub2lHFMEsEn3/hiA7mIg0Bb4iBm8SJ
X-Gm-Gg: ASbGncujzJTj97cRwaevHb6PRjrpy3MfWt8tRo/xBL2KUyMQ1NcogA+pHPahpP8ZK16
	Rv1nYGuNF/EArY7fVwUDXKt098lRHLCvFTBF9HPgne8omLC/JHWZjjocl+CaY/A==
X-Google-Smtp-Source: AGHT+IEYUtjqBOfhYmwUmXk7ZVagsLqJaLpw1VzmKEfuA/uLAvghKlUKEthZAqpx66oTNTtjSeM5RraRZ8GtLAZlBSM=
X-Received: by 2002:a05:6e02:1567:b0:39b:b1f:5be1 with SMTP id
 e9e14a558f8ab-3a7171c3900mr3763585ab.1.1731517039934; Wed, 13 Nov 2024
 08:57:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108143424.819126-1-yeoreum.yun@arm.com> <c03b1604-cc41-4746-be3a-fc326152d556@linaro.org>
In-Reply-To: <c03b1604-cc41-4746-be3a-fc326152d556@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 Nov 2024 08:57:08 -0800
Message-ID: <CAP-5=fUSE9Pt+=T73wTUn+y_7iMZ6=bNNNgP0z_a1ty_KwV1Lw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf/util: initialize is_test value in expr__ctx_new()
To: James Clark <james.clark@linaro.org>
Cc: Levi Yun <yeoreum.yun@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nd@arm.com, namhyung@kernel.org, 
	mark.rutland@arm.com, james.clark2@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 8:13=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 08/11/2024 2:34 pm, Levi Yun wrote:
> > when expr_parse_ctx is allocated by expr_ctx_new(),
> > expr_scanner_ctx->is_test isn't initialize, so it has garbage value.
> > this can affects the result of expr__parse() return when it parses
> > non-exist event literal according to garbage value.
> >
> > use calloc instead of malloc in expr_ctx_new() to fix this.
> >
> > Fixes: 3340a08354ac ("perf pmu-events: Fix testing with JEVENTS_ARCH=3D=
all")
> > Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
> > ---
> >   tools/perf/util/expr.c | 5 +----
> >   1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > index 5e3732bc2fa5..bc119501f091 100644
> > --- a/tools/perf/util/expr.c
> > +++ b/tools/perf/util/expr.c
> > @@ -285,7 +285,7 @@ struct expr_parse_ctx *expr__ctx_new(void)
> >   {
> >       struct expr_parse_ctx *ctx;
> >
> > -     ctx =3D malloc(sizeof(struct expr_parse_ctx));
> > +     ctx =3D calloc(1, sizeof(struct expr_parse_ctx));
> >       if (!ctx)
> >               return NULL;
> >
> > @@ -294,9 +294,6 @@ struct expr_parse_ctx *expr__ctx_new(void)
> >               free(ctx);
> >               return NULL;
> >       }
> > -     ctx->sctx.user_requested_cpu_list =3D NULL;
> > -     ctx->sctx.runtime =3D 0;
> > -     ctx->sctx.system_wide =3D false;
> >
> >       return ctx;
> >   }
> > --
> > LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> >
> >
>
> Reviewed-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
