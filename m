Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6BB413D8C
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544239; cv=pass; b=Us0+MOC69v5ngikolO5IjtUkYMWUXIGANevSBjKm35k8e5CURP6YnQ/xWbkF2LVwrRUuqazOaZgbQ4h7rn0MP+MXFswWWZI5gjQNSIYHWh1YSg/uwH+8aFeAt8A5qvpHkXhmIwg2i25Iu3GtE0Xph1RO+/TDDPH1x3mrUGebxtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544239; c=relaxed/simple;
	bh=ogIzM+cM7+MY+w+5gYHEMx2iJlJg6vlO7hKaiSYEhg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z14UDHySXfGWyEWJMAA2yPoDn/Ym4xgdB0LxNWq7w+3Eum3pd/vCn7me43nQjYpcvdojsd8L/vcuTVvgxsmLuVpkUVSpZ34VSs2x/7KdQ5KAFKS9/cb973yGlCLV+77GgokOCVWIDYjgXG28KdhwlipOdxRPAArI933FXBnm1gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ey0duGFR; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ey0duGFR"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c67ea316caso3025ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 10:23:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781544237; cv=none;
        d=google.com; s=arc-20240605;
        b=kpvbz3r9f7HpkgFgYb6bvkOjXQpwdteOaiAAEWyfAEHCfcAum5Q3yP5rKTjNjqJE5i
         XxgC8uVTmwjKgm5kaDJBgwq6p666vEuPCWmsKatojSbc4iVeNVbF3ND76LnnV2LI9bKS
         Q6GgYJhO2xH2vLzWEUxftCToPobxDSUrty2TtOwrEmezgl+tL1WnDlU5AXbNUR5g1GS8
         4oeb3QurjI2ZbHRchFbm6IxfyRGt/zDrneU+TmbLHb4RVnNkuDJLRXV17s+YA8ogjkbZ
         Nji7ElgWKqvPceEHz8ZPf4TlZbVrUYho+581LJjNHL/7jqwedRzHiyvGMLqpbqsWaySs
         vdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sD1RLyk2y6QWmU2MiBulLO5AxuzI09IXWPGAL5j/YN8=;
        fh=KIbo5JCo/JGb/KKwahbBN/ozCu/cZgDlKTFTs7EV3Uk=;
        b=hv2SlmdRcOXR+ivwHPq03ehuNEFs2UlSbH7ci5OvjcEoagmIrFY9QU+0GduFcJwdWn
         EJtWEH4TEusSxAp/lK12obEd/YzUdOiJW9dKISbfWVXee1597aQWWMeh1YMMmH/zqT8k
         Z3HYEIbUD/IVnavmW+4y5DnYRpM1m+uX/sIncuewge636PDjqUvWYAGkNaLqgiDIctXD
         qR1nCEesvs4d+85wNggpas4Asoik22884ZYtm+3Cib036FTqBHGkbBCZztcyEoR439VZ
         09LwXtdBBYmrMde6vnWy8lmR59nL7ToMB+FVpdaPxmsDG2meqEnS1rgr2UBYDdv3Hdsk
         z4ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781544237; x=1782149037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sD1RLyk2y6QWmU2MiBulLO5AxuzI09IXWPGAL5j/YN8=;
        b=Ey0duGFRQXQAt9IES/Z/r0EYyidA2wZESigv87AvDhWP8FCnPS1nzUqSnczf4LjpBk
         23vdPNMZAHUX9KrWf0lVMKZsqM4A7hGK7ocQsneNzWfDgz+GSonrok8gyN0IdjgpF414
         QJfXMQEiJDE94Kp69w9PUHGz3ZFNg4+BH7VV7/7TQsodDKXZIT+HkASoMfzEChqeJqFo
         GcvPd8WcAcG5PJXfkDgMJnmR5Sr/PDJAZgMJlV9loArsbox+LXOOEuW85njNdEO/oNRq
         ff7TD0JV9cEnB+W2QJ2YpZWCAfW6g+Slaw3XkI0/T+nhEVuXRVuAf//0Y6zSv+6wZYLX
         9TKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544237; x=1782149037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sD1RLyk2y6QWmU2MiBulLO5AxuzI09IXWPGAL5j/YN8=;
        b=bxVR4hSUYnWEex+8TmhIJsf7APbpD3/r1cTqklqsjgM7MV/Zc9r4Q3YWLKlvYIts9i
         WSvfeZlaWEeqjevKToEgf6t4z8x7WmdGiKMsHw02hdBY9guFxCh8GgJYhk5wt2X4Km4L
         yOa41I5Rd1gA3uQz2DgHD+ShefQEtfG9vP/DQuAut+X/QSNIBi4gkYLzRqQGQtRpaS80
         RcU7kbqf97vqTIoNt9hVuu6Bu5t6Vk8I3vpRqlll9zWkHVh998SMXIEiF4YCBz0DOx1e
         qsQICpEXBqvBg38LrW9/J5xXXqcf5b50BpfM6CB6MevF8FZO5fewDSDmkrUcMPt+Hxq7
         4sMw==
X-Forwarded-Encrypted: i=1; AFNElJ+7WuiOqOxBvl8mHzGk5h0TbUk5luRmp8DBCVTu59IySggK5ZCFncO7Nn+ScAZsgvpKKdeS2doYlIkeHSInKfuQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzLEX4OGRmAmWqcwSTTLUbNve/xwMIluW4CfQUDKjCgvSKctNBr
	0SQWaWvNpJuMUNJGWyieChAJ3TZGH5bj3SxR1TTHLAkVI+9EHlPZ5opWiXZQdhPjYP4DhhKQpav
	4UmJLUi/TjUdPPV8nu3LUUxI6btyP9/4uXo1CSdU5
X-Gm-Gg: Acq92OHx1+64BBvlZEYjZKffYN8Og8/M/gTlJ0V62qzos7pAxJJxWqLNquDW8TF6CJ7
	+EpCQ7JU6qt91Z7X3qOZKCaPoqFp6xJUpIYUFV8wyu3BldYB8vLbe3moEQQvkd5QCSFCRgVuuyI
	AHE+yW8YcIGNnk3lT5fOZ4/jDNWjuoiBfU74JKS0tZ8KuywPMOzCqqHAk1oLy2GHytAJJN4Uqhy
	QCTM+r7UHidu12tLxErw+qzdCmXVLkBMS6zghB2+0bI60Kpv/0gIgKI4weuD3CIBR+6wghkVvWh
	TRkMNHaw3UliQizEcuAcD8GGXeZIgsLGbF+BNAwyUmlXnVA=
X-Received: by 2002:a17:903:240a:b0:2c1:ee6e:4e4b with SMTP id
 d9443c01a7336-2c69a30bed8mr103585ad.28.1781544237008; Mon, 15 Jun 2026
 10:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612222413.40791-1-acme@kernel.org> <20260612222413.40791-13-acme@kernel.org>
In-Reply-To: <20260612222413.40791-13-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jun 2026 10:23:45 -0700
X-Gm-Features: AVVi8Cfj1Fc40_6ra12H0IpP-kCWnSSLGkS7KqV1fn6S1g9SDL4ei6fuocFJdcI
Message-ID: <CAP-5=fW2SEMgKJkENrz5vmwZNiyv_8T5mMsdcyjfza=OgyMGwg@mail.gmail.com>
Subject: Re: [PATCH 12/13] perf c2c: Free format list entries when releasing
 c2c hist entries
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, "Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 3:25=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> c2c_hists__init() calls hpp_list__parse() which allocates and registers
> format entries on hists->list.  When c2c_he_free() destroys a c2c hist
> entry, it deletes the histogram entries and frees the hists container but
> never unregisters the format list entries, leaking them.
>
> Call perf_hpp__reset_output_field() before freeing the hists to properly
> unregister and free all format entries.
>
> Fixes: f485e33c4543ac31 ("perf c2c report: Add cacheline hists processing=
")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/finding/41

I don't think these are public "Closes:" links and should probably be strip=
ped.

Thanks,
Ian

> Cc: Jiri Olsa <jolsa@kernel.org>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-c2c.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index e205f58b2f3d3786..07c7e8fb315e6cf3 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -185,6 +185,7 @@ static void c2c_he_free(void *he)
>         c2c_he =3D container_of(he, struct c2c_hist_entry, he);
>         if (c2c_he->hists) {
>                 hists__delete_entries(&c2c_he->hists->hists);
> +               perf_hpp__reset_output_field(&c2c_he->hists->list);
>                 zfree(&c2c_he->hists);
>         }
>
> --
> 2.54.0
>
