Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A79363
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706660232; cv=none; b=B4OlBH2DKZcS9CnNzIUuHAgrtqRP5sqVA6twXkUnY6giFz2xplg76AY9U2HOxoiIgD83DheRBV5Ag1tllJvRrm8jjfuHXSTh1qGZGkEBpHE0iWZcK9lwVp5B+pWt7nqrKYlMJqF3yrwYPMyKiZiBS7I/DP+Jx/zjQMpmd+hIvDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706660232; c=relaxed/simple;
	bh=KwKhk0ly1qcZSHTw4wHNizU0tG72WrpaT4ovmkbAmYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFY+6rV9lUSNPXTHzCieTTzOq7q5KgaO9RL00LFYzXjtuRWItdBtgDbqvun9+1ffFJbnd9akkcxiGhzXCWLmTf+HikH9epoKFSH7BWKptelqr7Wf1MBeZiAOHNj/8JZIjcq2NRbbVlqGVFfhGTELa0Wu5umyDlz92/C+Ww9XFZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5986d902ae6so2779455eaf.3
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Jan 2024 16:17:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706660230; x=1707265030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UDsTsRelxoU8Mo567YSPLBAQgbgDIHAcVOQ/uXHGPg=;
        b=t8PijWH0Ndsmh7LYMYw0HXrM2/ILExvI3xlGkSULLUxL2nnFZd4N82PwcYJ48ISlti
         /VGw5lGYnG2i8ievHcLdcHO6dZeueMJ9DIjzxnfdKiMs3+/2yll1nkpCAYuo6sWmKTwW
         P9mcPSerz0lObhV6iqEWNLfBXHrQr5vtc0xxpmdNDgtXCq9XjXNKE2oaia3bDwmEximn
         Ho5a95ebMp5pBpPyDL7WG6QGwx4IDid3mPiZZbj0idUf0FXVmzcedEIO8y86DXwXaQeq
         2rK6ltpF6aK4qwQops6AQvDUMwzOvPbyEBWLAXZILLXmANVSkTzwmBFYkpVY1gDCe/cU
         3haw==
X-Gm-Message-State: AOJu0YynJ2oRQLJ0yg9oX1I2tARWurqCEGaGHMJpKocDIQKLDz62C2+J
	KD0RxON1DLU1GqJlxAqlIQYz5vOuymeR/rH15DtVTSPr5o64jQyhLD9hEudb+nI+xoa2ssejYnU
	XEj7taTQCiwpwmOAvHsRa7HJV7vs=
X-Google-Smtp-Source: AGHT+IF0UO3Ofrc0zgCfTw+TZuCyoXAM/eraGUQxWUin50af3BONTezzDrbycHcpmrlYdfar4CMGhpDNkJT21MhfeY4=
X-Received: by 2002:a05:6358:99a8:b0:178:99cc:e52e with SMTP id
 j40-20020a05635899a800b0017899cce52emr2085167rwb.20.1706660229968; Tue, 30
 Jan 2024 16:17:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130185552.150578-1-ak@linux.intel.com>
In-Reply-To: <20240130185552.150578-1-ak@linux.intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 30 Jan 2024 16:16:58 -0800
Message-ID: <CAM9d7choHiivk9i3_iKLPCwRwEyrc-tSereLt4Aw7orzW2x3Ew@mail.gmail.com>
Subject: Re: [PATCH] perf report: Prevent segfault with --no-parent
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andi,

On Tue, Jan 30, 2024 at 10:56=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wr=
ote:
>
> Prevent a perf report segfault with the (non sensical) --no-parent
> option
>
> Signed-off-By: Andi Kleen <ak@linux.intel.com>

Acked-by: Namhyung <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/sort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 30254eb63709..92a1bd695e8a 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -3372,7 +3372,7 @@ int sort_dimension__add(struct perf_hpp_list *list,=
 const char *tok,
>                                 sort_dimension_add_dynamic_header(sd);
>                 }
>
> -               if (sd->entry =3D=3D &sort_parent) {
> +               if (sd->entry =3D=3D &sort_parent && parent_pattern) {
>                         int ret =3D regcomp(&parent_regex, parent_pattern=
, REG_EXTENDED);
>                         if (ret) {
>                                 char err[BUFSIZ];
> --
> 2.43.0
>
>
