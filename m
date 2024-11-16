Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40D018E361
	for <linux-perf-users@vger.kernel.org>; Sat, 16 Nov 2024 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731782267; cv=none; b=k7xbHXBLtO8sSCJIZNkjtgigUpkzr3YRakh6eQhOE8kjwDwl81NdFrPLR6snJYHWhfS35uwd437sLFXFNYN7EurZFTEbz5OpUiJV7FVeT++JTCkzo7a5BeOwDXxQAdfMSBNKI0kKY+VDeZsw9tZ+5tGC2EblUgEnlp8iPUMGk/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731782267; c=relaxed/simple;
	bh=EuVvZndbJbLCbkw/jVWTOrqaNxG+iFovwa0e+HK6+zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfgGTheYK7a0MKfuyegNwmZZY13dKF57Zbm2YpI+TJ/bZvW8gQP4c1fcl+phoelNEl2MrHLIHxaxoPydl1QHlXfGIErcF4PrRKi7Az55sFGDWT8c1JBeiadPSdW2/QjbPFUurXiJlCuoZY+975shkqUdROtxu2oGA4YtQs+Bdg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UrQ6FJYG; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UrQ6FJYG"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a761c7c496so2875ab.0
        for <linux-perf-users@vger.kernel.org>; Sat, 16 Nov 2024 10:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731782265; x=1732387065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ct7dWEryvMDfH1sRvyaI/rpEKv5TjVF/tJVlscy8fBM=;
        b=UrQ6FJYGgRToACPJ6w0SQ1BQ6YGfFNplAmLP0uzBM68nt3Lp6cI/NbixWCNZsi2Eep
         Jv6jrP+RYGqZpy0s6luDy9fjut6y09y9b88htSuzKnPAvau01avwzBGfj4Fco9TU5Riq
         BAsu8G1cieYOPQAwZ/pfZ35uzcZB5wbQ1ubSCTbUHHYlinEyhRaBGAOHHZLY+6ewxqk6
         cBlLWlFmXSXd5ASxmkMHwndwKmPZUCVyA2svsaXil4wrFYPHnzIS8M6rJsoSq61fNZj2
         o4xdmeVNGNa6dtFlWpJA4o7LEYscjIaMiCDUAV9ZBO/ta42K+5Q4H/D3P71AaIlaH22M
         bWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731782265; x=1732387065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ct7dWEryvMDfH1sRvyaI/rpEKv5TjVF/tJVlscy8fBM=;
        b=mlvxc741JL/7eFccOwTaxr6ttxrwqbkHKNJtRq3sl78e4YUZbfPiPoqvOoOCMgLjKE
         58E98BmctZBKNQhLq0gFkSsZDorYWFQSbI4sSTdLIQrA4cwKuwvEre8Kj2lvVF4TjD99
         dU9kRVDbn6quSWpc5f94fZEKpsU/b9xH9GKueZbN6/1HiD+CqM84T1H1cDaZqOEGZ9B+
         m4KUxjgy1yl0iwa3FKWz1qBnICuuEjrGWdzKWTYMtYkNuYI6CxXhf+kzmOgr1qQ+hqXW
         DLKW6TDeB1IbUlL8MYMpgLUAedsQRIQmRxfvGmx+/cMfaY1hGo4E+9uaPhuqEcp02gXr
         2S1A==
X-Forwarded-Encrypted: i=1; AJvYcCVKkzxDS8ndpCx4cDbdmEAvit8tYwCd1/PTYg9A6cv8Hm/lWtXF53FUPTnCpqXo2HXpV3Zzy14P5hqb/pFUJpB4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3RBAiM6sLtVBehnnW39DkFND+GJc8GcESDhH3oPLLjFqWhV0y
	cjIwGsjtNBTCPWajqJg+gDj1gRL6K0JPs3y7t4i5s0Ws6CM9VyMV1/E+8BcrQCUOVaUhTjaUcvp
	kDXfuVKaFcgdn981OHDokRUmp0LVXMrWOC6/V
X-Gm-Gg: ASbGncs2AzCfwrVTW/5Xc2+oAeJPoaWH0hpR72CEKdAgQ6dIxuLU5ig7wJc7xIvvqa6
	Gt8wDJQlpyGTcHSTZwmnBEGRE3drog7Mt
X-Google-Smtp-Source: AGHT+IFaZTQ5zPAocYt8kqY+sKAsQpnFpg4ANEp9NJJsjwgwEVw/Id0rLAsqpRi6pgxDSGeB1E51/3JmCjaS+FESOdw=
X-Received: by 2002:a05:6e02:b4c:b0:3a6:f215:c5aa with SMTP id
 e9e14a558f8ab-3a750c61f8emr2428345ab.14.1731782264632; Sat, 16 Nov 2024
 10:37:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116155850.113129-1-linux@treblig.org>
In-Reply-To: <20241116155850.113129-1-linux@treblig.org>
From: Ian Rogers <irogers@google.com>
Date: Sat, 16 Nov 2024 10:37:32 -0800
Message-ID: <CAP-5=fXqig=qHAa26d5-8pHPCtS0ZyCNs4FJGr4c4BSjFe+-eg@mail.gmail.com>
Subject: Re: [PATCH] perf util: Remove kernel version deadcode
To: linux@treblig.org
Cc: namhyung@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 7:58=E2=80=AFAM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> fetch_kernel_version() has been unused since Ian's 2013
> commit 3d6dfae88917 ("perf parse-events: Remove BPF event support")
>
> Remove it, and it's helpers.
> I noticed there are a bunch of kernel-version macros that are also
> unused nearby.
> Also remove them.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/util.c | 85 ------------------------------------------
>  tools/perf/util/util.h |  8 ----
>  2 files changed, 93 deletions(-)
>
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 9d55a13787ce..855aac5150a0 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -336,91 +336,6 @@ bool perf_event_paranoid_check(int max_level)
>         return perf_event_paranoid() <=3D max_level;
>  }
>
> -static int
> -fetch_ubuntu_kernel_version(unsigned int *puint)
> -{
> -       ssize_t len;
> -       size_t line_len =3D 0;
> -       char *ptr, *line =3D NULL;
> -       int version, patchlevel, sublevel, err;
> -       FILE *vsig;
> -
> -       if (!puint)
> -               return 0;
> -
> -       vsig =3D fopen("/proc/version_signature", "r");
> -       if (!vsig) {
> -               pr_debug("Open /proc/version_signature failed: %s\n",
> -                        strerror(errno));
> -               return -1;
> -       }
> -
> -       len =3D getline(&line, &line_len, vsig);
> -       fclose(vsig);
> -       err =3D -1;
> -       if (len <=3D 0) {
> -               pr_debug("Reading from /proc/version_signature failed: %s=
\n",
> -                        strerror(errno));
> -               goto errout;
> -       }
> -
> -       ptr =3D strrchr(line, ' ');
> -       if (!ptr) {
> -               pr_debug("Parsing /proc/version_signature failed: %s\n", =
line);
> -               goto errout;
> -       }
> -
> -       err =3D sscanf(ptr + 1, "%d.%d.%d",
> -                    &version, &patchlevel, &sublevel);
> -       if (err !=3D 3) {
> -               pr_debug("Unable to get kernel version from /proc/version=
_signature '%s'\n",
> -                        line);
> -               goto errout;
> -       }
> -
> -       *puint =3D (version << 16) + (patchlevel << 8) + sublevel;
> -       err =3D 0;
> -errout:
> -       free(line);
> -       return err;
> -}
> -
> -int
> -fetch_kernel_version(unsigned int *puint, char *str,
> -                    size_t str_size)
> -{
> -       struct utsname utsname;
> -       int version, patchlevel, sublevel, err;
> -       bool int_ver_ready =3D false;
> -
> -       if (access("/proc/version_signature", R_OK) =3D=3D 0)
> -               if (!fetch_ubuntu_kernel_version(puint))
> -                       int_ver_ready =3D true;
> -
> -       if (uname(&utsname))
> -               return -1;
> -
> -       if (str && str_size) {
> -               strncpy(str, utsname.release, str_size);
> -               str[str_size - 1] =3D '\0';
> -       }
> -
> -       if (!puint || int_ver_ready)
> -               return 0;
> -
> -       err =3D sscanf(utsname.release, "%d.%d.%d",
> -                    &version, &patchlevel, &sublevel);
> -
> -       if (err !=3D 3) {
> -               pr_debug("Unable to get kernel version from uname '%s'\n"=
,
> -                        utsname.release);
> -               return -1;
> -       }
> -
> -       *puint =3D (version << 16) + (patchlevel << 8) + sublevel;
> -       return 0;
> -}
> -
>  int perf_tip(char **strp, const char *dirpath)
>  {
>         struct strlist *tips;
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index 9966c21aaf04..b5e7becfc803 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -43,14 +43,6 @@ int sysctl__max_stack(void);
>
>  bool sysctl__nmi_watchdog_enabled(void);
>
> -int fetch_kernel_version(unsigned int *puint,
> -                        char *str, size_t str_sz);
> -#define KVER_VERSION(x)                (((x) >> 16) & 0xff)
> -#define KVER_PATCHLEVEL(x)     (((x) >> 8) & 0xff)
> -#define KVER_SUBLEVEL(x)       ((x) & 0xff)
> -#define KVER_FMT       "%d.%d.%d"
> -#define KVER_PARAM(x)  KVER_VERSION(x), KVER_PATCHLEVEL(x), KVER_SUBLEVE=
L(x)
> -
>  int perf_tip(char **strp, const char *dirpath);
>
>  #ifndef HAVE_SCHED_GETCPU_SUPPORT
> --
> 2.47.0
>
