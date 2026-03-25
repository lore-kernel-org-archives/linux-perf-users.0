Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980803DEFEB
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451036; cv=pass; b=AUVe2ZJO03+sl6rZ+LwmGUDeDdGnKidnaZwzMQvdM0U2fYwrNEF+WB0xda6VFqvDHeu7iNyjiBBAMmQxs8SiZjKg5XDdsCCZBbadNqELszD7vPb6laJLJ16sOw9cWcIlMGgeaj49wKKN12X/La1lEj1yOLtJd7zijn5Jko9VWFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451036; c=relaxed/simple;
	bh=qm0d3kjQW6aV5Cy2RHmHl8ULGvSuNMloC3mjkRM2Ggw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxrZOaS+97opsge3LQmoBUk/V+TvPUhpgPc/A3Af5K1yZdS5INjqGmVrcO8GLdbS3l5QIDRb/yyT5RKK/N/feMupsfCGEeaDM7JhT7x50pyqs2cJubB6w29x+Mkr4ltRiHsQCuvZf93yr4EKmL54IG2oKUwpNwbAuBslA14FYr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PquHJ8hv; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PquHJ8hv"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b0b260d309so75455ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 08:03:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774451035; cv=none;
        d=google.com; s=arc-20240605;
        b=K+JIRzHuReQyN6fBCwyKumrqB5sK7tw8/qEN8LsBSOImDxBARj/iuuQ+17m4SCrKG2
         hTOr+yy1IzgkyZ/REyzO5SbxvmYerTlExBAbA/u0f7zlrhFlSvjuFyKXkMB3tXiK1vyu
         oNCZxtzCWBMYhtRqxdSuKrYYb3LfDbRbeapafajJf+siau5DkIorFD4Ud7pFiBu0gY2e
         RBdiCkE/FQUOhFrhvwNM2Te/XQ7+/YfKprZBMdojv9tN8ic1zsadv+nz7LQowkX1RgHu
         7e0LnSyyYwSwnrtT+rNOhTxjpALow7/Tgo4D5F86/iu2TN7TkwCGymlW4BuN1UpSfoAo
         u0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lfgBqYyqmJOVRzGjk6Fl6eNS+jqrf2i2gCxPGM4REos=;
        fh=OZqx1dL1HQSb/BHlmcsBUt/65e9ZtcnB1eVr/DW19Gw=;
        b=AZwYoleKediNLqgvnp6BnSnfBurogod9By8S3nkLLoaVFhAV4lbUI8CFsebq5G/ltZ
         K3kHUxF2D8hR1YJuoT9U4J90YfY2vB5wojARroXw7P4gqVfIuq1L+2nD6JSPxH7Nvu91
         in8xPi5Q16/7c5xzCMqnOxJWyHEDOdYClOfNtrUpOh0ZScNN/7BET0iETh/CXzcJypL9
         eSWD1IQa8cNorsZ5Pl2AQG8RlWTklgBSfwFnOXPZxfZKZPvBsu+LfRqoNRRsT/hltR92
         HX5PzDShKavGKcUMf1TyYqESKzSHdOg0IJ72F/ZvMh5VnLPldA4injGqBIPg0VEeh5Pt
         tQaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774451035; x=1775055835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfgBqYyqmJOVRzGjk6Fl6eNS+jqrf2i2gCxPGM4REos=;
        b=PquHJ8hvvdwSWl2FiF6B5ycrJOH0wnAKwfUHN8Rr4VGfpQwroNuLsEKNVoqfgfmmeT
         U/di0+PfvZvcsy1Fx9utQIJJcv2MpLhihXvJRP9WXvLHQrqjoWwuMqir4sKSZuAgXoMd
         vbP/XNsYrk4FfijBzkcSNJXVp9Ecuc40bwFcseFZMkNYM41UDn9xWiIVwIAimvMb7z1N
         8/bIgoUOX1bwV9ZSoS1oaGIMQD5AO4y668LYcrsSJVBlqsgJU4qclCkamjg/A6oxxkvr
         nNInbEgONMLSxbRg4b8FrLcvzbWhXpnG6SmoX3DDviIsRDzLdkphAMHn1WwqUliykPuQ
         ZBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774451035; x=1775055835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lfgBqYyqmJOVRzGjk6Fl6eNS+jqrf2i2gCxPGM4REos=;
        b=hsoBaNY44/iz2WSr2C3hlu0GGTJdyath/ft9vZ8plogKKCTa0rXxsZjVmk81wsZrRm
         dxop9xdeZymOCb9zRBgHR6fvV6w+g8UMtnamSQu/7h4qemPRlngMFxDSHeIVgJGzbXvb
         SQYf7Gumqc31XyKqe9e4uLHX+KccfKl260lk/R6wsURhUcGpx2UKVVWH7J5ZymvZqrcb
         vBAOeZwiRZs+BFGIGTPovkm6i9phcc/A7kLF6O6FGZ1OpqavENpGhqZeDtmtbj2W/9Qq
         A7nlV9LqYOliaUX1AA2tZw/jMej+Cded0l6bgdSEji9fIc9giSd0NiO7QAsNy6+94gG1
         R/xw==
X-Forwarded-Encrypted: i=1; AJvYcCUwFFQ1675y2XsBxP41ZvQoPK4AzNTagTcr4NO/DYcSX7t8imjcc3hVkY0Sy92L2jaPKHOOmEfhwCmwTvrKMQYc@vger.kernel.org
X-Gm-Message-State: AOJu0YxNwLKn+AmYujlMTQGi9c8RUXxnlLM8xJBLDF4MYQJXyeCxfivg
	Rx2scZMfNJVg2e8ALcXIe9IB74UPvWm9rgmSICfcbgn8vls2a4kpURKLp2nDBOx9VAd/XEbeGFB
	VAOwRBPgNT2Cg5aOlJrwR/EJnduVLVgpLZTlk0+jF
X-Gm-Gg: ATEYQzy606n66j/whXpLlGGhmewUVIEKSUfBuXKTHkl8HrJlhnkjegmBuI1nSGxOGol
	FlZLbevzuesxUm0C2SW4h/5R28fakMuq+Qt/mZJ95toOwg/OKKR1Y7O9+o/lyp0bcqy43sejVff
	amFF6Gxh6rApNbslac8NINlrNLodiWOXYqjjL6sdsDGbSNmeTCcjQ5A5/5WaYBOONO13VPldjwp
	VIfSrBVPWzFnvssbeiDQ4CHaRx7Q6ReOTK5MaWSBX529mOgNyN+SWAtriE70TOP3c6Vb+fR0K8L
	mT/Pr5rnyp9d6DDWDH/hnftEl+sMZXy9RqvEiw==
X-Received: by 2002:a17:902:d4d1:b0:2b0:4d40:ce18 with SMTP id
 d9443c01a7336-2b0b1d4459fmr2878515ad.14.1774451034374; Wed, 25 Mar 2026
 08:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325120627.1841175-1-tmricht@linux.ibm.com> <20260325120627.1841175-3-tmricht@linux.ibm.com>
In-Reply-To: <20260325120627.1841175-3-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Mar 2026 08:03:42 -0700
X-Gm-Features: AaiRm528F_wWEBXtl0FfNSdUfpS1Bi_tLi3HEsUxHneMwV_eVuVnmeFilDaCSjg
Message-ID: <CAP-5=fV_iaQYRkgOw4rQTLmXbEtrRT3TAFOFdPznF_9BOHGNpQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf config: Make symbol_conf::addr2line_disable_warn configurable
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 5:06=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Make symbol_conf::addr2line_disable_warn configurable by reading
> the perfconfig file. Use section core and addr2line-disable-warn =3D
> value.
>
> Example:
>  # perf config -l
>  core.addr2line-timeout=3D500
>  core.addr2line-disable-warn=3D1
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Ian Rogers <irogers@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/config.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 0452fbc6c085..31541e03aab7 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -461,6 +461,9 @@ static int perf_default_core_config(const char *var, =
const char *value)
>         if (!strcmp(var, "core.addr2line-timeout"))
>                 addr2line_timeout_ms =3D strtoul(value, NULL, 10);
>
> +       if (!strcmp(var, "core.addr2line-disable-warn"))
> +               symbol_conf.addr2line_disable_warn =3D strtoul(value, NUL=
L, 10);
> +
>         /* Add other config variables here. */
>         return 0;
>  }
> --
> 2.53.0
>
