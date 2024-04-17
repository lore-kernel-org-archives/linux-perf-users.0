Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A459B7A
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Apr 2024 06:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335783; cv=none; b=AoqPra+4uAbvmS+Zl3HXKRKoeQdUDuCeGOBKItuCa1qvIT4LZDIZAoxACbPL+ybM5ZdiCW9TuAECtNjrLAn+O369HtCLFiY16o4kpbR+FpfOI+/blw3IgX9+HAAySfR45fmh6eY7B5mZbBMy+zglOK/urURV5mBYjvr0ke+Y3OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335783; c=relaxed/simple;
	bh=FBFGo1TypK9HPXRlgJBx48oxUcb9ZIDsMyMtFqP9+fM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGqkAgcdq0PQuiMJdRMOhPOhPEscsgepspmZ90k01Ztrcu4xzr1ODSDqaQZ9wxWC29zURC2fJhoMRrn0PfjJJCQtkURktygOyvRlYHQJ94EYbG82umAMRWmiIziTjy5xiMVxu44rCsygWZdF42S7HsxsgNtlKBH2J0zJcsC5VMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J/2TT/q/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J/2TT/q/"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e44f82ff9cso79795ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Apr 2024 23:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713335780; x=1713940580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsDVlHRa9iXnfcTgTwT31ew2pDSP8h1AFx3bi9h+wp0=;
        b=J/2TT/q/Bm2Mk8K+BAv5LUDW/7QyAJYy139LlyTww3nA4+N3FxcgrG1zG+kW5J9Sle
         NhCejnqqCwpt8BDs1Nbn9O8W3up8CG4jF8h2qlTDEp4yYww16Ukt4A6wEMI1Y1KLN09n
         6u1OIqvJBCHxe0MtYUFS9hFWr9+5/cUEe+qB5zkDBEbuoMS/+3gmdFOoI02k8D4gcrgh
         bhcaUhgXxdsR4e6malpMQqT1s/BKyv+BeLIs/ev+o6oLK4NBRH8VvI2LI2+lnOq4gLAX
         nrG3ASA1sY3mcvkOX6Q67jqmcq2x23l1QN/gzRAIqG/r45JnrNk1Ooh/R1txzcsasFPi
         2HCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713335780; x=1713940580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsDVlHRa9iXnfcTgTwT31ew2pDSP8h1AFx3bi9h+wp0=;
        b=mrESOEt3MFDFXmxW/xTI4kYBTAjHZGoSQ5jKdKXD1t2oxYD4Nhy27Wu/wJiiaBMxVa
         lES1Eb7j8BYIedi6G/esqPzbGMkVjKMTPaTQNnAYmJT6q1qoBfpYqcpSwK3XgBSbYA6S
         lEwrEbRoFjLpj4OMfVFe1VgR/w/njWf4LxIf2+OFVgUo9tB7tyTHpWk7iOVMs9FG/L9W
         E1gxVAQK7bckiNTLamVI0wdBHA6rwUuS1OIZzaHBMIZKKP1qYc4WYaJP9xI91Y6xK/mv
         BcPojN4k0eCLPCuMBFcCT+BKcAKp1bk6T6GD3Y8hnlM/VhiX/XXnWAfrxPqs5AFJ+LlP
         flOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS+/hPtPf+xDXOht9W/yGh3WgwyhWNnB9il0nmvgVjLPE5MUJ91KDcJJOzBF5skqxPn6Y0I2U5pA86+lXumIXBWMpMjAnZoH9k92bw/WM/YA==
X-Gm-Message-State: AOJu0YyMeQUFObQ7zle0cP6qkphN8ekLa/VRdUiY1pnRx3Ap2gbXuLLm
	4FZd40uXFyQBby2N1wHrONk7by/oET5RnkM3SBrhDcTkjZWGqPdAOmpgjpm9odv9riRqSn5NX56
	DK/uAAt4jF1CWN+SlL9mMeZCNZlrRmr2WAXxG
X-Google-Smtp-Source: AGHT+IHUgizpB28cwoGPrTR+lm6aMkCh9AcTpEQ1yGrkdEF8ValwGq3EAXhYTz1Zxyy9qxSqrUPsttDsHArVTxGjZpU=
X-Received: by 2002:a17:902:c652:b0:1e2:c902:57b9 with SMTP id
 s18-20020a170902c65200b001e2c90257b9mr145266pls.28.1713335779526; Tue, 16 Apr
 2024 23:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412210756.309828-1-weilin.wang@intel.com> <20240412210756.309828-16-weilin.wang@intel.com>
In-Reply-To: <20240412210756.309828-16-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Apr 2024 23:36:06 -0700
Message-ID: <CAP-5=fU+RsJGdcA-cLkyKUwqh61y8f6_+H9rbdvFX3ZNec95wQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 15/16] perf stat: use tool event helper function in metricgroup__build_event_string
To: weilin.wang@intel.com
Cc: Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 2:08=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> We want to include all used tool events in each event group to ensure
> sharing events so that help improve multiplexing.
>
> This change updates parse_id and metricgroupg__build_event_string to use

nit: typo in metricgroup__build_event_string

> the get_tool_event_str helper function to generate tool event string
> instead of inserting temporary tool event ids and generate string from
> the tool event ids.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/util/metricgroup.c | 61 +++++++++++++----------------------
>  1 file changed, 22 insertions(+), 39 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 86b6528e5a44..39746d18f078 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -774,6 +774,18 @@ static int get_tool_event_str(struct strbuf *events,
>         int i =3D 0;
>         int ret;
>
> +       /*
> +        * We may fail to share events between metrics because a tool
> +        * event isn't present in one metric. For example, a ratio of
> +        * cache misses doesn't need duration_time but the same events
> +        * may be used for a misses per second. Events without sharing
> +        * implies multiplexing, that is best avoided, so place
> +        * all tool events in every group.
> +        * This function helps place all tool events in every group by
> +        * generating the tool event strbuf that to be added in event
> +        * group strings.
> +        */
> +
>         perf_tool_event__for_each_event(i) {
>                 if (tool_events[i]) {
>                         const char *tmp =3D strdup(perf_tool_event__to_st=
r(i));
> @@ -795,15 +807,18 @@ static int get_tool_event_str(struct strbuf *events=
,
>  static int metricgroup__build_event_string(struct strbuf *events,
>                                            const struct expr_parse_ctx *c=
tx,
>                                            const char *modifier,
> -                                          bool group_events)
> +                                          bool group_events,
> +                                          const bool tool_events[PERF_TO=
OL_MAX])
>  {
>         struct hashmap_entry *cur;
>         size_t bkt;
>         bool no_group =3D true, has_tool_events =3D false;
> -       bool tool_events[PERF_TOOL_MAX] =3D {false};
>         int ret =3D 0;
> +       struct strbuf tool_event_str =3D STRBUF_INIT;
>
>  #define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
> +       ret =3D get_tool_event_str(&tool_event_str, tool_events, &has_too=
l_events);
> +       RETURN_IF_NON_ZERO(ret);
>
>         hashmap__for_each_entry(ctx->ids, cur, bkt) {
>                 const char *sep, *rsep, *id =3D cur->pkey;
> @@ -814,8 +829,6 @@ static int metricgroup__build_event_string(struct str=
buf *events,
>                 /* Always move tool events outside of the group. */
>                 ev =3D perf_tool_event__from_str(id);
>                 if (ev !=3D PERF_TOOL_NONE) {
> -                       has_tool_events =3D true;
> -                       tool_events[ev] =3D true;
>                         continue;
>                 }
>                 /* Separate events with commas and open the group if nece=
ssary. */
> @@ -879,19 +892,8 @@ static int metricgroup__build_event_string(struct st=
rbuf *events,
>                 RETURN_IF_NON_ZERO(ret);
>         }
>         if (has_tool_events) {
> -               int i;
> -
> -               perf_tool_event__for_each_event(i) {
> -                       if (tool_events[i]) {
> -                               if (!no_group) {
> -                                       ret =3D strbuf_addch(events, ',')=
;
> -                                       RETURN_IF_NON_ZERO(ret);
> -                               }
> -                               no_group =3D false;
> -                               ret =3D strbuf_addstr(events, perf_tool_e=
vent__to_str(i));
> -                               RETURN_IF_NON_ZERO(ret);
> -                       }
> -               }
> +               ret =3D strbuf_addstr(events, tool_event_str.buf);
> +               RETURN_IF_NON_ZERO(ret);
>         }
>
>         return ret;
> @@ -2421,32 +2423,13 @@ static int parse_ids(bool metric_no_merge, struct=
 perf_pmu *fake_pmu,
>
>         *out_evlist =3D NULL;
>         if (!metric_no_merge || hashmap__size(ids->ids) =3D=3D 0) {
> -               bool added_event =3D false;
> -               int i;
>                 /*
> -                * We may fail to share events between metrics because a =
tool
> -                * event isn't present in one metric. For example, a rati=
o of
> -                * cache misses doesn't need duration_time but the same e=
vents
> -                * may be used for a misses per second. Events without sh=
aring
> -                * implies multiplexing, that is best avoided, so place
> -                * all tool events in every group.
> -                *
> -                * Also, there may be no ids/events in the expression par=
sing
> +                * There may be no ids/events in the expression parsing
>                  * context because of constant evaluation, e.g.:
>                  *    event1 if #smt_on else 0
>                  * Add a tool event to avoid a parse error on an empty st=
ring.
>                  */
> -               perf_tool_event__for_each_event(i) {
> -                       if (tool_events[i]) {
> -                               char *tmp =3D strdup(perf_tool_event__to_=
str(i));
> -
> -                               if (!tmp)
> -                                       return -ENOMEM;
> -                               ids__insert(ids->ids, tmp);
> -                               added_event =3D true;
> -                       }
> -               }
> -               if (!added_event && hashmap__size(ids->ids) =3D=3D 0) {
> +               if (hashmap__size(ids->ids) =3D=3D 0) {
>                         char *tmp =3D strdup("duration_time");
>
>                         if (!tmp)
> @@ -2455,7 +2438,7 @@ static int parse_ids(bool metric_no_merge, struct p=
erf_pmu *fake_pmu,
>                 }
>         }
>         ret =3D metricgroup__build_event_string(&events, ids, modifier,
> -                                             group_events);
> +                                             group_events, tool_events);
>         if (ret)
>                 return ret;
>
> --
> 2.42.0
>
