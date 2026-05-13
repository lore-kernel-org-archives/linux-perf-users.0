Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63273315D58
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 01:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778634198; cv=pass; b=r54K4/u78Dnl8cnAifOfoc2jO3VGrMtTCByfVjC3/2pXvI3dJGFVlzR1eSwCsiszMVPT7WYGeYQTUZquXob/tGHGVA7DotIHa7beZEr1xt4qSjrMLQ8tVfSl7qxjtfdB5q9wUzNfDCW5Q1BI6BL2ZxMnRmIEArNCjvQbPbuuLDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778634198; c=relaxed/simple;
	bh=tAiYKupbjmlWomiFBWZm3U1DIWAp2oTqKhW1IiO9dbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAYwQn2x0s0GEHnueDamz+5pLEoEC81fRkWZ9Ais7ThVwZzpUMfPxNODLf3JNsZGte5qDIysAHDteLmtFslIuHoDJvISUVyrsraOcem4Vd9T4Yzv8NsehCmKCadUbzP3Q2juzraLqsBH5hidqz5/G2KyhQAHy15XeFz+90yJ7IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i+pM6cKZ; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+pM6cKZ"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-133362c30cfso26c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 18:03:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778634190; cv=none;
        d=google.com; s=arc-20240605;
        b=Yed5Y/52oL5QimmCL4WP8mC1BIE9w3fgmajTx84PPqRaB9qSRAOiomxM+skECaD/bt
         zYA4n/4fhvk7TXwtvOpelwiu3uE5+ItYc9v5PzkagP0lgBDGcgOmwBt6JgI+LMtylWlb
         hWzz5jrufvPkveu88HrtDqALtsMxSLUBgx0qBdcqNrfzIl0/v6dlpw9ko3Bg2SuV9FbC
         xcFjC+5V9LXZEpCtVyTq2YfxvpGw/o1D83RC2sOwdcqGdb0VgAgpQT2t153suoeaHCBl
         8Z+zk5YRakMpbghgm0BE64H8KzYfjHBWwwxV4KjWZIVFGiyoCwFASiCorZ5Fcq9CPrtM
         EaMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ulhWHKpmSnD058yAqu2u4kJ2BZiEp2EGH+nr0nLUtAM=;
        fh=wy717DyGdQzfQILADtJ2ysxAzwHtIU4Hglb5G600Z58=;
        b=ZnxcyviPh3Z73fSbGXruvoUmCyy85wi0y6BzXljGYqDFAIReYDrAAuAEJH9QVBC7oM
         JH8BcHRSdz+m5CpN+QcRlWOoW4+HdXbKlid8LDeWDyWzzsSf6Dz/+8xqd54V+scHZa6c
         Z2X9s1Or4mvY/vntjjFwRuAqlo3ydCkVevbGE5ClzLnaKU3fZSlUbxi2f0EugSg2m99q
         0mZxnq5FMRKFZ6p634BmNzuZGM5bAIh2E0Y2emzNhePBA/+hcYYS9EBd/sy1f7WbZq7X
         E9w/ED04OLwsPTjw9rv21YlyLwjoDD8aTY1r3VUK8nCbYwRxXcuAUjCvvSns0Be0KShy
         JPRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778634190; x=1779238990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulhWHKpmSnD058yAqu2u4kJ2BZiEp2EGH+nr0nLUtAM=;
        b=i+pM6cKZAoPYYnZWrO+y4VmuBMRrdyOzpJqYhYhtYdMo/TaVMf4pl04viX7FO7k77I
         ySaEDSo7fcjnIdqfh1PwCSD0YSzcpnwspAkdv22krQAx0lpTLvJEm/o/04WyENGIv9do
         u3Hg6HiafsScCAOmvCUJZPIs+0xjBeX0grsst1iYG4pWxnuurdJJEtbTeb1wzf1yl0yH
         mOpO1WkGwxgvC4B62ocsmVECKzq3mI07vBw2p7G4KU107m3cGsT8KtMhjNBiqxyc0N/n
         brfhoBTAHVLr4TOdtw5h9uQr41MbPyoMvqoKlgTBN397dJCUNrFLsN+u8aM2SW8L40EI
         EMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778634190; x=1779238990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ulhWHKpmSnD058yAqu2u4kJ2BZiEp2EGH+nr0nLUtAM=;
        b=fw+bp2XoRKJRkTRpk3aF1KJz0Vih4kTNwBINUCQcMPSM2tPKJn38YuwTspLWcwbJO4
         6bjYYEA5YPWhq+uUVn9UjsRUWCTtZiUOY3ROkwhzubYeYNiq1Tu74wpbiYmsqS+UIoAG
         ilquJywA7QH+xqHuyr3ET5mR6UAUPcIRdccySyWoVXjpiZU9Zwww5m6i9CdFeY2iemjj
         N3yMzH0mGbYNm6duqux55O173B3Vk1YlTKChELDRXImU1hMCTnBsKpCcL8tutfkHZgmB
         n8gcU6IBrYirRNhAaZy6H7minQoBcLU6BC+KRpj/S/TO6ALa4mKHJhcnEfiCD1fiTxg4
         mWYg==
X-Forwarded-Encrypted: i=1; AFNElJ8Ykd7YCj3F1wb1hL9S68AA1YCHR3yHxvyzYh6/WWtsaf+R+M1aKc+3deeE6lrXOCyOkHZqvRgFWbUoMprmkl87@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3WRVsPUbBd07R6xuar+AIiv9m1JW2EkLkREsIGPs/EG5nPUsL
	dD0E43OhqrrRx7P1vxQ0+rTpTzTbg+xGJ03id7oAyqnGrYK2LAjQkbgtoeWKIX+KZm8ivqhuEjk
	LVXSwljlI1XBdDLzHE4ZbPL12u/KzldUSGOR76Al0
X-Gm-Gg: Acq92OGNmC61V34Z4SBhiNA7MByFVjo1U8RnYVXCXbiGj9/yh6qdKaijwBl61quBTbD
	FNg9IivavbKyMvggcjgQvbvgBlaC0SOA6867cfiE47Oy6fHRB0P4T64ypoDGIbh/4AdT8qYoIsu
	xm5r5v5eLuWJPLwkFtrXFm/oWggCxKeOqrX7U0XBgRUqgsquGz+BHTN9+yRxvJJQ60trdQJD1kR
	KdjVZgLClF3UL1q53KDisBE/KjGOrgFh+CTldfHyv5QbNgES52Os5qdV1joF4gF+TuOtplUTKeU
	OeCqxiJLcxyeGJfWvFw=
X-Received: by 2002:a05:7022:785:b0:133:3bc1:bf2e with SMTP id
 a92af1059eb24-13489ba2e12mr62355c88.5.1778634189086; Tue, 12 May 2026
 18:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504154205.21394-1-atrajeev@linux.ibm.com> <20260504154205.21394-2-atrajeev@linux.ibm.com>
In-Reply-To: <20260504154205.21394-2-atrajeev@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 May 2026 18:02:55 -0700
X-Gm-Features: AVHnY4L4IACcJi8qI8F6D66t_-FPiqzis4dycqEsczXQ7zZot14mCrzXc7WlR2Y
Message-ID: <CAP-5=fWWN_+v9h8LDwm0UamHtGv0awg6P+ZZYkBJR18P_TanSw@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] tools/perf: Use scnprintf in buffer offset calculations
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com, 
	namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com, 
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 8:42=E2=80=AFAM Athira Rajeev <atrajeev@linux.ibm.co=
m> wrote:
>
> Replace snprintf with scnprintf in buffer offset calculations to
> ensure the 'used' count will not exceed the "len".
>
> The current logic in perf_pmu__for_each_event uses an unconditional
> + 1 increment to buf_used to account for null terminators. This can
> cause a a stack buffer overflow in the subsequent scnprintf call.
> When the local stack buffer buf (1024 bytes) is full, buf_used can
> reach 1025. This causes the subsequent remaining space calculation
> sizeof(buf) - buf_used to underflow.
>
> Use sub_non_neg() to see if space actually existed, and only
> increment the offset if remaning space is present.
>
> Changes includes:
> - Use sub_non_neg to check if space exists
> - Replacing snprintf with scnprintf to ensure the return value
> reflects the actual bytes written into the buffer.
> - Only increment buf_used by 1 if space exists
> - If a parameterized event uses a built-in perf keyword for its
> parameter name (eg, config=3D?), the lexer parses it as a predefined
> term token, which sets term->config to NULL. Add check to use
> parse_events__term_type_str() if term->config is NULL.
>
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> Changelog:
> v2 -> v3:
> - Split the scnprintf related changes in separate patch
> - Handle the overflow issues and unconditional increment
> wrapped around sub_non_neg addressing review comment from Sashiko
>
>  tools/perf/util/pmu.c | 46 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 0b8d58543f17..4b9ade1a4cf9 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -2129,15 +2129,19 @@ static char *format_alias(char *buf, int len, con=
st struct perf_pmu *pmu,
>                 pr_err("Failure to parse '%s' terms '%s': %d\n",
>                         alias->name, alias->terms, ret);
>                 parse_events_terms__exit(&terms);
> -               snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->na=
me, alias->name);
> +               scnprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->n=
ame, alias->name);
>                 return buf;
>         }
> -       used =3D snprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->na=
me, alias->name);
> +       used =3D scnprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->n=
ame, alias->name);
>
>         list_for_each_entry(term, &terms.terms, list) {
> +               const char *name =3D term->config;
> +
> +               if (!name)
> +                       name =3D parse_events__term_type_str(term->type_t=
erm);
>                 if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_STR)
> -                       used +=3D snprintf(buf + used, sub_non_neg(len, u=
sed),
> -                                       ",%s=3D%s", term->config,
> +                       used +=3D scnprintf(buf + used, sub_non_neg(len, =
used),
> +                                       ",%s=3D%s", name,
>                                         term->val.str);
>         }
>         parse_events_terms__exit(&terms);
> @@ -2201,6 +2205,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, =
bool skip_duplicate_pmus,
>         int ret =3D 0;
>         struct hashmap_entry *entry;
>         size_t bkt;
> +       size_t size_rem, len;
>
>         if (perf_pmu__is_tracepoint(pmu))
>                 return tp_pmu__for_each_event(pmu, state, cb);
> @@ -2234,17 +2239,36 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu=
, bool skip_duplicate_pmus,
>                         }
>                         buf_used =3D strlen(buf) + 1;
>                 }
> +
>                 info.scale_unit =3D NULL;
>                 if (strlen(event->unit) || event->scale !=3D 1.0) {
> -                       info.scale_unit =3D buf + buf_used;
> -                       buf_used +=3D snprintf(buf + buf_used, sizeof(buf=
) - buf_used,
> -                                       "%G%s", event->scale, event->unit=
) + 1;
> +                       /* Check the remaining space */
> +                       size_rem =3D sub_non_neg(sizeof(buf), buf_used);
> +
> +                       if (size_rem > 0) {
> +                               info.scale_unit =3D buf + buf_used;
> +                               len =3D scnprintf(buf + buf_used, size_re=
m, "%G%s",
> +                                               event->scale, event->unit=
);
> +                               /*
> +                                * Increment buf_used by 1 only if
> +                                * it fits remaining space
> +                                */
> +                               buf_used +=3D min(len + 1, size_rem);
> +                       }
>                 }
>                 info.desc =3D event->desc;
>                 info.long_desc =3D event->long_desc;
> -               info.encoding_desc =3D buf + buf_used;
> -               buf_used +=3D snprintf(buf + buf_used, sizeof(buf) - buf_=
used,
> -                               "%.*s/%s/", (int)pmu_name_len, info.pmu_n=
ame, event->terms) + 1;
> +               info.encoding_desc =3D NULL;
> +
> +               /* Check the remaining space */
> +               size_rem =3D sub_non_neg(sizeof(buf), buf_used);
> +               if (size_rem > 0) {
> +                       info.encoding_desc =3D buf + buf_used;
> +                       len =3D scnprintf(buf + buf_used, size_rem, "%.*s=
/%s/",
> +                                       (int)pmu_name_len, info.pmu_name,=
 event->terms);
> +                       buf_used +=3D min(len + 1, size_rem);
> +               }
> +
>                 info.str =3D event->terms;
>                 info.topic =3D event->topic;
>                 info.deprecated =3D perf_pmu_alias__check_deprecated(pmu,=
 event);
> @@ -2254,7 +2278,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, =
bool skip_duplicate_pmus,
>         }
>         if (pmu->selectable) {
>                 info.name =3D buf;
> -               snprintf(buf, sizeof(buf), "%s//", pmu->name);
> +               scnprintf(buf, sizeof(buf), "%s//", pmu->name);
>                 info.alias =3D NULL;
>                 info.scale_unit =3D NULL;
>                 info.desc =3D NULL;
> --
> 2.47.3
>
