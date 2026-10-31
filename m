Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793459871;
	b=EG9GOFgA35l6Fu3vSfeXEMySoGgnuG/rqYymt2+OSjb8FJq3vVfKhzSvejPT/5bnLtEX
	 weBtOSDN14RDyfYSac+fb1x8u/unJZx9Ri08QinKWt7ycOU+3RsWGS2SkbggeUw+Azetw
	 wi+zPuvtKuD7SCdqbQEPnLjnVpQwqcr5cBF+ecIScopIPTzlvbVg60KFyd/6cDv6B9Awn
	 6jq4nnBovI7MYOVgyI1bzGv7vL+Pjbk9hFzkUCZSg6ZPtxOwVF+35asaCKwIH64Y3Gm53
	 cEVEenoChMDL5xrgD8O7mCjc/j8P541nox9NTgNi3pB13nHM5RRcmlNZc/rQFDc+tww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ivGTWu4BzmKjaoJGyQkGLOIrnm8Ff1i6dz13M+a0Bvo=;
	b=ViYgVt/DffrSv20FG04CZBBZFG/MS4NJ+mQv/902l5VODg2m+Ca/iwzwyQIoldE/eKz4
	 +vBLRt8d/nY6qYWc+uEVpHUktzDKg8uW15QTBRHhKt/ELXVelM5keADA0hHjEo0ePt/uG
	 yEezi3FvQecKFJzPeXmQwl6SCW7SwY3x5wT8ZRGA+WK7RCHpGNYky6jVQQTh1zaU5f4mN
	 SWK2oiPhJVszu+m0jxJBnDrz924HR9UJxreQxd82PHr7nesnFh7kkFbUxZg9QIoGV6Jsl
	 xwNvie2FYV/bYCHukbtMPE3K8mu4Dg7uQ4TZsTE0RoRkctPVofPqzfPmNS82jCV5xyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cnxYB9xZ;
	arc=fail smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CAB606A31D
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2026 15:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5CAB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cnxYB9xZ
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so2630748a12.1
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2026 08:17:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793459869; cv=none;
        d=google.com; s=arc-20260327;
        b=fL3WoHoOdxkDSlqXP3K180YjiTDHHIy9g3beonYiIKX+4w9rBW1koWTJQxPO9EHlJQ
         sRdZGN4HP5vy9fzHXQtXCBKsuuDDc44jYjrywvGXlLtoTMB+hBFTMml3sNoyfiP9of0m
         6wAuWyVYQmc708nobaa2goBmtgidWegYmH7MBwQCQwnY/Gf0JANDH9Kac+GTfT8BwiOa
         9U73HD9S1cUuIPYdn/rpqYA8tnqKGh9lf1Q4W3q7wRFOuiZxjJfsKNWXB2jQtz3hCmAN
         69PHpKw5QJ+3MSX1Q1OBZH86DdRbrvMNDTJptvPwISq8thWdCDdpd9XXDAXslUE8bVKp
         m96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ivGTWu4BzmKjaoJGyQkGLOIrnm8Ff1i6dz13M+a0Bvo=;
        fh=4Ic4D3Gw4jmLrWXDtns9LjxiPCeMHKSM8qRvoMloAnw=;
        b=iSic3HZpX2qtpw26gwbYQksr8FMYbZ5/pTjsa7bgiBU80qTxJrQKo+rgwzOD9QEa3d
         or1FQDI6e9naBsFhR49Xr0PjQuILwfD6nqxX96VItJl1shEiFkC2Fk3uuhk8xePln0Lc
         Tnu5dfu0FJHKyoOjJGSVnw/N9lfBp1IOrYuS97l+nrulILP56vdkpWmUJbcsj8X5xhnb
         aJL6uR3+4KI8s+0SIOU09G0uj43KFb8+yhnJ/1eUOK18YnYzH8BDqRr962ZfSkXiKNdq
         smpihv9E1UO+kQ4ZOG7EpFMxLK9liYx5PiuuZhpbnivHxhPx7JyuMy0FfPAlgwVX4E7k
         /wBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793459869; x=1794064669; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ivGTWu4BzmKjaoJGyQkGLOIrnm8Ff1i6dz13M+a0Bvo=;
        b=cnxYB9xZtAZ/OPPwfPVy5DokNx7+PqeN31PtirnlApVGJaEXexayGOu0+0FqSxaPKs
         w0itJlM5mY1lcgTnVCd7ocx6fDlGoQ475odcb2GEYqYPmIuVk9z6IXbp0j5RPKO0ZpZa
         2WWnGyWG0FEtUYD/QThxLRdbZm01tJ5lWoZeC24odZpj0/Ly5Ikci+9HW5wZoqYg4Oiv
         bfEZj0RST1PQdKNzaqxziG3Hg5K6MPoPvfDm5/U5NUffHkoKwim355/cNr0GSdoGXIjL
         ORgPg1JZnOafvlligNzc7O75mFJPxq647A3arHncnSWr6gfmjpOrlc4iDpEipGEUYXgW
         eOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793459869; x=1794064669;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ivGTWu4BzmKjaoJGyQkGLOIrnm8Ff1i6dz13M+a0Bvo=;
        b=zinYu0h9Lb61tOTJ9gJH1lEveDQMUQqJsFsHSlEtpKm8dAB8qs7w1VY9R+ALo17rvl
         pfFkdxZukjrtu6ERBI6wYBeFucNhYpr8vKM+IVouAU5IbZZIyOrXQn0mNrnD/Ar122kX
         N1o6ox0UeHePfrf/WUAe01OZ3h7fuQBP42X3dSfewkf05cVzsOygMpt//U8Sv4zcylds
         yfhxa23v7tU6v/YBlXsQjZhCXu3/Ur3LZLU3sY7ol1hWKySichNvgcHTAggPMIjFqdju
         LX2PUzQ0+pgUrHOqR8DUJOyoFmrWKcvFK5oYHYGdusxEKWMeKqGrtRMTqFjJsHGZJVRA
         Qsgg==
X-Forwarded-Encrypted: i=1; AKwUvBw0E9i/A3x/xsygcj0MJQqsa+lDUBoHO/hrrmkKoAWCpjpbxXN3Y+gpvVg9yXYXMzOE1XcFmXA+9jaRXmjmjOBX@vger.kernel.org
X-Gm-Message-State: AFq9FYItsA6Jfgm5QKiChTYsxkmD0BNC9RbSMd97sfUkPBX5bBB2gKrZ
	3+4B8c8Vn27E9/EXKHCB3m+hHF1WF0YIw+N5gJc5LCOjilFgufKgxdSwXos3kvfOVB5qwymeo2G
	VrTsgk62o00b51e/507Smh3ylYRCEB9Q=
X-Gm-Gg: AYBFou1RHXf7Wk+WybrkUPsdpIJUU51K2yuTzs6YTtqPfboLALQfeN+L1vpjY+Tr9JW
	EwS9NEMp0RacqENrp1kcq6Opywgf8bSkLNnUyahOx59tcZRbu5LExHtTyIfjdxVYKAC2sYGF1gZ
	t8AnXv+38XRdW/qJz+frxP0Sr7ir0Km5LgMm2LAvHp/GtckCQAzM3R2tgSaBLcxcGoZFDAk+fwl
	I/0f0hbuuK/q+sILII+fiKI7AnYlT+PVTsZ8fjTB6B4hlcGoWtxNZFdReid2gUnIC/oKR43ks0R
	Htc8ZQgZh2B6IVvEWSJrvDU4+j0PDxRKQdP0VimW693bl4P7Gc49x57Rnvnik1iu5nOfJWKvmWI
	9oYwHZzQ4iJRabhAb0lUqnueVTxxQS/4bB4uG0jWoqhlo8Cjej5FjMDzl/sS7X4mNIeY30c7Q3q
	TwddJfnMUML64QVgZw/Ql/jI9eAMl6ItWWGD3gcLFP3/BZ
X-Received: by 2002:a05:6402:2031:b0:6af:9a96:5324 with SMTP id
 4fb4d7f45d1cf-6b4d5edb541mr2916962a12.33.1793459868935; Sat, 31 Oct 2026
 08:17:48 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-alpha-profileme-v2-0-c702f1c65272@gmail.com> <20261030-alpha-profileme-v2-1-c702f1c65272@gmail.com>
In-Reply-To: <20261030-alpha-profileme-v2-1-c702f1c65272@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 31 Oct 2026 16:17:37 +0100
X-Gm-Features: AclHuK_R4D8NWUtYc6iQtFezNeMcTpVIFAfFVK5FGtcztQRPo5Tx6TLf5qBIjwA
Message-ID: <CA+=Fv5Sqkh=N+ezg1K4WTvfkVgfDgdFUR0Af7FJWFZUx6sLwtw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] alpha/perf: pass PERFMON_CMD_LOGGING_ALL to the
 logging options call
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Fri, Oct 30, 2026 at 5:04=E2=80=AFAM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> alpha_pmu_enable() passes EV67_PCTR_MODE_AGGREGATE to
> PERFMON_CMD_LOGGING_OPTIONS. That constant is the counting mode bit for
> PCTR_CTL, which belongs in the PERFMON_CMD_DESIRED_EVENTS argument. The
> logging options call takes a flag in bit 0 where 0 means "count all
> processes". It works only because EV67_PCTR_MODE_AGGREGATE happens to be
> 0.
>
> Table E-18 of the Alpha Architecture Reference Manual gives bit 0 the
> opposite sense, but the PALcode in the ES40 and ES47 firmware agrees
> with the above: it sets I_CTL[SPCE], which enables counting for all
> processes, unless bit 0 is set. Linux never sets the PME bit in the
> PCB, so if 0 meant "selected processes only", nothing would be counted.
>
> Add a name for that argument and pass it instead. No functional change.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/include/asm/wrperfmon.h | 2 ++
>  arch/alpha/kernel/perf_event.c     | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/alpha/include/asm/wrperfmon.h b/arch/alpha/include/asm/=
wrperfmon.h
> index c97b82a1f7db..1fa9bc813263 100644
> --- a/arch/alpha/include/asm/wrperfmon.h
> +++ b/arch/alpha/include/asm/wrperfmon.h
> @@ -23,6 +23,8 @@
>  #define PERFMON_CMD_I_STAT 8
>  #define PERFMON_CMD_PMPC 9
>
> +/* PERFMON_CMD_LOGGING_OPTIONS arguments */
> +#define PERFMON_CMD_LOGGING_ALL 0
>
>  /* EV5/EV56/PCA56 Counters */
>  #define EV5_PCTR_0 (1UL<<0)
> diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_even=
t.c
> index a3eaab094ece..2d9383425357 100644
> --- a/arch/alpha/kernel/perf_event.c
> +++ b/arch/alpha/kernel/perf_event.c
> @@ -728,7 +728,7 @@ static void alpha_pmu_enable(struct pmu *pmu)
>                 maybe_change_configuration(cpuc);
>
>                 /* Start counting the desired events. */
> -               wrperfmon(PERFMON_CMD_LOGGING_OPTIONS, EV67_PCTR_MODE_AGG=
REGATE);
> +               wrperfmon(PERFMON_CMD_LOGGING_OPTIONS, PERFMON_CMD_LOGGIN=
G_ALL);
>                 wrperfmon(PERFMON_CMD_DESIRED_EVENTS, cpuc->config);
>                 wrperfmon(PERFMON_CMD_ENABLE, cpuc->idx_mask);
>         }
>
> --
> 2.55.0
>

Thanks for the update, tested as part of the v2 series on my
AlphaServer ES40. Looks good!

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
