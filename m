Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F64243951
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2025 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765917569; cv=pass; b=VBJO3h43Te5AeDHBxt7AyfB1yxxAnd0ePJedEFhzmn/5qybmTWujQqjSG8VgJLyFkO+FMDtgy0vCD0+ERzpL8dWmbT88JZY/fmUR51BekQsPa50Qphw/jH64fympU5iCzD1eD7UJ0q5llSIKKLNNFNstGyx/MThythFrO2L5vkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765917569; c=relaxed/simple;
	bh=yJEPhspzQIfLUIdNRdsJz7MWs4Mpem8JwCSQx4xtxWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8BjuuvstphKqONo4V/PvXswI4Ken7NsmJ2sKlh98dmJM/i180Cy7QwAo3qR86ni+xSPslY16YG2S/iEvqHBjNV6NaCklm0cGKlCo9skZF1smxrd4reHGw+w75DydinQEpHbywIPIrye2C9x1SP36ABUE7DTwwmTjvXAfRhvS0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2av69Szn; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2av69Szn"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29e0753e5d8so7225ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2025 12:39:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765917567; cv=none;
        d=google.com; s=arc-20240605;
        b=CH6W3wKqxS7sBwjGSYoLHmJhgkp08ZiN2c1WZ7rpxFZXXUpLmUQSUPRdrvS38Y6CG5
         61GzWOyIl55iaC9k0ovl3gD6PSnP6hNtEqbd8IKbl+Mu6omqqLU3muz8XYI5MKF7XEVj
         /+1HVgzYWUBZUE+abeLiuUaoSDQFswUX9vP4sdxEvIGi9j7lTYgXz0iJavdAfX8I+0G6
         iEtN+Nf/lAvGU8ZvG732hHSsNjNoBUUcFbOQ/gQh0dMzuWBM84aSmXZX/rSR/3R6vo9w
         aVEerBDJfD2BaNpNP8NiBn31kyFlDkORCauLPfSCUYQ8PvrXhwOWwP0VmrRZRg/ucHEP
         L5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ukuk6hNM0rhIIJoAwXdQKqwGGG0/U9BA+D9A0gMIbO4=;
        fh=LdCqJR8fHrjwA6zIP106p9FWsScbMqvJZaTmOhP0iXU=;
        b=YYJZgPHw7ivOfCtxajXaZ/05lvgKjJ3a6iyCpELjgji6XmhNSY0fV8Dk6VA5C0Rckl
         CZ3hEji5yb29OPdPm3ofjPtGuyap/CjNtxMlgvTwWFUzvqkMS0JRybhbGfb1Ne8j/QQm
         jtvN6Jgl5IUauUWAiMq2mHxH0O7anHRyCPxWuzKkgoVN8/UNtnP5F72FnDQWJtig22Rb
         4scaUiUfg/sMrFB/x12u4OvPyXzY6bkqnayrTENbqh0irtUllnJ3AwvEptT4RM88RXn5
         xcs/E4bXMdXKRpUwiaOuk0GbGsLexaYQi5jv+o4Ko+poL2iluUXCmYCW9/plDfovwDz9
         HR5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765917567; x=1766522367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ukuk6hNM0rhIIJoAwXdQKqwGGG0/U9BA+D9A0gMIbO4=;
        b=2av69SznbgXjbzCFVtkOgjGPq2ECnjF++sNRap/FzhDBrm3YgCcf4Yj5puBPNLiiX5
         WHUSFfvCtyIVM7/Xz/an+7E9diiTpevdSa99mWxskgTUE3/SHrkFBHtVIXO305MDaImP
         gYtgmW+YkggoY0bDR9k9Jaf4Ufw8Y1wQsY5GW9lCMI2Dt2CvDmw0xdSBkrWQXLTcQDdW
         +kTvdpaDaY0eiN0OoMnJL2KO1Ok0zpkfeUABALQ5hFlQzcV2qBsOoufy2/MOmfIQjD1s
         kH2vmxyCAcm+r5SCNFAKQPN8ldDBWZqhnSwon1W/uILWZ3zRVmLUhJb443gxqhEUPxO2
         YRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765917567; x=1766522367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ukuk6hNM0rhIIJoAwXdQKqwGGG0/U9BA+D9A0gMIbO4=;
        b=TUjEmOWUI2kvCKCuvLBTD9BUuf8GlNqG4e+mZhRxwfDqYmDGyCfUqiUK48d6l4QJZ6
         tA/lkJqF7CbZVdpXnwJrXL8jSBqOArDzOiz2A893BUnWJUknhycDw5qjAq37waWMTfon
         9/8JCH0S6/wVfgxW8NBY3Dlf3QMk1x3pxSpkENfnwNJS4bHfwnaOrPd8ldn6T4zPRFEp
         ucuzvVVNjXcBDg2lEVdOWOU4LAcQ98Vkzd4JxIcWfhrbN0eaDoG7nijXtCgPNW5TOd28
         Yx4qVGOg/VcRpgrMkGQJWWmmoxcUi0P92JuR3qmbX5AVLCR/1Cajfu3HX6d+GVGurlTv
         adeA==
X-Forwarded-Encrypted: i=1; AJvYcCV46lRA++LnHsky3RunXLLbCiCDJmwFnB23ZJIcDhHefAyPAJvHeudkralt8Id/g7uo1VGRupiMxItkjfxkeQ2G@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ulO3iLxjjFPTCBZUZzLFhGgs811W1rxdkUyRvCgiQIpQJCAA
	0umfFsTwqdnwBm25PtlJVY9kayHrAZXYxV30t3kWU8L7LKeLHEtuy9tLFcnk/UGIyErZmkaqetO
	DMzqeD32dFtv20jjJZ+sxl6ruxqw/sdO+eXCfCJY1
X-Gm-Gg: AY/fxX4F/pnKjHCQcvmucgeePu8IEU3yK8qC0dqM67ea+ymNSeczdjPzy438eBENseI
	Acner8KIQNlqMeWaf5te4HUi//P4M2PgQQSUXW/77degQ3vj1KQq2w+2NdVhnImd5488X0zWMlM
	MrveMRi7Is70GDA+c29kaIHgwk84VESANkMuk2VIIPuQpSSJ67Z0gdmqNKOeguElhsi8xepjMiR
	BMn3xVPLxDg7M1nhE676kuwLtvSHu+2VOJp7Xx8s3idyyK+Js98mt+gaR71lGQnfLhtr51+SeF6
	KjKAd49Z1wWvTCk7wAJvRGmBnQ==
X-Google-Smtp-Source: AGHT+IFbtromBH6vAzZR3khshhkq7zEpAfWZpYBVhFN1J0nhsZlubwpQbDkoQhPYSPVohaFwBMJplA+PSSewgLadUlI=
X-Received: by 2002:a17:902:e552:b0:294:d42c:ca0f with SMTP id
 d9443c01a7336-2a15f24dc5emr588085ad.2.1765917566615; Tue, 16 Dec 2025
 12:39:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212-james-perf-config-bits-v3-0-aa36a4846776@linaro.org> <20251212-james-perf-config-bits-v3-3-aa36a4846776@linaro.org>
In-Reply-To: <20251212-james-perf-config-bits-v3-3-aa36a4846776@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Dec 2025 12:39:15 -0800
X-Gm-Features: AQt7F2o23fY33OmRwFHSMOklIQAwK0RjO2RcUW0zisLbAmMBE5vBP7v2D-DGMhY
Message-ID: <CAP-5=fUBSOHcK5rjJgyJed3PkgLb_dMys_qDNu=Cy_18faLX_Q@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] perf parse-events: Track all user changed config bits
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 7:32=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> Currently we only track which bits were set by the user in attr->config.
> But all configN fields should be treated equally as they can all have
> default and user overridden values.
>
> Track them all by making get_config_chgs() generic and calling it once
> for each config value.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/evsel.c        |  6 ++-
>  tools/perf/util/evsel_config.h |  6 ++-
>  tools/perf/util/parse-events.c | 98 +++++++++++++++++++++++-------------=
------
>  tools/perf/util/pmu.c          |  2 +-
>  4 files changed, 65 insertions(+), 47 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 9cd706f6279313c2cc53eba1adbd45f352090f75..dcadf022405d398bf394b3da7=
f0db5c81a3ec268 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1242,7 +1242,11 @@ static void evsel__apply_config_terms(struct evsel=
 *evsel,
>                 case EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
>                         /* Already applied by auxtrace */
>                         break;
> -               case EVSEL__CONFIG_TERM_CFG_CHG:
> +               case EVSEL__CONFIG_TERM_USR_CHG_CONFIG:
> +               case EVSEL__CONFIG_TERM_USR_CHG_CONFIG1:
> +               case EVSEL__CONFIG_TERM_USR_CHG_CONFIG2:
> +               case EVSEL__CONFIG_TERM_USR_CHG_CONFIG3:
> +               case EVSEL__CONFIG_TERM_USR_CHG_CONFIG4:
>                         break;
>                 case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
>                         rtp_buf =3D term->val.str;
> diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_confi=
g.h
> index 685fd8d5c4a88fb8ae601ded60c1fc36dde73403..7b565d76c0bc4277effbbf950=
110986b423f571c 100644
> --- a/tools/perf/util/evsel_config.h
> +++ b/tools/perf/util/evsel_config.h
> @@ -27,7 +27,11 @@ enum evsel_term_type {
>         EVSEL__CONFIG_TERM_AUX_OUTPUT,
>         EVSEL__CONFIG_TERM_AUX_ACTION,
>         EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE,
> -       EVSEL__CONFIG_TERM_CFG_CHG,
> +       EVSEL__CONFIG_TERM_USR_CHG_CONFIG,
> +       EVSEL__CONFIG_TERM_USR_CHG_CONFIG1,
> +       EVSEL__CONFIG_TERM_USR_CHG_CONFIG2,
> +       EVSEL__CONFIG_TERM_USR_CHG_CONFIG3,
> +       EVSEL__CONFIG_TERM_USR_CHG_CONFIG4,
>         EVSEL__CONFIG_TERM_RATIO_TO_PREV,
>  };
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index 46422286380f33a48087e7079a45bb21beb2d573..7ef63b808d0542999fd1303b9=
f94cae68e38030f 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1253,66 +1253,32 @@ static int get_config_terms(const struct parse_ev=
ents_terms *head_config,
>         return 0;
>  }
>
> -/*
> - * Add EVSEL__CONFIG_TERM_CFG_CHG where cfg_chg will have a bit set for
> - * each bit of attr->config that the user has changed.
> - */
> -static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_ter=
ms *head_config,
> -                          struct list_head *head_terms)
> +static int add_cfg_chg(struct perf_pmu *pmu,
> +                      struct parse_events_terms *head_config,

nit: the head_config could be made const here.

> +                      struct list_head *head_terms,
> +                      int format_type,
> +                      enum parse_events__term_type term_type,
> +                      enum evsel_term_type new_term_type)
>  {
>         struct parse_events_term *term;
>         u64 bits =3D 0;
>         int type;
>
>         list_for_each_entry(term, &head_config->terms, list) {
> -               switch (term->type_term) {
> -               case PARSE_EVENTS__TERM_TYPE_USER:
> +               if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_USER) =
{
>                         type =3D perf_pmu__format_type(pmu, term->config)=
;
> -                       if (type !=3D PERF_PMU_FORMAT_VALUE_CONFIG)
> +                       if (type !=3D format_type)
>                                 continue;
>                         bits |=3D perf_pmu__format_bits(pmu, term->config=
);
> -                       break;
> -               case PARSE_EVENTS__TERM_TYPE_CONFIG:
> +               } else if (term->type_term =3D=3D term_type) {
>                         bits =3D ~(u64)0;
> -                       break;
> -               case PARSE_EVENTS__TERM_TYPE_CONFIG1:
> -               case PARSE_EVENTS__TERM_TYPE_CONFIG2:
> -               case PARSE_EVENTS__TERM_TYPE_CONFIG3:
> -               case PARSE_EVENTS__TERM_TYPE_CONFIG4:
> -               case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
> -               case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
> -               case PARSE_EVENTS__TERM_TYPE_NAME:
> -               case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
> -               case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
> -               case PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE:
> -               case PARSE_EVENTS__TERM_TYPE_TIME:
> -               case PARSE_EVENTS__TERM_TYPE_CALLGRAPH:
> -               case PARSE_EVENTS__TERM_TYPE_STACKSIZE:
> -               case PARSE_EVENTS__TERM_TYPE_NOINHERIT:
> -               case PARSE_EVENTS__TERM_TYPE_INHERIT:
> -               case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
> -               case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
> -               case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
> -               case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
> -               case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
> -               case PARSE_EVENTS__TERM_TYPE_PERCORE:
> -               case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
> -               case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
> -               case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
> -               case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
> -               case PARSE_EVENTS__TERM_TYPE_RAW:
> -               case PARSE_EVENTS__TERM_TYPE_CPU:
> -               case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
> -               default:
> -                       break;
>                 }
>         }
>
>         if (bits) {
>                 struct evsel_config_term *new_term;
>
> -               new_term =3D add_config_term(EVSEL__CONFIG_TERM_CFG_CHG,
> -                                          head_terms, false);
> +               new_term =3D add_config_term(new_term_type, head_terms, f=
alse);
>                 if (!new_term)
>                         return -ENOMEM;
>                 new_term->val.cfg_chg =3D bits;
> @@ -1321,6 +1287,50 @@ static int get_config_chgs(struct perf_pmu *pmu, s=
truct parse_events_terms *head
>         return 0;
>  }
>
> +/*
> + * Add EVSEL__CONFIG_TERM_USR_CFG_CONFIGn where cfg_chg will have a bit =
set for
> + * each bit of attr->configN that the user has changed.
> + */
> +static int get_config_chgs(struct perf_pmu *pmu,
> +                          struct parse_events_terms *head_config,
> +                          struct list_head *head_terms)
> +{
> +       int ret;
> +
> +       ret =3D add_cfg_chg(pmu, head_config, head_terms,
> +                         PERF_PMU_FORMAT_VALUE_CONFIG,
> +                         PARSE_EVENTS__TERM_TYPE_CONFIG,
> +                         EVSEL__CONFIG_TERM_USR_CHG_CONFIG);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D add_cfg_chg(pmu, head_config, head_terms,
> +                         PERF_PMU_FORMAT_VALUE_CONFIG1,
> +                         PARSE_EVENTS__TERM_TYPE_CONFIG1,
> +                         EVSEL__CONFIG_TERM_USR_CHG_CONFIG1);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D add_cfg_chg(pmu, head_config, head_terms,
> +                         PERF_PMU_FORMAT_VALUE_CONFIG2,
> +                         PARSE_EVENTS__TERM_TYPE_CONFIG2,
> +                         EVSEL__CONFIG_TERM_USR_CHG_CONFIG2);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D add_cfg_chg(pmu, head_config, head_terms,
> +                         PERF_PMU_FORMAT_VALUE_CONFIG3,
> +                         PARSE_EVENTS__TERM_TYPE_CONFIG3,
> +                         EVSEL__CONFIG_TERM_USR_CHG_CONFIG3);
> +       if (ret)
> +               return ret;
> +
> +       return add_cfg_chg(pmu, head_config, head_terms,
> +                          PERF_PMU_FORMAT_VALUE_CONFIG4,
> +                          PARSE_EVENTS__TERM_TYPE_CONFIG4,
> +                          EVSEL__CONFIG_TERM_USR_CHG_CONFIG4);
> +}
> +
>  int parse_events_add_tracepoint(struct parse_events_state *parse_state,
>                                 struct list_head *list,
>                                 const char *sys, const char *event,
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 2c26c8d76bed920c7b5b43beb867e4d1bcaa2970..e02f74d4020c151082ecc434c=
29c0ec4c2c9b2c8 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1387,7 +1387,7 @@ void evsel__set_config_if_unset(struct perf_pmu *pm=
u, struct evsel *evsel,
>                                 const char *config_name, u64 val)
>  {
>         u64 user_bits =3D 0, bits;
> -       struct evsel_config_term *term =3D evsel__get_config_term(evsel, =
CFG_CHG);
> +       struct evsel_config_term *term =3D evsel__get_config_term(evsel, =
USR_CHG_CONFIG);
>
>         if (term)
>                 user_bits =3D term->val.cfg_chg;
>
> --
> 2.34.1
>
