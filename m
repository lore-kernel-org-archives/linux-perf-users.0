Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DB745C10
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Feb 2024 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547893; cv=none; b=tbS5t22zPpH6FGSbPwTdmjR9wGNkj2Sjgq845Dok4VOjPl/M+wmdx/E/i2GxBxynXy1T0dqJNDFxvuh6rv5m6nSb18rEkjZUBlgkFn+I7zt0gmfz0Or37rU+M/TA1cLnjOFNpjkhukcbMj83tGb67rUDHY5CPY2XWgY5f49FGhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547893; c=relaxed/simple;
	bh=NGyaURh4r9Zx9kSUoZd+AwfsWUAs4mYTOTN47/5bQLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9sAaTw3YWeAIW+eG0MfbgzBa7Wo1Fjfb1+o30A9il6DWxNeoxBafwOnvvTN3DTONpcvgZ3WEg08C9IJnMyduz37U5zkuB4yyAJMtE08N0R4xvee0nomIYtu+EIW7m3Qc0576+28MmJJ4pSoTHyBaAwVhspdQM+iz1yNz8NC/q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jKEjKieV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jKEjKieV"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dbe7e51f91so37095ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Feb 2024 12:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708547891; x=1709152691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+JpCP8R5SCl4MExppAiV+dYGLFKd6cCpdy0KaCUGD4=;
        b=jKEjKieVLV4zFGEg7WAy0n0dAlOEcCdmrA1UkTBKxLBL3/qbHM48x9LUDD/OQrKEtX
         vU3IGJRPNITscmh3hCuATLpycDRddHAKmlFadlsdKKMBWj4rRyGTTnq+IHuM1A6+DP8X
         mrN2dZeiA10uUpk18xVKNyd4LZSgYKu1MbG6BTvu2YATLORdtPXCf3OTAqSazCZQqdkk
         mGx5PSywSEWRhHJNTmIT2pdmr36qR1ymI2HN5KQRmXK3YF/92NDCfP1Roplwyr9dwTyU
         drEBOMKQB1RsFKfEVqW2kP0fpSqrM4v0QEmWJMpPzbLbU0kvSEAe6inCTw6suaQZPznP
         RUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708547891; x=1709152691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+JpCP8R5SCl4MExppAiV+dYGLFKd6cCpdy0KaCUGD4=;
        b=UaCiEKbjYySW9fmVs3vfONSebRn7JyXTR58dv9md2BeZgU25fjuQkKTTd6T2SrccOx
         ZY1eYgs0SHPRkzLH5em0SiSKvdg89hTGxLOs9aBzy7RcyEGpqQ2qk3eAdLvepLbOnVkJ
         TMS4f+MQhn6N9tIRmG9DYyw/ufCwssT1hrvlkzbBxaJJgG9vmyTCU7Vflj1pxf2szsOD
         jvSAdcvSzkbsPrl1oTWltZVbDEUP9yZEJIF3ow/CGLyHONJWnu6Ih4hlGU42EujbEQII
         F5fhCEpopXUJHt/LjDdm8gEZZ4fEpfhptiRQWf4R29pShV10c9osKFDfXxlMhMJFmOnw
         hTpw==
X-Forwarded-Encrypted: i=1; AJvYcCUVk3NjNPvFh7PFr+gDY5UTujAkJN1XDvHCQvHe5AQ6LJSsQWQ8cAVev7wnJFaPwsHILV17kvIEt480f39aEthAOjl3AR9DLXnLRtzjRkUGyA==
X-Gm-Message-State: AOJu0YyU+A+kVdwSOYPx+BmF12nh1K78cwhYO7NEAfr6PheQLiqX4dBL
	CKNMVZnBwf6dbUBipJHKATxJcfwjreGHWIy9MAvQxliTp3QxVbDa5+mMnvYJWmind5AVdSBmWv6
	d7yrXxOI427M3MyaXvJKo6XB9jhxj9pwFq7AJ
X-Google-Smtp-Source: AGHT+IF8wpfBeD0iwu5k1t/0ihImHCcnx0Qsyu7YGzKtxdq4u2YfYtqbW18oCCAwNNQi46SFqxBO/QJep42mFRsQJYk=
X-Received: by 2002:a17:902:bc45:b0:1db:e5e3:f7ac with SMTP id
 t5-20020a170902bc4500b001dbe5e3f7acmr283043plz.7.1708547890791; Wed, 21 Feb
 2024 12:38:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221091908.1759083-1-tmricht@linux.ibm.com>
In-Reply-To: <20240221091908.1759083-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 Feb 2024 12:37:59 -0800
Message-ID: <CAP-5=fVY0f4SkQ-F0KC2JXuayZyPHwXvsdS8dbMEvF8zg0vdwA@mail.gmail.com>
Subject: Re: [PATCH] perf list: fix short description for some cache events
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	acme@kernel.org, krebbel@linux.ibm.com, svens@linux.ibm.com, 
	gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 1:20=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Correct the short description of the following events:
> DCW_REQ, DCW_REQ_CHIP_HIT, DCW_REQ_DRAWER_HIT, DCW_REQ_IV,
> DCW_ON_CHIP, DCW_ON_CHIP_IV, DCW_ON_CHIP_CHIP_HIT,
> DCW_ON_CHIP_DRAWER_HIT, CW_ON_MODULE, DCW_ON_DRAWER,
> DCW_OFF_DRAWER, IDCW_ON_MODULE_IV, IDCW_ON_MODULE_CHIP_HIT,
> IDCW_ON_MODULE_DRAWER_HIT, IDCW_ON_DRAWER_IV, IDCW_ON_DRAWER_CHIP_HIT,
> IDCW_ON_DRAWER_DRAWER_HIT, IDCW_OFF_DRAWER_IV, IDCW_OFF_DRAWER_CHIP_HIT,
> IDCW_OFF_DRAWER_DRAWER_HIT, ICW_REQ, ICW_REQ_IV, CW_REQ_CHIP_HIT,
> ICW_REQ_DRAWER_HIT, ICW_ON_CHIP, ICW_ON_CHIP_IV, ICW_ON_CHIP_CHIP_HIT,
> ICW_ON_CHIP_DRAWER_HIT, ICW_ON_MODULE and ICW_OFF_DRAWER.
>
> The second Cache should be L2-Cache.
>
> Output before (display diff of the first four events)
>   # perf list -d
>   DCW_REQ
>        [Directory Write Level 1 Data Cache from Cache. Unit: cpum_cf]
>   DCW_REQ_CHIP_HIT
>        [Directory Write Level 1 Data Cache from Cache with Chip HP \
>                Hit. Unit: cpum_cf]
>   DCW_REQ_DRAWER_HIT
>        [Directory Write Level 1 Data Cache from Cache with Drawer \
>                HP Hit. Unit: cpum_cf]
>   DCW_REQ_IV
>        [Directory Write Level 1 Data Cache from Cache with Intervention. =
\
>                Unit: cpum_cf]
>
> Output after:
>   # perf list -d
>   DCW_REQ
>        [Directory Write Level 1 Data Cache from L2-Cache. Unit: cpum_cf]
>   DCW_REQ_CHIP_HIT
>        [Directory Write Level 1 Data Cache from L2-Cache with Chip HP \
>                Hit. Unit: cpum_cf]
>   DCW_REQ_DRAWER_HIT
>        [Directory Write Level 1 Data Cache from L2-Cache with Drawer \
>                HP Hit. Unit: cpum_cf]
>   DCW_REQ_IV
>        [Directory Write Level 1 Data Cache from L2-Cache with \
>                Intervention. Unit: cpum_cf]
>
> Fixes: 7f76b3113068 ("perf list: Add IBM z16 event description for s390")
> Reported-by: Andreas Krebbel <krebbel@linux.ibm.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Andreas Krebbel <krebbel@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
