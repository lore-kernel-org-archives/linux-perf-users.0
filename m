Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A54431F99E
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Apr 2026 20:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161986; cv=pass; b=QK/8pJXhFgBR4MiRShMcqfsWe7nraNqwUJYkE7v3SVd8CTshO3EAZJik4SejiLI9SddHF8mS5MTAihNOD0thB0OO/ZJmwvn+WZ7FG0x8+3cH/1H96niVZOjwi6aajuLwRJ+CSIs6pI9JDnd33gPcIFJKn7rG1wCnGWEzfWWZbFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161986; c=relaxed/simple;
	bh=76nVsFIzca0JfDL3k0s/0UXG1tolgd2fXXDQOTCVqJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GaiL5dBV/sJjXWpnfJbsDge5Mg0dRUVN0C6JKpyAIlDKNf6DuqbLDvzJm81xfJGwJ/PQrDeRw6PR4pYznnNSvfzlRPXfqIJZfHgwFbxdh4z0Mu82f2TONaj6OoOvzwX4nouXoClQhHUw64AX42V51HryoJj0sIWsK9c9Fayx2TQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=smK787Ij; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smK787Ij"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b2591757fbso28095ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Apr 2026 13:33:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775161984; cv=none;
        d=google.com; s=arc-20240605;
        b=BApGqRzeH/G7ykZznW6TFwO94cBiLiE8LIsYjZ3N/XP2cM41b9+aPE/QLd5DpRauPH
         kqf07JwI/FEU/UL5DD4wRPHuCmeMuaIJAt+H+Eo0wCkidhWGnQ3yCDyy1ERujPbUTh4G
         qwh2VMeG7RlVeNU6D95XS1Hg7PBhUbErEgkJWAM+k1sFMleATj09qrQqLfhSHsGREMaD
         icnsqEUXvbZ6SvNqRmf0i9qtrhsb2U3c0jzRm4+qGof+FNclezjmsMEdG+20NLKbVztz
         vW56RQGKFyCxO01ceV8pQV4qRpATBWBT5rRuNiONEoRGOEsLlHBLFDQT+rPAcfIpWnTM
         yetw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R0Fk+SK4rOpR2k9kCubpeHNVZ7mkrxIlD+k9iFqGulY=;
        fh=Khqb/Km+dM8p6GiqgWpu92FAYZaDaXPVPFaiSI/zaQA=;
        b=BHcEYUUSw5FVq33TYofd6t/KqHHZpE7QVHJYc0Ac9Zx/mpx3/SgotMh65Hj8IXEqWH
         WZEeEK+uy1vez6yBqNiDdJEhy/LogZEX+NBZhdVP9bLfyMp8vHarOkS1Gz6XEwKEDWmp
         tftB/O5H4BIcccLs6N3rQpAcbdUOCeGamkha+poapvLUkmuXh7JSqSExStp293uNR1ZK
         gnkMZcTKEPjMQoUtQ4OaKpQHWfkxJIvx/jiJaaIelbaxk8o3geO8Hbc7mB+yfM3bMbug
         7y1h/eBjMc0yIdcfbdDuZtRKY5OU0rQuL1kBN80x1NNdbjpTPuzI+6n0pTtL9eAdJdYn
         iwsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775161984; x=1775766784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0Fk+SK4rOpR2k9kCubpeHNVZ7mkrxIlD+k9iFqGulY=;
        b=smK787Ij3E1gdYxjmCOlrUC33SG/oZ296YWXhpl5A6ee0pXiMiKiX1d9xE/YT3IFfQ
         xAQgUz6meK6ugSP+tePCJrhtZizETkCa9xm0oEXHruEe+4SdrS3ouEGSVj+wwK5Tgq62
         3d2suGVzqb9D4OD8aRaCpIAK9brRD2cOcL2D7is1U4XakFaxaR87PVdgjICdknUX0taI
         6OcEHWARbVhdrhOpqt0EBOaoE/lud4EMIiKo3nec2lAjyiXUTlnptCx9MdtrheMPmdGC
         EckwgkxjF50ktePwxeJ5xsYB/g44VqKfg1epCaipO63KEjacCEvsAygoAvBQ8Quv1cPB
         sDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775161984; x=1775766784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R0Fk+SK4rOpR2k9kCubpeHNVZ7mkrxIlD+k9iFqGulY=;
        b=JwZnGoWtgA6DQOAMnCjaKDiTSQXW60FB/1tifd3s3Gsgu34I3gcs/0ceuRX6W9PHHr
         otQ2f3c81yMyaLplWmIjZRO0OX7nOoScnWUx+WK6fZfHl4ckWiKl5ptNc5WYZqXAuMlh
         tHXdTg8fBnQmqoyGXz97r9Ge1CAUtMHKlJYQOPtOGl+BUwUZykCmfDKjX5DzZEYsFLK4
         MLVIt5ktVVBMwsWgqRncWJDJuTPyZZqQ4VDLPY3uUI7+RvT32ov4KtXITMYNUCHP/hQa
         NGr+BgoUCwBqDdjKtfTol+DeeYv1wl6W0BybsoBBC/+Ni0l9SpSlrEdV+y/ya3OIQ66d
         ugPg==
X-Forwarded-Encrypted: i=1; AJvYcCUL7qZ+s1qL/Q6AxeBXo737FrcEHgYXtaQ4eoR5bj6tToXl/uh6zLzFmTj/7M7703leiqQUuL6moxl7mjGyatNy@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq37HL3nZjk1Lbr7fmikpEN392a+7AN+wpJvBrzeWFxaIuIigM
	hAloYaK2x27k/lntLvY/M5+826bDA9hVvyV9OHzKqZmGMWMXlzCxSvk7aEuUO45XVQ3VQQdgbw/
	TndU8Uv2eIcEgz48d6DEvSdKOGzBXBGOSVUJXJIHr
X-Gm-Gg: AeBDiev2J9OVJWJZCe07jdOrtWwgZb0bD4cQ3/7LAfdG0nU/nHoja+8kH0EyC5mA5uI
	mHvvAGc42I876Lxx4gKlMOYVQJE1SzpwyOUAiCSha7fIC6bHHZAVmgTTYA7yND+o1HsbDN7MMew
	h16M2qqDAgp+rjMBvRYCGADXuK5Msjsla3j1Ce5e9xs8GWqKS8kCrdAwP8BdQDhZQrgEALE0aLt
	Dnk950Cjdo+v9HBEydBbeDswpYH/i+NrUBgeAkIgfxEUxFWEV5xftscU9beN4/tUSxKiceGrsqg
	af+9qa5CS51hA6BbirS3/arj7cdsazCPAeTtkZoQrVmj2XUx
X-Received: by 2002:a17:902:c943:b0:2ae:6432:8f77 with SMTP id
 d9443c01a7336-2b28303347emr290655ad.17.1775161983758; Thu, 02 Apr 2026
 13:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402-perf_fix_metrics_group-v2-0-1f9427a5d763@arm.com>
In-Reply-To: <20260402-perf_fix_metrics_group-v2-0-1f9427a5d763@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 2 Apr 2026 13:32:51 -0700
X-Gm-Features: AQROBzCSDmqfqgcAldePIsUAxoFC4rqiaPysPHn4GKffEJzUwtZVpvYTRkrKvW0
Message-ID: <CAP-5=fU0hFSBFzuuHwyHRDdBTkUdsEsaTSjPJ3ZRnnyMRrTxdw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] perf metricgroup: Fix segmentation fault and
 refine logs
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 9:04=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> The first patch is to fix segmentation fault if there have syntax errors
> in metric groups.
>
> The last two patches are to refine logs to give users clear hints for
> failures.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

For the series:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> Changes in v2:
> - Added fix tags (James).
> - Added before and after logs (James).
> - Link to v1: https://lore.kernel.org/r/20260327-perf_fix_metrics_group-v=
1-1-49e4b8ee9a08@arm.com
>
> ---
> Leo Yan (3):
>       perf expr: Return -EINVAL for syntax error in expr__find_ids()
>       perf expr: Add '\n' in literal parse errors
>       perf metricgroup: Refine error logs
>
>  tools/perf/util/expr.c        |  7 ++++---
>  tools/perf/util/metricgroup.c | 11 ++++++-----
>  2 files changed, 10 insertions(+), 8 deletions(-)
> ---
> base-commit: d9db9c8db56c3e378aa5c91637664f77ca5a6f72
> change-id: 20260327-perf_fix_metrics_group-4be55b236f96
>
> Best regards,
> --
> Leo Yan <leo.yan@arm.com>
>
