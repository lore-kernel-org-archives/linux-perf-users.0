Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73AE39FCBF
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 05:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790140901; cv=pass; b=BVveQY/7jbLtfxL8DPqQKKoDkVIHhyn6IPTOB0rE7idJTM39NkJMlWr7l1z7olH1SzSVuFOObLI5ip2in8Dvh20w7t7RH2fpWIGXoZmNY767H/nxPo+eu3DTUGhEmZmp4ivFbNP2ReHZeOnVyJP1+vpp/y/PmdTsF87UjGzHBiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790140901; c=relaxed/simple;
	bh=fjeXzgUyPMVpWTsqztlnXmY9TzRJEhenevz8j8bP9HU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nb9FbuL/PHBv1ap62C3Z/ZyMhZQF1Fv1TIBETthdI0fdLjTsf77nNzs3Hh66xv1XVFBH2UlQskAU8Lsvw5PAj4LvTWSPgSjK0abdQbgn/qtQTIav9pGaiQaFjQBwHu/AxZzPHXnfFrJT1yzJND78gL6E8Q8jyaPND4aDUngprkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ucxOZh99; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ucxOZh99"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-530e8c6fb80so100701cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 22:21:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790140898; cv=none;
        d=google.com; s=arc-20260327;
        b=agXi/votIlbWxSHeFnDntcMfxFjObqi4/O9LfXdYf+/nbNTc8w7fm/dZHFGXkThoTX
         B6orRr0Bmq2quNFg0LdO0S8ruBNeXfWcmm9Om9IiQVnP2pUo+wCwJ7U9GyMrPKJiDsIf
         t2BF3Exib/WizvwXpur53voZe6shC4OKeJlOTWWFnWA+4VkPKHn8SpYvXpdT0HtDp5f1
         8mKDfQ7GL9iB3CFqdR/ZWYivW2yc0PAxskOu1sGL1RxHL9IvpXvfK5YAN09HD4b4kvFe
         RUqCL0tb6pNFSh1mkKbV5EU2uMKz0EN8VA1HC49tNdGYAvzlciJ2X6wBIKii73qWyt0R
         eNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/B9l6mIeZxMxe9Z/zLAxGK1w8KBQ/Nf7Vha7JvI1aMo=;
        fh=gJHU7dsipJgvVBCfrt0jMqWXqsnFFgfRqgQg4VP+AqQ=;
        b=acyVE4gN1Hy58JgD/oztLTS5LCohaF29MW6E6q7oWRQF4hVXYHoGFDvsYgKKXeVUrw
         6QBUP2YDE+5ihcF+fyRo7a1dQ0JFhHdsrFQeaY6tQQzZa6MgmeRjB6Es/JCtu8WtaKsL
         BVDdfqCSJCqn+WExMJFjo6L2qrhO/LshssSPc2nz7KQhqitZdLAi79Ldy2iooC/AIcJj
         rS0z0G1xhIcVVgIYWuS0JaJTiQxXSJV8C6aSi/40WyOXUVPJt2/gzx2SoWGK3+DZ174H
         KpnoZ+XkHy3QuHzhAJOHezrbTXwGto6RBEyJD6OrrgAwEyfTUObI2McJq/rSxoqWlYWz
         QNxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790140898; x=1790745698; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/B9l6mIeZxMxe9Z/zLAxGK1w8KBQ/Nf7Vha7JvI1aMo=;
        b=ucxOZh99qJ1mQkWLHiNQCJEYbeDI9H+rJhnjyHxy/KjFy964amhJyxyvytIi58B/EG
         9bOm3wHJOe/Txq/NMvt+s8JichcpiP7NIBgHD86sJ4ftBaAoDKr7vl7QnUPLWZ5tf4CV
         Xm4xqyyUe/K797tJvjCvjQODiu1WOtON6IiY3/sfh8XJC37UpF+BKlPJypUDTcjinYca
         s6y0ZanM07ItWPOALJCyuRwp13e70MhxvtsjqskFEeILQ31l8UgzWszFLfXDc2IxsAtG
         AKM+E7Rss93pI0aMQxP76AtH+afVkT4EBvH+gbel1/yElfo4WfXfQZfOCiwDHZclW2FX
         xEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790140898; x=1790745698;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/B9l6mIeZxMxe9Z/zLAxGK1w8KBQ/Nf7Vha7JvI1aMo=;
        b=W0qcWaURT121mWamjOjmjo1qUnritIFQGUjSwsS0YZO5liX76SSWMwCvmEgFQNY11F
         bmjsgEOZ204F2b2dmUTo1Nts9FJlYhW95aieZ+3KjzWS8K1eEAAJ5T0YxkxZMeU7DJC7
         eubH7kgtoEbcDdlyevhj3BajbHStPdqd5Jlbpx69ltvi9piPU5P5iPkfVD/b5ULPlwIo
         BH6E3E2027Dd3iR5JVmm8l9StVFKYnZ4DS4NDaHAQu8Vzmxvyhki1RyVU11v0KMrEJ1p
         zgDuC4XiRU+ZkCtUKyi96jPUBNYvPgRpqvHtVxezHNalVeFMqTy9qv7Mc07fMvgNJcr0
         yKIQ==
X-Forwarded-Encrypted: i=1; AKwUvBy5prPeOYfyt8tBVTzxmClx6bjed9aoYWXaqmT6d2ztl2tv772wZ29x1TY2MMRlIkEo8L/AJ1C6ezwTekp5Rw2R@vger.kernel.org
X-Gm-Message-State: AFuF++mcY+MAQd3+1+YpsGTtkFxuttfQgN0120fq2h3UJM5Z6Z/aZ9OF
	ukbCPi15jNRXVWCSk8D64xz9dD9MSEELpUcjjitiNuWbaV3JGyzEBGVkpeUbuD0H3ZGG1ceNGOC
	79auqtVbh8t25GSnEIp+Asl6v7A54cMhYXJTQN6AR
X-Gm-Gg: AYBFou0yqHQ4pUPMnsnFmnNgXXc5KaEJqpAQmv8wOekbsPTKJTIiwkvva/A5eOUb9xN
	qUjv7PLBJtzb6fANEl/3RgpIOXnkc+cU3AAWeNCqzQnSHhZwUlrBVlnya6mv4d0J/5pPLtV2P9C
	xlUU41m8xULUrUaM5JMCd3s+5Mg6nHMAiE/DUmJNNryeZah6n3RpCeSVVXGEpHjObqgyC0yf9Pb
	G5CLhVhTDIX5lNhneMIeaa7ufOkzmAtqk3O/0hbYu7EJlmwxW+foy4cb2zHTgKqTGR1rG42zYIh
	9OGZlvyeLCO7NMqEPqWfUNqG8y3zIbN4N1ux7KOO2yBjH0+yvznEIgY=
X-Received: by 2002:a05:622a:1b90:b0:531:6de:6028 with SMTP id
 d75a77b69052e-532ef055b5bmr6391261cf.13.1790140897968; Tue, 22 Sep 2026
 22:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922-james-perf-aux-archive-v1-1-0ede8ed764ff@linaro.org>
In-Reply-To: <20260922-james-perf-aux-archive-v1-1-0ede8ed764ff@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 22 Sep 2026 22:21:25 -0700
X-Gm-Features: AcwNN1W7W6Rlvk6tFuRWSJMCRVxQegU7Pmwo5ix54xSpt0gDfcaZdx4FJDf5iEI
Message-ID: <CAP-5=fWUZrANh69W=aADmSwhg-8ogFBheL+chOHAWbRuhijEew@mail.gmail.com>
Subject: Re: [PATCH] perf buildid-list: Fix empty output for AUX data
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 7:47=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> perf record enables buildid_all for AUX trace because buildid-list does
> not decode AUX data to identify hit DSOs. Historically those build IDs
> were available in HEADER_BUILD_ID, and buildid-list disabled hit
> filtering when HEADER_AUXTRACE was present.
>
> Build IDs are now carried by MMAP2 records by default and the build-ID
> header is omitted. perf_session__list_build_ids() forces with_hits when
> the header is absent so that it processes the event stream. That also
> filters the result to DSOs referenced by ordinary samples. AUX data has
> no such samples unless the trace is decoded, so every DSO is dropped and
> perf archive reports that no build IDs were found.
>
> Process the event stream whenever the build-ID header is absent,
> allowing MMAP2 build IDs to be read, but do not enable hit filtering for
> AUX data, this ensures that all build-IDs are included for AUX data.
>
> Fixes: 6bd89ae7d147 ("perf record: Make sure to update build-ID cache")
> Assisted-by: Codex:GPT-5.6-Sol
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-buildid-list.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-build=
id-list.c
> index e0881b0ac38f..5555f5dcefe4 100644
> --- a/tools/perf/builtin-buildid-list.c
> +++ b/tools/perf/builtin-buildid-list.c
> @@ -87,6 +87,7 @@ static bool dso__skip_buildid(struct dso *dso, int with=
_hits)
>  static int perf_session__list_build_ids(bool force, bool with_hits)
>  {
>         struct perf_session *session;
> +       bool has_auxtrace, has_build_id;
>         struct perf_data data =3D {
>                 .path  =3D input_name,
>                 .mode  =3D PERF_DATA_MODE_READ,
> @@ -118,11 +119,19 @@ static int perf_session__list_build_ids(bool force,=
 bool with_hits)
>          * We take all buildids when the file contains AUX area tracing d=
ata
>          * because we do not decode the trace because it would take too l=
ong.
>          */
> -       if (!perf_data__is_pipe(&data) &&
> -           perf_header__has_feat(&session->header, HEADER_AUXTRACE))
> +       has_auxtrace =3D !perf_data__is_pipe(&data) &&
> +               perf_header__has_feat(&session->header, HEADER_AUXTRACE);
> +       has_build_id =3D perf_header__has_feat(&session->header, HEADER_B=
UILD_ID);
> +
> +       if (has_auxtrace)
>                 with_hits =3D false;
>
> -       if (!perf_header__has_feat(&session->header, HEADER_BUILD_ID))
> +       /*
> +        * Without a build-ID header, the event stream is processed below=
 to find
> +        * build IDs in MMAP2 records. For AUX data keep all DSOs because=
 the trace
> +        * is not decoded and consequently none of them can be marked as =
hit.
> +        */
> +       if (!has_build_id && !has_auxtrace)
>                 with_hits =3D true;
>
>         if (zstd_init(&(session->zstd_data), 0) < 0)
> @@ -132,7 +141,7 @@ static int perf_session__list_build_ids(bool force, b=
ool with_hits)
>          * in pipe-mode, the only way to get the buildids is to parse
>          * the record stream. Buildids are stored as RECORD_HEADER_BUILD_=
ID
>          */
> -       if (with_hits || perf_data__is_pipe(&data))
> +       if (with_hits || perf_data__is_pipe(&data) || !has_build_id)
>                 perf_session__process_events(session);
>
>         perf_session__fprintf_dsos_buildid(session, stdout, dso__skip_bui=
ldid, with_hits);
>
> ---
> base-commit: edd8a9fe2eca009599e013a29c421c7a6b5ad1b9
> change-id: 20260922-james-perf-aux-archive-4c00c7943487
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>
>
