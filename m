Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D42D1385
	for <linux-perf-users@vger.kernel.org>; Sat, 30 Sep 2023 06:40:40 +0000 (UTC)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DF11A7;
	Fri, 29 Sep 2023 23:40:39 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-79faf4210b2so412300939f.2;
        Fri, 29 Sep 2023 23:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696056038; x=1696660838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VoHaFU1JQ7O+sUtwCftatF38jqRuulVsKTws+XSug0=;
        b=YmuuGRAsNbvPmv3gesmp0EWCT5sHjyaCbbBW3llA+Bk2aMnhHtvM0MzaPRCC98WfYy
         bOgb46RK3Ae1dbEz5pyEEFxqUsKdy6nClQlG38kqe1og01h41RgjuePxFtYNxVsWZKII
         1787blOMWyG1L57/oB1x9yXETXGK5oEtNzHATXrozMj5DAdY8LJR7H3agacATLB11mY/
         AEOFDBTxcS/dPvetum6ncnLl3xd0d3avXbJ7V0THqGycxT4wNZ/KUPNZh93I49os4a8D
         Qn0IKQn1RI7L/FqcRbbOPRlLNrC5eUjl//YEMnLBX2d9l67bYSyCqeVsQ4MZwjf3Sl85
         DFtg==
X-Gm-Message-State: AOJu0Yx7yO3cIvcY3Vj2e8fYwAkAQOA5KArpIUhex0qOD6FogFwOQqnO
	CRQQquou/KWAor+7nIGWG13rKeUG62octATohk4=
X-Google-Smtp-Source: AGHT+IFkk8IFMSRCpasvMh0U7q0h+3/6K08PJrhKenu4U9+dO+dEyKm3f4e0bVJyA+q9oKBMkzrHtyWAGIyMmeWtPV0=
X-Received: by 2002:a5e:9207:0:b0:79f:b87a:4f00 with SMTP id
 y7-20020a5e9207000000b0079fb87a4f00mr6191738iop.1.1696056038505; Fri, 29 Sep
 2023 23:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928072953.19369-1-adrian.hunter@intel.com>
In-Reply-To: <20230928072953.19369-1-adrian.hunter@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 29 Sep 2023 23:40:27 -0700
Message-ID: <CAM9d7cgihVvEtGN6LbSdtSnh6U9=dOttLAOs28SVzrB_sf3fnQ@mail.gmail.com>
Subject: Re: [PATCH] perf intel-pt: Fix async branch flags
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 12:30=E2=80=AFAM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> Ensure PERF_IP_FLAG_ASYNC is set always for asynchronous branches (i.e.
> interrupts etc).
>
> Fixes: 90e457f7be08 ("perf tools: Add Intel PT support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/intel-pt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index dbf0bc71a63b..f38893e0b036 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -1512,9 +1512,11 @@ static void intel_pt_sample_flags(struct intel_pt_=
queue *ptq)
>         } else if (ptq->state->flags & INTEL_PT_ASYNC) {
>                 if (!ptq->state->to_ip)
>                         ptq->flags =3D PERF_IP_FLAG_BRANCH |
> +                                    PERF_IP_FLAG_ASYNC |
>                                      PERF_IP_FLAG_TRACE_END;
>                 else if (ptq->state->from_nr && !ptq->state->to_nr)
>                         ptq->flags =3D PERF_IP_FLAG_BRANCH | PERF_IP_FLAG=
_CALL |
> +                                    PERF_IP_FLAG_ASYNC |
>                                      PERF_IP_FLAG_VMEXIT;
>                 else
>                         ptq->flags =3D PERF_IP_FLAG_BRANCH | PERF_IP_FLAG=
_CALL |
> --
> 2.34.1
>
>
