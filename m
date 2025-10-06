Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10C3846F
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Oct 2025 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773680; cv=none; b=b0XiHPqBAwvVrfKUnGYstWV4RuvdlqbvxEthAKjBIuytmWVG4V1TOm1BgumyBMIKZDNfVr6EBD4rYtwdJMpBfCP5dvR1H0yArUVOO+Dxbn2tVKUBrXM5/xu7r+BAPph6dqz+w4I/Ipuq6g0nqLCiQesseoVXk1f4lJLvnqSHTmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773680; c=relaxed/simple;
	bh=A6/BJX/rSJ+oEW3Z5FawwJ1mbJY4uAhwOGF2VHEQU3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9EoHGZ4Kc8+4zs0oB4KMwthN8i/24Bf6b0OJJKEoYuv4MewQC4bkMVO09xoE66fmOkMZHTh9usAKTKfSjeOvKQSItCZpB27jbehjOOa/yX5IkKYi/0KKzLsSnv91s28s+A4MmgfhPct+dQ4i2W8+EpW9Xc98vL/ovMybUFutwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H9yp2Qq9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H9yp2Qq9"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27eeafd4882so32005ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Oct 2025 11:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759773678; x=1760378478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3XSntDDcAtonl22HdbxJ3JujsfuLjYh2Gi8mbDcwjU=;
        b=H9yp2Qq9+mrU3jl+0bdvEb6ngbpu7a/255YP9Rs+YhcUr4yyBFbqVREVG8zOwXrQU/
         zMOppazajfTXJ6LgPn779RLu/agu8opoMvI/xvSweT6NAdIxS7Xcd7oqd0gkohrds9vu
         +3mCjmV/0Q46Z6RznV1gRcFq1gZc77xBvG7sYFiq63XgBhZNDMKuyG2spnf93GkWGjo/
         ugr2UVUT48EodC9j/NlqC4XJiR2tUEKVFFHo+C+DcKOPI9mbypxYWcBm9DcxD3enIJqb
         rQREJcAOEGbk80E0u92aJiS9tX9MQoBx3eITgjuYdKNIWoyLdXCJTKSzoj4Jdow2/nmO
         OTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759773678; x=1760378478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3XSntDDcAtonl22HdbxJ3JujsfuLjYh2Gi8mbDcwjU=;
        b=tArEKwaNy4BukPwdB/kTbDUish39d+isAeachbYV42F6NdRwKLn0QH5xfMg9TU8f4F
         +NFdlUGmRr0i/YYVnCjX7cN3zXChnM2DcdLKrOvpaRVbAHvkUzOBrgEw7hzA2eYZBCPQ
         RlTCJi/b0jzoapB4vWZGyIxDappA5iXdnq+SOQlg63Ui5A4JqC/DHnwWS+SXXQKdS8MH
         N+7JJHJ0eNlnqLTGaIgsHxIdeHRDhGeIwAlRG75KufXJbBM4LP3c7MFWlvkSOWWwwBmb
         mBEHBHZqBubLo7+fpXp+5LJr7JioBHeCWBH+ZFWyJ3+8nKbt5pO9u/2lmJkceNBrLt+E
         Z/SQ==
X-Gm-Message-State: AOJu0YyI+nKiaEflbg13aB5dAoiayGskY2Xotia2jeGGmUdKYiKbOBTu
	Rg265AvgvHxb1W7wN9cTANj+AKFs631QGunaxHfBjb1lc3V8+lh1m6xx8jqF0KyhmBGYayI/S+N
	6ddK54hJyr1SDhQ/9LkYdG9M2WyhTQI9iFTSe0IKK
X-Gm-Gg: ASbGncvxiLk8j47z9WvoW+PQqRP6D4KERAxlWKfqUNhm1lvlLT8AAfKEu5LQRfO7Y/X
	g8Nr2SLTAyTyDGC6J/03RZ/XzrJAqK4vrNcuGwh7GOLo55CgyxIn44VXbTTjOIvBBagRkFeMfno
	GaRVER2LA21+NU9HoEnR0rqBz/A0FMKytti2cXfz4P/Jz7jzzgtINnwHFGWWPbmY27xfF6KDkvt
	+eTQnvN9YnoT7KOtWOIOq2RQvhvBvqu5ZBReglOWnZkZw3Agl1Ksq0XNYTGQA2DZPT5
X-Google-Smtp-Source: AGHT+IGYZOz6tdwi/2SqWSVYOeBfbz3o0UKrixnlYK72dl/zu2CNuW3/yxwKF6qJZhnzGqs1I0DYAqAQ09NO0gbbdK8=
X-Received: by 2002:a17:902:cecf:b0:248:f683:e980 with SMTP id
 d9443c01a7336-28eca39eb6fmr330075ad.2.1759773677003; Mon, 06 Oct 2025
 11:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006175710.1179040-1-mpetlan@redhat.com> <20251006175710.1179040-2-mpetlan@redhat.com>
In-Reply-To: <20251006175710.1179040-2-mpetlan@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Oct 2025 11:01:05 -0700
X-Gm-Features: AS18NWC7X_scpoUlxvdivacuoeaD3LFBX_-PU2TTDhaytOdFOXJpFbemSVq2c4k
Message-ID: <CAP-5=fXo2+tKbTtNKN8oxiva+rKYB2AMpOCjA4+5xxNagC01UQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf tools: Remove /SYSV from no_dso maps
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, namhyung@kernel.org, 
	jmario@redhat.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 10:57=E2=80=AFAM Michael Petlan <mpetlan@redhat.com>=
 wrote:
>
> We will need it for upcoming commits. Also adjust the function
> calls in perf-inject, in order not to break the logic.
>
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> ---
>  tools/perf/builtin-inject.c | 4 ++--
>  tools/perf/util/map.c       | 5 +++--
>  tools/perf/util/map.h       | 6 +++++-
>  3 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index a114b3fa1bea..cc090da5c445 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -773,7 +773,7 @@ static int tool__inject_build_id(const struct perf_to=
ol *tool,
>
>         if (is_anon_memory(filename) || flags & MAP_HUGETLB)
>                 return 0;
> -       if (is_no_dso_memory(filename))
> +       if (is_no_dso_memory(filename) || is_shared_memory(filename))
>                 return 0;
>
>         if (inject->known_build_ids !=3D NULL &&
> @@ -813,7 +813,7 @@ static int tool__inject_mmap2_build_id(const struct p=
erf_tool *tool,
>         /* Return to repipe anonymous maps. */
>         if (is_anon_memory(filename) || flags & MAP_HUGETLB)
>                 return 1;
> -       if (is_no_dso_memory(filename))
> +       if (is_no_dso_memory(filename) || is_shared_memory(filename))
>                 return 1;
>
>         if (dso__read_build_id(dso)) {
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index b46c68c24d1c..6d13b4602970 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -133,12 +133,13 @@ struct map *map__new(struct machine *machine, u64 s=
tart, u64 len,
>         if (ADD_RC_CHK(result, map)) {
>                 char newfilename[PATH_MAX];
>                 struct dso *dso;
> -               int anon, no_dso, vdso, android;
> +               int anon, no_dso, vdso, android, shared;
>
>                 android =3D is_android_lib(filename);
>                 anon =3D is_anon_memory(filename) || flags & MAP_HUGETLB;
>                 vdso =3D is_vdso_map(filename);
>                 no_dso =3D is_no_dso_memory(filename);
> +               shared =3D is_shared_memory(filename);
>                 nsi =3D nsinfo__get(thread__nsinfo(thread));
>
>                 if ((anon || no_dso) && nsi && (prot & PROT_EXEC)) {
> @@ -174,7 +175,7 @@ struct map *map__new(struct machine *machine, u64 sta=
rt, u64 len,
>                 assert(!dso__kernel(dso));
>                 map__init(result, start, start + len, pgoff, dso, prot, f=
lags);
>
> -               if (anon || no_dso) {
> +               if (anon || no_dso || shared) {
>                         map->mapping_type =3D MAPPING_TYPE__IDENTITY;
>
>                         /*
> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> index 9cadf533a561..616f32504e46 100644
> --- a/tools/perf/util/map.h
> +++ b/tools/perf/util/map.h
> @@ -258,10 +258,14 @@ static inline int is_anon_memory(const char *filena=
me)
>  static inline int is_no_dso_memory(const char *filename)
>  {
>         return !strncmp(filename, "[stack", 6) ||
> -              !strncmp(filename, "/SYSV", 5)  ||
>                !strcmp(filename, "[heap]");
>  }
>
> +static inline int is_shared_memory(const char *filename)
> +{
> +       return !strncmp(filename, "/SYSV", 5);
> +}

Shared memory could happen because of two mmaps having the same file
and offset. Is the mapping shared within or across processes? Perhaps
there is a clearer and more capable API hiding here.

Thanks,
Ian

> +
>  static inline void map__set_start(struct map *map, u64 start)
>  {
>         RC_CHK_ACCESS(map)->start =3D start;
> --
> 2.47.3
>
