Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0BC3563D2
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763570586; cv=none; b=aH6KQXP5CqFQOIo72R2+NzUGyl29rBf9s1OzCPvVC3jDFqt6DvJ6PbXL1U9laKwabi6Kzh+hMxatLRguYcYpk5qAD3TmrHybtL1PRPfblC+SJfarIZCqFXN8VfLriSgx2eRBBfzHxaKQdgcEoYx8H/lVuqy8qrizoyhhWPnb+4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763570586; c=relaxed/simple;
	bh=38vS9GA473QtcCf61PHWQfcgMCDEe9DkhidLpEZoyuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFnm1RkgzIgEPkwuvfMesDGYFe9mClakaIx11lzPzo4ZBLRqPqGF1WzSlDerrPmWcfTkutDy5Y3vuI9IWyn2exRbVMIamjlbxA/rC3NbNIAkeltnOPa/lqXNb5xNs4+D762z5mVU5NOSPayf1YKNSxxtFEBIW+8wr71wYvNjjx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RjkjVaSH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RjkjVaSH"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29852dafa7dso217225ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 08:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763570583; x=1764175383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyPcA35IUOfxBLtEjdK4s5oNYkdy4BP7cj9/6TMgYc4=;
        b=RjkjVaSHtIZbIbiMVuayw+e6iLIdhcxSNH1/BftNLxREXj7TdeKKuyj78aVY5U0/cY
         UXa/Zd9jsHko7o4XtKZX6jqhqWGdUrPj5C1D54/utbJDcUen+0X7Vqcke2ino9zU20zC
         SUry3skLW3KbXAsyKt8b1hHG8+oWSuMhJLnq/zl+UBTwqCBuIwSMIT5XWsSt4G306Agl
         nn3JrkYitmBgFD0P+PND/9j8XjRAu8Z4gTRVJj4ut09FH0d6lzZlbquXTSWRQM/JJN71
         ZNNIS6ClrL4gnakI/EFfQfc/q9P2CnotBFCfp2XJEwY0cb0uoi9NA+OPSaaXpn7yD6Nv
         Onaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763570583; x=1764175383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KyPcA35IUOfxBLtEjdK4s5oNYkdy4BP7cj9/6TMgYc4=;
        b=qlTkfwdgazlGiIkFUCHPI7uJSWvwFrjVQG/3NBJC36xdqBviQfUvOrlG2cTiptVQ31
         PJY6SmVpgJGkeAoDaaeoc32c3zL6/Ro5PcwZowv4JAtD2qe7s4S7gafqytO7Rz+k8Wsy
         d4hXlNzMu77gSWcHdwNvtgthbwIR4ETme8vYEF2r6sagAU1EOVzY82bT4hc0jYaYNBJg
         QotyPxZABn+H2j2GYOZXNog9n6uiM/LtdC07qYTvYHGweFJLB5WH1QQoOs7b5iwthUr3
         4SALnI3TY9lIsQeHMXHo1u3qgL+SQJT/YSuo9ig7b28/RO0gMAUjP5FlkEkySs1s2K6F
         +U7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUry9J4QENmf+5SbxW8GGhRp1lbjnJOETL90vutzSCxbF14oc2v+ty5loHAWFuMVwmIfRU0QfxT9Eb9xysasmI/@vger.kernel.org
X-Gm-Message-State: AOJu0YwJRJIwsebevellnHcHfAwxcTNLbrt+ye0scRXla8M98ouj8cFa
	CVh3Xx7WDOJsVwOSQTdKgdgiyal/XM3mLIL30co7RGxdp/e0VoiGlnEbISIY/draTUU79uhPUX+
	pDc4WAiJPp1JglXdiLDQpQYPtBaUlTDJ6v65HZlfJ
X-Gm-Gg: ASbGncv2pejZgV3DuWhlaF+5EEDS4DvRovTp/pyeE/O2rZNNL1nT4xUVW1SO5t00qCW
	cyQrYJMs7dYPoB69rujTczpDg3yM08orAtviAiMPrnhbfxkCYn64RQ+c/sIB4kVOhIm829JWwdS
	mvJ2U1kNs6T1y/SvvItNhZk2YgDQQBp2D0DLsym7RyxI4MmoEbE7/x2iEdJbwQ2pLlFMvzhnupu
	MmbbqFS3040sjkfxnDbIhnSu9Dhu4Ql9HIQR3FlpFVNFl8fkt1+KJV0FOxk7yOyIWjRTKBabauM
	MK+9PIu9imXckXkYhBD04mda5g==
X-Google-Smtp-Source: AGHT+IG/9JBL8sQnK+7vvrtSMc95YQDQAnx63SsCVQsW3nrXDgRk82zngNyFhl9LZx9u0MOWj0pbrL9gx8HvNRgrYtM=
X-Received: by 2002:a05:7022:670b:b0:11a:fcc8:c311 with SMTP id
 a92af1059eb24-11c8ddae885mr128403c88.5.1763570582925; Wed, 19 Nov 2025
 08:43:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118063641.517066-1-namhyung@kernel.org> <20251118063641.517066-3-namhyung@kernel.org>
In-Reply-To: <20251118063641.517066-3-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Nov 2025 08:42:50 -0800
X-Gm-Features: AWmQ_bkR-6uL3denG7l-zFDYgOUE1OLSZByipKSHe7Y7SruQfcVVFS77QczKhcU
Message-ID: <CAP-5=fXBhg3M0JdE6rEF+Gh1KDBdcd=onVgGegWv4GG6Jw2U9Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf list: Support filtering in JSON output
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 10:36=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Like regular output mode, it should honor command line arguments to
> limit to a certain type of PMUs or events.
>
>   $ perf list -j hw
>   [
>   {
>           "Unit": "cpu",
>           "Topic": "legacy hardware",
>           "EventName": "branch-instructions",
>           "EventType": "Kernel PMU event",
>           "BriefDescription": "Retired branch instructions [This event is=
 an alias of branches]",
>           "Encoding": "cpu/event=3D0xc4\n/"

The new-line '\n' here looks like another bug, the bug is coming from
reading the event from sysfs but not stripping any '\n'.

This change lgtm but we need to figure out the struct json_print_state
in patch 2.

Thanks,
Ian

>   },
>   {
>           "Unit": "cpu",
>           "Topic": "legacy hardware",
>           "EventName": "branch-misses",
>           "EventType": "Kernel PMU event",
>           "BriefDescription": "Mispredicted branch instructions",
>           "Encoding": "cpu/event=3D0xc5\n/"
>   },
>   ...
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-list.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 1ab969ffe371c5cb..48c799007414bf6e 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -375,6 +375,21 @@ static void json_print_event(void *ps, const char *t=
opic,
>         FILE *fp =3D print_state->fp;
>         struct strbuf buf;
>
> +       if (deprecated && !print_state->deprecated)
> +               return;
> +
> +       if (print_state->pmu_glob && (!pmu_name || !strglobmatch(pmu_name=
, print_state->pmu_glob)))
> +               return;
> +
> +       if (print_state->exclude_abi && pmu_type < PERF_TYPE_MAX && pmu_t=
ype !=3D PERF_TYPE_RAW)
> +               return;
> +
> +       if (print_state->event_glob &&
> +           (!event_name || !strglobmatch(event_name, print_state->event_=
glob)) &&
> +           (!event_alias || !strglobmatch(event_alias, print_state->even=
t_glob)) &&
> +           (!topic || !strglobmatch_nocase(topic, print_state->event_glo=
b)))
> +               return;
> +
>         strbuf_init(&buf, 0);
>         fprintf(fp, "%s{\n", print_state->need_sep ? ",\n" : "");
>         print_state->need_sep =3D true;
> @@ -451,6 +466,11 @@ static void json_print_metric(void *ps __maybe_unuse=
d, const char *group,
>         FILE *fp =3D print_state->fp;
>         struct strbuf buf;
>
> +       if (print_state->event_glob &&
> +           (!print_state->metrics || !name || !strglobmatch(name, print_=
state->event_glob)) &&
> +           (!print_state->metricgroups || !group || !strglobmatch(group,=
 print_state->event_glob)))
> +               return;
> +
>         strbuf_init(&buf, 0);
>         fprintf(fp, "%s{\n", print_state->need_sep ? ",\n" : "");
>         print_state->need_sep =3D true;
> --
> 2.52.0.rc1.455.g30608eb744-goog
>
